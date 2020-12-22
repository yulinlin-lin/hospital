<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>门诊医生</title>
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
    <script type="text/javascript">
        $(function () {
            $('#newNav').click(function () {
                window.location.href = "${pageContext.request.contextPath}/topage/doctor/add";
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

    </script>
</head>
<body>

<form id="fm" action="${pageContext.request.contextPath}/doctor/index/1/5" method="post" class="definewidth m20">
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">医生编号：</td>
            <td><input type="text" name="doctorId" value="${conditionDoctorId}"/></td>

            <td width="10%" class="tableleft">医生姓名：</td>
            <td><input type="text" name="name" value="${conditionName}"/></td>

            <td width="10%" class="tableleft">科室：</td>
            <td><input type="text" name="depName" value="${conditionDepName}"/></td>
        </tr>
        <tr>
            <td colspan="6">
                <center>
                    <button type="submit" class="btn btn-primary" id="search" type="button">查询</button>
                    <button type="button" class="btn btn-primary" onclick="clearVlaue();">清空</button>
                </center>
            </td>
        </tr>
    </table>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th><input type="checkbox" id="checkall" onChange="checkall();"></th>
        <th>医生编号</th>
        <th>医生姓名</th>
        <th>入院时间</th>
        <th>所属科室</th>
        <th>手机</th>
        <th>性别</th>
        <th>学历</th>
        <th>操作</th>
    </tr>
    </thead>
    <c:forEach items="${pg2.list}" var="d">
        <tr>
            <td style="vertical-align:middle;"><input type="checkbox" name="check" value="${d.doctorId}"></td>
            <td style="vertical-align:middle;">${d.doctorId}</td>
            <td style="vertical-align:middle;">${d.name}</td>
            <td style="vertical-align:middle;">${d.createTime}</td>
            <td style="vertical-align:middle;">${d.dep.depName}</td>
            <td style="vertical-align:middle;">${d.phone}</td>
            <c:choose>
                <c:when test="${d.gender == 1}"><td style="vertical-align:middle;">男</td></c:when>
                <c:otherwise><td style="vertical-align:middle;">女</td></c:otherwise>
            </c:choose>
            <c:if test="${d.degree == 1}"><td style="vertical-align:middle;">专科</td></c:if>
            <c:if test="${d.degree == 2}"><td style="vertical-align:middle;">本科</td></c:if>
            <c:if test="${d.degree == 3}"><td style="vertical-align:middle;">博士</td></c:if>
            <c:if test="${d.degree == 4}"><td style="vertical-align:middle;">博士后</td></c:if>
            <td style="vertical-align:middle;"><a href="${pageContext.request.contextPath}/doctor/look/${d.doctorId}">详情>>></a>&nbsp;&nbsp;&nbsp;
                <a href="${pageContext.request.contextPath}/doctor/edit/${d.doctorId}">更改</a>
            </td>
        </tr>
    </c:forEach>


</table>

<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <th colspan="5">
            <div class="inline pull-right page">
                <a href='javascript:jumpPage(1);'>第一页</a>

                <c:if test="${pg2.prePage>=1}">
                    <a href='javascript:jumpPage(${pg2.prePage});'>上一页</a>
                </c:if>


                <c:choose>
                    <%--页数没有超过 6 页的情况--%>
                    <c:when test="${pg2.pages <= 6}">
                        <c:set var="begin" value="1"></c:set>
                        <c:set var="end" value="${pg2.pages}"></c:set>
                    </c:when>
                    <%--页数超过了 6 页的情况--%>
                    <c:otherwise>
                        <c:set var="begin" value="${pg2.prePage}"></c:set>
                        <c:set var="end" value="${pg2.pageNum + 3}"></c:set>

                        <%--如果begin减 1 后为  0   设置超始页为 1 最大页为  6 --%>
                        <c:if test="${begin -1 <= 0}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="6"/>
                        </c:if>

                        <%--如果end超过最大页,设置起始页=最大页-5--%>
                        <c:if test="${end > pg2.pages}">
                            <c:set var="begin" value="${pg2.pages - 5}"/>
                            <c:set var="end" value="${pg2.pages}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>


                <c:forEach var="i" begin="${begin}" end="${end}">
                    <c:choose>
                        <c:when test="${i == pg2.pageNum}">
                            <span class='current'>${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href='javascript:jumpPage(${i});'>${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <%--<a href='#'>2</a>
                <a href='/chinapost/index.php?m=Label&a=index&p=3'>3</a>
                <a href='#'>4</a>--%>


                <c:if test="${pg2.nextPage<=pg2.pages&&pg2.nextPage!=0 }">
                    <a href='javascript:jumpPage(${pg2.nextPage});'>下一页</a>
                </c:if>
                <a href='javascript:jumpPage(${pg2.pages});'>最后一页</a>
                &nbsp;&nbsp;&nbsp;共<span class='current'>${pg2.total}</span>条记录<span
                    class='current'> ${pg2.pageNum}/${pg2.pages} </span>页
            </div>
            <div>
                <button type="button" class="btn btn-success" id="newNav">添加新医生</button>
                <button type="button" class="btn btn-success" id="delPro" onclick="exportToExcel();">导出Excel</button>
            </div>

        </th>
    </tr>
</table>


<script>


    function queryDoctors() {
        var url = "${pageContext.request.contextPath}/doctor/index/1/5";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }



    function jumpPage(pageNum) {
        var url = "${pageContext.request.contextPath}/doctor/index/" + pageNum + "/${pg2.pageSize}";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }




    function clearVlaue() {
        $('input[name="doctorId"]').val("");
        $('input[name="name"]').val("");
        $('input[name="depName"]').val("");
    };



    /***
     * 导出到excel
     */
    function exportToExcel() {

        var url = "${pageContext.request.contextPath}/doctor/dbExportToExcel";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }

</script>
</body>
</html>
