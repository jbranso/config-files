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
		Never forget what you are. <i>The rest of the world will not.</i> Wear it like armor,
		and it can never be used to harm you.<br/>
		-Tyrion Lannister
		<em>Game of Thrones</em>
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
     xmlhttp.open("GET","index.xml",true);
     xmlhttp.send();
     xmlhttp.onreadystatechange=function()
     {
	 if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 {
	     document.getElementById("content").innerHTML=xmlhttp.responseText;
	 }
     }
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
 }
</script>
  </body>
</html>
