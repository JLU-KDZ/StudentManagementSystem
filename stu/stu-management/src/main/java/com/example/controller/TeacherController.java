package com.example.controller;

import com.example.pojo.*;
import com.example.service.TeacherService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Slf4j
@RequestMapping("teacher")
@RestController
public class TeacherController {

    @Autowired
    private TeacherService teacherService;

    @GetMapping("/list")
    public Result list(){
        log.info("查询全部老师数据");
        List<Teacher> teacherlist = teacherService.listTable();
        return Result.success(teacherlist);
    }

    @GetMapping("/listCourse")
    public Result listCourse(String username){
        log.info("查询该老师教授课程");
        List<Course> courseList = teacherService.listCourse(username);
        return Result.success(courseList);
    }

    @GetMapping("/listEnrollment")
    public Result listEnrolment(String username,Integer courseId){
        log.info("查询该老师教授课程的选课情况");
        List<EnrollCourseJoin> list = teacherService.listEnrollment(username,courseId);
        return Result.success(list);
    }


    @GetMapping
    public Result page(@RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "10") Integer pageSize,
                       String name, Integer dept2Id) {
        log.info("分页查询老师，参数：{}，{}，{}，{}，{}，{}", page, pageSize, name, dept2Id);
        PageBean2 pageBean2 = teacherService.list(page, pageSize, name,dept2Id);
        return Result.success(pageBean2);

    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        log.info("根据id删除老师：{}", id);
        teacherService.delete(id);
        return Result.success();
    }


    @PostMapping
    public Result add(@RequestBody Teacher teacher) {
        log.info("新增老师：{}", teacher);
        teacherService.add(teacher);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id) {
        log.info("根据id查询老师：{}", id);
        Teacher teacher = teacherService.getById(id);
        return Result.success(teacher);
    }


    @PutMapping
    public Result update(@RequestBody Teacher teacher) {
        log.info("根据id修改老师:{}", teacher);
        teacherService.update(teacher);
        return Result.success();
    }
}
