package com.jtspringproject.JtSpringProject.dao;

import java.util.ArrayList;
import java.util.List;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.CartItem;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class cartDao {
    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }

    @Transactional
    public Cart addCart(Cart cart) {
        this.sessionFactory.getCurrentSession().save(cart);
        return cart;
    }

    @Transactional
    public List<Cart> getCarts() {
        return this.sessionFactory.getCurrentSession().createQuery("from CART").list();
    }

    @Transactional
    public Cart getCart(int id) {
        return this.sessionFactory.getCurrentSession().get(Cart.class, id);
    }
    
    @Transactional
    public Cart getActiveCartForUser(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        Query<Cart> query = session.createQuery(
                "FROM CART c WHERE c.customer = :customer AND c.isCheckout = false", 
                Cart.class);
        query.setParameter("customer", user);
        List<Cart> carts = query.getResultList();
        
        if (carts.isEmpty()) {
            // Create a new cart for the user
            Cart newCart = new Cart();
            newCart.setCustomer(user);
            newCart.setCheckout(false);
            session.save(newCart);
            return newCart;
        }
        
        return carts.get(0);
    }

    @Transactional
    public void updateCart(Cart cart) {
        this.sessionFactory.getCurrentSession().update(cart);
    }

    @Transactional
    public void deleteCart(Cart cart) {
        this.sessionFactory.getCurrentSession().delete(cart);
    }
    
    @Transactional
    public CartItem addProductToCart(Cart cart, Product product, int quantity) {
        Session session = this.sessionFactory.getCurrentSession();
        
        try {
            // Check if product already exists in cart
            Query<CartItem> query = session.createQuery(
                    "FROM CART_ITEMS ci WHERE ci.cart = :cart AND ci.product = :product", 
                    CartItem.class);
            query.setParameter("cart", cart);
            query.setParameter("product", product);
            List<CartItem> existingItems = query.getResultList();
            
            CartItem cartItem;
            
            if (!existingItems.isEmpty()) {
                // Update existing cart item
                cartItem = existingItems.get(0);
                cartItem.setQuantity(cartItem.getQuantity() + quantity);
                session.update(cartItem);
            } else {
                // Create new cart item
                cartItem = new CartItem(cart, product, quantity);
                session.save(cartItem);
                cart.addCartItem(cartItem);
            }
            
            return cartItem;
        } catch (Exception e) {
            // Log exception details
            System.err.println("Error adding product to cart: " + e.getMessage());
            e.printStackTrace();
            
            // Alternative native SQL approach if HQL fails
            try {
                // Check if item exists using native SQL
                String checkSql = "SELECT * FROM CART_ITEMS WHERE cart_id = :cartId AND product_id = :productId";
                Query checkQuery = session.createNativeQuery(checkSql, CartItem.class);
                checkQuery.setParameter("cartId", cart.getId());
                checkQuery.setParameter("productId", product.getId());
                List<CartItem> existingItems = checkQuery.getResultList();
                
                CartItem cartItem;
                
                if (!existingItems.isEmpty()) {
                    // Update existing
                    cartItem = existingItems.get(0);
                    cartItem.setQuantity(cartItem.getQuantity() + quantity);
                    session.update(cartItem);
                } else {
                    // Create new
                    cartItem = new CartItem(cart, product, quantity);
                    session.save(cartItem);
                    cart.addCartItem(cartItem);
                }
                
                return cartItem;
            } catch (Exception e2) {
                System.err.println("Native SQL approach also failed: " + e2.getMessage());
                throw e2;
            }
        }
    }
    
    @Transactional
    public boolean removeProductFromCart(Cart cart, int productId) {
        Session session = this.sessionFactory.getCurrentSession();
        
        try {
            // Find product in cart
            Query<CartItem> query = session.createQuery(
                    "FROM CART_ITEMS ci WHERE ci.cart = :cart AND ci.product.id = :productId", 
                    CartItem.class);
            query.setParameter("cart", cart);
            query.setParameter("productId", productId);
            List<CartItem> items = query.getResultList();
            
            if (!items.isEmpty()) {
                CartItem item = items.get(0);
                cart.removeCartItem(item);
                session.delete(item);
                return true;
            }
            
            return false;
        } catch (Exception e) {
            System.err.println("Error removing product from cart: " + e.getMessage());
            
            // Fallback to native SQL
            try {
                String sql = "DELETE FROM CART_ITEMS WHERE cart_id = :cartId AND product_id = :productId";
                Query query = session.createNativeQuery(sql);
                query.setParameter("cartId", cart.getId());
                query.setParameter("productId", productId);
                int rowsAffected = query.executeUpdate();
                
                return rowsAffected > 0;
            } catch (Exception e2) {
                System.err.println("Native SQL fallback also failed: " + e2.getMessage());
                return false;
            }
        }
    }
    
    @Transactional
    public void updateCartItemQuantity(CartItem cartItem, int quantity) {
        cartItem.setQuantity(quantity);
        this.sessionFactory.getCurrentSession().update(cartItem);
    }
    
    @Transactional
    public CartItem getCartItem(int id) {
        return this.sessionFactory.getCurrentSession().get(CartItem.class, id);
    }
    
    @Transactional
    public List<CartItem> getCartItemsByCart(Cart cart) {
        Session session = this.sessionFactory.getCurrentSession();
        try {
            Query<CartItem> query = session.createQuery(
                    "FROM CART_ITEMS ci WHERE ci.cart = :cart", 
                    CartItem.class);
            query.setParameter("cart", cart);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Error getting cart items: " + e.getMessage());
            
            // Fallback to native SQL
            String sql = "SELECT * FROM CART_ITEMS WHERE cart_id = :cartId";
            Query query = session.createNativeQuery(sql, CartItem.class);
            query.setParameter("cartId", cart.getId());
            return query.getResultList();
        }
    }
    
    @Transactional
    public void clearCart(Cart cart) {
        Session session = this.sessionFactory.getCurrentSession();
        
        try {
            // Delete all cart items
            Query query = session.createQuery(
                    "DELETE FROM CART_ITEMS ci WHERE ci.cart = :cart");
            query.setParameter("cart", cart);
            query.executeUpdate();
            
            // Clear cart items collection
            cart.getCartItems().clear();
        } catch (Exception e) {
            System.err.println("Error clearing cart: " + e.getMessage());
            
            // Fallback to native SQL
            try {
                String sql = "DELETE FROM CART_ITEMS WHERE cart_id = :cartId";
                Query query = session.createNativeQuery(sql);
                query.setParameter("cartId", cart.getId());
                query.executeUpdate();
                
                // Clear cart items collection
                cart.getCartItems().clear();
            } catch (Exception e2) {
                System.err.println("Native SQL fallback also failed: " + e2.getMessage());
                throw e2;
            }
        }
    }

    @Transactional
    public CartItem addProductToCartNative(Cart cart, Product product, int quantity) {
        Session session = this.sessionFactory.getCurrentSession();
        
        try {
            // Check if product already exists in cart using native SQL
            String checkSql = "SELECT * FROM CART_ITEMS WHERE cart_id = :cartId AND product_id = :productId";
            Query checkQuery = session.createNativeQuery(checkSql);
            checkQuery.setParameter("cartId", cart.getId());
            checkQuery.setParameter("productId", product.getId());
            List<Object[]> existingItems = checkQuery.getResultList();
            
            CartItem cartItem;
            
            if (!existingItems.isEmpty()) {
                // Update existing item using native SQL
                Object[] row = existingItems.get(0);
                int itemId = ((Number) row[0]).intValue();
                int currentQuantity = ((Number) row[3]).intValue();
                int newQuantity = currentQuantity + quantity;
                
                String updateSql = "UPDATE CART_ITEMS SET quantity = :quantity WHERE id = :id";
                Query updateQuery = session.createNativeQuery(updateSql);
                updateQuery.setParameter("quantity", newQuantity);
                updateQuery.setParameter("id", itemId);
                updateQuery.executeUpdate();
                
                // Get the updated cart item
                cartItem = session.get(CartItem.class, itemId);
            } else {
                // Insert new cart item using native SQL
                cartItem = new CartItem(cart, product, quantity);
                session.save(cartItem);
                
                // Update the cart's items collection
                if (!cart.getCartItems().contains(cartItem)) {
                    cart.addCartItem(cartItem);
                }
            }
            
            return cartItem;
        } catch (Exception e) {
            System.err.println("Error in native SQL approach: " + e.getMessage());
            e.printStackTrace();
            
            // Last resort: direct JDBC
            try {
                java.sql.Connection conn = session.doReturningWork(connection -> connection);
                
                // Check if item exists
                String checkSql = "SELECT id, quantity FROM CART_ITEMS WHERE cart_id = ? AND product_id = ?";
                java.sql.PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                checkStmt.setInt(1, cart.getId());
                checkStmt.setInt(2, product.getId());
                java.sql.ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    // Update existing
                    int itemId = rs.getInt("id");
                    int currentQty = rs.getInt("quantity");
                    int newQty = currentQty + quantity;
                    
                    String updateSql = "UPDATE CART_ITEMS SET quantity = ? WHERE id = ?";
                    java.sql.PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                    updateStmt.setInt(1, newQty);
                    updateStmt.setInt(2, itemId);
                    updateStmt.executeUpdate();
                    
                    // Create and return a CartItem object
                    CartItem item = new CartItem();
                    item.setId(itemId);
                    item.setCart(cart);
                    item.setProduct(product);
                    item.setQuantity(newQty);
                    return item;
                } else {
                    // Insert new
                    String insertSql = "INSERT INTO CART_ITEMS (cart_id, product_id, quantity) VALUES (?, ?, ?)";
                    java.sql.PreparedStatement insertStmt = conn.prepareStatement(insertSql, java.sql.Statement.RETURN_GENERATED_KEYS);
                    insertStmt.setInt(1, cart.getId());
                    insertStmt.setInt(2, product.getId());
                    insertStmt.setInt(3, quantity);
                    insertStmt.executeUpdate();
                    
                    // Get generated ID
                    java.sql.ResultSet generatedKeys = insertStmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int newId = generatedKeys.getInt(1);
                        
                        // Create and return a CartItem object
                        CartItem item = new CartItem();
                        item.setId(newId);
                        item.setCart(cart);
                        item.setProduct(product);
                        item.setQuantity(quantity);
                        
                        // Update cart's collection
                        if (!cart.getCartItems().contains(item)) {
                            cart.addCartItem(item);
                        }
                        
                        return item;
                    }
                }
                
                // Close resources
                rs.close();
                checkStmt.close();
            } catch (Exception e2) {
                System.err.println("JDBC approach also failed: " + e2.getMessage());
                e2.printStackTrace();
            }
            
            throw e;
        }
    }
}
