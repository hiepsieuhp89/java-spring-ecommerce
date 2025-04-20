<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Update Profile | E-Shop</title>
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
            --accent-color: #e74a3b;
            --dark-color: #5a5c69;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fc;
            color: #5a5c69;
            padding: 40px 0;
        }
        
        .profile-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid #f1f1f1;
            padding: 1.5rem;
        }
        
        .card-title {
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 0;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(238, 77, 45, 0.25);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            transition: all 0.3s;
            font-weight: 600;
        }
        
        .btn-primary:hover {
            background-color: #d73919;
            transform: translateY(-2px);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        .form-text {
            font-size: 0.875rem;
            color: #858796;
        }
    </style>
</head>
<body>
    <div class="container profile-container">
        <div class="card mb-4">
            <div class="card-header">
                <h3 class="card-title">
                    <i class="fas fa-user-edit me-2"></i>Update Profile
                </h3>
            </div>
            <div class="card-body p-4">
                <form action="updateuser" method="post" class="needs-validation" novalidate>
                    <input type="hidden" name="userid" value="${userid}">
                    
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="username" value="${username}" required>
                        </div>
                        <div class="invalid-feedback">
                            Please provide a username.
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" value="${email}" required>
                        </div>
                        <div class="form-text">We'll never share your email with anyone else.</div>
                        <div class="invalid-feedback">
                            Please provide a valid email address.
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" value="${password}" required>
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">
                            Please provide a password.
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="address" class="form-label">Address</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                            <textarea class="form-control" id="address" name="address" rows="3">${address}</textarea>
                        </div>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Update Profile
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="text-center mt-3">
            <a href="/user/home" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Homepage
            </a>
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