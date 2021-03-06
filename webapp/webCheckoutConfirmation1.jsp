<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HostedPCI Demo App 3D Secure Confirmation1 Page</title>
<!-- Bootstrap 3.2.0-->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css"
	rel="stylesheet">
<script src="js/jquery-2.1.1.js" type="text/javascript" charset="utf-8"></script>
<script src="https://cc.hostedpci.com/WBSStatic/site60/proxy/js/jquery.ba-postmessage.2.0.0.min.js" type="text/javascript" charset="utf-8"></script>
<script src="https://cc.hostedpci.com/WBSStatic/site60/proxy/js/hpci-cciframe-1.0.js" type="text/javascript" charset="utf-8"></script>
<script>
	var hpciCCFrameHost = "https://cc.hostedpci.com";
	var hpciCCFrameFullUrl = "https://cc.hostedpci.com/iSynSApp/showPxyPage!ccFrame.action?pgmode1=prod&locationName=javasample1&sid=528160&reportCCType=Y&fullParentHost=http://localhost:8799&fullParentQStr=/webCheckoutConfirmation1.jsp";
	var hpciCCFrameName = "ccframe"; // use the name of the frame containing the credit card

	var hpciSiteErrorHandler = function(errorCode, errorMsg) {
		// Please the following alert to properly display the error message
		//alert("Error while processing credit card code:" + errorCode + "; msg:"	+ errorMsg);
		document.getElementById('errorMessage').style.display = 'block';
	}

	var hpciSiteSuccessHandlerV2 = function(mappedCCValue, mappedCVVValue, ccBINValue) {
		// Please pass the values to the document input and then submit the form
		
		// No errors from iframe so hide the errorMessage div
		document.getElementById('errorMessage').style.display = 'none';
		// Name of the input (hidden) field required by ecommerce site
		// Typically this is a hidden input field.
		var ccNumInput = document.getElementById("ccNum");
		ccNumInput.value = mappedCCValue;
		alert("ccNumInput = " + ccNumInput);

		// name of the input (hidden) field required by ecommerce site
		// Typically this is a hidden input field.
		var ccCVVInput = document.getElementById("ccCVV");
		ccCVVInput.value = mappedCVVValue;

		// name of the input (hidden) field required by ecommerce site
		// Typically this is a hidden input field.
		var ccBINInput = document.getElementById("ccBIN");
		ccBINInput.value = ccBINValue;

		// name of the form submission for ecommerce site
		var pendingForm = document.getElementById("CCAcceptForm");
		pendingForm.submit();

	}

	var hpci3DSitePINSuccessHandler = function() {
		// name of the form submission for ecommerce site
		var pendingForm = document.getElementById("CCAcceptForm");
		pendingForm.submit();
	}

	var hpci3DSitePINErrorHandler = function() {
		// Adapt the following message / action to match your required experience
		alert("Could not verify PIN for the credit card");
	}

	var hpciCCPreliminarySuccessHandler = function(hpciCCTypeValue, hpciCCBINValue, hpciCCValidValue, hpciCCLengthValue) {
		// Adapt the following message / action to match your required experience
		alert("Received preliminary credit card details");
	}

	var hpciCVVPreliminarySuccessHandler = function(hpciCVVLengthValue) {
		// Adapt the following message / action to match your required experience
		alert("Received preliminary CVV details");
	}
</script>
<script type="text/javascript">
$(document).ready(function () {
	$('#noButton').click(function () {
		$('#message').hide('slow');
	});
	$('#yesButton').click(function () {
		$('#message').show('slow');
	});
});
</script>
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
<!-- container class sets the page to use 100% width -->
<div class="container">
	<!-- row class sets the margins -->
	<div class="row">
		<!-- col-md-7 col-centered class uses the bootstrap grid system to use 7/12 of the screen and place it in the middle -->
		<div class="col-md-7 col-centered">
			<form id="CCAcceptForm" action="/Iframe3DSecServlet" method="post">
			<input type="hidden" name="action" value="form3DSecResponse">
				<section style="margin: 10px;">
					<fieldset style="min-height: 100px;">
						<!-- Form Name -->
						<legend>Web Checkout</legend>
						<!-- Text Input -->
						<div>
							Dear Hosted PCI Customer,<br /> Thank you for trying our
							services. If you have any questions, please contact us at
							www.hostedpci.com<br />
							<br /> <label>Transaction Summary</label><br />
							<label>*******************</label><br />
							<c:choose>
								<c:when test="${map['pxyResponse.threeDSEnrolled'].equals('Y')}">
									<iframe seamless id="threeDSecFrame" name="threeDSecFrame" onload="receivePINMsg()" src="https://cc.hostedpci.com/iSynSApp/appUserVerify3DResp!verificationForm.action?sid=528160&authTxnId=${map['pxyResponse.threeDSTransactionId']}&fullParentHost=http://localhost:8799&fullParentQStr=/webCheckoutConfirmation1.jsp" width=450 height=400 style="border:none">
									If you can see this, your browser doesn't understand IFRAME.
									</iframe>
									<br />
								</c:when>
								<c:when test="${map['pxyResponse.threeDSEnrolled'] ne 'Y'}">
									<!-- Gets responseStatus from the response map that the iframe sent back -->
									<label>Status: <c:out value="${map['pxyResponse.responseStatus.name']}" /></label><br />
									<!-- Gets description from the response map that the iframe sent back -->
									<label>Description: <c:out value="${map['pxyResponse.responseStatus.description']}" /></label><br />
									<!-- Gets processorRefId from the response map that the iframe sent back -->
									<label>Processor Reference ID: <c:out value="${map['pxyResponse.processorRefId']}" /></label><br />
									<!-- Gets merchantRefId from the response map that the iframe sent back -->
									<label>Merchant ID: <c:out value="${globalMap['merchantRefId']}" /></label><br />
									<!-- Gets cardType from the user input on previous page -->
									<c:set var="mappedParams" value="${map['pxyResponse.mappedParams']}" />
									<c:set var="mappedParamsValue" value="${fn:split(mappedParams, '=')}" />
									<label>Card Type: <c:out value="${mappedParamsValue[1]}" /></label><br />
									<!-- Gets cardNumber -->
									<label>Token Card Number: <c:out value="${globalMap['cardNumber']}" /></label><br />
									<!-- Gets cardCVV -->
									<label>Token CVV Number: <c:out value="${globalMap['cardCVV']}" /></label><br />
									<!-- Gets today's date -->
									<label>Payment Date: <c:set var="now" value="<%=new java.util.Date()%>" /><fmt:formatDate type="both" value="${now}" /></label><br />
									<!-- Gets amount from the user input on previous page -->
									<label>Amount: <c:out value="${globalMap['amount']}" /></label><br />
									<!-- Gets comment from the user input on previous page -->
									<label>Comments: <c:out value="${globalMap['comments']}" /></label><br />
								</c:when>
							</c:choose>
							<label>Show Full Message?</label><br />
								<input id="noButton" type="radio" name="radioButton" checked />No
								<input id="yesButton" type="radio" name="radioButton" />Yes
							<div id="message" style="display:none; word-wrap: break-word;">
								<label>Full Message: </label><br />
								<c:out value="${map}" />
							</div><br />
							<label>*******************</label><br /> Thank you for using Hosted PCI.<br />
							<br /> <input Type="button" class="btn btn-primary" value="Back" onClick="history.go(-1);return true;"></input><br />
							<input type="hidden" id="ccNum" name="ccNum" value="${globalMap['cardNumber']}" />
							<input type="hidden" id="ccCVV" name="ccCVV" value="${globalMap['cardCVV']}" />
							<input type="hidden" name="action3DSec" value="verifyresp" />
							<input type="hidden" name="authTxnId" value="${map['pxyResponse.threeDSTransactionId']}" />
						</div>
					</fieldset>
				</section>
			</form>
		</div><!-- col-md-7 col-centered -->
	</div><!-- row -->
</div><!-- container -->
</body>
</html>