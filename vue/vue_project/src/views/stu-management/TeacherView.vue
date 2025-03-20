<template>
  <div>
    <!-- 表单 -->
    <el-form :inline="true" :model="searchForm" class="demo-form-inline">
      <el-form-item label="姓名">
        <el-input v-model="searchForm.name" placeholder="姓名"></el-input>
      </el-form-item>

      <el-form-item label="所在学院">
        <el-select v-model="searchForm.dept2Id" placeholder="选择学院">
          <el-option
            v-for="item in deptTable"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          >
          </el-option>
        </el-select>
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

    <!-- 新增教师 -->
    <el-button type="primary" @click="emptyForm">新增教师</el-button>
    <el-dialog title="保存教师" :visible.sync="addFormVisible" width="27%">
      <el-form ref="addForm" :model="addForm" label-width="80px">
        <el-form-item label="用户名">
          <el-input v-model="addForm.username" placeholder="(非空)"></el-input>
        </el-form-item>

        <el-form-item label="姓名">
          <el-input v-model="addForm.name" placeholder="(非空)"></el-input>
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

        <el-form-item label="年龄">
          <el-input v-model="addForm.age" placeholder="年龄"></el-input>
        </el-form-item>

        <el-form-item label="所在学院">
          <el-select v-model="addForm.dept2Id" placeholder="选择学院（非空）">
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
          <el-input v-model="addForm.phoneNumber" placeholder="电话"></el-input>
        </el-form-item>

        <el-form-item label="邮箱">
          <el-input v-model="addForm.email" placeholder="邮箱"></el-input>
        </el-form-item>

        <el-form-item label="办公室">
          <el-select v-model="addForm.office" placeholder="选择办公室">
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

    <el-table :data="teacherTable" height="615px">
      <el-table-column
        prop="name"
        label="姓名"
        width="120px"
        align="center"
      ></el-table-column>

      <el-table-column label="性别" width="120px" align="center">
        <template slot-scope="scope">
          {{
            scope.row.gender === 1
              ? "男"
              : scope.row.gender === null ||
                scope.row.gender === undefined ||
                scope.row.gender === 0
              ? "Unknow"
              : "女"
          }}
        </template>
      </el-table-column>

      <el-table-column
        prop="age"
        label="年龄"
        width="120px"
        align="center"
      ></el-table-column>

      <el-table-column prop="dept2Id" label="所在学院" align="center">
        <template slot-scope="scope">
          <!-- 在这里使用计算属性或方法来显示部门名称 -->
          {{ getDeptName(scope.row.dept2Id) }}
        </template></el-table-column
      >

      <el-table-column
        prop="phoneNumber"
        label="电话"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="email"
        label="邮箱"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="office"
        label="办公室"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="updateTime"
        label="最后操作时间"
        align="center"
      ></el-table-column>

      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <!-- 修改教师 -->
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
            title="修改教师"
            :visible.sync="updateFormVisible"
            width="27%"
          >
            <el-form ref="updateForm" :model="updateForm" label-width="80px">
              <el-form-item label="用户名">
                <el-input
                  v-model="inputedUsername"
                  placeholder="(非空)"
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

              <el-form-item label="所在学院">
                <el-select v-model="selectedDept" placeholder="选择学院（非空）">
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

              <el-form-item label="邮箱">
                <el-input v-model="inputedEmail" placeholder="邮箱"></el-input>
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
          <el-button
            type="danger"
            size="mini"
            @click="deleteTeacher(scope.row.id)"
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
      :page-sizes="[10, 20, 30, 40]"
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
      teacherTable: [],
      deptTable: [],
      smmLookup: [],
      addFormVisible: false,
      updateFormVisible: false,

      currentPage: 1, // 当前页
      pageSize: 10, // 每页显示的记录数
      total: 0, // 总记录数
      searchForm: {
        name: "",
        dept2Id: null,
      },

      addForm: {
        username: "",
        name: "",
        gender: null,
        age: null,
        dept2Id: null,
        phoneNumber: "",
        email: "",
        office: "",
      },

      inputedUsername: "",
      inputedName: "",
      selectedGender: null,
      inputedAge: null,
      selectedDept: null,
      inputedPhone: "",
      inputedEmail: "",
      selectedOffice: "",
      updateForm: {
        username: "",
        name: "",
        gender: null,
        age: null,
        dept2Id: null,
        phoneNumber: "",
        email: "",
        office: "",
      },
    };
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
    //新增教师 清空表单
    emptyForm() {
      this.addFormVisible = true;
      this.addForm.username = "";
      this.addForm.name = "";
      this.addForm.gender = null;
      this.addForm.age = null;
      this.addForm.dept2Id = null;
      this.addForm.phoneNumber = "";
      this.addForm.email = "";
      this.addForm.office = "";
    },
    //新增学生 提交
    onAddSubmit() {
      this.addForm.gender = Number(this.addForm.gender);
      this.addForm.age = Number(this.addForm.age);
      console.log(this.addForm);
      try {
        if (
          this.addForm.name != "" &&
          this.addForm.username != "" &&
          this.addForm.dept2Id != null
        ) {
          axios({
            url: "http://localhost:8080/teacher",
            method: "POST",
            data: this.addForm,
          }).then((result) => {
            console.log(result);
            if (result.data.msg != "success") {
              this.$message.error("对不起，操作失败，请联系管理员");
            } else {
              //成功消息
              this.$message({
                message: "恭喜你，成功插入教师",
                type: "success",
              });
            }
            //添加成功后渲染列表
            this.fetchData();
          });
          this.addFormVisible = false;
        } else {
          //没插入 失败消息
          this.$message.error("错了哦，你必须添加姓名、用户名、学院");
          this.addFormVisible = false;
        }
      } catch (e) {
        console.error("捕获到错误：", e);
      }
    },

    //编辑
    getById(id) {
      axios
        .get(`http://localhost:8080/teacher/${id}`)
        .then((result) => {
          this.updateForm = result.data.data;
          //教师预选
          this.inputedUsername = this.updateForm.username;
          this.inputedName = this.updateForm.name;
          this.selectedGender = this.updateForm.gender;
          this.inputedAge = this.updateForm.age;
          this.inputedPhone = this.updateForm.phoneNumber;
          this.selectedDept = this.updateForm.dept2Id;
          this.inputedEmail = this.updateForm.email;
          this.selectedOffice = this.updateForm.office;
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
        .put("http://localhost:8080/teacher", this.updateForm)
        .then((result) => {
          console.log(result);

          //修改成功后渲染列表
          this.fetchData();
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
              message: "恭喜你，成功修改教师",
              type: "success",
            });
          }
        })
        .catch((error) => console.error("Error:", error));
      //关闭窗口
      this.updateFormVisible = false;
    },

    //找对应dept name 显示在teacher表中
    getDeptName(id) {
      return this.deptTable.find((dept) => dept.id === id)?.name || "Unknown";
    },

    //查询
    onSearchSubmit: function () {
      axios
        .get("http://localhost:8080/teacher", {
          params: {
            name: this.searchForm.name,
            dept2Id: this.searchForm.dept2Id,
          },
        })
        .then((result) => {
          console.log(result.data.data.rows.name);
          this.teacherTable = result.data.data.rows;
          this.total = result.data.data.total; // 更新总记录数
        })
        .catch((error) => console.error("Error:", error));
    },
    //清空查询
    deleteSearch() {
      this.searchForm.name = "";
      this.searchForm.dept2Id = null;
      this.fetchData();
    },

    //删除单个
    deleteTeacher(id) {
      this.$confirm("此操作将永久删除数据, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          try {
            //调用后端api删除数据 （删除确定）
            axios
              .delete(`http://localhost:8080/teacher/${id}`)
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

    fetchData(page = this.currentPage, pageSize = this.pageSize) {
      // 发送请求获取分页数据
      axios
        .get("http://localhost:8080/teacher", {
          headers: { "Content-Type": "application/json" },
          params: {
            page,
            pageSize,
          },
        })
        .then((result) => {
          this.teacherTable = result.data.data.rows;
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
    //dept2表
    axios
      .get("http://localhost:8080/depts")
      .then((result) => {
        console.log(result);
        this.deptTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

    //teacher表
    this.fetchData();

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