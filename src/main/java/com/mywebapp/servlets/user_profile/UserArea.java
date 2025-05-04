package com.mywebapp.servlets.user_profile;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;
import com.mywebapp.servlets.Cart.Product;

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

@WebServlet("/UserArea")
public class UserArea extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();

        if (cookies != null) {
            for (Cookie tmp : cookies) {
                if ("email".equals(tmp.getName()) && tmp.getValue() != null && !tmp.getValue().isEmpty()) {
                    if (tmp.getValue().equals("admin@admin")) {
                        resp.sendRedirect("AdminArea");
                        return;
                    }
                }
            }
        }

        String section = req.getParameter("section");

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        UserData userData = getUserData(req, resp, db);
        if (userData == null) return;

        ArrayList<Order> userOrders = getUserOrders(req, resp, db, userData.id);

        req.setAttribute("user_data", userData);
        req.setAttribute("user_ordes", userOrders);

        db.close();
        if (section == null) {
            req.getRequestDispatcher("/cliente.jsp").forward(req, resp);
        }
        else if (section.equals("orders")) {
            req.getRequestDispatcher("/order.jsp").forward(req, resp);
        }
        else {
            req.getRequestDispatcher("/cliente.jsp").forward(req, resp);
        }
    }

    private UserData getUserData(HttpServletRequest req, HttpServletResponse resp, Database db) throws ServletException, IOException {
        Cookie cookie = null;
        Cookie[] cookies = req.getCookies();

        if (cookies != null) {
            for (Cookie tmp : cookies) {
                if ("email".equals(tmp.getName()) && tmp.getValue() != null && !tmp.getValue().isEmpty()) {
                    cookie = tmp;
                    break;
                }
            }
        }

        if (cookie == null) {
            resp.sendRedirect("login.jsp");
            return null;
        }

        ResultSet rs = db.query("SELECT * FROM users WHERE email = '" + cookie.getValue() + "'");

        UserData userData = null;

        try {
            if (rs.next()) {
                userData = new UserData(rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getDate("birth_date"));
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        return userData;
    }

    private ArrayList<Order> getUserOrders(HttpServletRequest req, HttpServletResponse resp, Database db, int user_id) throws ServletException, IOException {
        ArrayList<Order> userOrders = new ArrayList<>();

        ResultSet rs = db.query("SELECT * FROM orders WHERE user_id = '" + user_id + "'");

        try {
            while (rs.next()) {
                ArrayList<Product> products = new ArrayList<>();
                ResultSet rs_prod = db.query("SELECT p.* " +
                        "FROM users u, orders o, order_details od, products p " +
                        "WHERE u.id = '" + user_id + "' AND o.id = " + rs.getInt("id") + " AND u.id = o.user_id AND o.id = od.order_id AND p.id = od.product_id");
                while(rs_prod.next()) {
                    products.add(new Product(
                            rs_prod.getInt("id"),
                            rs_prod.getString("brand"),
                            rs_prod.getString("name"),
                            rs_prod.getDouble("price"),
                            rs_prod.getInt("stock"),
                            rs_prod.getString("description"),
                            rs_prod.getString("image")
                    ));
                }

                userOrders.add(new Order(
                        rs.getInt("id"),
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getString("status"),
                        products
                ));
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        return userOrders;
    }
}
