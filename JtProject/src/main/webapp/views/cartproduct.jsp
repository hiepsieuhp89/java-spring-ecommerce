<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.FileOutputStream" %>    
<%@page import=" java.io.ObjectOutputStream" %>    
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Shopping Cart | E-Shop</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #ee4d2d;
            --secondary-color: #f8f9fc;
            --accent-color: #e74a3b;
        }
        
        body {
            background-color: #f8f9fc;
            font-family: 'Nunito', sans-serif;
        }
        
        .navbar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: transform 0.3s ease;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
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
            background-color: #c0392b;
            transform: translateY(-2px);
        }
        
        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        .table thead {
            background-color: var(--primary-color);
            color: white;
        }
        
        .empty-cart-message {
            text-align: center;
            padding: 30px;
        }
        
        .product-name {
            font-weight: 600;
        }
        
        .page-title {
            color: #5a5c69;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: var(--primary-color);">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-shopping-cart me-2"></i> E-Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="/adminhome">
                            <i class="fas fa-home me-1"></i> Home
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

    <!-- Main Content -->
    <div class="container py-5">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="page-title"><i class="fas fa-shopping-cart me-2"></i>Your Shopping Cart</h1>
            <a href="/user/products" class="btn btn-primary">
                <i class="fas fa-plus me-1"></i> Add Products
            </a>
        </div>

        <div class="card">
            <div class="card-body">
                <%
                try {
                    String url = "jdbc:mysql://localhost:3306/springproject";
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(url, "root", "");
                    Statement stmt = con.createStatement();
                    Statement stmt2 = con.createStatement();
                    ResultSet rs = stmt.executeQuery("select * from cart");
                    boolean hasItems = rs.isBeforeFirst();
                    
                    if (!hasItems) {
                %>
                    <div class="empty-cart-message">
                        <i class="fas fa-shopping-cart fa-4x mb-3 text-muted"></i>
                        <h3>Your cart is empty</h3>
                        <p class="text-muted">Add some products to your cart and they will appear here.</p>
                        <a href="/user/products" class="btn btn-primary mt-3">
                            <i class="fas fa-shopping-bag me-1"></i> Browse Products
                        </a>
                    </div>
                <%
                    } else {
                %>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Product Name</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Description</th>
                                    <th scope="col">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            while (rs.next()) {
                            %>
                                <tr>
                                    <td><%= rs.getInt(1) %></td>
                                    <td class="product-name"><%= rs.getString(2) %></td>
                                    <td>$<%= rs.getString(3) %></td>
                                    <td><%= rs.getString(4) %></td>
                                    <td>
                                        <form action="cart/delete" method="get">
                                            <input type="hidden" name="id" value="<%=rs.getInt(1)%>">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="fas fa-trash me-1"></i> Remove
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            <%
                            }
                            %>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="d-flex justify-content-end mt-4">
                        <a href="#" class="btn btn-primary">
                            <i class="fas fa-credit-card me-1"></i> Proceed to Checkout
                        </a>
                    </div>
                <%
                    }
                } catch (Exception ex) {
                    out.println("<div class='alert alert-danger'><i class='fas fa-exclamation-triangle me-2'></i>Error: " + ex.getMessage() + "</div>");
                }
                %>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="py-4 bg-light mt-auto">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between small">
                <div class="text-muted">Copyright &copy; E-Shop 2023</div>
                <div>
                    <a href="#">Privacy Policy</a>
                    &middot;
                    <a href="#">Terms &amp; Conditions</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>