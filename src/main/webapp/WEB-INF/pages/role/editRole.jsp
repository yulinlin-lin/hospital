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
<form action="#" method="post" class="definewidth m20">
    <table class="table table-bordered table-hover definewidth m10">
        <input type="text" name="roleId" value="${role.roleId}">
        <tr>
            <td width="10%" class="tableleft">角色名称</td>
            <td><input type="text" name="resname" value="${role.roleName}"/></td>
        </tr>
        <tr>
            <td class="tableleft">状态</td>
            <td>
                <input type="radio" name="status" value="0" ${role.status == 0?'checked':''}/> 启用
                <input type="radio" name="status" value="1" ${role.status == 1?'checked':''}/> 禁用
            </td>
        </tr>
        <tr>
            <td class="tableleft">权限</td>
            <td id="authority">
            </td>
        </tr>
        <tr>
            <td class="tableleft"></td>
            <td>
                <button type="button" class="btn btn-primary" type="button" onclick="subAddRole();">更新</button> &nbsp;&nbsp;<button
                    type="button" class="btn btn-success" name="backid" id="backid">返回列表
            </button>
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

                //把当前这个角色所拥有的权限资源的id整成一个数组；
                var arr = new Array();
                <c:forEach items="${role.resources}" var="resour">
                    arr.push(${resour.resId});
                </c:forEach>


                $.each(obj, function (index, res) {
                    //判断所有的资源的id  ，一个一个地判断是否在数组里面，如果在，则添加的是已经选中的，如果不在，则直接添加就好
                    var value = $.inArray(res.resId,arr);
                    var utl = "";
                    if(value != -1){
                        utl = "<ul><label class='checkbox inline'><input type='checkbox' checked name='group[]' value="+res.resId+">"+ res.resname +"</label></ul>"
                        $("#authority").append(utl);
                    }else{
                        utl = "<ul><label class='checkbox inline'><input type='checkbox' name='group[]' value="+res.resId+">"+ res.resname +"</label></ul>"
                        $("#authority").append(utl);
                    }
                });
            },
            error: function () {
                alert("发生了严重错误！ 返回值类型不是想要的检查一下controller");
            }
        });
    }



    //提交修改
    function subAddRole() {
        let sta = $("input[name='status']:checked").val();
        let roleId = $("input[name='roleId']").val();
        var idAll="";
        var name=$("input[name='resname']").val();
        $(":checkbox:checked").each(function() {
            var id=$(this).val()+",";     //将选取商品的id存入到一个字符串中,用-隔开
            idAll+=id;
        });

        if(idAll==""){
            alert("请选择权限!");
            return;
        }else{
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/role/edit",
                data: {"status":sta,"idAll":idAll,"rolename":name,"roleId":roleId},
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