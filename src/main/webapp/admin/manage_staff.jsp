<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Random"%>
<%@ page import="jakarta.servlet.http.*"%>
<%@ page import="java.util.UUID"%>
<%@ page import="java.security.MessageDigest"%>

<%!// Method to generate a unique 4-character ID
	public String generateUniqueId(Connection con, String tableName) throws SQLException {
		String generatedId;
		boolean isUnique = false;

		do {
			generatedId = "";
			String characters = "0123456789abcdefghijklmnopqrstuvwxyz";
			for (int i = 0; i < 4; i++) {
				generatedId += characters.charAt((int) (Math.random() * characters.length()));
			}

			String query = "SELECT COUNT(*) FROM " + tableName + " WHERE staff_id = ?";
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
<title>Manage Staff</title>
<%@ include file="links.jsp"%>
<link rel="stylesheet" type="text/css"
	href="../admin_css/managestaff.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="container mt-5">
		<h1 class="text-center mb-4">Staff Management</h1>

		<!-- Add/Edit Staff Form -->
		<div class="card mb-4">
			<div class="card-header text-white"
				style="background-color: #6C757D;">Add / Edit Staff</div>
			<div class="card-body">
				<form method="post" onsubmit="return validateForm()">
					<input type="hidden" name="staffId" id="staffId">
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="fullName" class="form-label">Full Name</label> <input
								type="text" class="form-control" id="fullName" name="fullName"
								required>
						</div>
						<div class="col-md-6">
							<label for="role" class="form-label">Role</label> <input
								type="text" class="form-control" id="role" name="role" required>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="email" class="form-label">Email</label> <input
								type="email" class="form-control" id="email" name="email"
								required>
						</div>
						<div class="col-md-6">
							<label for="phoneNumber" class="form-label">Phone</label> <input
								type="tel" class="form-control" id="phoneNumber"
								name="phoneNumber" pattern="[0-9]{10}" required>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="gender" class="form-label">Gender</label> <select
								class="form-control" id="gender" name="gender" required>
								<option value="">Select Gender</option>
								<option value="Male">Male</option>
								<option value="Female">Female</option>
							<!-- 	<option value="Other">Other</option> -->
							</select>
						</div>
						<div class="col-md-6">
							<label for="dateOfJoining" class="form-label" id="dateofjoining">Date
								of Joining</label> <input type="date" class="form-control"
								id="dateOfJoining" name="dateOfJoining" required>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-12">
							<label for="address" class="form-label">Address</label>
							<textarea class="form-control" id="address" name="address"
								rows="3" required></textarea>
						</div>
					</div>
					<div class="text-end">
						<button type="submit" name="action" value="save"
							class="btn btn-success">Save</button>
						<button type="reset" class="btn btn-secondary ms-1">Reset</button>
					</div>
				</form>
			</div>
		</div>

		<!-- Staff Table -->
		<div class="card">
			<div class="card-header bg-secondary text-white">Staff List</div>
			<div class="card-body table-responsive">
				<table class="table table-bordered table-hover">
					<thead class="table-dark">
						<tr>
							<th>Staff ID</th>
							<th>Full Name</th>
							<th>Gender</th>
							<th>Phone</th>
							<th>Email</th>
							<th>Role</th>
							<th>Date of Joining</th>
							<th>Address</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						Connection con = null;
						PreparedStatement stmt = null;
						ResultSet rs = null;
						String message = "";
						String action = request.getParameter("action");

						try {
							Class.forName("com.mysql.cj.jdbc.Driver");
							con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dental", "root", "sarap@321");

							if ("save".equals(action)) {
								String id = request.getParameter("staffId");
								String fullName = request.getParameter("fullName");
								String gender = request.getParameter("gender");
								String phoneNumber = request.getParameter("phoneNumber");
								String email = request.getParameter("email");
								String address = request.getParameter("address");
								String role = request.getParameter("role");
								String dateOfJoining = request.getParameter("dateOfJoining");

								if (id == null || id.isEmpty()) {
							// Adding new staff
							String checkQuery = "SELECT COUNT(*) FROM staff_details WHERE phone_number = ? OR email = ?";
							stmt = con.prepareStatement(checkQuery);
							stmt.setString(1, phoneNumber);
							stmt.setString(2, email);
							ResultSet rsCheck = stmt.executeQuery();
							if (rsCheck.next() && rsCheck.getInt(1) > 0) {
								message = "Phone or email already exists!";
							} else {
								id = generateUniqueId(con, "staff_details");
								String insertQuery = "INSERT INTO staff_details (staff_id, full_name, gender, phone_number, email, address, role, date_of_joining) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
								stmt = con.prepareStatement(insertQuery);
								stmt.setString(1, id);
								stmt.setString(2, fullName);
								stmt.setString(3, gender);
								stmt.setString(4, phoneNumber);
								stmt.setString(5, email);
								stmt.setString(6, address);
								stmt.setString(7, role);
								stmt.setString(8, dateOfJoining);
								stmt.executeUpdate();
								message = "Staff added successfully with ID: " + id;
							}
								} else {
							// Updating existing staff
							String updateQuery = "UPDATE staff_details SET full_name = ?, gender = ?, phone_number = ?, email = ?, address = ?, role = ?, date_of_joining = ? WHERE staff_id = ?";
							stmt = con.prepareStatement(updateQuery);
							stmt.setString(1, fullName);
							stmt.setString(2, gender);
							stmt.setString(3, phoneNumber);
							stmt.setString(4, email);
							stmt.setString(5, address);
							stmt.setString(6, role);
							stmt.setString(7, dateOfJoining);
							stmt.setString(8, id);
							stmt.executeUpdate();
							message = "Staff updated successfully.";
								}
							} else if ("delete".equals(action)) {
								String id = request.getParameter("deleteId");
								if (id != null && !id.isEmpty()) {
							String deleteQuery = "DELETE FROM staff_details WHERE staff_id = ?";
							stmt = con.prepareStatement(deleteQuery);
							stmt.setString(1, id);
							stmt.executeUpdate();
							message = "Staff deleted successfully.";
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

						try {
							con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dental", "root", "sarap@321");
							String query = "SELECT * FROM staff_details";
							stmt = con.prepareStatement(query);
							rs = stmt.executeQuery();

							while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getString("staff_id")%></td>
							<td><%=rs.getString("full_name")%></td>
							<td><%=rs.getString("gender")%></td>
							<td><%=rs.getString("phone_number")%></td>
							<td><%=rs.getString("email")%></td>
							<td><%=rs.getString("role")%></td>
							<td><%=rs.getString("date_of_joining")%></td>
							<td><%=rs.getString("address")%></td>
							<td>
								<form method="post" class="d-inline">
									<button type="button"
										class="btn btn-warning btn-sm text-light px-3 ms-2"
										onclick="editStaff('<%=rs.getString("staff_id")%>', '<%=rs.getString("full_name")%>', '<%=rs.getString("gender")%>', '<%=rs.getString("phone_number")%>', '<%=rs.getString("email")%>', '<%=rs.getString("role")%>', '<%=rs.getDate("date_of_joining")%>', '<%=rs.getString("address")%>')">
										Edit</button>
									<input type="hidden" name="deleteId"
										value="<%=rs.getString("staff_id")%>">
									<button type="submit" name="action" value="delete"
										class="btn btn-danger btn-sm ms-2 mt-1" id="delete"
										onclick="return confirm('Are you sure you want to delete this staff member?')">Delete</button>
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
				<div class="alert alert-info" role="alert"><%=message%></div>
			</div>
		</div>
	</div>

	<script>
		// Form validation
		function validateForm() {
			var fullName = document.getElementById("fullName").value;
			var phoneNumber = document.getElementById("phoneNumber").value;
			var email = document.getElementById("email").value;

			var nameRegex = /^[A-Za-z\s]+$/;
			if (!nameRegex.test(fullName)) {
				alert("Please enter a valid name (only letters allowed).");
				return false;
			}

			if (phoneNumber.length !== 10) {
				alert("Phone number must be 10 digits.");
				return false;
			}

			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailRegex.test(email)) {
				alert("Please enter a valid email address.");
				return false;
			}

			return true;
		}

		// Populate form for editing
		function editStaff(id, fullName, gender, phoneNumber, email, role,
				dateOfJoining, address) {
			document.getElementById("staffId").value = id;
			document.getElementById("fullName").value = fullName;
			document.getElementById("gender").value = gender;
			document.getElementById("phoneNumber").value = phoneNumber;
			document.getElementById("email").value = email;
			document.getElementById("role").value = role;
			document.getElementById("dateOfJoining").value = dateOfJoining;
			document.getElementById("address").value = address;
		}
	</script>
</body>
</html>