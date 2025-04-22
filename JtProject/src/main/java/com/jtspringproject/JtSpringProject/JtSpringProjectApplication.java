package com.jtspringproject.JtSpringProject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.orm.hibernate5.support.OpenSessionInViewFilter;

@SpringBootApplication(exclude = HibernateJpaAutoConfiguration.class)
public class JtSpringProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(JtSpringProjectApplication.class, args);
	}

	/**
	 * Registers the OpenSessionInViewFilter to ensure
	 * Hibernate sessions stay open during view rendering,
	 * preventing LazyInitializationException issues
	 */
	@Bean
	public FilterRegistrationBean<OpenSessionInViewFilter> openSessionInView() {
		FilterRegistrationBean<OpenSessionInViewFilter> registrationBean = new FilterRegistrationBean<>();
		OpenSessionInViewFilter filter = new OpenSessionInViewFilter();
		filter.setSessionFactoryBeanName("sessionFactory");
		registrationBean.setFilter(filter);
		registrationBean.setOrder(5);
		return registrationBean;
	}

}
