
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
                                            <h1 class="mt-5">User Management</h1>
                                            <p class="lead">This is where you can manage your suppliers.</p>

                                            <!-- Example form for adding a new supplier -->
                                            <form action="UserManagement" method="post">
                                                <div class="form-group">
                                                    <label for="userName">User Name:</label>
                                                    <input type="text" class="form-control" id="userName" name="name">
                                                </div>
                                                <div class="form-group">
                                                    <label for="email">Email:</label>
                                                    <input type="email" class="form-control" id="email" name="email">
                                                </div>
                                                <div class="form-group">
                                                    <label for="address">Address:</label>
                                                    <input type="text" class="form-control" id="address" name="address">
                                                </div>
                                                <div class="form-group">
                                                    <label for="mobile">Mobile:</label>
                                                    <input type="text" class="form-control" id="mobile" name="mobile">
                                                </div>
                                                <div class="form-group">
                                                    <label for="role">Role:</label>
                                                    <select class="form-control" id="role" name="role">
                                                        <option value="admin">Admin</option>
                                                        <option value="user">User</option>
                                                    </select>
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
                                                <button type="submit" class="btn btn-success">Add User</button>
                                               
                                               
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