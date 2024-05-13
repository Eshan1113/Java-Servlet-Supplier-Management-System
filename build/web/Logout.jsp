<%-- 
    Document   : Logout
    Created on : Feb 28, 2024, 1:31:42 PM
    Author     : - AI -
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if (session.getAttribute("UN") != null) {
                if (session != null) {
            session.invalidate();
        }
                response.sendRedirect("Login.jsp");
            }
        %>
    </body>
</html>
