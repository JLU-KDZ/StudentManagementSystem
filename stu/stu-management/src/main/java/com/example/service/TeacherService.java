package com.example.service;

import com.example.pojo.Course;
import com.example.pojo.EnrollCourseJoin;
import com.example.pojo.PageBean2;
import com.example.pojo.Teacher;

import java.util.List;

public interface TeacherService {
    PageBean2 list(Integer page, Integer pageSize, String name, Integer dept2Id);

    void delete(Integer id);

    void add(Teacher teacher);

    Teacher getById(Integer id);

    void update(Teacher teacher);

    List<Teacher> listTable();

    List<Course> listCourse(String username);

    List<EnrollCourseJoin> listEnrollment(String username,Integer courseId);

}
