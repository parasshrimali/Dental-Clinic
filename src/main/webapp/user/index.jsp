<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="../user_css/index.css">
<link rel="stylesheet" type="text/css" href="../user_css/navbar.css">
<link rel="stylesheet" type="text/css" href="../user_css/doctor.css">

<style>
html, body {
	overflow: -moz-scrollbars-none;
	-ms-overflow-style: none;
	scrollbar-width: none;
}

html::-webkit-scrollbar, body::-webkit-scrollbar {
	display: none;
}

.counter-box {
	background: rgba(255, 255, 255, 0.1);
	padding: 20px;
	border-radius: 10px;
	transition: 0.3s ease-in-out;
	color: black;
}

.counter-box:hover {
	background: rgba(255, 255, 255, 0.3);
}

#i {
	color: #17A2B8;
}

h5 {
	margin-top: 10px;
	font-weight: bold;
}
</style>



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

	<!-- INFO SECTION START -->

	<div class="container" id="info">
		<div class="row px-2">
			<!-- Carousel Section -->
			<div class="col-sm-12 col-md-6 col-lg-6 col-12" data-aos="zoom-out"
				data-aos-duration="1000" data-aos-once="true">
				<div id="carouselExampleControls" class="carousel slide pt-5"
					data-bs-ride="carousel">
					<div class="carousel-inner">
						<!-- First Carousel Item -->
						<div class="carousel-item active">
							<h1 class="display-4">
								Your Smile is Our Priority <span class="text-danger">Teeth</span>
							</h1>
							<p class="lead">We provide expert dental care for your teeth,
								ensuring a healthy and bright smile. Trust us with all your oral
								health needs, from routine check-ups to specialized treatments.</p>
							<a href="booking.jsp"
								class="btn btn-info btn-md rounded-pill shadow-sm text-white">Book
								an Appointment</a>
						</div>
						<!-- Second Carousel Item -->
						<div class="carousel-item">
							<h1 class="display-4">
								A Healthy <span class="text-danger">Mouth</span> Starts Here
							</h1>
							<p class="lead">Your mouth is the gateway to overall health.
								We offer comprehensive dental services to maintain and improve
								your oral health, ensuring a confident and happy smile.</p>
							<a href="booking.jsp"
								class="btn btn-danger btn-md rounded-pill shadow-sm text-white">Schedule
								a Consultation</a>
						</div>
						<!-- Third Carousel Item -->
						<div class="carousel-item">
							<h1 class="display-4">
								Brighten Your <span class="text-danger">Future</span> with a
								Healthy Smile
							</h1>
							<p class="lead">Let us guide you to a bright future with a
								healthy smile. Our team is dedicated to providing top-notch care
								that sets you up for a lifetime of excellent dental health.</p>
							<a href="booking.jsp"
								class="btn btn-info btn-md rounded-pill shadow-sm text-white">Start
								Your Journey</a>

						</div>
					</div>

					<!-- Carousel Controls -->
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>

			<!-- Image Section -->
			<div class="col-sm-12 col-md-6 col-lg-6 col-12" data-aos="zoom-in"
				data-aos-duration="1000" data-aos-once="true">
				<img src="img/index1.png" alt="Dental Care"
					class="img-fluid rounded">
			</div>
		</div>
	</div>
	<!-- INFO SECTION ENDS -->




	<!-- Dental Care Start -->
	<div class="container-fluid py-5">
		<div class="container">
			<div class="row gx-5">
				<div class="col-lg-5 mb-5 mb-lg-0" style="min-height: 500px;"
					data-aos="fade-right" data-aos-duration="1000" data-aos-once="true">
					<div class="position-relative h-100">
						<img class="position-absolute w-100 h-100 rounded"
							data-aos-once="true" src="img/index2.jpg"
							style="object-fit: cover;">
					</div>
				</div>
				<div class="col-lg-7" data-aos="fade-left" data-aos-duration="1000"
					data-aos-once="true">
					<div class="mb-4">
						<!-- <h5
							class="d-inline-block text-primary text-uppercase border-bottom border-5">Dental
							Care</h5> -->
						<h1 class="display-5">
							Comprehensive <br> Dental Care For You and Your Family
						</h1>
					</div>
					<p>Tempor erat elitr at rebum at at clita aliquyam consetetur.
						Diam dolor diam ipsum et, tempor voluptua sit consetetur sit.
						Aliquyam diam amet diam et eos sadipscing labore. Clita erat ipsum
						et lorem et sit, sed stet no labore lorem sit. Sanctus clita duo
						justo et tempor consetetur takimata eirmod, dolores takimata
						consetetur invidunt magna dolores aliquyam dolores dolore. Amet
						erat amet et magna</p>
					<div class="row g-3 pt-3">
						<div class="col-sm-3 col-6" data-aos="zoom-in">
							<div class="bg-light text-center rounded-circle py-4">
								<i class="fa fa-3x fa-tooth text-primary mb-3"></i>
								<h6 class="mb-0">
									Expert<small class="d-block text-primary">Dentists</small>
								</h6>
							</div>
						</div>
						<div class="col-sm-3 col-6" data-aos="zoom-in">
							<div class="bg-light text-center rounded-circle py-4">
								<i class="fa fa-3x fa-smile text-primary mb-3"></i>
								<h6 class="mb-0">
									Painless<small class="d-block text-primary">Treatments</small>
								</h6>
							</div>
						</div>
						<div class="col-sm-3 col-6" data-aos="zoom-in">
							<div class="bg-light text-center rounded-circle py-4">
								<i class="fa fa-3x fa-x-ray text-primary mb-3"></i>
								<h6 class="mb-0">
									Advanced<small class="d-block text-primary">Technology</small>
								</h6>
							</div>
						</div>
						<div class="col-sm-3 col-6" data-aos="zoom-in">
							<div class="bg-light text-center rounded-circle py-4">
								<i class="fa fa-3x fa-headset text-primary mb-3"></i>
								<h6 class="mb-0">
									24/7<small class="d-block text-primary">Support</small>
								</h6>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- Dental Care End -->

	<!-- DETAILS ABOUT DOCTORS -->

	<div class="text-center mb-" style="padding-top: 5rem;"
		data-aos="fade-up">
		<i class="fa fa-user-md fs-1 text-primary"></i>
		<h2>Our Experienced Doctors</h2>
		<hr class="w-25 m-auto">
	</div>

	<div class="container mt-5">
		<div class="row">
			<div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
				<div class="doctor-card">
					<img src="img/dr5.jpg" alt="Doctor 1" class="doctor-image">
					<div class="doctor-info">
						<h3 class="doctor-name">Dr. John Doe</h3>
						<p class="doctor-specialty">Cosmetic Dentist</p>
						<p class="doctor-details">
							DDS, BDS <br> 15+ Years of Experience
						</p>
						<div class="doctor-icons">
							<i class="fab fa-facebook-f doctor-icon"></i> <i
								class="fab fa-twitter doctor-icon"></i> <i
								class="fab fa-instagram doctor-icon"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
				<div class="doctor-card">
					<img src="img/dr3.jpg" alt="Doctor 2" class="doctor-image">
					<div class="doctor-info">
						<h3 class="doctor-name">Dr. Jane Smith</h3>
						<p class="doctor-specialty">Orthodontist</p>
						<p class="doctor-details">
							MDS (Orthodontics), BDS <br> 10+ Years of Experience
						</p>
						<div class="doctor-icons">
							<i class="fab fa-facebook-f doctor-icon"></i> <i
								class="fab fa-twitter doctor-icon"></i> <i
								class="fab fa-instagram doctor-icon"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
				<div class="doctor-card">
					<img src="img/dr4.jpg" alt="Doctor 3" class="doctor-image">
					<div class="doctor-info">
						<h3 class="doctor-name">Dr. Rhana Lee</h3>
						<p class="doctor-specialty">Oral Surgeon</p>
						<p class="doctor-details">
							MDS (Oral & Maxillofacial Surgery), BDS <br> 8+ Years of
							Experience
						</p>
						<div class="doctor-icons">
							<i class="fab fa-facebook-f doctor-icon"></i> <i
								class="fab fa-twitter doctor-icon"></i> <i
								class="fab fa-instagram doctor-icon"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4" data-aos="fade-up" data-aos-delay="400">
				<div class="doctor-card">
					<img src="img/dr1.jpg" alt="Doctor 4" class="doctor-image">
					<div class="doctor-info">
						<h3 class="doctor-name">Dr. Sarah Jones</h3>
						<p class="doctor-specialty">Pediatric Dentist</p>
						<p class="doctor-details">
							Pediatric Dentistry, BDS <br> 12+ Years of Experience
						</p>
						<div class="doctor-icons">
							<i class="fab fa-facebook-f doctor-icon"></i> <i
								class="fab fa-twitter doctor-icon"></i> <i
								class="fab fa-instagram doctor-icon"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4" data-aos="fade-up" data-aos-delay="500">
				<div class="doctor-card">
					<img src="img/dr6.jpg" alt="Doctor 5" class="doctor-image">
					<div class="doctor-info">
						<h3 class="doctor-name">Dr. Michael Brown</h3>
						<p class="doctor-specialty">Endodontist</p>
						<p class="doctor-details">
							MDS (Endodontics), BDS <br> 7+ Years of Experience
						</p>
						<div class="doctor-icons">
							<i class="fab fa-facebook-f doctor-icon"></i> <i
								class="fab fa-twitter doctor-icon"></i> <i
								class="fab fa-instagram doctor-icon"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4" data-aos="fade-up" data-aos-delay="600">
				<div class="doctor-card">
					<img src="img/dr2.jpg" alt="Doctor 6" class="doctor-image">
					<div class="doctor-info">
						<h3 class="doctor-name">Dr. Emily Davis</h3>
						<p class="doctor-specialty">Periodontist</p>
						<p class="doctor-details">
							MDS (Periodontics), BDS <br> 9+ Years of Experience
						</p>
						<div class="doctor-icons">
							<i class="fab fa-facebook-f doctor-icon"></i> <i
								class="fab fa-twitter doctor-icon"></i> <i
								class="fab fa-instagram doctor-icon"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- Experties Section start -->

	<section id="expertise" class="my-5 p-4">
		<div class="text-center mb-5" data-aos="fade-up">
			<i class="fa fa-tooth fs-1 text-primary mb-3"></i>
			<h2>Expertise of Our Dentists</h2>
			<hr class="w-25 m-auto">
		</div>
		<div class="container">
			<!-- Advanced Dental Surgery -->
			<div class="row mb-5 d-flex flex-column flex-md-row"
				data-aos="fade-right">
				<div class="col-12 col-md-6 order-1 order-md-1">
					<img src="img/expert1.jpg" alt="Dental Surgery"
						class="img-fluid img-thumbnail rounded-pill">
				</div>
				<div class="col-12 col-md-6 pt-4 order-2 order-md-2">
					<h2 class="mb-4">Advanced Dental Surgery</h2>
					<p>Our expert dentists specialize in advanced dental surgeries,
						including wisdom tooth extractions, root canal treatments, and
						complex surgical procedures. With state-of-the-art equipment and a
						commitment to patient comfort, we ensure a painless experience.</p>
					<p>We follow the highest standards of sterilization and use the
						latest techniques to guarantee successful procedures with minimal
						recovery time.</p>
				</div>
			</div>

			<!-- Cosmetic Dentistry -->
			<div class="row mt-5 d-flex flex-column flex-md-row"
				data-aos="fade-left">
				<div class="col-12 col-md-6 order-1 order-md-2">
					<img src="img/expert2.jpg" alt="Cosmetic Dentistry"
						class="img-fluid img-thumbnail rounded-pill">
				</div>
				<div class="col-12 col-md-6 pb-4 order-2 order-md-1">
					<h2 class="mb-4">Cosmetic Dentistry</h2>
					<p>Enhance your smile with our world-class cosmetic dentistry
						services. Our skilled dentists specialize in teeth whitening,
						veneers, smile makeovers, and dental bonding to give you a
						confident, radiant smile.</p>
					<p>Our personalized treatment plans focus on both aesthetics
						and oral health, ensuring a perfect balance between beauty and
						functionality. Whether you need a minor enhancement or a complete
						smile transformation, our experts are here to craft the perfect
						smile for you.</p>
				</div>
			</div>

			<!-- Pediatric Dentistry -->
			<div class="row mt-5 d-flex flex-column flex-md-row"
				data-aos="fade-right">
				<div class="col-12 col-md-6 order-1 order-md-1">
					<img src="img/expert3.jpg" alt="Pediatric Dentistry"
						class="img-fluid img-thumbnail rounded-pill">
				</div>
				<div class="col-12 col-md-6 pt-4 order-2 order-md-2">
					<h2 class="mb-4">Pediatric Dentistry</h2>
					<p>We provide specialized dental care for children, ensuring a
						comfortable and friendly environment. Our pediatric dental experts
						focus on early cavity prevention, fluoride treatments, and gentle
						checkups to create a positive dental experience.</p>
					<p>From the first tooth to teenage orthodontics, we guide your
						childâ€™s dental health journey with personalized care and expert
						advice, making every visit stress-free and enjoyable.</p>
				</div>
			</div>
		</div>
	</section>

	<!-- Experties Section end -->



	<!-- Counter Section Start -->
	<section id="counter" class="text-white py-5"
		style="background: linear-gradient(135deg, #17A2B8, #FFFFFF);">
		<div class="container" data-aos="fade-up">
			<div class="row text-center">

				<!-- Total Patients -->
				<div class="col-md-3 col-sm-6 mb-4" data-aos="zoom-in">
					<div class="counter-box">
						<i class="fas fa-users fa-3x mb-2"></i>
						<h2 class="counter" data-target="5000">0</h2>
						<h5>Happy Patients</h5>
					</div>
				</div>

				<!-- Successful Surgeries -->
				<div class="col-md-3 col-sm-6 mb-4" data-aos="zoom-in">
					<div class="counter-box">
						<i class="fas fa-tooth fa-3x mb-2"></i>
						<h2 class="counter" data-target="1200">0</h2>
						<h5>Successful Surgeries</h5>
					</div>
				</div>

				<!-- Experienced Dentists -->
				<div class="col-md-3 col-sm-6 mb-4" data-aos="zoom-in">
					<div class="counter-box">
						<i class="fas fa-user-md fa-3x mb-2"></i>
						<h2 class="counter" data-target="15">0</h2>
						<h5>Expert Dentists</h5>
					</div>
				</div>

				<!-- Awards -->
				<div class="col-md-3 col-sm-6 mb-4" data-aos="zoom-in">
					<div class="counter-box">
						<i class="fas fa-award fa-3x mb-2"></i>
						<h2 class="counter" data-target="10">0</h2>
						<h5>Awards Won</h5>
					</div>
				</div>

			</div>
		</div>
	</section>
	<!-- Counter Section End -->

	<!-- PHONE CALL -->

	<div class="container py-5" id="call_rn" data-aos="fade-up">
		<div class="row justify-content-center">
			<div class="col-md-6 col-sm-8 col-lg-5 col-xl-4">
				<div class="contact-banner">
					<img src="img/agent.png" alt="">
					<h5>Need help? Talk to our dentist</h5>
					<h3>
						<a href="" style="color: white; text-decoration: none;"
							data-bs-toggle="modal" data-bs-target="#callmodal">01169271007</a>
					</h3>
				</div>
			</div>
		</div>
	</div>






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

	<script>
    document.addEventListener("DOMContentLoaded", function () {
        const counters = document.querySelectorAll(".counter");
        const speed = 200;

        const observer = new IntersectionObserver(entries => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const updateCounter = counter => {
                        const target = +counter.getAttribute("data-target");
                        const count = +counter.innerText;
                        const increment = target / speed;

                        if (count < target) {
                            counter.innerText = Math.ceil(count + increment);
                            setTimeout(() => updateCounter(counter), 30);
                        } else {
                            counter.innerText = target;
                        }
                    };
                    updateCounter(entry.target);
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.5 });

        counters.forEach(counter => {
            observer.observe(counter);
        });
    });
</script>

	<%@ include file="../user/footer.jsp"%>
</body>
</html>

