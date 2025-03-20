package com.example.mapper;

import com.example.pojo.EnrollCourseJoin;
import com.example.pojo.Enrollment;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface EnrollmentMapper {
    List<EnrollCourseJoin> listJoin(String stuName, String courseName);

    List<EnrollCourseJoin> listTimes(String stuName, String courseName);


    
    @Insert("insert into ENROLLMENT(STU_NAME, COURSE_ID, CREATE_BY, CREATE_TIME, UPDATE_BY, UPDATE_TIME) " +
            "values (#{stuName},#{courseId},USER,sysdate,USER,sysdate)")
    void insert(Enrollment enrollment);

    @Delete("delete from ENROLLMENT where STU_NAME = #{stuName} and COURSE_ID = #{courseId}")
    void delete(Enrollment enrollment);



    @Select("select ID from COURSE where NAME = #{courseName}")
    Integer selectByAdmin(String courseName);


    @Insert("insert into ENROLLMENT(STU_NAME, COURSE_ID, CREATE_BY, CREATE_TIME, UPDATE_BY, UPDATE_TIME) " +
            "values (#{stuName},#{courseId},USER,sysdate,USER,sysdate)")
    void insertByAdmin(String stuName, Integer courseId);

    @Delete("delete from ENROLLMENT where STU_NAME = #{stuName} and COURSE_ID = #{courseId}")
    void deleteByAdmin(String stuName, Integer courseId);




    @Delete("delete from ENROLLMENT where COURSE_ID = #{courseId}")
    void deleteByCourseId(Integer courseId);

    @Update("update COURSE set ENROLLED_NUMBER = ENROLLED_NUMBER+1 where ID = #{courseId}")
    void plus1(Integer courseId);

    @Update("update COURSE set ENROLLED_NUMBER = ENROLLED_NUMBER-1 where ID = #{courseId}")
    void minus1(Integer courseId);

    @Select("select ENROLLED_NUMBER from COURSE where ID = #{courseId}")
    Integer getEnNum(Integer courseId);

    @Select("select STU_NUMBER from COURSE where ID = #{courseId}")
    Integer getStuNum(Integer courseId);

    @Select("select MAX_NUMBER from COURSE where ID = #{courseId}")
    Integer getMaxNum(Integer courseId);

    @Update("update COURSE set STATUS = #{status} where ID = #{courseId}")
    void setStatus(String status,Integer courseId);

    @Select("select * from ENROLLMENT where STU_NAME = #{stuName} and COURSE_ID = #{courseId} ")
    Enrollment flag(String stuName ,Integer courseId);

    @Select("select STATUS from COURSE where ID = #{courseId}")
    String getStatusByCourseId(Integer courseId);


    List<EnrollCourseJoin> listJoinByCid(Integer id_item,Integer courseId);

    List<EnrollCourseJoin> listJoinByCidNull(Integer id_item);
}
