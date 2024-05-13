<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom CSS styles */
        /* Add your custom styles here */
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Search Results</h2>
        <ul class="list-group mt-3">
            <% for (String productName : (List<String>) request.getAttribute("results")) { %>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <%= productName %>
                    <a href="user_viweProduct.jsp? productName=<%= productName %>" class="btn btn-primary">View</a>
                </li>
            <% } %>
        </ul>
        <a href="javascript:history.back()" class="btn btn-secondary mt-3">Back</a>
    </div>
</body>
</html>
