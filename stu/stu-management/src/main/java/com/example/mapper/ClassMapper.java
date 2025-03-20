package com.example.mapper;

import com.example.pojo.Class;
import com.example.pojo.Dept;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ClassMapper {
    @Select("select * from CLASS")
    List<Class> list();

    @Delete("delete from CLASS where ID=#{id}")
    void deleteById(Integer id);

    @Insert("insert into CLASS (NAME,DEPT2_ID,create_by, CREATE_TIME, update_by,UPDATE_TIME) values (#{name},#{dept2Id},USER,sysdate,USER,sysdate)")
    void insert(Class clas);

    @Select("select * from CLASS where id = #{id}")
    Class getById(Integer id);

    @Update("update CLASS set NAME = #{name},DEPT2_ID = #{dept2Id},update_by = USER,UPDATE_TIME = sysdate where id = #{id}")
    void update(Class clas);

    /**
     * 根据学院ID删除班级（学院删除则班级删除）
     * @param dept2Id
     */
    @Delete("delete from CLASS where DEPT2_ID = #{dept2Id}")
    void deleteByDeptId(Integer dept2Id);
}
