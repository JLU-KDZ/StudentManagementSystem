<template>
  <div>
    <br />
    <!-- 表格 -->
    <el-table :data="majorTable" border>
      <el-table-column
        type="index"
        :index="indexMethod"
        label="序列"
        align="center"
      ></el-table-column>

      <el-table-column
        prop="name"
        label="名称"
        align="center"
      ></el-table-column>

      <el-table-column label="所属学院" width="250" align="center"
        ><template slot-scope="scope">
          <!-- 在这里使用计算属性或方法来显示部门名称 -->
          {{ getDeptName(scope.row.dept2Id) }}
        </template>
      </el-table-column>

      <el-table-column
        prop="createTime"
        label="创建时间"
        align="center"
      ></el-table-column>
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
      username: "",
    };
  },
  methods: {
    //序列
    indexMethod(index) {
      return index + 1;
    },

    //找对应dept name 显示在class表中
    getDeptName(id) {
      return this.deptTable.find((dept) => dept.id === id)?.name || "Unknown";
    },
  },

  created() {
    this.username = this.$store.getters.currentUser;
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

    //用username找到dept2Id
    axios
      .get("http://localhost:8080/stus/getDept", {
        headers: { "Content-Type": "application/json" },
        params: {
          username: this.username,
        },
      })
      .then((res) => {
        //major表
        axios
          .get("http://localhost:8080/major/deptMajor", {
            headers: { "Content-Type": "application/json" },
            params: {
              dept2Id: res.data.data
            },
          })
          .then((result) => {
            this.majorTable = result.data.data;
          })
          .catch((error) => console.error("Error:", error));

      })
      .catch((error) => console.error("Error:", error));
  },
};
</script>

<style scoped>
</style>