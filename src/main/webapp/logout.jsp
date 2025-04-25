<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);


Cookie cookie = new Cookie("email", "");
cookie.setMaxAge(0); // scadenza immediata
cookie.setPath("/"); // deve coincidere esattamente col path usato per settarlo
response.addCookie(cookie);

// opzionale ma consigliato
session.invalidate();

// disabilita cache

// redirect alla home
response.sendRedirect("login.jsp");
%>
