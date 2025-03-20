<template>
  <div class="div2">
    <el-card class="box-card">
      <h2 class="title">注册</h2>
      <el-form
          :model="ruleForm"
          status-icon
          :rules="rules"
          ref="ruleForm"
          label-position="left"
          label-width="80px"
          class="demo-ruleForm"
      >
        <el-form-item label="用户名" prop="uname">
          <el-input v-model="ruleForm.uname" class="registerInput"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="pass">
          <el-input
              type="password"
              v-model="ruleForm.pass"
              autocomplete="off"
              class="registerInput"
          ></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="password">
          <el-input
              type="password"
              v-model="ruleForm.password"
              autocomplete="off"
              class="registerInput"
          ></el-input>
        </el-form-item>
      </el-form>
      <div class="btnGroup">
        <el-button type="primary" @click="submitForm('ruleForm')"
        >提交</el-button
        >
        <el-button @click="resetForm('ruleForm')">重置</el-button>
        <el-button @click="goBack">返回</el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        if (this.ruleForm.checkPass !== "") {
          this.$refs.ruleForm.validateField("checkPass");
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.ruleForm.pass) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      ruleForm: {
        uname: "",
        pass: "",
        password: "",
      },
      rules: {
        uname: [
          { required: true, message: "用户名不能为空！", trigger: "blur" },
        ],
        pass: [{ required: true, validator: validatePass, trigger: "blur" }],
        password: [
          { required: true, validator: validatePass2, trigger: "blur" },
        ],
      },
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          axios
              .post("http://localhost:8080/api/register", {
                username: this.ruleForm.uname,
                password: this.ruleForm.password,
              })
              .then((response) => {
                // 处理成功的响应
                console.log(response);
                if (response.data.code == 1) {
                  this.$router.push({
                    name: "login",
                    query: { refresh: new Date().getTime() },
                  });
                  this.$message({
                    message: "注册成功",
                    type: "success",
                  });
                } else {
                  this.$message.error("该用户已存在");
                }
              })
              .catch((error) => {
                // 处理错误响应
                console.error(error);
              });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    goBack() {
      this.$router.go(-1);
    },
  },
};
</script>

<style scoped>
/* 设置html和body的高度为100%，以确保container可以居中 */
html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
}

/* 设置背景图片 */
.div2 {
  display: grid;
  place-items: center;
  height: 100%;
  background-image: url('@/assets/back2.jpg'); /* 替换为你的图片路径 */
  background-size: cover;
  background-position: center;
}

/* 注册表单容器 */
.box-card {
  display: flex;
  flex-direction: column;
  max-width: 400px;
  width: 100%;
  padding: 20px;
  box-sizing: border-box;
  background-color: rgba(255, 255, 255, 0.9); /* 半透明背景 */
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.title {
  text-align: center;
  margin-bottom: 20px;
}

/* 表单项样式 */
.el-form-item {
  margin-bottom: 20px;
}

/* 输入框样式 */
.registerInput {
  width: 100%;
  height: 100%;
}

/* 按钮组样式 */
.btnGroup {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-top: 20px;
}
</style>