<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.security.MessageDigest, jakarta.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dental Clinic - Login</title>
<!-- Disable AOS on small screens -->
<style>
@media ( max-width : 768px) {
	[data-aos] {
		opacity: 1 !important;
		transform: none !important;
		transition: none !important;
	}
}
</style>
<%@ include file="links.jsp"%>

<link rel="stylesheet" type="text/css"
	href="../admin_css/adminlogin.css">
</head>
<body>
	<%
	String errorMessage = null; // Variable to store error messages
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String name = request.getParameter("name").trim();
		String password = request.getParameter("password").trim();

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			String dbURL = "jdbc:mysql://localhost:3306/dental";
			String dbUser = "root";
			String dbPass = "sarap@321";

			// Loading MySQL JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

			// Check if there are any admins registered
			String countSql = "SELECT COUNT(*) AS admin_count FROM admin";
			stmt = conn.prepareStatement(countSql);
			rs = stmt.executeQuery();
			if (rs.next() && rs.getInt("admin_count") == 0) {
		errorMessage = "No admin registered. Please register an admin first.";
			} else {
		// Query to get hashed password for the entered name
		String sql = "SELECT password FROM admin WHERE name = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, name);

		rs = stmt.executeQuery();

		if (rs.next()) {
			// Get the hashed password from the database
			String storedHashedPassword = rs.getString("password");

			// Hash the entered password
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(password.getBytes());
			byte[] hashedBytes = md.digest();
			StringBuilder sb = new StringBuilder();
			for (byte b : hashedBytes) {
				sb.append(String.format("%02x", b));
			}
			String hashedPassword = sb.toString();

			// Compare the hashed password
			if (hashedPassword.equals(storedHashedPassword)) {
				// Set session attribute and redirect to dashboard
				HttpSession ses = request.getSession();
				session.setAttribute("name", name);
				response.sendRedirect("admin_dashboard.jsp");
				return;
			} else {
				errorMessage = "Invalid name or password. Please try again.";
			}
		} else {
			errorMessage = "Invalid name or password. Please try again.";
		}
			}
		} catch (Exception e) {
			errorMessage = "Error: " + e.getMessage();
			e.printStackTrace();
		} finally {
			try {
		if (rs != null)
			rs.close();
		if (stmt != null)
			stmt.close();
		if (conn != null)
			conn.close();
			} catch (Exception ex) {
		errorMessage = "Error closing resources: " + ex.getMessage();
			}
		}
	}
	%>

	<div class="login-container text-dark" data-aos="fade-up"
		data-aos-duration="1000">
		<form method="post">
			<h2 data-aos="fade-down" data-aos-delay="200">Admin Login</h2>

			<div class="mb-3" data-aos="fade-right" data-aos-delay="300">
				<label for="name" class="form-label">Name</label> <input type="text"
					class="form-control" id="name" name="name" required>
			</div>

			<div class="mb-3" data-aos="fade-left" data-aos-delay="400">
				<label for="password" class="form-label">Password</label> <input
					type="password" class="form-control" id="password" name="password"
					required>
			</div>

			<div class="d-flex justify-content-between align-items-center">
				<a href="forgot_password.jsp" class="forgot-password"
					data-aos="fade-up" data-aos-delay="500">Forgot Password ?</a>
			</div>

			<div class="d-grid gap-2 mt-3" data-aos="zoom-in"
				data-aos-delay="600">
				<button type="submit" class="btn btn-dark">Login</button>
			</div>
		</form>

		<p class="text-center mt-3" data-aos="fade-up" data-aos-delay="700">
			Don't have an account? <a href="admin_register.jsp"
				style="color: #353B4D">Register</a>
		</p>

		<%
		if (errorMessage != null) {
		%>
		<div class="alert alert-danger mt-3" data-aos="fade-up"
			data-aos-delay="800"><%=errorMessage%></div>
		<%
		}
		%>
	</div>



	<!-- Initialize AOS -->
	<script>
		AOS.init();
	</script>

</body>
</html>
