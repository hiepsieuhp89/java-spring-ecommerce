package com.jtspringproject.JtSpringProject.services;

import com.jtspringproject.JtSpringProject.dao.cartDao;
import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.CartItem;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class cartService {
    @Autowired
    private cartDao cartDao;

    @Transactional
    public Cart addCart(Cart cart) {
        return cartDao.addCart(cart);
    }

    @Transactional
    public Cart getCart(int id) {
        Cart cart = cartDao.getCart(id);
        if (cart != null) {
            Hibernate.initialize(cart.getCartItems());
        }
        return cart;
    }

    @Transactional
    public List<Cart> getCarts() {
        List<Cart> carts = this.cartDao.getCarts();
        // Initialize cart items to prevent lazy loading issues
        for (Cart cart : carts) {
            Hibernate.initialize(cart.getCartItems());
        }
        return carts;
    }

    @Transactional
    public Cart getActiveCartForUser(User user) {
        Cart cart = cartDao.getActiveCartForUser(user);
        // Initialize cart items to prevent lazy loading issues
        if (cart != null) {
            Hibernate.initialize(cart.getCartItems());
        }
        return cart;
    }

    @Transactional
    public void updateCart(Cart cart) {
        cartDao.updateCart(cart);
    }

    @Transactional
    public void deleteCart(Cart cart) {
        cartDao.deleteCart(cart);
    }

    @Transactional
    public CartItem addProductToCart(Cart cart, Product product, int quantity) {
        try {
            CartItem item = this.cartDao.addProductToCart(cart, product, quantity);
            // Re-fetch the cart to ensure its items are initialized
            if (item != null) {
                // Initialize the cart items collection
                Hibernate.initialize(cart.getCartItems());
            }
            return item;
        } catch (Exception e) {
            System.err.println("Error in cartService.addProductToCart: " + e.getMessage());
            e.printStackTrace();
            
            // Try using native SQL approach as a fallback
            return this.addProductToCartNative(cart, product, quantity);
        }
    }

    @Transactional
    public CartItem addProductToCartNative(Cart cart, Product product, int quantity) {
        // This is a fallback method that uses native SQL instead of HQL
        try {
            CartItem item = this.cartDao.addProductToCartNative(cart, product, quantity);
            if (item != null) {
                // Initialize the cart items collection
                Hibernate.initialize(cart.getCartItems());
            }
            return item;
        } catch (Exception e) {
            System.err.println("Native SQL fallback also failed: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    @Transactional
    public boolean removeProductFromCart(Cart cart, int productId) {
        boolean removed = cartDao.removeProductFromCart(cart, productId);
        if (removed) {
            // Re-initialize the cart items
            Hibernate.initialize(cart.getCartItems());
        }
        return removed;
    }

    @Transactional
    public void updateCartItemQuantity(CartItem cartItem, int quantity) {
        cartDao.updateCartItemQuantity(cartItem, quantity);
    }

    @Transactional
    public CartItem getCartItem(int id) {
        return cartDao.getCartItem(id);
    }

    @Transactional
    public List<CartItem> getCartItemsByCart(Cart cart) {
        try {
            // Don't modify the cart's original collection
            List<CartItem> items = cartDao.getCartItemsByCart(cart);
            
            // Return the items without changing the cart's collection
            return items;
        } catch (Exception e) {
            System.err.println("Error fetching cart items: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Transactional
    public void clearCart(Cart cart) {
        cartDao.clearCart(cart);
    }

    @Transactional
    public void checkoutCart(Cart cart) {
        cart.setCheckout(true);
        updateCart(cart);
    }
    
    @Transactional
    public double getCartTotal(Cart cart) {
        // Safely calculate cart total even with lazy loading issues
        if (cart == null) {
            return 0;
        }
        
        double total = 0;
        List<CartItem> items = cartDao.getCartItemsByCart(cart);
        for (CartItem item : items) {
            total += (item.getProduct().getPrice() * item.getQuantity());
        }
        return total;
    }
}
