package com.example.service;

import com.example.pojo.Major;

import java.util.List;

public interface MajorService {
    List<Major> list(String name,Integer dept2Id);

    void delete(Integer id);

    void add(Major major);

    Major getById(Integer id);

    void update(Major major);

    List<Major> getByDept(Integer dept2Id);
}
