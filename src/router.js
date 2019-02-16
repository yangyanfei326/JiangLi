import Vue from 'vue'
import Router from 'vue-router'
import HelloContainer from "./components/HelloWorld.vue"
import testContainer from "./components/testContainer.vue"
import Home from './components/Home/home.vue'
import productlist from './components/product/productlist.vue'
import productdetails from './components/product/productdetails.vue'
import productlistsearch from './components/product/productlist-search.vue'
import login from './components/login/login.vue'
import register from './components/login/register.vue'
import cart from './components/product/cart.vue'
import logout from './components/login/logout'


Vue.use(Router)
export default new Router({
  routes: [
    /*用户访问 / 重新定位 /Home Home显示*/
    {path:'/',redirect:"/Home"},
    {path:'/test',component:testContainer},
    {path:'/Home',component:Home},
    {path:"/productlist",component:productlist},
    {path:'/productdetails',component:productdetails},
    {path:'/productlistsearch/:kwords',component:productlistsearch},
    {path:'/login',component:login},
    {path:'/register',component:register},
    {path:'/cart',component:cart},
    {path:'/logout',component: logout}
  ]
})
