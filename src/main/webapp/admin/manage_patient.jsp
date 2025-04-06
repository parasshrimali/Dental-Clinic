<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.io.*, jakarta.servlet.http.*, java.util.UUID, java.security.MessageDigest"%>

<%!// Method to generate a unique 4-character ID
	public String generateUniqueId(Connection con, String patients) throws SQLException {
		String generatedId;
		boolean isUnique = false;

		do {
			// Generate a random 4-character alphanumeric ID
			generatedId = "";
			String characters = "0123456789abcdefghijklmnopqrstuvwxyz";
			for (int i = 0; i < 4; i++) {
				generatedId += characters.charAt((int) (Math.random() * characters.length()));
			}

			// Check if the ID already exists in the specified table
			String query = "SELECT COUNT(*) FROM " + patients + " WHERE id = ?";
			try (PreparedStatement stmt = con.prepareStatement(query)) {
				stmt.setString(1, generatedId);
				try (ResultSet rs = stmt.executeQuery()) {
					if (rs.next() && rs.getInt(1) == 0) {
						isUnique = true;
					}
				}
			}
		} while (!isUnique);

		return generatedId;
	}%>

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
<title>Manage Patients</title>
<%@ include file="links.jsp"%>
<link rel="stylesheet" type="text/css"
	href="../admin_css/managepatient.css">
</head>
<body style="z-index: -1;">
	<%@ include file="header.jsp"%>
	<div class="container mt-5">
		<h1 class="text-center mb-4">Patient Management</h1>

		<!-- Add / Edit Patient Form -->
		<div class="card mb-4">
			<div class="card-header text-white"
				style="background-color: #6C757D;">Add / Edit Patient</div>
			<div class="card-body">
				<form method="post" onsubmit="return validateForm()">
					<input type="hidden" name="patientId" id="patientId">

					<!-- Name and Email -->
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="name" class="form-label">Patient Name</label> <input
								type="text" class="form-control" id="name" name="name" required>
						</div>
						<div class="col-md-6">
							<label for="email" class="form-label">Email</label> <input
								type="email" class="form-control" id="email" name="email"
								required>
						</div>
					</div>

					<!-- Phone and Gender -->
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="gender" class="form-label">Gender</label> <select
								class="form-control" id="gender" name="gender" required>
								<option value="">Select Gender</option>
								<option value="Male">Male</option>
								<option value="Female">Female</option>
							</select>
						</div>
						<div class="col-md-6">
							<label for="age" class="form-label">Age</label> <input
								type="number" class="form-control" id="age" name="age" min="1"
								max="120" required>
						</div>

					</div>

					<!-- Address and Age -->
					<div class="row mb-3">

						<div class="col-md-6">
							<label for="phone" class="form-label">Phone</label> <input
								type="tel" class="form-control" id="phone" name="phone"
								pattern="[0-9]{10}" required>
						</div>
						<div class="col-md-6">
							<label for="address" class="form-label">Address</label> <input
								type="text" class="form-control" id="address" name="address"
								required>
						</div>

					</div>

					<!-- Buttons -->
					<div class="text-end">
						<button type="submit" name="action" value="save"
							class="btn btn-success">Save</button>
						<button type="reset" class="btn btn-secondary ms-1">Reset</button>
					</div>
				</form>

			</div>
		</div>

		<br> <br>

		<!-- Patient Table -->
		<div class="card">
			<div class="card-header bg-secondary text-white">Patient List</div>
			<div class="card-body table-responsive">
				<table class="table table-bordered table-hover">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Age</th>
							<th>Gender</th>
							<th>Address</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						// Database code to fetch and manage patients
						Connection con = null;
						PreparedStatement stmt = null;
						ResultSet rs = null;
						String message = "";
						String action = request.getParameter("action");

						try {
							Class.forName("com.mysql.cj.jdbc.Driver");
							con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dental", "root", "sarap@321");

							if ("save".equals(action)) {
								String id = request.getParameter("patientId");
								String name = request.getParameter("name");
								String email = request.getParameter("email");
								String phone = request.getParameter("phone");
								String gender = request.getParameter("gender");
								String address = request.getParameter("address");
								String age = request.getParameter("age");

								// Only check for phone or email uniqueness when adding a new patient
								if (id == null || id.isEmpty()) {
							// Check if phone or email already exists for new patient
							String checkQuery = "SELECT COUNT(*) FROM patients WHERE phone = ? OR email = ?";
							stmt = con.prepareStatement(checkQuery);
							stmt.setString(1, phone);
							stmt.setString(2, email);
							ResultSet rsCheck = stmt.executeQuery();
							if (rsCheck.next() && rsCheck.getInt(1) > 0) {
								message = "Phone or email already exists!";
							} else {
								id = generateUniqueId(con, "patients");
								String insertQuery = "INSERT INTO patients (id, name, email, phone, gender, address, age) VALUES (?, ?, ?, ?, ?, ?, ?)";
								stmt = con.prepareStatement(insertQuery);
								stmt.setString(1, id);
								stmt.setString(2, name);
								stmt.setString(3, email);
								stmt.setString(4, phone);
								stmt.setString(5, gender);
								stmt.setString(6, address);
								stmt.setString(7, age);
								stmt.executeUpdate();
								message = "Patient added successfully with ID: " + id;
							}
								} else {
							// Update the existing patient (no need to check for phone/email again)
							String updateQuery = "UPDATE patients SET name = ?, email = ?, phone = ?, gender = ?, address = ?, age	 = ? WHERE id = ?";
							stmt = con.prepareStatement(updateQuery);
							stmt.setString(1, name);
							stmt.setString(2, email);
							stmt.setString(3, phone);
							stmt.setString(4, gender);
							stmt.setString(5, address);
							stmt.setString(6, age);
							stmt.setString(7, id);
							stmt.executeUpdate();
							message = "Patient updated successfully.";
								}
							} else if ("delete".equals(action)) {
								String id = request.getParameter("deleteId");
								if (id != null && !id.isEmpty()) {
							String deleteQuery = "DELETE FROM patients WHERE id = ?";
							stmt = con.prepareStatement(deleteQuery);
							stmt.setString(1, id);
							stmt.executeUpdate();
							message = "Patient deleted successfully.";
								}
							}
						} catch (Exception e) {
							e.printStackTrace();
						} finally {
							if (stmt != null)
								stmt.close();
							if (con != null)
								con.close();
						}

						// Display patients
						try {
							Class.forName("com.mysql.cj.jdbc.Driver");
							con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dental", "root", "sarap@321");
							String query = "SELECT * FROM patients";
							stmt = con.prepareStatement(query);
							rs = stmt.executeQuery();

							while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getString("id")%></td>
							<td><%=rs.getString("name")%></td>
							<td><%=rs.getString("email")%></td>
							<td><%=rs.getString("phone")%></td>
							<td><%=rs.getString("age")%></td>
							<td><%=rs.getString("gender")%></td>
							<td><%=rs.getString("address")%></td>

							<td>
								<form method="post" class="d-inline">
									<button type="button"
										class="btn btn-warning btn-sm text-light px-3 ms-2"
										id="edit_btn"
										onclick="editPatient('<%=rs.getString("id")%>', '<%=rs.getString("name")%>', '<%=rs.getString("email")%>', '<%=rs.getString("phone")%>', '<%=rs.getString("gender")%>', '<%=rs.getString("address")%>', '<%=rs.getString("age")%>')">Edit</button>
									<input type="hidden" name="deleteId"
										value="<%=rs.getString("id")%>">
									<button type="submit" name="action" value="delete"
										class="btn btn-danger btn-sm"
										onclick="return confirm('Are you sure you want to delete this patient?')"
										id="delete_btn">Delete</button>
								</form>
							</td>
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
				<div class="alert alert-info" role="alert">
					<%=message%>
				</div>
			</div>
		</div>
	</div>

	<script>
		// Form validation function
		function validateForm() {
			var name = document.getElementById("name").value;
			var phone = document.getElementById("phone").value;
			var email = document.getElementById("email").value;

			// Validate name (only letters and spaces allowed)
			var nameRegex = /^[A-Za-z\s]+$/;
			if (!nameRegex.test(name)) {
				alert("Please enter a valid name (only letters allowed).");
				return false;
			}

			// Validate phone (should be 10 digits)
			if (phone.length !== 10) {
				alert("Phone number must be 10 digits.");
				return false;
			}

			// Validate email format
			var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
			if (!emailRegex.test(email)) {
				alert("Please enter a valid email address.");
				return false;
			}

			return true;
		}

		// Edit patient function
		function editPatient(id, name, email, phone, gender, address, age) {
			document.getElementById("patientId").value = id;
			document.getElementById("name").value = name;
			document.getElementById("email").value = email;
			document.getElementById("phone").value = phone;
			document.getElementById("gender").value = gender;
			document.getElementById("address").value = address;
			document.getElementById("age").value = age;
		}
	</script>

</body>
</html>