<template>
    <div class="app-pro">
         <!--购物车 登录-->
        <div class="app-login">
            <router-link to="">购物车:{{$store.getters.optCartCount}}</router-link>
            <router-link to="/login">登录</router-link>
        </div>
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
                kwords:this.$route.params.kwords
            }
        },
        methods:{
            getProductList(){
                var kwords=this.kwords;
                this.pageIndex++;
                var pno=this.pageIndex;
                var pageSize=this.pageSize;
                this.axios.get("http://127.0.0.1:3000/getproductsearch?kwords="+kwords+"&pno="+pno+"&pageSIze="+pageSize)
                .then((res)=>{
                    if(res.data.pageCount==0){ Toast("无相关产品")}
                    else{
                        var rows=this.list.concat(res.data.data);
                        this.list=rows;
                        var pageCount=res.data.pageCount
                        if(this.pageIndex>res.data.pageCount){
                            Toast("已经是最后一条啦")
                        }
                    }
                })
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
</style>