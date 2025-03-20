<template>
  <div>
    <br />
    <el-descriptions class="margin-top" title="学生信息" :column="2" border>
      <template slot="extra">
        <el-button
          type="primary"
          @click="
            getByUsername();
            updateFormVisible = true;
          "
          >编辑</el-button
        ><el-dialog
          title="修改学生"
          :visible.sync="updateFormVisible"
          width="27%"
        >
          <el-form ref="updateForm" :model="updateForm" label-width="80px">
            <el-form-item label="用户名">
              <el-input
                v-model="inputedUsername"
                placeholder="必须以1开头 (非空)"
              ></el-input>
            </el-form-item>
            <el-form-item label="学号">
              <el-input v-model="inputedStuId" placeholder="(非空)"></el-input>
            </el-form-item>
            <el-form-item label="姓名">
              <el-input v-model="inputedName" placeholder="(非空)"></el-input>
            </el-form-item>
            <el-form-item label="图像">
              <el-upload
                class="avatar-uploader"
                action="http://localhost:8080/upload"
                :http-request="handleUpload2"
                :show-file-list="false"
                :file-list="fileList"
                :before-upload="beforeAvatarUpload"
              >
                <img v-if="inputedImage" :src="inputedImage" class="avatar" />
                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
              </el-upload>
            </el-form-item>
            <el-form-item label="性别">
              <el-select v-model="selectedGender" placeholder="选择性别 (非空)">
                <el-option
                  v-for="item in genderLookup"
                  :key="item.id"
                  :label="item.desp"
                  :value="item.value"
                >
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="年级">
              <el-select v-model="selectedGrade" placeholder="选择年级">
                <el-option
                  v-for="item in gradeLookup"
                  :key="item.id"
                  :label="item.desp"
                  :value="item.value"
                >
                </el-option>
              </el-select>
            </el-form-item>

            <el-form-item label="电话">
              <el-input v-model="inputedPhone" placeholder="电话"></el-input>
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
            <el-form-item label="所属班级">
              <el-select v-model="selectedClass" placeholder="选择班级">
                <el-option
                  v-for="item in classInfo2"
                  :key="item.classId"
                  :label="item.className"
                  :value="item.classId"
                >
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="入学日期" prop="entrydate">
              <el-date-picker
                v-model="inputedEntrydate"
                type="date"
                placeholder="选择日期"
                format="yyyy-MM-dd"
                value-format="yyyy-MM-dd"
              >
              </el-date-picker>
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
            <el-form-item label="确认密码" prop="confirmPassword" class="pwdForm">
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
          <i class="el-icon-picture-outline-round"></i>
          图像
        </template>
        <div class="block" v-for="fit in fits" :key="fit">
          <el-image
            style="width: 130px; height: 150px"
            :src="form.image"
            :fit="fit"
          ></el-image>
        </div>
      </el-descriptions-item>

      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-star-off"></i>
          学号
        </template>
        {{ form.stuId === null || form.stuId === "" ? "Unknow" : form.stuId }}
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
          手机号
        </template>
        {{ form.phonenumber }}
      </el-descriptions-item>

      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-tickets"></i>
          年级
        </template>
        {{
          form.grade === "1"
            ? "大一"
            : form.grade === "2"
            ? "大二"
            : form.grade === "3"
            ? "大三"
            : form.grade === null
            ? "Unknow"
            : "大四"
        }}
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
          <i class="el-icon-bell"></i>
          所属班级
        </template>
        <!-- 在这里使用计算属性或方法来显示部门名称 -->
        {{ getClassName(form.classId) }}
      </el-descriptions-item>

      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-date"></i>
          入学日期
        </template>
        <!-- 在这里使用计算属性或方法来显示部门名称 -->
        {{ form.entrydate }}
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

      fits: ["cover"],
      deptTable: [],
      classTable: [],
      classInfoTable: [],
      smmLookup: [],
      updateFormVisible: false,

      form: {
        username: "",
        stuId: "",
        name: "",
        gender: null,
        phonenumber: "",
        image: "",
        grade: null,
        dept2Id: null,
        classId: null,
        entrydate: "",
      },

      inputedUsername: "",
      inputedStuId: "",
      inputedName: "",
      inputedImage: "",
      selectedGender: null,
      selectedGrade: null,
      inputedPhone: "",
      selectedDept: null,
      selectedClass: null,
      inputedEntrydate: "",
      updateForm: {
        username: "",
        stuId: "",
        name: "",
        image: "", //图像url
        gender: null,
        grade: null,
        phonenumber: "",
        dept2Id: null,
        classId: null,
        entrydate: "",
      },
      fileList: [],
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
    gradeLookup() {
      return this.smmLookup.filter((item) => item.type === "grade");
    },
    classInfo2() {
      return this.classInfoTable.filter(
        (item) => item.dept2Id === this.selectedDept
      );
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
        .get(`http://localhost:8080/user`, {
          headers: { "Content-Type": "application/json" },
          params: {
            username,
          },
        })
        .then((result) => {
          console.log(result);
          this.updateForm = result.data.data;

          //学生预选
          this.inputedUsername = this.updateForm.username;
          this.inputedStuId = this.updateForm.stuId;
          this.inputedName = this.updateForm.name;
          this.inputedImage = this.updateForm.image;
          this.selectedGender = this.updateForm.gender;
          this.selectedGrade = this.updateForm.grade;
          this.inputedPhone = this.updateForm.phonenumber;

          this.selectedDept = this.updateForm.dept2Id;
          this.selectedClass = this.updateForm.classId;
          this.inputedEntrydate = this.updateForm.entrydate;
        })
        .catch((error) => console.error("Error:", error));
    },

    //编辑 提交
    onUpdateSubmit() {
      console.log(this.updateForm);
      const oldUsername = this.updateForm.username;
      const oldStuId = this.updateForm.stuId;
      const oldName = this.updateForm.name;
      const oldImage = this.updateForm.image;
      const oldGender = this.updateForm.gender;
      const oldGrade = this.updateForm.grade;
      const oldPhone = this.updateForm.phonenumber;
      const oldDeptId = this.updateForm.dept2Id;
      const oldClass = this.updateForm.classId;
      const oldEntrydate = this.updateForm.entrydate;
      this.updateForm.username = this.inputedUsername;
      this.updateForm.stuId = this.inputedStuId;
      this.updateForm.name = this.inputedName;
      this.updateForm.image = this.inputedImage;
      this.updateForm.gender = Number(this.selectedGender);
      this.updateForm.grade = Number(this.selectedGrade);
      this.updateForm.phonenumber = this.inputedPhone;
      this.updateForm.dept2Id = this.selectedDept;
      this.updateForm.classId = this.selectedClass;
      this.updateForm.entrydate = this.inputedEntrydate;
      axios
        .put("http://localhost:8080/user", this.updateForm)
        .then((result) => {
          console.log(result);
          const username = result.data.username;
          if (this.form.username !== username) {
            this.$store.dispatch("setUser", username).then(() => {
              console.log("res.data.username:" + username);
            });
            this.form.username = username;
          }
          //修改成功后渲染列表
          this.fetchStu();
          //提示
          if (
            oldUsername == this.updateForm.username &&
            oldStuId == this.updateForm.stuId &&
            oldName == this.updateForm.name &&
            oldImage == this.updateForm.image &&
            oldGender == this.updateForm.gender &&
            oldGrade == this.updateForm.grade &&
            oldPhone == this.updateForm.phonenumber &&
            oldDeptId == this.updateForm.dept2Id &&
            oldClass == this.updateForm.classId &&
            oldEntrydate == this.updateForm.entrydate
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

    //根据username展示学生
    fetchStu(username = this.form.username) {
      axios
        .get("http://localhost:8080/user", {
          headers: { "Content-Type": "application/json" },
          params: {
            username,
          },
        })
        .then((result) => {
          console.log(result.data.data);
          this.form.stuId = result.data.data.stuId;
          this.form.name = result.data.data.name;
          this.form.gender = result.data.data.gender;
          this.form.phonenumber = result.data.data.phonenumber;
          this.form.image = result.data.data.image;
          this.form.grade = result.data.data.grade;
          this.form.dept2Id = result.data.data.dept2Id;
          this.form.classId = result.data.data.classId;
          this.form.entrydate = result.data.data.entrydate;
        })
        .catch((error) => console.error("Error:", error));
    },

    //找对应dept name 显示在stu表中
    getDeptName(id) {
      return (
        this.deptTable.find((deptItem) => deptItem.id === id)?.name || "Unknown"
      );
    },

    //找对应class name 显示在stu表中
    getClassName(id) {
      return (
        this.classTable.find((classItem) => classItem.id === id)?.name ||
        "Unknown"
      );
    },

    //图像
    handleUpload2(param) {
      const form = new FormData();
      form.append("image", param.file); //这里文件名参数为image
      //发送请求到后端
      axios
        .post("http://localhost:8080/upload", form)
        .then((response) => {
          console.log(response.data.data);
          this.inputedImage = response.data.data;
        })
        .catch((error) => {
          console.error(error);
        });
    },

    beforeAvatarUpload(file) {
      const isJPG = file.type === "image/jpeg";
      const isLt10M = file.size / 1024 / 1024 < 10;

      if (!isJPG) {
        this.$message.error("上传头像图片只能是 JPG 格式!");
      }
      if (!isLt10M) {
        this.$message.error("上传头像图片大小不能超过 10MB!");
      }
      return isJPG && isLt10M;
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

    //class表
    axios
      .get("http://localhost:8080/classes")
      .then((result) => {
        console.log(result);
        this.classTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

    // 如果需要确保用户信息已经更新，则可以监听 store 的变化
    this.$store.subscribe((mutation, state) => {
      if (mutation.type === "setCurrentUser") {
        this.form.username = state.currentUser;
      }
    });

    //stu form
    this.fetchStu();

    //smmLookup表
    axios
      .get("http://localhost:8080/lookup")
      .then((result) => {
        console.log(result);
        this.smmLookup = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

    //classInfoTable表
    axios
      .get("http://localhost:8080/join")
      .then((result) => {
        console.log(result);
        this.classInfoTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));
  },
};
</script>

<style scoped>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 130px;
  height: 120px;
  line-height: 120px;
  text-align: center;
}
.avatar {
  width: 130px;
  height: 120px;
  display: block;
}

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
.pwdForm{
  margin-bottom: 20px;
}
</style>