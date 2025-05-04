package com.mywebapp.servlets.admin;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;
import com.mywebapp.servlets.Cart.Product;
import com.mywebapp.servlets.user_profile.Order;
import com.mywebapp.servlets.user_profile.UserData;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@WebServlet("/AdminArea")
public class AdminArea extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        boolean flag = false;
        Cookie[] cookies = req.getCookies();

        if (cookies != null) {
            for (Cookie tmp : cookies) {
                if ("email".equals(tmp.getName()) && tmp.getValue() != null && !tmp.getValue().isEmpty()) {
                    if (tmp.getValue().equals("admin@admin")) {
                        flag = true;
                    }
                }
            }
        }

        if (!flag) {
            resp.sendRedirect("index.jsp");
            return;
        }

        try {
            Database db = new Database("root", "");
            db.connect("127.0.0.1", "3306", "webapp");

            // ---------------------------------------------------------------------------------------------------------------- RECUPERO TUTTI PRODOTTI
            List<Product> productList = new ArrayList<>();
            ResultSet rs = db.query("SELECT * FROM products");
            while (rs.next()) {
                int id = rs.getInt("id");
                String brand = rs.getString("brand");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                int stock = rs.getInt("stock");
                String description = rs.getString("description");
                String image = rs.getString("image");
                ResultSet rs2 = db.query("SELECT * FROM catalogs WHERE id = '" + rs.getString("catalog_id") + "'");
                String catalog = "";
                if (rs2.next()) {
                    catalog = rs2.getString("name");
                }

                productList.add(new Product(id, brand, name, price, stock, description, image, catalog));
            }
            req.setAttribute("productList", productList);

            // ---------------------------------------------------------------------------------------------------------------- CATEGORIE
            ResultSet rs2 = db.query("SELECT * FROM catalogs");
            HashMap<Integer, String> categories = new HashMap<>();
            while(rs2.next()) {
                categories.put(rs2.getInt("id"), rs2.getString("name"));
            }
            req.setAttribute("Categories", categories);

            db.close();
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        String section = req.getParameter("section");
        if (section == null) {
            req.getRequestDispatcher("/Admin/admin_products.jsp").forward(req, resp);
        }
        else if (section.equals("orders")) {
            String query = "SELECT id, brand, description, image, name, selled_num, price, stock, catalog_id FROM products ORDER BY selled_num DESC LIMIT 3";
            Database db = new Database("root", "");
            db.connect("127.0.0.1", "3306", "webapp");
            ResultSet rs = db.query(query);
            try {
                ArrayList<Product> mostSelledProd = new ArrayList<>();
                while(rs.next()) {
                    mostSelledProd.add(new Product(
                            rs.getInt("id"),
                            rs.getString("brand"),
                            rs.getString("name"),
                            rs.getDouble("price"),
                            rs.getInt("selled_num"),
                            rs.getString("description"),
                            rs.getString("image")));
                }
                req.setAttribute("mostSelledProd", mostSelledProd);

                getUserOrders(req, resp, db);

                db.close();
            } catch (SQLException e) {
                Logger.error(e.getMessage());
            }

            req.getRequestDispatcher("/Admin/admin_orders.jsp").forward(req, resp);
        }
        else if (section.equals("users")) {
            Database db = new Database("root", "");
            db.connect("127.0.0.1", "3306", "webapp");

            ResultSet rs = db.query("SELECT * FROM users");

            ArrayList<UserData> users = new ArrayList<>();

            try {
                while(rs.next()) {
                    users.add(new UserData(
                            rs.getInt("id"),
                            rs.getString("first_name"),
                            rs.getString("last_name"),
                            rs.getString("email"),
                            rs.getDate("birth_date")
                    ));
                }
                req.setAttribute("userList", users);
            } catch (SQLException e) {
                Logger.error(e.getMessage());
            }

            req.getRequestDispatcher("/Admin/admin_users.jsp").forward(req, resp);
        }
        else if (section.equals("order_details")) {
            String idOrder = req.getParameter("idOrder");

            String query = "SELECT " +
                    "    o.user_id ," +
                    "    o.id AS order_id, " +
                    "    CONCAT(u.first_name, ' ', u.last_name) AS cliente, " +
                    "    o.order_date, " +
                    "    o.status, " +
                    "    p.name AS product_name, " +
                    "    COUNT(p.id) AS quantita, " +
                    "    p.price AS prezzo_unitario, " +
                    "    ROUND(COUNT(p.id) * p.price, 2) AS totale_prodotto " +
                    "FROM orders o " +
                    "JOIN users u ON o.user_id = u.id " +
                    "JOIN order_details od ON od.order_id = o.id " +
                    "JOIN products p ON p.id = od.product_id " +
                    "WHERE o.id = '" + idOrder + "' " +
                    "GROUP BY p.id;";

            Database db = new Database("root", "");
            db.connect("127.0.0.1", "3306", "webapp");

            ResultSet rs = db.query(query);

            OrderDetails order = null;

            try {
                ArrayList<Product> prods = new ArrayList<>();
                boolean first = true;
                double total = 0f;
                
                while (rs.next()) {
                    if (first) {
                        first = false;
                        order = new OrderDetails(
                                rs.getString("cliente"),
                                rs.getTimestamp("order_date"),
                                rs.getString("status"),
                                0,
                                null
                        );
                    }
                    prods.add(new Product(  // riciclo della classe Product -> le variabili che non servono sono inizializzate a caso,
                                            // inoltre la discrizione rappresenta il prezzo di tutte le quantitò
                            0,
                            "",
                            rs.getString("product_name"),
                            rs.getDouble("prezzo_unitario"),
                            rs.getInt("quantita"),
                            rs.getString("totale_prodotto"),
                            ""
                    ));
                    total += rs.getDouble("prezzo_unitario");
                }
                order.total = total;
                order.products = prods;
                req.setAttribute("order_details", order);
            } catch (SQLException e) {
                Logger.error(e.getMessage());
            }

            req.getRequestDispatcher("/Admin/admin_orders_details.jsp?idOrder=" + idOrder).forward(req, resp);
        }
        else {
            req.getRequestDispatcher("/Admin/admin_products.jsp").forward(req, resp);
        }
    }

    private void getUserOrders(HttpServletRequest req, HttpServletResponse resp, Database db) throws ServletException, IOException {
        ArrayList<Order> userOrders = new ArrayList<>();

        ResultSet rs = db.query("SELECT o.id AS order_id, CONCAT(u.first_name, ' ', u.last_name) AS cliente, o.order_date, o.status, ROUND(SUM(p.price), 2) AS totale FROM orders o JOIN users u ON o.user_id = u.id JOIN order_details od ON od.order_id = o.id JOIN products p ON p.id = od.product_id GROUP BY o.id ORDER BY o.order_date DESC;");

        try {
            ArrayList<OrderSummary> orderSummaries = new ArrayList<>();
            while (rs.next()) {
                orderSummaries.add(new OrderSummary(
                        rs.getInt("order_id"),
                        rs.getString("cliente"),
                        rs.getTimestamp("order_date"),
                        rs.getDouble("totale"),
                        rs.getString("status")
                        ));
            }
            req.setAttribute("orderSummaries", orderSummaries);
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }
    }
}
