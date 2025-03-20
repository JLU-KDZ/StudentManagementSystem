package com.example.controller;

import com.example.pojo.Lookup;
import com.example.pojo.Result;
import com.example.service.SmmLookupService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequestMapping("/lookup")
//@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class SmmLookupController {

    @Autowired
    private SmmLookupService lookupService;

    @GetMapping
    public Result list(){
        log.info("查询lookup数据");
        List<Lookup> lu = lookupService.list();
        return Result.success(lu);
    }
}
