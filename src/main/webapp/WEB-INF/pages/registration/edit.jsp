<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>挂号-- -2015</title>
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

</head>
<body>
<form action="${pageContext.request.contextPath}/registration/updateRegister" method="post" class="definewidth m20">
    <table class="table table-bordered table-hover definewidth m10">

        <input type="hidden" name="bingLiId" value="${regedit.bingLiId}"/>

        <tr>
            <td width="10%" class="tableleft">姓名</td>
            <td><input type="text" name="name" value="${regedit.name}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">证件类型</td>
            <td>
                <select id="idtype" name="identifierType">
                    <option value="身份证" ${regedit.identifierType == '身份证'?"selected='selected'":""}>身份证</option>
                    <option value="护照" ${regedit.identifierType == '护照'?"selected='selected'":""}>护照</option>
                    <option value="军人证" ${regedit.identifierType == '军人证'?"selected='selected'":""}>军人证</option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">证件号</td>
            <td><input type="text" name="identifier" value="${regedit.identifier}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">挂号费</td>
            <td><input type="text" name="guahaofei" value="${regedit.guahaofei}"/>元</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">社保号</td>
            <td><input type="text" name="insuranceint" value="${regedit.insuranceint}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">联系电话</td>
            <td><input type="text" name="phone" value="${regedit.phone}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">是否自费</td>
            <td>
                <input type="radio" name="expenseFlag" value="否" ${regedit.expenseFlag == '否'?'checked':''}/>否&nbsp;&nbsp;&nbsp;
                <input type="radio" name="expenseFlag" value="是" ${regedit.expenseFlag == '是'?'checked':''}/>是
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">性别</td>
            <td>
                <input type="radio" name="gender" value="1" ${regedit.gender == 1?'checked':''}/>男&nbsp;&nbsp;&nbsp;
                <input type="radio" name="gender" value="0" ${regedit.gender == 0?'checked':''}/>女
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">年龄</td>
            <td><input type="text" name="age" value="${regedit.age}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">职业</td>
            <td><input type="text" name="profession" value="${regedit.profession}"/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">初复诊</td>
            <td>
                <input type="radio" name="czflag" value="初诊" ${regedit.czflag == '初诊'?'checked':''}/>初诊&nbsp;&nbsp;&nbsp;
                <input type="radio" name="czflag" value="复诊" ${regedit.czflag == '复诊'?'checked':''}/>复诊
            </td>
        </tr>

        <tr>
            <td width="10%" class="tableleft">病例状态</td>
            <td>
                <select name="status">
                    <option value="1" ${regedit.status == 1?'selected':''}>已挂号</option>
                    <option value="2" ${regedit.status == 2?'selected':''}>已询医</option>
                    <option value="3" ${regedit.status == 3?'selected':''}>已出院</option>
                    <option value="4" ${regedit.status == 4?'selected':''}>已退号</option>
                </select>
            </td>
        </tr>

        <tr>
            <td width="10%" class="tableleft">所挂科室</td>
            <td>
                <select id="sgks" name="ks">
                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">指定医生</td>
            <td>
                <select id="doc" name="doctorId">

                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">备注</td>
            <td><textarea name="remark">${regedit.remark}</textarea></td>
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


        $('#backid').click(function () {
            // window.location.href="index.html";
            window.history.back(-1);
        });


        // 初始化所挂科室
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/dep/getDepsList",
            dataType: "JSON",
            success: function (result) {
                var depid = ${regedit.dep.depId};
                // alert();
                $.each(result, function (index, res) {
                    if (res.depId == depid) {
                        $("#sgks").append("<option value='" + res.depId + "'selected='selected'>" + res.depName + "</option>");
                    } else {
                        $("#sgks").append("<option value='" + res.depId + "'>" + res.depName + "</option>");
                    }
                })
                docindex(depid);
            },
            error: function () {
                alert("ajax 500!!");
            }
        });


        //    初始化医生的信息；


    });


    function docindex(depid) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/doctor/queryByDepId",
            data: {"depid": depid},
            dataType: "JSON",
            success: function (result) {
                var doctorid =  ${regedit.doctorId};
                $.each(result, function (index, res) {
                    if (res.doctorId == doctorid) {
                        $("#doc").append("<option value='" + res.doctorId + "'selected='selected' >" + res.name + "</option>");
                    } else {
                        $("#doc").append("<option value=" + res.doctorId + " >" + res.name + "</option>");
                    }
                });
            }
        })

    }
</script>
</body>
</html>