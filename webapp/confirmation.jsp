<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HostedPCI Demo App Confirmation Page</title>
<!-- Bootstrap 3.2.0-->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css"
	rel="stylesheet">
<!-- Jquery 1.4.1-->
<script
	src="https://cc.hostedpci.com/WBSStatic/site60/proxy/js/jquery-1.4.1.min.js"
	type="text/javascript" charset="utf-8"></script>

<style type="text/css">
container {
	margin-top: 10px;
}

fieldset {
	font-family: sans-serif;
	border: 5px solid #1F497D;
	background: #ddd;
	border-radius: 5px;
	padding: 15px;
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
</style>
</head>
<body>
	<!-- container class sets the page to use 100% width -->
	<div class="container">
		<!-- row class sets the margins -->
		<div class="row">
			<!-- col-md-4 class uses the bootstrap grid system to use 1/3rd of the left side of the page -->
			<div class="col-md-4">
				<form>
					<section style="margin: 10px;">
						<fieldset style="min-height: 100px;">
							<!-- Form Name -->
							<legend>Hosted PCI</legend>
							<!-- Text Input -->
							<div>
								Dear Hosted PCI Customer,<br /> Thank you for trying our
								services. If you have any questions, please contact us at
								www.hostedpci.com<br />
								<br /> <label>Transaction Summary</label><br /> <label>*******************</label><br />
								<!-- Gets responseStatus from the response map that the iframe sent back -->
								<label>Status: <c:out value="${map['pxyResponse.responseStatus.name']}" /></label><br />
								<!-- Gets description from the response map that the iframe sent back -->
								<label>Description: <c:out value="${map['pxyResponse.responseStatus.description']}" /></label><br />
								<!-- Gets processorRefId from the response map that the iframe sent back -->
								<label>Authorization Code: <c:out value="${map['pxyResponse.processorRefId']}" /></label><br />
								<!-- Gets merchantRefId from the response map that the iframe sent back -->
								<label>Merchant ID: <c:out value="${map['pxyResponse.merchantRefId']}" /></label><br />
								<!-- Gets cardType from the user input on previous page -->
								<label>Card Type: <c:out value="${map['pxyResponse.mappedParams']}" /></label><br />
								<!-- Gets today's date -->
								<label>Payment Date: <c:set var="now" value="<%=new java.util.Date()%>" /><fmt:formatDate type="both" value="${now}" /></label><br />
								<!-- Gets amount from the user input on previous page -->
								<label>Amount: <c:out value="${param.amount}" /></label><br />
								<!-- Gets comment from the user input on previous page -->
								<label>Comments: <c:out value="${param.comment}" /></label><br />
								<label>*******************</label><br /> Thank you for using Hosted PCI.<br />
								<br /> <input Type="button" class="btn btn-primary" value="Back" onClick="history.go(-1);return true;"></input>
							</div>
						</fieldset>
					</section>
				</form>
			</div>
		</div>
	</div>
</body>
</html>