package com.mywebapp.servlets.admin;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/DeleteProduct")
public class DeleteProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));

            Database db = new Database("root", "");
            db.connect("127.0.0.1", "3306", "webapp");

            db.queryUpdate("DELETE FROM products WHERE id = '" + productId + "'");

        } catch (Exception e) {
            Logger.error("Errore eliminazione prodotto: " + e.getMessage());
        }

        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();
        out.print("ok");
        out.flush();
    }
}
