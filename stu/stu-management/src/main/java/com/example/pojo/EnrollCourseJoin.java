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
public class EnrollCourseJoin {
    private Integer id;
    private String stuName;
    private Integer courseId;
    private String courseName;
    private Integer majorId;
    private Integer credit;
    private String time;
    private String location;
}
