<div class="container footer">
    <div class="row">
	<div class="col-sm-6">
	    <h4 class="brown">Connect with Me</a></h4>
            <div class="row">
                <div class="col-xs-1">
                    <a href="https://github.com/jbranso" target="_blank">
                        <img src="images/github.png" style="max-width:20px;max-height:20px;" />
                    </a>
                </div>
                <div class="col-xs-1">
                    <a href="https://www.linkedin.com/profile/public-profile-settings?trk=prof-edit-edit-public_profile" target="_blank">
                        <img src="images/linked-in.png" style="max-width:20px;max-height:20px;" />
                    </a>
                </div>
                <div class="col-xs-1">
                    <a href="mailto:jbranso@purdue.edu" target="_blank">
                        <img alt="email-icon" src="images/email-icon.png"/>
                    </a>
                </div>
            </div>
        </div><!-- col-sm-6 -->
	<div class="col-sm-6">
	        <h4 class="brown">What runs this site</h4>
                This is powered by some pretty amazing web technologies including bootstrap, jQuery, ajax, php, html5, and javascript!
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
     // collapse the navbar when the user selects home
     $("#navbar-collapse").collapse("hide");
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
     $("#navbar-collapse").collapse("hide");
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET","about.html",true);
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
     $("#navbar-collapse").collapse("hide");
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET","skills.html",true);
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
     $("#navbar-collapse").collapse("hide");
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET","experience.html",true);
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
 function loadPortfolio() {
     $("#navbar-collapse").collapse("hide");
     var xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET","portfolio.html",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function()
     {
	 if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 {
	     document.getElementById("content").innerHTML=xmlhttp.responseText;
	 }
     }
     history.pushState(null, null, "portfolio.php")
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
