package com.mywebapp.servlets.access;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/verifyRegister")
public class Register extends HttpServlet {

    @Override
    public void init(ServletConfig config) throws ServletException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //response.setHeader("Access-Control-Allow-Origin", "*");  // Permette tutte le origini
        //response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        //response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept");

        String email = request.getParameter("emailInput");
        String password = request.getParameter("passwordInput");

        String name = request.getParameter("nameInput");
        String surname = request.getParameter("surnameInput");
        String username = "null";
        //String username = request.getParameter("usernameInput");
        String date = request.getParameter("dateInput");

        String rememberMeInput = request.getParameter("rememberMeInput");

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        ResultSet set = db.query("SELECT * FROM users WHERE email = '" + email + "'");

        try {
            if (!set.next()) {
                db.queryUpdate("INSERT INTO users (email, password, first_name, last_name, username, birth_date) VALUES ('" + email + "', '" + password + "', '" + name + "', '" + surname + "', '" + username + "', '" + date + "')");
                Cookie cookie = new Cookie("email", email);
                cookie.setPath("/");
                if (rememberMeInput != null) {
                    cookie.setMaxAge(60 * 60 * 24 * 30); // ss, mm, hh, gg
                }
                response.addCookie(cookie);
                response.sendRedirect("index.jsp");
            }
            else {
                // error msg
                request.setAttribute("messaggio", "errore");
                RequestDispatcher dispatcher = request.getRequestDispatcher("registrazione.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        db.close();
    }
}