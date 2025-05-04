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
import java.util.HashMap;
import java.util.List;

@WebServlet("/Search")
public class GetStoreProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        int sorting = Integer.parseInt(req.getParameter("sorting"));
        int category = Integer.parseInt(req.getParameter("category"));

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        String query = "SELECT * FROM products WHERE name LIKE \"%" + name + "%\"";

        if (category != 0) {
            query += " AND catalog_id = '" + category + "'";
        }

        switch (sorting) {
            case 1: {
                 query +=  " ORDER BY name";
                break;
            }
            case 2: {
                query +=  " ORDER BY price ASC";
                break;
            }
            case 3: {
                query +=  " ORDER BY price DESC";
                break;
            }
            case 4: {
                query +=  " ORDER BY insertion_date DESC";
                break;
            }
        }

        ResultSet rs = db.query(query);
        List<Product> productList = new ArrayList<>();

        ResultSet rs2 = db.query("SELECT * FROM catalogs");
        HashMap<Integer, String> categories = new HashMap<>();

        try {
            while (rs.next()) {
                int id = rs.getInt("id");
                String brand = rs.getString("brand");
                String _name = rs.getString("name");
                double price = rs.getDouble("price");
                int stock = rs.getInt("stock");
                String description = rs.getString("description");
                String image = rs.getString("image");

                productList.add(new Product(id, brand, _name, price, stock, description, image));
            }

            while(rs2.next()) {
                categories.put(rs2.getInt("id"), rs2.getString("name"));
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        db.close();

        req.setAttribute("Categories", categories);
        req.setAttribute("ProductsList", productList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("search.jsp");
        dispatcher.forward(req, resp);
    }
}
