<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>门诊查询-- -2015</title>
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

        /*点击  添加挂号信息的   返回添加页面*/
        $(function () {
            $('#newNav').click(function () {
                window.location.href = "${pageContext.request.contextPath}/topage/registration/add";
            });
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
            var idds = "";
            for (var i = 0; i < alls.length; i++) {
                if (alls[i].checked) {
                    ids.push(alls[i].value);
                    idds += alls[i].value+",";
                }
            }
            if (ids.length > 0) {
                if (confirm("确认操作?")) {
                    $.ajax({
                       type: "POST",
                       url: "${pageContext.request.contextPath}/registration/BounceMore",
                       data: {"idds":idds},
                       dataType: "JSON",
                       success: function (result) {
                           window.location.reload();
                       },
                        error: function () {
                            alert("ajax发生了严重的错误！");
                        }
                    });
                }
            } else {
                alert("请选中要操作的项");
            }
        }
    </script>
</head>
<body>

<form id="fm" action="#" method="post" class="definewidth m20">
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">病历号：</td>
            <td><input type="text" name="bingLiId" value="${bingLiId}"/></td>

            <td width="10%" class="tableleft">主治医生：</td>
            <td><input type="text" name="doctorName" value="${doctorName}"/></td>

            <td width="10%" class="tableleft">科室：</td>
            <td><input type="text" name="depName" value="${depName}"/></td>
        </tr>
        <tr>

            <td width="10%" class="tableleft">挂号时间：</td>

            <td colspan="5">
                <input type="text" name="startCreateTime" value="${startCreateTime}"/>&nbsp;至&nbsp;
                <input type="text" name="endCreateTime" value="${endCreateTime}"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <button type="submit" class="btn btn-primary" onclick="queryRegistration();" type="button" >查询</button>
                <button  class="btn btn-primary" onclick="clearVlaue();" type="button">清空</button>
            </td>
        </tr>
    </table>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th><input type="checkbox" id="checkall" onChange="checkall();"></th>
        <th>门诊编号</th>
        <th>主治医生</th>
        <th>挂号时间</th>
        <th>挂号科室</th>
        <th>挂号病人</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <c:forEach items="${pg1.list}" var="r">
        <tr>
            <td style="vertical-align:middle;"><input type="checkbox" name="check" value="${r.bingLiId}"></td>
            <td style="vertical-align:middle;">${r.dep.depCode}</td>
            <td style="vertical-align:middle;">${r.d.name}</td>
            <td style="vertical-align:middle;">${r.createTime}</td>
            <td style="vertical-align:middle;">${r.dep.depName}</td>
            <td style="vertical-align:middle;">${r.name}</td>
            <c:if test="${r.status == 1}">
                <td style="vertical-align:middle;">已挂号</td>
            </c:if>

            <c:if test="${r.status == 2}">
                <td style="vertical-align:middle;">已询医</td>
            </c:if>

            <c:if test="${r.status == 3}">
                <td style="vertical-align:middle;">已出院</td>
            </c:if>

            <c:if test="${r.status == 4}">
                <td style="vertical-align:middle;">已退号</td>
            </c:if>·

            <td style="vertical-align:middle;">
                <a href="${pageContext.request.contextPath}/registration/queryRegisterById?id=${r.bingLiId}">详情>>></a>&nbsp;&nbsp;&nbsp;
                <a href="${pageContext.request.contextPath}/registration/editRegisterById?id=${r.bingLiId}">更改</a>&nbsp;&nbsp;&nbsp;
                <a href="${pageContext.request.contextPath}/registration/Bounce?id=${r.bingLiId}">退号</a>
            </td>
        </tr>
    </c:forEach>


</table>
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <th colspan="5">
            <div class="inline pull-right page">
<%--                <a href='${pageContext.request.contextPath}/registration/index/1/${pg1.pageSize}'>第一页</a>--%>
                <a href='javascript:jumpPage(1);'>第一页</a>

                <c:if test="${pg1.prePage>=1}">
<%--                    <a href='${pageContext.request.contextPath}/registration/index/${pg1.prePage}/${pg1.pageSize}'>上一页</a>--%>
                    <a href='javascript:jumpPage(${pg1.prePage});'>上一页</a>
                </c:if>


                <c:choose>
                    <%--页数没有超过 6 页的情况--%>
                    <c:when test="${pg1.pages <= 6}">
                        <c:set var="begin" value="1"></c:set>
                        <c:set var="end" value="${pg1.pages}"></c:set>
                    </c:when>
                    <%--页数超过了 6 页的情况--%>
                    <c:otherwise>
                        <c:set var="begin" value="${pg1.prePage}"></c:set>
                        <c:set var="end" value="${pg1.pageNum + 3}"></c:set>

                        <%--如果begin减 1 后为  0   设置超始页为 1 最大页为  6 --%>
                        <c:if test="${begin -1 <= 0}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="6"/>
                        </c:if>

                        <%--如果end超过最大页,设置起始页=最大页-5--%>
                        <c:if test="${end > pg1.pages}">
                            <c:set var="begin" value="${pg1.pages - 5}"/>
                            <c:set var="end" value="${pg1.pages}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>


                <c:forEach var="i" begin="${begin}" end="${end}">
                    <c:choose>
                        <c:when test="${i == pg1.pageNum}">
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


                <c:if test="${pg1.nextPage<=pg1.pages&&pg1.nextPage!=0 }">
                    <a href='javascript:jumpPage(${pg1.nextPage});'>下一页</a>
                </c:if>
<%--                <a href='${pageContext.request.contextPath}/registration/index/${pg1.pages}/${pg1.pageSize}'>最后一页</a>--%>
                <a href='javascript:jumpPage(${pg1.pages});'>最后一页</a>
                &nbsp;&nbsp;&nbsp;共<span class='current'>${pg1.total}</span>条记录<span
                    class='current'> ${pg1.pageNum}/${pg1.pages} </span>页
            </div>
            <div>
                <button type="button" class="btn btn-success" id="newNav" onclick="addNewReg();">门诊挂号</button>&nbsp;&nbsp;&nbsp;
                <button type="button" class="btn btn-success" id="delPro" onClick="delAll();">退号</button>&nbsp;&nbsp;&nbsp;
                <button type="button" class="btn btn-success" onclick="exportToExcel();" id="exportExcel">导出Excel</button>
                <button type="button" class="btn btn-success" id="prin">打印</button>
            </div>

        </th>
    </tr>
</table>



<script>


    $(document).keydown(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == '13'){

            queryRegistration();
        }
    })


    /*$(function () {

    });*/



    /*
    清空
    */
    function clearVlaue() {
        $('input[name="bingLiId"]').val("");
        $('input[name="doctorName"]').val("");
        $('input[name="depName"]').val("");
        $('input[name="startCreateTime"]').val("");
        $('input[name="endCreateTime"]').val("");
    };



    /***
     * 导出到excel
     */
    function exportToExcel() {
        var url = "${pageContext.request.contextPath}/registration/dbExportToExcel";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }


    function queryRegistration() {
        var url = "${pageContext.request.contextPath}/registration/index/1/5";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }


    function jumpPage(pageNum) {
        var url = "${pageContext.request.contextPath}/registration/index/" + pageNum + "/${pg1.pageSize}";
        $("#fm").prop("action",url);
        $("#fm").submit();
    }





</script>

</body>
</html>
