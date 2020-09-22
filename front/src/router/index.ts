import Vue from 'vue'
import VueRouter, { RouteConfig } from 'vue-router'
import Item from '../views/Item.vue'

Vue.use(VueRouter)

const routes: Array<RouteConfig> = [
  {
    path: '/',
    name: '',
    component: Item
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
