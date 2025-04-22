<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<%@page import="java.sql.*"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Update Product | E-Shop Admin</title>
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
        border-radius: 10px;
        box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
    }
    
    .card-header {
        background-color: white;
        border-bottom: 1px solid #f1f1f1;
        padding: 1.25rem;
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
    
    .form-control:focus, .form-select:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
    }
    
    .form-label {
        font-weight: 600;
        color: var(--dark-color);
    }
    
    .preview-container {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 120px;
        height: 120px;
        border: 2px dashed #d1d3e2;
        border-radius: 5px;
        margin-top: 10px;
        overflow: hidden;
    }
    
    .preview-container img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
    }
    
    .form-control.is-invalid, .form-select.is-invalid {
        border-color: var(--accent-color);
    }
    
    .invalid-feedback {
        color: var(--accent-color);
    }
    
    .section-title {
        font-weight: 600;
        color: var(--primary-color);
        margin-bottom: 1rem;
        padding-bottom: 0.5rem;
        border-bottom: 1px solid #eaecf4;
    }
    
    .required-field::after {
        content: ' *';
        color: var(--accent-color);
    }
</style>
</head>
<body>
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
						<a class="nav-link" href="/admin/products">
							<i class="fas fa-box me-1"></i> Products
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/admin/Dashboard">
							<i class="fas fa-home me-1"></i> Dashboard
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/logout">
							<i class="fas fa-sign-out-alt me-1"></i> Logout
						</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="container py-4">
		<div class="mb-4">
			<h2 class="page-title">
				<i class="fas fa-edit me-2"></i> Update Product
			</h2>
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="/admin/products" class="text-decoration-none">Products</a></li>
					<li class="breadcrumb-item active" aria-current="page">Update Product</li>
				</ol>
			</nav>
		</div>

        <!-- Alert Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Error!</strong> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Error!</strong> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

		<div class="card mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Product Information</h6>
			</div>
			<div class="card-body">
				<form action="/admin/products/update/${product.id}" method="post" class="needs-validation" novalidate>
					<div class="row">
						<div class="col-md-6">
							<h5 class="section-title">Basic Information</h5>
							
							<div class="mb-3">
								<label for="id" class="form-label">Product ID</label>
								<input type="number" readonly class="form-control bg-light" name="id" id="id" value="${product.id}">
							</div>
							
							<div class="mb-3">
								<label for="name" class="form-label required-field">Product Name</label>
								<input type="text" class="form-control" name="name" id="name" required value="${product.name}" placeholder="Enter product name">
								<div class="invalid-feedback">
									Please enter a product name.
								</div>
							</div>
							
							<div class="mb-3">
								<label for="categoryid" class="form-label required-field">Category</label>
								<select class="form-select" name="categoryid" id="categoryid" required>
									<option value="">Select a Category</option>
									<c:forEach var="category" items="${categories}">
										<option value="${category.id}" ${product.category.id == category.id ? 'selected' : ''}>${category.name}</option>
									</c:forEach>
								</select>
								<div class="invalid-feedback">
									Please select a category.
								</div>
							</div>
							
							<div class="mb-3">
								<label for="price" class="form-label required-field">Price ($)</label>
								<input type="number" class="form-control" name="price" id="price" min="0.01" step="0.01" required value="${product.price}" placeholder="Enter price">
								<div class="invalid-feedback">
									Please enter a valid price.
								</div>
							</div>
							
							<div class="mb-3">
								<label for="weight" class="form-label required-field">Weight (grams)</label>
								<input type="number" class="form-control" name="weight" id="weight" min="1" required value="${product.weight}" placeholder="Enter weight in grams">
								<div class="invalid-feedback">
									Please enter a valid weight.
								</div>
							</div>
							
							<div class="mb-3">
								<label for="quantity" class="form-label required-field">Quantity in Stock</label>
								<input type="number" class="form-control" name="quantity" id="quantity" min="0" required value="${product.quantity}" placeholder="Enter available quantity">
								<div class="invalid-feedback">
									Please enter a valid quantity.
								</div>
							</div>
						</div>
						
						<div class="col-md-6">
							<h5 class="section-title">Additional Information</h5>
							
							<div class="mb-3">
								<label for="description" class="form-label">Description</label>
								<textarea class="form-control" name="description" id="description" rows="5" placeholder="Enter product description">${product.description}</textarea>
							</div>
							
							<div class="mb-3">
								<label for="productImageUrl" class="form-label required-field">Product Image URL</label>
								<input type="text" class="form-control" name="productImage" id="productImageUrl" required value="${product.image}" placeholder="Enter image URL">
								<div class="invalid-feedback">
									Please provide an image URL.
								</div>
								<small class="text-muted">Enter a direct URL to the product image</small>
							</div>
							
							<div class="mb-3">
								<label for="productImageFile" class="form-label">Or Upload an Image</label>
								<input type="file" class="form-control" name="productImageFile" id="productImageFile" accept="image/jpeg, image/png" onchange="loadFile(event)">
								<small class="text-muted">If you upload a file, it will override the URL above</small>
							</div>
							
							<div class="mb-3">
								<label class="form-label">Image Preview</label>
								<div class="preview-container">
									<img id="imgPreview" src="${product.image}" alt="${product.name}">
								</div>
							</div>
						</div>
					</div>
					
					<div class="d-flex justify-content-end mt-4">
						<a href="/admin/products" class="btn btn-secondary me-2">
							<i class="fas fa-times me-1"></i> Cancel
						</a>
						<button type="submit" class="btn btn-primary">
							<i class="fas fa-save me-1"></i> Update Product
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
		// Example starter JavaScript for disabling form submissions if there are invalid fields
		(function () {
			'use strict'
			
			// Fetch all the forms we want to apply custom Bootstrap validation styles to
			var forms = document.querySelectorAll('.needs-validation')
			
			// Loop over them and prevent submission
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
		
		// File input preview functionality
		var loadFile = function(event) {
			var image = document.getElementById('imgPreview');
			image.src = URL.createObjectURL(event.target.files[0]);
			// When file is selected, clear the URL field
			document.getElementById('productImageUrl').value = '';
		};
		
		// URL input preview functionality
		document.getElementById('productImageUrl').addEventListener('change', function() {
			var preview = document.getElementById('imgPreview');
			if (this.value) {
				preview.src = this.value;
			} else {
				preview.src = '';
			}
		});
	</script>
</body>
</html>