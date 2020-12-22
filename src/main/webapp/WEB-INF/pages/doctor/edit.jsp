<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>修改医生---2015</title>
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
                // window.location.href="index.html";
                window.history.back(-1);
            });
        });
    </script>
</head>
<body>
<form action="${pageContext.request.contextPath}/doctor/editBydoctorId" method="post" class="definewidth m20">
    <table class="table table-bordered table-hover definewidth m10">

        <input type="hidden" name="doctorId" value="${doctor.doctorId}" />

        <tr>
            <td width="10%" class="tableleft">姓名</td>
            <td><input type="text" name="name" value="${doctor.name}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">证件类型</td>
            <td>
                <select name="identifierType">
                    <option value="1" ${doctor.identifierType == 1?"selected='selected'":""}>身份证</option>
                    <option value="2" ${doctor.identifierType == 2?"selected='selected'":""}>护照</option>
                    <option value="3" ${doctor.identifierType == 3?"selected='selected'":""}>军人证</option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">证件号</td>
            <td><input type="text" name="identifier" value="${doctor.identifier}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">手机</td>
            <td><input type="text" name="phone" value="${doctor.phone}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">座机</td>
            <td><input type="text" name="telephone" value="${doctor.telephone}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">性别</td>
            <td><input type="radio" name="gender" value="1" ${doctor.gender == 1?'checked':''}/>男&nbsp;&nbsp;&nbsp;
                <input type="radio" name="gender" value="0" ${doctor.gender == 0?'checked':''}/>女
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">出生年月</td>
            <td><input type="text" name="birthDate" value="${doctor.birthDate}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">年龄</td>
            <td><input type="text" name="age" value="${doctor.age}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">电子邮箱</td>
            <td><input type="text" name="email" value="${doctor.email}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">所属科室</td>
            <td>
                <select id="ssks" name="depid">
                    <%--<option>急诊科</option>
                    <option>骨科</option>
                    <option>血液科</option>--%>
                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">学历</td>
            <td>
                <select name="degree">
                    <option value="1" ${doctor.degree == 1?'selected':''}>专科</option>
                    <option value="2" ${doctor.degree == 2?'selected':''}>本科</option>
                    <option value="3" ${doctor.degree == 3?'selected':''}>博士</option>
                    <option value="4" ${doctor.degree == 4?'selected':''}>博士后</option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">备注</td>
            <td><textarea name="remark">此人表现优异工作非常的积极！</textarea></td>
        </tr>
        <tr>
            <td colspan="2">
                <center>
                    <button type="submit" class="btn btn-primary" type="button">保存</button> &nbsp;&nbsp;<button
                        type="button" class="btn btn-success" name="backid" id="backid">返回列表
                </button>
                </center>
            </td>
        </tr>
    </table>
</form>


<script type="text/javascript">
    $(function () {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/dep/getDepsList",
            dataType: "JSON",
            success: function (result) {
                var depid = ${doctor.dep.depId};
                // alert();
                $.each(result, function (index, res) {
                    if (res.depId == depid) {
                        $("#ssks").append("<option value='" + res.depId + "'selected='selected'>" + res.depName + "</option>");
                    } else {
                        $("#ssks").append("<option value='" + res.depId + "'>" + res.depName + "</option>");
                    }
                })
                /*                docindex(depid);*/
            },
            error: function () {
                alert("ajax 500!!");
            }
        });
    })
</script>
</body>
</html>