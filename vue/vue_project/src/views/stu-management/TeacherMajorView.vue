<template>
  <div>
    <!-- 表单 -->
    <el-form :inline="true" :model="searchForm" class="demo-form-inline">
      <el-form-item label="">
        <el-input v-model="searchForm.name" placeholder="专业"></el-input>
      </el-form-item>

      <el-form-item label="">
        <el-select v-model="searchForm.dept2Id" placeholder="学院">
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
      searchForm: {
        name: "",
        dept2Id: null,
      },
    };
  },
  methods: {
    //查询
    onSearchSubmit: function () {
      axios
        .get("http://localhost:8080/major", {
          params: {
            name: this.searchForm.name,
            dept2Id: this.searchForm.dept2Id,
          },
        })
        .then((result) => {
          this.majorTable = result.data.data;
        })
        .catch((error) => console.error("Error:", error));
    },
    //清空查询
    deleteSearch() {
      this.searchForm.name = "";
      this.searchForm.dept2Id = null;
      this.fetchData();
    },

    //序列
    indexMethod(index) {
      return index + 1;
    },

    //找对应dept name 显示在class表中
    getDeptName(id) {
      return this.deptTable.find((dept) => dept.id === id)?.name || "Unknown";
    },

    fetchData() {
      axios
        .get("http://localhost:8080/major")
        .then((result) => {
          console.log(result);
          this.majorTable = result.data.data;
        })
        .catch((error) => console.error("Error:", error));
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
    this.fetchData();
  },
};
</script>
  
  <style scoped>
</style>