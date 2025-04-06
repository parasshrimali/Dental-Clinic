<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.io.*, jakarta.servlet.http.*, java.util.UUID, java.security.MessageDigest"%>

<%!// Method to generate a unique 4-character ID
	public String generateUniqueId(Connection con, String doctors) throws SQLException {
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
			String query = "SELECT COUNT(*) FROM " + doctors + " WHERE id = ?";
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
<title>Manage Doctors</title>
<%@ include file="links.jsp"%>
<link rel="stylesheet" type="text/css"
	href="../admin_css/managedoctor.css">
</head>
<body style="z-index: -1;" id="body">
	<%@ include file="header.jsp"%>
	<div class="container mt-5">
		<h1 class="text-center mb-4">Doctor Management</h1>

		<!-- Add / Edit Doctor Form -->
		<div class="card mb-4">
			<div class="card-header text-white"
				style="background-color: #6C757D;">Add / Edit Doctor</div>
			<div class="card-body">
				<form method="post" action="manage_doctor.jsp"
					onsubmit="return validateForm()">
					<input type="hidden" name="doctorId" id="doctorId">

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="name" class="form-label">Doctor Name</label> <input
								type="text" class="form-control" id="name" name="name" required>
						</div>
						<div class="col-md-6">
							<label for="specialization" class="form-label">Specialization</label>
							<input type="text" class="form-control" id="specialization"
								name="specialization" required>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="email" class="form-label">Email</label> <input
								type="email" class="form-control" id="email" name="email"
								required>
						</div>
						<div class="col-md-6">
							<label for="phone" class="form-label">Phone</label> <input
								type="tel" class="form-control" id="phone" name="phone"
								pattern="[0-9]{10}" required>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="gender" class="form-label">Gender</label> <select
								class="form-control" id="gender" name="gender" required>
								<option value="">Select Gender</option>
								<option value="Male">Male</option>
								<option value="Female">Female</option>
							</select><br>
						</div>
						<div class="col-md-6">
							<label for="date_of_joining" class="form-label">Date of
								Joining</label> <input type="date" class="form-control"
								id="date_of_joining" name="date_of_joining" required>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-12">
							<label for="address" class="form-label">Address</label>
							<textarea class="form-control" id="address" name="address"
								rows="3" required></textarea>
						</div>
					</div>
					<div class="text-end ">
						<button type="submit" name="action" value="save"
							class="btn btn-success">Save</button>
						<button type="reset" class="btn btn-secondary ms-1">Reset</button>
					</div>
				</form>
			</div>
		</div>

		<br> <br>

		<!-- Doctor Table -->
		<div class="card">
			<div class="card-header bg-secondary text-white">Doctor List</div>
			<div class="card-body table-responsive">
				<table class="table table-bordered table-hover">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Specialization</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Gender</th>
							<th>Date of Joining</th>
							<th>Address</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						// Database code to fetch and manage doctors
						Connection con = null;
						PreparedStatement stmt = null;
						ResultSet rs = null;
						String message = "";
						String action = request.getParameter("action");

						try {
							Class.forName("com.mysql.cj.jdbc.Driver");
							con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dental", "root", "sarap@321");

							if ("save".equals(action)) {
								String id = request.getParameter("doctorId");

								String name = request.getParameter("name");
								String specialization = request.getParameter("specialization");
								String email = request.getParameter("email");
								String phone = request.getParameter("phone");
								String gender = request.getParameter("gender");
								String dateOfJoining = request.getParameter("date_of_joining");
								String address = request.getParameter("address");

								// Only check for phone or email uniqueness when adding a new doctor
								if (id == null || id.isEmpty()) {
							// Check if phone or email already exists for new doctor
							String checkQuery = "SELECT COUNT(*) FROM doctors WHERE phone = ? OR email = ?";
							stmt = con.prepareStatement(checkQuery);
							stmt.setString(1, phone);
							stmt.setString(2, email);
							ResultSet rsCheck = stmt.executeQuery();
							if (rsCheck.next() && rsCheck.getInt(1) > 0) {
								message = "Phone or email already exists!";
							} else {
								id = generateUniqueId(con, "doctors");
								String insertQuery = "INSERT INTO doctors (id, name, specialization, email, phone, gender, date_of_joining, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
								stmt = con.prepareStatement(insertQuery);
								stmt.setString(1, id);
								stmt.setString(2, name);
								stmt.setString(3, specialization);
								stmt.setString(4, email);
								stmt.setString(5, phone);
								stmt.setString(6, gender);
								stmt.setString(7, dateOfJoining);
								stmt.setString(8, address);
								stmt.executeUpdate();
								message = "Doctor added successfully with ID: " + id;
							}
								} else {
							// Update the existing doctor (no need to check for phone/email again)
							String updateQuery = "UPDATE doctors SET name = ?, specialization = ?, email = ?, phone = ?, gender = ?, date_of_joining = ?, address = ? WHERE id = ?";
							stmt = con.prepareStatement(updateQuery);
							stmt.setString(1, name);
							stmt.setString(2, specialization);
							stmt.setString(3, email);
							stmt.setString(4, phone);
							stmt.setString(5, gender);
							stmt.setString(6, dateOfJoining);
							stmt.setString(7, address);
							stmt.setString(8, id);
							stmt.executeUpdate();
							message = "Doctor updated successfully.";
								}
							} else if ("delete".equals(action)) {
								String id = request.getParameter("deleteId");
								if (id != null && !id.isEmpty()) {
							String deleteQuery = "DELETE FROM doctors WHERE id = ?";
							stmt = con.prepareStatement(deleteQuery);
							stmt.setString(1, id);
							stmt.executeUpdate();
							message = "Doctor deleted successfully.";
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

						// Display doctors
						try {
							Class.forName("com.mysql.cj.jdbc.Driver");
							con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dental", "root", "sarap@321");
							String query = "SELECT * FROM doctors";
							stmt = con.prepareStatement(query);
							rs = stmt.executeQuery();

							while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getString("id")%></td>
							<td><%=rs.getString("name")%></td>
							<td><%=rs.getString("specialization")%></td>
							<td><%=rs.getString("email")%></td>
							<td><%=rs.getString("phone")%></td>
							<td><%=rs.getString("gender")%></td>
							<td><%=rs.getDate("date_of_joining")%></td>
							<td><%=rs.getString("address")%></td>
							<td>
								<form method="post" class="d-inline">
									<button type="button"
										class="btn btn-warning btn-sm text-light px-3 ms-2"
										id="edit_btn"
										onclick="editDoctor('<%=rs.getString("id")%>', '<%=rs.getString("name")%>', '<%=rs.getString("specialization")%>', '<%=rs.getString("email")%>', '<%=rs.getString("phone")%>', '<%=rs.getString("gender")%>', '<%=rs.getDate("date_of_joining")%>', '<%=rs.getString("address")%>')">Edit</button>
									<br> <input type="hidden" name="deleteId"
										value="<%=rs.getString("id")%>">
									<button type="submit" name="action" value="delete"
										class="btn btn-danger btn-sm"
										onclick="return confirm('Are you sure you want to delete this doctor?')"
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

		function editDoctor(id, name, specialization, email, phone, gender,
				date_of_joining, address) {
			document.getElementById("doctorId").value = id; // This must be set for update
			document.getElementById("name").value = name;
			document.getElementById("specialization").value = specialization;
			document.getElementById("email").value = email;
			document.getElementById("phone").value = phone;
			document.getElementById("gender").value = gender;

			// Ensure the date format is YYYY-MM-DD
			let formattedDate = new Date(date_of_joining).toISOString().split(
					'T')[0];
			document.getElementById("date_of_joining").value = formattedDate;

			document.getElementById("address").value = address;
		}
	</script>

</body>
</html>