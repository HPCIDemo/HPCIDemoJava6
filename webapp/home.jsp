<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hosted PCI Demo App for Java 6</title>
<!-- Bootstrap -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" rel="stylesheet">
<script src="js/jquery-2.1.1.js" type="text/javascript"></script>
<style type="text/css">
h1 {
	margin: 30px 0;
	padding: 0 200px 15px 0;
	border-bottom: 1px solid #E5E5E5;
}

.container {
	margin-top: 10px;
}

fieldset {
	font-family: sans-serif;
	border: 5px solid #1F497D;
	background: #ddd;
	border-radius: 5px;
	padding: 15px;
	/* margin-right: -20px; */
	margin-top: 10px;
}

fieldset legend {
	background: #1F497D;
	color: #fff;
	padding: 5px 10px;
	font-size: 32px;
	border-radius: 5px;
	box-shadow: 0 0 0 5px #ddd;
	margin-left: 10px;
	margin-right: 60px;
	width: auto;
}
.row {
	margin-top: 5px;
	margin-bottom: 5px;
}
.col-centered {
	float: none;
	margin: 0 auto;
}
</style>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-md-7 col-centered">
			<form id="paymentForm">
				<fieldset>
					<legend>HostedPCI Demo App For Java6</legend><br />
					<fieldset>
						<!-- <legend>Session Information</legend> -->
						<div class="row">
							<div class="col-xs-6 col-sm-4 col-md-5 col-centered">
								<!-- Link to iframe demo app -->
								<a href="/webCheckoutForm.jsp" role="button" class="btn btn-primary">Web Checkout (Iframe)</a>
								<br /><br />
								<!-- Link to iframe3dsec demo app -->
								<a href="/webCheckoutForm3DSec.jsp" role="button" class="btn btn-primary">Web Checkout (Iframe) 3D Secure</a>
								<br /><br />
								<!-- Link to IVR demo app -->
								<a href="/phoneSession.jsp" role="button" class="btn btn-primary">Phone/Call Center (IVR)</a>
								<br /><br />
							</div>
						</div>
					</fieldset>
				</fieldset>
			</form>
		</div><!-- col-md-7 col-centered -->
	</div><!-- row -->
</div><!-- container -->
</body>
</html>