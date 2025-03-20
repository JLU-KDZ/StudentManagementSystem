package com.example.mapper;

import com.example.pojo.Course;
import com.example.pojo.Stu;
import com.example.pojo.Teacher;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TeacherMapper {

    @Select("select count(*) from TEACHER")
    Long count();

    List<Teacher> page(Integer startRow, Integer endRow, String name, Integer dept2Id);

    @Delete("delete from TEACHER where ID=#{id}")
    void deleteById(Integer id);

    @Insert("insert into TEACHER (username,NAME,GENDER,AGE,DEPT2_ID,PHONE_NUMBER,EMAIL,OFFICE,create_by, CREATE_TIME, update_by,UPDATE_TIME) " +
            "values (#{username},#{name},#{gender},#{age},#{dept2Id},#{phoneNumber},#{email},#{office},USER,sysdate,USER,sysdate)")
    void insert(Teacher teacher);

    @Select("select * from TEACHER where id = #{id}")
    Teacher getById(Integer id);

    void update(Teacher teacher);


    @Select("select * from TEACHER")
    List<Teacher> list();

    @Select("select ID from TEACHER where USERNAME = #{username}")
    Integer getIdByUsername(String username);


    @Select("select * from COURSE where TEACHER_ID = #{teacherId}")
    List<Course> listCourse(Integer teacherId);



}
