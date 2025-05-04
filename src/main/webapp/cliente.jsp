<%@page import="java.util.Locale"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.mywebapp.servlets.user_profile.Order"%>
<%@page import="com.mywebapp.servlets.user_profile.UserData"%>
<%@page import="com.mywebapp.servlets.Cart.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
UserData userData = null;
%>

<%
//-------------------------------------------------------------------------------------------- Verifica email
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

if (request.getAttribute("user_data") != null) {
	userData = (UserData) request.getAttribute("user_data");
}
else {
	response.sendError(404);
}
//--------------------------------------------------------------------------------------------
%>

<!DOCTYPE html>
<html lang="it">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>TecnoStore | Profilo Cliente</title>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	    <link rel="stylesheet" href="CSS/clienti.css">
	</head>
	<body>
	    <!-- Sidebar Semplificata -->
	    <aside class="admin-sidebar">
	        <div class="sidebar-header">
	            <h2>Il Mio Account</h2>
	        </div>
	        <ul class="sidebar-menu">
	            <li class="sidebar-item">
	                <a href="#" class="active">
	                    <i class="fas fa-user"></i>
	                    <span>Profilo</span>
	                </a>
	            </li>
	            <li class="sidebar-item">
	                <a href="UserArea?section=orders">
	                    <i class="fas fa-box-open"></i>
	                    <span>I Miei Ordini</span>
	                </a>
	            </li>
	        </ul>
	    </aside>
	
	    <!-- Main Content -->
	    <main class="admin-main">
	        <!-- Header -->
	        <header class="admin-header">
	            <h1>Profilo Cliente</h1>
	            <div class="user-menu">
	                <div class="user-profile">
	                    <div class="user-avatar"><%= "" + userData.first_name.toUpperCase().charAt(0) + userData.last_name.toUpperCase().charAt(0) %></div>
	                    <span><%= userData.first_name + " " + userData.last_name %></span>
	                    <i class="fas fa-sign-out-alt action-icon" 
	                        	role="button" 
	                        	tabindex="0"
	                        	onclick="window.location.href='logout.jsp'"
	                            aria-label="Logout"></i>
	                </div>
	            </div>
	        </header>
	
	        <!-- Contenuto Profilo -->
	        <div class="admin-content">
	            <!-- Sezione Dati Personali Unificata -->
	            <div class="form-section">
	                <div class="form-header">
	                    <h2><i class="fas fa-id-card"></i> Dati Personali</h2>
	                    <button class="btn btn-primary">
	                        <i class="fas fa-edit"></i> Modifica Profilo
	                    </button>
	                </div>
	                <div class="form-row">
	                    <div class="form-group">
	                        <label>Nome</label>
	                        <div class="form-control-static"><%= userData.first_name %></div>
	                    </div>
	                    <div class="form-group">
	                        <label>Cognome</label>
	                        <div class="form-control-static"><%= userData.last_name %></div>
	                    </div>
	                </div>
	                <div class="form-row">
	                    <div class="form-group">
	                        <label>Email</label>
	                        <div class="form-control-static"><%= userData.email %></div>
	                    </div>
	                    <div class="form-group">
	                        <label>Data di Nascita</label>
	                        <div class="form-control-static"><%= userData.birth_date %></div>
	                    </div>
	                </div>
	            </div>
	
	            <!-- Storico Ordini -->
	            <div class="form-section">
	                <h2><i class="fas fa-history"></i> Storico Acquisti</h2>
	                <table class="data-table">
	                    <thead>
	                        <tr>
	                            <th>Ordine</th>
	                            <th>Data</th>
	                            <th>Prodotti</th>
	                            <th>Totale</th>
	                            <th>Stato</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<%
	                    	ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("user_ordes");
	                    	if (request.getAttribute("user_ordes") != null) {
	                    		if (!orders.isEmpty()) {
	                    			for (Order tmp : orders) {
                    					double totalPrice = 0f;
	                    			%>
	                    				<tr>
				                            <td><%= tmp.id %></td>
				                            <td><%= tmp.order_date.format(DateTimeFormatter.ofPattern("d MMMM yyyy", Locale.ITALIAN)) %></td>
				                            <td><% 
					                            for (Product _tmp : tmp.products) {
			                   						totalPrice += _tmp.price; %>
			                   						<a href="ViewProduct?id=<%= _tmp.id %>"><%= _tmp.name %></a><br>
			                   					<% }%>
				                            </td>
				                            <% if (totalPrice < 50f) totalPrice += 10f; %>
				                            <td><%= String.format("%.2f", totalPrice) %> €</td>
				                            <%
			                            	switch (tmp.status) {
			                            		case "Consegnato": {
			                            			%><td><span class="status completed"><%= tmp.status %></span></td><%
			                            			break;
			                            		}
			                            		case "In elaborazione": {
			                            			%><td><span class="status pending"><%= tmp.status %></span></td><%
			                            			break;
			                            		}
			                            		case "Spedito": {
			                            			%><td><span class="status shipped"><%= tmp.status %></span></td><%
			                            			break;
			                            		}
			                            		case "Annulato": {
			                            			%><td><span class="status cancelled"><%= tmp.status %></span></td><%
			                            			break;
			                            		}
			                            	}
				                            %>
				                        </tr>
	                    			<%}
	                    		}
	                    	}
	                    	%>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	
	        <!-- Loader -->
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
	        // Animazione Loader
	        window.addEventListener('load', () => {
	            const loader = document.querySelector('.loader-container');
	            setTimeout(() => {
	                loader.classList.add('hidden');
	                setTimeout(() => {
	                    loader.remove();
	                }, 1200);
	            }, 600);
	        });
	
	        // Highlight Menu Attivo
	        const menuItems = document.querySelectorAll('.sidebar-item a');
	        menuItems.forEach(item => {
	            item.addEventListener('click', function() {
	                menuItems.forEach(i => i.classList.remove('active'));
	                this.classList.add('active');
	            });
	        });
	    </script>
	</body>
</html>