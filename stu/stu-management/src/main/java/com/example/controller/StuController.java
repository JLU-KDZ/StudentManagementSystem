package com.example.controller;

import com.example.pojo.PageBean;
import com.example.pojo.Result;
import com.example.pojo.Stu;
import com.example.service.StuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@RequestMapping("/stus")
//@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class StuController {

    @Autowired
    private StuService stuService;


//    @CrossOrigin(origins = "*", allowedHeaders = "*")
    @GetMapping
    public Result page(@RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "5") Integer pageSize,
                       String name, String stuId,
                       @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
                       @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end){
        log.info("分页查询学生，参数：{}，{}，{}，{}，{}，{}",page,pageSize,name,stuId,begin,end);
        PageBean pageBean = stuService.page2(page,pageSize,name,stuId,begin,end);
        return Result.success(pageBean);

    }

    @DeleteMapping("/{ids}")
    public Result deleteByIds(@PathVariable List<Integer> ids){
        log.info("批量删除学生 ids=：{}",ids);
        stuService.deleteByIds(ids);
        return Result.success();
    }

    @PostMapping
    public Result save(@RequestBody Stu stu){
        log.info("新增学生：{}",stu);
        stuService.save(stu);
        return Result.success();
    }


    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id){
        log.info("根据id查询学生信息，id：{}",id);
        Stu stu =stuService.getById(id);
        return Result.success(stu);
    }

    @GetMapping("/getDept")
    public Result getDeptByUsername(String username){
        Integer dept2Id =stuService.getDeptByUsername(username);
        return Result.success(dept2Id);
    }

    @GetMapping("getStuName")
    public Result getNameByUsername(String username){
        String name =stuService.getNameByUsername(username);
        return Result.success(name);
    }


    @PutMapping
    public Result update(@RequestBody Stu stu){
        log.info("管理员权限，修改学生：{}",stu);
        stuService.update(stu);
        return Result.success();
    }

}
