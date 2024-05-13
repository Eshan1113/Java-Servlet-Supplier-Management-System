<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
    <style>
        .placeicon {
            font-family: fontawesome;
        }
        .custom-control-label::before {
            background-color: #dee2e6;
            border: #dee2e6;
        }
        .snippet-body {
            background-color: #f8f9fa; /* Set a light gray background color */
            padding-top: 20px; /* Add some top padding to the body */
        }
        .form-container {
            margin-top: 50px; /* Add margin to the top of the container */
        }
        .form-heading {
            text-align: center;
            margin-bottom: 30px; /* Add margin to the bottom of the heading */
        }
        .form-group {
            margin-bottom: 20px; /* Add margin to the bottom of each form group */
        }
    </style>
</head>
<body>
    <div class="container form-container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card">
                    <div class="card-body">
                        <h1 class="card-title form-heading">Reset Password</h1>
                        <form action="newPassword" method="POST">
                            <div class="form-group">
                                <input type="text" name="password" placeholder=" New Password" class="form-control border-info placeicon">
                            </div>
                            <div class="form-group">
                                <input type="password" name="confPassword" placeholder=" Confirm New Password" class="form-control border-info placeicon">
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-info btn-block">Reset</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="mt-4 text-center">
                    <p class="mb-1">Don't have an Account? <a href="Signup.jsp" class="text-danger">Register Now!</a></p>
                </div>
            </div>
        </div>
    </div>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
</body>
</html>
