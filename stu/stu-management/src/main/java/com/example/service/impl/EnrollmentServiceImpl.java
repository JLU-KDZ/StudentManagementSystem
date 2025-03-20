package com.example.service.impl;

import com.example.mapper.EnrollmentMapper;
import com.example.pojo.EnrollCourseJoin;
import com.example.pojo.EnrollCourseJoinStatus;
import com.example.pojo.Enrollment;
import com.example.service.EnrollmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.ArrayList;

@Service
public class EnrollmentServiceImpl implements EnrollmentService {

    @Autowired
    private EnrollmentMapper enrollmentMapper;

    @Override
    public List<EnrollCourseJoinStatus> listJoin(String stuName, String courseName) {

        List<EnrollCourseJoinStatus> resultList = new ArrayList<>();

        if(stuName==null||courseName==null|| stuName.isEmpty() || courseName.isEmpty()){
            List<EnrollCourseJoin> tempResultList=enrollmentMapper.listJoin(stuName, courseName);
            for (EnrollCourseJoin join : tempResultList) {
                EnrollCourseJoinStatus statusJoin = new EnrollCourseJoinStatus();
                statusJoin.setId(join.getId());
                statusJoin.setStuName(join.getStuName());
                statusJoin.setCourseId(join.getCourseId());
                statusJoin.setCourseName(join.getCourseName());
                statusJoin.setMajorId(join.getMajorId());
                statusJoin.setCredit(join.getCredit());
                statusJoin.setTime(join.getTime());
                statusJoin.setLocation(join.getLocation());
                statusJoin.setStatus("已选课"); // 设置status为"已选课"
                resultList.add(statusJoin);
            }
        }else{
            List<EnrollCourseJoin> tempResultList1=enrollmentMapper.listJoin(stuName, courseName);
            if(!tempResultList1.isEmpty()){
                for (EnrollCourseJoin join : tempResultList1) {
                    EnrollCourseJoinStatus statusJoin = new EnrollCourseJoinStatus();
                    statusJoin.setId(join.getId());
                    statusJoin.setStuName(join.getStuName());
                    statusJoin.setCourseId(join.getCourseId());
                    statusJoin.setCourseName(join.getCourseName());
                    statusJoin.setMajorId(join.getMajorId());
                    statusJoin.setCredit(join.getCredit());
                    statusJoin.setTime(join.getTime());
                    statusJoin.setLocation(join.getLocation());
                    statusJoin.setStatus("已选课"); // 设置status为"已选课"
                    resultList.add(statusJoin);
                }
            }else{
                List<EnrollCourseJoin> tempResultList2=enrollmentMapper.listTimes(stuName, courseName);
                EnrollCourseJoin join = tempResultList2.getFirst();
                EnrollCourseJoinStatus statusJoin = new EnrollCourseJoinStatus();
                statusJoin.setId(join.getId());
                statusJoin.setStuName(join.getStuName());
                statusJoin.setCourseId(join.getCourseId());
                statusJoin.setCourseName(join.getCourseName());
                statusJoin.setMajorId(join.getMajorId());
                statusJoin.setCredit(join.getCredit());
                statusJoin.setTime(join.getTime());
                statusJoin.setLocation(join.getLocation());
                statusJoin.setStatus("未选课"); // 设置status为"已选课"
                resultList.add(statusJoin);
            }

        }

        return resultList;
    }

    @Override
    public void insert(Enrollment enrollment) {
        Integer enNum = enrollmentMapper.getEnNum(enrollment.getCourseId());
        Integer maxNum = enrollmentMapper.getMaxNum(enrollment.getCourseId());
        Integer stuNum = enrollmentMapper.getStuNum(enrollment.getCourseId());
        if (enNum < maxNum) {
            enrollmentMapper.plus1(enrollment.getCourseId());
            enNum = enNum + 1;
            enrollmentMapper.insert(enrollment);
            if (enNum >= stuNum && enNum < maxNum) {
                enrollmentMapper.setStatus("开课", enrollment.getCourseId());
            } else if (enNum == maxNum) {
                enrollmentMapper.setStatus("满课", enrollment.getCourseId());
            }

        }


    }


//    public void delete(Enrollment enrollment) {
//        Integer enNum = enrollmentMapper.getEnNum(enrollment.getCourseId());
//        Integer stuNum = enrollmentMapper.getStuNum(enrollment.getCourseId());
//        if (enNum - 1 > 0) {
//            enrollmentMapper.minus1(enrollment.getCourseId());
//            enNum = enNum - 1;
//            enrollmentMapper.delete(enrollment);
//            if (enNum < stuNum) {
//                enrollmentMapper.setStatus("未开课", enrollment.getCourseId());
//            }
//
//        }
//
//    }

    @Override
    public void delete(Enrollment enrollment) {
        Integer enNum = enrollmentMapper.getEnNum(enrollment.getCourseId());
        Integer stuNum = enrollmentMapper.getStuNum(enrollment.getCourseId());
        if (enNum - 1 >= 0) {
            enrollmentMapper.minus1(enrollment.getCourseId());
            enNum = enNum - 1;
            enrollmentMapper.delete(enrollment);
            if (enNum >= stuNum) {
                enrollmentMapper.setStatus("开课", enrollment.getCourseId());
            }
            else  {
                enrollmentMapper.setStatus("未开课", enrollment.getCourseId());
            }

        }

    }

    @Override
    public void insertByAdmin(String stuName, String courseName){
        Integer courseId = enrollmentMapper.selectByAdmin(courseName);
        enrollmentMapper.insertByAdmin(stuName,courseId);
    }

    @Override
    public void deleteByAdmin(String stuName, String courseName){
        Integer courseId = enrollmentMapper.selectByAdmin(courseName);
        enrollmentMapper.deleteByAdmin(stuName, courseId);
    }


    @Override
    public Integer flag(String stuName, Integer courseId) {
        Enrollment enrollment = enrollmentMapper.flag(stuName, courseId);
        String status = enrollmentMapper.getStatusByCourseId(courseId);
        if (enrollment == null && !status.equals("满课")) {
            return 0;
        } else if (enrollment == null && status.equals("满课")) {
            return -1;
        } else if(enrollment != null && status.equals("满课")){
            return 1;
        }else {
            return 1;
        }
    }
}
