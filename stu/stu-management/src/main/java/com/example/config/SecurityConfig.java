//package com.example.config;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.config.http.SessionCreationPolicy;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.security.web.SecurityFilterChain;
//import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
//
////@Configuration
////@EnableWebSecurity
//public class SecurityConfig {
//
//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http
//                .csrf().disable() // 禁用CSRF保护，可根据需要启用
//                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS) // 无状态会话，适用于API
//                .and()
//                .authorizeHttpRequests((authorize) -> authorize
//                        .requestMatchers("/api/register").permitAll() // 允许未认证用户访问注册API
//                        .anyRequest().authenticated() // 所有其他请求都需要认证
//                )
//                .httpBasic(); // 启用HTTP Basic认证
//
//        return http.build();
//    }
//
//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder(); // 使用BCrypt密码编码器
//    }
//}