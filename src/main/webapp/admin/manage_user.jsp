<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*"%>

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


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Information</title>
<%@ include file="links.jsp"%>

</head>
<body>
	<%@ include file="header.jsp"%>

	<div class="container mt-5">
		<h1 class="text-center mb-4">User Information</h1>

		<!-- User Info Table -->
		<div class="card">
			<div class="card-header">User Information</div>
			<div class="card-body table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Phone</th>
							<th>Email</th>
							<th>Message</th>
							<th>Created At</th>
						</tr>
					</thead>
					<tbody>
						<%
						Connection con = null;
						PreparedStatement stmt = null;
						ResultSet rs = null;

						try {
							Class.forName("com.mysql.cj.jdbc.Driver");
							con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dental", "root", "sarap@321");

							// Query to fetch all user information
							String query = "SELECT * FROM user_info";
							stmt = con.prepareStatement(query);
							rs = stmt.executeQuery();

							// Loop through and display each user's data
							
							while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getInt("id")%></td>
							<td><%=rs.getString("name")%></td>
							<td><%=rs.getString("phone")%></td>
							<td><%=rs.getString("email")%></td>
							<td><%=rs.getString("message")%></td>
							<td><%=rs.getTimestamp("created_at")%></td>
						</tr>
						<%
						}
						} catch (Exception e) {
						e.printStackTrace();
						} finally {
						if (stmt != null)
						stmt.close();
						if (rs != null)
						rs.close();
						if (con != null)
						con.close();
						}
						%>
					</tbody>
				</table>
			</div>
		</div>

		<!-- Back Button -->
		<!-- <div class="text-center mt-4">
			<a href="admin_dashboard.jsp" class="btn">Back to Dashboard</a>
		</div> -->
	</div>
</body>
</html>
