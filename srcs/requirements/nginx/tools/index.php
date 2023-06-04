<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Inception</title>
	<style>
		@import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap");
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: "Poppins", sans-serif;
}

ul {
  margin: 0;
  padding: 0;
  list-style-type: none;
}

a {
  text-decoration: none;
}
a:hover {
  color: #111;
}

p {
  font-size: 1rem;
  line-height: 1.6;
}

.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #f0ebe7;
  overflow-x: hidden;
  transition: 0.5s;
  padding: 0;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.sidenav .closebtn {
  position: absolute;
  top: 15px;
  right: 25px;
  font-size: 40px;
  margin-left: 50px;
  color: #2685ad;
}
@media screen and (min-width: 700px) {
  .sidenav .closebtn {
    display: none;
  }
}
.sidenav .closebtn:hover {
  color: #111;
}
.sidenav-logo a {
  font-size: 2.5rem;
  font-weight: bold;
  color: #2685ad;
}
.sidenav-logo a:hover {
  color: #111;
}
.sidenav h2 {
  font-weight: 700;
  color: #2685ad;
  font-size: 1.6rem;
  line-height: 1.2;
}
.sidenav p {
  color: #0e3e52;
  margin-top: 15px;
  margin-bottom: 35px;
}
.sidenav-btn_view {
  font-size: 1rem;
  display: inline-block;
  font-weight: 700;
  color: #2685ad;
  padding-top: min(20vh, 2rem);
}
.sidenav-content {
  padding-block: min(20vh, 2rem);
}
.sidenav .portfolio-slides-second {
  padding-top: 30px;
  margin-bottom: 0;
}
.sidenav .slick-dots {
  bottom: -35px;
}
.sidenav .slick-dots li button:before {
  color: #2685ad;
}
.sidenav .slick-dots li.slick-active button:before {
  color: #0e3e52;
}
.sidenav .slick-prev {
  bottom: -35px;
  left: 40%;
  transform: translatex(-40%);
  top: unset;
}
.sidenav .slick-prev:before {
  color: #0e3e52;
}
.sidenav .slick-prev:hover:before {
  color: #2685ad;
}
.sidenav .slick-next {
  bottom: -35px;
  right: 40%;
  transform: translatex(40%);
  top: unset;
}
.sidenav .slick-next:before {
  color: #0e3e52;
}
.sidenav .slick-next:hover:before {
  color: #2685ad;
}
.sidenav .slick-lightbox-close {
  right: 30px;
}
.sidenav .slick-lightbox-close:before {
  font-size: 40px;
}
.sidenav .single img {
  aspect-ratio: 1/1;
  width: 100%;
  padding: 8px;
  object-fit: cover;
}

main {
  transition: margin-left 0.5s;
  padding: 2.5rem 3rem;
  height: 100vh;
  height: 100svh;
  min-height: 630px;
  background: url("https://cdn.pixabay.com/photo/2020/02/04/06/16/watercolour-4817390_960_720.jpg") no-repeat 50% 50%/cover;
  background-position: top center;
  background-size: cover;
  display: grid;
  justify-content: center;
  align-content: space-between;
}
@media screen and (min-width: 600px) {
  main {
    padding: 2.5rem 3rem;
    justify-content: end;
  }
}
@media screen and (min-width: 700px) {
  main {
    padding: 3.5rem 5rem;
  }
}
main .main-content {
  text-align: left;
}
main .main-content h1 {
  text-transform: uppercase;
  font-size: clamp(2.6rem, 2.0435rem + 2.7826vw, 5rem);
  line-height: 1;
  color: #fff;
  text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.6392156863);
  margin-bottom: 15px;
}
@media screen and (min-width: 600px) {
  main .main-content h1 {
    justify-content: end;
  }
}
main .main-content p {
  color: #fff;
  text-shadow: 3px 1px 9px #000000;
}
@media screen and (min-width: 600px) {
  main .main-content p {
    max-width: 260px;
  }
}
main ul {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 20px;
}
main ul li i {
  font-size: 1.25rem;
  color: #fff;
  text-shadow: 1px 0px 10px rgba(0, 0, 0, 0.3411764706);
}
main ul li i:hover {
  color: #111;
}
main .menu {
  background: white;
  position: relative;
  content: "";
  border-radius: 50%;
  width: 60px;
  height: 60px;
  box-shadow: -4px 1px 14px rgba(0, 0, 0, 0.22);
  margin-left: auto;
  display: grid;
  place-content: center;
  cursor: pointer;
}

#main.active {
  margin-left: 0;
}
@media screen and (min-width: 700px) {
  #main.active {
    margin-left: 350px;
  }
}

#mySidenav.active {
  width: 100%;
  padding: 3.5rem 3rem;
}
@media screen and (min-width: 700px) {
  #mySidenav.active {
    width: 350px;
  }
}

#nav-icon {
  width: 28px;
  height: 24px;
  position: relative;
  -webkit-transform: rotate(0deg);
  -moz-transform: rotate(0deg);
  -o-transform: rotate(0deg);
  transform: rotate(0deg);
  -webkit-transition: 0.5s ease-in-out;
  -moz-transition: 0.5s ease-in-out;
  -o-transition: 0.5s ease-in-out;
  transition: 0.5s ease-in-out;
  cursor: pointer;
}
#nav-icon span {
  display: block;
  position: absolute;
  height: 4px;
  width: 100%;
  background: #111;
  border-radius: 9px;
  opacity: 1;
  left: 0;
  -webkit-transform: rotate(0deg);
  -moz-transform: rotate(0deg);
  -o-transform: rotate(0deg);
  transform: rotate(0deg);
  -webkit-transition: 0.25s ease-in-out;
  -moz-transition: 0.25s ease-in-out;
  -o-transition: 0.25s ease-in-out;
  transition: 0.25s ease-in-out;
}
#nav-icon span:nth-child(1) {
  top: 0px;
  -webkit-transform-origin: left center;
  -moz-transform-origin: left center;
  -o-transform-origin: left center;
  transform-origin: left center;
}
#nav-icon span:nth-child(2) {
  top: 10px;
  -webkit-transform-origin: left center;
  -moz-transform-origin: left center;
  -o-transform-origin: left center;
  transform-origin: left center;
}
#nav-icon span:nth-child(3) {
  top: 20px;
  -webkit-transform-origin: left center;
  -moz-transform-origin: left center;
  -o-transform-origin: left center;
  transform-origin: left center;
}

#nav-icon.open span:nth-child(1) {
  -webkit-transform: rotate(45deg);
  -moz-transform: rotate(45deg);
  -o-transform: rotate(45deg);
  transform: rotate(45deg);
  top: 0px;
  left: 4px;
}
#nav-icon.open span:nth-child(2) {
  width: 0%;
  opacity: 0;
}
#nav-icon.open span:nth-child(3) {
  -webkit-transform: rotate(-45deg);
  -moz-transform: rotate(-45deg);
  -o-transform: rotate(-45deg);
  transform: rotate(-45deg);
  top: 20px;
  left: 4px;
}

@media screen and (max-height: 450px) {
  .sidenav {
    padding-top: 15px;
  }
  .sidenav a {
    font-size: 18px;
  }
}
/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0, 0, 0); /* Fallback color */
  background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
  padding: 2rem 0;
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 40px 30px;
  border: 1px solid #888;
  width: 80%;
  position: relative;
  /* The Close Button */
}
.modal-content .title {
  text-transform: uppercase;
  display: inline-block;
  margin: 10px 0 5px 0;
  letter-spacing: 1px;
  font-size: 0.9rem;
  color: #1a6a8d;
}
.modal-content h2 {
  text-transform: capitalize;
}
.modal-content p {
  margin-top: 25px;
  margin-bottom: 0;
}
.modal-content .close {
  color: #aaaaaa;
  float: right;
  font-size: 35px;
  font-weight: bold;
  position: absolute;
  right: 25px;
  top: 15px;
}
.modal-content .close:hover, .modal-content .close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
	</style>
</head>
<body>
	<div id="mySidenav" class="sidenav active">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<div class="sidenav-logo">
		  <a href="#">Artist.</a>
		</div>
		<div class="sidenav-content">
		  <h2>Artist with water colour</h2>
		  <p>Watercolour is a painting method in which the paints are made of pigments suspended in a water-based solution.</p>
		  <div class="portfolio-slides">
	  
			<div class="single">
			  <a href="https://cdn.pixabay.com/photo/2020/01/06/23/45/watercolor-4746520_960_720.jpg">
				<img src="https://cdn.pixabay.com/photo/2020/01/06/23/45/watercolor-4746520_960_720.jpg" />
			  </a>
			</div>
			<div class="single">
			  <a href="https://cdn.pixabay.com/photo/2017/11/25/12/53/watercolour-2976746_1280.jpg">
				<img src="https://cdn.pixabay.com/photo/2017/11/25/12/53/watercolour-2976746_1280.jpg" />
			  </a>
			</div>
			<div class="single">
			  <a href="https://cdn.pixabay.com/photo/2018/07/18/15/43/animal-3546613_1280.jpg">
				<img src="https://cdn.pixabay.com/photo/2018/07/18/15/43/animal-3546613_1280.jpg" />
			  </a>
			</div>
			<div class="single">
			  <a href="https://cdn.pixabay.com/photo/2021/03/13/10/23/hut-6091451_1280.jpg">
				<img src="https://cdn.pixabay.com/photo/2021/03/13/10/23/hut-6091451_1280.jpg" />
			  </a>
			</div>
		  </div>
		  <div class="portfolio-slides-second">
	  
			<div class="single">
			  <a href="https://cdn.pixabay.com/photo/2017/09/26/23/10/painting-2790478_1280.jpg">
				<img src="https://cdn.pixabay.com/photo/2017/09/26/23/10/painting-2790478_1280.jpg" />
			  </a>
			</div>
			<div class="single">
			  <a href="https://cdn.pixabay.com/photo/2013/01/16/19/12/tigers-75119_1280.jpg">
				<img src="https://cdn.pixabay.com/photo/2013/01/16/19/12/tigers-75119_1280.jpg" />
			  </a>
			</div>
			<div class="single">
			  <a href="https://cdn.pixabay.com/photo/2021/09/13/10/37/fruit-6620951_1280.jpg">
				<img src="https://cdn.pixabay.com/photo/2021/09/13/10/37/fruit-6620951_1280.jpg" />
			  </a>
			</div>
			<div class="single">
			  <a href="https://cdn.pixabay.com/photo/2016/02/24/11/55/cat-1219635_1280.jpg">
				<img src="https://cdn.pixabay.com/photo/2016/02/24/11/55/cat-1219635_1280.jpg" />
			  </a>
			</div>
		  </div>
		</div>
	  
		<a href="#" class="sidenav-btn_view" id="myBtn">View profile</a>
		<div id="myModal" class="modal">
	  
		  <div class="modal-content">
			<span class="close">&times;</span>
			<span class="title">watercolour artist</span>
			<h2>jane doe</h2>
			<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam sapien elit, consequat eget, tristique non, venenatis quis, ante. Vestibulum erat nulla, ullamcorper nec, rutrum non, nonummy ac, erat. Nulla non lectus sed nisl molestie malesuada. Integer vulputate sem a nibh rutrum consequat. In enim a arcu imperdiet malesuada. Aliquam ante. Cras pede libero, dapibus nec, pretium sit amet, tempor quis. Fusce aliquam vestibulum ipsum. Quisque tincidunt scelerisque libero. Morbi scelerisque luctus velit. Quisque porta.</p>
		  </div>
	  
		</div>
	  </div>
	  <main id="main" class="active">
		<div class="menu" onclick="toggleNav()">
		  <div id="nav-icon" class="open">
			<span></span>
			<span></span>
			<span></span>
		  </div>
		</div>
		<div class="main-content">
		  <h1>Water <br>colour</h1>
		  <p>Watercolors can also be made opaque by adding Chinese white.</p>
		</div>
		<ul class="social-icons">
		  <li><a href="#"><i class="fa-brands fa-facebook-f"></i></a></li>
		  <li><a href="#"><i class="fa-brands fa-square-tumblr"></i></a></li>
		  <li><a href="#"><i class="fa-brands fa-twitter"></i></a></li>
		  <li><a href="#"><i class="fa-brands fa-linkedin"></i></a></li>
		</ul>
	  </main>
	  <script>
		let mySidenav = document.getElementById("mySidenav");
let main = document.getElementById("main");
let navIcon = document.getElementById("nav-icon");

function toggleNav() {
  navIcon.classList.toggle("open");
  mySidenav.classList.toggle("active");
  main.classList.toggle("active");
}

function closeNav() {
  navIcon.classList.remove("open");
  mySidenav.classList.remove("active");
  main.classList.remove("active");
}

$(".portfolio-slides").slick({
  infinite: true,
  slidesToShow: 3,
  slidesToScroll: 1,
  dots: false,
  arrows: true,
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3
      }
    },
    {
      breakpoint: 600,
      settings: {
        slidesToShow: 2
      }
    }
  ]
});

$(".portfolio-slides-second").slick({
  infinite: true,
  slidesToShow: 3,
  slidesToScroll: 1,
  dots: true,
  arrows: false,
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3
      }
    },
    {
      breakpoint: 600,
      settings: {
        slidesToShow: 3
      }
    }
  ]
});

$(".portfolio-slides").slickLightbox({
  itemSelector: "a",
  navigateByKeyboard: true
});

$(".portfolio-slides-second").slickLightbox({
  itemSelector: "a",
  navigateByKeyboard: true
});

// Get the modal
let modal = document.getElementById("myModal");

// Get the button that opens the modal
let btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
let span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal
btn.onclick = function () {
  modal.style.display = "grid";
  document.body.style.overflow = "hidden";
};

// When the user clicks on <span> (x), close the modal
span.onclick = function () {
  modal.style.display = "none";
  document.body.style.overflow = "auto";
};
	  </script>
</body>
</html>