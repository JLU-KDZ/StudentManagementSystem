package com.example.service.impl;

import com.example.mapper.CourseMapper;
import com.example.mapper.EnrollmentMapper;
import com.example.pojo.Course;
import com.example.pojo.PageBean3;
import com.example.service.CourseService;
import com.example.service.EnrollmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private EnrollmentMapper enrollmentMapper;
    @Override
    public PageBean3 list(Integer page, Integer pageSize, String name) {
        Long count = courseMapper.count();
        Integer startRow = ((page-1)*pageSize)+1;
        Integer endRow = startRow+pageSize-1;
        List<Course> courseList = courseMapper.page(startRow,endRow,name);
        PageBean3 pageBean3 = new PageBean3(count,courseList);
        return pageBean3;
    }

    @Override
    public void delete(Integer id) {
        enrollmentMapper.deleteByCourseId(id);
        courseMapper.deleteById(id);
    }

    @Override
    public void add(Course course) {
        courseMapper.insert(course);
    }

    @Override
    public Course getById(Integer id) {
        return courseMapper.getById(id);
    }

    @Override
    public void update(Course course) {
        courseMapper.update(course);
    }

    @Override
    public List<Course> listTable() {
        return courseMapper.list();
    }
}
