<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<%@page import="java.sql.*"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Categories | E-Shop Admin</title>
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
            --dark-color: #5a5c69;
            --success-color: #1cc88a;
            --warning-color: #f6c23e;
            --info-color: #36b9cc;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fc;
            color: #5a5c69;
        }
        
        .navbar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .page-title {
            font-weight: 700;
            margin-bottom: 1.5rem;
        }
        
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        .table {
            color: var(--dark-color);
        }
        
        .table th {
            font-weight: 600;
            background-color: #f8f9fc;
            border-top: none;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            transition: all 0.2s;
        }
        
        .btn-primary:hover {
            background-color: #2e59d9;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background-color: var(--accent-color);
            border: none;
            transition: all 0.2s;
        }
        
        .btn-danger:hover {
            background-color: #be3c30;
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background-color: var(--warning-color);
            border: none;
            color: white;
            transition: all 0.2s;
        }
        
        .btn-warning:hover {
            background-color: #dda20a;
            color: white;
            transform: translateY(-2px);
        }
        
        .modal-content {
            border: none;
            border-radius: 10px;
        }
        
        .modal-header {
            border-bottom: 1px solid #f1f1f1;
            background-color: var(--primary-color);
            color: white;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        
        .modal-footer {
            border-top: 1px solid #f1f1f1;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
        }
        
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            border-radius: 0.2rem;
        }
        
        .action-buttons {
            white-space: nowrap;
        }
        
        .close {
            color: white;
            opacity: 1;
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        .category-count {
            color: var(--primary-color);
            font-weight: 600;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: var(--primary-color);">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-store me-2"></i> E-Shop Admin
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="Dashboard">
                            <i class="fas fa-home me-1"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">
                            <i class="fas fa-sign-out-alt me-1"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Main Content -->
    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="page-title">
                <i class="fas fa-list-alt me-2"></i> Categories Management
            </h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                <i class="fas fa-plus me-1"></i> Add Category
            </button>
        </div>

        <!-- Categories List Card -->
        <div class="card mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold text-primary">Category List</h6>
                <span class="category-count">${categories.size()} Categories</span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Category Name</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="category" items="${categories}">
                                <tr>
                                    <td>${category.id}</td>
                                    <td>${category.name}</td>
                                    <td class="action-buttons">
                                        <button type="button" class="btn btn-warning btn-sm me-2" 
                                            onclick="setupUpdate('${category.id}', '${category.name}')" 
                                            data-bs-toggle="modal" data-bs-target="#updateCategoryModal">
                                            <i class="fas fa-edit me-1"></i> Edit
                                        </button>
                                        <form action="categories/delete" method="get" class="d-inline">
                                            <input type="hidden" name="id" value="${category.id}">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="fas fa-trash me-1"></i> Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Category Modal -->
    <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="categories" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCategoryModalLabel">
                            <i class="fas fa-plus-circle me-2"></i> Add New Category
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="categoryname" class="form-label">Category Name</label>
                            <input type="text" name="categoryname" class="form-control" id="categoryname" required placeholder="Enter category name">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i> Save
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Update Category Modal -->
    <div class="modal fade" id="updateCategoryModal" tabindex="-1" aria-labelledby="updateCategoryModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="categories/update" method="get">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateCategoryModalLabel">
                            <i class="fas fa-edit me-2"></i> Update Category
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="categoryid" class="form-label">Category ID</label>
                            <input type="number" class="form-control" name="categoryid" id="categoryid" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="updateCategoryName" class="form-label">Category Name</label>
                            <input type="text" class="form-control" name="categoryname" id="updateCategoryName" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i> Update
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function setupUpdate(id, name) {
            document.getElementById('categoryid').value = id;
            document.getElementById('updateCategoryName').value = name;
        }
    </script>
</body>
</html>