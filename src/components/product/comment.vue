<template>
    <div class="app-comment">
        <div class="comment_head">
            <p><span>商品评价（27）</span><span>好评100%</span></p>
        </div>
        <div class="comment_detail" v-for="item of list" :key ="item.id">
            <div class="comment_detail_1">
                <p>{{item.user_name}}</p>
                 <p>{{item.content}}</p>
            </div>
            <div>
                <p>{{item.ctime | datetimeFilter}}</p>
            </div>
        </div>
        <mt-button size="large" type="primary" @click="getMore">显示全部内容</mt-button>
    </div>
</template>
<script>
import {Toast} from 'mint-ui'
    export default{
        props:["id"],
        data(){
            return{
                list:[],
                pageIndex:0,
                pageCount:1,
                pageSize:1
            }
        },
        methods:{
            getComment(){
                var nid=this.id;
                this.axios.get("http://127.0.0.1:3000/getComment?nid="+nid)
                .then((res)=>{
                    this.list=res.data;
                })
            },
            getMore(){
                var nid=this.id;
                this.pageIndex++;
                var pno=this.pageIndex;
                var pageSize=this.pageSize;
                this.axios.get("http://127.0.0.1:3000/getCommentAll?nid="+nid)
                .then((res)=>{
                    this.list=res.data;
                    Toast("已显示全部评论")
                }) 
            }
        },
        created(){
            this.getComment();
        }
    }
</script>
<style>
.comment_head p{
    display:flex;
    justify-content:space-between
}
.comment_head p span{
    padding:10px;
}
.comment_head p span:first-child{
    font-size:16px ;
    color:#000;
    font-weight:bold
}
.comment_head p span:last-child{
    font-size:12px ;
}
.comment_head{
    padding:5px;
}
.comment_detail{
    display:flex;
    justify-content:space-between;
    border-bottom:1px solid #ccc
}
.comment_detail div{
    padding:10px;
   
}
.comment_detail div:last-child p{
     font-size:12px;
}
</style>