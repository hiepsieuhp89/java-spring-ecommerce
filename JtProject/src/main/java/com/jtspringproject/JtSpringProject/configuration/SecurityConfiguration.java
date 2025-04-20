package com.jtspringproject.JtSpringProject.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.services.userService;

@Configuration
public class SecurityConfiguration {
	
	userService UserService;

	public SecurityConfiguration(userService UserService) {
		this.UserService = UserService;
	}

	@Configuration
	@Order(1)
	public static class AdminConfigurationAdapter{
		
		@Bean
		SecurityFilterChain adminFilterChain(HttpSecurity http) throws Exception {
            http.antMatcher("/admin/**") 
                .authorizeRequests()
                .antMatchers("/admin/login").permitAll()
                .antMatchers("/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/admin/login")
                .loginProcessingUrl("/admin/loginvalidate")
                .defaultSuccessUrl("/admin/", true)
                .failureUrl("/admin/login?error=true")
                .permitAll()
                .and()
                .logout()
                .logoutUrl("/admin/logout")
                .logoutSuccessUrl("/admin/login?logout=true")
                .deleteCookies("JSESSIONID")
                .permitAll()
                .and()
                .exceptionHandling()
                .accessDeniedPage("/403")
                .and()
                .csrf().disable();

            return http.build();
		}
	}
	
	@Configuration
	@Order(2)
	public static class UserConfigurationAdapter{
		
		@Bean
		SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
            http.authorizeRequests()
                .antMatchers("/login", "/register", "/newuserregister", "/test", "/test2", "/css/**", "/js/**", "/images/**").permitAll()
                .antMatchers("/**").hasRole("USER")
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/userloginvalidate")
                .defaultSuccessUrl("/", true)
                .failureUrl("/login?error=true")
                .permitAll()
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .deleteCookies("JSESSIONID")
                .permitAll()
                .and()
                .exceptionHandling()
                .accessDeniedPage("/403")
                .and()
                .csrf().disable();

            return http.build();
		}
	}
	
	@Bean
	UserDetailsService userDetailsService() {
		return username -> {
			System.out.println("Authenticating user: " + username);
			User user = UserService.getUserByUsername(username);
			if(user == null) {
				System.out.println("User not found: " + username);
	            throw new UsernameNotFoundException("User with username " + username + " not found.");
			}
			String role = user.getRole().equals("ROLE_ADMIN") ? "ADMIN":"USER"; 
			System.out.println("Found user: " + username + " with role: " + role);
			
			return org.springframework.security.core.userdetails.User
					.withUsername(username)
					.password(user.getPassword())
					.roles(role)
					.build();
		};
	}

	@Bean
	PasswordEncoder passwordEncoder() {
		return org.springframework.security.crypto.password.NoOpPasswordEncoder.getInstance();
	}
}
