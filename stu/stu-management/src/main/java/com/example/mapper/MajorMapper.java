package com.example.mapper;

import com.example.pojo.Major;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MajorMapper {

    List<Major> list(String name,Integer dept2Id);

    @Delete("delete from MAJOR where id = #{id}")
    void deleteById(Integer id);

    @Insert("insert into MAJOR (NAME, DEPT2_ID, CREATE_BY, CREATE_TIME, UPDATE_BY, UPDATE_TIME) values (#{name},#{dept2Id},USER,sysdate,USER,sysdate)")
    void insert(Major major);

    @Select("select * from MAJOR where ID = #{id}")
    Major getById(Integer id);

    @Update("update MAJOR set NAME = #{name},DEPT2_ID = #{dept2Id},update_by = USER,UPDATE_TIME = sysdate where id = #{id} ")
    void update(Major major);

    @Select("select * from MAJOR where DEPT2_ID = #{dep2Id}")
    List<Major> getByDept(Integer dept2Id);
}
