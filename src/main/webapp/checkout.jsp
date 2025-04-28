<%@page import="java.util.List"%>
<%@page import="com.mywebapp.servlets.Cart.Product"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.util.*"%>
<%@ page session="true" %>

<%! double totaleProdotti = 0.0; %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="CSS/tmpCheckout.css"></link>
</head>
<body>

<div class="checkout-container">
    <div class="checkout-left">
        <h2>Checkout</h2>

        <div class="checkout-section">
            <h3>Dati di spedizione</h3>
            <form id="checkoutForm">
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" required>

                <label for="cognome">Cognome</label>
                <input type="text" id="cognome" name="cognome" required>

                <label for="indirizzo">Indirizzo</label>
                <input type="text" id="indirizzo" name="indirizzo" required>

                <label for="città">Città</label>
                <input type="text" id="città" name="città" required>

                <label for="cap">CAP</label>
                <input type="text" id="cap" name="cap" required>

                <label for="telefono">Telefono</label>
                <input type="tel" id="telefono" name="telefono">

                <label for="note">Note per la consegna</label>
                <textarea id="note" name="note" rows="3"></textarea>
            </form>

        <button class="checkout-button" onclick="confermaOrdine()">Conferma Ordine</button>
    </div>

    <div class="checkout-right">
        <h3>Il tuo carrello</h3>
        <div id="cartProducts" class="cart-products-list">
        <%
            Cookie[] cookies = request.getCookies();
            String email = null;
            
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("email".equals(cookie.getName())) {
                        email = cookie.getValue();
                        break;
                    }
                }
            }

            if (email != null) {
                List<Product> cart = (List<Product>) session.getAttribute("Cart");
                totaleProdotti = 0f;

                if (cart != null && !cart.isEmpty()) {
                    for (Product prodotto : cart) {
        %>
                        <div class="cart-product">
                            <img src="<%= prodotto.image %>" alt="<%= prodotto.name %>">
                            <div class="cart-product-details">
                                <h4><%= prodotto.name %></h4>
                                <p>$<%= String.format("%.2f", prodotto.price) %> x <%= prodotto.quantity %></p>
                            </div>
                        </div>
        <%
                        totaleProdotti += prodotto.price * prodotto.quantity;
                    }
                } else {
        %>
                    <p>Il carrello è vuoto.</p>
        <%
                }
            } else {
        %>
                <p>Devi essere loggato per vedere il carrello.</p>
        <%
            }
        %>
        </div>

        <!-- Totali -->
        <div class="order-summary">
            <h3>Riepilogo ordine</h3>
            <div class="summary-item">
                <span>Prodotti</span>
                <span id="prodottiTotali">$<%= String.format("%.2f", totaleProdotti) %></span>
            </div>
            <div class="summary-item">
                <span>Spedizione</span>
                <span id="spedizione">$5.00</span>
            </div>
            <div class="summary-item" style="font-weight: bold;">
                <span>Totale</span>
                <span id="totaleFinale">$<%= String.format("%.2f", (totaleProdotti + 5.00)) %></span>
            </div>
        </div>
    </div>
</div>

<script>
    function confermaOrdine() {
        const form = document.getElementById('checkoutForm');

        if (form.checkValidity()) {
            alert("Ordine confermato! 🎉 Grazie per il tuo acquisto!");
            form.reset();
        } else {
            alert("Compila tutti i campi obbligatori!");
        }
    }
</script>

</body>
</html>
