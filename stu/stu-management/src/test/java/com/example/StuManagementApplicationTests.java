package com.example;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@SpringBootTest
class StuManagementApplicationTests {

    @Test
    void contextLoads() {

    }

    /**
     * 生成JWT令牌
     */
    @Test
    public void testGenJwt(){
        Map<String, Object> claims = new HashMap<>();
        claims.put("id",1);
        claims.put("name","tom");
        String jwt = Jwts.builder()
                .signWith(SignatureAlgorithm.HS256, "stuManage")//签名算法
                .setClaims(claims) //自定义内容
                .setExpiration(new Date(System.currentTimeMillis() + 3600 * 1000)) //设置有效期为1小时
                .compact();
        System.out.println(jwt);
    }

    /**
     * 解析JWT令牌
     */
    @Test
    public void testParseJwt(){
        Claims claims = Jwts.parser()
                .setSigningKey("stuManage")
                .parseClaimsJws("eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoidG9tIiwiaWQiOjEsImV4cCI6MTcyMTM4MTk0NX0.lQAH5zvi0KweHztJkDSgocTOTAaKQlRx4ZYgH6Wixj4")
                .getBody();
        System.out.println(claims);
    }

}
