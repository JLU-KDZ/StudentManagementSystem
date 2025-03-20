package com.example.mapper;

import com.example.pojo.Dept;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface DeptMapper {

    @Select("select * from DEPT2")
    List<Dept> list();

    @Delete("delete from DEPT2 where ID=#{id}")
    void deleteById(Integer id);

    @Insert("insert into DEPT2 (NAME,create_by, CREATE_TIME, update_by,UPDATE_TIME) values (#{name},USER,sysdate,USER,sysdate)")
    void insert(Dept dept);

    @Select("select * from DEPT2 where id = #{id}")
    Dept getById(Integer id);

    @Update("update DEPT2 set NAME = #{name},update_by = USER,UPDATE_TIME = sysdate where id = #{id}")
    void update(Dept dept);
}
