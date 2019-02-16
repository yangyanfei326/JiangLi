<template>
    <div class="app-register">
        <div class="pro-login">
        <h4>会员注册</h4>
        <div class="login_form">
            <form>
                <p>
                    账号<input type="text" placeholder="请输入账号（必填）3-8位字母或数字" @blur="nametest"  v-model="uname">
                </p>
                <span class="confirm"></span>
                <p>
                    密码<input class="upwd1" type="password" placeholder="请输入密码（必填）3-8位字母或数字" @blur="nametest" v-model="upwd">
                </p>
                 <span class="confirm"></span>
                <p>
                    密码<input type="password" placeholder="请输入确认密码（必填）与密码一致"  @blur="pwdconfirm" >
                </p>
                <span></span>
                <p>
                    姓名<input type="text" placeholder="请输入姓名（必填）3-8位字母或数字" @blur="nametest" v-model="user_name">
                </p>
                <span class="confirm"></span>
                <p>
                    微信号<input type="text" placeholder="请输入微信号（必填）3-8位字母或数字" @blur="nametest" v-model="wechat_name">
                </p> 
                <span class="confirm"></span>
                <p>
                    邮箱<input type="text" placeholder="请输入邮箱（必填）" v-model="email">
                </p> 
                <span></span>
                <p>
                    手机<input type="text" placeholder="请输入11位手机（必填）" @blur="phonetest" v-model="phone">
                </p> 
                <span class="confirm"></span>
                <p>
                    留言<input type="text" placeholder="请输入留言">
                </p> 
                
                <button size="large" @click="form_submit">注册</button>
            </form>
        </div>
    </div>
    </div>
</template>
<script>
import qs from 'qs'
import {Toast} from 'mint-ui'
    export default{
        data(){
            return{
                uname:"",
                upwd:"",
                user_name:"",
                wechat_name:"",
                email:"",
                phone:""
            }
        },
        methods:{
        /*验证注册信息 */
            vali(txt,reg){
                var div=txt.parentNode.nextElementSibling;
                if(reg.test(txt.value)){
                    div.innerHTML="格式正确";
                    return true;
                }
                else{
                    div.innerHTML="格式错误";
                    return false;
                }
            },
            nametest(e){
               this.vali(e.target,/^[0-9a-zA-Z]{3,8}$/);
            },
            pwdconfirm(e){
                var val=document.querySelector(".upwd1").value
                var val2=e.target.value;
                if(val2===val){
                    e.target.parentNode.nextElementSibling.innerHTML="两次密码一致"
                }else{
                     e.target.parentNode.nextElementSibling.innerHTML="两次密码不一致"
                }
            },
            phonetest(e){
                this.vali(e.target,/^1[3-9]\d{9}$/);
            },
            form_submit(e){
                e.preventDefault();
                var spans=document.querySelectorAll(".login_form span.confirm")
                var sum=0;
                for(var span of spans){
                    if(span.innerHTML=="格式正确"){
                        sum+=1;
                    } else{ sum-=1 }
                }
                if(sum==5){    
                        var uname=this.uname;
                        var upwd=this.upwd;
                        var user_name=this.user_name;
                        var wechat_name=this.wechat_name;
                        var email=this.email;
                        var phone=this.phone
                        /*this.axios.get("http://127.0.0.1:3000/register?uname="+uname+"&upwd="+upwd+"&user_name="+user_name+"&wechat_name="+wechat_name+"&email="+email+"&phone="+phone)
                    .then((res)=>{
                        if(res.data.code==1){
                            Toast("注册成功,请登录")
                           this.$router.push("/login")
                        }else{
                            Toast("注册失败")
                        }
                    })
                }else{
                    Toast("注册信息不完整")
                }*/
                        
                    this.axios.post("http://127.0.0.1:3000/register",qs.stringify({uname,upwd,user_name,wechat_name,email,phone}),
                    {
                        headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                        }
                    }/*,
                    {emulateJSON: true}*/
                    )
                    .then((res)=>{
                        if(res.data.code==1){
                            Toast("注册成功,请登录")
                           this.$router.push("/login")
                        }else{
                            Toast("注册失败")
                        }
                    })
                }else{
                    Toast("注册信息不完整")
                }
            }
        }
    }
</script>
<style>
.pro-login h4{
    text-align:center;
    padding:5px;
}
.login_form span{
    font-size:12px;
    color:#f00;
    margin-left:20px
}
.login_form p{
    border: 1px solid #ccc;
    margin: 0;
    width: 90%;
    margin-left: 20px;
}
.login_form p input{
    border: none;
    width: 80%;
    margin: 0;
    font-size: 14px;
    background: #efeff4;
}
.login_form button{
    width: 80%;
    background: #112f17;
    color: #fff;
    opacity: 0.9;
    margin: 10px 40px
}
</style>