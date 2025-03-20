package com.example.service.impl;

import com.example.mapper.StuMapper;
import com.example.mapper.UserMapper;
import com.example.pojo.PageBean;
import com.example.pojo.Stu;
import com.example.pojo.User;
import com.example.service.StuService;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class StuServiceImpl implements StuService {
    @Autowired
    private StuMapper stuMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public PageBean page2(Integer page, Integer pageSize, String name, String stuId, LocalDate begin, LocalDate end) {
        Long count = stuMapper.count();
        Integer startRow = ((page-1)*pageSize)+1;
        Integer endRow = startRow+pageSize-1;
        List<Stu> stuList = stuMapper.page2(startRow,endRow,name,stuId, begin, end);
        PageBean pageBean = new PageBean(count,stuList);
        return pageBean;
//        // 开始分页
//        PageHelper.startPage(page, pageSize);
//
//        // 执行查询
//        List<Stu> stuList = stuMapper.list(name, gender, begin, end);
//
//        // 获取分页信息
//        Page<Stu> p = (Page<Stu>) stuList;
//
//        // 封装到PageBean
//        PageBean pageBean = new PageBean(p.getTotal(),p.getResult());
//
//        return pageBean;
    }

    @Override
    public void deleteByIds(List<Integer> ids) {
        List<String> usernames = stuMapper.getUsernameByIds(ids);
        List<Integer> uid2s = userMapper.getByUsernames(usernames);
        userMapper.deleteURbyUID2s(uid2s);
        userMapper.deleteByUsernames(usernames);
        stuMapper.deleteByIds(ids);
    }

    @Override
    public void save(Stu stu) {
        if (stu.getEntrydate() == null) {
            // 可以在这里设置默认值，例如当前日期
            stu.setEntrydate(LocalDate.now());
        }
        if (stu.getDept2Id() == null) {
            // 可以在这里设置默认值，例如当前日期
            stu.setDept2Id(0);
        }
        if (stu.getClassId() == null) {
            // 可以在这里设置默认值，例如当前日期
            stu.setClassId(0);
        }

        stuMapper.insert(stu);
        userMapper.AdminInsertUser(stu.getUsername());
        Integer uid2 = userMapper.getUID2(stu.getUsername());
        userMapper.insertUserRole(uid2,1);
    }

    private String oldUsername;
    private Integer uid;
    @Override
    public Stu getById(Integer id) {
        Stu s = stuMapper.getByID(id);
        this.oldUsername = s.getUsername();
        this.uid = userMapper.getUID2(s.getUsername());
        return s;
    }


    @Override
    public void update(Stu stu) {
        stuMapper.update(stu);
        if(!stu.getUsername().equals(this.oldUsername)){
            userMapper.updateUsername(stu.getUsername(),this.uid);
        }


    }

    @Override
    public Integer getDeptByUsername(String username) {
        return stuMapper.getDeptByUsername(username);
    }

    @Override
    public String getNameByUsername(String username) {
        return stuMapper.getNameByUsername(username);
    }


}
