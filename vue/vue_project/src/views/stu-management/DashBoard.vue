<template>
  <div class="image-container">
    <img :src="imagePath" />
  </div>
</template>

<script>
import axios from "@/utils/axiosConfig"; // 导入你上面创建的实例
export default {
  data() {
    return {
      imagePath: "",
    };
  },
  mounted() {
    axios
      .get("http://localhost:8080/dashboard")
      .then((result) => {
        console.log(result);
        this.imagePath = result.data.data;
      })
      .catch((error) => console.error("Error:", error));
  },
};
</script>
<style scoped>
.image-container {
  text-align: center; /* 居中显示图片 */
}

.image-container img {
  max-width: 100%; /* 图片宽度不超过容器宽度 */
  height: auto;
}
</style>