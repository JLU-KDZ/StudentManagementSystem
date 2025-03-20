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

    <!-- 新增课程 -->
    <el-button type="primary" @click="emptyForm">新增课程</el-button>
    <el-dialog title="保存课程" :visible.sync="addFormVisible" width="27%">
      <el-form ref="addForm" :model="addForm" label-width="80px">
        <el-form-item label="课程名称">
          <el-input v-model="addForm.name"></el-input>
        </el-form-item>
        <el-form-item label="教授老师">
          <el-select
            v-model="addForm.teacherId"
            placeholder="输入老师"
            filterable
            remote
            :remote-method="searchNames"
            :loading="loading"
            clearable
          >
            <el-option
              v-for="item in filteredNames"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="介绍">
          <el-input v-model="addForm.description"></el-input>
        </el-form-item>
        <el-form-item label="开课人数">
          <el-input v-model="addForm.stuNumber"></el-input>
        </el-form-item>
        <el-form-item label="满课人数">
          <el-input v-model="addForm.maxNumber"></el-input>
        </el-form-item>
        <el-form-item label="专业">
          <el-select v-model="addForm.majorId" placeholder="选择专业">
            <el-option
              v-for="item in majorTable"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="学分">
          <el-input v-model="addForm.credit"></el-input>
        </el-form-item>
        <el-form-item label="上课时段">
          <el-select v-model="addForm.time" placeholder="选择时段">
            <el-option
              v-for="item in timeLookup"
              :key="item.id"
              :label="item.desp"
              :value="item.desp"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="上课地点">
          <el-select v-model="addForm.location" placeholder="选择地点">
            <el-option
              v-for="item in locationLookup"
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
          <el-button @click="handleAddCancel" size="small">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

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
          <el-button
            type="primary"
            size="mini"
            @click="
              getById(scope.row.id);
              updateFormVisible = true;
            "
            >编辑</el-button
          ><el-dialog
            title="修改课程"
            :visible.sync="updateFormVisible"
            width="27%"
          >
            <el-form ref="updateForm" :model="updateForm" label-width="80px">
              <el-form-item label="课程名称">
                <el-input v-model="inputedName"></el-input>
              </el-form-item>
              <el-form-item label="教授老师">
                <el-select v-model="selectedTeacherId" placeholder="选择老师">
                  <el-option
                    v-for="item in teacherTable"
                    :key="item.id"
                    :label="item.name"
                    :value="item.id"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="介绍">
                <el-input v-model="inputedDescription"></el-input>
              </el-form-item>
              <el-form-item label="开课人数">
                <el-input v-model="inputedStuNumber"></el-input>
              </el-form-item>
              <el-form-item label="满课人数">
                <el-input v-model="inputedMaxNumber"></el-input>
              </el-form-item>
              <el-form-item label="专业">
                <el-select v-model="selectedMajorId" placeholder="选择专业">
                  <el-option
                    v-for="item in majorTable"
                    :key="item.id"
                    :label="item.name"
                    :value="item.id"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="学分">
                <el-input v-model="inputedCredit"></el-input>
              </el-form-item>
              <el-form-item label="上课时段">
                <el-select v-model="selectedTime" placeholder="选择时段">
                  <el-option
                    v-for="item in timeLookup"
                    :key="item.id"
                    :label="item.desp"
                    :value="item.desp"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="上课地点">
                <el-select v-model="selectedLocation" placeholder="选择地点">
                  <el-option
                    v-for="item in locationLookup"
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
                <el-button @click="handleUpdateCancel" size="small"
                  >取消</el-button
                >
              </el-form-item>
            </el-form>
          </el-dialog>

          <el-button
            type="danger"
            size="mini"
            @click="deleteCourse(scope.row.id)"
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
      courseTable: [],
      teacherTable: [],
      filteredNames: [],
      loading: false,
      smmLookup: [],
      majorTable: [],
      addFormVisible: false,
      updateFormVisible: false,
      addForm: {
        name: "",
        teacherId: null,
        description: "",
        stuNumber: null,
        maxNumber: null,
        majorId: null,
        credit: null,
        time: "",
        location: "",
      },
      inputedName: "",
      selectedTeacherId: null,
      inputedDescription: "",
      inputedStuNumber: null,
      inputedMaxNumber: null,
      selectedMajorId: null,
      inputedCredit: null,
      selectedTime: "",
      selectedLocation: "",
      updateForm: {
        name: "",
        teacherId: null,
        description: "",
        stuNumber: null,
        maxNumber: null,
        majorId: null,
        credit: null,
        time: "",
        location: "",
      },

      currentPage: 1, // 当前页
      pageSize: 5, // 每页显示的记录数
      total: 0, // 总记录数
      searchForm: {
        name: "",
      },
    };
  },

  computed: {
    // 计算属性，返回只包含 type 为 "time" 的 lookup
    timeLookup() {
      return this.smmLookup.filter((item) => item.type === "time");
    },
    locationLookup() {
      return this.smmLookup.filter((item) => item.type === "location");
    },
  },

  methods: {
    //老师input
    searchNames(query) {
      this.loading = true;
      setTimeout(() => {
        this.filteredNames = this.teacherTable.filter((item) => {
          return item.name.toLowerCase().includes(query.toLowerCase());
        });
        this.loading = false;
      }, 200); // 模拟延迟加载
    },
    //新增课程 清空表单
    emptyForm() {
      this.addFormVisible = true;
      this.addForm.name = "";
      this.addForm.teacherId = null;
      this.addForm.description = "";
      this.addForm.stuNumber = null;
      this.addForm.maxNumber = null;
      this.addForm.majorId = null;
      this.addForm.credit = null;
      this.addForm.time = "";
      this.addForm.location = "";
    },

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

    //新增课程 提交
    onAddSubmit() {
      this.addForm.stuNumber = Number(this.addForm.stuNumber);
      this.addForm.maxNumber = Number(this.addForm.maxNumber);
      this.addForm.credit = Number(this.addForm.credit);
      try {
        if (this.addForm.name != "" && this.addForm.majorId != null) {
          axios({
            url: "http://localhost:8080/course",
            method: "POST",
            data: this.addForm,
          }).then((result) => {
            console.log(result);
            if (result.data.msg != "success") {
              this.$message.error("对不起，操作失败，请联系管理员");
            } else {
              //成功消息
              this.$message({
                message: "恭喜你，成功插入课程",
                type: "success",
              });
            }
            //添加成功后渲染列表
            this.fetchData();
          });
        } else {
          //没插入 失败消息
          this.$message.error("错了哦，你必须添加课程名称、专业");
        }
      } catch (e) {
        console.error("捕获到错误：", e);
      }

      this.addFormVisible = false;
    },

    //新增课程 取消
    handleAddCancel() {
      this.addFormVisible = false;
    },

    //编辑
    getById(id) {
      axios
        .get(`http://localhost:8080/course/${id}`)
        .then((result) => {
          console.log(result);
          this.updateForm = result.data.data;
          //课程预选
          this.inputedName = this.updateForm.name;
          this.selectedTeacherId = this.updateForm.teacherId;
          this.inputedDescription = this.updateForm.description;
          this.inputedStuNumber = this.updateForm.stuNumber;
          this.inputedMaxNumber = this.updateForm.maxNumber;
          this.selectedMajorId = this.updateForm.majorId;
          this.inputedCredit = this.updateForm.credit;
          this.selectedTime = this.updateForm.time;
          this.selectedLocation = this.updateForm.location;
        })
        .catch((error) => console.error("Error:", error));
    },

    //编辑 提交
    onUpdateSubmit() {
      const oldName = this.updateForm.name;
      const oldTeacherId = this.updateForm.teacherId;
      const oldDescription = this.updateForm.description;
      const oldStuNumber = this.updateForm.stuNumber;
      const oldMaxNumber = this.updateForm.maxNumber;
      const oldMajorId = this.updateForm.majorId;
      const oldCredit = this.updateForm.credit;
      const oldTime = this.updateForm.time;
      const oldLocation = this.updateForm.location;
      this.updateForm.name = this.inputedName;
      this.updateForm.teacherId = this.selectedTeacherId;
      this.updateForm.description = this.inputedDescription;
      this.updateForm.stuNumber = this.inputedStuNumber;
      this.updateForm.maxNumber = this.inputedMaxNumber;
      this.updateForm.majorId = this.selectedMajorId;
      this.updateForm.credit = this.inputedCredit;
      this.updateForm.time = this.selectedTime;
      this.updateForm.location = this.selectedLocation;
      axios
        .put("http://localhost:8080/course", this.updateForm)
        .then((result) => {
          console.log(result);

          //修改成功后渲染列表
          this.fetchData();
          //提示
          if (
            oldName == this.updateForm.name &&
            oldTeacherId == this.updateForm.teacherId &&
            oldDescription == this.updateForm.description &&
            oldStuNumber == this.updateForm.stuNumber &&
            oldMaxNumber == this.updateForm.maxNumber &&
            oldMajorId == this.updateForm.majorId &&
            oldCredit == this.updateForm.credit &&
            oldTime == this.updateForm.time &&
            oldLocation == this.updateForm.location
          ) {
            //提示没改
            this.$message({
              type: "info",
              message: "你没有修改任何数据",
            });
          } else {
            //提示修改成功
            this.$message({
              message: "恭喜你，成功修改课程",
              type: "success",
            });
          }
        })
        .catch((error) => console.error("Error:", error));
      //关闭窗口
      this.updateFormVisible = false;
    },

    //编辑 取消
    handleUpdateCancel() {
      this.updateFormVisible = false;
    },

    //删除
    deleteCourse(id) {
      this.$confirm("此操作将永久删除数据, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          try {
            //调用后端api删除数据 （删除确定）
            axios
              .delete(`http://localhost:8080/course/${id}`)
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
    //smmLookup表
    axios
      .get("http://localhost:8080/lookup")
      .then((result) => {
        console.log(result);
        this.smmLookup = result.data.data;
      })
      .catch((error) => console.error("Error:", error));

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