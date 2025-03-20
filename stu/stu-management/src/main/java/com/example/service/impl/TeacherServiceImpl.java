package com.example.service.impl;

import com.example.mapper.CourseMapper;
import com.example.mapper.EnrollmentMapper;
import com.example.mapper.TeacherMapper;
import com.example.mapper.UserMapper;
import com.example.pojo.*;
import com.example.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    private TeacherMapper teacherMapper;
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CourseMapper courseMapper;

    @Autowired
    private EnrollmentMapper enrollmentMapper;

    @Override
    public PageBean2 list(Integer page, Integer pageSize, String name, Integer dept2Id) {
        Long count = teacherMapper.count();
        Integer startRow = ((page-1)*pageSize)+1;
        Integer endRow = startRow+pageSize-1;
        List<Teacher> teacherList = teacherMapper.page(startRow,endRow,name,dept2Id);
        PageBean2 pageBean2 = new PageBean2(count,teacherList);
        return pageBean2;
    }



    @Override
    public void delete(Integer id) {
        Teacher t = teacherMapper.getById(id);
        Integer uid2 = userMapper.getUID2(t.getUsername());
        userMapper.deleteURbyUID2(uid2);
        userMapper.deleteUserByUsername(t.getUsername());
        teacherMapper.deleteById(id);
    }

    @Override
    public void add(Teacher teacher) {
        teacherMapper.insert(teacher);
        userMapper.AdminInsertUser(teacher.getUsername());
        Integer uid2 = userMapper.getUID2(teacher.getUsername());
        userMapper.insertUserRole(uid2,3);
    }

    private Integer uid2;
    @Override
    public Teacher getById(Integer id) {
        Teacher t = teacherMapper.getById(id);
        this.uid2 = userMapper.getUID2(t.getUsername());
        return t;
    }

    @Override
    public void update(Teacher teacher) {
        teacherMapper.update(teacher);
        userMapper.updateUsername(teacher.getUsername(),this.uid2);
    }

    @Override
    public List<Teacher> listTable() {
        return teacherMapper.list();
    }

    @Override
    public List<Course> listCourse(String username) {
        Integer teacherId = teacherMapper.getIdByUsername(username);
        return teacherMapper.listCourse(teacherId);
    }

//    @Override
//    public List<EnrollCourseJoin> listEnrollment(String username,Integer courseId) {
//        Integer tid = teacherMapper.getIdByUsername(username);
//        Integer cid = courseMapper.getIdByTid(tid);
//        return enrollmentMapper.listJoinByCid(cid,courseId);
//    }

    @Override
    public List<EnrollCourseJoin> listEnrollment(String username,Integer courseId) {
        Integer tid = teacherMapper.getIdByUsername(username);
        List<Integer> cid = courseMapper.getIdByTid(tid);
        List<EnrollCourseJoin> ans = new ArrayList<>();
        if(courseId != null){
            for (Integer id_item : cid) {
                if(Objects.equals(id_item, courseId)){
                    ans.addAll(enrollmentMapper.listJoinByCid(id_item,courseId));
                }
            }
        }else {
            for (Integer id_item : cid) {
                ans.addAll(enrollmentMapper.listJoinByCidNull(id_item));
            }
        }
        return ans;

    }


}
