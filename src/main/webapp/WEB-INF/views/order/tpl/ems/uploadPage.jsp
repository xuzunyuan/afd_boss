<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <title></title>
</head>
<body>
<div class="crumbs-box">
    <div class="crumbs">
        <h3>当前位置 &#58;</h3>
        <ul>
            <li><a href="#">BOSS</a>&#62;</li>
            <li><a href="#">订单管理</a>&#62;</li>
            <li>上传已配送订货单</li>
        </ul>
    </div>
</div>
<!--crumbs-box end-->
<div class="goods-Uplodaing">
    <div class="category-main">
        <!-- relateType -->
        <div class="result">
            <div class="hintBar clearfix">
                <dl>
                    <dt><i class="i-exclaim" style="background:url(${pageContext.request.contextPath}/static/img/UpLoading.png) no-repeat;"></i></dt>
                    <dd>
                        <div class="hintBox">
                            <h2>请注意：</h2>

                            <p>· 请将接收到的EMS回传《一网全城订单发货明细表》文件，直接上传，不需修改文件内容及格式； </p>

                            <p>·《一网全城订单发货明细表》成功上传后，系统将会同步更新对应的订单状态、支付状态及付款金额，请谨慎操作！</p>
                        </div>
                    </dd>
                </dl>
            </div>
        </div>
        <!-- relateType end -->
        <!-- resultUploding -->
        <div class="resultUploding clearfix">
            <form id="myForm" action="${pageContext.request.contextPath}/order/tpl/ems/upload" method="post" enctype="multipart/form-data">
                <div class="crumbs">上传订单发货明细</div>
                <dl>
                    <dt>选择本地文件：</dt>
                    <dd><input id="uploadFile" type="file" name="file" class="txt" accept=".xlsx"/>
                        <input type="button" id="submitBtn" class="btn btnC" value="上传"/>
                    </dd>
                </dl>
                <dl>
                    <dt></dt>
                    <dd>
                        <p>提示：</p>

                        <p>1.本地上传图片大小不能超过3M</p>

                        <p>2.上传文件格式限制为 .xlsx </p>
                    </dd>
                </dl>
            </form>
        </div>
        <!-- resultUploding end-->
    </div>
    <!--category-main end-->
</div>
<!--main end-->
<div class="mask-bg" style="display: none;"></div>
<div class="mask-show" id="orderpop" style="top: 30%;left: 40%;width: 550px;height: 190px;display:none;">
    <h2>
        操作确认<a title="关闭" onclick="$('div.mask-bg').hide();$('#orderpop').hide();">关闭</a>
    </h2>

    <div id="orderidlist" style="margin-top: 20px;">
        <div style="text-align:center;">
            <blockquote>点击“确定”，将成功上传订单发货明细，系统处理后不允许修改。</blockquote>
            <blockquote>点击“取消”，取消本次上传操作，并可重新选择上传文件。</blockquote>
        </div>
        <div style="margin: 30px 0 0 0">
            <button type="button" class="inputBtn" id="uploadBtn" style="margin: 0 0 0 100px">确&nbsp;&nbsp;&nbsp;定
            </button>
            <button type="button" class="inputBtn" id="cancelBtn" style="margin: 0 100px 0 200px">取&nbsp;&nbsp;&nbsp;消
            </button>
        </div>
    </div>
</div>
<script language="javascript" type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/tpl/uploadPage.js"></script>
<script type="text/javascript">
    var obj = <c:out value="${result}" default="null" escapeXml="false"/>;
    $().ready(function () {
        showInfo();
    });
    function showInfo() {
        if (!(null === obj)) alert(obj.info);
    }
</script>
</body>
</html>