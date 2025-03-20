package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.autoconfigure.domain.EntityScan;

import java.time.LocalDateTime;

@EntityScan
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EnrollmentAdmin {
    private String stuName;
    private String courseName;

}
