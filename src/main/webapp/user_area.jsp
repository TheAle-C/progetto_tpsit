<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
Cookie[] cookies = request.getCookies();

if (cookies != null) {
    for (Cookie tmp : cookies) {
        if ("email".equals(tmp.getName())) {
        	if (tmp.getValue() == null || tmp.getValue().isEmpty()) {
        		response.sendRedirect("login.jsp");
                break;
        	}
        }
    }
}

%>

<html>
	<head>
	    <title>Area Utente</title>
	    <style>
	        body {
	            font-family: Arial, sans-serif;
	            padding: 40px;
	            background-color: #f4f4f4;
	        }
	        .container {
	            background-color: white;
	            padding: 30px;
	            border-radius: 8px;
	            max-width: 600px;
	            margin: auto;
	            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
	        }
	        h1 {
	            color: #333;
	        }
	        .info {
	            margin: 20px 0;
	            font-size: 18px;
	        }
	        .buttons {
	            margin-top: 30px;
	        }
	        .buttons button {
	            padding: 10px 20px;
	            font-size: 16px;
	            margin-right: 15px;
	            background-color: #007bff;
	            color: white;
	            border: none;
	            border-radius: 4px;
	            cursor: pointer;
	        }
	        .buttons button.logout {
	            background-color: #dc3545;
	        }
	    </style>
	</head>
	<body>
	
	<div class="container">
        <h1>Ciao, !</h1>
        <div class="info">
            <strong>Email:</strong> <br>
        </div>

        <div class="buttons">
            <button onclick="window.location.href='modificaProfilo.jsp'">Modifica Profilo</button>
            <button onclick="window.location.href='cart.jsp'">Vai al Carrello</button>
            <button onclick="window.location.href='store'">Vai allo Store</button>
            <button class="logout" onclick="window.location.href='logout.jsp'">Esci</button>
        </div>
	</div>
	
	</body>
</html>
