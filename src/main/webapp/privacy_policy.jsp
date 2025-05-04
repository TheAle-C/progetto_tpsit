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
	            <a href="index.jsp" class="logo">Tecno</a>
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
	                    <div class="cart-wrapper">
	                        <i class="fas fa-shopping-bag action-icon" id="cart-icon"></i>
	                        <span class="cart-counter">3</span>
	                        <div class="cart-dropdown hidden">
	                            <div class="cart-header">
	                                <h4>Il tuo carrello</h4>
	                                <span class="cart-items-count">3 articoli</span>
	                            </div>
	                            <div class="cart-items" id="miniCartProducts">
	                                <% //if (isLoggedIn) {%>
	                                	
	                                <% //} else {
	                                	if (session.getAttribute("Cart") != null) {
	                    					ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("Cart");
	                    					
	                    					cartTotalPrice = 0;
	                    					int items = 0;
	                    					
	                    		            for (Product _tmp : list) {
	                    		            	cartTotalPrice += _tmp.price;
	                    		            	items ++;
	                    		            	if (items < 8) { 
	                    		            		%>
													<div class="cart-item" id="cart-item">
		                    		            	    <img src="<%= _tmp.image %>" alt="<%= _tmp.name %>">
													    <div class="item-details">
													        <h5><%= _tmp.name %></h5>
													        <p class="item-price" data-price="<%= _tmp.price %>">€<%= _tmp.price %></p>
													    </div>
													    <button class="remove-item">&times;</button>
													</div>
										  	  <%}
	                    		            }
	                                	}
	                                //} %>
	
	                                <!-- Altri items... -->
	                            </div>
	                            <div class="cart-total">
	                                <span>Totale:</span>
	                                <span class="total-amount" id="total-amount"><%= String.format("%.2f", cartTotalPrice) %>€</span>
	                            </div>
	                            <button class="btn" onclick="window.location.href='checkout.jsp'">Checkout</button>
	                        </div>
	                    </div>
	                    
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

    <section class="legal-section">
        <div class="content-container">
            <h1 class="section-title">Privacy Policy</h1>
            
            <div class="legal-text">
                <h2>1. Informazioni sulla raccolta dei dati</h2>
                <p>Raccogliamo e processiamo i seguenti tipi di dati personali:</p>
                <ul>
                    <li>Dati di registrazione (nome, email, indirizzo)</li>
                    <li>Dati di transazione (cronologia acquisti, metodi di pagamento)</li>
                    <li>Dati tecnici (indirizzo IP, dispositivo, browser)</li>
                    <li>Cookie e dati di tracciamento</li>
                </ul>
    
                <h2>2. FinalitÃ  del trattamento</h2>
                <p>I dati vengono utilizzati per:</p>
                <ul>
                    <li>Erogazione dei servizi acquistati</li>
                    <li>Comunicazioni di servizio</li>
                    <li>Miglioramento dell'esperienza utente</li>
                    <li>Analisi marketing (solo con consenso esplicito)</li>
                </ul>
    
                <h2>3. Condivisione con terze parti</h2>
                <p>Condividiamo dati solo con:</p>
                <ul>
                    <li>Partner di pagamento certificati (Stripe, PayPal)</li>
                    <li>Servizi logistici per la spedizione</li>
                    <li>AutoritÃ  competenti su richiesta legale</li>
                </ul>
    
                <h2>4. Diritti dell'utente</h2>
                <p>In accordo con il GDPR hai diritto a:</p>
                <ul>
                    <li>Accesso e portabilitÃ  dei dati</li>
                    <li>Rettifica e cancellazione</li>
                    <li>Limitazione del trattamento</li>
                    <li>Opposizione al trattamento</li>
                    <li>Revoca del consenso</li>
                </ul>
            </div>
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
                        <a href="privacy_policy.jsp">Privacy Policy</a>
                        <a href="terms_conditions.jsp">Termini e condizioni</a>
                        <a href="cookies_settings.jsp">Cookie Settings</a>
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
	// Inizializza carrello
	updateCartTotal();
	//updateCartPrice();
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