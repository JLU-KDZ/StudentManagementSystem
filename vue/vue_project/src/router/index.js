import Vue from 'vue'
import VueRouter from 'vue-router'
//import MainLayout from '@/layouts/MainLayout.vue';
// import HomeView from '../views/HomeView.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/dashboard',
    name: 'dashboard',
    component: () => import('../views/stu-management/DashBoard.vue')
  },
  {
    path: '/stu',
    name: 'stu',
    component: () => import('../views/stu-management/StuView.vue')
  },
  {
    path: '/alonestu',
    name: 'alonestu',
    component: () => import('../views/stu-management/AloneStuView.vue')
  },
  {
    path: '/teacherstu',
    name: 'teacherstu',
    component: () => import('../views/stu-management/TeacherStuView.vue')
  },
  {
    path: '/dept',
    name: 'dept',
    component: () => import('../views/stu-management/DeptView.vue')
  },
  {
    path: '/class',
    name: 'class',
    component: () => import('../views/stu-management/ClassView.vue')
  },
  {
    path: '/major',
    name: 'major',
    component: () => import('../views/stu-management/MajorView.vue')
  },
  {
    path: '/course',
    name: 'course',
    component: () => import('../views/stu-management/CourseView.vue')
  },
  {
    path: '/enrollment',
    name: 'enrollment',
    component: () => import('../views/stu-management/EnrollmentView.vue')
  },
  {
    path: '/teacher',
    name: 'teacher',
    component: () => import('../views/stu-management/TeacherView.vue')
  },
  {
    path: '/modifyAdmin',
    name: 'modifyAdmin',
    component: () => import('../views/stu-management/ModifyAdminView.vue')
  },

  {
    path: '/deptMajor',
    name: 'deptMajor',
    component: () => import('../views/stu-management/DeptMajorView.vue')
  },
  {
    path: '/stuCourse',
    name: 'stuCourse',
    component: () => import('../views/stu-management/StuCourseView.vue')
  },
  {
    path: '/stuEnrollment',
    name: 'stuEnrollment',
    component: () => import('../views/stu-management/StuEnrollmentView.vue')
  },
  {
    path: '/teacherMajor',
    name: 'teacherMajor',
    component: () => import('../views/stu-management/TeacherMajorView.vue')
  },
  {
    path: '/teacherCourse',
    name: 'teacherCourse',
    component: () => import('../views/stu-management/TeacherCourse.vue')
  },
  {
    path: '/teacherEnrollment',
    name: 'teacherEnrollment',
    component: () => import('../views/stu-management/TeacherEnrollment.vue')
  },
  {
    path: '/aloneTeacher',
    name: 'aloneTeacher',
    component: () => import('../views/stu-management/AloneTeacherView.vue')
  },

  {
    path: '/login',
    name: 'login',
    component: () => import('../views/stu-management/LoginView.vue'),
    meta: { layout: 'no-layout' } 
  },
  {
    path: '/register',
    name: 'register',
    component: () => import('../views/stu-management/RegisterView.vue'),
    meta: { layout: 'no-layout' } 
  },
  // {
  //   path: '/main',
  //   name: 'main',
  //   component: MainLayout,
  // },
  { 
    path: '/',
    name: 'default',
    redirect:'/dashboard'
  },
  
]


const router = new VueRouter({
  mode: 'history', // 使用 HTML5 History 模式
  base: process.env.BASE_URL,
  routes
});

router.beforeEach((to, from, next) => {
  if (to.path === '/login') {
    // 登录页面，不显示布局
    document.body.classList.add('no-layout');
  } else {
    // 其他页面，显示布局
    document.body.classList.remove('no-layout');
  }
  next();
});

export default router;
  
  // {
  //   path: '/system',
  //   redirect: '/system',
  //   name: 'System',
  //   meta: { title: '系统信息管理', icon: 'el-icon-s-tools' },
  //   children: [
  //     {
  //       path: 'dept',
  //       name: 'dept',
  //       component: () => import('../views/stu-management/DeptView.vue'),
  //       meta: { title: '学院管理', icon: 'el-icon-menu' }
  //     },
  //     {
  //       path: 'stu',
  //       name: 'stu',
  //       component: () => import('../views/stu-management/StuView.vue'),
  //       meta: { title: '员工管理', icon: 'el-icon-user-solid' }
  //     },
  //     {
  //       path: 'class',
  //       name: 'class',
  //       component: () => import('../views/stu-management/ClassView.vue'),
  //       meta: { title: '班级管理', icon: 'el-icon-user-solid' }
  //     }
  //   ]
  // },


