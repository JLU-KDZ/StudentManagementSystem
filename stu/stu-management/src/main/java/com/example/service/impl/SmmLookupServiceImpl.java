package com.example.service.impl;

import com.example.mapper.SmmLookupMapper;
import com.example.pojo.Lookup;
import com.example.service.SmmLookupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SmmLookupServiceImpl implements SmmLookupService {


    @Autowired
    private SmmLookupMapper lookupMapper;

    @Override
    public List<Lookup> list() {
        return lookupMapper.list();
    }
}
