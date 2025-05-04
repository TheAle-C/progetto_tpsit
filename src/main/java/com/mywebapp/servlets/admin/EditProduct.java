package com.mywebapp.servlets.admin;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;

@WebServlet("/EditProduct")
public class EditProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String result = "errore";

        try {
            int id = Integer.parseInt(req.getParameter("productId"));
            String brand = req.getParameter("productBrand");
            String name = req.getParameter("productName");
            String description = req.getParameter("productDescription");
            double price = Double.parseDouble(req.getParameter("productPrice"));
            int stock = Integer.parseInt(req.getParameter("productQuantity"));
            int catalogId = Integer.parseInt(req.getParameter("productCategory"));
            String image = req.getParameter("productImage");

            Database db = new Database("root", "");
            db.connect("127.0.0.1", "3306", "webapp");

            String sql = "UPDATE products SET brand = ?, name = ?, description = ?, price = ?, stock = ?, catalog_id = ?, image = ? WHERE id = ?";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, brand);
            stmt.setString(2, name);
            stmt.setString(3, description);
            stmt.setDouble(4, price);
            stmt.setInt(5, stock);
            stmt.setInt(6, catalogId);
            stmt.setString(7, image);
            stmt.setInt(8, id);

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                result = "ok";
            }

        } catch (Exception e) {
            Logger.error("Errore modifica prodotto: " + e.getMessage());
        }

        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();
        out.print(result);
        out.flush();
    }
}
