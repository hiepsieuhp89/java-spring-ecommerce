package com.jtspringproject.JtSpringProject.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.models.Product;

@Repository
public class productDao {
	@Autowired
    private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }
	
	@Transactional(readOnly = true)
	public List<Product> getProducts(){
		Session session = this.sessionFactory.getCurrentSession();
		Query<Product> query = session.createQuery("from PRODUCT", Product.class);
		return query.list();
	}
	
	@Transactional
	public Product addProduct(Product product) {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(product);
		return product;
	}
	
	@Transactional(readOnly = true)
	public Product getProduct(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		return session.get(Product.class, id);
	}

	@Transactional
	public Product updateProduct(Product product){
		Session session = this.sessionFactory.getCurrentSession();
		session.merge(product);
		session.flush();
		return product;
	}
	
	@Transactional
	public Boolean deleteProduct(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		Product product = session.get(Product.class, id);

		if (product != null) {
			session.delete(product);
			return true;
		}
		return false;
	}
	
	@Transactional(readOnly = true)
	public List<Product> getProductsByCategory(int categoryId) {
		Session session = this.sessionFactory.getCurrentSession();
		Query<Product> query = session.createQuery(
				"from PRODUCT p where p.category.id = :categoryId", 
				Product.class);
		query.setParameter("categoryId", categoryId);
		return query.list();
	}
}
