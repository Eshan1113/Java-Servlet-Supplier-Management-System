<%@page import="Model.DBConn"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    session = request.getSession();
    if (session == null || session.isNew()) {
        response.sendRedirect("Login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product Details Form</title>
    <jsp:include page="userheader.jsp"/>     
</head>
<body>
    <div class="container-scroller">
     <jsp:include page="usernavbar.jsp"/>
        <div class="container-fluid page-body-wrapper">
         <jsp:include page="usernavbar2.jsp"/>
            <div class="main-panel">
                <div class="content-wrapper">
                    <div class="row justify-content-center">
                        <div class="col-md-8 offset-md-1"> <!-- Adjusted offset -->
                            <div class="card mt-5">
                                <div class="card-body">
                                    <h5 class="card-title text-center">Update Product Details Form</h5>
                                    
                                    <form action="usereditProduct" method="POST">
                                        
                              
                                        <% 
                                            try (Connection conn = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");) {
                                                PreparedStatement pst;
                                                String id = request.getParameter("product_id");
                                                String checkSql = "SELECT * FROM products WHERE product_id = ?";
                                                PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                checkStmt.setString(1, id);

                                                ResultSet checkResult = checkStmt.executeQuery();

                                                while (checkResult.next()) { 
                                        %>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-md-12">
                                                     <input name="product_id" type="text" value="<%= id%>" hidden/>
                                                    <div class="form-group">
                                                        <label for="product_name">Product Name</label>
                                                        <input type="text" class="form-control" name="product_name" value="<%= checkResult.getString("product_name")%>" placeholder="Enter Product Name"/>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="price">Price</label>
                                                        <input type="text" class="form-control" name="price" value="<%= checkResult.getString("price")%>" placeholder="Enter Price"/>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="product_description">Product Description</label>
                                                        <textarea class="form-control" name="product_description" placeholder="Enter Product Description"><%= checkResult.getString("product_description")%></textarea>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="product_added_date">Product Added Date</label>
                                                        <input type="text" class="form-control" name="product_added_date" value="<%= checkResult.getString("product_added_date")%>" placeholder="Enter Product Added Date"/>
                                                        </div>
                                                </div>
                                            </div>
                                        </div>
                                          
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-success">Update Product</button>
                                            <button type="reset" class="btn btn-secondary">Clear</button>
                                        </div>
                                                        <% 
                                            String successMessage = (String) request.getAttribute("successMessage");
                                            String errorMessage = (String) request.getAttribute("errorMessage");
                                            if (successMessage != null) { 
                                        %>
                                        <div class="alert alert-success" role="alert">
                                            <%= successMessage %>
                                        </div>
                                        <script>
                                            setTimeout(function() {
                                                window.location.href = "user_UpdateProduct.jsp";
                                            }, 2000); // Redirect after 2 seconds
                                        </script>
                                        <% 
                                            } else if (errorMessage != null) { 
                                        %>
                                        <div class="alert alert-danger" role="alert">
                                            <%= errorMessage %>
                                        </div>
                                        <% 
                                            } 
                                        %>   
                                        <% 
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                        %> 
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>
