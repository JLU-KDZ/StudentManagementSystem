<template>
  <el-menu :default-openeds="['1', '2','3']">
    <el-menu-item index="1" @click="goToDashBoard"
      ><i class="el-icon-menu"></i>首页</el-menu-item
    >

    <el-submenu index="2">
      <template slot="title"
        ><i class="el-icon-s-tools"></i>系统信息管理</template
      >
      <el-menu-item index="2-1" @click="goToStu">个人学生管理</el-menu-item>
      <el-menu-item index="2-2" @click="goToDeptMajor">学院专业</el-menu-item>
    </el-submenu>
    <el-submenu index="3">
      <template slot="title"
        ><i class="el-icon-s-claim"></i>选课信息管理</template
      >
      <el-menu-item index="3-1" @click="goToStuCourse">课程管理</el-menu-item>
      <el-menu-item index="3-2" @click="goToStuEnrollment"
        >选课信息</el-menu-item
      >
    </el-submenu>
  </el-menu>
</template>
  
  <script>
export default {
  name: "StuSideMenu",
  data() {
    return {
      activeIndex: "1",
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
        name: "alonestu",
        query: { refresh: new Date().getTime() },
      });
    },
    goToDeptMajor() {
      this.$router.push({
        name: "deptMajor",
        query: { refresh: new Date().getTime() },
      });
    },
    goToStuCourse() {
      this.$router.push({
        name: "stuCourse",
        query: { refresh: new Date().getTime() },
      });
    },
    goToStuEnrollment() {
      this.$router.push({
        name: "stuEnrollment",
        query: { refresh: new Date().getTime() },
      });
    },
  },
};
</script>
  
  <style>
</style>