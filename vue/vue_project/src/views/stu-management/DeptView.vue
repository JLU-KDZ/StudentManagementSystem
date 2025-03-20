<template>
  <div id="app">
    <br />

    <!-- 新增学院 -->
    <el-button type="primary" @click="addFormVisible = true"
      >新增学院</el-button
    >
    <el-dialog title="保存学院" :visible.sync="addFormVisible">
      <el-form ref="addForm" :model="addForm" label-width="80px">
        <el-form-item label="学院名称">
          <el-input v-model="addForm.name"></el-input>
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
    <el-table :data="deptTable" border>
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
          ><el-dialog title="修改学院" :visible.sync="updateFormVisible">
            <el-form ref="updateForm" :model="updateForm" label-width="80px">
              <el-form-item label="学院名称">
                <el-input v-model="inputedName"></el-input>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="onUpdateSubmit"
                  >提交</el-button
                >
                <el-button @click="handleUpdateCancel">取消</el-button>
              </el-form-item>
            </el-form>
          </el-dialog>
          <el-button type="danger" size="mini" @click="deleteDept(scope.row.id)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import axios from "@/utils/axiosConfig"; // 导入你上面创建的实例
// import SideMenu from "./components/SideMenu.vue";

export default {
  // components: {
  //   SideMenu,
  // },
  data() {
    return {
      deptTable: [],
      addFormVisible: false,
      updateFormVisible: false,
      addForm: {
        name: "",
      },
      inputedName: "",
      updateForm: {
        name: "",
      },
    };
  },
  methods: {
    //新增学院 提交
    onAddSubmit() {
      try {
        if (this.addForm.name != "") {
          /*try {
            // 调用后端 API 保存新行
            axios.post("http://localhost:8080/depts", this.addForm);
            const now = moment(); // 假设后端返回新的 ID

            // 更新前端数据模型，添加新行
            this.deptTable.push({ ...this.addForm, updateTime: now.format('YYYY-MM-DDTHH:mm:ss')});

            // 清空表单
            this.addForm = { name: ""};
          } catch (error) {
            console.error("Error adding row:", error);
          }
            */
          axios({
            url: "http://localhost:8080/depts",
            method: "POST",
            data: this.addForm,
          }).then((result) => {
            console.log(result);
            if (result.data.msg != "success") {
              this.$message.error("对不起，操作失败，请联系管理员");
            } else {
              //成功消息
              this.$message({
                message: "恭喜你，成功插入学院",
                type: "success",
              });
            }
            //添加成功后渲染列表
            axios
              .get("http://localhost:8080/depts")
              .then((result) => {
                this.deptTable = result.data.data;
              })
              .catch((error) => console.error("Error:", error));
          });
        } else {
          //没插入 失败消息
          this.$message.error("错了哦，你没有添加任何数据");
        }
      } catch (e) {
        console.error("捕获到错误：", e);
      }

      this.addFormVisible = false;
    },

    //新增学院 取消
    handleAddCancel() {
      this.addFormVisible = false;
    },

    //根据id查询（点击编辑）

    getById(id) {
      axios
        .get(`http://localhost:8080/depts/${id}`)
        .then((result) => {
          console.log(result);
          this.updateForm = result.data.data;
          this.inputedName = this.updateForm.name;
        })
        .catch((error) => console.error("Error:", error));
    },

    //修改提交按钮 （编辑提交）
    onUpdateSubmit() {
      const oldName = this.updateForm.name;
      this.updateForm.name = this.inputedName;
      axios
        .put("http://localhost:8080/depts", this.updateForm)
        .then((result) => {
          console.log(result);
          //修改成功后渲染列表
          axios
            .get("http://localhost:8080/depts")
            .then((result) => {
              this.deptTable = result.data.data;
              //提示
              if (oldName == this.updateForm.name) {
                //提示没改
                this.$message({
                  type: "info",
                  message: "你没有修改任何数据",
                });
              } else {
                //提示修改成功
                this.$message({
                  message: "恭喜你，成功修改学院",
                  type: "success",
                });
              }
            })
            .catch((error) => console.error("Error:", error));
        })
        .catch((error) => console.error("Error:", error));

      //关闭窗口
      this.updateFormVisible = false;
    },

    //修改取消按钮 （编辑取消）
    handleUpdateCancel() {
      this.updateFormVisible = false;
    },

    //序列
    indexMethod(index) {
      return index + 1;
    },

    //删除  （删除）
    deleteDept(id) {
      this.$confirm("此操作将永久删除数据, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          try {
            //调用后端api删除数据 （删除确定）
            axios.delete(`http://localhost:8080/depts/${id}`).then((result) => {
              console.log(result);
              //删除成功后渲染列表
              axios
                .get("http://localhost:8080/depts")
                .then((result) => {
                  this.deptTable = result.data.data;
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
  },

  mounted() {
    //发送异步请求,获取数据
    axios
      .get("http://localhost:8080/depts")
      .then((result) => {
        console.log(result);
        this.deptTable = result.data.data;
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
  height: 250px !important; /* 设置具体高度 */
}

.el-dialog__body .el-form {
  display: flex;
  flex-direction: column;
  align-items: flex-start; /* 左对齐 */
}
</style>