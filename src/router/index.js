import { createRouter, createWebHistory } from 'vue-router'
import MainPage from '@/views/MainPage'
import ChattingPage from '@/views/ChattingPage' 

const routes = [
  {
    path: '/',
    name: 'Main',
    component: MainPage
  },
  {
    path: '/chatting',
    name: 'Chatting',
    component: ChattingPage
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router