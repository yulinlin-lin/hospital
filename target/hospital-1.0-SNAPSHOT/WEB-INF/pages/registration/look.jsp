<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>查看-- -2015</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/style.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.js"></script>
<%--    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.sorted.js"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/ckform.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/ckeditor/ckeditor.js"></script>
 

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
		$('#backid').click(function(){
				<%--window.location.href="${pageContext.request.contextPath}/registration/index/1/5";--%>
            window.history.back(-1);
		 });
    });
    </script>
</head>
<body>
<form action="index.html" method="post" class="definewidth m20">
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="10%" class="tableleft">姓名</td>
        <td>${reg.name}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">证件类型</td>
        <td>${reg.identifierType}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">证件号</td>
        <td>${reg.identifier}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">挂号费</td>
        <td>${reg.guahaofei}元</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">社保号</td>
        <td>${reg.insuranceint}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">联系电话</td>
        <td>${reg.phone}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">性别</td>


        <c:choose>
            <c:when test="${reg.gender == 1}">
                <td>男</td>
            </c:when>
            <c:otherwise>
                <td>女</td>
            </c:otherwise>
        </c:choose>


    </tr>
    <tr>
        <td width="10%" class="tableleft">是否自费</td>
        <td>${reg.expenseFlag}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">年龄</td>
        <td>${reg.age}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">职业</td>
        <td>${reg.profession}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">初复诊</td>
        <td>${reg.czflag}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">病例状态</td>${reg.status}
        <c:if test="${reg.status == 1}"><td>已挂号</td></c:if>
        <c:if test="${reg.status == 2}"><td>已询医</td></c:if>
        <c:if test="${reg.status == 3}"><td>已出院</td></c:if>
        <c:if test="${reg.status == 4}"><td>已退号</td></c:if>
    </tr>

    <tr>
        <td width="10%" class="tableleft">所挂科室</td>
        <td>${reg.dep.depName}</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">指定医生</td>
        <td>${reg.d.name}</td>
    </tr>
	<tr>
        <td width="10%" class="tableleft">备注</td>
        <td>${reg.remark}</td>
	</tr>
    <tr>
        <td colspan="2">
			<center>
				<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
			</center>
		</td>
    </tr>
</table>
</form>


<script type="text/javascript">

    function goBack() {
        window.location.href = "${pageContext.request.contextPath}/registration/index/1/5";
    }

</script>
</body>
</html>