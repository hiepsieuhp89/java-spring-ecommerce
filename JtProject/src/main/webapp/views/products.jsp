<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.FileOutputStream" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import=" java.io.ObjectOutputStream" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Products | E-Shop Admin</title>
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
            background-color: #d73919;
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
        
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            border-radius: 0.2rem;
        }
        
        .action-buttons {
            white-space: nowrap;
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        .product-count {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: contain;
            border-radius: 5px;
            background-color: #fff;
            padding: 5px;
            border: 1px solid #e3e6f0;
        }
        
        .category-badge {
            background-color: var(--info-color);
            color: white;
            font-size: 0.7rem;
            padding: 0.35em 0.65em;
            border-radius: 50rem;
            display: inline-block;
            font-weight: 600;
        }
        
        .product-name {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .product-desc {
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .price {
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .empty-state {
            text-align: center;
            padding: 2rem;
        }
        
        .empty-state-icon {
            font-size: 3rem;
            color: #d1d3e2;
            margin-bottom: 1rem;
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
                <i class="fas fa-box me-2"></i> Products Management
            </h2>
            <a href="/admin/products/add" class="btn btn-primary">
                <i class="fas fa-plus me-1"></i> Add Product
            </a>
        </div>

        <!-- Products List Card -->
        <div class="card mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold text-primary">Product List</h6>
                <span class="product-count">${products.size()} Products</span>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${products.size() > 0}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Image</th>
                                        <th scope="col">Product Details</th>
                                        <th scope="col">Category</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${products}">
                                        <tr>
                                            <td>${product.id}</td>
                                            <td>
                                                <img src="${product.image}" class="product-image" alt="${product.name}">
                                            </td>
                                            <td>
                                                <div class="product-name">${product.name}</div>
                                                <div class="product-desc text-muted small">${product.description}</div>
                                                <div class="small text-muted mt-1">Weight: ${product.weight}g</div>
                                            </td>
                                            <td>
                                                <span class="category-badge">${product.category.name}</span>
                                            </td>
                                            <td class="price">$${product.price}</td>
                                            <td>
                                                <span class="badge bg-secondary">${product.quantity} in stock</span>
                                            </td>
                                            <td class="action-buttons">
                                                <form action="products/update/${product.id}" method="get" class="d-inline">
                                                    <button type="submit" class="btn btn-warning btn-sm me-1">
                                                        <i class="fas fa-edit me-1"></i> Edit
                                                    </button>
                                                </form>
                                                <form action="products/delete" method="get" class="d-inline">
                                                    <input type="hidden" name="id" value="${product.id}">
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
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-box-open"></i>
                            </div>
                            <h5>No Products Found</h5>
                            <p class="text-muted">There are no products in the database yet.</p>
                            <a href="/admin/products/add" class="btn btn-primary">
                                <i class="fas fa-plus me-1"></i> Add First Product
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>