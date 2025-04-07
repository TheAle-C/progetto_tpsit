package com.mywebapp.servlets;

import com.mywebapp.MySql.Database;

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
                out.println(res.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        db.close(); // chiusura della connessione
    }
}
