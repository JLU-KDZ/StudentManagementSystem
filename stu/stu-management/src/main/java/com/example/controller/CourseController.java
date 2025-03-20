package com.example.controller;

import com.example.pojo.Course;
import com.example.pojo.PageBean3;
import com.example.pojo.Result;
import com.example.pojo.Teacher;
import com.example.service.CourseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequestMapping("course")
@RestController
public class CourseController {
    @Autowired
    private CourseService courseService;

    @GetMapping("/list")
    public Result list(){
        log.info("查询全部老师数据");
        List<Course> courseList = courseService.listTable();
        return Result.success(courseList);
    }

    @GetMapping
    public Result list(@RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "5") Integer pageSize,
                       String name){
        log.info("分页查询课程，参数：{}，{}，{}，{}，{}，{}", page, pageSize, name);
        PageBean3 pageBean3 = courseService.list(page, pageSize, name);
        return Result.success(pageBean3);
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        log.info("根据id删除课程：{}", id);
        courseService.delete(id);
        return Result.success();
    }

    @PostMapping
    public Result add(@RequestBody Course course) {
        log.info("新增班级：{}", course);
        courseService.add(course);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id) {
        log.info("根据id查询班级：{}", id);
        Course course = courseService.getById(id);
        return Result.success(course);
    }


    @PutMapping
    public Result update(@RequestBody Course course) {
        log.info("根据id修改班级:{}", course);
        courseService.update(course);
        return Result.success();
    }

}
