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
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <header>
        <nav class="nav-container">
            <a href="index.jsp" class="logo">Tecno</a>
            <ul class="nav-links">
                <li><a href="Search?name=&sorting=1&category=1">Telefonia</a></li>
                <li><a href="Search?name=&sorting=1&category=3">TV</a></li>
                <li><a href="Search?name=&sorting=1&category=2">Cuffie</a></li>
                <li><a href="support.jsp">Supporto</a></li>
            </ul>
            <div class="header-actions">
                <i class="fas fa-search action-icon"></i>
                <i class="fas fa-shopping-bag action-icon"></i>
                <i class="fas fa-user action-icon"></i>
            </div>
        </nav>
    </header>

    <section class="auth-hero">
        <div class="auth-container">
            <div class="auth-card floating-element">
                <h2>Accedi al tuo account</h2>
                
                <form class="auth-form" action="verifyLogin" method="post">
                    <div class="input-group">
                        <input type="email" id="email" name="emailInput" required>
                        <label for="email">Email</label>
                        <i class="fas fa-envelope icon"></i>
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

                    <!-- Opzioni aggiuntive -->
                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" name="rememberMeInput">
                            <span>Ricordami</span>
                        </label>
                        <a href="#" class="forgot-password">Password dimenticata?</a>
                    </div>

                    <button type="submit" class="btn btn-full">Accedi ora</button>

                    <p class="auth-switch">Nuovo cliente? <a href="registrazione.jsp">Crea un account</a></p>
                </form>
            </div>
        </div>
    </section>
</body>
</html>