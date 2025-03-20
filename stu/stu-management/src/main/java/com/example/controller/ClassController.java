package com.example.controller;


import com.example.pojo.Class;
import com.example.pojo.Result;
import com.example.service.ClassService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequestMapping("/classes")
//@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class ClassController {

    @Autowired
    private ClassService classService;

    @GetMapping
    public Result list() {
        log.info("查询全部班级数据");
        List<Class> classlist = classService.list();
        return Result.success(classlist);
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        log.info("根据id删除班级：{}", id);
        classService.delete(id);
        return Result.success();
    }

    @PostMapping
    public Result add(@RequestBody Class clas) {
        log.info("新增班级：{}", clas);
        classService.add(clas);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id) {
        log.info("根据id查询班级：{}", id);
        Class clas = classService.getById(id);
        return Result.success(clas);
    }


    @PutMapping
    public Result update(@RequestBody Class clas) {
        log.info("根据id修改班级:{}", clas);
        classService.update(clas);
        return Result.success();
    }
}
