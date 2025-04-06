<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../user_css/navbar.css">
<link rel="stylesheet" type="text/css" href="../user_css/forall.css">
<link rel="stylesheet" type="text/css" href="../user_css/about.css">


</head>
<body>
	<%@ include file="links.jsp"%>

	<!-- Bootstrap Navbar Start -->
	<nav
		class="navbar navbar-expand-lg navbar-dark bg-info fixed-top shadow">
		<div class="container-fluid">
			<!-- Logo Section -->
			<h3 class="m-0 text-light d-flex align-items-center">

				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"
					style="width: 30px; height: 30px; fill: white;">
                <path
						d="M288 115L69.5 307.7c-1.6 1.5-3.7 2.1-5.5 3.4V496a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V311.1c-1.7-1.2-3.7-1.8-5.3-3.2zm96 261a8 8 0 0 1 -8 8h-56v56a8 8 0 0 1 -8 8h-48a8 8 0 0 1 -8-8v-56h-56a8 8 0 0 1 -8-8v-48a8 8 0 0 1 8-8h56v-56a8 8 0 0 1 8-8h48a8 8 0 0 1 8 8v56h56a8 8 0 0 1 8 8zm186.7-139.7l-255.9-226a39.9 39.9 0 0 0 -53.5 0l-256 226a16 16 0 0 0 -1.2 22.6L25.5 282.7a16 16 0 0 0 22.6 1.2L277.4 81.6a16 16 0 0 1 21.2 0L527.9 283.9a16 16 0 0 0 22.6-1.2l21.4-23.8a16 16 0 0 0 -1.2-22.6z" />
            </svg>
				<span class="ms-2" id="medical_home">EASY-DENT</span>
			</h3>

			<!-- Navbar Toggler -->
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- Navbar Content -->
			<div class="collapse navbar-collapse" id="navbarNav">
				<!-- Centered Navigation Links -->
				<ul class="navbar-nav mx-auto text-center" id="navbar-menu">
					<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="aboutus.jsp">About-Us</a></li>
					<li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
					<li class="nav-item"><a class="nav-link" href="booking.jsp">Book-Appointment</a></li>
					<li class="nav-item"><a class="nav-link" href="contactus.jsp">Contact-Us</a></li>

				</ul>

				<!-- User Actions (Icons Only with Hover Titles) -->
				<div class="d-flex align-items-center">
					<a href="user_profile.jsp"
						class="btn btn-outline-light btn-sm me-2" title="Profile"> <i
						class="fas fa-user-circle"></i>
					</a> <a href="user_login.jsp" class="btn btn-outline-light btn-sm me-2"
						title="Login"> <i class="fas fa-sign-in-alt"></i>
					</a> <a href="user_register.jsp" class="btn btn-outline-light btn-sm"
						title="Register"> <i class="fas fa-user-plus"></i>
					</a>
				</div>
			</div>
		</div>
	</nav>
	<!-- Bootstrap Navbar End -->


	<!-- ABOUT SECTION STARTS -->

	<div id="about">
		<div class="text-center mb-5" data-aos="fade-up">
			<i class="fa fa-user fs-1 text-info"></i>
			<h2>About Us</h2>
			<hr class="w-25 m-auto">
		</div>

		<div class="container my-4">
			<div
				class="row featurette d-flex justify-content-center align-items-center"
				data-aos="fade-left">
				<div class="col-md-6 order-md-2">
					<p class="lead" id="lead_abt">At Easy-Dent Dental Clinic, we
						are committed to providing **exceptional dental care** with a
						focus on patient comfort, safety, and long-term oral health.
						Established with a vision to redefine dentistry, we ensure that
						every patient receives the **highest standard of treatment** in a
						relaxed and friendly environment. Whether it's preventive care,
						cosmetic dentistry, or advanced procedures, our goal is to create
						healthy and confident smiles for life.</p>
				</div>
				<div class="col-md-6 order-md-1" id="lead_img">
					<img class="img-fluid mx-auto" src="img/ab1.jpg"
						alt="Dental Clinic" data-aos="zoom-in">
				</div>
			</div>

			<div
				class="row featurette d-flex justify-content-center align-items-center"
				data-aos="fade-right">
				<div class="col-md-6">
					<p class="lead" id="lead_abt">Our clinic is **equipped with
						state-of-the-art technology**, ensuring precise diagnosis and
						effective treatment. Our team consists of **highly skilled and
						experienced dentists** who follow strict sterilization protocols,
						ensuring a safe and hygienic environment for all our patients. We
						believe in **transparent communication**, educating our patients
						about their oral health, and offering the best treatment options
						tailored to their needs.</p>
				</div>
				<div class="col-md-6" id="lead_img">
					<img class="img-fluid mx-auto" src="img/ab2.jpg"
						alt="Advanced Equipment" data-aos="zoom-in">
				</div>
			</div>

			<div
				class="row featurette d-flex justify-content-center align-items-center"
				data-aos="fade-left">
				<div class="col-md-6 order-md-1">
					<p class="lead" id="lead_abt">At Easy-Dent, we believe in
						**ethical dental practices and patient-first care**. Our approach
						focuses on minimally invasive treatments, pain-free procedures,
						and the use of biocompatible materials. We aim to make every visit
						a comfortable experience, offering **personalized dental
						solutions** for families, individuals, and children alike.</p>
				</div>
				<div class="col-md-6" id="lead_img">
					<img class="img-fluid mx-auto" src="img/ab4.jpg" alt="Patient Care"
						data-aos="zoom-in">
				</div>
			</div>
		</div>
	</div>

	<!-- TRUST AND RESPECT -->
	<div class="text-center mb-5" data-aos="fade-up">
		<img src="img/values.png" width="70rem">
		<h2 class="ps-4 pt-2">Our Core Values</h2>
		<hr class="w-25 m-auto">
	</div>

	<div class="container" id="trust_ab">
		<div class="row">
			<div class="col-md-4" data-aos="fade-up">
				<div class="core-values trust">
					<h2 class="core-value-title">TRUST</h2>
					<hr>
					<ul class="core-value-list">
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Quality Treatment</li>
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Patient-Centered Care</li>
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Advanced Sterilization</li>
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Excellence in Service</li>
					</ul>
				</div>
			</div>

			<div class="col-md-4" data-aos="fade-up" id="for_mq">
				<div class="core-values respect">
					<h2 class="core-value-title">RESPECT</h2>
					<hr>
					<ul class="core-value-list">
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Patients First</li>
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Dedicated Team</li>
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Ethical Practices</li>
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Professionalism</li>
					</ul>
				</div>
			</div>

			<div class="col-md-4" data-aos="fade-up" id="for_mq">
				<div class="core-values integrity">
					<h2 class="core-value-title">INTEGRITY</h2>
					<hr>
					<ul class="core-value-list">
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Honesty</li>
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Transparency</li>
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Continuous Learning</li>
						<li class="core-value-item"><img src="img/tooth.png"
							width="20rem"> Commitment to Care</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- ABOUT SECTION ENDS -->



	<%@ include file="footer.jsp"%>
</body>
</html>

