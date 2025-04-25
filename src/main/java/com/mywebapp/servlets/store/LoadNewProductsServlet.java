package com.mywebapp.servlets.store;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/LoadNewProductsServlet")
public class LoadNewProductsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Database db = new Database("root", ""); // tua classe custom
        StringBuilder jsonBuilder = new StringBuilder();

        try {
            db.connect("127.0.0.1", "3306", "webapp");

            ResultSet rs = db.query("SELECT * FROM products ORDER BY insertion_date DESC LIMIT 3");

            jsonBuilder.append("[");
            boolean first = true;

            while (rs.next()) {
                if (!first) {
                    jsonBuilder.append(",");
                }
                jsonBuilder.append("{")
                        .append("\"id\":").append(rs.getInt("id")).append(",")
                        .append("\"brand\":\"").append(escapeJson(rs.getString("brand"))).append("\",")
                        .append("\"name\":\"").append(escapeJson(rs.getString("name"))).append("\",")
                        .append("\"description\":\"").append(escapeJson(rs.getString("description"))).append("\",")
                        .append("\"price\":").append(rs.getDouble("price")).append(",")
                        .append("\"stock\":").append(rs.getInt("stock")).append(",")
                        .append("\"insertionDate\":\"").append(rs.getDate("insertion_date")).append("\",")
                        .append("\"catalogId\":").append(rs.getInt("catalog_id")).append(",")
                        .append("\"image\":\"").append(escapeJson(rs.getString("image"))).append("\"")
                        .append("}");
                first = false;
            }

            jsonBuilder.append("]");

            db.close();
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonBuilder.toString());
    }

    // Metodo di supporto per scappare virgolette e caratteri speciali nel JSON
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
