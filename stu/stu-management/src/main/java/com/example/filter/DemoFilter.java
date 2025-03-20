package com.example.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;

/**
 * 学习用的，该类没有实际意义
 */

//@WebFilter(urlPatterns = "/login")
public class DemoFilter implements Filter {
    @Override //初始化方法 只调用1次
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("init 初始化方法执行了");
    }

    @Override //拦截到请求之后调用 调用多次
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("Demo拦截到了请求...放行前的逻辑");
        //放行
        filterChain.doFilter(servletRequest,servletResponse);

        System.out.println("Demo拦截到了请求...放行后的逻辑");

    }

    @Override //销毁方法 只调用一次
    public void destroy() {
        System.out.println("destroy 销毁方法执行了");
    }
}
