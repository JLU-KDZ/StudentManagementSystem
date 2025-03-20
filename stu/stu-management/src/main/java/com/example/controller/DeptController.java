package com.example.controller;

import com.example.pojo.Dept;
import com.example.pojo.Result;
import com.example.service.DeptService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 学院管理controller
 */
@Slf4j
@RequestMapping("/depts")
//@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class DeptController {

    @Autowired
    private DeptService deptService;

    @GetMapping
    public Result list() {
        log.info("查询全部学院数据");
        List<Dept> deptlist = deptService.list();
        return Result.success(deptlist);
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        log.info("根据id删除学院：{}", id);
        deptService.delete(id);
        return Result.success();
    }

    @PostMapping
    public Result add(@RequestBody Dept dept) {
        log.info("新增学院：{}", dept);
        deptService.add(dept);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id) {
        log.info("根据id查询学院：{}", id);
        Dept dept = deptService.getById(id);
        return Result.success(dept);
    }


    @PutMapping
    public Result update(@RequestBody Dept dept) {
        log.info("根据id修改学院:{}", dept);
        deptService.update(dept);
        return Result.success();
    }
}