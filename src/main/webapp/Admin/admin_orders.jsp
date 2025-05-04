<%@page import="com.mywebapp.servlets.admin.OrderSummary"%>
<%@page import="com.mywebapp.servlets.user_profile.Order"%>
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
        <!-- Stesse impostazioni head di admin.html -->
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
                <a href="AdminArea?section=orders" class="active">
                    <i class="fas fa-truck"></i>
                    <span>Ordini</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="AdminArea?section=users">
                    <i class="fas fa-users"></i>
                    <span>Clienti</span>
                </a>
            </li>
        </ul>
    </aside>
    <!-- Sidebar (come nelle pagine precedenti con active su Ordini) -->
    
    <main class="admin-main">
        <header class="admin-header">
            <h1>Gestione Ordini</h1>
            <div class="user-menu">
                <div class="user-profile">
                    <div class="user-avatar">AM</div>
                    <span>Admin Manager</span>
                </div>
            </div>
        </header>

        <div class="admin-content">

			<!-- Prodotti piÃ¹ venduti -->
            <div class="form-section">
                <h2>Prodotti più Venduti</h2>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th>Quantità Venduta</th>
                            <th>Prezzo per unità</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <%ArrayList<Product> prodList = (ArrayList<Product>) request.getAttribute("mostSelledProd");
				        if (prodList != null) {
				       		for (Product tmp : prodList) {%>
		                        <tr>
		                            <td><%= tmp.name %></td>
		                            <td><%= tmp.quantity %></td>
		                            <td><%= tmp.price %> €</td>
		                        </tr>
			            	<%}
			          	}%>
                    </tbody>
                </table>
            </div>

            <!-- Ultimi 5 Ordini -->
            <div class="form-section">
                <h2>Ordini</h2>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID Ordine</th>
                            <th>Cliente</th>
                            <th>Data</th>
                            <th>Totale</th>
                            <th>Stato</th>
                            <th>Azioni</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <%
	                   	ArrayList<OrderSummary> orders = (ArrayList<OrderSummary>) request.getAttribute("orderSummaries");
	                   	if (orders != null) {
	                   		if (!orders.isEmpty()) {
	                   			for (OrderSummary tmp : orders) {
	                  				double totalPrice = 0f;%>
	                  				<tr>
			                            <td><span class="order-link" onclick="viewOrder(<%= tmp.orderId %>)"><%= tmp.orderId %></span></td>
			                            <td><%= tmp.customerName %></td>
			                            <td><%= tmp.orderDate %></td>
			                            <% if (tmp.total < 50) {%>
			                            	<td><%= (tmp.total + 10) %> €</td>
			                            <% } else { %>
			                            	<td><%= tmp.total %> €</td>
			                            <% }
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
			                            <td>
			                                <button class="action-btn view" onclick="window.location.href='AdminArea?section=order_details&idOrder=<%= tmp.orderId %>'">Dettagli</button>
			                            </td>
			                        </tr>
	                   			<%}
	                   		}
	                   	}
	                   	%>
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
        
        // Piccolo ritardo per fluiditÃ 
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