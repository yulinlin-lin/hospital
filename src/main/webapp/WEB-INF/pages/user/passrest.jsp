<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap-responsive.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.js"></script>
    <%--    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.sorted.js"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/ckform.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/common.js"></script>
    <style type="text/css">
        body {
            padding-bottom: 40px;
        }

        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }


    </style>
</head>
<body>
<form method="post" class="definewidth m20">

    <table class="table table-bordered table-hover definewidth m10">
        <input type="hidden" name="userid" value="${sessionScope.user.userid}">
        <tr>
            <td width="10%" class="tableleft">当前用户登录名</td>
            <td>${sessionScope.user.no}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">当前用户真名</td>
            <td>${sessionScope.user.realname}</td>
        </tr>

        <tr>
            <td width="10%" class="tableleft">旧密码</td>
            <td><input type="text" name="oldPass" value=""/></td>
        </tr>
        <tr>
            <td class="tableleft">新密码</td>
            <td><input type="text" name="newPass" value=""/></td>
        </tr>

        <tr>
            <td class="tableleft"></td>
            <td>
                <button type="button" class="btn btn-primary" type="button" onclick="updatePass();">更新</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
<script>
    $(function () {
        $('#backid').click(function () {
            window.location.href = "${pageContext.request.contextPath}/user/index/1/5";
        });
    });


    function updatePass() {
        let userid = $("input[name='userid']").val();
        let oldPass = $("input[name='oldPass']").val();
        let newPass = $("input[name='newPass']").val();

        // alert(userid);
        // alert(oldPass);
        // alert(newPass);
        // return ;

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/user/passRest",
            data: {"userid":userid,"oldPass":oldPass,"newPass":newPass},
            dataType: "json",
            success: function (result) {
                if (result.code == 0){
                    alert(result.msg);
                    window.location.href = "../login.jsp";
                }else{
                    alert(result.msg);
                }
            },
            error: function () {
                alert("500 ajax");
            }
        });

    }
</script>