// --------------------------------------------------------------------------------------------------------------------- HOME PAGE: MINI CART
function addToCart(productId) {
    // Recupera il prodotto selezionato tramite l'ID del prodotto
	$.ajax({
        url: "AddToCart",  // URL del tuo servlet
        method: "GET",
        data: {
            IdProduct: productId
        },
        success: function(response) {
			alert("Prodotto aggiunto al carello!");
			
			updateCart(response[0]); // attenzione, viene ritornato un array
        },
        error: function() {
            alert("Errore durante l'aggiunta al carrello.");
        }
    });
}


function removeItem(productId) {
    const button = event.target;
    const cartItem = button.closest('.cart-item');
    cartItem.remove();
	updateCartPrice();
	updateCartTotal();
	
	$.ajax({
        url: "RemoveToCart",  // URL del tuo servlet
        method: "GET",
        data: {
            IdProduct: productId
        },
        success: function() {
			alert("Prodotto rimosso dal carello!");
        },
        error: function() {
            alert("Errore durante al rimozione dal carrello.");
        }
    });
}

function updateCart(response) {
	console.log("Risposta ricevuta:", response);
	
	const cart = document.getElementById('miniCartProducts');

	if (cart.querySelectorAll('.cart-item').length < 7) {
		const card = document.createElement('div');
		card.className = 'cart-item';
		
		card.innerHTML = `
    	    <img src="${response.image}" alt="${response.name}">
		    <div class="item-details">
		        <h5>${response.name}</h5>
		        <p class="item-price" data-price="${response.price}">€${response.price}</p>
		    </div>
		    <button class="remove-item">&times;</button>
        `;
		cart.appendChild(card);
	}

	updateCartTotal();
	document.getElementById('total-amount').textContent = `€${response.totalCart.toFixed(2)}`;
}

function countItemsInCart() {
    let totalItems = 0;
	console.log("num of items in cart (countItemsInCart()): " +  document.querySelectorAll('.cart-item').length);
    document.querySelectorAll('.cart-item').forEach(item => {
        totalItems += 1;
    });

    return totalItems;
}

function updateCartPrice() {
    let total = 0;    
	document.querySelectorAll('.cart-item').forEach(item => {
        const unitPrice = parseFloat(item.querySelector('.item-price').dataset.price);
        total += unitPrice;
    });
	
	document.querySelector('.total-amount').textContent = `€${total.toFixed(2)}`;
}

function updateCartTotal() {
    let totalItems = 0;
    
	document.querySelectorAll('.cart-item').forEach(item => {
		totalItems ++;
    });

    document.querySelector('.cart-items-count').textContent = `${totalItems > 6 ? '7+' : totalItems} articol${totalItems !== 1 ? 'i' : 'o'}`;
    document.querySelector('.cart-counter').textContent = totalItems > 6 ? '7+' : totalItems;
}

// --------------------------------------------------------------------------------------------------------------------- HOME PAGE: PRODUCT
function loadMostSelledProduct() {
	document.addEventListener('DOMContentLoaded', function() {
	    console.log("(MostSelledProd:) Pagina caricata, lancio fetch...");
	    fetch('LoadMostSelledProductsServlet')
	        .then(response => {
	            console.log("(MostSelledProd:) Risposta arrivata:", response);
	            return response.json();
	        })
	        .then(products => {
	            console.log("(MostSelledProd:) Prodotti ricevuti:", products);
	            const grid = document.getElementById('mostSelledProductsGrid');
	            grid.innerHTML = '';

	            products.forEach(product => {
	                const card = document.createElement('div');
	                card.className = 'product-card';

	                card.innerHTML = `
	                    <a href="ViewProduct?id=${product.id}"><img src="${product.image}" class="product-image" alt="${product.name}"></a>
	                    <h3>${product.name}</h3>
	                    <p class="product-price">${product.price} €</p>
	                    <input type="hidden" name="IdProduct" value="${product.id}">
	                    <button class="btn" onclick="addToCart(${product.id})">Acquista ora</button>
	                `;

	                grid.appendChild(card);
	            });
	        })
	        .catch(error => {
	            console.error("(MostSelledProd:) Errore nel caricamento dei prodotti:", error);
	        });
	});
}

function loadNewProduct() {
	document.addEventListener('DOMContentLoaded', function() {
	    console.log("(NewProd:) Pagina caricata, lancio fetch...");
	    fetch('LoadNewProductsServlet')
	        .then(response => {
	            console.log("(NewProd:) Risposta arrivata:", response);
	            return response.json();
	        })
	        .then(products => {
	            console.log("(NewProd:) Prodotti ricevuti:", products);
	            const grid = document.getElementById('newProductsGrid');
	            grid.innerHTML = '';

	            products.forEach(product => {
	                const card = document.createElement('div');
	                card.className = 'product-card';

	                card.innerHTML = `
	                    <img src="${product.image}" class="product-image" alt="${product.name}">
	                    <h3>${product.name}</h3>
	                    <p class="product-price">${product.price} €</p>
	                    <input type="hidden" name="IdProduct" value="${product.id}">
	                    <button class="btn" onclick="addToCart(${product.id})">Acquista ora</button>
	                `;

	                grid.appendChild(card);
	            });
	        })
	        .catch(error => {
	            console.error("(NewProd:) Errore nel caricamento dei prodotti:", error);
	        });
	});
}

// ------------------------------------------------------------------------------------------------------------------------- COOKIES
function sendCookiePreference() {
    // Raccogli il valore della checkbox "Cookie Analitici"
    const analyticsCookie = document.getElementById("analytics-cookies").checked;
    // Raccogli il valore della checkbox "Cookie di Marketing"
    const marketingCookie = document.getElementById("marketing-cookies").checked;

	// Recupera il prodotto selezionato tramite l'ID del prodotto
	$.ajax({
        url: "UpdateCookiesPreferences",  // URL del tuo servlet
        method: "GET",
        data: {
            AnalyticsCookie: analyticsCookie,
			MarketingCookie: marketingCookie
        },
        success: function(response) {
			
        },
        error: function() {
            alert("Errore durante l'aggiornamento dei cookies");
        }
    });
}
// ------------------------------------------------------------------------------------------------------------------------- 