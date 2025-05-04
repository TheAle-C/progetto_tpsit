<%@page import="com.mywebapp.servlets.user_profile.UserData"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.mywebapp.servlets.Cart.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
Cookie cookie = null;
double cartTotalPrice = 0f;

%>

<%
//-------------------------------------------------------------------------------------------- Verifica sessione
Cookie[] cookies = request.getCookies();

if (cookies != null) {
    for (Cookie tmp : cookies) {
        if ("email".equals(tmp.getName()) && tmp.getValue() != null && !tmp.getValue().isEmpty()) {
            cookie = tmp;
            break;
        }
    }
}
//--------------------------------------------------------------------------------------------
if (cookie == null) {
	response.sendRedirect("../index.jsp");
}
else if (!cookie.getValue().equals("admin@admin")) {
	response.sendRedirect("../index.jsp");
}
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStore | Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="CSS/admin.css">
</head>
<body>
    <aside class="admin-sidebar">
        <div class="sidebar-header">
            <button class="toggle-sidebar">
                <i class="fas fa-bars"></i>
            </button>
            <h2>Admin Panel</h2>
        </div>
        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="AdminArea?section=products">
                    <i class="fas fa-shopping-bag"></i>
                    <span>Prodotti</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="AdminArea?section=orders">
                    <i class="fas fa-truck"></i>
                    <span>Ordini</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="AdminArea?section=users" class="active">
                    <i class="fas fa-users"></i>
                    <span>Clienti</span>
                </a>
            </li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header">
            <h1>Gestione Clienti</h1>
            <div class="user-menu">
                <div class="user-profile">
                    <div class="user-avatar">AM</div>
                    <span>Admin Manager</span>
                </div>
            </div>
        </header>

        <div class="admin-content">
            <!-- Tabella Clienti -->
            <div class="form-section">
                <h2>Elenco Clienti</h2>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th></th>
                            <th>ID Cliente</th>
                            <th>Nome</th>
                            <th>Cognome</th>
                            <th>Email</th>
                            <th>Data Nascita</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <%ArrayList<UserData> list = (ArrayList<UserData>) request.getAttribute("userList");
				        if (list != null) {
				       		for (UserData userData : list) {%>
		                        <tr>
		                            <td><div class="customer-avatar"><%= "" + userData.first_name.toUpperCase().charAt(0) + userData.last_name.toUpperCase().charAt(0) %></div></td>
		                            <td><%= userData.id %></td>
		                            <td><%= userData.first_name %></td>
		                            <td><%= userData.last_name %></td>
		                            <td><%= userData.email %></td>
		                            <td><%= userData.birth_date %></td>
		                        </tr>
			            	<%}
			          	}%>
                        
                    </tbody>
                </table>
            </div>
        </div>

        <div class="loader-container">
            <div class="bouncing-loader">
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
            </div>
        </div>
    </main>

    <script>
     
        window.addEventListener('load', () => {
        const loader = document.querySelector('.loader-container');
        
            setTimeout(() => {
                loader.classList.add('hidden');
                
                // Rimuovi dopo l'animazione
                setTimeout(() => {
                    loader.remove();
                }, 1200);
            }, 600);
        });
    </script>
</body>
</html>