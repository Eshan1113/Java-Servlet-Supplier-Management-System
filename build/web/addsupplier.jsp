
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% session = request.getSession();
    if (session == null || session.getAttribute("UN") == null) {
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
                            <div class="container">
                                <div class="d-flex justify-content-center"> <!-- Centering the form horizontally -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <h1 class="mt-5">Supplier Management</h1>
                                            <p class="lead">This is where you can manage your suppliers.</p>

                                            <!-- Example form for adding a new supplier -->
                                            <form action="addsupplier" method="post">
                                                <div class="form-group">
                                                    <label for="supplierName">Supplier Name:</label>
                                                    <input type="text" class="form-control" id="supplierName" name="name">
                                                </div>
                                                <div class="form-group">
                                                    <label for="contactPerson">Contact Person:</label>
                                                    <input type="text" class="form-control" id="contactPerson" name="contactPerson">
                                                </div>
                                                <div class="form-group">
                                                    <label for="email">Email:</label>
                                                    <input type="email" class="form-control" id="email" name="email">
                                                </div>
                                                <div class="form-group">
                                                    <label for="phone">Phone:</label>
                                                    <input type="text" class="form-control" id="phone" name="phone">
                                                </div>
                                                <div class="form-group">
                                                    <label for="address">Address:</label>
                                                    <input type="text" class="form-control" id="address" name="address">
                                                </div>
                                                <div class="form-group">
                                                    <label for="city">City:</label>
                                                    <input type="text" class="form-control" id="city" name="city">
                                                </div>
                                                <div class="form-group">
                                                    <label for="state">State:</label>
                                                    <input type="text" class="form-control" id="state" name="state">
                                                </div>
                                                <div class="form-group">
                                                    <label for="postalCode">Postal Code:</label>
                                                    <input type="text" class="form-control" id="postalCode" name="postalCode">
                                                </div>
                                                <div class="form-group">
                                                    <label for="country">Country:</label>
                                                    <input type="text" class="form-control" id="country" name="country">
                                                </div>
                                                <div class="form-group">
                                                    <label for="notes">Notes:</label>
                                                    <textarea class="form-control" id="notes" name="notes"></textarea>
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
                                                <button type="submit" class="btn btn-success">Add Supplier</button>

                                               
                                               


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
        <jsp:include page="foter.jsp"/>
    </body>







</html>