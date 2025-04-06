<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.security.MessageDigest, jakarta.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Forgot Password</title>
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
	href="../admin_css/forgotpassword.css">
</head>

<body>

	<div class="container">
		<h3 class="text-center mb-4" data-aos="fade-up"
			data-aos-duration="1000">Forgot Password</h3>

		<%
		String secQuestion = request.getParameter("recoveryQuestion");
		String errorMessage = null;

		if ("POST".equalsIgnoreCase(request.getMethod()) && "validateSecurity".equals(request.getParameter("action"))) {
			String name = request.getParameter("name").trim();
			String secAnswer = request.getParameter("securityAnswer").trim();

			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;

			try {
				String dbURL = "jdbc:mysql://localhost:3306/dental";
				String dbUser = "root";
				String dbPass = "sarap@321";

				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

				String sql = "SELECT recovery_question, recovery_answer FROM users WHERE name = ? AND recovery_question = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, name);
				stmt.setString(2, secQuestion);
				rs = stmt.executeQuery();

				if (rs.next()) {
			String storedAnswer = rs.getString("recovery_answer");

			if (secAnswer.equalsIgnoreCase(storedAnswer)) {
				request.setAttribute("resetPasswordAllowed", true);
			} else {
				errorMessage = "Invalid security answer. Please try again.";
			}
				} else {
			errorMessage = "User not found or recovery question does not match. Please check the entered information.";
				}
			} catch (Exception e) {
				errorMessage = "Error: " + e.getMessage();
				e.printStackTrace();
			} finally {
				if (rs != null)
			rs.close();
				if (stmt != null)
			stmt.close();
				if (conn != null)
			conn.close();
			}
		}

		if ("POST".equalsIgnoreCase(request.getMethod()) && "resetPassword".equals(request.getParameter("action"))) {
			String name = request.getParameter("name").trim();
			String newPassword = request.getParameter("newPassword").trim();

			Connection conn = null;
			PreparedStatement stmt = null;

			try {
				String dbURL = "jdbc:mysql://localhost:3306/dental";
				String dbUser = "root";
				String dbPass = "sarap@321";

				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

				MessageDigest md = MessageDigest.getInstance("SHA-256");
				md.update(newPassword.getBytes());
				byte[] hashedBytes = md.digest();
				StringBuilder sb = new StringBuilder();
				for (byte b : hashedBytes) {
			sb.append(String.format("%02x", b));
				}
				String hashedPassword = sb.toString();

				String sql = "UPDATE users SET password = ? WHERE name = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, hashedPassword);
				stmt.setString(2, name);
				int rowsUpdated = stmt.executeUpdate();

				if (rowsUpdated > 0) {
			request.setAttribute("passwordResetSuccess", true);
		%>
		<script>
			setTimeout(function() {
				window.location.href = "user_login.jsp";
			}, 1500);
		</script>
		<%
		} else {
		errorMessage = "Failed to update password. Please try again.";
		}
		} catch (Exception e) {
		errorMessage = "Error: " + e.getMessage();
		e.printStackTrace();
		} finally {
		if (stmt != null)
		stmt.close();
		if (conn != null)
		conn.close();
		}
		}
		%>

		<%
		if (request.getAttribute("resetPasswordAllowed") == null) {
		%>
		<form method="post">
			<input type="hidden" name="action" value="validateSecurity">

			<div class="mb-3" data-aos="fade-right" data-aos-delay="300">
				<label for="name" class="form-label">Enter Your Name</label> <input
					type="text" class="form-control" id="name" name="name" required>
			</div>

			<div class="mb-3" data-aos="fade-left" data-aos-delay="400">
				<label for="securityQuestion" class="form-label">Select Your
					Security Question</label> <select class="form-control"
					id="securityQuestion" name="recoveryQuestion" required>
					<option value="What is your pet's name?"
						<%="What is your pet's name?".equals(secQuestion) ? "selected" : ""%>>What
						is your pet's name?</option>
					<option value="What is the name of your first school?"
						<%="What is the name of your first school?".equals(secQuestion) ? "selected" : ""%>>What
						is the name of your first school?</option>
					<option value="What city were you born in?"
						<%="What city were you born in?".equals(secQuestion) ? "selected" : ""%>>What
						city were you born in?</option>
					<option value="What was your childhood nickname?"
						<%="What was your childhood nickname?".equals(secQuestion) ? "selected" : ""%>>What
						was your childhood nickname?</option>
					<option value="What is your favorite color?"
						<%="What is your favorite color?".equals(secQuestion) ? "selected" : ""%>>What
						is your favorite color?</option>
				</select>
			</div>

			<div class="mb-3" data-aos="fade-right" data-aos-delay="500">
				<label for="securityAnswer" class="form-label">Enter
					Security Answer</label> <input type="text" class="form-control"
					id="securityAnswer" name="securityAnswer" required>
			</div>

			<button type="submit" class="btn btn-dark w-100" data-aos="zoom-in"
				data-aos-delay="600">Submit</button>

			<p class="text-center mt-3" data-aos="fade-up" data-aos-delay="700">
				Already Registered? <a href="user_login.jsp" style="color: #353B4D">Login</a>
			</p>
		</form>




		<%
		}
		%>

		<%
		if (request.getAttribute("resetPasswordAllowed") != null) {
		%>
		<form method="post" onsubmit="return validatePassword()"
			data-aos="fade-up" data-aos-duration="1000">
			<input type="hidden" name="action" value="resetPassword"> <input
				type="hidden" name="name" value="<%=request.getParameter("name")%>">

			<div class="mb-3" data-aos="fade-right" data-aos-delay="300">
				<label for="newPassword" class="form-label">Enter New
					Password</label> <input type="password" class="form-control"
					id="newPassword" name="newPassword"
					pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$"
					title="Password must be at least 8 characters long, contain one uppercase letter, one lowercase letter, one number, and one special character."
					required minlength="8"> <small id="passwordMessage"
					class="form-text"></small>
			</div>

			<div class="mb-3" data-aos="fade-left" data-aos-delay="400">
				<label for="confirmPassword" class="form-label">Confirm
					Password</label> <input type="password" class="form-control"
					id="confirmPassword" name="confirmPassword" required minlength="8">
				<small id="confirmPasswordMessage" class="form-text"></small>
			</div>

			<button type="submit" class="btn btn-dark w-100" data-aos="zoom-in"
				data-aos-delay="500">Reset Password</button>
		</form>
		<%
		}
		%>

		<%
		if (errorMessage != null) {
		%>
		<div class="alert alert-danger mt-3"><%=errorMessage%></div>
		<%
		} else if (request.getAttribute("passwordResetSuccess") != null) {
		%>
		<div class="alert alert-success mt-3">Password has been reset
			successfully!</div>
		<%
		}
		%>

	</div>

	<script>
		function validatePassword() {
			const password = document.getElementById('newPassword').value;
			const confirmPassword = document.getElementById('confirmPassword').value;
			const confirmMessage = document
					.getElementById('confirmPasswordMessage');

			// Check if passwords match
			if (password !== confirmPassword) {
				confirmMessage.textContent = "Passwords do not match.";
				confirmMessage.classList.remove("text-success");
				confirmMessage.classList.add("text-danger");
				return false;
			} else {
				confirmMessage.textContent = "Passwords match!";
				confirmMessage.classList.remove("text-danger");
				confirmMessage.classList.add("text-success");
			}

			return true;
		}
	</script>

	<!-- Initialize AOS -->
	<script>
		AOS.init();
	</script>
</body>

</html>