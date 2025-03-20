package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeptClassJoin {
    private Integer dept2Id;
    private String dept2Name;
    private Integer classId;
    private String className;
}
