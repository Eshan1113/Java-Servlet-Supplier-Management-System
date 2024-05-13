<%-- 
    Document   : Update
    Created on : Mar 1, 2024, 8:09:42 PM
    Author     : - AI -
--%>

<%@page import="Model.DBConn"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% session = request.getSession();
    if (session == null || session.isNew()) {
        response.sendRedirect("Login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Supplier Details Form</title>
    <jsp:include page="userheader.jsp"/>     
</head>
<body>
    <div class="container-scroller">
      <jsp:include page="usernavbar.jsp"/>  
        <div class="container-fluid page-body-wrapper">
             <jsp:include page="usernavbar2.jsp"/>  
            <div class="main-panel">
                <div class="content-wrapper">
                    <div class="row">
                        <div class="col-md-8 offset-md-2">
                            <div class="card mt-5">
                                <div class="card-body">
                                    <h5 class="card-title text-center">Update Supplier Details Form</h5>
                                    
                                    <form action="userSupplierEdit" method="POST">
                                        <% String successMessage = (String) request.getAttribute("successMessage");
                                           String errorMessage = (String) request.getAttribute("errorMessage");
                                           if (successMessage != null) { %>
                                               <div class="alert alert-success" role="alert">
                                                   <%= successMessage %>
                                               </div>
                                               <script>
                                                   setTimeout(function() {
                                                       window.location.href = "user_editsupplier.jsp";
                                                   }, 2000); // Redirect after 3 seconds
                                               </script>
                                        <% } else if (errorMessage != null) { %>
                                               <div class="alert alert-danger" role="alert">
                                                   <%= errorMessage %>
                                               </div>
                                        <% } %>   
                              
                                        <% 
                                            try (Connection conn = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");) {
                                                PreparedStatement pst;
                                                String id = request.getParameter("SupplierID");
                                                String checkSql = "SELECT * FROM Suppliers WHERE SupplierID = ?";
                                                PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                checkStmt.setString(1, id);

                                                ResultSet checkResult = checkStmt.executeQuery();

                                                while (checkResult.next()) { 
                                        %>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <input name="id" type="text" value="<%= id%>" hidden/>
                                                    <div class="form-group">
                                                        <label for="name">Name</label>
                                                        <input type="text" class="form-control" name="name" value="<%= checkResult.getString("Name")%>" placeholder="Enter Name"/>
                                                    </div>
                                                     <div class="mb-3">
                                                                <label for="contactPerson" class="form-label">Contact Person</label>
                                                                <input type="text" class="form-control" name="contactPerson" value="<%= checkResult.getString("ContactPerson")%>" placeholder="Enter contact person"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="email" class="form-label">Email</label>
                                                                <input type="text" class="form-control" name="email" value="<%= checkResult.getString("Email")%>" placeholder="Enter email"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="phone" class="form-label">Phone</label>
                                                                <input type="text" class="form-control" name="phone" value="<%= checkResult.getString("Phone")%>" placeholder="Enter phone"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="address" class="form-label">Address</label>
                                                                <input type="text" class="form-control" name="address" value="<%= checkResult.getString("Address")%>" placeholder="Enter address"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="city" class="form-label">City</label>
                                                                <input type="text" class="form-control" name="city" value="<%= checkResult.getString("City")%>" placeholder="Enter city"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="state" class="form-label">State</label>
                                                                <input type="text" class="form-control" name="state" value="<%= checkResult.getString("State")%>" placeholder="Enter state"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="postalCode" class="form-label">Postal Code</label>
                                                                <input type="text" class="form-control" name="postalCode" value="<%= checkResult.getString("PostalCode")%>" placeholder="Enter postal code"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="country" class="form-label">Country</label>
                                                                <input type="text" class="form-control" name="country" value="<%= checkResult.getString("Country")%>" placeholder="Enter country"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="notes" class="form-label">Notes</label>
                                                                <textarea class="form-control" name="notes" placeholder="Enter notes"><%= checkResult.getString("Notes")%></textarea>
                                                            </div>
                                                        </div>
                                                </div>
                                            </div>
                                        </div>
                                          
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-success">Update Supplier</button>
                                            <button type="reset" class="btn btn-secondary">Clear</button>
                                        </div>
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
  <jsp:include page="userheader.jsp"/>     
</body>
</html>
