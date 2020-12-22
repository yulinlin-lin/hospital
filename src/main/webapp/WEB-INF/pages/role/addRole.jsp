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
<form action="${pageContext.request.contextPath}/role/add" method="post" class="definewidth m20">
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">角色名称</td>
            <td><input type="text" name="resname"/></td>
        </tr>
        <tr>
            <td class="tableleft">状态</td>
            <td>
                <input type="radio" name="status" value="0" checked/> 启用
                <input type="radio" name="status" value="1"/> 禁用
            </td>
        </tr>
        <tr>
            <td class="tableleft">权限</td>
            <td id="authority">
                <%--<ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>挂号信息管理</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>门诊医生管理</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>药品管理</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>住院办理</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>收费项目登记</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>在院发药</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>住院结算</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>月营业额统计</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>年营业额统计</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>用户管理</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>角色管理</label></ul>
                <ul><label class='checkbox inline'><input type='checkbox' name='group[]' value=''/>资源管理</label></ul>--%>
            </td>
        </tr>
        <tr>
            <td class="tableleft"></td>
            <td>
                <button type="button" class="btn btn-primary" id="sub" type="button" onclick="subAddRole();">添加</button> &nbsp;&nbsp;
                <button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
<script>
    $(function () {
        $(':checkbox[name="group[]"]').click(function () {
            $(':checkbox', $(this).closest('li')).prop('checked', this.checked);
        });

        $('#backid').click(function () {
            window.history.back(-1);
        });

        indexResources();
    });


    function indexResources() {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/resource/getAllResources",
            dataType: "json",
            success: function (obj) {
                $.each(obj, function (index, res) {
                    var utl = "<ul><label class='checkbox inline'><input type='checkbox' name='group[]' value="+res.resId+">"+ res.resname +"</label></ul>"
                    $("#authority").append(utl);
                });
            },
            error: function () {
                alert("发生了严重错误！ 返回值类型不是想要的检查一下controller");
            }
        });
    }



    function subAddRole() {
        let sta = $("input[name='status']:checked").val();
        var idAll="";
        var name=$("input[name='resname']").val();
        $(":checkbox:checked").each(function() {
            var id=$(this).val()+",";     //将选取商品的id存入到一个字符串中,用-隔开
            idAll+=id;
        });

        // alert(sta);
        // alert(idAll)
        // alert(name)
        //
        // return;
        if(idAll==""){
            alert("请选择权限!");
            return;
        }else{
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/role/add",
                data: {"status":sta,"idAll":idAll,"rolename":name},
                dataType: "json",
                success: function (obj) {
                    if(obj.code == 0){
                     window.location.href = "${pageContext.request.contextPath}/role/index/1/5";
                    }else{
                        alert(obj.msg);
                    }
                },
                error: function () {
                    alert("发生了严重错误！ 返回值类型不是想要的检查一下controller");
                }
            });

        }


    }


</script>