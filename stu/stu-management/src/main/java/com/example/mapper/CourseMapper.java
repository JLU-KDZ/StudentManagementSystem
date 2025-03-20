package com.example.mapper;

import com.example.pojo.Course;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CourseMapper {

    @Select("select count(*) from COURSE")
    Long count();

    List<Course> page(Integer startRow, Integer endRow, String name);

    @Delete("delete from COURSE where ID = #{id}")
    void deleteById(Integer id);

    @Insert("insert into COURSE(name, teacher_id, description, stu_number,MAX_NUMBER, major_id, credit, time, location, enrolled_number,STATUS, create_by, create_time, update_by, update_time) " +
            "values (#{name},#{teacherId},#{description},#{stuNumber},#{maxNumber},#{majorId},#{credit},#{time},#{location},0,'未开课',USER,sysdate,USER,sysdate)")
    void insert(Course course);

    @Select("select * from COURSE where ID = #{id}")
    Course getById(Integer id);


    void update(Course course);


//    @Select("select ID from COURSE where TEACHER_ID = #{tid}")
//    Integer getIdByTid(Integer tid);
    @Select("select ID from COURSE where TEACHER_ID = #{tid}")
    List<Integer> getIdByTid(Integer tid);

    @Select("select * from COURSE")
    List<Course> list();
}
