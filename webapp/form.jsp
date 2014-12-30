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
	margin-right: -20px;
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
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>-->
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>-->

	<!-- container class sets the page to use 100% width -->
	<div class="container">
		<!-- row class sets the margins -->
		<div class="row">
			<!-- col-md-4 class uses the bootstrap grid system to use 1/3rd of the left side of the page -->
			<div class="col-md-4">
				<!-- IMPORTANT: id CCAcceptForm needs to match the ID's in the HostedPCI script code -->
				<!-- So if you change this ID, make sure to change it in all other places -->
				<!-- Action points to the servlet -->
				<form id="CCAcceptForm" action="/DemoIframe" method="post">
					<fieldset>
						<!-- Form Name -->
						<legend>Hosted PCI</legend>
						<!-- Text Input -->
						<div id="errorMessage" style="display:none;color:red"><label>Invalid card number, try again</label><br/></div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>First Name</label>
									<!-- id is used in confirmation.jsp -->
									<input id="firstName" name="firstName" type="text"
										class="form-control" placeholder="First Name">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Last Name</label>
									<!-- id is used in confirmation.jsp -->
									<input id="lastName" name="lastName" type="text"
										class="form-control" placeholder="Last Name">
								</div>
							</div>
						</div>
						<!-- Select credit card -->
						<label for="cardType">Card Type</label>
						<div class="form-group">
							<!-- id is used in confirmation.jsp -->
							<select id="cardType" name="cardType" class="selectpicker">
								<option value="visa">Visa</option>
								<option value="mastercard">MasterCard</option>
								<option value="amex">American Express</option>
							</select>
						</div>
						<!-- iframe -->
						<div class="row">
							<div class="form-group">
								<iframe seamless id="ccframe" name="ccframe" onload="receiveHPCIMsg()" src="https://cc.hostedpci.com/iSynSApp/showPxyPage!ccFrame.action?pgmode1=prod&locationName=javasample1&sid=528160&fullParentHost=http://localhost:8799&fullParentQStr=/form.jsp" style="border:none" height="61"> 
								If you can see this, your browser doesn't understand IFRAME. 
								</iframe>
							</div>
						</div>
						<!-- Input row (exp, month, cvv) -->
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label>Expiry Month</label>
									<!-- id is used in confirmation.jsp -->
									<input type="text" id="expiryMonth" name="expiryMonth"
										class="form-control" placeholder="MM">
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>Expiry Year</label>
									<!-- id is used in confirmation.jsp -->
									<input type="text" id="expiryYear" name="expiryYear"
										class="form-control" placeholder="YY">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label>Amount</label>
									<!-- id is used in confirmation.jsp -->
									<input type="text" id="amount" name="amount"
										class="form-control" placeholder="Amount">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label>Merchant Reference Number</label>
									<!-- id is used in confirmation.jsp -->
									<input type="text" id="merchantRefId" name="merchantRefId"
										class="form-control" placeholder="Merchant Reference Number">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label>Comments</label>
									<!-- id is used in confirmation.jsp -->
									<input type="text" id="comment" name="comment"
										class="form-control" placeholder="Comments">
								</div>
							</div>
						</div>
						<!-- Hidden rows that are required by the iframe -->
						<div class="form-group">
							<input type="hidden" id="ccNum" name="ccNum" value="" class="form-control"> 
							<input type="hidden" id="ccCVV" name="ccCVV" value="" class="form-control"> 
							<input type="hidden" id="ccBIN" name="ccBIN" value="" class="form-control">
						</div>
						<!-- Submit button -->
						<button type="submit" value="Submit" class="btn btn-primary"
							onClick='return sendHPCIMsg();'>Pay Now</button>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</body>
</html>