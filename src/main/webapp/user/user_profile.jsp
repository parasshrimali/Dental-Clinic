<%@ page import="java.sql.*, java.util.*"%>

<%

//Prevent browser caching
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

//Check if the session exists and the user is authenticated
if (session == null || session.getAttribute("email") == null) {
	response.sendRedirect("user_login.jsp");
	return;
}



String jdbcURL = "jdbc:mysql://localhost:3306/dental";
String dbUser = "root";
String dbPassword = "sarap@321";

Connection conn = null;
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
} catch (Exception e) {
	out.println("Database Connection Failed: " + e.getMessage());
	return;
}

String userEmail = (String) session.getAttribute("email");
if (userEmail == null) {
	response.sendRedirect("user_login.jsp");
	return;
}

String query = "SELECT * FROM users WHERE email=?";
PreparedStatement pstmt = conn.prepareStatement(query);
pstmt.setString(1, userEmail);
ResultSet rs = pstmt.executeQuery();

String name = "", email = "", phone = "", createdAt = "", updatedAt = "";
if (rs.next()) {
	name = rs.getString("name");
	email = rs.getString("email");
	phone = rs.getString("phone");
	createdAt = rs.getString("created_at");
	updatedAt = rs.getString("updated_at");
} else {
	session.invalidate();
	response.sendRedirect("user_login.jsp");
	return;
}

String appointmentsQuery = "SELECT * FROM appointments WHERE patient_email=? ORDER BY appointment_date DESC";
PreparedStatement appStmt = conn.prepareStatement(appointmentsQuery);
appStmt.setString(1, userEmail);
ResultSet appRs = appStmt.executeQuery();

if (request.getMethod().equals("POST")) {
	String newName = request.getParameter("name");
	String newPhone = request.getParameter("phone");

	String updateQuery = "UPDATE users SET name=?, phone=?, updated_at=NOW() WHERE email=?";
	PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
	updateStmt.setString(1, newName);
	updateStmt.setString(2, newPhone);
	updateStmt.setString(3, userEmail);

	int rowsUpdated = updateStmt.executeUpdate();
	if (rowsUpdated > 0) {
		response.sendRedirect("user_profile.jsp");
	} else {
		out.println("Update failed. Please try again.");
	}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Profile</title>
<link rel="stylesheet" type="text/css" href="../user_css/forall.css">
<link rel="stylesheet" type="text/css"
	href="../user_css/userprofile.css">
<%@ include file="links.jsp"%>

<style type="text/css">
body {
	background: linear-gradient(to right, #e3f2fd, #ffffff);
	font-family: 'Poppins', sans-serif;
}

/* Profile Container */
.profile-container {
	background: rgba(255, 255, 255, 0.9);
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
	text-align: center;
	max-width: 500px;
	margin: auto;
}

/* Scrollable Table */
.scrollable-table {
	max-height: 300px;
	overflow-y: auto;
}

/* Buttons */
.btn-custom {
	background: #46474A;
	color: white;
	padding: 10px 15px;
	border-radius: 8px;
	transition: all 0.3s ease-in-out;
	width: 100%;
}

.btn-custom:hover {
	background: #2F2F2F;
	color: white;
}

/* Sidebar Button */
.offcanvas-btn {
	position: fixed;
	top: 20px;
	right: 20px;
	border: none;
	background: transparent;
	color: white;
	font-size: 2rem;
	padding: 10px;
	border-radius: 50%;
	transition: 0.3s ease-in-out;
}

.offcanvas-btn:hover {
	background: transparent;
}

/* Offcanvas Sidebar */
.offcanvas {
	width: 250px;
	transition: transform 0.3s ease-in-out;
}

/* Modal */
.modal-content {
	border-radius: 10px;
}
</style>

</head>
<body>

	<!-- Toggle Button for Offcanvas -->
	<button class="btn btn-light offcanvas-btn" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasLeft"
		aria-controls="offcanvasLeft">
		<!-- <img alt="" src="img/togg.png" width="50px"> -->
		<i class="fa fa-bars" style="color: black;"></i>


	</button>

	<!-- Offcanvas Sidebar -->
	<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasLeft"
		aria-labelledby="offcanvasLeftLabel">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="offcanvasLeftLabel">User
				Dashboard</h5>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
			<ul class="list-group">
			<li class="list-group-item"><i class="fa fa-home me-2"></i> <a
					href="index.jsp" class="text-dark">Home</a></li>
				<li class="list-group-item"><i class="fa fa-user me-2"></i> <a
					href="user_profile.jsp" class="text-dark">Profile</a></li>
				<li class="list-group-item"><i class="fa fa-file-alt me-2"></i>
					<a href="view_report.jsp" class="text-dark">View Reports</a></li>
				<li class="list-group-item"><i class="fa fa-calendar-alt me-2"></i>
					<a href="user_profile.jsp" class="text-dark">View Appointments</a></li>
					<li class="list-group-item"><i class="fa fa-calendar me-2"></i>
					<a href="booking.jsp" class="text-dark">Book Appointment</a></li>
				<li class="list-group-item"><i class="fa fa-sign-out-alt me-2"></i>
					<a href="user_logout.jsp" class="text-dark">Logout</a></li>
			</ul>
		</div>

	</div>

	<div class="container mt-4">
		<div class="profile-container">
			<h3>
				Welcome,
				<%=name%>!
			</h3>
			<p>
				<b>Email:</b>
				<%=email%></p>
			<p>
				<b>Phone:</b>
				<%=phone%></p>
			<p>
				<b>Account Created:</b>
				<%=createdAt%></p>
			<p>
				<b>Last Updated:</b>
				<%=updatedAt%></p>
			<button class="btn btn-custom mt-3" data-bs-toggle="modal"
				data-bs-target="#editProfileModal">Edit Profile</button>
		</div>

		<!-- Appointments Section -->
		<div class="table-container mt-4">
			<h4 class="text-center">Your Appointments</h4>
			<div class="scrollable-table">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>ID</th>
							<th>Date</th>
							<th>Time</th>
							<th>Reason</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<%
						while (appRs.next()) {
						%>
						<tr>
							<td><%=appRs.getString("id")%></td>
							<td><%=appRs.getString("appointment_date")%></td>
							<td><%=appRs.getString("appointment_time")%></td>
							<td><%=appRs.getString("reason")%></td>
							<td><%=appRs.getString("status")%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- Edit Profile Modal -->
	<div class="modal fade" id="editProfileModal" tabindex="-1"
		aria-labelledby="editProfileLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editProfileLabel">Edit Profile</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form method="POST">
					<div class="modal-body">
						<div class="mb-3">
							<label class="form-label">Name:</label> <input type="text"
								class="form-control" name="name" value="<%=name%>" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Phone:</label> <input type="text"
								class="form-control" name="phone" value="<%=phone%>" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-custom">Save Changes</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>



