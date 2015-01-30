<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="pagination">
    <div class="page-allnum">共${page.totalRecord}条记录，本页显示${ fn:length(page.result)}条</div>  
    <div class="inner">  
    <c:set var="showpagenums" value="10"/>
    <c:set var="pagetotal" value="${page.totalRecord/page.pageSize}"/>
    <c:if test="${page.totalRecord%page.pageSize>0}">
    <c:set var="pagetotal" value="${page.totalRecord/page.pageSize+1}"/>
    </c:if> 
    <c:set var="beginnum" value="${page.currentPageNo-showpagenums/2}"/>
    <c:if test="${page.currentPageNo-showpagenums/2<1}">
    <c:set var="beginnum" value="1"/>	
    </c:if>
    <c:set var="endnum" value="${page.currentPageNo+showpagenums/2-1}"/>
    <c:if test="${page.currentPageNo+showpagenums/2-1>pagetotal}">
    <c:set var="endnum" value="${pagetotal}"/>	
    </c:if>
    
    <span  class="prev <c:if test="${page.currentPageNo-1<=0}">disabled</c:if>"><i class="triangle"></i>
    <span <c:if test="${page.currentPageNo-1>=0}"> onclick="nextpage(${page.currentPageNo-1},'frm')"  </c:if>>上一页</span>
    </span>
    <c:forEach var="item" varStatus="status" begin="${beginnum}" end="${endnum}" step="1">
    
     <a <c:if test="${status.index!=page.currentPageNo}">class="btn"</c:if> href="javascript:void(0);"  onclick="nextpage(${status.index},'frm')" <c:if test="${status.index==page.currentPageNo}">class="active"</c:if> >${status.index}</a>
 
   </c:forEach>
   
    
    <span  class="next <c:if test="${page.currentPageNo+1>pagetotal}">disabled</c:if>">
    <i class="triangle"></i>
    <span <c:if test="${page.currentPageNo+1<pagetotal}"> onclick="nextpage(${page.currentPageNo+1},'frm')" </c:if>>下一页</span>
    </span>
    <span class="text">到第</span>
    <input name="pageNoIpnut"  id="pageNoIpnut" class="num"><span class="text">页</span>
    <button type="button" id="submitbut" onclick="nextpage(0,'frm')" class="submit">确定</button>
    </div>
    </div>
  <script type="text/javascript">
function nextpage(type,formname){
	var re =/^[1-9]\d*$/;
	var pageNo=type;
	if(type==0){
		pageNo=$("#pageNoIpnut").val();
	}
    if (type==0&&(!re.test(pageNo)))
   {
       alert("必须为正整数!");
       $("#pageNoIpnut").focus();
       return false;
    }
	$("#"+formname).attr("action", "${ctx}${actionname}"+pageNo);
	$("#"+formname).submit();
}

function querydata(formname){
	$("#"+formname).attr("action", "${ctx}${actionname}1");
	$("#"+formname).submit();
}
</script>
