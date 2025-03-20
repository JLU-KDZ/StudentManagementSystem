package com.example.service;

import com.example.pojo.Course;
import com.example.pojo.PageBean3;

import java.util.List;


public interface CourseService {

    PageBean3 list(Integer page, Integer pageSize, String name);

    void delete(Integer id);

    void add(Course course);

    Course getById(Integer id);

    void update(Course course);

    List<Course> listTable();
}
