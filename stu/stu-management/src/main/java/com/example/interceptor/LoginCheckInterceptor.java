package com.example.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.example.pojo.Result;
import com.example.utils.JwtUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@Component
public class LoginCheckInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

        //1.获取请求url
        String url = req.getRequestURL().toString();
        log.info("请求的url：{}",url);

        //2.判断请求url中是否包含login，如果包含，说明是登陆操作，放行
        if(url.contains("login")){
            log.info("登陆操作，放行...");
            return true;
        }

        //3.获取请求中的令牌（token）
        String jwt = req.getHeader("token");

        //4.判断令牌是否存在，如果不存在，返回错误结果（未登录）
        if(!StringUtils.hasLength(jwt)){
            log.info("请求头token为空，返回未登录的信息");
            Result error = Result.error("NOT_LOGIN");
            //手动转换 对象--json------------>阿里巴巴fastJSON工具包
            String notLogin = JSONObject.toJSONString(error);
            resp.getWriter().write(notLogin);
            return false;

        }

        //5.解析token，如果解析失败返回错误结果（未登录）
        try {
            JwtUtils.parseJWT(jwt);
        } catch (Exception e) { //jwt解析失败
            e.printStackTrace();
            log.info("解析令牌失败，返回未登陆的错误信息");
            Result error = Result.error("NOT_LOGIN");
            //手动转换 对象--json------------>阿里巴巴fastJSON工具包
            String notLogin = JSONObject.toJSONString(error);
            resp.getWriter().write(notLogin);
            return false;
        }

        //6.放行
        log.info("令牌合法，放行");
        return  true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle ...");
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("afterCompletion");
    }
}
