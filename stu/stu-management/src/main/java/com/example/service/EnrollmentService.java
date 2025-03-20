package com.example.service;

import com.example.pojo.EnrollCourseJoin;
import com.example.pojo.EnrollCourseJoinStatus;
import com.example.pojo.Enrollment;

import java.util.List;

public interface EnrollmentService {
    List<EnrollCourseJoinStatus> listJoin(String stuName, String courseName);

    void insert(Enrollment enrollment);

    void delete(Enrollment enrollment);

    void insertByAdmin(String stuName, String courseName);

    void deleteByAdmin(String stuName, String courseName);

    Integer flag(String stuName ,Integer courseId);
}
