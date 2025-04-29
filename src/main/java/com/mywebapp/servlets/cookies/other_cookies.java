package com.mywebapp.servlets.cookies;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/UpdateCookiesPreferences")
public class other_cookies extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        boolean an_c = Boolean.parseBoolean(req.getParameter("AnalyticsCookie"));
        boolean ma_c = Boolean.parseBoolean(req.getParameter("MarketingCookie"));

        Cookie analyticsCookie = new Cookie("analyticsCookie", "" + an_c); //60 * 60 * 24 * 30
        analyticsCookie.setPath("/");
        analyticsCookie.setMaxAge(60 * 60 * 24 * 30);
        resp.addCookie(analyticsCookie);

        Cookie marketingCookie = new Cookie("marketingCookie", "" + ma_c); //60 * 60 * 24 * 30
        marketingCookie.setPath("/");
        marketingCookie.setMaxAge(60 * 60 * 24 * 30);
        resp.addCookie(marketingCookie);
    }
}
