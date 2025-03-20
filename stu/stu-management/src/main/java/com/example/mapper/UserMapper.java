package com.example.mapper;


import com.example.pojo.Pwd;
import com.example.pojo.Stu;
import com.example.pojo.Teacher;
import com.example.pojo.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMapper {
    /**
     * 登录
     * @return
     */
    @Select("select * from users where username = #{username} and PASSWORD = #{password}")
    User getByUsernameAndPassword(User user);

    @Select("select RID from USER_ROLE where UID2 = #{uid2}")
    Integer getRID(Integer uid2);
//    @Update("update USER_ROLE set RID = #{roleId} where UID2 = #{UID2}")
//    void update(User u);


    /**
     * 注册
     * @param user
     */
    @Insert("INSERT INTO users(username, password) VALUES(#{username}, #{password})")
    void insertUser(User user);

    @Select("SELECT * FROM users WHERE username = #{username}")
    User selectUserByUsername(String username);

    @Insert("INSERT INTO USER_ROLE(UID2, RID) VALUES(#{UID2}, #{roleId})")
    void insertUserRole(Integer UID2,Integer roleId);

    @Insert("INSERT INTO STU(USERNAME, PASSWORD,CREATE_BY,CREATE_TIME,UPDATE_BY,UPDATE_TIME) VALUES(#{username}, #{password},#{username},sysdate,#{username},sysdate)")
    void insertStu(User user);

    @Select("select UID2 from USERS where USERNAME=#{username}")
    Integer getUID2(String username);


    /**
     * 学生用户权限
     * @param username
     * @return
     */
    @Select("select * from stu where USERNAME = #{username}")
    Stu getStu(String username);


    /**
     * 管理员用户权限
     * @param username , password
     */
    @Insert("INSERT INTO users(USERNAME,PASSWORD) VALUES(#{username},'123456')")
    void AdminInsertUser(String username);

    @Update("update users set username = #{username} where UID2 = #{uid2}")
    void updateUsername(String username,Integer uid2);

    void deleteByUsernames(List<String> usernames);

    List<Integer> getByUsernames(List<String> usernames);

    @Delete("delete from USER_ROLE where UID2 = #{uid2}")
    void deleteURbyUID2(Integer uid2);
    void deleteURbyUID2s(List<Integer> uid2s);


    void updateAdmin(User user);

    @Select("select PASSWORD from USERS where UID2 = #{uid2}")
    String getPwd2(Integer uid2);


    /**
     * 学生用户权限
     * @param pwd
     */
    @Update("update USERS set PASSWORD = #{password} where USERNAME = #{username}")
    void updatePwd(Pwd pwd);

    @Select("select PASSWORD from stu where USERNAME = #{username}")
    String getPwd(String username);

    @Select("select PASSWORD from USERS where USERNAME = #{username}")
    String getTeacherPwd(String username);

    void updateStuPwd(Pwd pwd);



    /**
     * 注销用户
     * @param username
     */
    @Delete("delete from Stu where USERNAME = #{username}")
    void deleteStuByUsername(String username);

    @Delete("delete from USERS where USERNAME = #{username}")
    void deleteUserByUsername(String username);


    @Select("select * from teacher where USERNAME = #{username}")
    Teacher getTeacher(String username);


}

