package com.example.service.impl;

import com.example.mapper.ClassMapper;
import com.example.mapper.DeptMapper;
import com.example.pojo.Dept;
import com.example.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.beans.Transient;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class DeptServiceImpl implements DeptService {
    @Autowired
    private DeptMapper deptMapper;

    @Autowired
    private ClassMapper classMapper;

    @Override
    public List<Dept> list() {
        return deptMapper.list();
    }

    @Transactional(rollbackFor = Exception.class)//事务管理  开启，提交/回滚事务   rollbackFor:出现什么样的异常要进行回滚
    @Override
    public void delete(Integer id) {
        deptMapper.deleteById(id);//删学院

        classMapper.deleteByDeptId(id);//根据学院ID删除班级
    }

    @Override
    public void add(Dept dept) {
        deptMapper.insert(dept);
    }

    @Override
    public Dept getById(Integer id) {
        return deptMapper.getById(id);
    }

    @Override
    public void update(Dept dept) {
        deptMapper.update(dept);
    }

}
