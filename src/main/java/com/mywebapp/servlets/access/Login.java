package com.mywebapp.servlets.access;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Login extends HttpServlet {

    @Override
    public void init(ServletConfig config) throws ServletException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");  // Permette tutte le origini
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept");

        String email = request.getParameter("emailInput");
        String password = request.getParameter("passwordInput");
        String rememberMeInput = request.getParameter("rememberMeInput");

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        ResultSet set = db.query("SELECT * FROM users WHERE email = '" + email + "'");

        try {
            if (set.next()) {
                if (set.getString("password").equals(password)) {
                    Cookie cookie = new Cookie("email", email);
                    cookie.setPath("/");
                    if (rememberMeInput != null) {
                        cookie.setMaxAge(60 * 60 * 24 * 30);
                    }
                    response.addCookie(cookie);
                    response.sendRedirect("index.jsp");
                }
                else {
                    request.setAttribute("messaggio", "errore");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                    dispatcher.forward(request, response);
                }
            }
            else {
                // msg error
                request.setAttribute("messaggio", "errore");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        db.close();
    }
}