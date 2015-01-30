<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <title>下载待配送订单_订单管理</title>
</head>
<body>
<script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/static/js/datePicker/WdatePicker.js"></script>
<style type="text/css">
    a .code {
        color: #06c;
        text-decoration: underline;
    }
</style>
<div class="crumbs-box">
    <div class="crumbs">
           <h3>当前位置 &#58;</h3>
           <ul>
               <li>BOSS&#62;</li>
               <li>订单管理&#62;</li>
               <li>下载待配送订单</li>
           </ul>
    </div>
</div>
<div class="returns-search" style="height: auto;">
    <form id="myForm" action="${pageContext.request.contextPath}/order/tpl/ems/downloadList">
        <ul class="r-s-list clearfix">
            <li>
                <div class="r-s-left">生成日期：</div>
                <div class="r-s-left">
                    <label>
                        <input type="text" readonly="readonly" value="${searchDate}" id="searchDateText" name="searchDate" class="inputText inputDate"
                               onClick="new WdatePicker()"/>
                    </label>
                </div>
                <div class="r-s-left">
                    <input id="searchBtn" type="button" name="query" value="查&nbsp;&nbsp;&nbsp;询" class="inputBtn inputW2" >
                </div>
            </li>
        </ul>
    </form>
</div>
<div class="returns-list">
    <table id="myTable" class="boos-table" style="table-layout:auto;">
    <thead>
        <tr>
            <th>序号</th>
            <th>发货明细表名称</th>
            <th>生成时间</th>
            <th>操作</th>
        </tr>
        <tr><td colspan="9" class="table-space"></td></tr>
    </thead>
    <tbody>
    </tbody>
    <tfoot>
        <tr><td colspan="9" class="table-space"></td></tr>
    </tfoot>
    </table>
</div>
<script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/static/js/tpl/downloadListPage.js"></script>
<script language="javascript" type="text/javascript">
    hoursList = ${hoursList};
    searchDate = "${searchDate}";
    contextPath = "${pageContext.request.contextPath}";

    $().ready(function() {
        showDatas();
    });

    $(function() {
        $('#searchBtn').click(function () {
//            searchDate = $("#searchDateText").val();
//            showDatas();
            $("#myForm").submit();
        });
    });
</script>
</body>
</html>