<%@page import="java.util.HashMap"%>
<%@page import="com.mywebapp.servlets.Cart.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
Cookie cookie = null;
double cartTotalPrice = 0f;

%>

<%
//-------------------------------------------------------------------------------------------- Verifica sessione
Cookie[] cookies = request.getCookies();

if (cookies != null) {
    for (Cookie tmp : cookies) {
        if ("email".equals(tmp.getName()) && tmp.getValue() != null && !tmp.getValue().isEmpty()) {
            cookie = tmp;
            break;
        }
    }
}
//--------------------------------------------------------------------------------------------
if (cookie == null) {
	response.sendRedirect("../index.jsp");
}
else if (!cookie.getValue().equals("admin@admin")) {
	response.sendRedirect("../index.jsp");
}
%>
<!DOCTYPE html>
<html lang="it">
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Stesse impostazioni head di admin.html -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStore | Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="CSS/admin.css">
</head>
<body>
    <aside class="admin-sidebar">
        <div class="sidebar-header">
            <button class="toggle-sidebar">
                <i class="fas fa-bars"></i>
            </button>
            <h2>Admin Panel</h2>
        </div>
        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="AdminArea?section=products" class="active">
                    <i class="fas fa-shopping-bag"></i>
                    <span>Prodotti</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="AdminArea?section=orders">
                    <i class="fas fa-truck"></i>
                    <span>Ordini</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="AdminArea?section=users">
                    <i class="fas fa-users"></i>
                    <span>Clienti</span>
                </a>
            </li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header">
            <h1>Gestione Prodotti</h1>
            <div class="user-menu">
                <div class="notification">
                <div class="user-profile">
                    <div class="user-avatar">AM</div>
                    <span>Admin Manager</span>
                </div>
            </div>
        </header>

        <div class="admin-content">
            <!-- Pulsante Nuovo Prodotto -->
            <button class="btn btn-primary" id="btnNewProduct" style="margin-bottom: 2rem;">
                <i class="fas fa-plus"></i> Nuovo Prodotto
            </button>

            <!-- Form Prodotto -->
            <div class="form-section" id="productForm" style="display: none;">
                <h2 id="formTitle">Nuovo Prodotto</h2>
                <form id="productFormContent">
                <input type="hidden" id="productId">
                    <div class="form-group">
					    <label>URL Immagine del prodotto</label>
					    <input type="url" class="form-control" id="imageURL" placeholder="https://esempio.com/immagine.jpg">
					    <img src="#" class="image-preview" id="imagePreview" style="display: none; margin-top: 10px;">
					</div>


                    <div class="form-row">
                        <div class="form-group">
                            <label>Marca</label>
                            <input type="text" class="form-control" id="brand" required>
                        </div>
                        <div class="form-group">
                            <label>Nome Prodotto</label>
                            <input type="text" class="form-control" id="productName" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Descrizione</label>
                        <textarea class="form-control" id="description" rows="3"></textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Prezzo (€)</label>
                            <input type="number" class="form-control" id="price" step="0.01" required>
                        </div>
                        <div class="form-group">
                            <label>Quantità </label>
                            <input type="number" class="form-control" id="quantity" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Catalogo</label>
                        <select class="form-control" id="categorySelect">
		                	<%HashMap<Integer, String> catList = (HashMap<Integer, String>) request.getAttribute("Categories");
					        if (catList != null) {
					       		for (int tmp : catList.keySet()) {%>
									<option value="<%= tmp %>"><%= catList.get(tmp) %></option>
				            	<%}
				          	}%>
		                </select>
                    </div>

                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">Salva</button>
                        <button type="button" class="btn btn-secondary" id="cancelEdit">Annulla</button>
                    </div>
                </form>
            </div>

            <!-- Card Prodotti -->
            <div class="form-section">
                <h2>Catalogo Prodotti</h2>
                <div class="cards-grid" id="productsGrid">
                    <%ArrayList<Product> list = (ArrayList<Product>) request.getAttribute("productList");
			        if (list != null) {
			       		for (Product tmp : list) {%>
							<div class="product-card fade-in" id="<%= tmp.id %>">
		                        <img src="<%= tmp.image %>" class="product-image" alt="<%= tmp.name %>">
		                        <div class="product-details">
		                            <div class="product-detail-item" id="prod_detail_id">
		                                <span>ID:</span>
		                                <span><%= tmp.id %></span>
		                            </div>
		                            <div class="product-detail-item" id="prod_detail_brand">
		                                <span>Marca:</span>
		                                <span><%= tmp.marca %></span>
		                            </div>
		                            <div class="product-detail-item" id="prod_detail_name">
		                                <span>Nome:</span>
		                                <span><%= tmp.name %></span>
		                            </div>
		                            <div class="product-detail-item" id="prod_detail_price">
		                                <span>Prezzo:</span>
		                                <span><%= tmp.price %> €</span>
		                            </div>
		                            <div class="product-detail-item" id="prod_detail_stock">
		                                <span>Quantità:</span>
		                                <span><%= tmp.quantity %></span>
		                            </div>
		                            <div class="product-detail-item" id="prod_detail_catalog">
		                                <span>Catalogo:</span>
		                                <span><%= tmp.catalog %></span>
		                            </div>
		                        </div>
		                        <div class="card-actions">
		                            <button class="action-btn edit" >Modifica</button>
		                            <button class="action-btn delete">Elimina</button>
	                        </div>
	                    </div>
		            	<%}
		          	}%>
                </div>
            </div>
        </div>

        <div class="loader-container">
            <div class="bouncing-loader">
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
            </div>
        </div>
    </main>

    <script>
        // Animazione Form
        const productForm = document.getElementById('productForm');
        const btnNewProduct = document.getElementById('btnNewProduct');
        const cancelEdit = document.getElementById('cancelEdit');

        btnNewProduct.addEventListener('click', () => {
            productForm.style.display = 'block';
            productForm.classList.add('fade-in');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });

        cancelEdit.addEventListener('click', () => {
            productForm.style.display = 'none';
            productForm.classList.remove('fade-in');
            document.getElementById('productFormContent').reset();
            document.getElementById('imagePreview').style.display = 'none';
        });


        // Gestione Prodotti
        let products = [];
        let currentProductId = 1;

        document.getElementById('productFormContent').addEventListener('submit', (e) => {
            e.preventDefault();

            const product = {
                id: document.getElementById('productId').value,
                brand: document.getElementById('brand').value,
                name: document.getElementById('productName').value,
                description: document.getElementById('description').value,
                price: parseFloat(document.getElementById('price').value).toFixed(2),
                quantity: document.getElementById('quantity').value,
                category: document.getElementById('categorySelect').value,
                image: document.getElementById('imagePreview').src || 'placeholder.jpg'
            };

            if (product.id) {
                updateProduct(product); // 🔄 modifica
            } else {
                createProductCard(product); // ➕ nuovo
            }
        });


        function createProductCard(product) {
        	console.log(product)
        	
        	id = 0;
        	
        	$.ajax({
                url: "CreateProduct",  // URL del tuo servlet
                method: "POST",
                data: {
					productBrand: product.brand,
					productName: product.name,
					productDescription: product.description,
					productPrice: product.price,
					productQuantity: product.quantity,
					productCategory: product.category,
					productImage: product.image
                },
                success: function(response) {
        			console.log("ADMIN - createProductCard(): " + response);
                	alert("Prodotto aggiunto! ID_PRODOTTO: " + response);
                	
                	product.id = response;
                	
                	const card = document.createElement('div');
                    card.className = 'product-card fade-in';
                    card.innerHTML = `
                        <img src="${product.image}" class="product-image" alt="${product.name}">
                        <div class="product-details">
                            <div class="product-detail-item">
                                <span>ID:</span>
                                <span>${product.id}</span>
                            </div>
                            <div class="product-detail-item">
                                <span>Marca:</span>
                                <span>${product.brand}</span>
                            </div>
                            <div class="product-detail-item">
                                <span>Nome:</span>
                                <span>${product.name}</span>
                            </div>
                            <div class="product-detail-item">
                                <span>Prezzo:</span>
                                <span>€${product.price}</span>
                            </div>
                            <div class="product-detail-item">
                                <span>Quantità :</span>
                                <span>${product.quantity}</span>
                            </div>
                            <div class="product-detail-item">
                                <span>Catalogo:</span>
                                <span>${product.category}</span>
                            </div>
                        </div>
                        <div class="card-actions">
                            <button class="action-btn edit">Modifica</button>
                            <button class="action-btn delete">Elimina</button>
                        </div>
                    `;

                    // Aggiungi gestione eventi
                    card.querySelector('.edit').addEventListener('click', () => editProduct(card, product));
                    card.querySelector('.delete').addEventListener('click', () => deleteProduct(card));
                    
                    document.getElementById('productsGrid').prepend(card);
                    
                    productForm.style.display = 'none';
                    currentProductId++;
                    productForm.classList.remove('fade-in');
                    document.getElementById('productFormContent').reset();
                    document.getElementById('imagePreview').style.display = 'none';
                },
                error: function() {
                    alert("Errore durante l'aggiunta.");
                }
            });
        }

        function editProduct(card, product) {
            document.getElementById('productId').value = product.id;
            document.getElementById('brand').value = product.brand;
            document.getElementById('productName').value = product.name;
            document.getElementById('description').value = product.description !== "undefined" ? product.description : "";
            document.getElementById('price').value = product.price;
            document.getElementById('quantity').value = product.quantity;
            
            // Cerca la <option> del select che contiene il testo corrispondente a `product.category`
            const select = document.getElementById('categorySelect');
            const options = Array.from(select.options);
            const matchedOption = options.find(opt => opt.text === product.category);
            if (matchedOption) {
                select.value = matchedOption.value;
            } else {
                select.value = ""; // fallback
            }

            document.getElementById('imageURL').value = product.image;
            const preview = document.getElementById('imagePreview');
            preview.src = product.image;
            preview.style.display = 'block';

            document.getElementById('formTitle').textContent = 'Modifica Prodotto';
            productForm.style.display = 'block';
            productForm.classList.add('fade-in');
            window.scrollTo({ top: 0, behavior: 'smooth' });

            card.remove();
        }
        
        function updateProduct(product) {
        	console.log("Valori da inviare:", product);
            $.ajax({
                url: "EditProduct",
                method: "POST",
                data: {
                    productId: product.id,
                    productBrand: product.brand,
                    productName: product.name,
                    productDescription: product.description,
                    productPrice: product.price,
                    productQuantity: product.quantity,
                    productCategory: product.category,
                    productImage: product.image
                },
                success: function(response) {
                    if (response === "ok") {
                        alert("Prodotto aggiornato con successo!");

                        // Ricrea la card aggiornata
                        const card = document.createElement('div');
                        card.className = 'product-card fade-in';
                        card.innerHTML = `
                            <img src="${product.image}" class="product-image" alt="${product.name}">
                            <div class="product-details">
                                <div class="product-detail-item"><span>ID:</span><span>${product.id}</span></div>
                                <div class="product-detail-item"><span>Marca:</span><span>${product.brand}</span></div>
                                <div class="product-detail-item"><span>Nome:</span><span>${product.name}</span></div>
                                <div class="product-detail-item"><span>Prezzo:</span><span>€${product.price}</span></div>
                                <div class="product-detail-item"><span>Quantità:</span><span>${product.quantity}</span></div>
                                <div class="product-detail-item"><span>Catalogo:</span><span>${product.category}</span></div>
                            </div>
                            <div class="card-actions">
                                <button class="action-btn edit">Modifica</button>
                                <button class="action-btn delete">Elimina</button>
                            </div>
                        `;

                        card.querySelector('.edit').addEventListener('click', () => editProduct(card, product));
                        card.querySelector('.delete').addEventListener('click', () => deleteProduct(card));
                        document.getElementById('productsGrid').prepend(card);

                        // Chiudi il form
                        productForm.style.display = 'none';
                        document.getElementById('productFormContent').reset();
                        document.getElementById('imagePreview').style.display = 'none';
                        document.getElementById('formTitle').textContent = 'Nuovo Prodotto';
                    } else {
                        alert("Errore durante l'aggiornamento del prodotto.");
                    }
                },
                error: function() {
                    alert("Errore AJAX durante l'aggiornamento.");
                }
            });
        }



        function deleteProduct(card) {
            const productId = card.querySelector('.product-detail-item span:nth-child(2)').textContent;

            if (confirm('Sei sicuro di voler eliminare questo prodotto?')) {
                $.ajax({
                    url: "DeleteProduct",
                    method: "POST",
                    data: { productId: productId },
                    success: function(response) {
	                    card.classList.add('fade-out');
	                    setTimeout(() => card.remove(), 300);
	                    alert("Prodotto eliminato con successo.");
                    },
                    error: function(xhr, status, error) {
                        console.error("Errore AJAX:", error);
                        alert("Errore durante la richiesta di eliminazione.");
                    }
                });
            }
        }


        document.getElementById('imageURL').addEventListener('input', () => {
            const url = document.getElementById('imageURL').value;
            const preview = document.getElementById('imagePreview');
            if (url) {
                preview.src = url;
                preview.style.display = 'block';
            } else {
                preview.style.display = 'none';
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
        
        window.addEventListener('load', () => {
            const loader = document.querySelector('.loader-container');

            // Rimuove loader
            setTimeout(() => {
                loader.classList.add('hidden');
                setTimeout(() => {
                    loader.remove();
                }, 1200);
            }, 600);

            // ✅ Aggiunta eventi per prodotti già presenti
            document.querySelectorAll('.product-card').forEach(card => {
                const editBtn = card.querySelector('.edit');
                const deleteBtn = card.querySelector('.delete');

                const product = {
                    id: card.querySelector('.product-detail-item:nth-child(1) span:nth-child(2)').textContent,
                    brand: card.querySelector('.product-detail-item:nth-child(2) span:nth-child(2)').textContent,
                    name: card.querySelector('.product-detail-item:nth-child(3) span:nth-child(2)').textContent,
                    price: card.querySelector('.product-detail-item:nth-child(4) span:nth-child(2)').textContent.replace('€', ''),
                    quantity: card.querySelector('.product-detail-item:nth-child(5) span:nth-child(2)').textContent,
                    category: card.querySelector('.product-detail-item:nth-child(6) span:nth-child(2)').textContent,
                    image: card.querySelector('img').src
                };

                editBtn.addEventListener('click', () => editProduct(card, product));
                deleteBtn.addEventListener('click', () => deleteProduct(card));
            });
        });

    </script>
</body>
</html>