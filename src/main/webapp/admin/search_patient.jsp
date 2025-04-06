<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Patients</title>
<%@ include file="links.jsp"%>
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
%>
<link rel="stylesheet" type="text/css"
	href="../admin_css/searchpatient.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="container">
		<h1 class="text-center mb-4">Search Patients</h1>

		<!-- Search Form -->
		<form method="post" class="mb-4">
			<div class="row g-3">
				<div class="col-md-3">
					<input type="text" class="form-control" name="name"
						placeholder="Search by Name">
				</div>
				<div class="col-md-3">
					<input type="email" class="form-control" name="email"
						placeholder="Search by Email">
				</div>
				<div class="col-md-3">
					<input type="tel" class="form-control" name="phone"
						placeholder="Search by Phone">
				</div>
				<div class="col-md-3">
					<select class="form-control" name="gender">
						<option value="">Select Gender</option>
						<option value="Male">Male</option>
						<option value="Female">Female</option>
					</select>
				</div>
			</div>
			<div class="row mt-3">
				<div class="col-md-6">
					<input type="text" class="form-control" name="address"
						placeholder="Search by Address">
				</div>
				<div class="col-md-3">
					<input type="number" class="form-control" name="age" id="age"
						placeholder="Search by Age" min="1" max="120">
				</div>
				<div class="col-md-3" id="search">
					<button type="submit" class="btn btn-primary w-100">Search</button>
				</div>
			</div>
		</form>


		<!-- Results Table -->
		<div class="table-responsive">
			<table class="table table-bordered table-hover">
				<thead class="table-dark">
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Phone</th>
						<th>Gender</th>
						<th>Address</th>
						<th>age</th>
						<th>Created At</th>
						<th>Updated At</th>
					</tr>
				</thead>
				<tbody>
					<%
					String url = "jdbc:mysql://localhost:3306/dental";
					String user = "root";
					String password = "sarap@321";

					Connection conn = null;
					PreparedStatement stmt = null;
					ResultSet rs = null;

					String name = request.getParameter("name");
					String email = request.getParameter("email");
					String phone = request.getParameter("phone");
					String gender = request.getParameter("gender");
					String address = request.getParameter("address");
					String age = request.getParameter("age");

					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn = DriverManager.getConnection(url, user, password);

						// Build SQL Query
						String sql = "SELECT * FROM patients WHERE 1=1";
						if (name != null && !name.trim().isEmpty())
							sql += " AND name LIKE ?";
						if (email != null && !email.trim().isEmpty())
							sql += " AND email LIKE ?";
						if (phone != null && !phone.trim().isEmpty())
							sql += " AND phone LIKE ?";
						if (gender != null && !gender.trim().isEmpty())
							sql += " AND gender = ?";
						if (address != null && !address.trim().isEmpty())
							sql += " AND address LIKE ?";
						if (age != null && !age.trim().isEmpty())
							sql += " AND age = ?";
						sql += " ORDER BY id";

						stmt = conn.prepareStatement(sql);

						// Set query parameters
						int index = 1;
						if (name != null && !name.trim().isEmpty())
							stmt.setString(index++, "%" + name + "%");
						if (email != null && !email.trim().isEmpty())
							stmt.setString(index++, "%" + email + "%");
						if (phone != null && !phone.trim().isEmpty())
							stmt.setString(index++, "%" + phone + "%");
						if (gender != null && !gender.trim().isEmpty())
							stmt.setString(index++, gender);
						if (address != null && !address.trim().isEmpty())
							stmt.setString(index++, "%" + address + "%");
						if (age != null && !age.trim().isEmpty())
							stmt.setInt(index++, Integer.parseInt(age));

						rs = stmt.executeQuery();

						// Display Results
						while (rs.next()) {
							out.println("<tr>");
							out.println("<td>" + rs.getString("id") + "</td>");
							out.println("<td>" + rs.getString("name") + "</td>");
							out.println("<td>" + rs.getString("email") + "</td>");
							out.println("<td>" + rs.getString("phone") + "</td>");
							out.println("<td>" + rs.getString("gender") + "</td>");
							out.println("<td>" + rs.getString("address") + "</td>");
							out.println("<td>" + rs.getString("age") + "</td>");
							out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
							out.println("<td>" + rs.getTimestamp("updated_at") + "</td>");
							out.println("</tr>");
						}
					} catch (Exception e) {
						e.printStackTrace();
						out.println("<tr><td colspan='9' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
					} finally {
						if (rs != null)
							try {
						rs.close();
							} catch (SQLException e) {
						e.printStackTrace();
							}
						if (stmt != null)
							try {
						stmt.close();
							} catch (SQLException e) {
						e.printStackTrace();
							}
						if (conn != null)
							try {
						conn.close();
							} catch (SQLException e) {
						e.printStackTrace();
							}
					}
					%>

				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
