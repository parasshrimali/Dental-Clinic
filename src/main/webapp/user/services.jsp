<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="../user_css/forall.css">
<link rel="stylesheet" type="text/css" href="../user_css/index.css">
<link rel="stylesheet" type="text/css" href="../user_css/navbar.css">

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



	<!-- SERVICES STARTS -->

	<section id="services" class="p-4"
		style="margin-top: 60px; padding-top: 100px;">
		<div class="text-center mb-5" data-aos="fade-up"
			data-aos-duration="1000">
			<i class="fa fa-user-md fs-1 text-primary"></i>
			<h2>What we Do!</h2>

		</div>
		<div class="container">
			<div class="row">



				<!-- SERVICE 1 STARTS -->
				<div class="col-sm-12 col-md-4 col-lg-4 col-12">
					<div class="card my-1" id="card-service">
						<div class="card-body" id="card-body-service">
							<img src="img/1.png" alt="Aligners & Braces" id="aligner">
							<h5 class="card-title fw-bold">ALIGNERS & BRACES</h5>
							<p class="card-text">Discover our range of aligners and
								braces, crafted to enhance your smile.</p>

							<!-- Button trigger modal -->
							<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#exampleModal1">
								View Details</button>

							<!-- Modal -->
							<div class="modal fade" id="exampleModal1" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-scrollable">
									<div class="modal-content"
										style="align-items: center; text-align: center;">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Aligners
												& Braces</h5>
										</div>
										<div class="modal-body">

											<!-- Inner card 1  -->
											<div class="card" style="width: 25rem;">
												<img src="img/braces.jpg" class="card-img-top"
													alt="Aligners">
												<div class="card-body">
													<h5 class="card-title">Clear Aligners</h5>
													<p class="card-text">Modern invisible aligners designed
														for comfort and a perfect smile.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Customized fit</li>
													<li class="list-group-item">Easy maintenance</li>
													<li class="list-group-item">No metal brackets</li>
													<li class="list-group-item"><b>Price: INR 1,500 -
															INR 4,000</b></li>
												</ul>
											</div>
											<br> <br>

											<!-- Inner card 2  -->
											<div class="card" style="width: 25rem;">
												<img src="img/metal_braces.jpg" class="card-img-top"
													alt="Braces">
												<div class="card-body">
													<h5 class="card-title">Traditional Braces</h5>
													<p class="card-text">Strong and effective braces to
														align your teeth for a lasting smile.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Durable and reliable</li>
													<li class="list-group-item">Suitable for all ages</li>
													<li class="list-group-item">Precise adjustments</li>
													<li class="list-group-item"><b>Price: INR 2,000 -
															INR 6,000</b></li>
												</ul>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>



				<!-- SERVICE 2 STARTS -->

				<div class="col-sm-12 col-md-4 col-lg-4 col-12">
					<div class="card my-2" id="card-service">
						<div class="card-body" id="card-body-service">
							<img src="img/2.png" alt="Root Canal" id="aligner">
							<h5 class="card-title">ROOT CANAL</h5>
							<p class="card-text">A safe and effective procedure to treat
								infections and save your natural tooth.</p>

							<!-- Button trigger modal -->
							<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#exampleModal2">
								View Details</button>

							<!-- Modal -->
							<div class="modal fade" id="exampleModal2" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-scrollable">
									<div class="modal-content"
										style="align-items: center; text-align: center;">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Root
												Canal Treatment</h5>
										</div>
										<div class="modal-body">

											<!-- Inner card 1  -->
											<div class="card" style="width: 25rem;">
												<img src="img/rootcanal2.jpg" class="card-img-top"
													alt="Root Canal Procedure">
												<div class="card-body">
													<h5 class="card-title">Procedure Overview</h5>
													<p class="card-text">Root canal treatment removes
														infection from the toothâ€™s pulp and restores it with a
														filling.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Pain relief & infection
														removal</li>
													<li class="list-group-item">Preserves natural tooth</li>
													<li class="list-group-item">Performed under anesthesia</li>
													<li class="list-group-item"><b>Price: INR 800 -
															INR 2,500</b></li>
												</ul>
											</div>
											<br> <br>

											<!-- Inner card 2  -->
											<div class="card" style="width: 25rem;">
												<img src="img/rootcanal1.jpg" class="card-img-top"
													alt="Post-Treatment Care">
												<div class="card-body">
													<h5 class="card-title">Aftercare & Recovery</h5>
													<p class="card-text">Post-treatment care includes
														temporary sensitivity and a follow-up for crown placement.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Mild discomfort for a few
														days</li>
													<li class="list-group-item">Avoid hard foods initially</li>
													<li class="list-group-item">Final crown placement
														needed</li>
													<li class="list-group-item"><b>Price (with Crown):
															INR 1,200 - INR 3,500</b></li>
												</ul>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


				<!-- SERVICE 3 STARTS -->

				<div class="col-sm-12 col-md-4 col-lg-4 col-12">
					<div class="card my-2" id="card-service">
						<div class="card-body" id="card-body-service">
							<img src="img/3.png" alt="Dental Fillings" id="aligner">
							<h5 class="card-title">DENTAL FILLINGS</h5>
							<p class="card-text">Restore your teeth with durable and
								natural-looking fillings for your teeth.</p>

							<!-- Button trigger modal -->
							<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#exampleModal">
								View Details</button>

							<!-- Modal -->
							<div class="modal fade" id="exampleModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-scrollable">
									<div class="modal-content"
										style="align-items: center; text-align: center;">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Dental
												Fillings</h5>
										</div>
										<div class="modal-body">

											<!-- Inner card 1  -->
											<div class="card" style="width: 25rem;">
												<img src="img/feeling1.jpg" class="card-img-top"
													alt="Dental Filling Procedure">
												<div class="card-body">
													<h5 class="card-title">Filling Procedure</h5>
													<p class="card-text">Dental fillings help repair
														cavities and restore tooth structure.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Cavity cleaning & filling</li>
													<li class="list-group-item">Composite, amalgam, or
														ceramic</li>
													<li class="list-group-item">Restores function &
														appearance</li>
													<li class="list-group-item"><b>Price: INR 100 -
															INR 500 per filling</b></li>
												</ul>
											</div>
											<br> <br>

											<!-- Inner card 2  -->
											<div class="card" style="width: 25rem;">
												<img src="img/feeling2.jpg" class="card-img-top"
													alt="Filling Material Options">
												<div class="card-body">
													<h5 class="card-title">Types of Fillings</h5>
													<p class="card-text">Choose from various filling
														materials based on durability and aesthetics.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Composite (Tooth-colored)</li>
													<li class="list-group-item">Amalgam (Silver-colored)</li>
													<li class="list-group-item">Ceramic (Porcelain-based)</li>
													<li class="list-group-item"><b>Price Range: INR
															150 - INR 700 per filling</b></li>
												</ul>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>



				<!-- SERVICES 4 STARTS -->

				<div class="col-sm-12 col-md-4 col-lg-4 col-12">
					<div class="card my-2" id="card-service">
						<div class="card-body" id="card-body-service">
							<img src="img/4.png" alt="Dental Crowns" id="aligner">
							<h5 class="card-title">DENTAL CROWNS</h5>
							<p class="card-text">Restore and protect your teeth with
								durable and natural-looking crowns.</p>

							<!-- Button trigger modal -->
							<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#exampleModal4">
								View Details</button>

							<!-- Modal -->
							<div class="modal fade" id="exampleModal4" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-scrollable">
									<div class="modal-content"
										style="align-items: center; text-align: center;">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Dental
												Crowns</h5>
										</div>
										<div class="modal-body">

											<!-- Inner card 1  -->
											<div class="card" style="width: 25rem;">
												<img src="img/crown1.jpg" class="card-img-top"
													alt="Dental Crown Procedure">
												<div class="card-body">
													<h5 class="card-title">Crown Procedure</h5>
													<p class="card-text">Dental crowns help restore tooth
														shape, strength, and function.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Crown placement & fitting</li>
													<li class="list-group-item">Metal, ceramic, or
														porcelain options</li>
													<li class="list-group-item">Protects weakened teeth</li>
													<li class="list-group-item"><b>Price: INR 2000 -
															INR 8000 per crown</b></li>
												</ul>
											</div>
											<br> <br>

											<!-- Inner card 2  -->
											<div class="card" style="width: 25rem;">
												<img src="img/crown2.jpg" class="card-img-top"
													alt="Crown Material Options">
												<div class="card-body">
													<h5 class="card-title">Types of Crowns</h5>
													<p class="card-text">Choose from various crown
														materials for durability and aesthetics.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Metal (Durable)</li>
													<li class="list-group-item">Porcelain
														(Natural-looking)</li>
													<li class="list-group-item">Ceramic (Best for front
														teeth)</li>
													<li class="list-group-item"><b>Price Range: INR
															3000 - INR 10000 per crown</b></li>
												</ul>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


				<!-- SERVICES 5 STARTS -->

				<div class="col-sm-12 col-md-4 col-lg-4 col-12">
					<div class="card my-2" id="card-service">
						<div class="card-body" id="card-body-service">
							<img src="img/5.png" alt="Dentures" id="aligner">
							<h5 class="card-title">DENTURES</h5>
							<p class="card-text">Restore your smile with comfortable and
								natural-looking dentures.</p>

							<!-- Button trigger modal -->
							<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#exampleModal5">
								View Details</button>

							<!-- Modal -->
							<div class="modal fade" id="exampleModal5" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-scrollable">
									<div class="modal-content"
										style="align-items: center; text-align: center;">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Dentures</h5>
										</div>
										<div class="modal-body">

											<!-- Inner card 1  -->
											<div class="card" style="width: 25rem;">
												<img src="img/dentures.jpg" class="card-img-top"
													alt="Dentures Procedure">
												<div class="card-body">
													<h5 class="card-title">Denture Procedure</h5>
													<p class="card-text">Dentures help replace missing
														teeth and restore oral function.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Full & partial denture
														options</li>
													<li class="list-group-item">Customized for a
														comfortable fit</li>
													<li class="list-group-item">Restores appearance &
														chewing ability</li>
													<li class="list-group-item"><b>Price: INR 5000 -
															INR 25000 per set</b></li>
												</ul>
											</div>
											<br> <br>

											<!-- Inner card 2  -->
											<div class="card" style="width: 25rem;">
												<img src="img/dentures2.jpg" class="card-img-top"
													alt="Denture Types">
												<div class="card-body">
													<h5 class="card-title">Types of Dentures</h5>
													<p class="card-text">Choose from a variety of denture
														types to suit your needs.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Complete Dentures</li>
													<li class="list-group-item">Partial Dentures</li>
													<li class="list-group-item">Implant-Supported Dentures</li>
													<li class="list-group-item"><b>Price Range: INR
															8000 - INR 30000 per set</b></li>
												</ul>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- SERVICES 6 STARTS -->

				<div class="col-sm-12 col-md-4 col-lg-4 col-12">
					<div class="card my-2" id="card-service">
						<div class="card-body" id="card-body-service">
							<img src="img/6.png" alt="Implants" id="aligner">
							<h5 class="card-title">IMPLANTS</h5>
							<p class="card-text">Permanent solutions for missing teeth
								with natural functionality without pain.</p>

							<!-- Button trigger modal -->
							<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#exampleModal6">
								View Details</button>

							<!-- Modal -->
							<div class="modal fade" id="exampleModal6" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-scrollable">
									<div class="modal-content"
										style="align-items: center; text-align: center;">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Implants</h5>
										</div>
										<div class="modal-body">

											<!-- Inner card 1  -->
											<div class="card" style="width: 25rem;">
												<img src="img/implant1.jpg" class="card-img-top"
													alt="Dental Implants">
												<div class="card-body">
													<h5 class="card-title">Dental Implants Procedure</h5>
													<p class="card-text">A permanent and sturdy replacement
														for missing teeth.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Single & multiple implants</li>
													<li class="list-group-item">Long-lasting & durable</li>
													<li class="list-group-item">Restores natural function
														& appearance</li>
													<li class="list-group-item"><b>Price: INR 25000 -
															INR 70000 per implant</b></li>
												</ul>
											</div>
											<br> <br>

											<!-- Inner card 2  -->
											<div class="card" style="width: 25rem;">
												<img src="img/implant2.jpg" class="card-img-top"
													alt="Types of Implants">
												<div class="card-body">
													<h5 class="card-title">Types of Implants</h5>
													<p class="card-text">Various implant options to suit
														individual needs.</p>
												</div>
												<ul class="list-group list-group-flush">
													<li class="list-group-item">Endosteal Implants</li>
													<li class="list-group-item">Subperiosteal Implants</li>
													<li class="list-group-item">All-on-4 Implants</li>
													<li class="list-group-item"><b>Price Range: INR
															30000 - INR 100000</b></li>
												</ul>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


				<!-- SERVICES SECTION -->
				<div class="container">
					<div class="row d-flex justify-content-center gap-3">
						<!-- SERVICE 7 -->
						<div class="col-sm-12 col-md-4">
							<div class="card my-2" id="card-service">
								<div class="card-body ">
									<!-- <img src="img/6.png" alt="Mouth Ulcers" id="aligner"> -->
									<i class="fas fa-grin-tongue pb-3"
										style="color: #472714; font-size: 50px;"></i>



									<h5 class="card-title">MOUTH ULCERS</h5>
									<p class="card-text">Effective treatments for painful mouth
										ulcers.</p>
									<button type="button" class="btn btn-primary"
										data-bs-toggle="modal" data-bs-target="#exampleModal7">
										View Details</button>

									<!-- Modal -->
									<div class="modal fade" id="exampleModal7" tabindex="-1"
										aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog modal-dialog-scrollable">
											<div class="modal-content"
												style="align-items: center; text-align: center;">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalLabel">Mouth
														Ulcers</h5>
												</div>
												<div class="modal-body">

													<!-- Inner card 1  -->
													<div class="card" style="width: 25rem;">
														<img src="img/ulcer1.jpg" class="card-img-top"
															alt="Mouth Ulcer Treatment">
														<div class="card-body">
															<h5 class="card-title">Ulcer Treatment</h5>
															<p class="card-text">Find relief with effective mouth
																ulcer treatments.</p>
														</div>
														<ul class="list-group list-group-flush">
															<li class="list-group-item">Topical ointments</li>
															<li class="list-group-item">Pain relief solutions</li>
															<li class="list-group-item">Oral hygiene
																recommendations</li>
															<li class="list-group-item"><b>Price: INR 500 -
																	INR 3000</b></li>
														</ul>
													</div>
													<br> <br>

													<!-- Inner card 2  -->
													<div class="card" style="width: 25rem;">
														<img src="img/ulcer2.jpg" class="card-img-top"
															alt="Ulcer Causes">
														<div class="card-body">
															<h5 class="card-title">Causes of Mouth Ulcers</h5>
															<p class="card-text">Understanding the causes to
																prevent future occurrences.</p>
														</div>
														<ul class="list-group list-group-flush">
															<li class="list-group-item">Nutritional deficiencies</li>
															<li class="list-group-item">Stress & lifestyle
																factors</li>
															<li class="list-group-item">Underlying medical
																conditions</li>
															<li class="list-group-item"><b>Consultation
																	Price: INR 500 - INR 1500</b></li>
														</ul>
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>


						<!-- SERVICES 8 STARTS -->

						<div class="col-sm-12 col-md-4 col-lg-4 col-12">
							<div class="card my-2" id="card-service">
								<div class="card-body" id="card-body-service">
									<!-- <img src="img/6.png" alt="Kids Dentistry" id="aligner"> -->
									<i class="fas fa-child pb-3"
										style="color: #472714; font-size: 50px;"></i>

									<h5 class="card-title">KIDS DENTISTRY</h5>
									<p class="card-text">Gentle and specialized dental care for
										children.</p>

									<!-- Button trigger modal -->
									<button type="button" class="btn btn-primary"
										data-bs-toggle="modal" data-bs-target="#exampleModal8">
										View Details</button>

									<!-- Modal -->
									<div class="modal fade" id="exampleModal8" tabindex="-1"
										aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog modal-dialog-scrollable">
											<div class="modal-content"
												style="align-items: center; text-align: center;">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalLabel">Kids
														Dentistry</h5>
												</div>
												<div class="modal-body">

													<!-- Inner card 1  -->
													<div class="card" style="width: 25rem;">
														<img src="img/kids1.jpg" class="card-img-top"
															alt="Kids Dental Care">
														<div class="card-body">
															<h5 class="card-title">Preventive Dental Care</h5>
															<p class="card-text">Early detection and preventive
																treatments for children's oral health.</p>
														</div>
														<ul class="list-group list-group-flush">
															<li class="list-group-item">Fluoride treatments</li>
															<li class="list-group-item">Dental sealants</li>
															<li class="list-group-item">Routine checkups</li>
															<li class="list-group-item"><b>Consultation
																	Price: INR 500 - INR 2000</b></li>
														</ul>
													</div>
													<br> <br>

													<!-- Inner card 2  -->
													<div class="card" style="width: 25rem;">
														<img src="img/kids2.jpg" class="card-img-top"
															alt="Pediatric Treatments">
														<div class="card-body">
															<h5 class="card-title">Pediatric Treatments</h5>
															<p class="card-text">Specialized dental treatments
																tailored for kids.</p>
														</div>
														<ul class="list-group list-group-flush">
															<li class="list-group-item">Cavity fillings</li>
															<li class="list-group-item">Space maintainers</li>
															<li class="list-group-item">Behavior management</li>
															<li class="list-group-item"><b>Price Range: INR
																	1000 - INR 5000</b></li>
														</ul>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- SERVICES ENDS -->
	<script type="text/javascript">
		//Disable AOS on small screens (less than 768px) and enable once animations
		if (window.innerWidth < 768) {
			AOS.init({
				disable : true
			});
		} else {
			AOS.init(); // Initialize AOS for larger screens with once animations
		}
	</script>


	<%@ include file="../user/footer.jsp"%>
</body>
</html>
