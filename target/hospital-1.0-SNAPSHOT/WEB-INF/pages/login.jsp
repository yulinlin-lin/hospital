<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>韶关市第二人民医院管理系统</title>
	<meta charset="UTF-8">
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/style.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.js"></script>
<%--    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.sorted.js"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/ckform.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/common.js"></script>
    <style type="text/css">
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
        }

        .form-signin {
            max-width: 300px;
            padding: 19px 29px 29px;
            margin: 0 auto 20px;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
        }

        .form-signin .form-signin-heading,
        .form-signin .checkbox {
            margin-bottom: 10px;
        }
        .form-signin input[type="text"],
        .form-signin input[type="password"] {
            font-size: 16px;
            height: auto;
            margin-bottom: 15px;
            padding: 7px 9px;
        }
    </style>  
</head>
<body>
<div class="container">
    <form class="form-signin" method="post" action="${pageContext.request.contextPath}/login">
        <h2 class="form-signin-heading">&nbsp;&nbsp;&nbsp;登录系统</h2>
        <input type="text" id="username" name="username" value="admin" class="input-block-level" placeholder="账号">
        <input type="password" id="password" name="password" value="admin" class="input-block-level" placeholder="密码">
  <%--      <input type="text" name="verify" class="input-medium" placeholder="验证码">这里有一个图片后期再做--%>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn btn-large btn-primary" type="submit">登录</button></p>
    </form>
</div>


<script>

    function userLogin() {
        let username = $("#username").val();
        let password = $("#password").val();
        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/user/login",
            data: {"username":username,"password":password},
            dataType: "json",
            success: function (res) {
                if (res.code == 1001){
                    alert(res.msg);
                }else{
                    location.href = "${pageContext.request.contextPath}/index"
                }
            }
        });
    }



</script>
</body>
</html>