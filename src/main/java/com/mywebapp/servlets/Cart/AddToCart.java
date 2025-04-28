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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        StringBuilder jsonBuilder = new StringBuilder();

        ArrayList<Product> prodList;
        Object obj = session.getAttribute("Cart");
        if (obj == null) {
            prodList = new ArrayList<>();
        } else if (obj instanceof ArrayList<?>) {
            prodList = (ArrayList<Product>) obj;
        } else {
            prodList = new ArrayList<>();
        }

        int id = Integer.parseInt(req.getParameter("IdProduct"));

        ResultSet rs = db.query("SELECT * FROM products WHERE id = '" + id + "'");

        try {
            if (rs.next()) {
                String marca = rs.getString("brand");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                String desc = rs.getString("description");
                String imgUrl = rs.getString("image");

                prodList.add(new Product(id, marca, name, price, 1, desc, imgUrl));
                System.out.println("Aggiunto");
                session.setAttribute("Cart", prodList);

                double totale = 0f;
                for (Product _tmp : prodList) {
                    totale += _tmp.price;
                }

                jsonBuilder.append("[{")
                        .append("\"id\":").append(rs.getInt("id")).append(",")
                        .append("\"brand\":\"").append(escapeJson(rs.getString("brand"))).append("\",")
                        .append("\"name\":\"").append(escapeJson(rs.getString("name"))).append("\",")
                        .append("\"description\":\"").append(escapeJson(rs.getString("description"))).append("\",")
                        .append("\"price\":").append(rs.getDouble("price")).append(",")
                        .append("\"stock\":").append(rs.getInt("stock")).append(",")
                        .append("\"insertionDate\":\"").append(rs.getDate("insertion_date")).append("\",")
                        .append("\"catalogId\":").append(rs.getInt("catalog_id")).append(",")
                        .append("\"image\":\"").append(escapeJson(rs.getString("image"))).append("\"").append(",")
                        .append("\"totalCart\":").append(totale)
                        .append("}]");
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage() + " a");
        }
        //------------------------------------------------------------------------------------------------------------------------------------
        db.close();

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonBuilder.toString());
    }

    // Metodo di supporto per scappare virgolette e caratteri speciali nel JSON
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
