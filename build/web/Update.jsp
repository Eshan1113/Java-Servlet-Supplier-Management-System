<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    session = request.getSession();
    if (session == null || session.isNew()) {
        response.sendRedirect("Login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="header.jsp"/>     
    <body>
        <div class="container-scroller">
            <jsp:include page="navbar.jsp"/>
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="navbar2.jsp"/>
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <h1>User Details</h1>
                            <table class="table table-striped">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Address</th>
                                        <th>Mobile</th>
                                        <th>Role</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        try {
                                            // Connect to the database
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newproject", "root", ""); // Replace 'username' and 'password' with your actual credentials

                                            // Prepare and execute the query to retrieve user details
                                            Statement stmt = con.createStatement();
                                            ResultSet rs = stmt.executeQuery("SELECT * FROM userdetials");

                                            // Iterate through the result set and display data in the table
                                            while (rs.next()) {
                                    %>
                                    <tr>
                                        <td><%= rs.getInt("id") %></td>
                                        <td><%= rs.getString("username") %></td>
                                        <td><%= rs.getString("email") %></td>
                                        <td><%= rs.getString("address") %></td>
                                        <td><%= rs.getString("mobile") %></td>
                                        <td><%= rs.getString("role") %></td>
                                        <td>
                                            <form action="editUser.jsp" method="post">
                                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                <button type="submit" name="Edit" class="btn btn-primary">Edit</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                            // Close the connection
                                            con.close();
                                        } catch (Exception e) {
                                            out.println("Error: " + e);
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="foter.jsp"/>
    </body>
</html>
