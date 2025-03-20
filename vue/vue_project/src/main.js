import Vue from 'vue'
import App from './App.vue'
import router from './router'
//引入element-ui组件
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import axios from './utils/axiosConfig'; // 引入配置好的 Axios 实例
import store from './store'; // 引入你的 store

Vue.config.productionTip = false
Vue.use(ElementUI);
Vue.prototype.$http = axios;

new Vue({
  store, // 注册 store
  router,
  render: h => h(App)
}).$mount('#app')

// 检查本地存储中是否存在角色信息
const storedRole = localStorage.getItem('currentRole');
if (storedRole) {
  store.commit('setCurrentRole', JSON.parse(storedRole));
}

// 检查本地存储中是否存在username信息
const storedUser = localStorage.getItem('currentUser');
if (storedRole) {
  store.commit('setCurrentUser', JSON.parse(storedUser));
}




