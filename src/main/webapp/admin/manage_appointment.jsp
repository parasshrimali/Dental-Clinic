<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

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

// Handle approve/decline actions
if ("POST".equalsIgnoreCase(request.getMethod())) {
	String action = request.getParameter("action");
	String appointmentId = request.getParameter("appointment_id");

	if (action != null && appointmentId != null) {
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
	String dbURL = "jdbc:mysql://localhost:3306/dental";
	String dbUser = "root";
	String dbPass = "sarap@321";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

	String sql = "";
	if ("approve".equalsIgnoreCase(action)) {
		sql = "UPDATE appointments SET status = 'Approved' WHERE id = ?";
	} else if ("decline".equalsIgnoreCase(action)) {
		sql = "UPDATE appointments SET status = 'Declined' WHERE id = ?";
	}

	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(appointmentId));
	int rowsUpdated = stmt.executeUpdate();

	if (rowsUpdated > 0) {
		// Set success message in session
		session.setAttribute("message", "Appointment updated successfully!");
		response.sendRedirect("manage_appointment.jsp");
		return;
	}

		} catch (Exception e) {
	out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
		} finally {
	try {
		if (stmt != null)
			stmt.close();
		if (conn != null)
			conn.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
		}
	}
}
%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Appointments</title>
<link rel="stylesheet" type="text/css"
	href="../admin_css/manageappointment.css">
</head>
<body>
	<%@ include file="links.jsp"%>
	<%@ include file="header.jsp"%>

	<h1 class="text-center mb-2" style="margin-top: 40px;">Manage
		Appointments</h1>

	<div class="container">
		<!-- Display success message from session if it exists -->
		<%
		String message = (String) session.getAttribute("message");
		if (message != null) {
		%>
		<div class="alert alert-success" role="alert">
			<%=message%>
		</div>
		<%
		// Clear the message after displaying
		session.removeAttribute("message");
		}
		%>

		<div class="table-responsive">
			<table class="table table-bordered text-center">
				<thead class="table-dark">
					<tr>
						<th>ID</th>
						<th>Patient Name</th>
						<th>Date</th>
						<th>Time</th>
						<th>Reason</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					Connection conn = null;
					PreparedStatement stmt = null;
					ResultSet rs = null;

					try {
						String dbURL = "jdbc:mysql://localhost:3306/dental";
						String dbUser = "root";
						String dbPass = "sarap@321";
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

						String sql = "SELECT a.id, p.name, a.appointment_date, a.appointment_time, a.reason, a.status "
						+ "FROM appointments a JOIN patients p ON a.patient_id = p.id ORDER BY a.created_at DESC";
						stmt = conn.prepareStatement(sql);
						rs = stmt.executeQuery();

						while (rs.next()) {
					%>
					<tr>
						<td><%=rs.getInt("id")%></td>
						<td><%=rs.getString("name")%></td>
						<td><%=rs.getDate("appointment_date")%></td>
						<td><%=rs.getTime("appointment_time")%></td>
						<td><%=rs.getString("reason")%></td>
						<td><%=rs.getString("status")%></td>
						<td>
							<form method="POST" action="" class="d-inline">
								<input type="hidden" name="appointment_id"
									value="<%=rs.getInt("id")%>">
								<button type="submit" name="action" value="approve" id="approve"
									class="btn btn-success btn-sm">Approve</button>
								<button type="submit" name="action" value="decline" id="decline"
									class="btn btn-danger btn-sm">Decline</button>
							</form>
						</td>
					</tr>
					<%
					}
					} catch (Exception e) {
					out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
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
					%>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>