<template>
    <div class="app-home">
        <!--1.顶部-->
        <!--登录注册-->
        <div class="app-login">
           
        </div>
        <!--2.轮播图-->
        <mt-swipe :auto="2500">
            <mt-swipe-item v-for="item of list" :key="item.id">
                <img :src="item.img_url">
            </mt-swipe-item>
        </mt-swipe>
        <!--3.九宫格-->
        <div class="mui-content">
		    <ul class="mui-table-view mui-grid-view mui-grid-9">
		        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <router-link to="/productlist">
		                <img src="../../img/menu1.png" />
		                <div class="mui-media-body">姜力产品</div>
                    </router-link>
                </li>
		        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <router-link to="/Home">
		                <img src="../../img/menu2.png" />
		                <div class="mui-media-body">招商</div>
                    </router-link>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <router-link to="/cart">
		                <img src="../../img/menu3.png" />
		                <div class="mui-media-body">购物车:<span class="cartcount">{{$store.getters.optCartCount}}件</span></div>
                    </router-link>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <router-link to="/Home">
		                <img src="../../img/menu4.png" />
		                <div class="mui-media-body">防伪查询</div>
                    </router-link>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <router-link to="/Home">
		                <img src="../../img/menu5.png" />
		                <div class="mui-media-body">粉丝留言</div>
                    </router-link>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <router-link to="/Home">
		                <img src="../../img/menu6.png" />
		                <div class="mui-media-body">星咖优选</div>
                    </router-link>
                </li>    
		    </ul> 
		</div>        
        <!--4.搜索框-->
        <div class="home_search">
            <input type="text" placeholder="请输入搜索内容">
            <button @click="search_pro">搜索</button>
        </div>
        <!--5.视频-->
        <div class="home-video">
            <video src="../../img/ABUIABA6GAAg-s3GugUoqeKxowc.mp4" autoplay loop controls></video>
        </div>
        <!--6.二维码-->
        <div class="home-erweima">
            <img src="../../img/ABUIABAEGAAg0M2exgUo5OTHswIw9AI49AI.png" alt="">
            <p>2015-2019 &nbsp;姜力品牌</p>
        </div>
          <!--3:tabbar-->
        <nav class="mui-bar mui-bar-tab">
			<router-link to="/Home" class="mui-tab-item mui-active" href="#tabbar">
				<span class="mui-icon mui-icon-phone"></span>
				<span class="mui-tab-label">首页</span>
			</router-link>
			<router-link to="/productlist" class="mui-tab-item" href="#tabbar-with-chat">
				<span class="mui-icon mui-icon-location"></span>
				<span class="mui-tab-label">全部宝贝</span>
			</router-link>
			<router-link to="/login" class="mui-tab-item" href="#tabbar-with-contact">
				<span class="mui-icon mui-icon-qq"></span>
				<span class="mui-tab-label">登录</span>
			</router-link>
			<router-link to="/register" class="mui-tab-item" href="#tabbar-with-contact">
				<span class="mui-icon mui-icon-chat"></span>
				<span class="mui-tab-label">注册</span>
			</router-link>
		</nav>
    </div>

</template>
<script>
    export default{
        data(){
            return{
                list:[]
            }
        },
        created(){
            this.axios.get("http://127.0.0.1:3000/getImages")
            .then((res)=>{
                this.list=res.data.data
                /*顶部登录用户名 */
                var uid=res.data.uid;
                var uname=res.data.uname;
                this.$store.commit("change",res.data.num)
                var div_login=document.querySelector(".app-login");
                if(uid){
                    div_login.innerHTML=
                    ` <a href="#/Home">欢迎：${uname}</a> <a href="#/logout">退出登录</a>`
                }else{
                    div_login.innerHTML=
                    `<a href="#/login" class="">登录</a><a href="#/register" class="">注册</a>`
                }
            })
        },
        methods:{
            search_pro(){
                var search_input=document.querySelector(".home_search>input");
                var kwords=search_input.value;
                this.$router.push("/productlistsearch/"+kwords)
            }
        }
    }

</script>

<style>
/*注册登录 */
.app-login{
    margin-top:8px;
    background:#fff;
    text-align:right;
}
.app-login a{
    color:#000;
    font-size:14px;
    margin:10px
}
/*轮播图 */
    .app-home .mint-swipe{
        height:200px;
    }
    .app-home .mint-swipe img{
        width:100%;
    }
/*九宫格 */
.app-home .mui-content .mui-table-view{
    background:#fff
}
.app-home .mui-grid-9 img{
  width:60px;
  height:60px;
}
.app-home .cartcount{
    color:#f00
}
/*搜索框 */
.app-home .home_search{
    background:#fff;
    margin:5px 0
}
.app-home .home_search input{
    width:75%;
    display:inline-block;
    height:35px;
    line-height:35px;
    font-size:12px;
    margin:10px 0 10px 15px;
    border-right:none
}
.app-home .home_search button{
    background:#146022;
    margin-top:10px;
    border-left:0;
    display:inline-block;
    height:35px;
    color:#fff
}
/*视频 */
.app-home .home-video{
    background:#fff;
    margin:5px 0;
    text-align:center
}
.app-home .home-video video{
    width:95%;
    margin:10px 5px
}
/*二维码 */
.app-home .home-erweima{
    background:#fff;
    margin:5px 0;
    text-align:center;
}
.app-home .home-erweima img{
    width:35%;
    margin:15px 0 0
}
.app-home .home-erweima p{
    font-size:12px;
}
/*底部导航栏 */
.app-container .mui-bar{
    background:#112f17;
    opacity:0.9;
}
.app-container .mui-bar span{
    color:#fff
}
.app-container .mui-tab-label,.mui-icon{
    color:#fff
}
</style>