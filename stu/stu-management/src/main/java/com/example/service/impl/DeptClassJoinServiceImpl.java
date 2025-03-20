package com.example.service.impl;

import com.example.mapper.DeptClassJoinMapper;
import com.example.pojo.DeptClassJoin;
import com.example.service.DeptClassJoinService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptClassJoinServiceImpl implements DeptClassJoinService {
    @Autowired
    private DeptClassJoinMapper joinMapper;

    @Override
    public List<DeptClassJoin> list() {
        return joinMapper.list();
    }
}
