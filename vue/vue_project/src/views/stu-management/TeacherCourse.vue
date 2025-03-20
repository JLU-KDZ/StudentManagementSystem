<template>
  <div id="app">
    <br />
    <br />
    <!-- 表格 -->
    <el-table :data="courseTable" border>
      <el-table-column
        prop="name"
        label="名称"
        width="150"
        align="center"
      ></el-table-column>

      <el-table-column label="教授老师" width="100" align="center"
        ><template slot-scope="scope">
          <!-- 在这里使用计算属性或方法来显示老师名称 -->
          {{ getTeacherName(scope.row.teacherId) }}
        </template>
      </el-table-column>

      <el-table-column
        prop="description"
        label="介绍"
        width="150"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="stuNumber"
        label="开课人数"
        width="80"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="maxNumber"
        label="满课人数"
        width="80"
        align="center"
      ></el-table-column>

      <el-table-column label="专业" width="200" align="center"
        ><template slot-scope="scope">
          <!-- 在这里使用计算属性或方法来显示部门名称 -->
          {{ getMajorName(scope.row.majorId) }}
        </template>
      </el-table-column>

      <el-table-column
        prop="credit"
        label="学分"
        width="80"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="time"
        label="上课时段"
        width="120"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="location"
        label="上课地点"
        width="100"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="enrolledNumber"
        label="已选人数"
        width="80"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="status"
        label="状态"
        width="80"
        align="center"
      ></el-table-column>
    </el-table>

    <br />
  </div>
</template>
      
      <script>
import axios from "@/utils/axiosConfig"; // 导入你上面创建的实例

export default {
  data() {
    return {
      courseTable: [],
      teacherTable: [],
      majorTable: [],
      username: "",
    };
  },

  created() {
    this.username = this.$store.getters.currentUser;
  },

  methods: {
    //找对应teacher major name 显示在course表中
    getTeacherName(id) {
      return (
        this.teacherTable.find((teacher) => teacher.id === id)?.name ||
        "Unknown"
      );
    },
    getMajorName(id) {
      return (
        this.majorTable.find((major) => major.id === id)?.name || "Unknown"
      );
    },

    fetchData() {
      // 发送请求获取分页数据
      axios
        .get("http://localhost:8080/teacher/listCourse", {
          params: {
            username: this.username,
          },
        })
        .then((result) => {
          this.courseTable = result.data.data;
        })
        .catch((error) => console.error("Error:", error));
    },
  },

  mounted() {
    //teacher表
    axios
      .get("http://localhost:8080/teacher/list")
      .then((result) => {
        console.log(result);
        this.teacherTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));
    //major表
    axios
      .get("http://localhost:8080/major")
      .then((result) => {
        this.majorTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

    //course表
    this.fetchData();
  },
};
</script>
      
    <style scoped>
.el-input {
  width: 350px !important;
  height: 40px !important; /* 自定义高度 */
}

.el-input__inner {
  height: 40px !important; /* 自定义内部输入框的高度 */
  line-height: 40px !important; /* 保持文字垂直居中 */
  width: 100%;
}

.el-dialog {
  height: 730px !important; /* 设置具体高度 */
}

.el-form-item {
  margin-bottom: 8px !important; /* 减小默认的底部外边距 */
}

.el-dialog__body {
  padding-top: 10px !important;
  padding-left: 30px;
  overflow-y: auto;
}

.el-dialog__body .el-form {
  display: flex;
  flex-direction: column;
  align-items: flex-start; /* 左对齐 */
}
</style>