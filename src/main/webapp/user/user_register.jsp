<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.io.*, jakarta.servlet.http.*, java.util.UUID, java.security.MessageDigest"%>
<%@ page import="java.util.List, java.util.Arrays"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Registration</title>
<link rel="stylesheet" type="text/css" href="../user_css/forall.css">
<link rel="stylesheet" type="text/css"
	href="../user_css/userregister.css">
<%@ include file="links.jsp"%>

<style type="text/css">
@charset "UTF-8";

body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background: url('dental-care-arrangement.jpg') no-repeat center center;
	background-size: cover;
	background-attachment: fixed;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

.card {
	width: 50rem;
	padding: 30px;
	background: rgba(255, 255, 255, 0.2);
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-label {
	color: #343A40;
}

.form-control {
	background: rgba(255, 255, 255, 0.8);
	border: none;
}

.form-control:focus {
	box-shadow: 0 0 5px rgba(255, 255, 255, 0.8);
	outline: none;
}

button {
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 10px;
	cursor: pointer;
}

button:hover {
	background-color: #0056b3;
}

#emailAlert, #phoneAlert, #passwordAlert {
	color: red;
}

#nameAlert {
	color: red;
}

@media ( max-width : 768px) {
	.card {
		padding: 20px;
		width: 25rem;
		margin-top: 100px;
	}
	.form-label {
		font-size: 0.9rem;
	}
	#recoveryquestion {
		padding-top: 15px;
	}
}

@media ( max-width : 386px) {
	.card {
		width: 75%;
		padding: 15px;
		margin-left: 40px;
	}
	.form-label {
		font-size: 0.8rem;
	}
	.form-control {
		font-size: 0.9rem;
	}
	#nameAlert, #emailAlert, #phoneAlert, #passwordAlert {
		font-size: 0.8rem;
	}
	button {
		padding: 8px;
		font-size: 0.9rem;
	}
}
</style>
</head>
<body>

	<div class="card-container">
		<div class="card shadow-lg">
			<h2 class="text-center mb-4">Register users</h2>
			<form id="registrationForm" method="post" class="needs-validation"
				novalidate>
				<input type="hidden" name="id" id="id">

				<div class="row mb-3">
					<div class="col-md-6" data-aos="fade-right" data-aos-delay="400">
						<label for="name" class="form-label">Name</label> <input
							type="text" class="form-control" id="name" name="name"
							pattern="[A-Za-z\s]+"
							title="Name can only contain alphabets and spaces." required>
						<div class="invalid-feedback">Please enter a valid name.</div>
					</div>
					<div class="col-md-6" data-aos="fade-left" data-aos-delay="500">
						<label for="email" class="form-label">Email</label> <input
							type="email" class="form-control" id="email" name="email"
							pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
						<div class="invalid-feedback">Please enter a valid email
							address.</div>
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-md-6" data-aos="fade-right" data-aos-delay="600">
						<label for="phone" class="form-label">Phone</label> <input
							type="tel" class="form-control" id="phone" name="phone"
							pattern="\d{10}" title="Phone number must be exactly 10 digits."
							required>
						<div class="invalid-feedback">Please enter a valid 10-digit
							phone number.</div>
					</div>
					<div class="col-md-6" data-aos="fade-left" data-aos-delay="700">
						<label for="password" class="form-label">Password</label> <input
							type="password" class="form-control" id="password"
							name="password"
							pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$"
							title="Password must be at least 8 characters long, contain one uppercase letter, one lowercase letter, one number, and one special character."
							required>
						<div class="invalid-feedback">Please enter a strong
							password.</div>
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-md-6" data-aos="fade-right" data-aos-delay="800">
						<label for="confirm_password" class="form-label">Confirm
							Password</label> <input type="password" class="form-control"
							id="confirm_password" name="confirm_password" required>
						<div class="invalid-feedback">Passwords do not match.</div>
					</div>
					<div class="col-md-6" data-aos="fade-left" data-aos-delay="900">
						<label for="recovery_question" class="form-label">Recovery
							Question</label> <select class="form-control" id="recovery_question"
							name="recovery_question" required>
							<option value="">Select a question</option>
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
				</div>

				<div class="mb-3" data-aos="fade-up" data-aos-delay="1000">
					<label for="recovery_answer" class="form-label">Answer to
						Recovery Question</label> <input type="text" class="form-control"
						id="recovery_answer" name="recovery_answer" required>
					<div class="invalid-feedback">Please provide an answer to the
						recovery question.</div>
				</div>

				<button type="submit" class="btn btn-dark w-100" >Register</button>
				<p class="text-center mt-3">
					Already Registered ? <a href="user_login.jsp"
						style="color: #353B4D">Login</a>
				</p>
			</form>
		</div>
	</div>





	<!-- Modal for Alerts Of Registeration Status -->

	<div class="modal fade" id="alertModal" tabindex="-1"
		aria-labelledby="alertModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="alertModalLabel">Registration
						Status</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="modalMessage">
					<!-- Dynamic message will be inserted here -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<%
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String dbUrl = "jdbc:mysql://localhost:3306/dental";
		String dbUser = "root";
		String dbPassword = "sarap@321";

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String recovery_question = request.getParameter("recovery_question");
		String recovery_answer = request.getParameter("recovery_answer");

		String modalMessage = ""; // Message to be shown in the modal

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] hashedPasswordBytes = md.digest(password.getBytes("UTF-8"));
			StringBuilder sb = new StringBuilder();
			for (byte b : hashedPasswordBytes) {
		sb.append(String.format("%02x", b));
			}
			String hashedPassword = sb.toString();

			String checkQuery = "SELECT * FROM users WHERE email = ? OR phone = ? OR name = ?";
			ps = con.prepareStatement(checkQuery);
			ps.setString(1, email);
			ps.setString(2, phone);
			ps.setString(3, name);
			rs = ps.executeQuery();

			if (rs.next()) {
		if (rs.getString("email").equals(email)) {
			modalMessage = "The email address already exists.";
		} else if (rs.getString("phone").equals(phone)) {
			modalMessage = "The phone number is already registered.";
		} else if (rs.getString("name").equals(name)) {
			modalMessage = "The name is already in use.";
		}
			} else {
		String insertQuery = "INSERT INTO users (id, name, password, email, phone, recovery_question, recovery_answer) VALUES (?, ?, ?, ?, ?, ?, ?)";
		ps = con.prepareStatement(insertQuery);
		String uniqueId = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 4);

		ps.setString(1, uniqueId);
		ps.setString(2, name);
		ps.setString(3, hashedPassword);
		ps.setString(4, email);
		ps.setString(5, phone);
		ps.setString(6, recovery_question);
		ps.setString(7, recovery_answer);

		int rowsAffected = ps.executeUpdate();
		modalMessage = rowsAffected > 0 ? "Registration successful!" : "Registration failed. Please try again.";
			}
		} catch (Exception e) {
			e.printStackTrace();
			modalMessage = "An error occurred during registration.";
		} finally {
			try {
		if (rs != null)
			rs.close();
		if (ps != null)
			ps.close();
		if (con != null)
			con.close();
			} catch (SQLException e) {
		e.printStackTrace();
			}
		}
		request.setAttribute("modalMessage", modalMessage);
	}
	%>

	<%
	// Retrieve the modal message set during form submission
	String modalMessage = (String) request.getAttribute("modalMessage");
	if (modalMessage == null) {
		modalMessage = ""; // Default value
	}
	%>

	<script>
    document.addEventListener("DOMContentLoaded", function () {
        const message = "<%=modalMessage%>";
			if (message.trim()) {
				console.log("Modal Message:", message); // Debugging
				document.getElementById("modalMessage").textContent = message;
				const modal = new bootstrap.Modal(document
						.getElementById('alertModal'));
				modal.show();
			}
		});
	</script>




	<script>
    // Bootstrap validation script
    (function () {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')

        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                const password = document.getElementById("password").value;
                const confirmPassword = document.getElementById("confirm_password").value;

                if (!form.checkValidity() || password !== confirmPassword) {
                    event.preventDefault();
                    event.stopPropagation();

                    if (password !== confirmPassword) {
                        document.getElementById("confirm_password").setCustomValidity("Passwords do not match.");
                    } else {
                        document.getElementById("confirm_password").setCustomValidity("");
                    }
                }

                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>

</body>
</html>



