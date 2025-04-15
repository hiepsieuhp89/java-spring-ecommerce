<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>E-Shop | Login</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #f8f9fc;
            --accent-color: #e74a3b;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background: linear-gradient(135deg, var(--primary-color) 0%, #2a4db7 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #5a5c69;
        }
        
        .login-container {
            width: 100%;
            max-width: 450px;
            padding: 0 15px;
        }
        
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.5rem 2rem 0 rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            text-align: center;
            padding: 2rem 1rem;
        }
        
        .card-header .logo {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        
        .card-header p {
            color: #858796;
            margin-bottom: 0;
        }
        
        .card-body {
            padding: 2rem;
        }
        
        .form-floating > label {
            color: #858796;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            font-weight: 600;
            padding: 0.75rem;
            border-radius: 10px;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            background-color: #2e59d9;
            transform: translateY(-3px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        
        .btn-google {
            background-color: #ea4335;
            color: white;
        }
        
        .btn-facebook {
            background-color: #3b5998;
            color: white;
        }
        
        .divider-text {
            position: relative;
            text-align: center;
            margin-top: 15px;
            margin-bottom: 15px;
        }
        
        .divider-text span {
            padding: 7px;
            font-size: 12px;
            position: relative;
            z-index: 2;
            background-color: #fff;
        }
        
        .divider-text:after {
            content: "";
            position: absolute;
            width: 100%;
            border-bottom: 1px solid #ddd;
            top: 55%;
            left: 0;
            z-index: 1;
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .alert {
            border-radius: 10px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="card">
            <div class="card-header">
                <div class="logo"><i class="fas fa-shopping-cart me-2"></i>E-Shop</div>
                <p>Welcome back! Please login to your account</p>
            </div>
            <div class="card-body">
                <form action="userloginvalidate" method="post">
                    <% if(request.getAttribute("message") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <%= request.getAttribute("message") %>
                    </div>
                    <% } %>
                    
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="floatingInput" name="username" placeholder="name@example.com" required>
                        <label for="floatingInput"><i class="fas fa-envelope me-2"></i>Email address</label>
                    </div>
                    
                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password" required>
                        <label for="floatingPassword"><i class="fas fa-lock me-2"></i>Password</label>
                    </div>
                    
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">
                                Remember Me
                            </label>
                        </div>
                        <a href="#" class="text-decoration-none">Forgot password?</a>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </button>
                    </div>
                </form>
                
                <div class="divider-text">
                    <span class="bg-light">OR</span>
                </div>
                
                <div class="d-grid gap-2 mb-3">
                    <a href="#" class="btn btn-google">
                        <i class="fab fa-google me-2"></i>Continue with Google
                    </a>
                </div>
                
                <div class="text-center">
                    <p>Don't have an account? <a href="register" class="text-decoration-none">Sign up</a></p>
                    <a href="adminlogin" class="text-decoration-none">
                        <i class="fas fa-user-shield me-1"></i>Admin Login
                    </a>
                </div>
            </div>
        </div>
        <div class="text-center text-white mt-3">
            <small>&copy; 2023 E-Shop. All rights reserved.</small>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
