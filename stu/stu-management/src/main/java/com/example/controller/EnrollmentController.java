package com.example.controller;

import com.example.pojo.*;
import com.example.service.EnrollmentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequestMapping("enrollment")
@RestController
public class EnrollmentController {

    @Autowired
    private EnrollmentService enrollmentService;

    @GetMapping
    public Result listJoin(String stuName, String courseName){
        log.info("查询选课，参数：{},{}",stuName,courseName);
        List<EnrollCourseJoinStatus> list = enrollmentService.listJoin(stuName,courseName);
        return Result.success(list);
    }

    @PostMapping
    public Result insert(@RequestBody Enrollment enrollment){
        log.info("插入选课：{}",enrollment);
        enrollmentService.insert(enrollment);
        return Result.success();
    }

    @DeleteMapping
    public Result delete(@RequestBody Enrollment enrollment){
        log.info("删除选课：{}",enrollment);
        enrollmentService.delete(enrollment);
        return Result.success();
    }

    @PostMapping("/insertByAdmin")
    public Result insertByAdmin(@RequestBody EnrollmentAdmin enrollmentAdmin){
        log.info("插入选课，参数：{}",enrollmentAdmin);
        enrollmentService.insertByAdmin(enrollmentAdmin.getStuName(),enrollmentAdmin.getCourseName());
        return Result.success();
    }

    @PostMapping("/deleteByAdmin")
    public Result deleteByAdmin(@RequestBody EnrollmentAdmin enrollmentAdmin){
        log.info("删除选课，参数：{}",enrollmentAdmin);
        enrollmentService.deleteByAdmin(enrollmentAdmin.getStuName(),enrollmentAdmin.getCourseName());
        return Result.success();
    }




    @GetMapping("/flag")
    public Result flag( String stuName ,Integer courseId){
        Integer flag = enrollmentService.flag(stuName,courseId);
        return Result.success(flag);
    }

}
