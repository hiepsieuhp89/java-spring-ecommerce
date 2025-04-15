<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Admin Login | E-Shop</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #224abe;
            --secondary-color: #f8f9fc;
            --accent-color: #e74a3b;
            --dark-color: #3a3b45;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background: linear-gradient(135deg, var(--dark-color) 0%, #161932 100%);
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
            box-shadow: 0 0.5rem 2rem 0 rgba(0, 0, 0, 0.3);
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
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }
        
        .card-header .badge {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
            padding: 0.35em 0.65em;
            border-radius: 10px;
        }
        
        .card-header p {
            color: #858796;
            margin-top: 1rem;
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
            box-shadow: 0 0 0 0.25rem rgba(34, 74, 190, 0.25);
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
            background-color: #1a3a95;
            transform: translateY(-3px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        
        .alert {
            border-radius: 10px;
            font-size: 0.9rem;
        }
        
        .admin-icon {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .restricted-badge {
            background-color: var(--accent-color);
            color: white;
            font-size: 0.7rem;
            padding: 0.25em 0.6em;
            border-radius: 10px;
            margin-left: 5px;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="card">
            <div class="card-header">
                <div class="admin-icon">
                    <i class="fas fa-user-shield"></i>
                </div>
                <div class="logo">
                    E-Shop <span class="badge">Admin Portal</span>
                </div>
                <p>Please enter your admin credentials to login</p>
            </div>
            <div class="card-body">
                <form action="adminloginvalidate" method="post">
                    <% if(request.getAttribute("msg") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <%= request.getAttribute("msg") %>
                    </div>
                    <% } %>
                    
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="floatingInput" name="username" placeholder="Username" required>
                        <label for="floatingInput"><i class="fas fa-user me-2"></i>Username</label>
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
                            <i class="fas fa-sign-in-alt me-2"></i>Admin Login
                        </button>
                    </div>
                </form>
                
                <div class="text-center mt-4">
                    <div class="alert alert-warning" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        This area is restricted to authorized personnel only.
                    </div>
                    <a href="/" class="text-decoration-none">
                        <i class="fas fa-arrow-left me-1"></i>Back to User Login
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
