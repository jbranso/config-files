<div class="container footer">
    <div class="row">
	<div class="col-sm-4">
	    <h6>
		<a href="work.html">Work Experience</a>
	    </h6>
	    <p>
		I am currently working as a Web Production Assistant. In other words, I work with numerous
		open source web technologies: HTML, CSS, javascript, jQuery, php, and MySQL.
	    </p>
	</div>
	<div class="col-sm-4">
	    <h6 class="brown">
		Favorite Quotation
	    </h6>
	    <p>
		Anyone can love a thing <em>because.</em> That's as easy as putting a penny in your
		pocket. But to love something <em>despite.</em> To know the flaws and love them too. That is
		rare and pure and perfect.<br>
		-Patrick Rothfuss, <a href="http://www.patrickrothfuss.com/content/books.asp">The Name Of The Wind</a>
	    </p>
	</div>
	<div class="col-sm-4">
	    <a href="www.gnu.org">
		<img src="images/gnu.png"" class="right img-responsive" />
	    </a>
	</div>
    </div>
</div>
<br/><br/><br/>
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="bs3.3/js/bootstrap.min.js"></script>
<script>
 function loadHome() {
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET","index.txt",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function()
     {
	 if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 {
	     document.getElementById("content").innerHTML=xmlhttp.responseText;
	 }
     }
     history.pushState(null, null, "index.php")
 }
 function loadAbout() {
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET","about.txt",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function()
     {
	 if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 {
	     document.getElementById("content").innerHTML=xmlhttp.responseText;
	 }
     }
     history.pushState(null, null, "about.php")
 }
 function loadSkills() {
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET","skills.txt",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function()
     {
	 if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 {
	     document.getElementById("content").innerHTML=xmlhttp.responseText;
	 }
     }
     history.pushState(null, null, "skills.php")
 }
 function loadExperience() {
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET","experience.txt",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function()
     {
	 if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 {
	     document.getElementById("content").innerHTML=xmlhttp.responseText;
	 }
     }
     history.pushState(null, null, "experience.php")
 }
 function loadHowIMade() {
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET","howIMade.txt",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function()
     {
	 if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 {
	     document.getElementById("content").innerHTML=xmlhttp.responseText;
	 }
     }
     history.pushState(null, null, "howIMade.php")
 }
 function swapPhoto(href) {
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET",
		  location.pathname.toString().split("/").pop().split(".")[0].concat(".txt"),
		  true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function()
     {
	 if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 {
	     document.getElementById("content").innerHTML=xmlhttp.responseText;
	 }
     }
 }
 window.addEventListener("popstate", function(e) {
     swapPhoto(location.pathname);
 });

</script>
  </body>
</html>
