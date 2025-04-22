package com.jtspringproject.JtSpringProject.controller;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.CartItem;
import com.jtspringproject.JtSpringProject.models.Order;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;

import java.io.Console;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.jtspringproject.JtSpringProject.services.cartService;
import com.jtspringproject.JtSpringProject.services.orderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jtspringproject.JtSpringProject.services.userService;
import com.jtspringproject.JtSpringProject.services.productService;

@Controller
public class UserController {

	private final userService userService;
	private final productService productService;
	private final cartService cartService;
	private final orderService orderService;

	@Autowired
	public UserController(userService userService, productService productService, cartService cartService, orderService orderService) {
		this.userService = userService;
		this.productService = productService;
		this.cartService = cartService;
		this.orderService = orderService;
	}

	@GetMapping("/register")
	public String registerUser() {
		return "register";
	}

	@GetMapping("/buy")
	public String buy() {
		return "buy";
	}

	@GetMapping("/login")
	public ModelAndView userlogin(@RequestParam(required = false) String error) {
	    ModelAndView mv = new ModelAndView("userLogin");
	    if ("true".equals(error)) {
	        mv.addObject("msg", "Please enter correct email and password");
	    }
	    return mv;
	}
	
	@GetMapping("/")
	public ModelAndView indexPage() {
		ModelAndView mView  = new ModelAndView("index");	
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		mView.addObject("username", username);
		List<Product> products = this.productService.getProducts();

		if (products.isEmpty()) {
			mView.addObject("msg", "No products are available");
		} else {
			mView.addObject("products", products);
		}
		return mView;
	}
	
	@GetMapping("/user/products")
	public ModelAndView getproduct() {
		ModelAndView mView = new ModelAndView("uproduct");
		List<Product> products = this.productService.getProducts();

		if(products.isEmpty()) {
			mView.addObject("msg","No products are available");
		} else {
			mView.addObject("products",products);
		}

		return mView;
	}
	
	@RequestMapping(value = "newuserregister", method = RequestMethod.POST)
	public ModelAndView newUseRegister(@ModelAttribute User user) {
		// Check if username already exists in database
		boolean exists = this.userService.checkUserExists(user.getUsername());

		if(!exists) {
			System.out.println(user.getEmail());
			user.setRole("ROLE_NORMAL");
			this.userService.addUser(user);

			System.out.println("New user created: " + user.getUsername());
			ModelAndView mView = new ModelAndView("userLogin");
			return mView;
		} else {
			System.out.println("New user not created - username taken: " + user.getUsername());
			ModelAndView mView = new ModelAndView("register");
			mView.addObject("msg", user.getUsername() + " is taken. Please choose a different username.");
			return mView;
		}
	}

	@GetMapping("/profileDisplay")
	public String profileDisplay(Model model) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);
	
		if (user != null) {
			model.addAttribute("userid", user.getId());
			model.addAttribute("username", user.getUsername());
			model.addAttribute("email", user.getEmail());
			model.addAttribute("password", user.getPassword()); 
			model.addAttribute("address", user.getAddress());
	    } else {
	    	model.addAttribute("msg", "User not found");
	    } 

		return "updateProfile";
	}
	
	@GetMapping("/cart")
	public String viewCart(Model model) {
		try {
			String username = SecurityContextHolder.getContext().getAuthentication().getName();
			User user = userService.getUserByUsername(username);
			
			if (user != null) {
				// Get cart without modifying its collections
				Cart cart = cartService.getActiveCartForUser(user);
				
				// Get cart items without modifying the cart
				List<CartItem> cartItems = cartService.getCartItemsByCart(cart);
				
				// Calculate total without relying on cart.getTotal() to avoid lazy loading issues
				double cartTotal = 0.0;
				for (CartItem item : cartItems) {
					cartTotal += (item.getProduct().getPrice() * item.getQuantity());
				}
				
				model.addAttribute("cart", cart);
				model.addAttribute("cartItems", cartItems);
				model.addAttribute("cartTotal", cartTotal);
			} else {
				model.addAttribute("errorMessage", "You must be logged in to view your cart.");
				return "redirect:/login";
			}
		} catch (Exception e) {
			// Log the error
			System.err.println("Error in viewCart: " + e.getMessage());
			e.printStackTrace();
			model.addAttribute("errorMessage", "An error occurred while loading your cart. Please try again later.");
		}
		
		return "cart";
	}
	
	@GetMapping("/cart/add")
	public String addToCart(@RequestParam("id") int productId, 
							@RequestParam(value = "quantity", defaultValue = "1") int quantity, 
							RedirectAttributes redirectAttributes) {
		try {
			// Validate quantity
			if (quantity <= 0) {
				redirectAttributes.addFlashAttribute("errorMessage", "Quantity must be at least 1.");
				return "redirect:/cart";
			}
			
			// Get logged in user
			String username = SecurityContextHolder.getContext().getAuthentication().getName();
			User user = userService.getUserByUsername(username);
			
			if (user == null) {
				redirectAttributes.addFlashAttribute("errorMessage", "You must be logged in to add products to cart.");
				return "redirect:/login";
			}
			
			// Get product
			Product product = productService.getProduct(productId);
			
			if (product == null) {
				redirectAttributes.addFlashAttribute("errorMessage", "Product not found.");
				return "redirect:/";
			}
			
			// Check if product is in stock
			if (product.getQuantity() < quantity) {
				redirectAttributes.addFlashAttribute("errorMessage", 
						"Sorry, only " + product.getQuantity() + " items of this product are available.");
				return "redirect:/";
			}
			
			// Get or create cart
			Cart cart = cartService.getActiveCartForUser(user);
			
			// Add product to cart
			CartItem cartItem = cartService.addProductToCart(cart, product, quantity);
			
			if (cartItem != null) {
				redirectAttributes.addFlashAttribute("successMessage", 
						product.getName() + " has been added to your cart.");
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", 
						"Failed to add product to cart. Please try again.");
			}
			
			return "redirect:/cart";
		} catch (Exception e) {
			// Log the error
			System.err.println("Error in addToCart: " + e.getMessage());
			e.printStackTrace();
			
			redirectAttributes.addFlashAttribute("errorMessage", 
					"An error occurred while adding the product to your cart. Please try again later.");
			return "redirect:/";
		}
	}
	
	@GetMapping("/cart/remove")
	public String removeFromCart(@RequestParam("id") int productId, RedirectAttributes redirectAttributes) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);
		
		if (user != null) {
			Cart cart = cartService.getActiveCartForUser(user);
			boolean removed = cartService.removeProductFromCart(cart, productId);
			
			if (removed) {
				redirectAttributes.addFlashAttribute("successMessage", "Product has been removed from your cart.");
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "Product not found in your cart.");
			}
		}
		
		return "redirect:/cart";
	}
	
	@PostMapping("/cart/update")
	public String updateCartItem(@RequestParam("itemId") int itemId, @RequestParam("quantity") int quantity, RedirectAttributes redirectAttributes) {
		if (quantity <= 0) {
			redirectAttributes.addFlashAttribute("errorMessage", "Quantity must be at least 1.");
			return "redirect:/cart";
		}
		
		CartItem cartItem = cartService.getCartItem(itemId);
		
		if (cartItem != null) {
			cartService.updateCartItemQuantity(cartItem, quantity);
			redirectAttributes.addFlashAttribute("successMessage", "Cart updated successfully.");
		} else {
			redirectAttributes.addFlashAttribute("errorMessage", "Cart item not found.");
		}
		
		return "redirect:/cart";
	}
	
	@GetMapping("/checkout")
	public String checkout(Model model) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);
		
		if (user != null) {
			Cart cart = cartService.getActiveCartForUser(user);
			List<CartItem> cartItems = cartService.getCartItemsByCart(cart);
			
			if (cartItems.isEmpty()) {
				model.addAttribute("errorMessage", "Your cart is empty.");
				return "redirect:/cart";
			}
			
			// Calculate total directly from items
			double cartTotal = 0.0;
			for (CartItem item : cartItems) {
				cartTotal += (item.getProduct().getPrice() * item.getQuantity());
			}
			
			model.addAttribute("cart", cart);
			model.addAttribute("cartItems", cartItems);
			model.addAttribute("cartTotal", cartTotal);
			model.addAttribute("user", user);
		}
		
		return "checkout";
	}
	
	@PostMapping("/placeOrder")
	public String placeOrder(
			@RequestParam("shippingAddress") String shippingAddress,
			@RequestParam("paymentMethod") String paymentMethod,
			RedirectAttributes redirectAttributes) {
		
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);
		
		if (user != null) {
			Cart cart = cartService.getActiveCartForUser(user);
			
			if (cart.getCartItems().isEmpty()) {
				redirectAttributes.addFlashAttribute("errorMessage", "Your cart is empty.");
				return "redirect:/cart";
			}
			
			Order order = orderService.createOrder(user, cart, shippingAddress, paymentMethod);
			redirectAttributes.addFlashAttribute("successMessage", "Your order has been placed successfully! Order #" + order.getId());
			return "redirect:/orders";
		}
		
		redirectAttributes.addFlashAttribute("errorMessage", "You must be logged in to place an order.");
		return "redirect:/login";
	}
	
	@GetMapping("/orders")
	public String viewOrders(Model model) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);
		
		if (user != null) {
			List<Order> orders = orderService.getOrdersByUser(user);
			model.addAttribute("orders", orders);
		}
		
		return "orders";
	}
	
	@GetMapping("/orders/{id}")
	public String viewOrderDetails(@PathVariable("id") int orderId, Model model, RedirectAttributes redirectAttributes) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);
		
		if (user != null) {
			Order order = orderService.getOrder(orderId);
			
			if (order != null && order.getCustomer().getId() == user.getId()) {
				model.addAttribute("order", order);
				return "orderDetails";
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "Order not found or not authorized to view.");
			}
		}
		
		return "redirect:/orders";
	}

	// Learning purpose methods - kept for reference
	@GetMapping("/test")
	public String Test(Model model) {
		System.out.println("test page");
		model.addAttribute("author","jay gajera");
		model.addAttribute("id",40);
		
		List<String> friends = new ArrayList<String>();
		model.addAttribute("f",friends);
		friends.add("xyz");
		friends.add("abc");
		
		return "test";
	}
	
	@GetMapping("/test2")
	public ModelAndView Test2() {
		System.out.println("test page");
		//create modelandview object
		ModelAndView mv = new ModelAndView();
		mv.addObject("name","jay gajera 17");
		mv.addObject("id",40);
		mv.setViewName("test2");
		
		List<Integer> list = new ArrayList<Integer>();
		list.add(10);
		list.add(25);
		mv.addObject("marks",list);
		return mv;
	}
}