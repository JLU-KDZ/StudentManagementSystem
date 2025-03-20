package com.example.controller;

import com.example.pojo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequestMapping("/dashboard")
@RestController
public class DashBoardPictureController {

    @GetMapping
    public Result picture(){
        log.info("上传首页图片中...");
        String src = "https://www.logosc.cn/uploads/output/2019/12/14/1a9af4a9a2500815717923f9d838f9ff.jpg?t=1576510024";
        log.info("上传首页图片完成");
        return Result.success(src);
    }
}
