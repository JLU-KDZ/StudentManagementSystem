<template>
  <el-menu :default-openeds="['1', '2','3','4']">
    <el-menu-item index="1" @click="goToDashBoard"
      ><i class="el-icon-menu"></i>首页</el-menu-item
    >
    <el-submenu index="2">
      <template slot="title"
        ><i class="el-icon-s-tools"></i>系统信息管理</template
      >
      <el-menu-item index="2-1" @click="goToDept">学院管理</el-menu-item>
      <el-menu-item index="2-2" @click="goToStu">学生管理</el-menu-item>
      <el-menu-item index="2-3" @click="goToClass">班级管理</el-menu-item>
      <el-menu-item index="2-4" @click="goToMajor">专业管理</el-menu-item>
    </el-submenu>
    <el-submenu index="3">
      <template slot="title"
        ><i class="el-icon-s-claim"></i>选课信息管理</template
      >
      <el-menu-item index="3-1" @click="goToCourse">课程管理</el-menu-item>
      <el-menu-item index="3-2" @click="goToEnrollment">选课信息</el-menu-item>
     
    </el-submenu>
    <el-submenu index="4">
      <template slot="title"
        ><i class="el-icon-s-custom"></i>教师信息管理</template
      >
      <el-menu-item index="4-1" @click="goToTeacher">教师管理</el-menu-item>
     
    </el-submenu>

    <el-menu-item index="5" @click="goToModifyAdmin"
      ><i class="el-icon-info"></i>管理员信息修改</el-menu-item
    >
  </el-menu>
</template>

<script>
export default {
  name: "AdminSideMenu",
  data() {
    return {
      activeIndex: "2",
    };
  },

  methods: {
    goToDashBoard() {
      this.$router.push({
        name: "dashboard",
        query: { refresh: new Date().getTime() },
      });
    },
    goToDept() {
      this.$router.push({
        name: "dept",
        query: { refresh: new Date().getTime() },
      });
    },
    goToStu() {
      this.$router.push({
        name: "stu",
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
        name: "major",
        query: { refresh: new Date().getTime() },
      });
    },
    goToCourse() {
      this.$router.push({
        name: "course",
        query: { refresh: new Date().getTime() },
      });
    },
    goToEnrollment() {
      this.$router.push({
        name: "enrollment",
        query: { refresh: new Date().getTime() },
      });
    },
    goToTeacher() {
      this.$router.push({
        name: "teacher",
        query: { refresh: new Date().getTime() },
      });
    },
    goToModifyAdmin() {
      this.$router.push({
        name: "modifyAdmin",
        query: { refresh: new Date().getTime() },
      });
    },
  },
};
</script>

<style>
</style>