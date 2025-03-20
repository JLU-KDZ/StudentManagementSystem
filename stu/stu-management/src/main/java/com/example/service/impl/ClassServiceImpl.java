package com.example.service.impl;

import com.example.mapper.ClassMapper;
import com.example.pojo.Class;
import com.example.pojo.Dept;
import com.example.service.ClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClassServiceImpl implements ClassService {
    @Autowired
    private ClassMapper classMapper;

    @Override
    public List<Class> list() {
        return classMapper.list();
    }

    @Override
    public void delete(Integer id) {
        classMapper.deleteById(id);
    }

    @Override
    public void add(Class clas) {
        classMapper.insert(clas);
    }

    @Override
    public Class getById(Integer id) {
        return classMapper.getById(id);
    }

    @Override
    public void update(Class clas) {
        classMapper.update(clas);
    }
}
