<template>
    <div class="app-logout">
        <input type="button" value="退出登录" style="background:#146022; color:#fff" @click="logout">
    </div>
</template>
<script>
import {Toast} from 'mint-ui'
    export default{
        data(){
            return{
            }
        },
        methods:{
            logout(){
                this.axios.get("http://127.0.0.1:3000/logout")
                .then(res=>{
                    Toast(res.data.msg)                  
                        this.$router.push("/Home")
                        this.$store.commit("change",0)
                })
            }
        }
    }
</script>
<style>
    .app-logout{
        margin-top:20px;
    }
</style>