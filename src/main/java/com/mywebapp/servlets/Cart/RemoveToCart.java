package com.mywebapp.servlets.Cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/RemoveToCart")
public class RemoveToCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        int id = Integer.parseInt(req.getParameter("IdProduct"));

        ArrayList<Product> prodList;
        Object obj = session.getAttribute("Cart");
        if (obj != null) {
            if (obj instanceof ArrayList<?>) {
                prodList = (ArrayList<Product>) obj;

                for (Product _tmp : prodList) {
                    if (_tmp.id == id) {
                        prodList.remove(_tmp);
                        break;
                    }
                }
            }
        }
    }
}
