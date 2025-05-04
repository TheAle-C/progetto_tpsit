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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/CreateProduct")
public class CreateProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = -1;

        String brand = req.getParameter("productBrand");
        String name = req.getParameter("productName");
        String description = req.getParameter("productDescription");
        double price = Double.parseDouble(req.getParameter("productPrice"));
        int stock = Integer.parseInt(req.getParameter("productQuantity"));
        int catalogId = Integer.parseInt(req.getParameter("productCategory"));
        String image = req.getParameter("productImage");

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        String sql = "INSERT INTO products (`brand`, `name`, `description`, `price`, `stock`, `catalog_id`, `selled_num`, `image`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement stmt = null;
        try {
            stmt = db.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, brand);
            stmt.setString(2, name);
            stmt.setString(3, description);
            stmt.setDouble(4, price);
            stmt.setInt(5, stock);
            stmt.setInt(6, catalogId);
            stmt.setInt(7, 0);
            stmt.setString(8, image);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    id = rs.getInt(1); // o il nome della colonna se preferisci: rs.getInt("id")
                }
                rs.close();
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();
        out.print(id);
        out.flush();
    }
}
