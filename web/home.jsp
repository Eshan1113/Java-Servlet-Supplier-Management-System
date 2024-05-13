<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="header.jsp"/>
    <style>
        .card {
            border: none;
            background: #f8f9fa;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
            padding: 20px;
        }

        .card:hover {
            box-shadow: 0px 0px 25px rgba(0, 0, 0, 0.2);
            transform: translateY(-5px);
        }

        .card-title {
            font-size: 18px;
            margin-bottom: 15px;
            color: #333;
        }

        .card-text {
            font-size: 16px;
            color: #555;
        }

        .icon {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 24px;
            color: #007bff; /* Adjust the color as needed */
        }

        .card-image {
            width: 80px; /* Adjust the width as needed */
            height: auto;
            margin-bottom: 10px;
        }

        .chart-container {
            width: 100%;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <% 
        // Check session
        session = request.getSession();
        if (session == null || session.getAttribute("UN") == null) {
            response.sendRedirect("Login.jsp");
        }

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/newproject";
        String username = "root";
        String password = "";

        // Initialize variables to store counts
        int totalUsers = 0;
        int totalSuppliers = 0;
        int totalProducts = 0;

        try {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);

            // Count total users
            PreparedStatement usersStmt = conn.prepareStatement("SELECT COUNT(*) FROM userdetials");
            ResultSet usersResult = usersStmt.executeQuery();
            if (usersResult.next()) {
                totalUsers = usersResult.getInt(1);
            }

            // Count total suppliers
            PreparedStatement suppliersStmt = conn.prepareStatement("SELECT COUNT(*) FROM suppliers");
            ResultSet suppliersResult = suppliersStmt.executeQuery();
            if (suppliersResult.next()) {
                totalSuppliers = suppliersResult.getInt(1);
            }

            // Count total products
            PreparedStatement productsStmt = conn.prepareStatement("SELECT COUNT(*) FROM Products");
            ResultSet productsResult = productsStmt.executeQuery();
            if (productsResult.next()) {
                totalProducts = productsResult.getInt(1);
            }

            // Close connections
            usersStmt.close();
            suppliersStmt.close();
            productsStmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
    %>

    <div class="container-scroller">
        <jsp:include page="navbar.jsp"/>
        <div class="container-fluid page-body-wrapper">
            <jsp:include page="navbar2.jsp"/>
            <div class="main-panel">
                <div class="content-wrapper">
                    <div class="row">
                        <div class="col-md-4 grid-margin stretch-card">
                            <div class="card">
                                <i class="fas fa-users icon"></i>
                                <div class="card-body">
                                    <img src="img/group.png" alt="User Image" class="card-image">
                                    <h4 class="card-title">Total Users</h4>
                                    <p class="card-text">Total number of users added: <strong><%= totalUsers %></strong></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 grid-margin stretch-card">
                            <div class="card">
                                <i class="fas fa-truck icon"></i>
                                <div class="card-body">
                                    <img src="img/supplier.png" alt="Supplier Image" class="card-image">
                                    <h4 class="card-title">Total Suppliers</h4>
                                    <p class="card-text">Total number of suppliers added: <strong><%= totalSuppliers %></strong></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 grid-margin stretch-card">
                            <div class="card">
                                <i class="fas fa-box icon"></i>
                                <div class="card-body">
                                    <img src="img/box.png" alt="Product Image" class="card-image">
                                    <h4 class="card-title">Total Products</h4>
                                    <p class="card-text">Total number of products added: <strong><%= totalProducts %></strong></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart-container">
                    <canvas id="myChart"></canvas>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="foter.jsp"/>
    <!-- Include Font Awesome -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <!-- Include Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Data for the chart
        var data = {
            datasets: [{
                label: 'Total Users, Suppliers, and Products',
                data: [
                    { x: 'Users', y: <%= totalUsers %> },
                    { x: 'Suppliers', y: <%= totalSuppliers %> },
                    { x: 'Products', y: <%= totalProducts %> }
                ],
                backgroundColor: ['blue', 'green', 'red'],
                borderColor: ['blue', 'green', 'red'],
                fill: false
            }]
        };

        // Configuration for the chart
        var config = {
            type: 'line', // Changed to line
            data: data,
            options: {
                scales: {
                    x: {
                        type: 'category',
                        title: {
                            display: true,
                            text: 'Category'
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: 'Value'
                        }
                    }
                }
            }
        };

        // Create the chart
        var myChart = new Chart(
            document.getElementById('myChart'),
            config
        );
    </script>
</body>
</html>
