package com.example.mapper;

import com.example.pojo.Lookup;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface SmmLookupMapper {

    @Select("select * from SMM_LOOKUP")
    List<Lookup> list();
}
