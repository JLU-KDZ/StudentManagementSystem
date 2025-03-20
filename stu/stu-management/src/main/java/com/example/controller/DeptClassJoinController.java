package com.example.controller;

import com.example.pojo.DeptClassJoin;
import com.example.pojo.Result;
import com.example.service.DeptClassJoinService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequestMapping("/join")
//@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class DeptClassJoinController {
    @Autowired
    private DeptClassJoinService joinService;

    @GetMapping
    public Result list(){
        log.info("查询学院下面对应的班级");
        List<DeptClassJoin> joinList = joinService.list();
        return Result.success(joinList);
    }
}
