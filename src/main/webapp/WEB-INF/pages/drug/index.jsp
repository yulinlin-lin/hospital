<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>药品查询----2015</title>
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

<form id="fm" action="${pageContext.request.contextPath}/drugs/index/1/5" method="post" class="definewidth m20">
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">药品名称：</td>
            <td><input type="text" name="drugName" value="${drName}"/></td>

            <td width="10%" class="tableleft">药品类型：</td>
            <td>
                <select name="drugType">
                    <option value="" id="psele">--请选择--</option>
                    <option value="1" ${(drType != null and drType == 1)?"selected='selected'":""}>中药</option>
                    <option value="2" ${(drType != null and drType == 21)?"selected='selected'":""}>西药</option>
                    <option value="3" ${(drType != null and drType == 3)?"selected='selected'":""}>处方</option>
                    <option value="4" ${(drType != null and drType == 4)?"selected='selected'":""}>非处方</option>
                </select>
            </td>
        </tr>
        <tr>


            <td colspan="4">
                <center>
                    <button type="submit" class="btn btn-primary" id="search" type="button">查询</button>
                    <button type="button" class="btn btn-primary" onclick="clearVlaue()" >清空</button>
                </center>
            </td>
        </tr>
    </table>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th><input type="checkbox" id="checkall" onChange="checkall();"></th>
        <th>药品编号</th>
        <th>药品名称</th>
        <th>药品类型</th>
        <th>简单描述</th>
        <th>状态</th>
        <th>剩余量</th>
        <th>操作</th>
    </tr>
    </thead>

    <c:forEach items="${pg3.list}" var="dr">
        <tr>
            <td style="vertical-align:middle;"><input type="checkbox" name="check" value="1"></td>
            <td style="vertical-align:middle;">${dr.drugsId}</td>
            <td style="vertical-align:middle;">${dr.drugName}</td>
            <c:if test="${dr.drugType == 1}"><td style="vertical-align:middle;">中药</td></c:if>
            <c:if test="${dr.drugType == 2}"><td style="vertical-align:middle;">西药</td></c:if>
            <c:if test="${dr.drugType == 3}"><td style="vertical-align:middle;">处方</td></c:if>
            <c:if test="${dr.drugType == 4}"><td style="vertical-align:middle;">非处方</td></c:if>
            <td style="vertical-align:middle;">${dr.description}</td>
            <c:choose>
                <c:when test="${dr.drugflag == 1}"><td style="vertical-align:middle;">销售中</td></c:when>
                <c:otherwise><td style="vertical-align:middle;">已停售</td></c:otherwise>
            </c:choose>
            <td style="vertical-align:middle;">${dr.inventory}袋</td>
            <td style="vertical-align:middle;">
                <a href="javascript:alert(${dr.drugsId}'修改成功了哦！');">更改</a>&nbsp;&nbsp;&nbsp;
                <a href="${pageContext.request.contextPath}/drugs/look/${dr.drugsId}">详情>>></a>
            </td>
        </tr>
    </c:forEach>

</table>
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <th colspan="5">
            <div class="inline pull-right page">
                <a href='javascript:jumpPage(1);'>第一页</a>

                <c:if test="${pg3.prePage>=1}">
                    <a href='javascript:jumpPage(${pg3.prePage});'>上一页</a>
                </c:if>


                <c:choose>
                    <%--页数没有超过 6 页的情况--%>
                    <c:when test="${pg3.pages <= 6}">
                        <c:set var="begin" value="1"></c:set>
                        <c:set var="end" value="${pg3.pages}"></c:set>
                    </c:when>
                    <%--页数超过了 6 页的情况--%>
                    <c:otherwise>
                        <c:set var="begin" value="${pg3.prePage}"></c:set>
                        <c:set var="end" value="${pg3.pageNum + 3}"></c:set>

                        <%--如果begin减 1 后为  0   设置超始页为 1 最大页为  6 --%>
                        <c:if test="${begin -1 <= 0}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="6"/>
                        </c:if>

                        <%--如果end超过最大页,设置起始页=最大页-5--%>
                        <c:if test="${end > pg3.pages}">
                            <c:set var="begin" value="${pg3.pages - 5}"/>
                            <c:set var="end" value="${pg3.pages}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>


                <c:forEach var="i" begin="${begin}" end="${end}">
                    <c:choose>
                        <c:when test="${i == pg3.pageNum}">
                            <span class='current'>${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href='javascript:jumpPage(${i});'>${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>


                <c:if test="${pg3.nextPage<=pg3.pages&&pg3.nextPage!=0 }">
                    <a href='javascript:jumpPage(${pg3.nextPage});'>下一页</a>
                </c:if>
                <a href='javascript:jumpPage(${pg3.pages});'>最后一页</a>
                &nbsp;&nbsp;&nbsp;共<span class='current'>${pg3.total}</span>条记录<span
                    class='current'> ${pg3.pageNum}/${pg3.pages} </span>页
            </div>
            <div>
                <button type="button" class="btn btn-success" id="newNav">添加新药品</button>
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

        var url = "${pageContext.request.contextPath}/drugs/dbExportToExcel";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }

    $(function () {
        $('#newNav').click(function () {
            window.location.href = "${pageContext.request.contextPath}/topage/drug/add";
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
            if (confirm("确认操作?")) {
                alert("成功!");
            }
        } else {
            alert("请选中要操作的项");
        }
    }


    function jumpPage(pageNum) {
        var url = "${pageContext.request.contextPath}/drugs/index/" + pageNum + "/${pg3.pageSize}";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }


    function clearVlaue() {
        $('input[name="drugName"]').val("");
        $("#psele").prop("selected",true);
    };
</script>
</body>
</html>
