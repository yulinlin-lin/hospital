<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>查看-- -2015</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap-responsive.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/style.css"/>
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
            $('#backid').click(function () {
                window.history.back(-1);
            });
        });
    </script>
</head>
<body>
<form action="index.html" method="post" class="definewidth m20">
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">药品编号</td>
            <td>${drug.drugsId}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">图片</td>
            <td><img src="${pageContext.request.contextPath}/imgs/drug/${drug.drugUrl}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">进价</td>
            <td>${drug.purchasingPrice}元</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">售价</td>
            <td>${drug.sellingPrice}元</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">药品名称</td>
            <td>${drug.drugName}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">药品类型</td>
            <c:if test="${drug.drugType == 1}"><td>中药</td></c:if>
            <c:if test="${drug.drugType == 2}"><td>西药</td></c:if>
            <c:if test="${drug.drugType == 3}"><td>处方药</td></c:if>
            <c:if test="${drug.drugType == 4}"><td>非处方药</td></c:if>
        </tr>
        <tr>
            <td width="10%" class="tableleft">简单描述</td>
            <td>${drug.description}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">生产日期</td>
            <td>${drug.productionDate}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">保质期</td>
            <td>${drug.shelfLife}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">过期日期</td>
            <td>${drug.expirationDate}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">详细描述</td>
            <td>${drug.detail}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">生产厂商</td>
            <td>${drug.manufacturer}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">服用说明</td>
            <td>${drug.directions}</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">库存</td>
            <td>${drug.countpurchases}袋</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">剩余量</td>
            <td>${drug.inventory}袋</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">备注</td>
            <td>${drug.remark}</td>
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
</body>
</html>