<%@ page import="java.sql.*"%>
<%
String jdbcURL = "jdbc:mysql://localhost:3306/dental";
String dbUser = "root";
String dbPassword = "sarap@321";
String message = "";
boolean isError = false;

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String treatment = request.getParameter("treatment");
		String price = request.getParameter("price");
		String notes = request.getParameter("notes");

		// Check if patient exists in the `patients` table
		String checkPatientSQL = "SELECT id FROM patients WHERE email = ?";
		pstmt = conn.prepareStatement(checkPatientSQL);
		pstmt.setString(1, email);
		ResultSet patientRs = pstmt.executeQuery();

		if (!patientRs.next()) {
	message = "Error: Patient does not exist. Please register the patient first.";
	isError = true;
		} else {
	String patientId = patientRs.getString("id");

	// Insert the medical history record
	String sql = "INSERT INTO medical_history (patient_name, patient_email, treatment, price, notes) VALUES (?, ?, ?, ?, ?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, name);
	pstmt.setString(2, email);
	pstmt.setString(3, treatment);
	pstmt.setString(4, price);
	pstmt.setString(5, notes);
	pstmt.executeUpdate();

	message = "Patient record added successfully!";
		}
		patientRs.close(); // Close the previous ResultSet
	}

	String fetchSQL = "SELECT m.patient_name, m.patient_email, m.treatment, m.price, m.notes, m.created_at FROM medical_history m ORDER BY m.created_at DESC;";
	pstmt = conn.prepareStatement(fetchSQL);
	rs = pstmt.executeQuery(); // Execute the query

} catch (Exception e) {
	message = "Error: Patient does not exist. Please register the patient first.";
	isError = true;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Medical History</title>
<%@ include file="links.jsp"%>
<link rel="stylesheet" type="text/css"
	href="../admin_css/patientrecord.css">
</head>
<body>
	<%@ include file="header.jsp"%>

	<div class="container">
		<div class="form-container">
			<h2 class="text-center mb-4">Add Patient Medical Record</h2>
			<form method="POST" class="needs-validation" novalidate>
				<div class="row">
					<!-- Left Section: Patient Details -->
					<div class="col-md-6">
						<div class="mb-3">
							<label class="form-label">Patient Name</label> <input type="text"
								class="form-control" name="name" pattern="^[A-Za-z\s]+$"
								title="Only alphabets and spaces allowed" required>
							<div class="invalid-feedback">Enter a valid name (Only
								letters and spaces).</div>
						</div>

						<div class="mb-3">
							<label class="form-label">Patient Email</label> <input
								type="email" class="form-control" name="email" required>
							<div class="invalid-feedback">Enter a valid email address.</div>
						</div>
					</div>

					<!-- Right Section: Treatment Details -->
					<div class="col-md-6">
						<div class="mb-3">
							<label class="form-label">Treatment Details</label> <input
								type="text" class="form-control" name="treatment" required>
							<div class="invalid-feedback">Please provide treatment
								details.</div>
						</div>

						<div class="mb-3">
							<label class="form-label">Charge </label> <input type="number"
								step="1" class="form-control" name="price" required>
							<div class="invalid-feedback">Enter a valid price.</div>
						</div>
					</div>
				</div>

				<!-- Full Width Notes Field -->
				<div class="mb-3">
					<label class="form-label">Additional Notes</label>
					<textarea class="form-control" name="notes"></textarea>
				</div>

				<div class="d-flex justify-content-center align-items-center">
					<button type="submit" class="btn btn-dark w-25">Save
						Record</button>
				</div>
			</form>
		</div>
	</div>

	<!-- Display message -->
	<div class="text-center mt-3">
		<%
		if (!message.isEmpty()) {
		%>
		<div
			style="font-size: 18px; font-weight: bold; color: <%=isError ? "red" : "#343A40"%>;">
			<%=message%>
		</div>
		<%
		}
		%>
	</div>

	<!-- Display Medical History Records -->
	<div class="container mt-5">
		<h3 class="text-center mb-3">Patient Medical Records</h3>
		<div class="table-responsive"
			style="max-height: 400px; overflow-y: auto;">
			<table class="table table-striped table-bordered text-center">
				<thead class="table-dark">
					<tr>
						<!-- 	<th>ID</th> -->
						<th>Patient Name</th>
						<th>Email</th>
						<th>Treatment</th>
						<th>Charge</th>
						<th>Notes</th>
						<th>Created At</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (rs != null) {
						while (rs.next()) {
					%>
					<tr>
						<%-- 		<td><%=rs.getInt("id")%></td> --%>
						<td><%=rs.getString("patient_name")%></td>
						<td><%=rs.getString("patient_email")%></td>
						<td><%=rs.getString("treatment")%></td>
						<td><%=rs.getBigDecimal("price")%></td>
						<td><%=rs.getString("notes") != null ? rs.getString("notes") : "-"%></td>
						<td><%=rs.getTimestamp("created_at")%></td>
					</tr>
					<%
					}
					} else {
					%>
					<tr>
						<td colspan="7">No records found.</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<script>
		// Bootstrap validation script
		(function() {
			'use strict';
			var forms = document.querySelectorAll('.needs-validation');

			Array.prototype.slice.call(forms).forEach(function(form) {
				form.addEventListener('submit', function(event) {
					if (!form.checkValidity()) {
						event.preventDefault();
						event.stopPropagation();
					}
					form.classList.add('was-validated');
				}, false);
			});
		})();
	</script>
</body>
</html>
