<!-- MainLayout.vue -->
<template>
  <div id="app">
    <el-container>
      <el-header
        style="font-size: 40px; background-color: rgb(238, 241, 246)"
        class="header"
        v-if="$route.meta.layout !== 'no-layout'"
        >学生信息管理系统
        <el-button
          type="info"
          plain
          round
          size="mini"
          class="button2"
          @click="deleteUser(username)"
          >注销</el-button
        >
        <el-button
          type="info"
          plain
          round
          size="mini"
          class="button"
          @click="logout"
          >退出</el-button
        ></el-header
      >
      <el-container>
        <el-aside
          width="230px"
          style="border: 1px solid #eee"
          v-if="$route.meta.layout !== 'no-layout'"
        >
          <AdminSideMenu v-if="role === '2'" />
          <StuSideMenu v-else-if="role === '1'" />
          <TeacherSideMenu v-else-if="role === '3'" />
        </el-aside>
        <el-main>
          <router-view :name="'default'"></router-view>
          <router-view :name="'no-layout'"></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import axios from "@/utils/axiosConfig"; // 导入你上面创建的实例
import AdminSideMenu from "./components/AdminSideMenu.vue";
import StuSideMenu from "./components/StuSideMenu.vue";
import TeacherSideMenu from "./components/TeacherSideMenu.vue";
//import { mapState } from "vuex";

export default {
  name: "MainLayout",
  components: {
    AdminSideMenu,
    StuSideMenu,
    TeacherSideMenu,
  },

  //当前用户的权限
  // computed: {
  //   ...mapState(["currentRole"]),
  // },

  created() {
    this.role = this.$store.getters.currentRole;
    this.username = this.$store.getters.currentUser;
  },
  mounted() {
    // 如果需要确保角色信息已经更新，则可以监听 store 的变化
    this.$store.subscribe((mutation, state) => {
      if (mutation.type === "setCurrentRole") {
        this.role = state.currentRole;
      }
    });

    // 如果需要确保用户信息已经更新，则可以监听 store 的变化
    this.$store.subscribe((mutation, state) => {
      if (mutation.type === "setCurrentUser") {
        this.username = state.currentUser;
      }
    });
  },

  data() {
    return {
      role: null, // 初始化role为null
      username: null,
    };
  },
  methods: {
    //删除该用户
    deleteUser(username) {
      console.log(username);
      this.$confirm("此操作将永久注销该用户, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          //删除用户
          try {
            axios
              .delete(`http://localhost:8080/user/delete/${username}`, {
                headers: { "Content-Type": "application/json" },
              })
              .then((result) => {
                console.log(result);
              });
          } catch (error) {
            console.error("Error deleting row:", error);
          }

          //提示删除成功
          this.$message({
            type: "success",
            message: "注销成功!",
          });
          this.$router.push({
            name: "login",
            query: { refresh: new Date().getTime() },
          });
        })
        .catch(() => {
          //提示删除取消 （删除取消）
          this.$message({
            type: "info",
            message: "已取消注销",
          });
        });
    },
    logout() {
      // 清除登录状态，例如删除 token
      // this.$store.dispatch('logout') 如果你使用 Vuex
      // 或者
      localStorage.removeItem("token");
      localStorage.removeItem("dept2Id");
      localStorage.removeItem("stuName");
      // 导航到登录页面
      this.$router.push({
        name: "login",
        query: { refresh: new Date().getTime() },
      });
    },
  },
};
</script>

<style>
/* 确保HTML和body占满整个视窗 */
html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
}

/* 设置el-container的高度为100%，以占满整个视窗 */
.el-container {
  height: 100%;
  display: flex;
  flex-direction: row;
  border: 1px solid #eee;
}

/* 设置el-aside的高度为100%，以占满el-container的高度 */
.el-aside .el-menu {
  height: 100%;
  /* 其他样式，如背景色、边框等 */
  background: #eff2fa;
}

/* 设置el-main的高度为100%，并使用flex-grow确保它占满剩余空间 */
.el-main {
  height: 820px;
  flex-grow: 1;
  /* 其他样式，如背景色、边框等 */
}

/* 用于表格的样式，可以设置一个最大高度，以限制其增长 */
.table-container {
  max-height: calc(100% - 20px); /* 减去顶部和底部的边距或padding */
}

/* 用于固定下边界，例如一个footer元素 */
.fixed-footer {
  position: sticky;
  bottom: 0;
  left: 0;
  right: 0;
}
.header {
  position: relative; /* 创建定位上下文 */
}

.button {
  position: absolute;
  bottom: 10px; /* 距离底部的距离 */
  right: 10px; /* 距离右侧的距离 */
}
.button2 {
  position: absolute;
  bottom: 10px; /* 距离底部的距离 */
  right: 70px; /* 距离右侧的距离 */
}

/* .no-layout .header,
.no-layout .aside {
  display: none;
} */
</style>