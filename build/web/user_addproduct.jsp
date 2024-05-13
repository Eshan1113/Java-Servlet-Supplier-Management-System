
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% session = request.getSession();
    if (session == null || session.getAttribute("UN") == null) {
        response.sendRedirect("Login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="userheader.jsp"/>     
    <body>
        <div class="container-scroller">
            <jsp:include page="usernavbar.jsp"/>
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="usernavbar2.jsp"/>
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <div class="container">
                                <div class="d-flex justify-content-center"> <!-- Centering the form horizontally -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <h1 class="mt-5">Product Management</h1>
                                            <p class="lead">This is where you can manage your products.</p>

                                            <!-- Example form for adding a new product -->
                                            <form action="useraddproduct" method="post">
                                                <div class="form-group">
                                                    <label for="productName">Product Name:</label>
                                                    <input type="text" class="form-control" id="productName" name="product_name">
                                                </div>
                                                <div class="form-group">
                                                    <label for="price">Price:</label>
                                                    <input type="text" class="form-control" id="price" name="price">
                                                </div>
                                                <div class="form-group">
                                                    <label for="description">Product Description:</label>
                                                    <textarea class="form-control" id="description" name="product_description"></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label for="productAddedDate">Product Added Date:</label>
                                                    <input type="text" class="form-control" id="productAddedDate" name="product_added_date" value="<%= new java.util.Date()%>" readonly>
                                                </div>
                                                <%-- Check if there's an error message --%>
                                                <% if (request.getAttribute("errorMessage") != null) {%>
                                                <div style="color: red;">
                                                    <%= request.getAttribute("errorMessage")%>
                                                </div>
                                                <% } %>

                                                <%-- Check if there's a success message --%>
                                                <% if (request.getAttribute("successMessage") != null) {%>
                                                <div style="color: green;">
                                                    <%= request.getAttribute("successMessage")%>
                                                </div>
                                                <% }%>
                                                <button type="submit" class="btn btn-success">Add Product</button>
                                            </form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="userfoter.jsp"/>
    </body>







</html>