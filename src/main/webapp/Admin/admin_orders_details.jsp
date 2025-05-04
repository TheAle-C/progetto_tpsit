<%@page import="com.mywebapp.servlets.admin.OrderDetails"%>
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
    <!-- Sidebar -->
    
    <main class="admin-main">
        <header class="admin-header">
            <h1>Dettaglio Ordine #<span id="orderId"></span></h1>
            <div class="user-menu">
                <!-- Stesso user menu -->
            </div>
        </header>

        <div class="admin-content">
        <% OrderDetails order = (OrderDetails) request.getAttribute("order_details");
        if (order != null) {%>
            <!-- Info Ordine -->
            <div class="form-section">
                <h2>Informazioni Ordine</h2>
                <div class="form-row">
                    <div class="form-group">
                        <label>Cliente</label>
                        <p id="customerName"><%= order.customerName %></p>
                    </div>
                    <div class="form-group">
                        <label>Data Ordine</label>
                        <p id="orderDate"><%= order.orderDate %></p>
                    </div>
                    <div class="form-group">
                        <label>Stato</label>
                        <%
                           	switch (order.status) {
                           		case "Consegnato": {
                           			%><td><span class="status completed"><%= order.status %></span></td><%
                           			break;
                           		}
                           		case "In elaborazione": {
                           			%><td><span class="status pending"><%= order.status %></span></td><%
                           			break;
                           		}
                           		case "Spedito": {
                           			%><td><span class="status shipped"><%= order.status %></span></td><%
                           			break;
                           		}
                           		case "Annulato": {
                           			%><td><span class="status cancelled"><%= order.status %></span></td><%
                           			break;
                           		}
                           	}
	                    %>
                    </div>
                    <div class="form-group">
                        <label>Totale</label>
                        <p id="orderTotal"><%= order.total %></p>
                    </div>
                </div>
            </div>

            <!-- Prodotti Acquiresti -->
            <div class="form-section">
                <h2>Prodotti Acquistati</h2>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th>Quantità </th>
                            <th>Prezzo Unitario</th>
                            <th>Totale</th>
                        </tr>
                    </thead>
                    <tbody id="orderProducts">
                    <% for (Product tmp : order.products) {%>
                        <tr>
                            <td><%= tmp.name %></td>
                            <td><%= tmp.quantity %></td>
                            <td><%= tmp.price %> €</td>
                            <td><%= tmp.description %> €</td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
        	<div class="form-section">
                <div class="btn-group">
                    <button class="btn btn-secondary" onclick="window.history.back()">Torna Indietro</button>
                </div>
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