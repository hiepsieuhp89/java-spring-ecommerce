package com.jtspringproject.JtSpringProject.dao;

import com.jtspringproject.JtSpringProject.models.Order;
import com.jtspringproject.JtSpringProject.models.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class orderDao {
    
    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }
    
    @Transactional
    public Order saveOrder(Order order) {
        this.sessionFactory.getCurrentSession().save(order);
        return order;
    }
    
    @Transactional
    public Order getOrder(int id) {
        return this.sessionFactory.getCurrentSession().get(Order.class, id);
    }
    
    @Transactional
    public List<Order> getAllOrders() {
        return this.sessionFactory.getCurrentSession().createQuery("from ORDERS", Order.class).list();
    }
    
    @Transactional
    public List<Order> getOrdersByUser(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        Query<Order> query = session.createQuery(
                "FROM ORDERS o WHERE o.customer = :customer ORDER BY o.orderDate DESC", 
                Order.class);
        query.setParameter("customer", user);
        return query.getResultList();
    }
    
    @Transactional
    public Order updateOrder(Order order) {
        this.sessionFactory.getCurrentSession().update(order);
        return order;
    }
    
    @Transactional
    public void deleteOrder(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Order order = session.get(Order.class, id);
        if (order != null) {
            session.delete(order);
        }
    }
} 