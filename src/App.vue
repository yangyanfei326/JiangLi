<!--App.vue-->
<template>
 <div class="app-container">
 
    <!--1:顶部导航栏-->
    <div class="top_header">
        <h5>
            <a id="icon-menu" class="mui-action-menu mui-icon mui-icon-bars mui-pull-left" @click="toggle_navs"></a>
            <img src="./img/20190117165558.png"style="width:40px;height:40px;"> 姜力品牌
        </h5>
        <div class="header_hidden" style="display:none">
			<div>
				<ul class="header_hidden_ul">
					<li>
						<router-link to="/Home">首页</router-link>
					</li>
					<li>
						<router-link to="/productlist">产品展示</router-link>
					</li>
					<li>
						<router-link to="/Home">留言板</router-link>
					</li>
					<li>
						<router-link to="/Home">招商代理</router-link>
					</li>
				</ul>
			</div>
		</div>
    </div>
    <!--2:router-view-->
    <router-view>
    </router-view>
  
 </div>
</template>
<script>
    export default{
        data(){
            return{}
        },
        methods:{
            toggle_navs(){
                var div_hide=document.querySelector(".header_hidden");
                if(div_hide.style.display=="none"){
                    div_hide.style.display="block";
                }else{
                    div_hide.style.display="none"
                }
            }
        }
    }
    
</script>
<style>

/*App.vue 顶部和底部导航栏*/
.app-container{
   padding-top:40px;
   padding-bottom:50px;
   overflow-x:hidden;
}

/*顶部姜力品牌样式 */
.app-container .top_header{
    width:100%;
    position:fixed;
    top:0;
    left:0;
    z-index:1000
}
#icon-menu{
    color:#fff;
    display:inline-block;
    height:45px;
    line-height:45px;
    text-indent:10px;
}
.app-container .top_header h5{
    width:100%;
    height:45px;
    line-height:45px;
    background:#112f17;
    opacity:0.9;
    text-indent:25%;;
    font-size:18px;
    color:#fff;
    margin:0
}
.app-container .top_header h5 img{
    vertical-align:middle
}
/*隐藏导航栏 */

.header_hidden_ul{
    list-style:none;
    background:#112f17;
    opacity:0.9;
    height:38px;
    line-height:38px;
    margin:2px 0 0;
    padding:0
}
.header_hidden_ul>li{
    float:left;
    padding:0 10px;
}
.header_hidden_ul:after{
    content:"";
    display:block;
    clear:both
}
.header_hidden_ul>li>a{
    text-decoration:none;
    font-size:14px;
    color:#fff;
}

</style>
