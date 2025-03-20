package com.example.controller;

import com.example.pojo.Result;
import com.example.pojo.User;
import com.example.service.UserService;
import com.example.utils.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@Slf4j
//@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping("/api")
@RestController
public class LoginController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Result login(@RequestBody User user){
        log.info("学生登录：{}",user);
        User s = userService.login(user);

        //登录成功，生成令牌，下发令牌
        if(s != null){
            Map<String, Object> claims = new HashMap<>();
            claims.put("id",s.getUid2());
            claims.put("name",s.getUsername());
            claims.put("username",s.getUsername());
            String jwt = JwtUtils.generateJwt(claims); //jwt包含了当前登录的用户信息
            return Result.success(s.getRoleId().toString(),s.getUsername(),jwt);
        }

        //登录失败，返回错误信息
       return Result.error("用户名或密码错误");
    }

}
