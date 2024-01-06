<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Transaction Page</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        h1{
            margin-top:3cm;
            margin-left:12cm;
        }
        #b2{
            margin-left:8cm;
        }
        #b1{
            margin-left:9cm;
        }
        #p1{
        margin-left:90%;
        }
    </style>
</head>
<body>
    <%-- Retrieve userid from the session --%>
    <% String userid = (String) request.getSession().getAttribute("userid"); %>
        <%-- Display userid in the HTML --%>
    <p id="p1">Welcome, <%= userid %></p>
    <!-- AJAX OPERATIONS Add a new script tag for handling AJAX requests -->
	<script>
	    function checkBalance() {
	        // Get userid from the session
	        var userid = '<%= userid %>';
	
	        // Create an XMLHttpRequest object
	        var xhr = new XMLHttpRequest();
	
	        // Configure it to make a GET request to a servlet
	        xhr.open("GET", "CheckBalanceServlet?userid=" + encodeURIComponent(userid), true);
	
	        // Define the function to handle the response
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                // Display the balance in the p1 element
	                document.getElementById("p1").innerHTML = "Welcome, " + userid + ". Balance: " + xhr.responseText;
	            }
	        };
	
	        // Send the request
	        xhr.send();
	    }
	</script>

    <h1 style="font-size: 2cm;"><big><b>Transaction Page</b></big></h1></br></br></br><br>

    <form action="CheckBalanceServlet" method="get">

        <div class="btns">
            <button style="font-size: 1.2cm;" type="button" class="btn btn-primary" id="b2" onclick="checkBalance()">Check Balance</button>
            <button style="font-size: 1.2cm;" type="button" class="btn btn-warning" id="b1">Transfer Money</button>
        </div>

    </form>
</body>
</html>
