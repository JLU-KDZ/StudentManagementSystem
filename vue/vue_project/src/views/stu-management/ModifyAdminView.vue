<template>
  <div>
    <el-card class="box-card">
      <h2>修改管理员</h2>
      <el-form
        :model="user"
        status-icon
        :rules="rules"
        ref="ruleForm"
        label-position="left"
        label-width="80px"
        class="demo-ruleForm"
      >
        <el-form-item label="用户名" prop="username">
          <el-input v-model="user.username" />
        </el-form-item>
        <el-form-item label="旧密码" prop="oldPassword">
          <el-input
            v-model="user.oldPassword"
            placeholder="请输入旧密码"
            type="password"
          />
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input
            v-model="user.newPassword"
            placeholder="请输入新密码"
            type="password"
          />
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input
            v-model="user.confirmPassword"
            placeholder="请确认密码"
            type="password"
          />
        </el-form-item>
      </el-form>
      <div class="btnGroup">
        <el-button type="primary" size="small" @click="submit()"
          >保存</el-button
        >
        <el-button @click="resetForm('ruleForm')" size="small">重置</el-button>
      </div>
    </el-card>
  </div>
</template>
<script>
import axios from "@/utils/axiosConfig"; // 导入你上面创建的实例

export default {
  data() {
    const equalToPassword = (rule, value, callback) => {
      if (this.user.newPassword !== value) {
        callback(new Error("两次输入的密码不一致"));
      } else {
        callback();
      }
    };

    return {
      uid: null,
      user: {
        username: "",
        oldPassword: "",
        newPassword: "",
        confirmPassword: "",
      },

      // 表单校验
      rules: {
        oldPassword: [
          { required: true, message: "旧密码不能为空", trigger: "blur" },
        ],
        newPassword: [
          { required: true, message: "新密码不能为空", trigger: "blur" },
        ],
        confirmPassword: [
          { required: true, message: "确认密码不能为空", trigger: "blur" },
          { required: true, validator: equalToPassword, trigger: "blur" },
        ],
      },
    };
  },

  created() {
    this.user.username = this.$store.getters.currentUser;
  },
  mounted() {
    //拿到uid
    axios
      .get("http://localhost:8080/user/uid2", {
        headers: { "Content-Type": "application/json" },
        params: {
          username: this.user.username,
        },
      })
      .then((result) => {
        this.uid = result.data.data;
      })
      .catch((error) => console.error("Error:", error));
  },
  methods: {
    resetForm(formName) {
      this.$refs[formName].resetFields();
      this.user.username = this.$store.getters.currentUser;
    },

    //修改密码
    async submit(
      uid2 = this.uid,
      username = this.user.username,
      password = this.user.newPassword,
      confirm =  this.user.confirmPassword,
      old = this.user.oldPassword.toString()
    ) {
      axios
        .get("http://localhost:8080/user/pwd2", {
          headers: { "Content-Type": "application/json" },
          params: {
            uid2,
          },
        })
        .then((result) => {
          const pwd = result.data.data;
          if (old === pwd && old != "") {
            if (password != confirm) {
              this.$message.error("确认密码不正确");
            } else {
              axios
                .put(
                  "http://localhost:8080/user/updateAdmin",
                  {
                    uid2: uid2,
                    username: username,
                    password: password,
                    roleId: "2",
                  },
                  {
                    headers: { "Content-Type": "application/json" },
                  }
                )
                .then((result) => {
                  console.log(result);
                  this.$message({
                    message: "修改成功",
                    type: "success",
                  });
                })
                .catch((error) => console.error("Error:", error));
            }
          } else {
            this.$message.error("旧密码错误");
          }
        })
        .catch((error) => console.error("Error:", error));
    },
  },
};
</script>

<style scoped>
</style>
