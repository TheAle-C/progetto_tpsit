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

@WebServlet("/verifyReg")
public class Register extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("emailInput");
        String password = request.getParameter("passwordInput");

        String name = request.getParameter("nameInput");
        String surname = request.getParameter("surnameInput");
        String date = request.getParameter("dateInput");

        String rememberMeInput = request.getParameter("rememberMeInput");

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "webapp");

        ResultSet set = db.query("SELECT * FROM users WHERE email = '" + email + "'");
        try {
            if (!set.next()) {
                db.queryUpdate("INSERT INTO users (email, password, first_name, last_name, username, birth_date) VALUES ('" + email + "', '" + password + "', '" + name + "', '" + surname + "', 'null', '" + date + "')");
                Cookie cookie = new Cookie("email", email);
                cookie.setPath("/");
                if (rememberMeInput != null) {
                    cookie.setMaxAge(60 * 60 * 24 * 30); // ss, mm, hh, gg
                }
                response.addCookie(cookie);
                response.sendRedirect("index.jsp");
            }
            else {
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