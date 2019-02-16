<template>
    <div class="app-details">
         <!--购物车 登录-->
        <div class="app-login">
           
        </div>
        <!--顶部图片-->
        <div class="detail_top">
            <div class="detail_img">
                <img :src="list.img_url" alt="">
            </div>
            <div class="detail_p">
                <p class="detail_price">￥<span>{{list.price | numberTofixed}}</span></p>
                <p class="detail_pay">该商品支持分期支付</p>
            </div>
            <div class="detail_title">
                {{list.name}}
            </div>
            <div class="detail_add">
                <span>吉林辽源</span>
                <span>运费 ￥8.0起</span>
            </div>
            <div class="detail_count">
                数量：<input class="detail_count_input"  type="text" value="1">
            </div>
        </div>
        <!--分隔条-->
        <div class="divider"></div>
        <!--地址-->
        <div class="detail_divider_next">
            <p><span>同城</span>&nbsp; 吉林辽源市下单可享受商家配送服务：全城</p>
            <p><span>交易资金担保</span><span>店长实名认证</span></p>
        </div>
        <div class="divider"></div>
        <!--店铺名称-->
        <div class="detail_shop">
            <div class="shop_logo">
                <img src="../../img/20190117165558.png" alt="">
            </div>
            <div class="shop_msg">
                <p>姜力品牌</p>
                <ul>
                    <li>
                        <p>11%</p>
                        <p>回头率</p>
                    </li>
                    <li>
                        <p>18小时前</p>
                        <p>登陆时间</p>
                    </li>
                    <li>
                        <p>24小时内</p>
                        <p>平均发货</p>
                    </li>
                </ul>
            </div>
        </div>
        <div class="shop_in">
            <span>+关注店铺</span>
            <span>进店逛逛</span>
        </div>
        <div class="divider"></div>
        <!--评论子组件-->
        <detailComment-box :id="id"></detailComment-box>
        <!--加入购物车 立即购买-->
        <div class="app_pro_bottom">
            <a href="#/Home">
                <img src="../../img/20190117165558.png" alt="" style="width:15px;height:15px">
                <span>联系店家</span>
            </a>  
            <a href="#/Home">
                <span class="mui-icon mui-icon-chat"></span>
				<span>进店</span>
            </a>
            <a href="#/productdetails">
                <span class="mui-icon mui-icon-chat"></span>
				<span>收藏</span>
            </a>
            <button class="cart" @click="addproduct">加入购物车</button>
            <button class="buy">立即购买</button>
        </div>
    </div>
</template>  
<script>
import detailComment from './comment.vue'
import {Toast} from "mint-ui"
    export default{
        components:{
            "detailComment-box":detailComment
        },
        data(){
            return{
                list:{},
                id:this.$route.query.id
            }
        },
        methods:{
            getproductdetail(){
                var id = this.$route.query.id;
                this.axios.get("http://127.0.0.1:3000/getproductdetail?id="+id)
                .then((res)=>{
                    this.list=res.data.data;
                    /*顶部登录用户名 */
                    var uid=res.data.uid;
                    var uname=res.data.uname;
                    var div_login=document.querySelector(".app-login");
                    if(uid){
                         div_login.innerHTML=` <a href="#/cart">购物车</a>
            <a href="#/Home">欢迎：${uname}</a> <a href="#/logout">退出登录</a>`
                    }else{
                         div_login.innerHTML=` <a href="#/cart">购物车</a>
            <a href="#/login">登录</a>`
                    }

                })
            },
            /*加入购物车 */
            addproduct(){
                var pid=this.id;
                var price=parseInt(document.querySelector(".detail_price>span").innerHTML);
                var count=document.querySelector(".detail_count_input").value;
                var pname=document.querySelector(".detail_title").innerHTML;
                this.axios.get("http://127.0.0.1:3000/addproduct?pid="+pid+"&price="+price+"&count="+count+"&pname="+pname)
                .then(res=>{
                    Toast(res.data.msg)
                    this.$store.commit("change",res.data.num)
                })
            }
        },
        created(){
            this.getproductdetail();
        }
    }
</script>
<style>
.app-details{
    background:#fff
}
p{
    margin:0 
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
/*商品图片及价格信息 */
.detail_p,.detail_title,.detail_add{
    margin:5px 20px ;
}
.detail_img img{width:30%;}
.detail_price{
    color:#f00;
    font-size:24px;
}
.detail_pay{
    font-size:12px;
    color:#00f
}
.detail_title{
    font-size:14px;
    font-weight:bold
}
.detail_add{
    display:flex;
    justify-content:space-between;
}
.detail_add span{
    font-size:9px;
    color:#666
}

/*分隔条 */
.divider{
    width:100%;
    height:10px;
    background:#ccc;
}
.detail_divider_next p{
    padding:5px;
    font-size:12px;
    margin:0
}
.detail_divider_next p:first-child{
    border-bottom:1px solid #ccc
}
.detail_divider_next p span{
    padding: 0 15px;
}
.detail_divider_next p:first-child span{
    border:1px solid #ccc;
    margin-left:5px;
}
/*店铺名称 */
.detail_shop{
    display:flex;
    justify-content:space-between
}
.shop_logo{
    width:20%;
}
.shop_logo img{
    width:100%;
    margin:10px;
}
.shop_msg{
    width:80%;
}
.shop_msg p{
    margin:10px 0 0 50px;
}
.shop_msg ul{
    list-style:none;
    margin:0
}
.shop_msg ul li{
    float:left;
    padding:10px;
}
.shop_msg ul li p{
    margin:0;
    font-size:12px;
}
.shop_msg ul:after{
    content:"";
    display:block;
    clear:both
}
.shop_in{
    display:flex;
    justify-content:space-around;
    padding-bottom:20px;
}
.shop_in span{
    text-align:center;
    width:150px;
    padding:5px 10px;
    font-size:12px;
    background:#ddd;
}
.shop_in span:first-child{
    color:#f00
}
/*数量 */
.detail_count{
    font-size:14px;
    margin-left:20px;
}
.detail_count .detail_count_input{
    width:40px;
    height:25px;
    padding:0px 10px ;
}

/*底部加入购物车 */
.app_pro_bottom{
    width:100%;
    position:fixed;
    bottom:0;
    left:0;
    background:#fff
}
.app_pro_bottom a{
    display:inline-block;
    width:15%;
    margin:0 3px 
}
.app_pro_bottom a span{
    display:block;
    color:#000;
    font-size:14px;
    text-align:center;
    margin:0;
    padding:0
}
.app_pro_bottom button{
    display:inline-block;
    height:100%;
    border:none;
    width:25%;
    position:absolute;
    bottom:0
}
.cart{
    right:25%;
    text-align:center;
    background:#999;
}
.buy{
    right:0;
    background:#f00
}
</style>
