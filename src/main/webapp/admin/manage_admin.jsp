<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.security.MessageDigest, java.nio.charset.StandardCharsets, java.util.regex.Pattern"%>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*"%>

<%
// Prevent browser caching
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

// Check if the session exists and the user is authenticated
if (session == null || session.getAttribute("name") == null) {
	response.sendRedirect("admin_login.jsp");
	return;
}

// Database Connection Variables
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
	String dbURL = "jdbc:mysql://localhost:3306/dental";
	String dbUser = "root";
	String dbPass = "sarap@321";

	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

	// Handle form submissions only if method is POST
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String action = request.getParameter("action");

		if ("deleteAdmin".equals(action)) {
	String adminId = request.getParameter("id");
	if (adminId != null) {
		String deleteSQL = "DELETE FROM admin WHERE id = ?";
		stmt = conn.prepareStatement(deleteSQL);
		stmt.setString(1, adminId);
		stmt.executeUpdate();
	}
		}

		if ("editAdmin".equals(action)) {
	String adminId = request.getParameter("id");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");

	if (adminId != null && name != null && email != null && phone != null && name.matches("[a-zA-Z ]+")
			&& phone.matches("\\d{10}") && email.matches("^[\\w._%+-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {

		String updateSQL = "UPDATE admin SET name=?, email=?, phone=? WHERE id=?";
		stmt = conn.prepareStatement(updateSQL);
		stmt.setString(1, name);
		stmt.setString(2, email);
		stmt.setString(3, phone);
		stmt.setString(4, adminId);
		stmt.executeUpdate();
	} else {
		out.println("<div class='alert alert-danger'>Invalid input provided!</div>");
	}
		}

		if ("addAdmin".equals(action)) {
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String password = request.getParameter("password");
	String recovery_question = request.getParameter("recovery_question");
	String recovery_answer = request.getParameter("recovery_answer");

	// Check for duplicate name, email, or phone
	String checkSQL = "SELECT * FROM admin WHERE name = ? OR email = ? OR phone = ?";
	stmt = conn.prepareStatement(checkSQL);
	stmt.setString(1, name);
	stmt.setString(2, email);
	stmt.setString(3, phone);
	rs = stmt.executeQuery();

	if (rs.next()) {
		out.println(
				"<div class='alert alert-danger'>Error: Name, email, or phone is already registered!</div>");
	} else {
		// Generate a unique 4-character ID
		String uniqueId = String.format("%04d", (int) (Math.random() * 10000));

		// Hash the password using SHA-256
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] hashedPasswordBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));
		StringBuilder sb = new StringBuilder();
		for (byte b : hashedPasswordBytes) {
			sb.append(String.format("%02x", b));
		}
		String hashedPassword = sb.toString();

		// Insert new admin
		String insertSQL = "INSERT INTO admin (id, name, email, phone, password, recovery_question, recovery_answer) VALUES (?, ?, ?, ?, ?, ?, ?)";
		stmt = conn.prepareStatement(insertSQL);
		stmt.setString(1, uniqueId);
		stmt.setString(2, name);
		stmt.setString(3, email);
		stmt.setString(4, phone);
		stmt.setString(5, hashedPassword);
		stmt.setString(6, recovery_question);
		stmt.setString(7, recovery_answer);
		stmt.executeUpdate();

		out.println("<div class='alert alert-success'>Admin added successfully!</div>");
	}
		}
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>


</head>
<body>
	<%@ include file="links.jsp"%>
	<%@ include file="header.jsp"%>

	<div class="container mt-5">

		<h2 class="text-center mb-4">Admin List</h2>

		<!-- Add Admin Button (above the ID column) -->
		<div class="text-center mb-3">
			<button class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#addAdminModal">Add Admin</button>
		</div>

		<!-- Scrollable Table -->
		<div class="table-responsive">
			<table class="table table-bordered my-2">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Phone</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					try {
						String sql = "SELECT * FROM admin";
						stmt = conn.prepareStatement(sql);
						rs = stmt.executeQuery();

						while (rs.next()) {
					%>
					<tr>
						<td><%=rs.getString("id")%></td>
						<td><%=rs.getString("name")%></td>
						<td><%=rs.getString("email")%></td>
						<td><%=rs.getString("phone")%></td>
						<td>
							<form method="post">
								<input type="hidden" name="id" value="<%=rs.getString("id")%>">
								<input type="hidden" name="action" value="deleteAdmin">
								<button type="submit" class="btn btn-danger btn-sm"
									onclick="return confirm('Are you sure you want to delete this admin?')">Delete</button>
							</form>
						</td>
					</tr>
					<%
					}
					} catch (Exception e) {
					out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
					}
					%>
				</tbody>
			</table>
		</div>

		<div class="modal fade" id="addAdminModal" tabindex="-1"
			aria-labelledby="addAdminModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="addAdminModalLabel">Add Admin</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="addAdminForm" method="post" novalidate>
							<div class="mb-3">
								<label for="name" class="form-label">Name</label> <input
									type="text" class="form-control" id="name" name="name"
									pattern="[a-zA-Z ]+" title="Only alphabets allowed" required>
								<div class="invalid-feedback">Please enter a valid name.</div>
							</div>

							<div class="mb-3">
								<label for="email" class="form-label">Email</label> <input
									type="email" class="form-control" id="email" name="email"
									pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
								<div class="invalid-feedback">Please enter a valid email
									address.</div>
							</div>
						
							<div class="mb-3">
								<label for="phone" class="form-label">Phone</label> <input
									type="text" class="form-control" id="phone" name="phone"
									pattern="^\+?[0-9]{10,13}$"
									title="Enter 10-13 digit phone number" required>
								<div class="invalid-feedback">Please enter a valid phone
									number.</div>
							</div>

							<div class="mb-3">
								<label for="password" class="form-label">Password</label> <input
									type="password" class="form-control" id="password"
									name="password"
									pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{6,}"
									title="Must contain at least 6 characters, including uppercase, lowercase, number, and special character"
									required>
								<div class="invalid-feedback">Password must be at least 6
									characters and include uppercase, lowercase, number, and
									special character.</div>
							</div>

							<div class="mb-3">
								<label for="recovery_question" class="form-label">Recovery
									Question</label> <select class="form-select" id="recovery_question"
									name="recovery_question" required>
									<option value="" disabled selected>Select a recovery
										question</option>
									<option value="What is your pet's name?">What is your
										pet's name?</option>
									<option value="What is the name of your first school?">What
										is the name of your first school?</option>
									<option value="What city were you born in?">What city
										were you born in?</option>
									<option value="What was your childhood nickname?">What
										was your childhood nickname?</option>
									<option value="What is your favorite color?">What is
										your favorite color?</option>
								</select>
								<div class="invalid-feedback">Please select a recovery
									question.</div>
							</div>

							<div class="mb-3">
								<label for="recovery_answer" class="form-label">Recovery
									Answer</label> <input type="text" class="form-control"
									id="recovery_answer" name="recovery_answer" required>
								<div class="invalid-feedback">Please provide an answer.</div>
							</div>

							<input type="hidden" name="action" value="addAdmin">
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
								<button type="submit" class="btn btn-primary">Add Admin</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<script>
			document.addEventListener("DOMContentLoaded", function() {
				const form = document.getElementById("addAdminForm");

				// Bootstrap validation
				form.addEventListener("submit", function(event) {
					if (!form.checkValidity()) {
						event.preventDefault();
						event.stopPropagation();
					}
					form.classList.add("was-validated");
				});

				// Clear form fields when modal is closed
				document.getElementById('addAdminModal').addEventListener(
						'hidden.bs.modal', function() {
							form.reset();
							form.classList.remove("was-validated");
						});
			});
		</script>
</body>
</html>

<%
} catch (Exception e) {
out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
} finally {
if (rs != null)
	rs.close();
if (stmt != null)
	stmt.close();
if (conn != null)
	conn.close();
}
%>