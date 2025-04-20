<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>403 - Forbidden | E-Shop</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #ee4d2d;
            --secondary-color: #f8f9fc;
            --accent-color: #e74c3c;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            text-align: center;
            padding: 50px;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px 20px;
            background-color: #fff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            border-radius: 8px;
        }

        .error-icon {
            font-size: 5rem;
            color: var(--accent-color);
            margin-bottom: 1.5rem;
        }

        h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 1rem;
        }

        p {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 2rem;
        }

        .button {
            display: inline-block;
            margin: 10px;
            padding: 12px 24px;
            font-size: 1rem;
            font-weight: 600;
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .button:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .home-button {
            background-color: var(--primary-color);
        }

        .home-button:hover {
            background-color: #d73919;
        }

        .logout-button {
            background-color: #6c757d;
        }

        .logout-button:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h1>403 - Forbidden</h1>
        <p>Sorry, you do not have permission to access this page.</p>
        <div>
            <a href="/" class="button home-button">
                <i class="fas fa-home me-2"></i>Go to Home
            </a>
            <a href="/logout" class="button logout-button">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
