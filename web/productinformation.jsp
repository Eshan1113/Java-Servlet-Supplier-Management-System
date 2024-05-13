<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%
    // Check if the session is valid
    session = request.getSession();
    if (session == null || session.isNew()) {
        response.sendRedirect("Login.jsp");
    }

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newproject", "root", ""); // Replace with your DB credentials

        // Prepare SQL statement to fetch data from the products table
        pstmt = con.prepareStatement("SELECT * FROM products");
        rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Information Report</title>
        <jsp:include page="header.jsp"/>     

        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .product-info {
                margin-bottom: 20px;
            }
            .product-info label {
                font-weight: bold;
            }
            .button-container {
                text-align: center;
                margin-top: 20px;
            }
            .button-container button {
                padding: 10px 20px;
                margin: 0 10px;
                border: none;
                border-radius: 5px;
                background-color: #007bff;
                color: #fff;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .button-container button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container-scroller">
            <jsp:include page="navbar.jsp"/>
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="navbar2.jsp"/>
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <div class="container">
                                <h2>Product Information Report</h2>
                                <% while (rs.next()) {%>
                                <div class="product-info">
                                    <label for="product_name">Product Name:</label>
                                    <span id="product_name"><%= rs.getString("product_name")%></span>
                                </div>
                                <div class="product-info">
                                    <label for="price">Price:</label>
                                    <span id="price">$<%= rs.getString("price")%></span>
                                </div>
                                <div class="product-info">
                                    <label for="product_description">Product Description:</label>
                                    <span id="product_description"><%= rs.getString("product_description")%></span>
                                </div>
                                <div class="product-info">
                                    <label for="product_added_date">Product Added Date:</label>
                                    <span id="product_added_date"><%= rs.getString("product_added_date")%></span>
                                </div>
                                <hr>
                                <% } %>
                                <div class="button-container">
                                    <button onclick="window.print()">Print Report</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                </div>
        </div>
                <jsp:include page="foter.jsp"/>
                </body>
                </html>

                <%
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.getWriter().println("Error: An unexpected exception occurred - " + e.getMessage());
                    } finally {
                        try {
                            // Close the resources
                            if (rs != null) {
                                rs.close();
                            }
                            if (pstmt != null) {
                                pstmt.close();
                            }
                            if (con != null) {
                                con.close();
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>
