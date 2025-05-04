package com.mywebapp.servlets.user_profile;

import com.mywebapp.MySql.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RemoveOrder")
public class RemoveOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        db.queryUpdate("DELETE FROM order_details WHERE order_id = '" + id + "'");
        db.queryUpdate("DELETE FROM orders WHERE id = '" + id + "'");

        db.close();
    }
}
