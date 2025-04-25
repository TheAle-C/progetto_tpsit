<%@page import="java.util.ArrayList"%>
<%@page import="com.mywebapp.servlets.Cart.Product"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Dettaglio Prodotto</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
            }
            .product-container {
                display: flex;
                align-items: flex-start;
                gap: 30px;
            }
            .product-image img {
                max-width: 400px;
                border: 1px solid #ccc;
                padding: 5px;
            }
            .product-details {
                max-width: 600px;
            }
            .product-name {
                font-size: 32px;
                font-weight: bold;
            }
            .product-price {
                font-size: 24px;
                color: #007b00;
                margin-top: 10px;
            }
            .product-description {
                margin-top: 20px;
                font-size: 18px;
            }
        </style>
    </head>
    <body>

    <%
    	Product product = (Product) request.getAttribute("product");
    
        if (product != null) {
    %>
        <div class="product-container">
            <div class="product-image">
                <img src="<%= product.image %>" alt="Immagine di <%= product.name %>">
            </div>
            <div class="product-details">
                <div class="product-name"><%= product.name %></div>
                <div class="product-price"><%= String.format("%.2f", product.price) %> €</div>
                <div class="product-description"><%= product.description %></div>
            </div>
        </div>

    <%
        } else {
    %>
        <p>Nessun prodotto selezionato.</p>
    <%
        }
    %>

    </body>
</html>
