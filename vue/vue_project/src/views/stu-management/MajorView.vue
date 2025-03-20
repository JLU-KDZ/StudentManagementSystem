<template>
  <div id="app">
    <!-- 新增专业 -->
    <el-button type="primary" @click="addFormVisible = true"
      >新增专业</el-button
    >
    <el-dialog title="保存专业" :visible.sync="addFormVisible">
      <el-form ref="addForm" :model="addForm" label-width="80px">
        <el-form-item label="专业名称">
          <el-input v-model="addForm.name"></el-input>
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
        <el-form-item>
          <el-button type="primary" @click="onAddSubmit">提交</el-button>
          <el-button @click="handleAddCancel">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <br />
    <br />
    <!-- 表格 -->
    <el-table :data="majorTable" border>
      <el-table-column
        type="index"
        :index="indexMethod"
        label="序列"
        align="center"
        width="65"
      ></el-table-column>

      <el-table-column
        prop="name"
        label="名称"
        width="250"
        align="center"
      ></el-table-column>

      <el-table-column label="所属学院" width="250" align="center"
        ><template slot-scope="scope">
          <!-- 在这里使用计算属性或方法来显示部门名称 -->
          {{ getDeptName(scope.row.dept2Id) }}
        </template>
      </el-table-column>

      <el-table-column
        prop="updateTime"
        label="最后操作时间"
        width="250"
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
          ><el-dialog title="修改专业" :visible.sync="updateFormVisible">
            <el-form ref="updateForm" :model="updateForm" label-width="80px">
              <el-form-item label="专业名称">
                <el-input v-model="inputedName"></el-input>
              </el-form-item>
              <el-form-item label="所属学院">
                <el-select v-model="selectedDeptId" placeholder="选择学院">
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
                <el-button type="primary" @click="onUpdateSubmit"
                  >提交</el-button
                >
                <el-button @click="handleUpdateCancel">取消</el-button>
              </el-form-item>
            </el-form>
          </el-dialog>

          <el-button
            type="danger"
            size="mini"
            @click="deleteMajor(scope.row.id)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>
  
  <script>
import axios from "@/utils/axiosConfig"; // 导入你上面创建的实例

export default {
  data() {
    return {
      majorTable: [],
      deptTable: [],
      addFormVisible: false,
      updateFormVisible: false,
      addForm: {
        name: "",
        dept2Id: null,
      },
      selectedDeptId: null,
      inputedName: "",
      updateForm: {
        name: "",
        dept2Id: null,
      },
    };
  },

  methods: {
    //找对应dept name 显示在class表中
    getDeptName(id) {
      return this.deptTable.find((dept) => dept.id === id)?.name || "Unknown";
    },

    //新增专业 提交
    onAddSubmit() {
      // console.log(this.addForm.name);
      // console.log(this.addForm.dept2Id);
      try {
        if (this.addForm.name != "" && this.addForm.dept2Id != null) {
          axios({
            url: "http://localhost:8080/major",
            method: "POST",
            data: this.addForm,
          }).then((result) => {
            console.log(result);
            if (result.data.msg != "success") {
              this.$message.error("对不起，操作失败，请联系管理员");
            } else {
              //成功消息
              this.$message({
                message: "恭喜你，成功插入专业",
                type: "success",
              });
            }
            //添加成功后渲染列表
            axios
              .get("http://localhost:8080/major")
              .then((result) => {
                this.majorTable = result.data.data;
              })
              .catch((error) => console.error("Error:", error));
          });
        } else {
          //没插入 失败消息
          this.$message.error("错了哦，你必须添加专业名称、所属学院");
        }
      } catch (e) {
        console.error("捕获到错误：", e);
      }

      this.addFormVisible = false;
    },

    //新增专业 取消
    handleAddCancel() {
      this.addFormVisible = false;
    },

    //编辑
    getById(id) {
      axios
        .get(`http://localhost:8080/major/${id}`)
        .then((result) => {
          console.log(result);
          this.updateForm = result.data.data;
          //学院预选
          this.inputedName = this.updateForm.name;
          this.selectedDeptId = this.updateForm.dept2Id;
        })
        .catch((error) => console.error("Error:", error));
    },

    //编辑 提交
    onUpdateSubmit() {
      const oldName = this.updateForm.name;
      const oldDeptId = this.updateForm.dept2Id;
      this.updateForm.name = this.inputedName;
      this.updateForm.dept2Id = this.selectedDeptId;
      axios
        .put("http://localhost:8080/major", this.updateForm)
        .then((result) => {
          console.log(result);

          //修改成功后渲染列表
          axios
            .get("http://localhost:8080/major")
            .then((result) => {
              this.majorTable = result.data.data;
            })
            .catch((error) => console.error("Error:", error));
          //提示
          if (
            oldName == this.updateForm.name &&
            oldDeptId == this.updateForm.dept2Id
          ) {
            //提示没改
            this.$message({
              type: "info",
              message: "你没有修改任何数据",
            });
          } else {
            //提示修改成功
            this.$message({
              message: "恭喜你，成功修改专业",
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
    deleteMajor(id) {
      this.$confirm("此操作将永久删除数据, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          try {
            //调用后端api删除数据 （删除确定）
            axios.delete(`http://localhost:8080/major/${id}`).then((result) => {
              console.log(result);
              //删除成功后渲染列表
              axios
                .get("http://localhost:8080/major")
                .then((result) => {
                  this.majorTable = result.data.data;
                })
                .catch((error) => console.error("Error:", error));
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

    //序列
    indexMethod(index) {
      return index + 1;
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
    //major表
    axios
      .get("http://localhost:8080/major")
      .then((result) => {
        console.log(result);
        this.majorTable = result.data.data;
      })
      .catch((error) => console.error("Error:", error));
  },
};
</script>
  
  <style scoped>
.el-input {
  width: 400px !important;
  height: 40px !important; /* 自定义高度 */
}

.el-input__inner {
  height: 40px !important; /* 自定义内部输入框的高度 */
  line-height: 40px !important; /* 保持文字垂直居中 */
  width: 100%;
}

.el-form-item {
  margin-bottom: 20px !important; /* 减小默认的底部外边距 */
}

.el-dialog {
  height: 300px !important; /* 设置具体高度 */
}

.el-dialog__body .el-form {
  display: flex;
  flex-direction: column;
  align-items: flex-start; /* 左对齐 */
}
</style>