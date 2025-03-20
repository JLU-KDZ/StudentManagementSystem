package com.example.service;

import com.example.pojo.Class;
import com.example.pojo.Dept;

import java.util.List;

public interface ClassService {
    List<Class> list();

    void delete(Integer id);
    void add(Class clas);

    Class getById(Integer id);
    void update(Class clas);
}
