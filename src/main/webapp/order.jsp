<%@page import="java.util.Locale"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.mywebapp.servlets.user_profile.Order"%>
<%@page import="com.mywebapp.servlets.user_profile.UserData"%>
<%@page import="com.mywebapp.servlets.Cart.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
UserData userData = null;
%>

<%
//-------------------------------------------------------------------------------------------- Verifica email
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie tmp : cookies) {
        if ("email".equals(tmp.getName())) {
        	if (tmp.getValue() == null || tmp.getValue().isEmpty()) {
        		response.sendRedirect("login.jsp");
                break;
        	}
        }
    }
}

if (request.getAttribute("user_data") != null) {
	userData = (UserData) request.getAttribute("user_data");
}
else {
	//response.sendError(404);
}
//--------------------------------------------------------------------------------------------
%>

<!DOCTYPE html>
<html lang="it">
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TecnoStore | I Miei Ordini</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="CSS/clienti.css">
</head>
<body>
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="sidebar-header">
            <h2>Il Mio Account</h2>
        </div>
        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="UserArea?section=main">
                    <i class="fas fa-user"></i>
                    <span>Profilo</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="ordine.html" class="active">
                    <i class="fas fa-box-open"></i>
                    <span>I Miei Ordini</span>
                </a>
            </li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="admin-main">
        <!-- Header -->
         <header class="admin-header">
            <h1>Profilo Cliente</h1>
            <div class="user-menu">
                <div class="user-profile">
                    <div class="user-avatar"><%= "" + userData.first_name.toUpperCase().charAt(0) + userData.last_name.toUpperCase().charAt(0) %></div>
                    <span><%= userData.first_name + " " + userData.last_name %></span>
                    <i class="fas fa-sign-out-alt action-icon" 
                        	role="button" 
                        	tabindex="0"
                        	onclick="window.location.href='logout.jsp'"
                            aria-label="Logout"></i>
                </div>
            </div>
        </header>

        <!-- Contenuto Ordini -->
        <div class="admin-content">
            <div class="form-section">
                <div class="form-header">
                    <h2><i class="fas fa-clipboard-list"></i> Ordini </h2>
                </div>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Ordine</th>
                            <th>Data</th>
                            <th>Totale</th>
                            <th>Stato</th>
                            <th>Azioni</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<%
                    	ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("user_ordes");
                    	if (request.getAttribute("user_ordes") != null) {
                    		if (!orders.isEmpty()) {
                    			for (Order tmp : orders) {
                   					double totalPrice = 0f;
                    			%>
                    				<tr>
			                            <td id="orderId"><%= tmp.id %></td>
			                            <td><%= tmp.order_date.format(DateTimeFormatter.ofPattern("d MMMM yyyy", Locale.ITALIAN)) %></td>
			                            <%for (Product _tmp : tmp.products) {
	                   						totalPrice += _tmp.price;
	                   					}%>
			                            <% if (totalPrice < 50f) totalPrice += 10f; %>
			                            <td><%= String.format("%.2f", totalPrice) %> €</td>
			                            <%
		                            	switch (tmp.status) {
		                            		case "Consegnato": {
		                            			%><td><span class="status completed"><%= tmp.status %></span></td><%
		                            			break;
		                            		}
		                            		case "In elaborazione": {
		                            			%><td><span class="status pending"><%= tmp.status %></span></td><%
		                            			break;
		                            		}
		                            		case "Spedito": {
		                            			%><td><span class="status shipped"><%= tmp.status %></span></td><%
		                            			break;
		                            		}
		                            		case "Annulato": {
		                            			%><td><span class="status cancelled"><%= tmp.status %></span></td><%
		                            			break;
		                            		}
		                            	}
			                            %>
				                        <td>
			                                <div class="btn-group">
			                                    <!-- NON SO SE IMPLEMENTARE:
			                                    <button class="btn btn-primary">
			                                        <i class="fas fa-edit"></i> Modifica
			                                    </button> -->
			                                    <% if(tmp.status.equals("In elaborazione")) { %>
				                                    <button class="btn btn-danger" id="<%= tmp.id %>">
				                                        <i class="fas fa-times"></i> Annulla
				                                    </button>
			                                    <% } else { %>
				                                    <button class="btn btn-disabled-custom" id="<%= tmp.id %>" disabled>
					                                        <i class="fas fa-times"></i> Annulla
				                                    </button>
			                                    <% } %>
			                                </div>
			                            </td>
			                        </tr>
                    			<%}
                    		}
                    	}
                    	%>
                    </tbody>
                </table>
            </div>

            <!-- Dettaglio Ordine Modificabile -->
            <!--<div class="form-section fade-in" id="editSection" style="display: none;">
                <div class="form-header">
                    <h2><i class="fas fa-edit"></i> Modifica Ordine</h2>
                    <div class="btn-group">
                        <button class="btn btn-secondary" onclick="closeEdit()">
                            <i class="fas fa-times"></i> Chiudi
                        </button>
                        <button class="btn btn-success">
                            <i class="fas fa-check"></i> Salva Modifiche
                        </button>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Indirizzo di Spedizione</label>
                        <input type="text" class="form-control" value="Via Roma 123, Milano">
                    </div>
                    <div class="form-group">
                        <label>Metodo di Pagamento</label>
                        <select class="form-control">
                            <option>Carta di Credito</option>
                            <option>PayPal</option>
                            <option>Contrassegno</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Aggiungi Prodotto</label>
                        <div class="form-control-static">
                            <button class="btn btn-primary">
                                <i class="fas fa-plus"></i> Seleziona Prodotto
                            </button>
                        </div>
                    </div>
                </div>
            </div>-->
        </div>

        <!-- Loader -->
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
        // Conferma Annullamento
        document.querySelectorAll('.btn-danger').forEach(btn => {
            btn.addEventListener('click', (e) => {
                if(!e.target.disabled && confirm('Sei sicuro di voler annullare questo ordine?')) {
                    e.target.closest('tr').classList.add('fade-in');
                    setTimeout(() => {
                        cancelOrder(e.target.id);
                        e.target.closest('tr').remove();
                    }, 300);
                }
            });
        });

        // Loader e Menu Active (stesso script della pagina cliente)
        window.addEventListener('load', () => {
            const loader = document.querySelector('.loader-container');
            setTimeout(() => {
                loader.classList.add('hidden');
                setTimeout(() => {
                    loader.remove();
                }, 1200);
            }, 600);
        });
        
        function cancelOrder(idOrder) {
        	$.ajax({
                url: "RemoveOrder",  // URL del tuo servlet
                method: "GET",
                data: {
                    id: idOrder
                },
                success: function(response) {

                },
                error: function() {
                    alert("Errore durante l'annulamento dell'ordine.");
                }
            });
        }
    </script>
</body>
</html>