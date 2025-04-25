<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
Cookie cookie = null;

// -------------------------------------------------------------------------------------------- DA IMPLEMENTARE
Integer[] mostSelledProductId = { 
		0,
		1,
		2
};
String[] mostSelledProduct = { 
		"A",
		"B",
		"C"
};
String[] mostSelledProductImage = {
		"https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2",
		"https://images.unsplash.com/photo-1537589376225-5405c60a5bd8",
		"https://images.unsplash.com/photo-1520333789090-1afc82db536a"
};
String[] mostSelledProductPrice = {
		"1.99",
		"2.99",
		"3.99"
};

Integer[] newProductId = { 
		3,
		4,
		5
};
String[] newProduct = {
		"A2",
		"B2",
		"C2"
};
String[] newProductImage = {
		"https://images.unsplash.com/photo-1603302576837-37561b2e2302",
		"https://images.unsplash.com/photo-1588872657578-7efd1f1555ed",
		"https://images.unsplash.com/photo-1555774698-0b77e0d5fac6"
};
String[] newProductPrice = {
		"10.99",
		"20.99",
		"30.99"
};
//--------------------------------------------------------------------------------------------
%>

<%
//-------------------------------------------------------------------------------------------- Verifica sessione
boolean isLoggedIn = false;

Cookie[] cookies = request.getCookies();

if (cookies != null) {
    for (Cookie tmp : cookies) {
        if ("email".equals(tmp.getName()) && tmp.getValue() != null && !tmp.getValue().isEmpty()) {
            isLoggedIn = true;
            break;
        }
    }
}
//--------------------------------------------------------------------------------------------

%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate">
    <title>TecnoStore | Premium Electronics</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="CSS/home.css">
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="../JavaScript/AddToCart.js"></script>
	
</head>
<body>
    <header>
        <nav class="nav-container">
            <a href="index.jsp" class="logo">Tecno</a>
            <ul class="nav-links">
                <li><a href="store">Store</a></li>
                <li><a href="#">Dispositivi</a></li>
                <li><a href="#">Accessori</a></li>
                <li><a href="#">Supporto</a></li>
            </ul>
            <div class="header-actions">
               	<i class="fas fa-search action-icon"></i>
                
                <% if (isLoggedIn) {%>
	                <a href="cart.jsp" class="fas fa-shopping-bag action-icon"></a>
                	<a href="user_area.jsp" class="fas fa-user action-icon"></a> 
                <% } else {%>
                	<a href="login.jsp"><i class="fas fa-shopping-bag action-icon"></i></a> 
                	<a href="login.jsp"><i class="fas fa-user action-icon"></i></a> 
                <% }%>
                
                
            </div>
        </nav>
    </header>

    <section class="hero">
        <div class="hero-content">
            <h1 class="floating-element">Innovazione<br>senza confini</h1>
        </div>
    </section>

    <section class="products-section">
	    <h2 class="section-title">Prodotti più popolari</h2>
	    <div class="products-grid">
	        <!-- Prodotto 1 -->
	        <div class="product-card">
	            <img src="<%= mostSelledProductImage[0] %>" class="product-image" alt="Laptop Pro">
	            <h3><%= mostSelledProduct[0] %></h3>
	            <p class="product-price"><%= mostSelledProductPrice[0] %> $</p>
	            <!-- Input nascosto per l'ID del prodotto -->
	            <input type="hidden" name="IdProduct" value="<%= mostSelledProductId[0] %>">
	            <button class="btn" onclick="addToCart(<%= mostSelledProductId[0] %>)">Acquista ora</button>
	        </div>
	
	        <!-- Prodotto 2 -->
	        <div class="product-card">
	            <img src="<%= mostSelledProductImage[1] %>" class="product-image" alt="Smartphone X">
	            <h3><%= mostSelledProduct[1] %></h3>
	            <p class="product-price"><%= mostSelledProductPrice[1] %> $</p>
	            <input type="hidden" name="IdProduct" value="<%= mostSelledProductId[1] %>">
	            <button class="btn" onclick="addToCart(<%= mostSelledProductId[1] %>)">Acquista ora</button>
	        </div>
	
	        <!-- Prodotto 3 -->
	        <div class="product-card">
	            <img src="<%= mostSelledProductImage[2] %>" class="product-image" alt="Smartwatch Pro">
	            <h3><%= mostSelledProduct[2] %></h3>
	            <p class="product-price"><%= mostSelledProductPrice[2] %> $</p>
	            <input type="hidden" name="IdProduct" value="<%= mostSelledProductId[2] %>">
	            <button class="btn" onclick="addToCart(<%= mostSelledProductId[2] %>)">Acquista ora</button>
	        </div>
	    </div>
	</section>
	
	<section class="products-section">
	    <h2 class="section-title">Ultimi arrivati</h2>
	    <div class="products-grid">
	        <!-- Prodotto 1 -->
	        <div class="product-card">
	            <img src="<%= newProductImage[0] %>" class="product-image" alt="Cuffie Wireless">
	            <h3><%= newProduct[0] %></h3>
	            <p class="product-price"><%= newProductPrice[0] %> $</p>
	            <input type="hidden" name="IdProduct" value="<%= newProductId[0] %>">
	            <button class="btn" onclick="addToCart(<%= newProductId[0] %>)">Acquista ora</button>
	        </div>
	
	        <!-- Prodotto 2 -->
	        <div class="product-card">
	            <img src="<%= newProductImage[1] %>" class="product-image" alt="Fotocamera 4K">
	            <h3><%= newProduct[1] %></h3>
	            <p class="product-price"><%= newProductPrice[1] %> $</p>
	            <input type="hidden" name="IdProduct" value="<%= newProductId[1] %>">
	            <button class="btn" onclick="addToCart(<%= newProductId[1] %>)">Acquista ora</button>
	        </div>
	
	        <!-- Prodotto 3 -->
	        <div class="product-card">
	            <img src="<%= newProductImage[2] %>" class="product-image" alt="Drone Pro">
	            <h3><%= newProduct[2] %></h3>
	            <p class="product-price"><%= newProductPrice[2] %> $</p>
	            <input type="hidden" name="IdProduct" value="<%= newProductId[2] %>">
	            <button class="btn" onclick="addToCart(<%= newProductId[2] %>)">Acquista ora</button>
	        </div>
	    </div>
	</section>

    
    <footer>
        <div class="footer-container">
            <div class="footer-section">
                <h3>Acquista</h3>
                <ul>
                    <li><a href="#">Mac</a></li>
                    <li><a href="#">iPad</a></li>
                    <li><a href="#">iPhone</a></li>
                    <li><a href="#">Apple Watch</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Servizi</h3>
                <ul>
                    <li><a href="#">Apple Music</a></li>
                    <li><a href="#">Apple TV+</a></li>
                    <li><a href="#">Supporto</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contatti</h3>
                <ul>
                    <li><a href="#">Trova un Store</a></li>
                    <li><a href="#">Chat Online</a></li>
                    <li><a href="#">02 1234567</a></li>
                </ul>
            </div>
        </div>
    </footer>
</body>
</html>