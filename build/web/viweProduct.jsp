<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int recordsPerPage = 10;
    int currentPage = 1;
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    int startRow = (currentPage - 1) * recordsPerPage + 1;
    int endRow = currentPage * recordsPerPage;
    int totalRows = 0;
%>
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
                        <h1>Product Details</h1>
                        <div class="table-responsive"> <!-- Wrap the table in a responsive container -->
                            <table class="table table-striped">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Product Name</th>
                                        <th>Price</th>
                                        <th>Product Description</th>
                                        <th>Product Added Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        try {
                                            // Connect to the database
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newproject", "root", ""); // Replace 'username' and 'password' with your actual credentials

                                            // Count total number of rows
                                            Statement countStmt = con.createStatement();
                                            ResultSet countRs = countStmt.executeQuery("SELECT COUNT(*) AS total FROM products");
                                            if (countRs.next()) {
                                                totalRows = countRs.getInt("total");
                                            }

                                            // Prepare and execute the query to retrieve product details for the current page
                                            PreparedStatement pstmt = con.prepareStatement("SELECT * FROM (SELECT *, ROW_NUMBER() OVER () AS rownum FROM products) AS T WHERE rownum BETWEEN ? AND ?");
                                            pstmt.setInt(1, startRow);
                                            pstmt.setInt(2, endRow);
                                            ResultSet rs = pstmt.executeQuery();

                                            // Iterate through the result set and display data in the table
                                            while (rs.next()) {
                                    %>
                                    <tr>
                                        <td><%= rs.getInt("product_id") %></td>
                                        <td><%= rs.getString("product_name") %></td>
                                        <td><%= rs.getString("price") %></td>
                                        <td><%= rs.getString("product_description") %></td>
                                        <td><%= rs.getString("product_added_date") %></td>
                                        <td>
                                             <form action="DeleteProduct" method="post">
                                                    <input type="hidden" name="product_id" value="<%= rs.getInt("product_id")%>">
                                                    <button type="submit" name="Delete" class="btn btn-danger" onclick="return confirmDelete()">Delete</button>
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
                        <%-- Pagination section --%>
                        <%
                            int totalPages = (int) Math.ceil((double) totalRows / recordsPerPage);
                        %>
                        <div class="row">
                            <div class="col-md-12">
                                <ul class="pagination justify-content-center">
                                    <%-- Previous button --%>
                                    <li class="page-item <%= (currentPage == 1) ? "disabled" : ""%>">
                                        <a class="page-link" href="UpdateProduct.jsp?currentPage=<%= currentPage - 1%>" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                            <span class="sr-only">Previous</span>
                                        </a>
                                    </li>
                                    <%-- Page numbers --%>
                                    <%
                                        for (int i = 1; i <= totalPages; i++) {
                                    %>
                                    <li class="page-item <%= (currentPage == i) ? "active" : ""%>">
                                        <a class="page-link" href="UpdateProduct.jsp?currentPage=<%= i%>"><%= i%></a>
                                    </li>
                                    <%
                                        }
                                    %>
                                    <%-- Next button --%>
                                    <li class="page-item <%= (currentPage == totalPages) ? "disabled" : ""%>">
                                        <a class="page-link" href="UpdateProduct.jsp?currentPage=<%= currentPage + 1%>" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                            <span class="sr-only">Next</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="foter.jsp"/>
    <script>
            function confirmDelete() {
                return confirm("Are you sure you want to delete this supplier?");
            }
        </script>
</body>
</html>
