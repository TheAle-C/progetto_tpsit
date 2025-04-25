<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Cookie[] cookies = request.getCookies();

if (cookies != null) {
	for (Cookie tmp : cookies) {
		if ((tmp.getName()).compareTo("email") == 0) {
			response.sendRedirect("index.jsp");
		}
	}
}
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStore | Premium Electronics</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="CSS/regStyle.css">

</head>
<body>
    <header>
        <nav class="nav-container">
            <a href="index.jsp" class="logo">Tecno</a>
        </nav>
    </header>

    <section class="auth-hero">
        <div class="auth-container">
            <div class="auth-card floating-element">
                <h2>Crea un account</h2>
                
                <form class="auth-form" action="verifyRegister" method="post">
                    <div class="double-input">
                        <div class="input-group">
                            <input type="text" id="nome" name="nameInput" required>
                            <label for="nome">Nome</label>
                            <i class="fas fa-user icon"></i>
                        </div>
                        <div class="input-group">
                            <input type="text" id="cognome" name="surnameInput" required>
                            <label for="cognome">Cognome</label>
                            <i class="fas fa-user icon"></i>
                        </div>
                    </div>
    
                    <div class="input-group">
                        <input type="text" id="username" name="usernameInput" required>
                        <label for="username">Username</label>
                        <i class="fas fa-user-tag icon"></i>
                    </div>
    
                    <div class="input-group">
                        <input type="email" id="email" name="emailInput" required>
                        <label for="email">Email</label>
                        <i class="fas fa-envelope icon"></i>
                    </div>
    
                    <div class="input-group">
                        <input type="date" id="data-nascita" name="dateInput" required>
                        <i class="fas fa-calendar icon"></i>
                    </div>
    
                    <div class="input-group">
                        <input type="password" id="password" name="passwordInput" required>
                        <label for="password">Password</label>
                        <i class="fas fa-lock icon"></i>
                    </div>
                    
                    <!-- Messaggi di errore -->
                    <div id="msgError">
                        <%
                            String msg = (String) request.getAttribute("messaggio");
                            if (msg != null) {
                                %><label class="error_msg">Lo username inserito o la password sono errati!</label><%
                            }
                        %>
                    </div>
                    
                    <div class="form-options">
	                    <label class="remember-me">
	                        <input type="checkbox" name="rememberMeInput">
	                        <span>Ricordami</span>
	                    </label>
                    </div>

                    <button type="submit" class="btn btn-full">Registrati ora</button>
    
                    <p class="auth-switch">Hai giÃ  un account? <a href="index.jsp">Accedi ora</a></p>
                </form>
            </div>
        </div>
    </section>
</body>
</html>