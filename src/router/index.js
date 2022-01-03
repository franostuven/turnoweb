import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
  {
    path: '/member',
    name: 'Member',
    component: () => import(/* webpackChunkName: "about" */ '../views/Member.vue'),
    meta: {authentical : true}
  },
  {
    path: '/news',
    name: 'News',
    component: () => import(/* webpackChunkName: "about" */ '../views/News.vue')
  },
  {
    path: '/turnos',
    name: 'Turnos',
    component: () => import(/* webpackChunkName: "about" */ '../views/Turnos.vue')
  },
  {
    path: '/recuperoclave',
    name: 'RecuperoClave',
    component: () => import(/* webpackChunkName: "about" */ '../views/RecuperoClave.vue')
  },
  {
    path: '/contacto',
    name: 'Contacto',
    component: () => import(/* webpackChunkName: "about" */ '../views/Contacto.vue')
  },
  {
    path: '/usuarios',
    name: 'Usuarios',
    component: () => import(/* webpackChunkName: "about" */ '../views/Usuarios.vue')
  },
  {
    path: '/adminturnos',
    name: 'AdminTurnos',
    component: () => import(/* webpackChunkName: "about" */ '../views/AdminTurnos.vue')
  },
  {
    path: '/adminfechas',
    name: 'AdminFechas',
    component: () => import(/* webpackChunkName: "about" */ '../views/AdminFechas.vue')
  },
  {
    path: '/configuracion',
    name: 'Configuracion',
    component: () => import(/* webpackChunkName: "about" */ '../views/Configuracion.vue')
  }
]


const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
