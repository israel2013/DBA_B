// import { createRouter, createWebHistory } from 'vue-router'

// const routes = [
//   {
//     path: '/',
//     name: 'home',
//     component:  () => import(/* webpackChunkName: "about" */ '../views/Home.vue')

//   },
// ]

// const router = createRouter({
//   history: createWebHistory(process.env.BASE_URL),
//   routes
// })

// export default router

import { createRouter, createWebHistory } from 'vue-router'

// import HomeView from '../views/HomeView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    // component: HomeView
    component: () => import(/* webpackChunkName: "about" */ '../views/HomeView.vue')

  },
  {
    path: '/perfil',
    name: 'profile',
    // component: HomeView
    component: () => import(/* webpackChunkName: "about" */ '../views/ProFile.vue'),
    meta: { requiresAuth: true } // Esta meta indica que requiere autenticación


  },

]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
