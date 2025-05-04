<%@page import="com.mywebapp.servlets.Cart.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
Cookie cookie = null;
double cartTotalPrice = 0f;

%>

<%

//-------------------------------------------------------------------------------------------- Verifica sessione
boolean isLoggedIn = false;

Cookie[] cookies = request.getCookies();

if (cookies != null) {
    for (Cookie tmp : cookies) {
        if ("email".equals(tmp.getName()) && tmp.getValue() != null && !tmp.getValue().isEmpty()) {
            isLoggedIn = true;
            cookie = tmp;
            break;
        }
    }
}
//--------------------------------------------------------------------------------------------

%>


<!DOCTYPE html>
<html lang="it">
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="JavaScript/index.js"></script>

    <meta charset="UTF-16">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStore | Premium Electronics</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <header>
        <nav class="nav-container">
            <a href="#" class="logo">Tecno</a>
            <ul class="nav-links">
                <li><a href="Search?name=&sorting=1&category=1">Telefonia</a></li>
                <li><a href="Search?name=&sorting=1&category=3">TV</a></li>
                <li><a href="Search?name=&sorting=1&category=2">Cuffie</a></li>
                <li><a href="support.jsp">Supporto</a></li>
            </ul>
            <div class="header-actions">
                <div class="search-input">
                    <input type="text" required>
                    <i class="fas fa-search"></i>
                </div>
                <div class="actions-container">
					<% if (isLoggedIn) {%>
						<i class="fas fa-user action-icon" 
	                        role="button" 
	                        tabindex="0"
	                        onclick="window.location.href='UserArea'"
	                        aria-label="Accedi al tuo account"></i>
                        <i class="fas fa-sign-out-alt action-icon" 
                        	role="button" 
                        	tabindex="0"
                        	onclick="window.location.href='logout.jsp'"
                            aria-label="Logout"></i>
	                <% } else {%>
						<i class="fas fa-user action-icon" 
	                        role="button" 
	                        tabindex="0"
	                        onclick="window.location.href='login.jsp'"
	                        aria-label="Accedi al tuo account"></i>
	                <% }%>
                </div>
            </div>
        </nav>
    </header>

    <main class="checkout-container">
        <div class="checkout-grid">
            <!-- Sezione Informazioni -->
            <section class="checkout-form">
                <h2 class="section-title">Indirizzo Spedizione</h2>
                
                <form class="payment-form">                    
                    <div class="form-group">
                        <label>Via/Piazza</label>
                        <input type="text" required class="form-input">
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>CittÃ </label>
                            <input type="text" required class="form-input">
                        </div>
                        <div class="form-group">
                            <label>CAP</label>
                            <input type="number" required class="form-input">
                        </div>
                    </div>
                </form>
            </section>

            <!-- Riepilogo ordine -->
            <aside class="order-summary">
                <h2 class="section-title">Il tuo ordine</h2>
                
                <div class="summary-items">
                	<%
                	double cartTotalPrice = 0f;
                	if (session.getAttribute("Cart") != null) {
     					ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("Cart");
     					
     					cartTotalPrice = 0;
     					int items = 0;
     					
     		            for (Product _tmp : list) {
     		            	cartTotalPrice += _tmp.price;
     		            	items ++;
     		            	if (items < 8) {%>
     		            	<div class="summary-item">
		                       <img src="<%= _tmp.image %>" alt="<%= _tmp.name %>">
		                       <div class="item-details">
		                           <h4><%= _tmp.name %></h4>
		                           <p>€<%= _tmp.price %></p>
		                       </div>
		                   </div>
					  	  <%}
      		            }
                  	}%>
                
                    
                    <!-- Altri items -->
                </div>

                <div class="summary-totals">
                    <div class="total-row">
                        <span>Subtotale:</span>
                        <span>€<%= String.format("%.2f", cartTotalPrice) %></span>
                    </div>
                    <div class="total-row">
                        <span>Spedizione:</span>
                        <% if (cartTotalPrice < 50) { 
                        	cartTotalPrice += 10f; %>
                        	<span>€10</span>
                        <%} else {%>
                        	<span>Gratuita</span>
                        <% } %>
                    </div>
                    <div class="total-row grand-total">
                        <span>Totale:</span>
                        <span>€<%= String.format("%.2f", cartTotalPrice) %></span>
                    </div>
                </div>

				<% if (isLoggedIn) {%>
                	<button class="btn btn-primary" onclick="window.location.href='OrderConfirmed'">Conferma ordine</button>
                <% } else { %>
                	<button class="btn btn-primary" onclick="window.location.href='login.jsp'">Conferma ordine</button>
                <% } %>
            </aside>
        </div>
    </main>


    <footer>
        <div class="footer-container">
            <div class="footer-top">
                <div class="footer-brand">
                    <h3 class="footer-logo">TecnoStore</h3>
                    <p class="footer-tagline">Innovazione e qualità  dal 2020</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
    
                <div class="footer-col">
                    <h4 class="footer-title">Prodotti</h4>
                    <ul>
                        <li><a href="#">Smartphone</a></li>
                        <li><a href="#">Laptop</a></li>
                        <li><a href="#">TV & Home Cinema</a></li>
                        <li><a href="#">Accessori</a></li>
                        <li><a href="#">Offerte speciali</a></li>
                    </ul>
                </div>
    
                <div class="footer-col">
                    <h4 class="footer-title">Supporto</h4>
                    <ul>
                        <li><a href="support.jsp">Centro assistenza</a></li>
                        <li><a href="shopping_guide.jsp">Guida all'acquisto</a></li>
                        <li><a href="warranty_support.jsp">Garanzia</a></li>
                        <li><a href="returns_refunds.jsp">Resi e rimborsi</a></li>
                        <li><a href="contacts.jsp">Contatti</a></li>
                    </ul>
                </div>
    
                <div class="footer-col">
                    <h4 class="footer-title">Contatti</h4>
                    <ul class="contact-info">
                        <li><i class="fas fa-phone"></i> +39 02 1234567</li>
                        <li><i class="fas fa-envelope"></i> info@tecnostore.it</li>
                        <li><i class="fas fa-map-marker-alt"></i> Via Roma 123, Milano</li>
                    </ul>
                </div>
            </div>
    
            <div class="footer-bottom">
                <div class="newsletter">
                    <h4>Iscriviti alla newsletter</h4>
                    <form class="newsletter-form">
                        <input type="email" placeholder="La tua email" required>
                        <button type="submit">Iscriviti <i class="fas fa-arrow-right"></i></button>
                    </form>
                </div>
                
                <div class="legal-links">
                    <p>&copy; 2024 TecnoStore. Tutti i diritti riservati</p>
                    <div>
                        <a href="#">Privacy Policy</a>
                        <a href="#">Termini e condizioni</a>
                        <a href="#">Cookie Settings</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <div class="loader-container">
        <div class="bouncing-loader">
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
        </div>
    </div>
</body>

<script>


document.addEventListener('DOMContentLoaded', function() {
    const searchIcon = document.querySelector('.search-input i');
    const searchInput = document.querySelector('.search-input');
    const searchField = searchInput.querySelector('input');

    searchIcon.addEventListener('click', (e) => {
        e.stopPropagation();
        searchInput.classList.toggle('active');
        if(searchInput.classList.contains('active')) {
            searchField.focus();
        }
    });

    document.addEventListener('click', (e) => {
        if(!searchInput.contains(e.target)) {
            searchInput.classList.remove('active');
        }
    });

    // Chiudi con ESC
    document.addEventListener('keydown', (e) => {
        if(e.key === 'Escape') {
            searchInput.classList.remove('active');
        }
    });


    searchField.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            const value = searchField.value.trim();
            if (value) {
                window.location.href = 'Search?name=' + encodeURIComponent(value) + "&sorting=" + sortSelect.value;
            }
            else {
            	window.location.href = 'Search?name=' + "&sorting=" + sortSelect.value;
            }
        }
    });

});

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
</html>