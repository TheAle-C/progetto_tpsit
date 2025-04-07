package com.mywebapp.servlets;

import com.mywebapp.MySql.Database;
import com.mywebapp.Other.Logger;

import java.io.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;

public class test extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Database db = new Database("root", "");
        db.connect("127.0.0.1", "3306", "test");

        ResultSet res = db.query("SELECT * FROM test");

        try {
            while (res.next()) {
                out.println(res.getString(1) + " " + res.getString(2) + " " + res.getString(3) + " " + res.getString(4) + "<br>");
            }
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }

        db.close(); // chiusura della connessione
    }
}
