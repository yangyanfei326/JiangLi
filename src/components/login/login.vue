<template>
    <div class="pro-login">
        <h4>会员登录</h4>
        <div class="login_form">
            <form>
                <p>
                    账号<input class="login_name" type="text" placeholder="请输入账号" v-model="uname"><br/>
                </p>
                <p>
                    密码<input class="login_pwd" type="password" placeholder="请输入密码" v-model="upwd">
                </p>
                <button @click="login">登录</button>
            </form>
        </div>
        <p><router-link to="/register" @click="login">立即注册</router-link></p>
    </div>
</template>
<script>
import {Toast} from 'mint-ui'
    export default{
        data(){
            return{
                uname:"",
                upwd:""
            }
        },
        methods:{
            login(e){
                e.preventDefault();
                var uname=this.uname;
                var upwd=this.upwd;
                var reg = /^[a-z0-9_]{3,12}$/i;
                if(!reg.test(uname)){
                    Toast("用户名格式不正确");
                    return;
                }
                if(!reg.test(upwd)){
                    Toast("密码格式不正确");
                    return;
                }
                this.axios.get("http://127.0.0.1:3000/login?uname="+uname+"&upwd="+upwd)
                .then((res)=>{
                    if(res.data.code==1){
                        Toast("登陆成功")
                        this.$router.push("/Home");
                        this.$store.commit("change",res.data.num)
                    }else{
                        Toast("登陆失败")
                    }
                })
            }
        }
    
    }
</script>
<style>
/*会员登录 */
.pro-login h4{
    text-align:center;
    padding:5px;
}
.login_form  p{
    border:1px solid #ccc;
    margin:0;
    width:90%;
    margin-left:20px;
}
.login_form>form>p>input{
    border:none;
    width:80%;
    margin:0;
    font-size:14px;
    background:#efeff4
}
/*表单 */
.login_form button{
    width:80%;
    background:#112f17;
    color:#fff;
    opacity:0.9;
    margin:10px 40px
}
/*立即注册 */
.pro-login>p{
    text-align:right;
}
.pro-login a{
    padding:5px;
    color:#666;
    font-size:12px;
}
</style>