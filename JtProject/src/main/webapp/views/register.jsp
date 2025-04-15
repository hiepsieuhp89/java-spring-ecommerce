<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Register | E-Shop</title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #5a5c69;
            padding: 40px 0;
        }
        
        .register-container {
            width: 100%;
            max-width: 500px;
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
        
        .form-label {
            font-weight: 600;
            color: #5a5c69;
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
        
        .alert {
            border-radius: 10px;
            font-size: 0.9rem;
        }
        
        .required-field::after {
            content: ' *';
            color: var(--accent-color);
        }
        
        .form-text {
            color: #858796;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="card">
            <div class="card-header">
                <div class="logo">
                    <i class="fas fa-shopping-cart me-2"></i>E-Shop
                </div>
                <p>Create your account to start shopping</p>
            </div>
            <div class="card-body">
                <form action="newuserregister" method="post" class="needs-validation" novalidate>
                    <c:if test="${not empty msg}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${msg}
                        </div>
                    </c:if>
                    
                    <div class="mb-3">
                        <label for="username" class="form-label required-field">Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Choose a username" required>
                        </div>
                        <div class="invalid-feedback">
                            Please choose a username.
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label required-field">Email address</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                        <div class="form-text">
                            We'll never share your email with anyone else.
                        </div>
                        <div class="invalid-feedback">
                            Please enter a valid email address.
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label required-field">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required minlength="6">
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="form-text">
                            Your password must be at least 6 characters long.
                        </div>
                        <div class="invalid-feedback">
                            Please create a password (minimum 6 characters).
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="address" class="form-label">Address</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                            <textarea class="form-control" id="address" name="address" rows="3" placeholder="Enter your shipping address"></textarea>
                        </div>
                    </div>
                    
                    <div class="d-grid gap-2 mb-3">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-user-plus me-2"></i>Create Account
                        </button>
                    </div>
                    
                    <div class="text-center">
                        <p>Already have an account? <a href="/" class="text-decoration-none">Log in</a></p>
                    </div>
                </form>
            </div>
        </div>
        <div class="text-center text-white mt-3">
            <small>&copy; 2023 E-Shop. All rights reserved.</small>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Password toggle visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
        
        // Form validation
        (function () {
            'use strict'
            
            // Fetch all forms with the class 'needs-validation'
            var forms = document.querySelectorAll('.needs-validation')
            
            // Loop through forms and prevent submission if invalid
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html>