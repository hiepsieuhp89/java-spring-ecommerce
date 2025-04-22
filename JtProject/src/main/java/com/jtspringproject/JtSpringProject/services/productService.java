package com.jtspringproject.JtSpringProject.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtspringproject.JtSpringProject.dao.productDao;
import com.jtspringproject.JtSpringProject.models.Product;

@Service
public class productService {
	@Autowired
	private productDao productDao;
	
	/**
	 * Get all products
	 * @return List of all products
	 */
	public List<Product> getProducts(){
		return this.productDao.getProducts();
	}
	
	/**
	 * Add a new product
	 * @param product The product to add
	 * @return The added product
	 */
	public Product addProduct(Product product) {
		// Validate required fields
		if (product.getName() == null || product.getName().trim().isEmpty()) {
			throw new IllegalArgumentException("Product name cannot be empty");
		}
		if (product.getCategory() == null) {
			throw new IllegalArgumentException("Product category cannot be null");
		}
		
		return this.productDao.addProduct(product);
	}
	
	/**
	 * Get a product by ID
	 * @param id The product ID
	 * @return The product if found, null otherwise
	 */
	public Product getProduct(int id) {
		return this.productDao.getProduct(id);
	}

	/**
	 * Update an existing product
	 * @param id The product ID
	 * @param product The updated product data
	 * @return The updated product
	 */
	public Product updateProduct(int id, Product product){
		// Validate required fields
		if (product.getName() == null || product.getName().trim().isEmpty()) {
			throw new IllegalArgumentException("Product name cannot be empty");
		}
		if (product.getCategory() == null) {
			throw new IllegalArgumentException("Product category cannot be null");
		}
		
		product.setId(id);
		return this.productDao.updateProduct(product);
	}
	
	/**
	 * Delete a product by ID
	 * @param id The product ID to delete
	 * @return true if deleted, false otherwise
	 */
	public boolean deleteProduct(int id) {
		return this.productDao.deleteProduct(id);
	}
	
	/**
	 * Get products by category ID
	 * @param categoryId The category ID
	 * @return List of products in that category
	 */
	public List<Product> getProductsByCategory(int categoryId) {
		return this.productDao.getProductsByCategory(categoryId);
	}
}
