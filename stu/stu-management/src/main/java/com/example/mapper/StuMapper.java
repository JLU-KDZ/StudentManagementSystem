package com.example.mapper;

import com.example.pojo.Stu;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface StuMapper {

    /**
     * 分页查询
     * count()   page()
     * @return
     */
    @Select("select count(*) from STU")
    Long count();

    List<Stu> page2(Integer startRow, Integer endRow, String name, String stuId, LocalDate begin, LocalDate end);
//    List<Stu> list(String name, Integer gender, LocalDate begin, LocalDate end);

    /**
     * 批量删除
     * @param ids
     */
    void deleteByIds(List<Integer> ids);



    /**
     * 新增学生
     * @param stu
     */
//    @Insert("insert into STU (username, name, gender, image, GRADE, entrydate, dept2_id,CLASS_ID,CREATE_BY, create_time,UPDATE_BY, update_time) " +
//            "values (#{username},#{name},#{gender},#{image},#{grade},#{entrydate},#{dept2Id},#{classId},USER,sysdate,USER,sysdate)")
    void insert(Stu stu);



    /**
     * 根据id查询学生
     * @param id
     * @return
     */
    @Select("select * from STU where id = #{id}")
    Stu getByID(Integer id);

    /**
     * 更新学生
     * @param stu
     */
     void update(Stu stu);

    /**
     * 根据id集合查找username
     * @param ids
     */
    List<String> getUsernameByIds(List<Integer> ids);


    /**
     * 根据username查找
     * @param username
     * @return
     */
    @Select("select DEPT2_ID from STU where USERNAME = #{username}")
    Integer getDeptByUsername(String username);

    @Select("select name from stu where USERNAME = #{username}")
    String getNameByUsername(String username);
}
