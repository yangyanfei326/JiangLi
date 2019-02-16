//vue_app_server 服务器
//   app.js 
//   public/img/banner1.png ...
const express = require("express");
var app = express();
app.use(express.static("public"));
app.listen(3000);
const pool = require("./pool");

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({
  extended: false //使用querystring解析数据
}));

//express mysql 参数 request;response
//跨域访问配置        
//1:加载模块cors
const cors = require("cors");
//2:配置cors
app.use(cors({
  origin:["http://127.0.0.1:3001",
         "http://localhost:8080"],//允许列表
  credentials:true   //是否验证
}))
//3.加载第三方模块 express-session
const session=require("express-session");
app.use(session({
  secret:"128位随机字符串",
  resave:false,
  saveUninitialized:true,
  cookie:{
    maxAge:1000*24*60*60
  }
}));
//功能一:首页轮播
app.get("/getImages",(req,res)=>{
  var obj=({code:0})
  obj.uid=req.session.uid;
  obj.uname=req.session.uname;
  obj.num=req.session.cartC
  var rows = [
    {id:1,img_url:"http://127.0.0.1:3000/img/ABUIABACGAAg3YjBugUoiv2qoQQwgBQ4rAs.jpg"},
    {id:2,img_url:"http://127.0.0.1:3000/img/ABUIABACGAAgvYvBugUowbKI1AUwgBQ4nAs.jpg"},
    {id:3,img_url:"http://127.0.0.1:3000/img/ABUIABACGAAgx4vBugUonPCenQUwgBQ4nAs.jpg"},
  ];
  obj.data=rows
  res.send(obj);
})

//#功能二:商品列表
app.get("/getProductList",(req,res)=>{
  //1:参数       pno 页码;pageSize 页大小
  var pno = parseInt(req.query.pno);
  var pageSize =  parseInt(req.query.pageSize);
  //1.2:默认值
  if(!pno){
    pno = 1;
  }
  if(!pageSize){
    pageSize = 6;
  }
  //2:验证正则表达式
  var reg = /^[0-9]{1,}$/;
  if(!reg.test(pno)){
     res.send({code:-1,msg:"页码格式不正确"});
     return;
  }
  if(!reg.test(pageSize)){
    res.send({code:-2,msg:"页大小格式不正确"});
    return;
  }
  //3:创建sql
  //  查询总页数
  var sql = "SELECT count(id) as c FROM JL_product";
  var progress = 0; //sql执行进度
  obj = {code:1};
  pool.query(sql,(err,result)=>{
       if(err)throw err;
       var pageCount = Math.ceil(result[0].c/pageSize);
       obj.pageCount = pageCount;
       progress += 50;
       if(progress == 100){
        res.send(obj);
       }
  });
  //  查询当前页内容
var sql=" SELECT id,name,img_url,price,sale";
    sql +=" FROM JL_product";
    sql +=" LIMIT ?,?"
var offset = parseInt((pno-1)*pageSize);
pageSize = parseInt(pageSize);
  pool.query(sql,[offset,pageSize],(err,result)=>{
    if(err)throw err;
    obj.uid=req.session.uid;
    obj.uname=req.session.uname
    obj.data = result;
    progress+=50;
    if(progress==100){
      res.send(obj);
    }
  }); 
});

//功能二隐藏页码中的搜索功能
app.get("/getproductsearch",(req,res)=>{
  var name=req.query.kwords
  name=`%${name}%`;
  var pno = parseInt(req.query.pno);
  var pageSize =  parseInt(req.query.pageSize);
  if(!pno){
    pno = 1;
  }
  if(!pageSize){
    pageSize = 6;
  }
  var sql="SELECT count(*) as c FROM JL_product  WHERE name LIKE ?"
  var progress = 0; //sql执行进度
  obj = {code:1};
  pool.query(sql,[name],(err,result)=>{
    if(err) throw err;
      var pageCount = Math.ceil(result[0].c/pageSize);
      obj.pageCount = pageCount;
      progress += 50;
      if(progress == 100){
      res.send(obj);
    }
  })
  //  查询当前页内容
  var sql=" SELECT * FROM JL_product WHERE name LIKE ? LIMIT  ?,?";
  var offset = parseInt((pno-1)*pageSize);
  pageSize = parseInt(pageSize);
    pool.query(sql,[name,offset,pageSize],(err,result)=>{
      if(err)throw err;
      obj.data = result;
      progress+=50;
      if(progress==100){
        res.send(obj);
      }
    });
})

//功能三：商品详情
app.get("/getproductdetail",(req,res)=>{
  var obj=({code:0})
  obj.uid=req.session.uid;
  obj.uname=req.session.uname
  var id= parseInt(req.query.id);
  var sql="SELECT * FROM JL_product  WHERE id=?"
  pool.query(sql,[id],(err,result)=>{
    if(err) throw err;
    obj.data=result[0]
    res.send(obj)
  })
})

//功能四：评论列表
app.get("/getComment",(req,res)=>{
  var nid= parseInt(req.query.nid);
  var sql="SELECT * FROM JL_comment WHERE nid=? LIMIT 1";
  pool.query(sql,[nid],(err,result)=>{
    if(err) throw err;  
      res.send(result)
  })
})
app.get("/getCommentAll",(req,res)=>{
  var nid= parseInt(req.query.nid);
  var sql="SELECT * FROM JL_comment WHERE nid=?";
  pool.query(sql,[nid],(err,result)=>{
    if(err) throw err;  
      res.send(result)
  })
})
//功能五登录
app.get("/login",(req,res)=>{
  var uname=req.query.uname;
  var upwd=req.query.upwd;
  var sql="SELECT *  FROM JL_user WHERE uname=? AND upwd=md5(?)";
  pool.query(sql,[uname,upwd],(err,result)=>{
    if(err) throw err
    if(result.length>0){
      req.session.uid=result[0].id
      req.session.uname=result[0].uname
      //查询购物车数量，保存到session中
      var sql2="SELECT * FROM JL_cart WHERE uid=?";
      pool.query(sql2,[result[0].id],(err,result)=>{
        if(err) throw err
        var cartC=0;
        for(var item of result){
          cartC+=item.count
        }
        req.session.cartC=cartC;
        res.send({code:1,msg:"登陆成功",num:req.session.cartC})
      })
    }else{
      res.send({code:-1,msg:"登陆失败"})
    }
  })
})
//功能登出
app.get("/logout",(req,res)=>{
  req.session.uid="";
  req.session.uname="";
  req.session.cartC=0;
  res.send({code:1,msg:"已退出登录"})
})
//功能六注册
app.post("/register",(req,res)=>{
  var uname=req.body.uname;
  var upwd=req.body.upwd;
  var user_name=req.body.user_name;
  var wechat_name=req.body.wechat_name;
  var email=req.body.email;
  var phone=req.body.phone;
  var sql="INSERT INTO JL_user (uname,upwd,user_name,wechat_name,email,phone) VALUES (?,md5(?),?,?,?,?)";
  pool.query(sql,[uname,upwd,user_name,wechat_name,email,phone],(err,result)=>{
    if(err) throw err
    if(result.affectedRows>0){
      res.send({code:1,msg:"注册成功"})
      
    }else{
      res.send({code:-1,msg:"注册失败"})
    }
    
  })
})
//功能七 加入购物车
app.get("/addproduct",(req,res)=>{
  //获取uid
  var uid=req.session.uid;
  //如果uid为true
  if(uid){
    //获取商品pid等参数
    var pid=parseInt(req.query.pid);
    var price=parseFloat(req.query.price);
    var count=parseInt(req.query.count);
    var pname=req.query.pname;
    var progress=0;
    var obj={}
    //查询购物车中是否已经有该商品
    var sql1="SELECT * FROM JL_cart WHERE pid=? AND uid=?";
    pool.query(sql1,[pid,uid],(err,result)=>{
      if(err) throw err
      //如果有，更新数量
        if(result[0]!=undefined){
         count+= result[0].count;
        /*SELECT * FROM JL_cart WHERE pid=? AND uid=?*/
        pool.query("UPDATE JL_cart SET count=? WHERE pid=? AND uid=?",[count,pid,uid],(err,result)=>{
          if(err) throw err
          var sql2="SELECT * FROM JL_cart WHERE uid=?"
          pool.query(sql2,[uid],(err,result)=>{
            if(err) throw err
            var num=0;
            for(var item of result){
              num+=item.count
            }
            req.session.cartC=num;
            obj.num=num
            progress+=50;
            if(progress==100){
              res.send(obj)
            }
          })
          obj.code=1;
          obj.msg="购物车商品数量已更新"
          progress+=50;
          if(progress==100){
            res.send(obj)
          }
        })
        
        //否则，插入数据
      }else{
        pool.query("INSERT INTO JL_cart VALUES (null,?,?,?,?,?)",[uid,pid,pname,price,count],(err,result)=>{
          if(err) throw err
          var sql2="SELECT * FROM JL_cart WHERE uid=?"
          pool.query(sql2,[uid],(err,result)=>{
            if(err) throw err
            var num=0;
            for(var item of result){
              num+=item.count
            }
            req.session.cartC=num;
            obj.num=num
            progress+=50;
            if(progress==100){
              res.send(obj)
            }
          })
          obj.code=1;
          obj.msg="加入成功"
          progress+=50;
          if(progress==100){
            res.send(obj)
          }
        })
        
      }
    })
    
  }else{
    obj={code:-1,msg:"请先登录"}
    res.send(obj)
  }
})


//功能八 查询购物车
app.get("/getcart",(req,res)=>{
  var uid=req.session.uid;
  if(uid){
    var sql2="SELECT id,pname,price,pid,count FROM JL_cart WHERE uid=?"
    pool.query(sql2,[uid],(err,result)=>{
      if(err) throw err
      var num=0;
      for(var item of result){
        num+=item.count
      }
        req.session.cartC=num
        if(result.length>0){
          result[0].num=req.session.cartC
          res.send(result)
          console.log(result)
        }else{
          res.send([{code:1,msg:"购物车还是空的",num:req.session.cartC}])
        }
    })
  }else{
    res.send({code:-1,msg:"请先登录"})
  }
})
//购物车商品数量变为0时，删除商品
app.get("/clearCart",(req,res)=>{
  var uid=req.session.uid;
  var pid=req.query.id;
  var sql="DELETE FROM JL_cart WHERE pid=? AND uid=?"
  pool.query(sql,[pid,uid],(err,result)=>{
    if(err) throw err
    res.send(result)
  })
})
//同步购物车
app.get("/cartupdate",(req,res)=>{
  var uid=req.session.uid;
  var pid=req.query.id;
  var count=req.query.count;
  var sql="UPDATE JL_cart SET count=? WHERE pid=? AND uid=?";
  pool.query(sql,[count,pid,uid],(err,result)=>{
    if(err) throw err
    if(result.affectedRows>0){
      res.send({code:1,msg:"购物车更新成功"})
    }else{
      res.send({code:-1,msg:"购物车更新失败"})
    }
  })
})





