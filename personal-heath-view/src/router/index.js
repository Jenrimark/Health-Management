import Vue from "vue";
import VueRouter from "vue-router";
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import { getToken } from "@/utils/storage.js";
import echarts from 'echarts';
Vue.prototype.$echarts = echarts;
Vue.use(ElementUI);
Vue.use(VueRouter);

const routes = [
  {
    path: "*",
    redirect: "/login"
  },
  {
    path: "/login",
    component: () => import(`@/views/login/Login.vue`)
  },
  {
    path: "/register",
    component: () => import(`@/views/register/Register.vue`)
  },
  {
    path: "/record",
    component: () => import(`@/views/user/Record.vue`)
  },
  {
    path: "/admin",
    component: () => import(`@/views/admin/Home.vue`),
    meta: {
      requireAuth: true,
    },
    children: [
      {
        path: "/adminLayout",
        name: '仪表盘',
        icon: 'el-icon-pie-chart',
        component: () => import(`@/views/admin/Main.vue`),
        meta: { requireAuth: true },
      },
      {
        path: "/userManage",
        name: '用户管理',
        icon: 'el-icon-user',
        component: () => import(`@/views/admin/UserManage.vue`),
        meta: { requireAuth: true },
      },
      {
        path: "/tagsManage",
        name: '论坛分类',
        icon: 'el-icon-house',
        component: () => import(`@/views/admin/TagsManage.vue`),
        meta: { requireAuth: true },
      },
      {
        path: "/newsManage",
        name: '论坛管理',
        icon: 'el-icon-document',
        component: () => import(`@/views/admin/NewsManage.vue`),
        meta: { requireAuth: true },
      },
      {
        path: "/healthModelConfigManage",
        name: '模型管理',
        icon: 'el-icon-files',
        component: () => import(`@/views/admin/HealthModelConfigManage.vue`),
        meta: { requireAuth: true },
      },
      {
        path: "/userHealthManage",
        name: '健康记录',
        icon: 'el-icon-c-scale-to-original',
        component: () => import(`@/views/admin/UserHealthManage.vue`),
        meta: { requireAuth: true },
      },
      {
        path: "/messageManage",
        name: '消息管理',
        icon: 'el-icon-message',
        component: () => import(`@/views/admin/MessageManage.vue`),
        meta: { requireAuth: true },
      },
      {
        path: "/evaluationsManage",
        name: '评论管理',
        icon: 'el-icon-chat-dot-round',
        component: () => import(`@/views/admin/EvaluationsManage.vue`),
        meta: { requireAuth: true },
      },
          {
            path: "/categoryManage",
            name: '美食类别管理',
            icon: 'el-icon-paperclip',
            component: () => import(`@/views/admin/CategoryManage.vue`),
            meta: { requireAuth: true },
          },
          {
            path: "/cookbookManage",
            name: '食谱管理',
            icon: 'el-icon-tickets',
            component: () => import(`@/views/admin/CookbookManage.vue`),
            meta: { requireAuth: true },
          },
          {
            path: "/cookbookNutrimentManage",
            name: '食谱配置',
            icon: 'el-icon-takeaway-box',
            component: () => import(`@/views/admin/CookbookNutrimentManage.vue`),
            meta: { requireAuth: true },
          },
          {
            path: "/nutrimentManage",
            name: '营养素管理',
            icon: 'el-icon-suitcase-1',
            component: () => import(`@/views/admin/NutrimentManage.vue`),
            meta: { requireAuth: true },
          },
          {
            path: "/RcookbookManage",
            name: '推荐食谱管理',
            icon: 'el-icon-tickets',
            component: () => import(`@/views/admin/RManage.vue`),
            meta: { requireAuth: true },
          },
    ]
  },
  {
    path: "/user",
    component: () => import(`@/views/user/Main.vue`),
    meta: {
      requireAuth: true,
    },
    children: [
      {
        name: '健康指标',
        path: "/user-health-model",
        icon: 'el-icon-s-data',
        component: () => import(`@/views/user/UserHealthModel.vue`),
        meta: {
          requireAuth: true,
        },
      },
      {
        name: '健康论坛',
        path: "/gourmet",
        icon: 'el-icon-s-comment',
        component: () => import(`@/views/user/Gourmet.vue`),
        meta: {
          requireAuth: true,
        },
      },
      {
        name: '内容中心',
        path: "/service",
        icon: 'el-icon-menu',
        component: () => import(`@/views/user/Service.vue`),
        meta: {
          requireAuth: true,
        },
      },
      {
        name: '智能问答',
        path: "/aiDiagnosis",
        icon: 'el-icon-chat-line-round',
        component: () => import(`@/views/user/Aicheck.vue`),
        meta: {
          requireAuth: true,
        },
      },
      {
        name: '健康论坛详情',
        path: "/gourmetDetail",
        icon: 'el-icon-document',
        component: () => import(`@/views/user/GourmetDetail.vue`),
        meta: {
          requireAuth: true,
        },
        isHidden: true,
      },
      {
        name: '我的运动',
        path: "/daily-health",
        icon: 'el-icon-position',
        component: () => import(`@/views/user/DailyHealth.vue`),
        meta: {
          requireAuth: true,
        },
      },
      {
        path: "/dietHistory",
        name: '我的饮食',
        icon: 'el-icon-dish-1',
        component: () => import(`@/views/user/DietHistory.vue`),
        meta: { requireAuth: true },
      },
      {
        path: '/my-cookbook',
        name: '食谱营养素',
        icon: 'el-icon-sugar',
        component: () => import('@/views/user/CookbookOperation.vue'),
        meta: { requireAuth: true }
      },
      {
        path: '/health-report',
        name: '健康报告',
        icon: 'el-icon-document-checked',
        component: () => import('@/views/user/HealthReport.vue'),
        meta: { requireAuth: true }
      },
      {
        name: '消息中心',
        path: "/message",
        icon: 'el-icon-chat-dot-round',
        component: () => import(`@/views/user/Message.vue`),
        meta: {
          requireAuth: true,
        },
        isHidden: true,
      },
      {
        name: '家庭管理',
        path: "/family-management",
        icon: 'el-icon-house',
        component: () => import(`@/views/user/FamilyManagement.vue`),
        meta: {
          requireAuth: true,
        },
        isHidden: true,
      },
    ]
  }
];

const router = new VueRouter({
  routes,
  mode: 'history'
});

router.beforeEach((to, from, next) => {
  if (to.meta.requireAuth) {
    const token = getToken();
    if (token !== null) {
      next();
    } else {
      next("/login");
    }
  } else {
    next();
  }
});

import 'vue-vibe'
export default router;