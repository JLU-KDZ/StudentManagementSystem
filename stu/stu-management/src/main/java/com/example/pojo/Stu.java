package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.lang.Nullable;

import java.time.LocalDate;
import java.time.LocalDateTime;

@EntityScan
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Stu {
    private Integer id;
    private String username;
    private String password;
    @Nullable
    private String stuId;
    @Nullable
    private String name;
    @Nullable
    private Integer gender;
    @Nullable
    private String phonenumber;
    @Nullable
    private String image;
    @Nullable
    private Integer grade;
    @Nullable
    private LocalDate entrydate;
    @Nullable
    private Integer dept2Id;
    @Nullable
    private Integer classId;
    private String createBy;
    private LocalDateTime createTime;
    private String updateBy;
    private LocalDateTime updateTime;

}
