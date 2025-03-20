package com.example.mapper;

import com.example.pojo.DeptClassJoin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface DeptClassJoinMapper {

    @Select("select d.id dept2_id,d.name dept2_name,c.id class_id, c.name class_name " +
            "from dept2 d,CLASS c where c.DEPT2_ID =d.id")
    List<DeptClassJoin> list();
}
