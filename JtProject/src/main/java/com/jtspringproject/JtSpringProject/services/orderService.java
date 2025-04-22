package com.jtspringproject.JtSpringProject.services;

import com.jtspringproject.JtSpringProject.dao.orderDao;
import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.CartItem;
import com.jtspringproject.JtSpringProject.models.Order;
import com.jtspringproject.JtSpringProject.models.OrderItem;
import com.jtspringproject.JtSpringProject.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class orderService {
    
    @Autowired
    private orderDao orderDao;
    
    @Autowired
    private cartService cartService;
    
    public Order createOrder(User user, Cart cart, String shippingAddress, String paymentMethod) {
        Order order = new Order();
        order.setCustomer(user);
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("Pending");
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        
        // Get cart items without modifying the cart's collection
        List<CartItem> cartItems = cartService.getCartItemsByCart(cart);
        
        // Add all cart items to order
        for (CartItem cartItem : cartItems) {
            OrderItem orderItem = OrderItem.fromCartItem(order, cartItem);
            order.addOrderItem(orderItem);
        }
        
        // Calculate total
        order.calculateTotal();
        
        // Save order
        order = orderDao.saveOrder(order);
        
        // Checkout cart
        cartService.checkoutCart(cart);
        
        return order;
    }
    
    public Order getOrder(int id) {
        return orderDao.getOrder(id);
    }
    
    public List<Order> getAllOrders() {
        return orderDao.getAllOrders();
    }
    
    public List<Order> getOrdersByUser(User user) {
        return orderDao.getOrdersByUser(user);
    }
    
    public Order updateOrderStatus(int id, String status) {
        Order order = orderDao.getOrder(id);
        if (order != null) {
            order.setStatus(status);
            return orderDao.updateOrder(order);
        }
        return null;
    }
    
    public void deleteOrder(int id) {
        orderDao.deleteOrder(id);
    }
} 