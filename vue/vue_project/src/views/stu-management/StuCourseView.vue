<template>
  <div id="app">
    <!-- 表单 -->
    <el-form :inline="true" :model="searchForm" class="demo-form-inline">
      <el-form-item label="">
        <el-input v-model="searchForm.name" placeholder="课程名称"></el-input>
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

      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <el-button type="primary" size="mini" @click="select(scope.row.id)"
            >选课</el-button
          >
          <el-button
            type="danger"
            size="mini"
            @click="deleteSelect(scope.row.id)"
            >取消</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <br />

    <!-- 分页条 -->
    <!-- Pagination 分页 -->
    <el-pagination
      background
      :current-page="currentPage"
      :page-sizes="[5, 10, 15, 20]"
      :page-size="pageSize"
      layout="total,sizes, prev, pager, next, jumper"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :total="total"
    ></el-pagination>
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
      currentPage: 1, // 当前页
      pageSize: 5, // 每页显示的记录数
      total: 0, // 总记录数
      searchForm: {
        name: "",
      },
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

    //选课
    async select(courseId) {
      let flag = null;
      try {
        const response = await axios.get(
          "http://localhost:8080/enrollment/flag",
          {
            params: {
              stuName: localStorage.getItem("stuName"),
              courseId: courseId,
            },
          }
        );
        flag = response.data.data;
        if (flag === 0 ) {
          await axios({
            url: "http://localhost:8080/enrollment",
            method: "POST",
            data: {
              stuName: localStorage.getItem("stuName"),
              courseId: courseId,
            },
          });
          //成功消息
          this.$message({
            message: "选课成功",
            type: "success",
          });
          //删除成功后渲染列表
          this.fetchData();
        } else if (flag === -1) {
          this.$message.error("已满课");
        } else {
          this.$message.error("已选过该课程");
        }
      } catch (error) {
        this.$message.error("对不起，操作失败，请联系管理员");
      }
    },

    //取消
    async deleteSelect(courseId) {
      let flag = null;
      try {
        const response = await axios.get(
          "http://localhost:8080/enrollment/flag",
          {
            params: {
              stuName: localStorage.getItem("stuName"),
              courseId: courseId,
            },
          }
        );
        flag = response.data.data;
        if (flag === 1) {
          await axios({
            url: "http://localhost:8080/enrollment",
            method: "DELETE",
            data: {
              stuName: localStorage.getItem("stuName"),
              courseId: courseId,
            },
          });

          //成功消息
          this.$message({
            message: "已取消选课",
            type: "info",
          });
          //删除成功后渲染列表
          this.fetchData();
        } else {
          this.$message.error("您未选该课程");
        }
      } catch (error) {
        this.$message.error("对不起，操作失败，请联系管理员");
      }
    },

    //查询
    onSearchSubmit: function () {
      axios
        .get("http://localhost:8080/course", {
          params: {
            name: this.searchForm.name,
          },
        })
        .then((result) => {
          console.log(result.data.data);
          this.courseTable = result.data.data.rows;
          this.total = result.data.data.total; // 更新总记录数
        })
        .catch((error) => console.error("Error:", error));
    },
    //清空查询
    deleteSearch() {
      this.searchForm.name = "";
      this.fetchData();
    },

    fetchData(page = this.currentPage, pageSize = this.pageSize) {
      // 发送请求获取分页数据
      axios
        .get("http://localhost:8080/course", {
          headers: { "Content-Type": "application/json" },
          params: {
            page,
            pageSize,
          },
        })
        .then((result) => {
          this.courseTable = result.data.data.rows;
          this.total = result.data.data.total; // 更新总记录数
        })
        .catch((error) => console.error("Error:", error));
    },
    //pageSize
    handleSizeChange: function (val) {
      this.pageSize = val;
      this.fetchData(this.currentPage, val);
    },
    //page
    handleCurrentChange: function (val) {
      this.currentPage = val;
      this.fetchData(val, this.pageSize);
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
        console.log(result);
        this.majorTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

    //course表
    this.fetchData();

    //根据username查stuName
    axios
      .get("http://localhost:8080/stus/getStuName", {
        headers: { "Content-Type": "application/json" },
        params: {
          username: this.username,
        },
      })
      .then((result) => {
        localStorage.setItem("stuName", result.data.data);
      })
      .catch((error) => console.error("Error:", error));
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