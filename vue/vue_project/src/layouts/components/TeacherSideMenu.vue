<template>
  <el-menu :default-openeds="['1', '2','3','4']">
    <el-menu-item index="1" @click="goToDashBoard"
      ><i class="el-icon-menu"></i>首页</el-menu-item
    >
    <el-submenu index="2">
      <template slot="title"
        ><i class="el-icon-s-tools"></i>系统信息管理</template
      >
      <el-menu-item index="2-1" @click="goToStu">学生管理</el-menu-item>
      <el-menu-item index="2-2" @click="goToClass">班级管理</el-menu-item>
      <el-menu-item index="2-3" @click="goToMajor">专业信息</el-menu-item>
    </el-submenu>
    <el-submenu index="3">
      <template slot="title"
        ><i class="el-icon-s-claim"></i>选课信息管理</template
      >
      <el-menu-item index="3-1" @click="goToTeacherCourse">课程信息</el-menu-item>
      <el-menu-item index="3-2" @click="goToTeacherEnrollment"
        >选课学生</el-menu-item
      >
    </el-submenu>
    <el-submenu index="4">
      <template slot="title"
        ><i class="el-icon-s-custom"></i>教师信息管理</template
      >
      <el-menu-item index="4-1" @click="goToTeacher">教师个人管理</el-menu-item>
     
    </el-submenu>
  </el-menu>
</template>
  
  <script>
export default {
  name: "AdminSideMenu",
  data() {
    return {
      activeIndex: "3",
    };
  },

  methods: {
    goToDashBoard() {
      this.$router.push({
        name: "dashboard",
        query: { refresh: new Date().getTime() },
      });
    },
    goToStu() {
      this.$router.push({
        name: "teacherstu",
        query: { refresh: new Date().getTime() },
      });
    },
    goToClass() {
      this.$router.push({
        name: "class",
        query: { refresh: new Date().getTime() },
      });
    },
    goToMajor() {
      this.$router.push({
        name: "teacherMajor",
        query: { refresh: new Date().getTime() },
      });
    },
    goToTeacherCourse() {
      this.$router.push({
        name: "teacherCourse",
        query: { refresh: new Date().getTime() },
      });
    },
    goToTeacherEnrollment() {
      this.$router.push({
        name: "teacherEnrollment",
        query: { refresh: new Date().getTime() },
      });
    },
    goToTeacher() {
      this.$router.push({
        name: "aloneTeacher",
        query: { refresh: new Date().getTime() },
      });
    },
  },
};
</script>
  
  <style>
</style>