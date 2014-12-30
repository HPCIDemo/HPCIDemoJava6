package com.isyn;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import com.srccodes.example.WebServlet;

@SuppressWarnings("serial")
// physical url for the servlet
@WebServlet("/DemoIframe")
public class DemoIframe extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// Preprocess request: we actually don't need to do any business stuff,
		// so just display JSP.
		// During load, get page from this jsp file "form.jsp".
		request.getRequestDispatcher("/form.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// Postprocess request: gather and validate submitted data and display
		// result in same JSP.
		// Here on happens once we click the submit button

		// Get request parameters from form.jsp (all the attributes that the
		// user inputs)
		String cardNumber = request.getParameter("ccNum");
		String cardCVV = request.getParameter("ccCVV");
		String expiryMonth = request.getParameter("expiryMonth");
		String expiryYear = request.getParameter("expiryYear");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String cardType = request.getParameter("cardType");
		String amount = request.getParameter("amount");
		String merchantRefId = request.getParameter("merchantRefId");

		// Setup request param map
		Map<String, String> hpciRequestParamMap = new LinkedHashMap<String, String>();

		// Populate hpciRequestParamMap with all the needed pairs of information
		hpciRequestParamMap.put("apiVersion", "1.0.1");
		hpciRequestParamMap.put("apiType", "pxyhpci");

		// The username is given by HostedPCI
		hpciRequestParamMap.put("userName", "sampqa1stgAdmAPI");

		// The passkey is given by HostedPCI
		hpciRequestParamMap.put("userPassKey", ".OQdIHVtVJSg-W-Zr40QQGY1xyhvGjUH");

		// Continue to populate hpciRequestParamMap with all the required
		// information
		hpciRequestParamMap.put("pxyCreditCard.cardType", cardType);
		hpciRequestParamMap.put("pxyCreditCard.creditCardNumber", cardNumber);
		hpciRequestParamMap.put("pxyCreditCard.expirationMonth", expiryMonth);
		hpciRequestParamMap.put("pxyCreditCard.expirationYear", expiryYear);
		hpciRequestParamMap.put("pxyCreditCard.cardCodeVerification", cardCVV);
		hpciRequestParamMap.put("pxyTransaction.txnAmount", amount);
		hpciRequestParamMap.put("pxyTransaction.txnCurISO", "USD");
		hpciRequestParamMap.put("pxyTransaction.merchantRefId", merchantRefId);
		hpciRequestParamMap.put("pxyTransaction.txnPayName", "DEF");
		hpciRequestParamMap.put("pxyCustomerInfo.email", "email@email.com");
		hpciRequestParamMap.put("pxyCustomerInfo.customerId", "111");
		hpciRequestParamMap.put("pxyCustomerInfo.billingLocation.firstName", firstName);
		hpciRequestParamMap.put("pxyCustomerInfo.billingLocation.lastName", lastName);
		hpciRequestParamMap.put("pxyCustomerInfo.billingLocation.address", "1 Main St.");
		hpciRequestParamMap.put("pxyCustomerInfo.billingLocation.city", "New York");
		hpciRequestParamMap.put("pxyCustomerInfo.billingLocation.state", "NY");
		hpciRequestParamMap.put("pxyCustomerInfo.billingLocation.zipCode", "10044");
		hpciRequestParamMap.put("pxyCustomerInfo.billingLocation.country", "USA");

		// Assuming the full request param map is ready
		// Url string is made of the api url which is given by
		// HostedPCI + "iSynSApp/paymentAuth.action"
		String urlString = "https://api-sampqa1stg.c1.hostedpci.com/iSynSApp/paymentAuth.action";

		// Uses the callUrl method to initiate the call to HostedPCI using the
		// iframe,
		// It requires the complete url and the populated map
		String callResponse = callUrl(urlString, hpciRequestParamMap);

		// Uses the parseQueryString method to collect the response from
		// HostedPCI
		// And pass the resulting map in a parameter "map" to be used in the
		// confirmation.jsp file
		request.setAttribute("map", parseQueryString(callResponse));

		// Pass all the information that was collected to the confirmation page
		// "confirmation.jsp"
		request.getRequestDispatcher("/confirmation.jsp").forward(request, response);

		// END: of doPost
	}

	// The callUrl method, it needs a complete url + populated map of pairs
	// (key,value)
	public static String callUrl(String urlString, Map<String, String> paramMap) {
		String urlReturnValue = "";
		try {
			// Construct data
			StringBuffer dataBuf = new StringBuffer();
			boolean firstParam = true;
			for (String paramKey : paramMap.keySet()) {
				if (!firstParam)
					dataBuf.append("&");
				dataBuf.append(URLEncoder.encode(paramKey, "UTF-8"))
						.append("=")
						.append(URLEncoder.encode(paramMap.get(paramKey),
								"UTF-8"));
				firstParam = false;
			}
			String data = dataBuf.toString();

			// Send data
			URL url = new URL(urlString);
			URLConnection conn = url.openConnection();
			conn.setDoOutput(true);
			OutputStreamWriter wr = new OutputStreamWriter(
					conn.getOutputStream());
			wr.write(data);
			wr.flush();

			// Get the response
			BufferedReader rd = new BufferedReader(new InputStreamReader(
					conn.getInputStream()));
			String line;
			while ((line = rd.readLine()) != null) {
				urlReturnValue = urlReturnValue + line;
			}
			wr.close();
			rd.close();
		} catch (Exception e) {
			e.printStackTrace();
			urlReturnValue = "";
		}
		return urlReturnValue;
	} // END: callUrl

	// The parseQueryString method, it uses the response from the callUrl method
	// And puts it inside a map of pairs
	public static Map<String, String> parseQueryString(String queryStr) {
		Map<String, String> map = new LinkedHashMap<String, String>();
		String queryStrDecoded = "";
		if (queryStr == null)
			return map;

		try {
			queryStrDecoded = URLDecoder.decode(queryStr, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String[] params = queryStrDecoded.split("&");
		for (String param : params) {
			String name = "";
			String value = "";

			String[] paramPair = param.split("=");
			if (paramPair != null && paramPair.length > 0) {
				name = paramPair[0];
				if (paramPair.length > 1 && paramPair[1] != null) {
					try {
						if (paramPair.length == 2) {
							value = URLDecoder.decode(paramPair[1], "UTF-8");
						} else // paramPair.length >= 3
						{
							value = URLDecoder.decode(
									paramPair[paramPair.length - 1], "UTF-8");
						}

					} catch (UnsupportedEncodingException e) {
						logMessage("Could not decode:" + paramPair[1]);
					}
				}
			}
			map.put(name, value);
		}
		return map;
	} // END: parseQueryString

	// Needed for the callUrl and parseQueryString methods
	public static void logMessage(String msg) {
		System.out.println(msg);
	}
}