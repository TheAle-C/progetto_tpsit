package com.mywebapp.servlets.store;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;
import com.mywebapp.servlets.Cart.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/store")
public class ViewStore extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> productList = new ArrayList<>();

        try {
            Database db = new Database("root", "");
            db.connect("127.0.0.1", "3306", "webapp");
            ResultSet rs = db.query("SELECT * FROM products");
            while (rs.next()) {
                int id = rs.getInt("id");
                String brand = rs.getString("brand");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                int stock = rs.getInt("stock");
                String description = rs.getString("description");
                String image = rs.getString("image");

                productList.add(new Product(id, brand, name, price, stock, description, image));
            }
            db.close();
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        req.setAttribute("productList", productList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("store.jsp");
        dispatcher.forward(req, resp);
    }
}
