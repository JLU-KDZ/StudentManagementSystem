<template>
  <div id="app">
    <!-- 表单 -->
    <el-form :inline="true" :model="searchForm" class="demo-form-inline">
      <el-form-item label="">
        <el-select v-model="searchForm.course" placeholder="选择课程">
          <el-option
            v-for="item in courseTable"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          >
          </el-option>
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" size="small" @click="onSearchSubmit"
          >查询</el-button
        >
        <el-button type="danger" size="small" @click="deleteSearch"
          >清空</el-button
        >
      </el-form-item>
    </el-form>

    <br />
    <br />

    <!-- 表格 -->
    <el-table :data="enrollmentTable">
      <el-table-column
        prop="stuName"
        label="学生"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="courseName"
        label="课程"
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
        align="center"
      ></el-table-column>

      <el-table-column
        prop="time"
        label="上课时段"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="location"
        label="上课地点"
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
      enrollmentTable: [],
      majorTable: [],
      courseTable: [],
      username: "",

      searchForm: {
        course: null,
      },
    };
  },

  created() {
    this.username = this.$store.getters.currentUser;
  },

  methods: {
    //找对应 major name 显示在表中
    getMajorName(id) {
      return (
        this.majorTable.find((major) => major.id === id)?.name || "Unknown"
      );
    },
    //查询
    onSearchSubmit: function () {
      axios
        .get("http://localhost:8080/teacher/listEnrollment", {
          params: {
            username: this.username,
            courseId: this.searchForm.course,
          },
        })
        .then((result) => {
          this.enrollmentTable = result.data.data;
        })
        .catch((error) => console.error("Error:", error));
    },
    //清空查询
    deleteSearch() {
      this.searchForm.course = null;
      this.fetchData();
    },

    fetchData() {
      axios
        .get("http://localhost:8080/teacher/listEnrollment", {
          params: {
            username: this.username,
          },
        })
        .then((result) => {
          this.enrollmentTable = result.data.data;
        })
        .catch((error) => console.error("Error:", error));
    },
  },
  mounted() {
    //major表
    axios
      .get("http://localhost:8080/major")
      .then((result) => {
        this.majorTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

    //course表
    axios
      .get("http://localhost:8080/course/list")
      .then((result) => {
        this.courseTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

    //enrollmentJoin表
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