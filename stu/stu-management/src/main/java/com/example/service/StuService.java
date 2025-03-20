package com.example.service;

import com.example.pojo.PageBean;
import com.example.pojo.Stu;

import java.time.LocalDate;
import java.util.List;

public interface StuService {
    PageBean page2(Integer page, Integer pageSize, String name, String stuId, LocalDate begin, LocalDate end);

    void deleteByIds(List<Integer> ids);

    void save(Stu stu);

    Stu getById(Integer id);

    void update(Stu stu);


    Integer getDeptByUsername(String username);

    String getNameByUsername(String username);
}
