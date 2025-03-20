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
public class Enrollment {
    private Integer id;
    private String stuName;
    private Integer courseId;
    private String createBy;
    private LocalDateTime createTime;
    private String updateBy;
    private LocalDateTime updateTime;
}
