package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@EntityScan
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private Integer uid2;
    private String username;
    private String password;
    private Integer roleId;
}
