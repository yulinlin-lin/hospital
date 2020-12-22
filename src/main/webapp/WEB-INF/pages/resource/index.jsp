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
<form id="fm" class="form-inline definewidth m20" action="${pageContext.request.contextPath}/resource/index/1/${pg6.pageSize}" method="post">
    资源(菜单)名称：
    <input type="text" name="resname" id="resname" class="abc input-default" placeholder="" value="${resname}">&nbsp;&nbsp;
    <button type="submit" class="btn btn-primary" id="search">查询</button>
    <button type="button" class="btn btn-primary" onclick="clearVlaue();">清空</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th width="5%"><input type="checkbox" id="checkall" onChange="checkall();"></th>
        <th>资源名称</th>
        <th>路径Url</th>
        <th>是否有效</th>
        <th width="10%">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${pg6.list}" var="r">
        <tr>
            <td style="vertical-align:middle;"><input type="checkbox" name="check" value="1"></td>
            <td>${r.resname}</td>
            <td>${r.resurl}</td>
            <c:choose>
                <c:when test="${r.status == 0}">
                    <td>有效</td>
                </c:when>
                <c:otherwise><td>无效</td></c:otherwise>
            </c:choose>

            <td>
                <a href="${pageContext.request.contextPath}/resource/edit?rid=${r.resId}">编辑</a>&nbsp;&nbsp;&nbsp;
                <a href="javascript:deleteresource(${r.resId});">删除</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>

</table>
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <th colspan="5">
            <div class="inline pull-right page">
                <a href='javascript:jumpPage(1);'>第一页</a>

                <c:if test="${pg6.prePage>=1}">
                    <a href='javascript:jumpPage(${pg6.prePage});'>上一页</a>
                </c:if>


                <c:choose>
                    <%--页数没有超过 6 页的情况--%>
                    <c:when test="${pg6.pages <= 6}">
                        <c:set var="begin" value="1"></c:set>
                        <c:set var="end" value="${pg6.pages}"></c:set>
                    </c:when>
                    <%--页数超过了 6 页的情况--%>
                    <c:otherwise>
                        <c:set var="begin" value="${pg6.prePage}"></c:set>
                        <c:set var="end" value="${pg6.pageNum + 3}"></c:set>

                        <%--如果begin减 1 后为  0   设置超始页为 1 最大页为  6 --%>
                        <c:if test="${begin -1 <= 0}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="6"/>
                        </c:if>

                        <%--如果end超过最大页,设置起始页=最大页-5--%>
                        <c:if test="${end > pg6.pages}">
                            <c:set var="begin" value="${pg6.pages - 5}"/>
                            <c:set var="end" value="${pg6.pages}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>


                <c:forEach var="i" begin="${begin}" end="${end}">
                    <c:choose>
                        <c:when test="${i == pg6.pageNum}">
                            <span class='current'>${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href='javascript:jumpPage(${i});'>${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>


                <c:if test="${pg6.nextPage<=pg6.pages&&pg6.nextPage!=0 }">
                    <a href='javascript:jumpPage(${pg6.nextPage});'>下一页</a>
                </c:if>
                <a href='javascript:jumpPage(${pg6.pages});'>最后一页</a>
                &nbsp;&nbsp;&nbsp;共<span class='current'>${pg6.total}</span>条记录<span
                    class='current'> ${pg6.pageNum}/${pg6.pages} </span>页
            </div>
            <div>
                <button type="button" class="btn btn-success" id="newNav">添加新资源</button>
                <button type="button" class="btn btn-success" id="delPro" onclick="exportToExcel();">导出Excel</button>
            </div>

        </th>
    </tr>
</table>


<script type="text/javascript">

    /***
     * 导出到excel
     */
    function exportToExcel() {

        var url = "${pageContext.request.contextPath}/resource/dbExportToExcel";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }
    $(function () {
        $('#newNav').click(function () {
            window.location.href = "${pageContext.request.contextPath}/topage/resource/add";
        });


        //回车事件
        document.onkeydown = function (event) {
            var e = event || window.event;
            if (e && e.keyCode == 13) { //回车键的键值为13
                $("#search").click(); //调用登录按钮的登录事件
            }
        };
    });


    function checkall() {
        var alls = document.getElementsByName("check");
        var ch = document.getElementById("checkall");
        if (ch.checked) {
            for (var i = 0; i < alls.length; i++) {
                alls[i].checked = true;
            }
        } else {
            for (var i = 0; i < alls.length; i++) {
                alls[i].checked = false;
            }
        }
    }

    function delAll() {
        var alls = document.getElementsByName("check");
        var ids = new Array();
        for (var i = 0; i < alls.length; i++) {
            if (alls[i].checked) {
                ids.push(alls[i].value);
            }
        }
        if (ids.length > 0) {
            if (confirm("确认删除?")) {
                alert("删除成功!");
            }
        } else {
            alert("请选中要删除的项");
        }
    }



    function jumpPage(pageNum) {
        var url = "${pageContext.request.contextPath}/resource/index/" + pageNum + "/${pg6.pageSize}";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }


    function clearVlaue() {
        $('input[name="resname"]').val("");
    };


    function deleteresource(resId) {
        var flag = confirm("确定要删除吗？");
        if (flag){
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/resource/deleteById",
                data:{"resId":resId},
                dataType: "json",
                success: function (obj) {
                    if(obj.code == 0){
                        window.location.href = "${pageContext.request.contextPath}/resource/index/1/${pg6.pageSize}";
                    }else{
                        alert(obj.msg);
                    }
                },
                error: function () {
                    alert("发生了严重错误！ 返回值类型不是想要的检查一下controller");
                }
            });
        }else{
            return ;
        }
    }
</script>
</body>
</html>