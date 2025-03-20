package com.example.controller;

import com.example.pojo.Major;
import com.example.pojo.Result;
import com.example.service.MajorService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 专业管理controller
 */
@Slf4j
@RequestMapping("/major")
@RestController
public class MajorController {


    @Autowired
    private MajorService majorService;

    @GetMapping
    public Result list(String name,Integer dept2Id) {
        log.info("查询全部专业数据");
        List<Major> majorlist = majorService.list(name,dept2Id);
        return Result.success(majorlist);
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        log.info("根据id删除专业：{}", id);
        majorService.delete(id);
        return Result.success();
    }

    @PostMapping
    public Result add(@RequestBody Major major) {
        log.info("新增专业：{}", major);
        majorService.add(major);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id) {
        log.info("根据id查询专业：{}", id);
        Major major = majorService.getById(id);
        return Result.success(major);
    }

    @GetMapping("/deptMajor")
    public Result getByDept(Integer dept2Id) {
        List<Major> majors = majorService.getByDept(dept2Id);
        return Result.success(majors);
    }

    @PutMapping
    public Result update(@RequestBody Major major) {
        log.info("根据id修改专业:{}", major);
        majorService.update(major);
        return Result.success();
    }
}
