<template>
  <div>
    <MainLayout />
  </div>
</template>
<script>
// import StuView from './views/stu-management/StuView.vue'
// import ElementView from './views/element/ElementView.vue'
import MainLayout from './layouts/MainLayout.vue';
export default {
  name: 'App',
  components: {
    MainLayout,
  },
  data() {
    return {
      message: "hello world",
    };
  },
  method: {},
};
</script>

<style>
</style>
