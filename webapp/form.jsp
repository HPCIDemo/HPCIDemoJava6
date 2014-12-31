<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>HostedPCI Demo App Payment Page</title>
<!-- Bootstrap -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" rel="stylesheet">


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script src="https://cc.hostedpci.com/WBSStatic/site60/proxy/js/jquery-1.4.1.min.js" type="text/javascript" charset="utf-8"></script>
<script src="https://cc.hostedpci.com/WBSStatic/site60/proxy/js/jquery.ba-postmessage.min.js" type="text/javascript" charset="utf-8"></script>
<script src="https://cc.hostedpci.com/WBSStatic/site60/proxy/js/hpci-cciframe-1.0.js" type="text/javascript" charset="utf-8"></script>
<script>
	var hpciCCFrameHost = "https://cc.hostedpci.com";
	var hpciCCFrameFullUrl = "https://cc.hostedpci.com/iSynSApp/showPxyPage!ccFrame.action?pgmode1=prod&locationName=javasample1&sid=528160&reportCCType=Y&fullParentHost=http://localhost:8799&fullParentQStr=/form.jsp";
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
$(document).ready(function() {
	$('#paymentResetButton').click(function resetPayment() {
		document.getElementById('CCAcceptForm').reset();
	});
});
</script>
<script type="text/javascript">
$(document).ready(function() {$('.selectpicker').selectpicker();});
</script>
<style type="text/css">
h1 {
	margin: 30px 0;
	padding: 0 200px 15px 0;
	border-bottom: 1px solid #E5E5E5;
}

text-align
:center
;


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
	<!-- container class sets the page to use 100% width -->
	<div class="container">
		<!-- row class sets the margins on the sides -->
		<div class="row">
			<!-- col-md-7 col-centered class uses the bootstrap grid system to use 7/12 of the screen and place it in the middle -->
			<div class="col-md-7 col-centered">
				<!-- IMPORTANT: id CCAcceptForm needs to match the ID's in the HostedPCI script code -->
				<!-- So if you change this ID, make sure to change it in all other places -->
				<!-- Action points to the servlet -->
				<form id="CCAcceptForm" action="/IframeServlet" method="post">
					<fieldset>
						<!-- Form Name -->
						<legend>Web Checkout</legend>
						<fieldset>
							<legend>Credit Card Information</legend>
							<!-- Error message for invalid credit card -->
							<div id="errorMessage" style="display:none;color:red"><label>Invalid card number, try again</label><br/></div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<!-- Select credit card -->
									<label for="cardType">Card Type</label>
								</div>
							</div><!-- row -->
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<!-- id is used in confirmation.jsp -->
									<select id="cardType" name="cardType" class="selectpicker">
										<option value="visa">Visa</option>
										<option value="mastercard">MasterCard</option>
										<option value="amex">American Express</option>
									</select>
								</div>
							</div><!-- row -->
							<!-- iframe -->
							<div class="row">
								<iframe seamless id="ccframe" name="ccframe" onload="receiveHPCIMsg()" src="https://cc.hostedpci.com/iSynSApp/showPxyPage!ccFrame.action?pgmode1=prod&locationName=javasample1&sid=528160&fullParentHost=http://localhost:8799&fullParentQStr=/form.jsp" style="border:none" height="61"> 
								If you can see this, your browser doesn't understand IFRAME. 
								</iframe>
							</div><!-- row -->
							<!-- Input row (exp, month, cvv) -->
							<div class="row">
								<div class="col-xs-5 col-sm-4 col-md-4">
										<label>Expiry MM/YY</label>
										<!-- id is used in confirmation.jsp -->
								</div>
							</div><!-- row -->
							<!-- Input row (exp, month, cvv) -->
							<div class="row">
								<div class="col-xs-2 col-sm-2 col-md-2">
									<input type="text" id="expiryMonth" name="expiryMonth"
										size="3" placeholder="MM">
								</div>
								<div class="col-xs-2 col-sm-2 col-md-2">		
									<!-- id is used in confirmation.jsp -->
									<input type="text" id="expiryYear" name="expiryYear"
										size="3" placeholder="YY">
								</div>
							</div><!-- row -->
						</fieldset>
						<br />
						<fieldset>
							<legend>Personal Information</legend>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>First Name:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="firstName" type="text" name="firstName">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Last Name:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="lastName" type="text" name="lastName">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Address Line 1:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="address1" type="text" name="address1">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Address Line 2:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="address2" type="text" name="address1">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>City:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="city" type="text" name="address1">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>State / Province:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="state" type="text" name="address1">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Zip / Postal Code:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="zip" type="text" name="address1">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Country:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<select id="country" name="country">
										<option value="CAN">Canada</option>
										<option value="US">United States</option>
									</select>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Payment Comments:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="comment" type="text" name="comment">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Payment Reference:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="merchantRefId" type="text" name="merchantRefId">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Currency:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<select id="currency" name="currency">
										<option value="CAD">Canadian Dollar</option>
										<option value="USD">US Dollar</option>
									</select>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Payment Amount:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<input id="amount" type="text" name="amount">
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-4">
									<label>Payment Profile:</label>
								</div>
								<div class="col-xs-4 col-sm-3 col-md-5">
									<select id="paymentProfile" name="paymentProfile">
										<option value="DEF">DEF - Currency: USD</option>
										<option value="DEF_MONERIS">DEF_MONERIS - Currency: CAD</option>
										<option value="DEF_MONERIS">DEF_MONERIS - Currency: USD</option>
									</select>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6 col-sm-3 col-md-4">
									<!-- Submit button -->
									<button type="submit" value="Submit" class="btn btn-primary"
										onClick='return sendHPCIMsg();'>Process Payment</button>
								</div>	
								<div class="col-xs-6 col-sm-3 col-md-4">
									<!-- Reset button -->
									<button id="paymentResetButton" type="button" value="Reset Payment" class="btn btn-primary">Reset Payment</button><br />
								</div>
							</div>
							<br />
							<div class="row">
								<div class="col-xs-6 col-sm-3 col-md-4">
									<!-- Back button -->
									<input Type="button" class="btn btn-primary" value="Back" onClick="history.go(-1);return true;"></input>
								</div>
							</div>
							<div class="row">
								<!-- Hidden rows that are required by the iframe -->
								<div class="col-xs-6 col-sm-3 col-md-4">
									<input type="hidden" id="ccNum" name="ccNum" value="" class="form-control"> 
									<input type="hidden" id="ccCVV" name="ccCVV" value="" class="form-control"> 
									<input type="hidden" id="ccBIN" name="ccBIN" value="" class="form-control">
								</div>
							</div>
						</fieldset>	
					</fieldset><!-- Outer fieldset -->
				</form>
			</div><!-- col-md-7 col-centered -->
		</div><!-- row -->
	</div><!-- container -->
</body>
</html>