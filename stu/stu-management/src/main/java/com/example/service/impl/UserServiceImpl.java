package com.example.service.impl;

import com.example.mapper.StuMapper;
import com.example.mapper.TeacherMapper;
import com.example.mapper.UserMapper;
import com.example.pojo.Pwd;
import com.example.pojo.Stu;
import com.example.pojo.Teacher;
import com.example.pojo.User;
import com.example.service.TeacherService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private StuMapper stuMapper;

    @Autowired
    private TeacherMapper teacherMapper;

    //    @Autowired
    //    private PasswordEncoder passwordEncoder;


    @Override
    public User login(User user) {
        User u = userMapper.getByUsernameAndPassword(user);
        u.setRoleId(userMapper.getRID(u.getUid2()));
        return u;
    }

    @Override
    public void register(User user) {
        if (userMapper.selectUserByUsername(user.getUsername()) != null) {
            throw new RuntimeException("Username is already taken");
        }

        if (user.getUsername().startsWith("1")) {
            user.setRoleId(1);
            userMapper.insertStu(user);
        } else if (user.getUsername().startsWith("2")) {
            user.setRoleId(2);
        } else {
            user.setRoleId(3);
        }
        // Encrypt the password before saving
//        String encodedPassword = passwordEncoder.encode(stu.getPassword());
//        stu.setPassword(encodedPassword);

        userMapper.insertUser(user);
        user.setUid2(userMapper.getUID2(user.getUsername()));
        System.out.println(user.getUid2());
//        System.out.println(user.getRoleId());
        userMapper.insertUserRole(user.getUid2(), user.getRoleId());
    }


    private String oldUsername;
    private Integer uid;


    @Override
    public Stu getStu(String username) {
        this.oldUsername = username;
        this.uid = userMapper.getUID2(username);

        return userMapper.getStu(username);
    }

    @Override
    public void updateStu(Stu stu) {
        stuMapper.update(stu);
        if (!stu.getUsername().equals(this.oldUsername)) {
            userMapper.updateUsername(stu.getUsername(), this.uid);
        }
    }

    @Override
    public void updatePwd(Pwd pwd) {
        if (pwd.getUsername().startsWith("1")) {
            userMapper.updateStuPwd(pwd);
        }
        userMapper.updatePwd(pwd);
    }

    @Override
    public String getPwd(String username) {
        if (username.startsWith("1")) {
            return userMapper.getPwd(username);
        } else if (username.startsWith("3")) {
            return userMapper.getTeacherPwd(username);
        }else{
            return "没找到pwd";
        }
    }

    @Override
    public void deleteUser(String username) {
        if (username.startsWith("1")) {
            userMapper.deleteStuByUsername(username);
        }
        userMapper.deleteUserByUsername(username);
    }

    @Override
    public void updateAdmin(User user) {
        userMapper.updateAdmin(user);
    }

    @Override
    public Integer getUID2(String username) {
        return userMapper.getUID2(username);
    }

    @Override
    public String getPwd2(Integer uid2) {
        return userMapper.getPwd2(uid2);
    }


    private String oldTeacherUsername;
    private Integer tuid;
    @Override
    public Teacher getTeacher(String username) {
        this.oldTeacherUsername = username;
        this.tuid = userMapper.getUID2(username);

        return userMapper.getTeacher(username);
    }
    @Override
    public void updateTeacher(Teacher t) {
        teacherMapper.update(t);
        if (!t.getUsername().equals(this.oldTeacherUsername)) {
            userMapper.updateUsername(t.getUsername(), this.tuid);
        }
    }

}
