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
    <!-- 批量删除 -->
    <el-button type="danger" @click="deleteStus()">批量删除</el-button>

    <!-- 新增学生 -->
    <el-button type="primary" @click="emptyForm">新增学生</el-button>
    <el-dialog title="保存学生" :visible.sync="addFormVisible" width="27%">
      <el-form ref="addForm" :model="addForm" label-width="80px">
        <el-form-item label="用户名">
          <el-input v-model="addForm.username" placeholder="必须以1开头 (非空)"></el-input>
        </el-form-item>
        <el-form-item label="学号">
          <el-input v-model="addForm.stuId" placeholder="(非空)"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="addForm.name" placeholder="(非空)"></el-input>
        </el-form-item>
        <el-form-item label="图像">
          <el-upload
            class="avatar-uploader"
            action="http://localhost:8080/upload"
            :http-request="handleUpload1"
            :show-file-list="false"
            :file-list="fileList"
            :before-upload="beforeAvatarUpload"
          >
            <img v-if="addForm.image" :src="addForm.image" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="性别">
          <el-select v-model="addForm.gender" placeholder="选择性别">
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
          <el-select v-model="addForm.grade" placeholder="选择年级">
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
          <el-input v-model="addForm.phonenumber" placeholder="电话"></el-input>
        </el-form-item>
        <el-form-item label="所属学院">
          <el-select v-model="addForm.dept2Id" placeholder="选择学院">
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
          <el-select v-model="addForm.classId" placeholder="选择班级">
            <el-option
              v-for="item in classInfo1"
              :key="item.classId"
              :label="item.className"
              :value="item.classId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="入学日期" prop="entrydate">
          <el-date-picker
            v-model="addForm.entrydate"
            type="date"
            placeholder="选择日期 (默认为今天)"
            format="yyyy-MM-dd"
            value-format="yyyy-MM-dd"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onAddSubmit" size="small"
            >提交</el-button
          >
          <el-button @click="addFormVisible = false" size="small"
            >取消</el-button
          >
        </el-form-item>
      </el-form>
    </el-dialog>

    <br />
    <br />

    <!-- 表格 -->

    <el-table
      :data="stuTable"
      @selection-change="handleSelectionChange"
      height="615px"
    >
      <el-table-column type="selection" width="55"></el-table-column>
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
      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <!-- 修改学生 -->
          <el-button
            type="primary"
            size="mini"
            @click="
              getById(scope.row.id);
              updateFormVisible = true;
            "
            >编辑</el-button
          >
          <el-dialog
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
                <el-select
                  v-model="selectedGender"
                  placeholder="选择性别 (非空)"
                >
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
                  placeholder="选择日期 (默认为今天)"
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
          <el-button type="danger" size="mini" @click="deleteStu(scope.row.id)"
            >删除</el-button
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
      stuTable: [],
      deptTable: [],
      classTable: [],
      classInfoTable: [],
      smmLookup: [],
      addFormVisible: false,
      updateFormVisible: false,
      currentPage: 1, // 当前页
      pageSize: 5, // 每页显示的记录数
      total: 0, // 总记录数
      searchForm: {
        name: '',
        stuId: null,
        entrydate: [],
      },
      multipleSelection: [],

      addForm: {
        username: "",
        stuId:"",
        name: "",
        image: "", //图像url
        gender: null,
        grade: null,
        phonenumber:"",
        dept2Id: null,
        classId: null,
        entrydate: "",
      },

      inputedUsername: "",
      inputedStuId:"",
      inputedName: "",
      inputedImage: "",
      selectedGender: null,
      selectedGrade: null,
      inputedPhone:"",
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
    //转换为整数类型
    // watch: {
    //   "addForm.gender": function (newVal) {
    //     this.addForm.gender = Number(newVal);
    //   },
    //   "addForm.grade": function (newVal) {
    //     this.addForm.grade = Number(newVal);
    //   },
    // },

    //新增学生 清空表单
    emptyForm() {
      this.addFormVisible = true;
      this.addForm.username = "";
      this.addForm.stuId = "";
      this.addForm.name = "";
      this.addForm.image = "";
      this.addForm.gender = null;
      this.addForm.grade = null;
      this.addForm.phonenumber = "";
      this.addForm.dept2Id = null;
      this.addForm.classId = null;
      this.addForm.entrydate = "";
    },
    //新增学生 提交
    onAddSubmit() {
      this.addForm.gender = Number(this.addForm.gender);
      this.addForm.grade = Number(this.addForm.grade);
      console.log(this.addForm);
      try {
        if (
          this.addForm.username != "" &&
          this.addForm.name != "" &&
          this.addForm.stuId != ""
        ) {
          axios({
            url: "http://localhost:8080/stus",
            method: "POST",
            data: this.addForm,
          }).then((result) => {
            console.log(result);
            if (result.data.msg != "success") {
              this.$message.error("对不起，操作失败，请联系管理员");
            } else {
              //成功消息
              this.$message({
                message: "恭喜你，成功插入学生",
                type: "success",
              });
            }
            //添加成功后渲染列表
            this.fetchData();
          });
          this.addFormVisible = false;
        } else {
          //没插入 失败消息
          this.$message.error("错了哦，你必须添加用户名、姓名、学号");
          this.addFormVisible = false;
        }
      } catch (e) {
        console.error("捕获到错误：", e);
      }
    },

    //编辑
    getById(id) {
      axios
        .get(`http://localhost:8080/stus/${id}`)
        .then((result) => {
          console.log(result);
          this.updateForm = result.data.data;
          console.log(this.getDeptId2);
          //学生预选
          this.inputedUsername = this.updateForm.username;
          this.inputedStuId = this.updateForm.stuId;
          this.inputedName = this.updateForm.name;
          this.inputedImage = this.updateForm.image;
          this.selectedGender = this.updateForm.gender;
          this.selectedGrade = this.updateForm.grade;
          this.inputedPhone = this.updateForm.phonenumber;
          console.log(this.getDeptId2);
          console.log(this.classInfo2);
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
      const oldStuId= this.updateForm.stuId;
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
        .put("http://localhost:8080/stus", this.updateForm)
        .then((result) => {
          console.log(result);

          //修改成功后渲染列表
          this.fetchData();
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
      console.log(this.searchForm.name);
      console.log(this.searchForm.stuId);
      console.log(this.formatDate(this.searchForm.entrydate[0]));
      console.log(this.formatDate(this.searchForm.entrydate[1]));
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
    //批量删除
    deleteStus() {
      // 获取所有选中行的 ID
      const idsToDelete = this.multipleSelection.map((row) => row.id);
      //转成字符串形式
      const idsString = idsToDelete.join(",");
      //用户没选数据情况
      if (this.multipleSelection.length === 0) {
        this.$message({
          type: "info",
          message: "你没有选中任何数据",
        });
        return;
      }

      this.$confirm("此操作将永久删除选中数据, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          try {
            //调用后端api删除数据 （删除确定）
            axios
              .delete(`http://localhost:8080/stus/${idsString}`)
              .then((result) => {
                console.log(result);
                //删除成功后渲染列表
                this.fetchData();
              });
          } catch (error) {
            console.error("Error deleting row:", error);
          }
          //提示删除成功
          this.$message({
            type: "success",
            message: "删除成功!",
          });
        })
        .catch(() => {
          //提示删除取消 （删除取消）
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },

    //删除单个
    deleteStu(id) {
      this.$confirm("此操作将永久删除数据, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          try {
            //调用后端api删除数据 （删除确定）
            axios.delete(`http://localhost:8080/stus/${id}`).then((result) => {
              console.log(result);
              //删除成功后渲染列表
              this.fetchData();
            });
          } catch (error) {
            console.error("Error deleting row:", error);
          }
          //提示删除成功
          this.$message({
            type: "success",
            message: "删除成功!",
          });
        })
        .catch(() => {
          //提示删除取消 （删除取消）
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },

    //勾选框
    handleSelectionChange(val) {
      this.multipleSelection = val;
      console.log(this.multipleSelection);
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