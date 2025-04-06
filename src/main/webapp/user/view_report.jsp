<%@ page
	import="java.sql.*, java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Medical History - Medinova Dental Clinic</title>
<link rel="stylesheet" type="text/css" href="../user_css/forall.css">
<%@ include file="links.jsp"%>
<style>
/* Make the table scrollable on small screens */
.table-responsive {
	overflow-x: auto;
	-webkit-overflow-scrolling: touch;
}
</style>
</head>
<body>
	<div class="container">
		<h2 class="my-4">Patient Medical History</h2>

		<%
		String jdbcURL = "jdbc:mysql://localhost:3306/dental";
		String dbUser = "root";
		String dbPassword = "sarap@321";

		String userEmail = (String) session.getAttribute("email");
		if (userEmail == null) {
			response.sendRedirect("user_login.jsp");
			return;
		}

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
			String query = "SELECT * FROM medical_history WHERE patient_email=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
		}
		%>

		<div class="table-responsive">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Date</th>
						<th>Treatment</th>
						<th>Price</th>
						<th>Notes</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					while (rs != null && rs.next()) {
						String createdAt = rs.getString("created_at");
						String treatment = rs.getString("treatment");
						String price = rs.getString("price");
						String notes = rs.getString("notes");
					%>
					<tr>
						<td><%=createdAt%></td>
						<td><%=treatment%></td>
						<td><%=price%></td>
						<td><%=notes%></td>
						<td>
							<form action="download_report.jsp" method="get">
								<input type="hidden" name="date" value="<%=createdAt%>">
								<button type="submit" class="btn btn-dark">Download</button>
							</form>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

		<%
		// Close the resources
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
		%>
	</div>
</body>
</html>





