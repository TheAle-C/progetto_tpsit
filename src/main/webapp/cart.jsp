<%@page import="com.mywebapp.servlets.Cart.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%! double cartTotalPrice = 0; %>

<html lang="it">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Carrello</title>
	</head>
	<body>
	
	    <h2>Il tuo Carrello</h2>
	
	    <table border="1" cellpadding="10" cellspacing="0">
	        <thead>
	            <tr>
	                <th>Immagine</th>
	                <th>Nome prodotto</th>
	                <th>Prezzo</th>
	                <th>Azioni</th>
	            </tr>
	        </thead>
	        <tbody>
	            <% 
	            if (session.getAttribute("Cart") != null) {
					ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("Cart");
					
					cartTotalPrice = 0;
		            for (Product _tmp : list) { 
		            	cartTotalPrice += _tmp.price; %>
			            <tr>
			                <td><img src="<%= _tmp.image %>" alt="Prodotto 1" width="100"></td>
			                <td><a href="ViewProduct?id=<%= _tmp.id %>"><%= _tmp.name %></a></td>
			                <td><%= _tmp.price %></td>
			                <td>
				                <a href="RemoveToCart?id=<%= _tmp.id %>" >Rimuovi</a>
			                </td>
			            </tr>
		            <% }
	            } %>
	        </tbody>
	    </table>
	
	    <hr>
	
	    <!-- Totale carrello -->
	    <h3>Totale carrello: <%= String.format("%.2f", cartTotalPrice) %>€</h3>
	
	    <!-- Pulsante per procedere al checkout -->
	    <a href="">
	        <button>Procedi al Checkout</button>
	    </a>
	
	</body>
</html>
