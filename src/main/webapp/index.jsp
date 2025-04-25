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
    
	<script>
		<!-- CARICAMENTO MOST SELLED PRODUCT CARD -->
		loadMostSelledProduct();
		
		<!-- CARICAMENTO NEW PRODUCT CARD -->
		loadNewProduct();
		
	</script>

    <meta charset="UTF-8">
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
                <li><a href="#">Telefonia</a></li>
                <li><a href="#">TV</a></li>
                <li><a href="#">Cuffie</a></li>
                <li><a href="#">Supporto</a></li>
            </ul>
            <div class="header-actions">
                <div class="input-group search-input">
                    <input type="text" required>
                    <i class="fas fa-search"></i>
                </div>
                <div class="actions-container">
                    <div class="cart-wrapper">
                        <i class="fas fa-shopping-bag action-icon" id="cart-icon"></i>
                        <span class="cart-counter">3</span>
                        <div class="cart-dropdown hidden">
                            <div class="cart-header">
                                <h4>Il tuo carrello</h4>
                                <span class="cart-items-count">3 articoli</span>
                            </div>
                            <div class="cart-items" id="miniCartProducts">
                                <% if (isLoggedIn) {%>
                                	
                                <% } else {
                                	if (session.getAttribute("Cart") != null) {
                    					ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("Cart");
                    					
                    					cartTotalPrice = 0;
                    					int items = 0;
                    					
                    		            for (Product _tmp : list) {
                    		            	cartTotalPrice += _tmp.price;
                    		            	if (items < 8) { 
                    		            		items ++;%>
												<div class="cart-item">
	                    		            	    <img src="<%= _tmp.image %>" alt="<%= _tmp.name %>">
												    <div class="item-details">
												        <h5><%= _tmp.name %></h5>
												        <div class="quantity-controls">
												            <button class="quantity-btn minus">-</button>
												            <span class="quantity">1</span>
												            <button class="quantity-btn plus" onclick="">+</button>
												        </div>
												        <p class="item-price" data-price="<%= _tmp.price %>">€<%= _tmp.price %></p>
												    </div>
												    <button class="remove-item">&times;</button>
												</div>
									  	  <%}
                    		            }
                                	}
                                } %>

                                <!-- Altri items... -->
                            </div>
                            <div class="cart-total">
                                <span>Totale:</span>
                                <span class="total-amount"></span>
                            </div>
                            <button class="btn">Checkout</button>
                        </div>
                    </div>
                    
					<% if (isLoggedIn) {%>
						<i class="fas fa-user action-icon" 
	                        role="button" 
	                        tabindex="0"
	                        onclick="window.location.href=''"
	                        aria-label="Accedi al tuo account"></i>
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

    <section class="hero">
        <div class="hero-content">
            <h1 class="floating-element">Innovazione<br>senza confini</h1>
        </div>
    </section>

    <section class="products-section">
        <h2 class="section-title">Prodotti più popolari</h2>
	    <div class="products-grid" id="mostSelledProductsGrid">
            <!-- PRODOTTI PIù VENDUTI -->
	    </div>
    </section>
    
    <section class="products-section">
        <h2 class="section-title">Ultimi arrivati</h2>
        <div class="products-grid" id="newProductsGrid">
            <!-- PRODOTTI PIù RECENTI -->
        </div>
    </section>
    
    <footer>
        <div class="footer-container">
            <div class="footer-top">
                <div class="footer-brand">
                    <h3 class="footer-logo">TecnoStore</h3>
                    <p class="footer-tagline">Innovazione e qualitÃ  dal 2020</p>
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
                        <li><a href="#">Centro assistenza</a></li>
                        <li><a href="#">Guida all'acquisto</a></li>
                        <li><a href="#">Garanzia</a></li>
                        <li><a href="#">Resi e rimborsi</a></li>
                        <li><a href="#">Contatti</a></li>
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
});








// Gestione apertura/chiusura carrello
const cartIcon = document.getElementById('cart-icon');
    const cartDropdown = document.querySelector('.cart-dropdown');

    cartIcon.addEventListener('click', (e) => {
        e.stopPropagation();
        cartDropdown.classList.toggle('active');
    });

    document.addEventListener('click', (e) => {
        if(!cartDropdown.contains(e.target) && !cartIcon.contains(e.target)) {
            cartDropdown.classList.remove('active');
        }
    });

    // Chiudi con ESC
    document.addEventListener('keydown', (e) => {
        if(e.key === 'Escape') {
            cartDropdown.classList.remove('active');
        }
    });


    // Gestione quantitÃ 
    document.querySelectorAll('.quantity-btn').forEach(button => {
        button.addEventListener('click', () => {
            const item = button.closest('.cart-item');
            const quantityElement = item.querySelector('.quantity');
            let quantity = parseInt(quantityElement.textContent);
            const priceElement = item.querySelector('.item-price');
            const unitPrice = parseFloat(priceElement.dataset.price);

            if(button.classList.contains('plus')) {
                quantity++;
            } else {
                quantity = quantity > 1 ? quantity - 1 : 1;
            }

            quantityElement.textContent = quantity;
            priceElement.textContent = `€${(unitPrice * quantity).toFixed(2)}`;
            
            updateCartTotals();
        });
    });

    // Aggiorna totali
    function updateCartTotals() {
        let total = 0;
        let totalItems = 0;

        document.querySelectorAll('.cart-item').forEach(item => {
            const quantity = parseInt(item.querySelector('.quantity').textContent);
            const unitPrice = parseFloat(item.querySelector('.item-price').dataset.price);
            total += quantity * unitPrice;
            totalItems += quantity;
        });

        document.querySelector('.total-amount').textContent = `€${total.toFixed(2)}`;
        document.querySelector('.cart-items-count').textContent = `${totalItems > 7 ? '7+' : totalItems} articol${totalItems !== 1 ? 'i' : 'o'}`;
        document.querySelector('.cart-counter').textContent = totalItems > 7 ? '7+' : totalItems;
    }

    // Inizializza carrello
    updateCartTotals();


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