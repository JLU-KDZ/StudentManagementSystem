package com.example.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

/**
 * 学习用的，该类没有实际意义
 */

import java.io.IOException;
//@WebFilter(urlPatterns = "/*")
public class AbcFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("Abc拦截到了请求...放行前的逻辑");
        //放行
        filterChain.doFilter(servletRequest,servletResponse);

        System.out.println("Abc拦截到了请求...放行后的逻辑");

    }
}
