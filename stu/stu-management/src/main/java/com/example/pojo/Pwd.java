package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@EntityScan
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pwd {
    private String password;
    private String username;
}
