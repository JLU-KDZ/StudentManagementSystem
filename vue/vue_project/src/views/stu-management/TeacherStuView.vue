<template>
    <div>
      <!-- 表单 -->
      <el-form :inline="true" :model="searchForm" class="demo-form-inline">
        <el-form-item label="姓名">
          <el-input v-model="searchForm.name" placeholder="姓名"></el-input>
        </el-form-item>
  
        <el-form-item label="学号">
          <el-input v-model="searchForm.stuId" placeholder="学号"></el-input>
        </el-form-item>
  
        <el-form-item label="入学日期">
          <!-- 日期选择器 -->
          <el-date-picker
            v-model="searchForm.entrydate"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
          >
          </el-date-picker>
        </el-form-item>
  
        <el-form-item>
          <el-button type="primary" size="medium" @click="onSearchSubmit"
            >查询</el-button
          >
          <el-button type="danger" size="medium" @click="deleteSearch"
            >清空</el-button
          >
        </el-form-item>
      </el-form>
      
  
      <br />
  
      <!-- 表格 -->
  
      <el-table
        :data="stuTable"
        height="615px"
      >
        <el-table-column
          prop="stuId"
          label="学号"
          width="120"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="name"
          label="姓名"
          width="100"
          align="center"
        ></el-table-column>
        <el-table-column label="图像" width="110" align="center">
          <template slot-scope="scope">
            <img :src="scope.row.image" width="70px" height="80px" />
          </template>
        </el-table-column>
        <el-table-column label="性别" width="80" align="center">
          <template slot-scope="scope">
            {{
              scope.row.gender === 1
                ? "男"
                : scope.row.gender === null || scope.row.gender === undefined || scope.row.gender === 0
                ? "Unknow"
                : "女"
            }}
          </template>
        </el-table-column>
        <el-table-column prop="grade" label="年级" width="80" align="center">
          <template slot-scope="scope">
            {{ formattedGrade(scope.row.grade) }}
          </template></el-table-column
        >
        <el-table-column
          prop="phonenumber"
          label="电话"
          width="120"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="dept2Id"
          label="所属学院"
          width="120"
          align="center"
        >
          <template slot-scope="scope">
            <!-- 在这里使用计算属性或方法来显示部门名称 -->
            {{ getDeptName(scope.row.dept2Id) }}
          </template></el-table-column
        >
        <el-table-column
          prop="classId"
          label="所属班级"
          width="120"
          align="center"
        >
          <template slot-scope="scope">
            <!-- 在这里使用计算属性或方法来显示部门名称 -->
            {{ getClassName(scope.row.classId) }}
          </template></el-table-column
        >
        <el-table-column
          prop="entrydate"
          label="入学日期"
          width="180"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="updateTime"
          label="最后操作时间"
          width="180"
          align="center"
        ></el-table-column>
        
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
        stuTable: [],
        deptTable: [],
        classTable: [],
        classInfoTable: [],
        smmLookup: [],
        currentPage: 1, // 当前页
        pageSize: 5, // 每页显示的记录数
        total: 0, // 总记录数
        searchForm: {
          name: '',
          stuId: null,
          entrydate: [],
        },

        fileList: [],
      };
    },
    computed: {
      // 计算属性，返回只包含 type 为 "gender" 的 lookup
      genderLookup() {
        return this.smmLookup.filter((item) => item.type === "gender");
      },
      gradeLookup() {
        return this.smmLookup.filter((item) => item.type === "grade");
      },
  
      classInfo1() {
        return this.classInfoTable.filter(
          (item) => item.dept2Id === this.addForm.dept2Id
        );
      },
      classInfo2() {
        return this.classInfoTable.filter(
          (item) => item.dept2Id === this.selectedDept
        );
      },
    },
    methods: {
      
     
  
      //找对应dept name 显示在stu表中
      getDeptName(id) {
        return this.deptTable.find((dept) => dept.id === id)?.name || "Unknown";
      },
  
      //找对应class name 显示在stu表中
      getClassName(id) {
        return (
          this.classTable.find((classItem) => classItem.id === id)?.name ||
          "Unknown"
        );
      },
  
      //查询
      onSearchSubmit: function () {
        axios
          .get("http://localhost:8080/stus", {
            params: {
              name: this.searchForm.name,
              stuId: this.searchForm.stuId,
              begin: this.formatDate(this.searchForm.entrydate[0]),
              end: this.formatDate(this.searchForm.entrydate[1]),
            },
          })
          .then((result) => {
            console.log(result.data.data);
            this.stuTable = result.data.data.rows;
            this.total = result.data.data.total; // 更新总记录数
          })
          .catch((error) => console.error("Error:", error));
      },
      //清空查询
      deleteSearch() {
        this.searchForm.name = "";
        this.searchForm.stuId = "";
        this.searchForm.entrydate = [];
        this.fetchData();
      },
  
      //格式化日期yyyy-mm-dd
      formatDate(date) {
        if (date == undefined) {
          return null;
        } else {
          const year = date.getFullYear();
          const month = String(date.getMonth() + 1).padStart(2, "0");
          const day = String(date.getDate()).padStart(2, "0");
          return `${year}-${month}-${day}`;
        }
      },
  
      //年级
      formattedGrade(grade) {
        switch (grade) {
          case 1:
            return "大一";
          case 2:
            return "大二";
          case 3:
            return "大三";
          case 4:
            return "大四";
          default:
            return "未知年级";
        }
      },
  
      fetchData(page = this.currentPage, pageSize = this.pageSize) {
        // 发送请求获取分页数据
        axios
          .get("http://localhost:8080/stus", {
            headers: { "Content-Type": "application/json" },
            params: {
              page,
              pageSize,
            },
          })
          .then((result) => {
            console.log(result.data.data);
            this.stuTable = result.data.data.rows;
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
  
      //图像
      handleUpload1(param) {
        const form = new FormData();
        form.append("image", param.file); //这里文件名参数为image
        //发送请求到后端
        axios
          .post("http://localhost:8080/upload", form)
          .then((response) => {
            console.log(response.data.data);
            this.addForm.image = response.data.data;
          })
          .catch((error) => {
            console.error(error);
          });
      },
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
      //stu表
      this.fetchData();
  
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
    width: 350px !important;
    height: 40px !important; /* 自定义高度 */
  }
  
  .el-input__inner {
    height: 40px !important; /* 自定义内部输入框的高度 */
    line-height: 40px; /* 保持文字垂直居中 */
    width: 100%;
  }
  
  .el-dialog {
    height: 730px !important; /* 设置具体高度 */
  }
  
  .el-form-item {
    margin-bottom: 10px !important; /* 减小默认的底部外边距 */
  }
  
  
  </style>