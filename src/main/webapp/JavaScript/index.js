

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

			updateCartTotals();
			
			if (countItemsInCart() > 8) {
			}
			else {
				updateCart(response[0]); // attenzione, viene ritornato un array
			}
        },
        error: function() {
            alert("Errore durante l'aggiunta al carrello.");
        }
    });
}

function updateCart(response) {
	console.log("Risposta ricevuta:", response);
	
	const cart = document.getElementById('miniCartProducts');
	
	const card = document.createElement('div');
    card.className = 'cart-item';

    card.innerHTML = `
		<img src="${response.image}" alt="${response.name}">
	    <div class="item-details">
	        <h5>${response.name}</h5>
	        <div class="quantity-controls">
	            <button class="quantity-btn minus">-</button>
	            <span class="quantity">1</span>
	            <button class="quantity-btn plus" onclick="">+</button>
	        </div>
	        <p class="item-price" data-price="${response.price}">€${response.price}</p>
	    </div>
	    <button class="remove-item">&times;</button>
    `;

    cart.appendChild(card);
}

function countItemsInCart() {
    let totalItems = 0;

    document.querySelectorAll('.cart-item').forEach(item => {
        const quantity = parseInt(item.querySelector('.quantity').textContent);
        totalItems += quantity;
    });

    return totalItems;
}

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
	                    <p class="product-price">${product.price} $</p>
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
