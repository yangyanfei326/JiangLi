<template>
    <div class="app-pro">
         <!--购物车 登录-->
        <div class="app-login">
            <router-link to="">购物车:{{$store.getters.optCartCount}}</router-link>
            <router-link to="/login">登录</router-link>
        </div>
        <img src="http://127.0.0.1:3000/img/ABUIABACGAAg3YjBugUoiv2qoQQwgBQ4rAs.jpg" alt="">
        <div class="pro-middle">
            <div>
                <img src="../../img/20190117165558.png" alt="">
            </div>
            <div class="pro_middle_middle">
                <p>姜力品牌</p>
                <p >探店</p>
                <p>关注486</p>
            </div>
            <div class="pro_middle_bottom">
                <p>店铺动态</p>
            </div> 
        </div>
        <p class="pro_middle_p">交易资金担保 &nbsp; 店长实名认证</p>
        <p class="pro-title">全部商品</p>
        
        <div class="app-productlist">
            <div class="pro-item" v-for="item of list" :key="item.id">
                <router-link :to="'/productdetails?id='+item.id">
                    <img :src="item.img_url" alt="">
                    <p>{{item.name}}</p>
                    <div class="pro-detail">
                        <p>￥{{item.price}}</p>
                        <p>销量 &nbsp;{{item.sale}}</p>
                    </div>
                </router-link>  
            </div> 
        </div>
        <div class="app-page">
            <mt-button type="primary" size="large" @click="getProductList">加载更多</mt-button>
        </div>
        <div class="app-pro-bottom">
            <nav class="mui-bar mui-bar-tab">
                <a class="mui-tab-item mui-active" href="javascript:;" @click="search_type">
                    <span class="mui-icon mui-icon-extra mui-icon-extra-class"></span>
                    <span class="mui-tab-label">分类</span>
                </a>
                <a class="mui-tab-item" href="javascript:;">
                    <span class="mui-icon mui-icon-eye"></span>
                    <span class="mui-tab-label">发现</span>
                </a>
                <a class="mui-tab-item" href="javascript:;">
                    <span class="mui-icon mui-icon-extra mui-icon-extra-comment"></span>
                    <span class="mui-tab-label">联系卖家</span>
                </a>
                <a class="mui-tab-item" href="javascript:;">
                    <span class="mui-icon mui-icon-extra mui-icon-extra-heart"></span>
                    <span class="mui-tab-label">关注</span>
                </a>
            </nav>
        </div>
        <!--隐藏菜单栏-->
        <div class="app-pro-hide" :style="left_distance">
            <input type="text"  v-model="val"><button class="search" @click="search_pro">搜索</button>
            <button class="right" @click="search_type">→→</button>
        </div>
    </div>
    
</template>
<script>
    import {Toast} from 'mint-ui'
    export default{
        data(){
            return{
                pageIndex:0,
                pno:1,
                pageSize:6,
                pageCount:1,
                list:[],
                distance:"-70%",
                val:"",
                hasMore:true
            }
        },
        computed:{
            left_distance(){
                return {
                     left:this.distance
                }
            }
        },
        methods:{
            getProductList(){
                if(this.hasMore===false){
                    Toast("已经是最后一条啦")
                    return
                }
                var pno=this.pageIndex+1;
                var pageSize=this.pageSize;
                this.axios.get("http://127.0.0.1:3000/getProductList?pno="+pno+"&pageSize="+pageSize)
                .then((res)=>{
                    var rows=this.list.concat(res.data.data);
                    this.list=rows;
                    this.pageIndex=pno;
                    this.pageCount=res.data.pageCount;
                    var flag=this.pageIndex< this.pageCount;
                    this.hasMore=flag
                    /*顶部登录用户名 */
                    var uid=res.data.uid;
                    var uname=res.data.uname;
                    var div_login=document.querySelector(".app-login") 
                    if(uid){
                         div_login.innerHTML=` <a href="#/cart">购物车</a>
            <a href="#/Home">欢迎：${uname}</a> <a href="#/logout">退出登录</a>`
                    }else{
                         div_login.innerHTML=` <a href="#/cart">购物车</a>
            <a href="#/login">登录</a>`
                    }
                })
            },
            search_type(){
                if(this.distance=="-70%"){
                    this.distance=0
                }else{
                    this.distance="-70%";
                }
            },
            search_pro(){
                var search_input=document.querySelector(".app-pro-hide>input");
                var kwords=search_input.value;
                console.log(kwords)
                this.$router.push("/productlistsearch/"+kwords)
            }
        },
        
        created(){
            this.getProductList();
        }
    }
</script>
<style>
.app-pro{
    background:#fff;
}
/*购物车登录 */
.app-login{
    margin-top:8px;
    background:#fff;
    text-align:right
}
.app-login a{
    color:#000;
    font-size:14px;
    margin:10px
}
/*顶部图片 */
.app-pro img{
    width:100%;
}
/*全部商品 */
.pro-title{
    background:#f1f1f1;
     margin:0;
    text-align:center
}
/*店铺名称 */
.pro-middle{
    display:flex;
    flex-wrap:no-wrap;
    justify-content:space-between;
}
.pro-middle img{
    width:100px;
    margin:15px 0 0 10px
}
.pro_middle_middle{
    width:170px;
    margin-top:15px;
}
.pro_middle_middle p:not(:first-child){
    font-size:12px;
    margin:0
}
.pro_middle_middle p:first-child{
    font-size:16px;
    margin:15px 0 0 
}
.pro-middle div:last-child{
    margin-top:15px;
}
.pro_middle_p{
    margin:15px;
}
/*商品详情 */
.app-productlist{
    display:flex;
    flex-wrap:wrap;
    justify-content:space-between;
    padding-top:10px;
}   
.app-productlist .pro-item{
    width:50%;
    box-sizing:border-box;
    display:flex;
    flex-direction:column;
    background:#fff;
    justify-content:center;
    align-items:center;
}
.app-productlist .pro-item p{
    margin:0
}
.app-productlist .pro-item img{
    width:100px;
    height:100px;
}
.pro-detail{
    text-align:left;
}
/*底部导航栏 */
.app-pro .mui-bar{
    background:#112f17;
    
}
.app-pro .mui-bar span{
    color:#fff
}
.app-pro .mui-tab-label,.mui-icon{
    color:#000
}
.app-home .home_search{
    background:#fff;
    margin:5px 0
}
/*隐藏菜单栏 */
.app-pro .app-pro-hide{
    width:70%;
    height:545px;
    position:fixed;
    top:70px;
    z-index:10;
    background:#fff
}
.app-pro .app-pro-hide input{
    width:50%;
    display:inline-block;
    height:25px;
    line-height:25px;
    font-size:12px;
    margin:10px 0 10px 15px;
    border-right:none
}
.app-pro .app-pro-hide .search{
    background:#f00;
    margin-top:10px;
    border-left:0;
    display:inline-block;
    height:25px;
    padding-top:0;
    padding-bottom:0;
    color:#fff
}
.app-pro-hide .right{
    margin:200px 0 0 260px;
    padding:0
}

</style>