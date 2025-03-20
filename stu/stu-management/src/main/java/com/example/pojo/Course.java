package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.autoconfigure.domain.EntityScan;

import java.time.LocalDateTime;


@EntityScan
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Course {
    private Integer id;
    private String name;
    private Integer teacherId;
    private String description;
    private Integer stuNumber;
    private Integer maxNumber;
    private Integer majorId;
    private Integer credit;
    private String time;
    private String location;
    private Integer enrolledNumber;
    private String status;
    private String createBy;
    private LocalDateTime createTime;
    private String updateBy;
    private LocalDateTime updateTime;
}
