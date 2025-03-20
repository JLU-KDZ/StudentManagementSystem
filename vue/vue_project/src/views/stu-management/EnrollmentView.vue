<!--<template>-->
<!--  <div id="app">-->
<!--    &lt;!&ndash; 表单 &ndash;&gt;-->
<!--    <el-form :inline="true" :model="searchForm" class="demo-form-inline">-->
<!--      <el-form-item label="">-->
<!--        <el-input-->
<!--          v-model="searchForm.stuName"-->
<!--          placeholder="学生名称"-->
<!--        ></el-input>-->
<!--      </el-form-item>-->
<!--      <el-form-item label="">-->
<!--        <el-input-->
<!--          v-model="searchForm.courseName"-->
<!--          placeholder="课程名称"-->
<!--        ></el-input>-->
<!--      </el-form-item>-->

<!--      <el-form-item>-->
<!--        <el-button type="primary" size="small" @click="onSearchSubmit"-->
<!--          >查询</el-button-->
<!--        >-->
<!--        <el-button type="danger" size="small" @click="deleteSearch"-->
<!--          >清空</el-button-->
<!--        >-->
<!--      </el-form-item>-->
<!--    </el-form>-->

<!--    <br />-->
<!--    <br />-->
<!--    &lt;!&ndash; 表格 &ndash;&gt;-->
<!--    <el-table :data="enrollmentTable">-->
<!--      <el-table-column-->
<!--        prop="stuName"-->
<!--        label="学生"-->
<!--        align="center"-->
<!--      ></el-table-column>-->

<!--      <el-table-column-->
<!--        prop="courseName"-->
<!--        label="课程"-->
<!--        align="center"-->
<!--      ></el-table-column>-->

<!--      <el-table-column label="专业" width="200" align="center"-->
<!--        ><template slot-scope="scope">-->
<!--          &lt;!&ndash; 在这里使用计算属性或方法来显示部门名称 &ndash;&gt;-->
<!--          {{ getMajorName(scope.row.majorId) }}-->
<!--        </template>-->
<!--      </el-table-column>-->

<!--      <el-table-column-->
<!--        prop="credit"-->
<!--        label="学分"-->
<!--        align="center"-->
<!--      ></el-table-column>-->

<!--      <el-table-column-->
<!--        prop="time"-->
<!--        label="上课时段"-->
<!--        align="center"-->
<!--      ></el-table-column>-->

<!--      <el-table-column-->
<!--        prop="location"-->
<!--        label="上课地点"-->
<!--        align="center"-->
<!--      ></el-table-column>-->
<!--    </el-table>-->

<!--    <br />-->
<!--  </div>-->
<!--</template>-->

<!--    <script>-->
<!--import axios from "@/utils/axiosConfig"; // 导入你上面创建的实例-->

<!--export default {-->
<!--  data() {-->
<!--    return {-->
<!--      enrollmentTable: [],-->
<!--      majorTable: [],-->

<!--      searchForm: {-->
<!--        stuName: "",-->
<!--        courseName: "",-->
<!--      },-->
<!--    };-->
<!--  },-->

<!--  methods: {-->
<!--    //找对应 major name 显示在表中-->
<!--    getMajorName(id) {-->
<!--      return (-->
<!--        this.majorTable.find((major) => major.id === id)?.name || "Unknown"-->
<!--      );-->
<!--    },-->

<!--    //查询-->
<!--    onSearchSubmit: function () {-->
<!--      axios-->
<!--        .get("http://localhost:8080/enrollment", {-->
<!--          params: {-->
<!--            stuName: this.searchForm.stuName,-->
<!--            courseName: this.searchForm.courseName,-->
<!--          },-->
<!--        })-->
<!--        .then((result) => {-->
<!--          this.enrollmentTable = result.data.data;-->
<!--        })-->
<!--        .catch((error) => console.error("Error:", error));-->
<!--    },-->
<!--    //清空查询-->
<!--    deleteSearch() {-->
<!--      this.searchForm.stuName = "";-->
<!--      this.searchForm.courseName = "";-->
<!--      this.fetchData();-->
<!--    },-->

<!--    fetchData() {-->
<!--      axios-->
<!--        .get("http://localhost:8080/enrollment")-->
<!--        .then((result) => {-->
<!--          this.enrollmentTable = result.data.data;-->
<!--        })-->
<!--        .catch((error) => console.error("Error:", error));-->
<!--    },-->
<!--  },-->
<!--  mounted() {-->
<!--    //major表-->
<!--    axios-->
<!--      .get("http://localhost:8080/major")-->
<!--      .then((result) => {-->
<!--        console.log(result);-->
<!--        this.majorTable = result.data.data;-->
<!--      })-->
<!--      .catch((error) => console.error("Error:", error));-->

<!--    //enrollmentJoin表-->
<!--    this.fetchData();-->
<!--  },-->
<!--};-->
<!--</script>-->

<!--  <style scoped>-->
<!--.el-input {-->
<!--  width: 350px !important;-->
<!--  height: 40px !important; /* 自定义高度 */-->
<!--}-->

<!--.el-input__inner {-->
<!--  height: 40px !important; /* 自定义内部输入框的高度 */-->
<!--  line-height: 40px !important; /* 保持文字垂直居中 */-->
<!--  width: 100%;-->
<!--}-->

<!--.el-dialog {-->
<!--  height: 730px !important; /* 设置具体高度 */-->
<!--}-->

<!--.el-form-item {-->
<!--  margin-bottom: 8px !important; /* 减小默认的底部外边距 */-->
<!--}-->

<!--.el-dialog__body {-->
<!--  padding-top: 10px !important;-->
<!--  padding-left: 30px;-->
<!--  overflow-y: auto;-->
<!--}-->

<!--.el-dialog__body .el-form {-->
<!--  display: flex;-->
<!--  flex-direction: column;-->
<!--  align-items: flex-start; /* 左对齐 */-->
<!--}-->
<!--</style>-->

<!--<template>-->
<!--  <div id="app">-->
<!--    &lt;!&ndash; 表单 &ndash;&gt;-->
<!--    <el-form :inline="true" :model="searchForm" class="demo-form-inline">-->
<!--      <el-form-item label="">-->
<!--        <el-input-->
<!--            v-model="searchForm.stuName"-->
<!--            placeholder="学生名称"-->
<!--        ></el-input>-->
<!--      </el-form-item>-->
<!--      <el-form-item label="">-->
<!--        <el-input-->
<!--            v-model="searchForm.courseName"-->
<!--            placeholder="课程名称"-->
<!--        ></el-input>-->
<!--      </el-form-item>-->

<!--      <el-form-item>-->
<!--        <el-button type="primary" size="small" @click="onSearchSubmit"-->
<!--        >查询</el-button-->
<!--        >-->
<!--        <el-button type="danger" size="small" @click="deleteSearch"-->
<!--        >清空</el-button-->
<!--        >-->
<!--      </el-form-item>-->
<!--    </el-form>-->

<!--    <br />-->
<!--    <br />-->
<!--    &lt;!&ndash; 表格 &ndash;&gt;-->
<!--    <el-table :data="enrollmentTable">-->
<!--      <el-table-column-->
<!--          prop="stuName"-->
<!--          label="学生"-->
<!--          align="center"-->
<!--      ></el-table-column>-->

<!--      <el-table-column-->
<!--          prop="courseName"-->
<!--          label="课程"-->
<!--          align="center"-->
<!--      ></el-table-column>-->

<!--      <el-table-column label="专业" width="200" align="center"-->
<!--      ><template slot-scope="scope">-->
<!--        {{ getMajorName(scope.row.majorId) }}-->
<!--      </template>-->
<!--      </el-table-column>-->

<!--      <el-table-column-->
<!--          prop="credit"-->
<!--          label="学分"-->
<!--          align="center"-->
<!--      ></el-table-column>-->

<!--      <el-table-column-->
<!--          prop="time"-->
<!--          label="上课时段"-->
<!--          align="center"-->
<!--      ></el-table-column>-->

<!--      <el-table-column-->
<!--          prop="location"-->
<!--          label="上课地点"-->
<!--          align="center"-->
<!--      ></el-table-column>-->

<!--      &lt;!&ndash; 状态列 &ndash;&gt;-->
<!--      <el-table-column label="状态" align="center">-->
<!--        <template slot-scope="scope">-->
<!--          <span>{{ scope.row.status }}</span>-->
<!--        </template>-->
<!--      </el-table-column>-->

<!--      &lt;!&ndash; 操作列 &ndash;&gt;-->
<!--      <el-table-column label="操作" align="center">-->
<!--        <template slot-scope="scope">-->
<!--          <el-button-->
<!--              v-if="scope.row.status === '已选课'"-->
<!--              type="danger"-->
<!--              size="small"-->
<!--              @click="handleDropCourse(scope.row)"-->
<!--          >-->
<!--            退课-->
<!--          </el-button>-->
<!--          <el-button-->
<!--              v-else-->
<!--              type="primary"-->
<!--              size="small"-->
<!--              @click="handleEnrollCourse(scope.row)"-->
<!--          >-->
<!--            选课-->
<!--          </el-button>-->
<!--        </template>-->
<!--      </el-table-column>-->
<!--    </el-table>-->

<!--    <br />-->
<!--  </div>-->
<!--</template>-->

<!--<script>-->
<!--import axios from "@/utils/axiosConfig"; // 导入你上面创建的实例-->

<!--export default {-->
<!--  data() {-->
<!--    return {-->
<!--      enrollmentTable: [],-->
<!--      majorTable: [],-->

<!--      searchForm: {-->
<!--        stuName: "",-->
<!--        courseName: "",-->
<!--      },-->
<!--    };-->
<!--  },-->

<!--  methods: {-->
<!--    //找对应 major name 显示在表中-->
<!--    getMajorName(id) {-->
<!--      return (-->
<!--          this.majorTable.find((major) => major.id === id)?.name || "Unknown"-->
<!--      );-->
<!--    },-->

<!--    //查询-->
<!--    onSearchSubmit: function () {-->
<!--      axios-->
<!--          .get("http://localhost:8080/enrollment", {-->
<!--            params: {-->
<!--              stuName: this.searchForm.stuName,-->
<!--              courseName: this.searchForm.courseName,-->
<!--            },-->
<!--          })-->
<!--          .then((result) => {-->
<!--            this.enrollmentTable = result.data.data;-->
<!--          })-->
<!--          .catch((error) => console.error("Error:", error));-->
<!--    },-->
<!--    //清空查询-->
<!--    deleteSearch() {-->
<!--      this.searchForm.stuName = "";-->
<!--      this.searchForm.courseName = "";-->
<!--      this.fetchData();-->
<!--    },-->

<!--    fetchData() {-->
<!--      axios-->
<!--          .get("http://localhost:8080/enrollment")-->
<!--          .then((result) => {-->
<!--            this.enrollmentTable = result.data.data;-->
<!--          })-->
<!--          .catch((error) => console.error("Error:", error));-->
<!--    },-->

<!--    //处理退课-->
<!--    handleDropCourse(row) {-->
<!--      axios-->
<!--          .post("http://localhost:8080/dropCourse", {-->
<!--            stuId: row.stuId,-->
<!--            courseId: row.courseId,-->
<!--          })-->
<!--          .then((response) => {-->
<!--            if (response.data.success) {-->
<!--              this.$message.success("退课成功");-->
<!--              row.status = "未选课"; // 更新状态-->
<!--            } else {-->
<!--              this.$message.error("退课失败");-->
<!--            }-->
<!--          })-->
<!--          .catch((error) => {-->
<!--            console.error("Error:", error);-->
<!--            this.$message.error("退课失败");-->
<!--          });-->
<!--    },-->

<!--    //处理选课-->
<!--    handleEnrollCourse(row) {-->
<!--      axios-->
<!--          .post("http://localhost:8080/enrollCourse", {-->
<!--            stuId: row.stuId,-->
<!--            courseId: row.courseId,-->
<!--          })-->
<!--          .then((response) => {-->
<!--            if (response.data.success) {-->
<!--              this.$message.success("选课成功");-->
<!--              row.status = "已选课"; // 更新状态-->
<!--            } else {-->
<!--              this.$message.error("选课失败");-->
<!--            }-->
<!--          })-->
<!--          .catch((error) => {-->
<!--            console.error("Error:", error);-->
<!--            this.$message.error("选课失败");-->
<!--          });-->
<!--    },-->
<!--  },-->
<!--  mounted() {-->
<!--    //major表-->
<!--    axios-->
<!--        .get("http://localhost:8080/major")-->
<!--        .then((result) => {-->
<!--          console.log(result);-->
<!--          this.majorTable = result.data.data;-->
<!--        })-->
<!--        .catch((error) => console.error("Error:", error));-->

<!--    //enrollmentJoin表-->
<!--    this.fetchData();-->
<!--  },-->
<!--};-->
<!--</script>-->

<!--<style scoped>-->
<!--.el-input {-->
<!--  width: 350px !important;-->
<!--  height: 40px !important; /* 自定义高度 */-->
<!--}-->

<!--.el-input__inner {-->
<!--  height: 40px !important; /* 自定义内部输入框的高度 */-->
<!--  line-height: 40px !important; /* 保持文字垂直居中 */-->
<!--  width: 100%;-->
<!--}-->

<!--.el-dialog {-->
<!--  height: 730px !important; /* 设置具体高度 */-->
<!--}-->

<!--.el-form-item {-->
<!--  margin-bottom: 8px !important; /* 减小默认的底部外边距 */-->
<!--}-->

<!--.el-dialog__body {-->
<!--  padding-top: 10px !important;-->
<!--  padding-left: 30px;-->
<!--  overflow-y: auto;-->
<!--}-->

<!--.el-dialog__body .el-form {-->
<!--  display: flex;-->
<!--  flex-direction: column;-->
<!--  align-items: flex-start; /* 左对齐 */-->
<!--}-->
<!--</style>-->


<template>
  <div id="app">
    <!-- 表单 -->
    <el-form :inline="true" :model="searchForm" class="demo-form-inline">
      <el-form-item label="">
        <el-input
            v-model="searchForm.stuName"
            placeholder="学生名称"
        ></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input
            v-model="searchForm.courseName"
            placeholder="课程名称"
        ></el-input>
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

      <!-- 状态列 -->
      <el-table-column label="状态" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.status }}</span>
        </template>
      </el-table-column>

      <!-- 操作列 -->
      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <el-button
              v-if="scope.row.status === '已选课'"
              type="danger"
              size="small"
              @click="handleDropCourse(scope.row)"
          >
            退课
          </el-button>
          <el-button
              v-else
              type="primary"
              size="small"
              @click="handleEnrollCourse(scope.row)"
          >
            选课
          </el-button>
        </template>
      </el-table-column>
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

      searchForm: {
        stuName: "",
        courseName: "",
      },
    };
  },

  methods: {
    // 找对应 major name 显示在表中
    getMajorName(id) {
      return (
          this.majorTable.find((major) => major.id === id)?.name || "Unknown"
      );
    },



    // 查询
    onSearchSubmit: function () {
      axios
          .get("http://localhost:8080/enrollment", {
            params: {
              stuName: this.searchForm.stuName,
              courseName: this.searchForm.courseName,
            },
          })
          .then((response) => {
            if (response.data && response.data.data) {
              this.enrollmentTable = response.data.data;
            } else {
              this.enrollmentTable = [];
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            this.enrollmentTable = [];
            this.$message.error("查询失败，请检查网络或后端服务");
          });
    },
    // 清空查询
    deleteSearch() {
      this.searchForm.stuName = "";
      this.searchForm.courseName = "";
      this.fetchData();
    },

    fetchData() {
      axios
          .get("http://localhost:8080/enrollment")
          .then((response) => {
            if (response.data && response.data.data) {
              this.enrollmentTable = response.data.data;
            } else {
              this.enrollmentTable = [];
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            this.enrollmentTable = [];
            this.$message.error("加载数据失败，请检查网络或后端服务");
          });
    },

    // 处理退课
    handleDropCourse(row) {
      axios
          .post("http://localhost:8080/enrollment/deleteByAdmin", {
            stuName: row.stuName,
            courseName: row.courseName,
          })
          .then((response) => {
            if (response.data.msg==="success") {
              this.$message.success("退课成功");
              row.status = "未选课"; // 更新状态
              this.onSearchSubmit(); // 刷新表格数据
            } else {
              this.$message.error("退课失败");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            this.$message.error("退课失败，请检查网络或后端服务");
          });
    },

    // 处理选课
    handleEnrollCourse(row) {
      axios
          .post("http://localhost:8080/enrollment/insertByAdmin", {
            stuName: row.stuName,
            courseName: row.courseName,
          })
          .then((response) => {
            if (response.data.msg==="success") {
              this.$message.success("选课成功");
              row.status = "已选课"; // 更新状态
              this.onSearchSubmit(); // 刷新表格数据
            } else {
              this.$message.error("选课失败");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            this.$message.error("选课失败");
          });
    },
  },
  mounted() {
    // 获取 major 表
    axios
        .get("http://localhost:8080/major")
        .then((response) => {
          if (response.data && response.data.data) {
            this.majorTable = response.data.data;
          } else {
            this.majorTable = [];
          }
        })
        .catch((error) => {
          console.error("Error:", error);
          this.majorTable = [];
          this.$message.error("加载专业数据失败，请检查网络或后端服务");
        });

    // 获取 enrollmentJoin 表
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