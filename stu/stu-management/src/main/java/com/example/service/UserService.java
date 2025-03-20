package com.example.service;


import com.example.pojo.Pwd;
import com.example.pojo.Stu;
import com.example.pojo.Teacher;
import com.example.pojo.User;

public interface UserService {

    User login(User user);
    void register(User user);

    Stu getStu(String username);

    void updateStu(Stu stu);

    void updatePwd(Pwd pwd);

    String getPwd(String username);

    void deleteUser(String username);

    void updateAdmin(User user);

    Integer getUID2(String username);

    String getPwd2(Integer uid2);


    void updateTeacher(Teacher t);

    Teacher getTeacher(String username);
}
