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
<link rel="stylesheet" type="text/css" href="../user_css/forall.css">
<link rel="stylesheet" type="text/css" href="../user_css/userlogin.css">
<%@ include file="links.jsp"%>




</head>
<body>
	<%
	String errorMessage = null; // Variable to store error messages
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String email = request.getParameter("email").trim();
		String password = request.getParameter("password").trim();

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			String dbURL = "jdbc:mysql://localhost:3306/dental"; // Replace with your DB URL
			String dbUser = "root"; // Replace with your DB username
			String dbPass = "sarap@321"; // Replace with your DB password

			// Loading MySQL JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

			// Check if there are any users registered
			String countSql = "SELECT COUNT(*) AS users_count FROM users";
			stmt = conn.prepareStatement(countSql);
			rs = stmt.executeQuery();
			if (rs.next() && rs.getInt("users_count") == 0) {
		errorMessage = "No users registered. Please register a user first.";
			} else {
		// Query to get hashed password for the entered email
		String sql = "SELECT password FROM users WHERE email = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, email);

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
				session.setAttribute("email", email);
				response.sendRedirect("index.jsp");
				return;
			} else {
				errorMessage = "Invalid email or password. Please try again.";
			}
		} else {
			errorMessage = "Invalid email or password. Please try again.";
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

	<div class="login-container text-dark">
		<form method="post">
			<h2>User Login</h2>
			<div class="mb-3">
				<label for="email" class="form-label">Email</label> <input
					type="email" class="form-control" id="email" name="email" required>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">Password</label> <input
					type="password" class="form-control" id="password" name="password"
					required>
			</div>
			<div class="d-flex justify-content-between align-items-center">
				<a href="forgot_password.jsp" class="forgot-password">Forgot
					Password ?</a>
			</div>

			<div class="d-grid gap-2 mt-3">
				<button type="submit" class="btn btn-dark">Login</button>
			</div>
		</form>
		<p class="text-center mt-3">
			Don't have an account ? <a href="user_register.jsp"
				style="color: #353B4D">Register</a>
		</p>
		<%
		// Display error message if available
		if (errorMessage != null) {
		%>
		<div class="alert alert-danger mt-3"><%=errorMessage%></div>
		<%
		}
		%>
	</div>

</body>
</html>


