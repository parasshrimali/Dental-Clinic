<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../user_css/navbar.css">
<link rel="stylesheet" type="text/css" href="../user_css/forall.css">
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





	<!-- Contact Start -->
	<div class="container-fluid pt-2"
		style="margin-top: 10rem; margin-bottom: 50px;">
		<div class="container">
			<div class="text-center mx-auto mb-5" style="max-width: 500px;" data-aos="fade-down" data-aos-duration="1000">
				<h5 class="d-inline-block text-uppercase border-bottom border-5"
					style="color: #128293;">Any Questions?</h5>
				<h1 class="display-4 font-weight-bold">Please Feel Free To
					Contact Us</h1>
			</div>
			<div class="row g-5 mb-5" data-aos="fade-up" data-aos-duration="1000">
				<div class="col-lg-4">
					<div class="bg-white shadow-sm rounded-4 p-3 text-center">
						<div
							class="d-flex align-items-center justify-content-center rounded-circle mx-auto mb-2"
							style="width: 60px; height: 60px; background-color: #128293;">
							<i class="fa fa-map-marker-alt text-white"
								style="font-size: 1.5rem;"></i>
						</div>
						<h6 class="mb-0">
							<a>Shivaranjani , Ahmedabad ,India</a>
						</h6>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="bg-white shadow-sm rounded-4 p-3 text-center">
						<div
							class="d-flex align-items-center justify-content-center rounded-circle mx-auto mb-2"
							style="width: 60px; height: 60px; background-color: #128293;">
							<i class="fa fa-phone text-white" style="font-size: 1.5rem;"></i>
						</div>
						<h6 class="mb-0">+012 345 6789</h6>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="bg-white shadow-sm rounded-4 p-3 text-center">
						<div
							class="d-flex align-items-center justify-content-center rounded-circle mx-auto mb-2"
							style="width: 60px; height: 60px; background-color: #128293;">
							<i class="fa fa-envelope text-white" style="font-size: 1.5rem;"></i>
						</div>
						<h6 class="mb-0">easydent@gmail.com</h6>
					</div>
				</div>
			</div>


			<!-- Contact Form -->
			<div class="row justify-content-center" data-aos="zoom-in" data-aos-duration="1000">
				<div class="col-lg-8">
					<div class="bg-white shadow-sm rounded p-5">


						<!-- Display Success/Error Message -->
						<%
						if ("POST".equalsIgnoreCase(request.getMethod())) {
							// Retrieve form data
							String name = request.getParameter("name");
							String phone = request.getParameter("phone");
							String email = request.getParameter("email");
							String message = request.getParameter("message");

							// Database connection details
							String jdbcURL = "jdbc:mysql://localhost:3306/dental";
							String dbUser = "root";
							String dbPassword = "sarap@321";

							Connection con = null;
							PreparedStatement stmt = null;
							String responseMessage = "";
							String alertClass = "";

							try {
								// Establish connection to the database
								Class.forName("com.mysql.cj.jdbc.Driver");
								con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

								// SQL query to insert form data into the user_info table
								String query = "INSERT INTO user_info (name, phone, email, message) VALUES (?, ?, ?, ?)";
								stmt = con.prepareStatement(query);
								stmt.setString(1, name);
								stmt.setString(2, phone);
								stmt.setString(3, email);
								stmt.setString(4, message);

								// Execute the query
								int result = stmt.executeUpdate();

								// Provide feedback to the user
								if (result > 0) {
							responseMessage = "Your message has been sent successfully ! We will get back to you soon.";
							alertClass = "alert-success"; // Success message style
								} else {
							responseMessage = "Failed to send message. Please try again.";
							alertClass = "alert-danger"; // Error message style
								}
							} catch (Exception e) {
								e.printStackTrace();
								responseMessage = "Error: " + e.getMessage();
								alertClass = "alert-danger";
							} finally {
								// Close resources
								if (stmt != null)
							try {
								stmt.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
								if (con != null)
							try {
								con.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							}
							// Display response message (success/error)
							if (!responseMessage.isEmpty()) {
								out.println("<div class='alert " + alertClass + "'>" + responseMessage + "</div>");
							}
						}
						%>

						<form action="" method="post">
							<div class="row g-3">
								<div class="col-12 col-sm-6">
									<input type="text" class="form-control border-0 shadow-sm"
										id="name" name="name" placeholder="Your Name" required>
								</div>
								<div class="col-12 col-sm-6">
									<input type="tel" class="form-control border-0 shadow-sm"
										id="phone" name="phone" placeholder="Your Phone" required
										pattern="^\d{10}$">
								</div>
								<div class="col-12">
									<input type="email" class="form-control border-0 shadow-sm"
										id="email" name="email" placeholder="Your Email" required>
								</div>
								<div class="col-12">
									<textarea class="form-control border-0 shadow-sm" id="message"
										name="message" rows="5" placeholder="Message" required></textarea>
								</div>
								<div class="col-12">
									<button class="btn btn-primary w-100 py-3" type="submit"
										style="background-color: #128293;">Send Message</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Contact End -->

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

	<%@ include file="../user/footer.jsp"%>
</body>
</html>

