package com.mywebapp.servlets.Cart;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getMiniCartShop")
public class GetItemInTheCart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("IdProduct"));

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        ResultSet rs = db.query("SELECT * FROM products WHERE id = '" + id + "'");

        try {
            if (rs.next()) {
                String marca = rs.getString("brand");
                String nome = rs.getString("name");
                double prezzo = rs.getDouble("price");
                String descrizione = rs.getString("description");
                String img = rs.getString("image");

                // Salvi in sessione o DB (semplificato qui)
                HttpSession session = request.getSession();
                List<Product> carrello = (List<Product>) session.getAttribute("Cart");
                if (carrello == null) {
                    carrello = new ArrayList<>();
                }
                carrello.add(new Product(id, marca, nome, prezzo, 1, descrizione, img));
                session.setAttribute("Cart", carrello);

                db.close();

                // Risposta HTML da iniettare
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println(
                    "<div class='cart-item'>"
                    + "<img src='" + img + "' alt='" + nome + "'>"
                    + "<div class='item-details'>"
                    + "<h5>" + nome + "</h5>"
                    + "<div class='quantity-controls'>"
                    + "<button class='quantity-btn minus'>-</button>"
                    + "<span class='quantity'>1</span>"
                    + "<button class='quantity-btn plus'>+</button>"
                    + "</div>"
                    + "<p class='item-price' data-price='" + prezzo + "'>€" + prezzo + "</p>"
                    + "</div>"
                    + "<button class='remove-item'>&times;</button>" // da modificare
                    + "</div>"
                );
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }
    }
}
