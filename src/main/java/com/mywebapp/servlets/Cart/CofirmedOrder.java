package com.mywebapp.servlets.Cart;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/OrderConfirmed")
public class CofirmedOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

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

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        ResultSet rs1 = db.query("SELECT * FROM users WHERE email = '" + cookie.getValue() + "'");

        try {
            System.out.println("0");
            if (rs1.next()) {
                db.queryUpdate("INSERT INTO orders (status, user_id) VALUES ('In elaborazione', '" + rs1.getInt("id") + "')");

                ResultSet last_id = db.query("SELECT LAST_INSERT_ID() as id");
                if (!last_id.next()) return;

                for (Product tmp : (ArrayList<Product>) session.getAttribute("Cart")) {
                    db.queryUpdate("INSERT INTO order_details (order_id, product_id) VALUES ('" + last_id.getInt("id") + "', '" + tmp.id + "')");
                }
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        db.close();
        session.setAttribute("Cart", new ArrayList<Product>());
        resp.sendRedirect("index.jsp");
    }
}
