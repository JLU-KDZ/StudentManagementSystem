<template>
  <div>
    <br />
    <el-descriptions class="margin-top" title="教师信息" :column="2" border>
      <template slot="extra">
        <el-button
          type="primary"
          @click="
            getByUsername();
            updateFormVisible = true;
          "
          >编辑</el-button
        ><el-dialog
          title="修改教师"
          :visible.sync="updateFormVisible"
          width="27%"
        >
          <el-form ref="updateForm" :model="updateForm" label-width="80px">
            <el-form-item label="用户名">
              <el-input
                v-model="inputedUsername"
                placeholder="必须以3开头 (非空)"
              ></el-input>
            </el-form-item>

            <el-form-item label="姓名">
              <el-input v-model="inputedName" placeholder="(非空)"></el-input>
            </el-form-item>

            <el-form-item label="性别">
              <el-select v-model="selectedGender" placeholder="选择性别">
                <el-option
                  v-for="item in genderLookup"
                  :key="item.id"
                  :label="item.desp"
                  :value="item.value"
                >
                </el-option>
              </el-select>
            </el-form-item>

            <el-form-item label="年龄">
              <el-input v-model="inputedAge" placeholder="年龄"></el-input>
            </el-form-item>

            <el-form-item label="所属学院">
              <el-select v-model="selectedDept" placeholder="选择学院">
                <el-option
                  v-for="item in deptTable"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id"
                >
                </el-option>
              </el-select>
            </el-form-item>

            <el-form-item label="电话">
              <el-input v-model="inputedPhone" placeholder="电话"></el-input>
            </el-form-item>

            <el-form-item label="邮件">
              <el-input v-model="inputedEmail" placeholder="邮件"></el-input>
            </el-form-item>

            <el-form-item label="办公室">
              <el-select v-model="selectedOffice" placeholder="选择办公室">
                <el-option
                  v-for="item in officeLookup"
                  :key="item.id"
                  :label="item.desp"
                  :value="item.desp"
                >
                </el-option>
              </el-select>
            </el-form-item>

            <el-form-item>
              <el-button type="primary" @click="onUpdateSubmit" size="small"
                >提交</el-button
              >
              <el-button @click="updateFormVisible = false" size="small"
                >取消</el-button
              >
            </el-form-item>
          </el-form>
        </el-dialog>
      </template>
      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-user"></i>
          用户名
        </template>
        {{ form.username }}
      </el-descriptions-item>
      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-circle-check"></i>
          密码
        </template>
        <el-button type="primary" plain size="small" @click="pwdVisible = true"
          >修改密码</el-button
        ><el-dialog
          title="修改密码"
          :visible.sync="pwdVisible"
          width="27%"
          class="pwd"
        >
          <el-form ref="form" :model="user" :rules="rules" label-width="80px">
            <el-form-item label="旧密码" prop="oldPassword" class="pwdForm">
              <el-input
                v-model="user.oldPassword"
                placeholder="请输入旧密码"
                type="password"
              />
            </el-form-item>
            <el-form-item label="新密码" prop="newPassword" class="pwdForm">
              <el-input
                v-model="user.newPassword"
                placeholder="请输入新密码"
                type="password"
              />
            </el-form-item>
            <el-form-item
              label="确认密码"
              prop="confirmPassword"
              class="pwdForm"
            >
              <el-input
                v-model="user.confirmPassword"
                placeholder="请确认密码"
                type="password"
              />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" size="mini" @click="submit()"
                >保存</el-button
              >
              <el-button type="danger" size="mini" @click="pwdVisible = false"
                >关闭</el-button
              >
            </el-form-item>
          </el-form>
        </el-dialog>
      </el-descriptions-item>

      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-s-custom"></i>
          姓名
        </template>
        {{ form.name }}
      </el-descriptions-item>



      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-coordinate"></i>
          性别
        </template>
        {{ form.gender === 1 ? "男" : form.gender === null ? "Unknow" : "女" }}
      </el-descriptions-item>

      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-mobile-phone"></i>
          年龄
        </template>
        {{ form.age }}
      </el-descriptions-item>

      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-mobile-phone"></i>
          手机号
        </template>
        {{ form.phoneNumber }}
      </el-descriptions-item>


      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-office-building"></i>
          所属学院
        </template>
        <!-- 在这里使用计算属性或方法来显示部门名称 -->
        {{ getDeptName(form.dept2Id) }}
      </el-descriptions-item>

      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-mobile-phone"></i>
          邮箱
        </template>
        {{ form.email }}
      </el-descriptions-item>

      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-mobile-phone"></i>
          办公室
        </template>
        {{ form.office }}
      </el-descriptions-item>
      
    </el-descriptions>
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
      pwdVisible: false,
      user: {
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

      deptTable: [],
      smmLookup: [],
      updateFormVisible: false,

      form: {
        username: "",
        name: "",
        gender: null,
        age: null,
        phoneNumber: "",
        dept2Id: null,
        email: "",
        office: "",
      },

      inputedUsername: "",
      inputedName: "",
      selectedGender: null,
      inputedAge: null,
      inputedPhone: "",
      selectedDept: null,
      inputedEmail: "",
      selectedOffice: "",
      updateForm: {
        username: "",
        name: "",
        gender: null,
        age: null,
        phoneNumber: "",
        dept2Id: null,
        email: "",
        office: "",
      },
    };
  },
  created() {
    this.form.username = this.$store.getters.currentUser;
  },
  computed: {
    // 计算属性，返回只包含 type 为 "gender" 的 lookup
    genderLookup() {
      return this.smmLookup.filter((item) => item.type === "gender");
    },
    officeLookup() {
      return this.smmLookup.filter((item) => item.type === "office");
    },
  },

  methods: {
    //修改密码
    async submit(
      username = this.form.username,
      password = this.user.newPassword,
      confirm = this.user.confirmPassword,
      old = this.user.oldPassword.toString()
    ) {
      axios
        .get("http://localhost:8080/user/pwd", {
          headers: { "Content-Type": "application/json" },
          params: {
            username,
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
                  "http://localhost:8080/user/pwd",
                  {
                    username: username,
                    password: password,
                  },
                  {
                    headers: { "Content-Type": "application/json" },
                  }
                )
                .then((result) => {
                  console.log(result);
                  this.$message({
                    message: "修改密码成功",
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

      this.pwdVisible = false;
      this.user.oldPassword = "";
      this.user.newPassword = "";
      this.user.confirmPassword = "";
    },

    //编辑
    getByUsername(username = this.form.username) {
      axios
        .get(`http://localhost:8080/user/teacher`, {
          headers: { "Content-Type": "application/json" },
          params: {
            username,
          },
        })
        .then((result) => {
          this.updateForm = result.data.data;

          //学生预选
          this.inputedUsername = this.updateForm.username;
          this.inputedName = this.updateForm.name;
          this.selectedGender = this.updateForm.gender;
          this.inputedPhone = this.updateForm.phoneNumber;
          this.inputedAge = this.updateForm.age;
          this.inputedEmail = this.updateForm.email;
          this.selectedOffice = this.updateForm.office;
          this.selectedDept = this.updateForm.dept2Id;
        })
        .catch((error) => console.error("Error:", error));
    },

    //编辑 提交
    onUpdateSubmit() {
      const oldUsername = this.updateForm.username;
      const oldName = this.updateForm.name;
      const oldGender = this.updateForm.gender;
      const oldAge = this.updateForm.age;
      const oldPhone = this.updateForm.phoneNumber;
      const oldDeptId = this.updateForm.dept2Id;
      const oldEmail = this.updateForm.email;
      const oldOffice = this.updateForm.office;

      this.updateForm.username = this.inputedUsername;
      this.updateForm.name = this.inputedName;
      this.updateForm.gender = Number(this.selectedGender);
      this.updateForm.age = Number(this.inputedAge);
      this.updateForm.phoneNumber = this.inputedPhone;
      this.updateForm.dept2Id = this.selectedDept;
      this.updateForm.email = this.inputedEmail;
      this.updateForm.office = this.selectedOffice;
      axios
        .put("http://localhost:8080/user/updateTeacher", this.updateForm)
        .then((result) => {
          const username = result.data.username;
          if (this.form.username !== username) {
            this.$store.dispatch("setUser", username).then(() => {
              console.log("res.data.username:" + username);
            });
            this.form.username = username;
          }
          //修改成功后渲染列表
          this.fetchTeacher();
          //提示
          if (
            oldUsername == this.updateForm.username &&
            oldName == this.updateForm.name &&
            oldGender == this.updateForm.gender &&
            oldAge == this.updateForm.age &&
            oldPhone == this.updateForm.phoneNumber &&
            oldDeptId == this.updateForm.dept2Id &&
            oldEmail == this.updateForm.email &&
            oldOffice == this.updateForm.office
          ) {
            //提示没改
            this.$message({
              type: "info",
              message: "你没有修改任何数据",
            });
          } else {
            //提示修改成功
            this.$message({
              message: "恭喜你，成功修改学生",
              type: "success",
            });
          }
        })
        .catch((error) => console.error("Error:", error));
      //关闭窗口
      this.updateFormVisible = false;
    },

    //根据username展示教师
    fetchTeacher(username = this.form.username) {
      axios
        .get("http://localhost:8080/user/teacher", {
          headers: { "Content-Type": "application/json" },
          params: {
            username,
          },
        })
        .then((result) => {
          this.form.name = result.data.data.name;
          this.form.gender = result.data.data.gender;
          this.form.age = result.data.data.age;
          this.form.phoneNumber = result.data.data.phoneNumber;
          this.form.dept2Id = result.data.data.dept2Id;
          this.form.email = result.data.data.email;
          this.form.office = result.data.data.office;
         
        })
        .catch((error) => console.error("Error:", error));
    },

    //找对应dept name 显示在stu表中
    getDeptName(id) {
      return (
        this.deptTable.find((deptItem) => deptItem.id === id)?.name || "Unknown"
      );
    },
   

    
  },

  mounted() {
    //dept2表
    axios
      .get("http://localhost:8080/depts")
      .then((result) => {
        console.log(result);
        this.deptTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

    

    // 如果需要确保用户信息已经更新，则可以监听 store 的变化
    this.$store.subscribe((mutation, state) => {
      if (mutation.type === "setCurrentUser") {
        this.form.username = state.currentUser;
      }
    });

    //teacher form
    this.fetchTeacher();

    //smmLookup表
    axios
      .get("http://localhost:8080/lookup")
      .then((result) => {
        console.log(result);
        this.smmLookup = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

  },
};
</script>
  
  <style scoped>

.el-input {
  width: 350px;
  height: 30px; /* 自定义高度 */
}

.el-input__inner {
  height: 30px; /* 自定义内部输入框的高度 */
  line-height: 30px; /* 保持文字垂直居中 */
  width: 100%;
}

.el-dialog {
  height: 730px; /* 设置具体高度 */
}

.el-form-item {
  margin-bottom: 7px; /* 减小默认的底部外边距 */
}

.el-dialog__body {
  padding-top: 10px;
  padding-left: 30px;
  overflow-y: auto;
}

.el-dialog__body .el-form {
  display: flex;
  flex-direction: column;
  align-items: flex-start; /* 左对齐 */
  margin-top: 5px;
}

.pwd {
  height: 500px;
}
.pwdForm {
  margin-bottom: 20px;
}
</style>