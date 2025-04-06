<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Footer Section</title>

<style>
#last-footer {
	height: auto;
	padding: 15px 0;
	text-align: center;
	background-color: #17A2B8;
}

.social-icons a {
	width: 40px;
	height: 40px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	border-radius: 50%;
	font-size: 18px;
	background: #fff;
	color: #17A2B8;
	transition: 0.3s;
	margin: 0 5px;
}

.social-icons a:hover {
	background: #17A2B8;
	color: #fff;
}

hr {
	border: 0;
	height: 2px;
	background: #fff;
	margin: 5px 0;
	color: black;
}

#footer .container {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
}

#footer .row {
	justify-content: center;
}
</style>

</head>
<body>
	<!-- Footer Start -->
	<div class="container-fluid text-light py-5" id="footer"
		style="background-color: #17A2B8;" data-aos="fade-up">
		<div class="container">
			<div class="row g-5">
				<div class="col-lg-4 col-md-6" data-aos="fade-right">
					<h4 class="text-uppercase border-bottom border-secondary pb-2 mb-4">Get
						In Touch</h4>
					<p class="mb-3">Your trusted dental clinic providing top-notch
						services with care and expertise.</p>
					<p>
						<i class="fa fa-map-marker-alt"></i> Shivaranjani , Ahmedabad
						,India
					</p>
					<p>
						<i class="fa fa-envelope"></i> easydent@gmail.com
					</p>
					<p>
						<i class="fa fa-phone-alt"></i> +012 345 67890
					</p>
				</div>
				<div class="col-lg-4 col-md-6" data-aos="fade-left">
					<h4 class="text-uppercase border-bottom border-secondary pb-2 mb-4">Quick
						Links</h4>
					<div class="d-flex flex-column">
						<a class="text-light mb-2" href="index.jsp"><i
							class="fa fa-angle-right me-2"></i>Home</a> <a
							class="text-light mb-2" href="aboutus.jsp"><i
							class="fa fa-angle-right me-2"></i>About Us</a> <a
							class="text-light mb-2" href="services.jsp"><i
							class="fa fa-angle-right me-2"></i>Services</a> <a
							class="text-light mb-2" href="contactus.jsp"><i
							class="fa fa-angle-right me-2"></i>Contact Us</a> <a
							class="text-light mb-2" href="booking.jsp"><i
							class="fa fa-angle-right me-2"></i>Book Appointment</a><a
							class="text-light mb-2" href="user_login.jsp"><i
							class="fas fa-sign-in-alt me-2"></i>Login</a> <a class="text-light"
							href="user_profile.jsp"><i class="fa fa-user me-2"></i>Profile</a>
					</div>
				</div>
				<div class="col-lg-4 col-md-6" data-aos="fade-right">
					<h4 class="text-uppercase border-bottom border-secondary pb-2 mb-4"
						style="font-size: 1.5rem;">Follow Us</h4>
					<div class="d-flex flex-column" style="font-size: 1.25rem;">
						<a class="text-light mb-2" href="#"><i
							class="fab fa-twitter me-3" style="font-size: 1.5rem;"></i>Twitter</a>
						<a class="text-light mb-2" href="#"><i
							class="fab fa-facebook-f me-3" style="font-size: 1.5rem;"></i>Facebook</a>
						<a class="text-light mb-2" href="#"><i
							class="fab fa-youtube me-3" style="font-size: 1.5rem;"></i>YouTube</a>
						<a class="text-light" href="#"><i
							class="fab fa-instagram me-3" style="font-size: 1.5rem;"></i>Instagram</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid text-center text-light py-3"
		style="background-color: #128293;">
		<p class="mb-0" style="font-size: 1.1rem;">
			&copy; <a class="text-light" href="#">EASY-DENT</a>. All Rights
			Reserved.
		</p>
		<p class="mb-0" style="font-size: 1.1rem;">
			Designed by <a class="text-light" href="">techfun</a>
		</p>
	</div>
	<!-- Footer End -->

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

</body>
</html>

