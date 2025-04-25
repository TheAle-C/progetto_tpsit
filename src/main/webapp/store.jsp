<%@page import="com.mywebapp.servlets.Cart.Product"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Store</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
        }
        .store-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }
        .product-card {
            border: 1px solid #ccc;
            padding: 15px;
            width: 250px;
            text-align: center;
        }
        .product-card img {
            max-width: 100%;
            height: auto;
        }
        .product-name {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }
        .product-price {
            font-size: 16px;
            color: green;
            margin-top: 5px;
        }
        .view-button {
            margin-top: 10px;
            padding: 8px 12px;
            background-color: #007bff;
            color: white;
            border: none;
            text-decoration: none;
            display: inline-block;
        }
    </style>
</head>
<body>

<h1>Store</h1>

<div class="store-grid">
    <%
        List<Product> products = (List<Product>) request.getAttribute("productList");
        if (products != null) {
            for (Product p : products) {
    %>
        <div class="product-card">
            <img src="<%= p.image %>" alt="<%= p.name %>">
            <div class="product-name"><%= p.name %></div>
            <div class="product-price"><%= String.format("%.2f", p.price) %> €</div>
			<button onclick="window.location.href='ViewProduct?id=<%= p.id %>'">Visualizza</button>
        </div>
    <%
            }
        } else {
    %>
        <p>Nessun prodotto trovato.</p>
    <%
        }
    %>
</div>

</body>
</html>
