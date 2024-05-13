
<%@page import="java.sql.SQLException"%>
<%@page import="Model.DBConn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% session = request.getSession();
    if (session == null || session.getAttribute("UN") == null) {
        response.sendRedirect("Login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="header.jsp"/> 
    <style>
        .enlarged-table {
            width: 120%; /* Adjust the width as needed */
            margin: 0 auto;
            top:120%/* Center the table horizontally */
        }
    </style>    
    <body>



        <div class="container-scroller">
            <jsp:include page="navbar.jsp"/>
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="navbar2.jsp"/>
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <div class="card mt-5 enlarged-table">
                                <div class="card-body">
                                    <h5 class="card-title">Update User Details Form</h5>
                                    <form class="p-3" action="UserEdit" method="POST">
                                        <%
                                            try (Connection conn = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");) {
                                                PreparedStatement pst;
                                                String id = request.getParameter("id");
                                                String checkSql = "SELECT * FROM userdetials WHERE id = ?";
                                                PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                checkStmt.setString(1, id);

                                                ResultSet checkResult = checkStmt.executeQuery();

                                                while (checkResult.next()) {

                                        %>    

                                        <div class="container-fluid h-100">
                                            <div class="row ">

                                                <div class="col-md-12 bg-light">
                                                    <div class="mb-3">
                                                        <input name="id" type="text" value="<%= id%>" hidden />
                                                        <div class="mb-3">
                                                            <label for="name" class="form-label">User Name</label>
                                                            <input type="text" class="form-control" name="username" value="<%= checkResult.getString("username")%>" placeholder="Enter name" />
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="st_id" class="form-label">Email</label>
                                                            <input type="text" class="form-control" name="email" value="<%= checkResult.getString("email")%>" placeholder="Enter Student Id" />
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="deparment" class="form-label">Address</label>
                                                            <input type="text" class="form-control" name="address" value="<%= checkResult.getString("address")%>" placeholder="Enter Department" />
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="fees" class="form-label">Mobile</label>
                                                            <input type="number" class="form-control" name="mobile" value="<%= checkResult.getString("mobile")%>" placeholder="Enter fees" />
                                                        </div>    
                                                        <div class="mb-3">
                                                            <label for="role" class="form-label">Role:</label>
                                                            <select class="form-control" id="role" name="role">
                                                                <option value="admin" <%= checkResult.getString("role").equals("admin") ? "selected" : ""%>>Admin</option>
                                                                <option value="user" <%= checkResult.getString("role").equals("user") ? "selected" : ""%>>User</option>
                                                            </select>
                                                            </form>

                                                        </div>

                                                        <button type="submit" class="btn btn-success">Update Student</button>
                                                        <button type="reset" class="btn btn-secondary">Clear</button>
                                                        <div class="container">
                                                            <% String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (successMessage != null) {%>
                                                            <div class="alert alert-success" role="alert">
                                                                <%= successMessage%>
                                                            </div>
                                                            <script>
                                                                setTimeout(function () {
                                                                    window.location.href = "Update.jsp";
                                                                }, 2000);
                                                            </script>
                                                            <% } else if (errorMessage != null) {%>
                                                            <div class="alert alert-danger" role="alert">
                                                                <%= errorMessage%>
                                                            </div>
                                                            <% } %>
                                                            <%                                }
                                                                } catch (SQLException ex) {
                                                                    System.out.println(ex);
                                                                }
                                                            %>



                                                            <% String msg = (String) request.getAttribute("msg");
                                                                String clz = (String) request.getAttribute("clz");
                                                                if (msg != null && clz != null) {
                                                            %>

                                                            <div class="alert <%= clz%> alert-dismissible fade show mt-4" role="alert">
                                                                <strong>Holy guacamole!</strong> <%= msg%>
                                                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                            <br>
                                                            <%
                                                                String message = (String) request.getAttribute("SendMessage");
                                                                if (message != null) {
                                                            %>

                                                            <h3><%=message%></h31>

                                                                <%
                                                                    }
                                                                %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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