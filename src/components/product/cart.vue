<template>  
    <div class="app-cart">
        <div class="mui-card-header"><h3>购物车列表</h3></div>
        <div class="mui-card-content">
            <div class="mui-card-content-inner">
                <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-media" v-for="item in list" :key="item.id">
                    <a href="javascript:;">
                        <img class="mui-media-object mui-pull-left" src="">
                        <div class="mui-media-body">
                            {{item.pname}}
                            <p class='mui-ellipsis'>{{item.price}}
                                <div class="mui-numbox" data-numbox-min='1' data-numbox-max='9'>
                                    <button class="mui-btn mui-btn-numbox-minus" type="button" @click="cardSub" :data-id="item.pid">-</button>
                                    <input id="test" class="mui-input-numbox" type="number" :value="item.count" />
                                    <button class="mui-btn mui-btn-numbox-plus" type="button" @click="cardAdd" :data-id="item.pid">+</button>
                                </div>                                
                            </p>
                        </div>
                    </a>
                </li>
                </ul>
            </div>
        </div>
        <div class="cart_sum">
            共计：￥<span>{{sum|numberTofixed}} &nbsp;&nbsp;&nbsp;数量:{{$store.getters.optCartCount}}件</span>
        </div>
    </div>
</template>
<script>
import {Toast} from "mint-ui"
    export default{
        data(){
            return{
                list:[]
            }
        },
        computed:{
            sum:function(){
                var sum=0;
                for(var item of this.list){
                    sum+=item.price*item.count;
                }
                 return sum
            },
            numberSum:function(){
                var sum=0;
                for(var item of this.list){
                    sum+=item.count;
                }
                 return sum
            }
        },
        methods:{
            getcart(){
                this.axios.get("http://127.0.0.1:3000/getcart")
                .then(res=>{
                    if(res.data.code==-1){
                        Toast("请先登录，即将跳转到登录页面...")
                        setTimeout(()=>{
                            this.$router.push("/login")
                        },2000)
                    }else{
                        this.list=res.data;
                        this.$store.commit("change",res.data[0].num)
                        Toast(res.data[0].msg)
                    }
                })
            },
            updateItemCount(id,count){
                var url="http://127.0.0.1:3000/cartupdate?id="+id+"&count="+count;
                this.axios.get(url)
                .then(res=>{
                    Toast(res.data.msg)
                })
            },
            cardSub(e){
                var id=e.target.dataset.id;
                for(var item of this.list){
                    if(item.pid==id && item.count>=1){
                        item.count--;
                        var url="http://127.0.0.1:3000/cartupdate?id="+item.pid+"&count="+item.count;
                            this.axios.get(url)
                            .then(res=>{
                                Toast(res.data.msg)
                                 this.getcart()
                            })
                       
                        //商品数量变为0时，删除购物车商品
                        if(item.count==0){
                            this.axios.get("http://127.0.0.1:3000/clearCart?id="+id)
                            .then(res=>{
                                this.getcart()
                            })
                        }                   
                    //this.$store.commit("substract")
                    break;
                    }
                }
            },
           cardAdd(e){
               var id=e.target.dataset.id;
               for(var item of this.list){
                   if(item.pid==id){
                       item.count++;
                       //this.updateItemCount(item.pid,item.count);
                     //  this.$store.commit("increment")
                        var url="http://127.0.0.1:3000/cartupdate?id="+item.pid+"&count="+item.count;
                        this.axios.get(url)
                        .then(res=>{
                            Toast(res.data.msg)
                            this.getcart()
                        })
                       break;
                   }
               }
           }
        },
        created(){
            this.getcart()
        }
    }
</script>
<style>
    .cart_sum{
        width:100%;
        background:#efeff4;
        text-align:right;
        position:fixed;
        bottom:0;
        right:0;
        padding:10px 50px;
        color:#f00
    }
    
</style>