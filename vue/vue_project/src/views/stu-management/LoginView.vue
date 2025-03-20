
<template>
  <div class="div1">
    <el-form
        :model="loginForm"
        :rules="fieldRules"
        ref="loginForm"
        class="login-container"
    >
      <span class="tool-bar"></span>
      <h2 class="title">用户登陆</h2>
      <el-form-item prop="account">
        <el-input
            type="text"
            v-model.trim="loginForm.account"
            auto-complete="false"
            placeholder="账号"
            class="input"
        ></el-input>
      </el-form-item>
      <el-form-item prop="password" class="item-m10">
        <el-input
            type="password"
            v-model.trim="loginForm.password"
            auto-complete="false"
            placeholder="密码"
            class="input"
        ></el-input>
      </el-form-item>
      <el-form-item prop="code" align="left" style="margin-top: 20px">
        <el-input
            v-model="loginForm.code"
            style="width: 170px"
            placeholder="验证码，点击图片刷新"
            class="input"
        ></el-input>
        <el-tag class="login-tag-code" @click="getCode">{{ viewCode }}</el-tag>
      </el-form-item>
      <div class="btn">
        <div class="checked-item">
          <el-checkbox v-model="checked">记住密码</el-checkbox>
        </div>
        <el-button type="text" @click="register">注册</el-button>
      </div>
      <br />
      <el-form-item style="width: 100%" class="btn-item">
        <el-button
            style="width: 100%"
            type="primary"
            @click.native.prevent="loginSubmit"
            :loading="loading"
        >登录</el-button
        >
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
import { setToken } from "@/utils/token";
//import { setRole, getRole } from "@/utils/role";
import axios from "axios";
export default {
  data() {
    return {
      viewCode: "",
      loginForm: {
        account: "",
        password: "",
        src: "",
        code: "",
      },
      fieldRules: {
        account: [{ required: true, message: "请输入账号", trigger: "blur" }],
        password: [{ required: true, message: "请输入密码", trigger: "blur" }],
      },
      checked: false,
      // 加载中的标志
      loading: false,
    };
  },

  // ------ 分割线

  methods: {
    register() {
      this.$router.push({
        name: "register",
        query: { refresh: new Date().getTime() },
      });
    },
    loginSubmit() {
      if (!this.loginForm.account || !this.loginForm.password) {
        this.$message.error("账号或密码不能为空！");
        return;
      }
      if (!this.loginForm.code || this.loginForm.code !== this.viewCode) {
        this.$message.error("验证码不正确！");
        return;
      }
      this.loading = true;
      let userInfo = {
        username: this.loginForm.account,
        password: this.loginForm.password,
      };
      console.log(userInfo);
      //登陆接口
      axios
          .post("http://localhost:8080/api/login", userInfo, {
            headers: {
              "Content-Type": "application/json", // 默认的内容类型
            },
          })
          .then((res) => {
            const token = res.data.data;
            setToken(token); // 将令牌存储到本地 调用utils/token里面的setToken方法
            //console.log(localStorage);
            const role = res.data.msg;
            // 使用Vuex保存角色
            this.$store.dispatch("setRole", role).then(() => {
              console.log("res.data.msg:" + role);
            });
            const username = res.data.username;
            this.$store.dispatch("setUser", username).then(() => {
              console.log("res.data.username:" + username);
            });

            //this.$store.commit('setCurrentRole', role);//mutations
            if (this.checked) {
              let rememberInfo = JSON.stringify({ ...userInfo });
              localStorage.setItem("rememberInfo", rememberInfo); // 记住密码时 保存login
            } else {
              localStorage.removeItem("rememberInfo");
            }
            if (res.data.code == 1) {
              this.$router.push({
                name: "default",
                query: { refresh: new Date().getTime() },
              });
              this.$message({
                message: "登陆成功",
                type: "success",
              });
            } else {
              this.$message.error("用户名或密码不存在");
            }
            this.loading = false;
          })
          .catch((error) => console.error("Error:", error));
    },

    //获取验证码
    getCode() {
      this.viewCode = "";
      let codeString =
          "0123456789abcdefghijklmnopqrstuvwxyz";
      let codeArray = codeString.split("");
      let num = codeArray.length;
      let newCodeArray = [];
      for (let i = 0; i < 5; i++) {
        let index = Math.floor(Math.random() * num);
        newCodeArray.push(codeArray[index]);
      }
      this.viewCode = newCodeArray.join("");
    },
  },
  mounted() {
    this.getCode();
    if (localStorage.getItem("rememberInfo")) {
      // 有上次登录信息 显示上次登录
      let rememberData = JSON.parse(localStorage.getItem("rememberInfo"));
      const { account, password } = rememberData;
      this.loginForm.account = account;
      this.loginForm.password = password;
    }
  },
};
</script>


<style scoped>
/* 设置html和body的高度为100%，以确保container可以居中 */
html,
body {
  height: 100%;
  margin: 0;
}

/* 设置背景图片 */
.div1 {
  display: grid;
  place-items: center;
  height: 100%;
  background-image: url('@/assets/back1.jpg');
  background-size: cover;
  background-position: center;
}

/* 其他样式保持不变 */
.login-container {
  display: flex;
  flex-direction: column;
  max-width: 400px;
  width: 100%;
  padding: 20px;
  box-sizing: border-box;
  background-color: rgba(255, 255, 255, 0.9); /* 半透明白色背景 */
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.input {
  width: 100%;
  height: 100%;
}
.btn {
  display: flex;
  align-items: center;
  gap: 220px; /* 或者使用 margin-right */
}

/* 验证码图片向右移动的样式 */
.login-tag-code {
  margin-left: 20px;
}

/* 标题居中 */
.title {
  text-align: center;
  margin-bottom: 20px;
}
</style>



