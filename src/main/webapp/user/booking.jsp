<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, javax.sql.*, java.text.*"%>
<%
// Check if the user is logged in
String userEmail = (String) session.getAttribute("email");
if (userEmail == null) {
	response.sendRedirect("user_login.jsp");
	return;
}
%>



<%!// Method to get the database connection
	public Connection getConnection() {
		Connection conn = null;
		try {
			String dbURL = "jdbc:mysql://localhost:3306/dental";
			String dbUser = "root";
			String dbPass = "sarap@321";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return conn;
	}

	// Method to insert appointment (handles patient_id and appointment details)
	public String insertAppointment(String patientId, String patientName, String patientEmail, String patientPhone,
			String appointmentDate, String appointmentTime, String reason) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();

			// Check if the patient already exists based on email or phone number
			if (patientId == null || patientId.isEmpty()) {
				stmt = conn.prepareStatement("SELECT id FROM patients WHERE email = ? OR phone = ?");
				stmt.setString(1, patientEmail);
				stmt.setString(2, patientPhone);
				rs = stmt.executeQuery();

				if (rs.next()) {
					patientId = rs.getString("id"); // Existing patient ID
				} else {
					// If patient does not exist, create new patient
					patientId = generatePatientId();
					stmt = conn.prepareStatement(
							"INSERT INTO patients (id, name, email, phone, gender, address) VALUES (?, ?, ?, ?, ?, ?)");
					stmt.setString(1, patientId);
					stmt.setString(2, patientName);
					stmt.setString(3, patientEmail);
					stmt.setString(4, patientPhone);
					stmt.setString(5, "Other"); // Default gender if not provided
					stmt.setString(6, ""); // Default address if not provided
					stmt.executeUpdate();
				}
			}

			// Generate a new appointment ID
			String appointmentId = generateAppointmentId();

			// Insert the appointment
			stmt = conn.prepareStatement(
					"INSERT INTO appointments (id, patient_id, patient_name, patient_email, patient_phone, appointment_date, appointment_time, reason, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Pending')");
			stmt.setString(1, appointmentId);
			stmt.setString(2, patientId);
			stmt.setString(3, patientName);
			stmt.setString(4, patientEmail);
			stmt.setString(5, patientPhone);
			stmt.setString(6, appointmentDate);
			stmt.setString(7, appointmentTime);
			stmt.setString(8, reason);
			int result = stmt.executeUpdate();

			if (result > 0) {
				return "Requested successfully.";
			} else {
				return "Failed to book the appointment.";
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return "Error: " + e.getMessage();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// Generate appointment ID (4-digit)
	public String generateAppointmentId() {
		return String.format("%04d", new Random().nextInt(10000));
	}

	// Generate patient ID (4-digit)
	public String generatePatientId() {
		return String.format("%04d", new Random().nextInt(10000));
	}

	// Fetch appointment status
	public String getAppointmentStatus() {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String status = "Pending"; // Default status
		try {
			conn = getConnection();
			stmt = conn.prepareStatement("SELECT status FROM appointments ORDER BY created_at DESC LIMIT 1");
			rs = stmt.executeQuery();
			if (rs.next()) {
				status = rs.getString("status");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return status;
	}%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Request for Appointment</title>

<link rel="stylesheet" type="text/css" href="../user_css/forall.css">
<link rel="stylesheet" type="text/css" href="../user_css/navbar.css">
<link rel="stylesheet" type="text/css" href="../user_css/booking.css">


</head>
<body>
	<%@ include file="links.jsp"%>


	<!-- Bootstrap Navbar Start -->
	<nav
		class="navbar navbar-expand-lg navbar-dark bg-info fixed-top shadow">
		<div class="container-fluid">
			<!-- Logo Section -->
			<h3 class="m-0 text-light d-flex align-items-center">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"
					style="width: 30px; height: 30px; fill: white;">
                <path
						d="M288 115L69.5 307.7c-1.6 1.5-3.7 2.1-5.5 3.4V496a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V311.1c-1.7-1.2-3.7-1.8-5.3-3.2zm96 261a8 8 0 0 1 -8 8h-56v56a8 8 0 0 1 -8 8h-48a8 8 0 0 1 -8-8v-56h-56a8 8 0 0 1 -8-8v-48a8 8 0 0 1 8-8h56v-56a8 8 0 0 1 8-8h48a8 8 0 0 1 8 8v56h56a8 8 0 0 1 8 8zm186.7-139.7l-255.9-226a39.9 39.9 0 0 0 -53.5 0l-256 226a16 16 0 0 0 -1.2 22.6L25.5 282.7a16 16 0 0 0 22.6 1.2L277.4 81.6a16 16 0 0 1 21.2 0L527.9 283.9a16 16 0 0 0 22.6-1.2l21.4-23.8a16 16 0 0 0 -1.2-22.6z" />
            </svg>
				<span class="ms-2" id="medical_home">EASY-DENT</span>
			</h3>

			<!-- Navbar Toggler -->
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- Navbar Content -->
			<div class="collapse navbar-collapse" id="navbarNav">
				<!-- Centered Navigation Links -->
				<ul class="navbar-nav mx-auto text-center" id="navbar-menu">
					<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="aboutus.jsp">About-Us</a></li>
					<li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
					<li class="nav-item"><a class="nav-link" href="booking.jsp">Book-Appointment</a></li>
					<li class="nav-item"><a class="nav-link" href="contactus.jsp">Contact-Us</a></li>
				</ul>

				<!-- User Actions (Icons Only with Hover Titles) -->
				<div class="d-flex align-items-center">
					<a href="user_profile.jsp"
						class="btn btn-outline-light btn-sm me-2" title="Profile"> <i
						class="fas fa-user-circle"></i>
					</a> <a href="user_login.jsp" class="btn btn-outline-light btn-sm me-2"
						title="Login"> <i class="fas fa-sign-in-alt"></i>
					</a> <a href="user_register.jsp" class="btn btn-outline-light btn-sm"
						title="Register"> <i class="fas fa-user-plus"></i>
					</a>
				</div>
			</div>
		</div>
	</nav>
	<!-- Bootstrap Navbar End -->

	<!-- Appointment Form Section -->
	<div class="container-fluid py-5" style="margin-top: 5rem;">
		<div class="container position-relative">
			<div class="row gx-5">
				<div class="col-lg-6 mb-5">
					<div class="appointment-section1">
						<h5 class="text-uppercase text-dark border-bottom border-3 pb-2">Working
							Hours</h5>
						<h2>Keep Checking Appointments</h2>
						<img src="img/medical-team.png" alt="Dental Clinic"
							class="img-fluid rounded mb-3"
							style="height: auto; width: 100%; max-width: 300px;">
						<ul class="list-unstyled text-dark">
							<li>Monday to Saturday: 10:00 AM - 6:00 PM</li>
							<li>Sunday: 10:00 AM - 1:00 PM</li>
						</ul>
						<p class="text-dark fw-bold">Please keep checking the
							appointment status for updates.</p>
						<div class="alert alert-info status-alert">
							Status: <strong><%=getAppointmentStatus()%></strong>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="appointment-section2">
						<h2 class="text-center mb-4 text-dark">Request for
							Appointment</h2>
						<h4 class="text-center text-muted" style="font-size: 1.2rem;">Please
							Enter Patient's Details</h4>

						<form id="appointmentForm" method="POST" action="booking.jsp">
							<div class="row g-3">
								<div class="col-12">
									<input type="text" name="full_name"
										class="form-control shadow-sm" placeholder="Full Name"
										required pattern="^[A-Za-z\s]+$"
										title="Name should only contain letters and spaces.">
								</div>
								<div class="col-12 col-sm-6">
									<input type="email" name="email" class="form-control shadow-sm"
										placeholder="Email Address" required
										pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
										title="Please enter a valid email address."
										value="<%=userEmail%>" readonly>
								</div>



								<div class="col-12 col-sm-6">
									<input type="tel" name="phone" class="form-control shadow-sm"
										placeholder="Phone Number" required pattern="^\d{10}$"
										title="Phone number must be exactly 10 digits.">
								</div>
								<div class="col-12 col-sm-6">
									<input type="date" name="appointment_date"
										class="form-control shadow-sm" required>
								</div>
								<div class="col-12 col-sm-6">
									<input type="time" name="appointment_time"
										class="form-control shadow-sm" required>
								</div>
								<div class="col-12">
									<textarea name="reason" class="form-control shadow-sm"
										placeholder="Reason for Visit" rows="4" required></textarea>
								</div>
								<div class="col-12">
									<button class="btn btn-dark w-100 py-2" type="submit"
										name="book_appointment">Request Appointment</button>
								</div>
							</div>
						</form>


						<%
						String statusMessage = "";
						%>
						<%
						if ("POST".equalsIgnoreCase(request.getMethod())) {
						%>
						<%
						if (request.getParameter("book_appointment") != null) {
						%>
						<%
						String fullName = request.getParameter("full_name");
						%>
						<%
						String email = request.getParameter("email");
						%>
						<%
						String phone = request.getParameter("phone");
						%>
						<%
						String appointmentDate = request.getParameter("appointment_date");
						%>
						<%
						String appointmentTime = request.getParameter("appointment_time");
						%>
						<%
						String reason = request.getParameter("reason");
						%>
						<%
						statusMessage = insertAppointment(null, fullName, email, phone, appointmentDate, appointmentTime, reason);
						%>
						<%
						}
						%>
						<%
						}
						%>

						<div class="alert alert-info alert-left mt-3"><%=statusMessage%></div>
						<div class="alert alert-success alert-right mt-3">Thank you
							for choosing us!</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Appointment Form Section End -->


	<script type="text/javascript">
		//Disable AOS on small screens (less than 768px) and enable once animations
		if (window.innerWidth < 768) {
			AOS.init({
				disable : true
			});
		} else {
			AOS.init(); // Initialize AOS for larger screens with once animations
		}
	</script>


	<%@ include file="footer.jsp"%>
</body>
</html>

