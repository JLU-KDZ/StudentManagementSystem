package com.example.service.impl;

import com.example.mapper.MajorMapper;
import com.example.pojo.Major;
import com.example.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MajorServiceImpl implements MajorService {

    @Autowired
    private MajorMapper majorMapper;


    @Override
    public List<Major> list(String name,Integer dept2Id) {
        return majorMapper.list(name,dept2Id);
    }

    @Override
    public void delete(Integer id) {
        majorMapper.deleteById(id);
    }

    @Override
    public void add(Major major) {
        majorMapper.insert(major);
    }

    @Override
    public Major getById(Integer id) {
        return majorMapper.getById(id);
    }

    @Override
    public void update(Major major) {
        majorMapper.update(major);
    }

    @Override
    public List<Major> getByDept(Integer dept2Id) {
        return majorMapper.getByDept(dept2Id);
    }
}
