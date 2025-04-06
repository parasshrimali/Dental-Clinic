<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.security.MessageDigest, jakarta.servlet.http.*,jakarta.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dental Clinic - Dashboard</title>
<%@ include file="links.jsp"%>
<link rel="stylesheet" type="text/css"
	href="../admin_css/admindashboard.css">
</head>
<body>
	<%
	// Prevent caching
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	// Check login session
	session = request.getSession();
	if (session.getAttribute("name") == null) {
		response.sendRedirect("admin_login.jsp");
		return;
	}
	%>


	<div class="container">
		<h1 class="welcome-title" data-aos="fade-up" data-aos-duration="1000">
			Welcome,
			<%=session.getAttribute("name")%>!
		</h1>
		<p class="description" data-aos="fade-right" data-aos-delay="300">
			Use the sidebar to navigate between different sections of the
			management system. Manage doctors, staff, appointments, and more with
			ease.</p>
		<div class="btn-container" data-aos="fade-left" data-aos-delay="500">
			<button id="dashbutton" type="button" data-bs-toggle="offcanvas"
				data-bs-target="#staticBackdrop" aria-controls="staticBackdrop">
				Open Navigation Menu</button>
		</div>
	</div>

	<!-- Offcanvas Navigation Menu -->
	<div class="offcanvas offcanvas-start text-bg-dark"
		data-bs-backdrop="static" tabindex="-1" id="staticBackdrop"
		aria-labelledby="staticBackdropLabel" style="width: 350px;">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="staticBackdropLabel">Navigation
				Menu</h5>
			<button type="button" class="btn-close btn-close-white"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body text-start">
			<nav class="nav flex-column">
				<a class="nav-link text-light" href="manage_admin.jsp">Manage
					Admins</a> <a class="nav-link text-light" href="manage_doctor.jsp">Manage
					Doctors</a> <a class="nav-link text-light" href="manage_staff.jsp">Manage
					Staff</a> <a class="nav-link text-light" href="manage_patient.jsp">Manage
					Patients</a> <a class="nav-link text-light" href="search_patient.jsp">Search
					Patients</a> <a class="nav-link text-light" href="manage_user.jsp">Manage
					Users</a> <a class="nav-link text-light" href="manage_appointment.jsp">Manage
					Appointments</a> <a class="nav-link text-light fs-5"
					href="patient_record.jsp">Manage Reports</a> <a
					class="nav-link text-light" href="logout.jsp">Logout <svg
						width="24px" height="24px" fill="white" viewBox="0 0 1024 1024"
						transform="rotate(180)" xmlns="http://www.w3.org/2000/svg"
						class="icon">
                    <path
							d="M868 732h-70.3c-4.8 0-9.3 2.1-12.3 5.8-7 8.5-14.5 16.7-22.4 24.5a353.84 353.84 0 0 1-112.7 75.9A352.8 352.8 0 0 1 512.4 866c-47.9 0-94.3-9.4-137.9-27.8a353.84 353.84 0 0 1-112.7-75.9 353.28 353.28 0 0 1-76-112.5C167.3 606.2 158 559.9 158 512s9.4-94.2 27.8-137.8c17.8-42.1 43.4-80 76-112.5s70.5-58.1 112.7-75.9c43.6-18.4 90-27.8 137.9-27.8 47.9 0 94.3 9.3 137.9 27.8 42.2 17.8 80.1 43.4 112.7 75.9 7.9 7.9 15.3 16.1 22.4 24.5 3 3.7 7.6 5.8 12.3 5.8H868c6.3 0 10.2-7 6.7-12.3C798 160.5 663.8 81.6 511.3 82 271.7 82.6 79.6 277.1 82 516.4 84.4 751.9 276.2 942 512.4 942c152.1 0 285.7-78.8 362.3-197.7 3.4-5.3-.4-12.3-6.7-12.3zm88.9-226.3L815 393.7c-5.3-4.2-13-.4-13 6.3v76H488c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h314v76c0 6.7 7.8 10.5 13 6.3l141.9-112a8 8 0 0 0 0-12.6z" />
                </svg>
				</a>
			</nav>
		</div>
	</div>

	<!-- Initialize AOS -->
	<script>
		AOS.init({
			disable : function() {
				return window.innerWidth < 768; // Disable AOS on small screens
			}
		});
	</script>

</body>
</html>







