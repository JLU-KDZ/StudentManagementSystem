// store/index.js
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    currentRole: null,
    currentUser: null,
  },
  mutations: {
    setCurrentRole(state, role) {
      state.currentRole = role;
    },
    setCurrentUser(state, user) {
      state.currentUser = user;
    },
    
  },
  actions: {
    async setRole({ commit }, role) {
      commit('setCurrentRole', role);
      // // 如果需要等待状态更新完成，可以在这里添加一个 Promise
      // return new Promise(resolve => setTimeout(() => resolve(), 0));
      // 将角色信息存储到本地存储
      localStorage.setItem('currentRole', JSON.stringify(role));
    },
    async setUser({ commit }, user) {
      commit('setCurrentUser', user);
      localStorage.setItem('currentUser', JSON.stringify(user));
    },
    
  },
  getters: {
    currentUser: state => state.currentUser,
    currentRole: state => state.currentRole,
  },
});