<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %> 
<%@taglib uri="/WEB-INF/tld/page.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/tld/pg.tld" prefix="p"%>
<%@ taglib uri="/WEB-INF/tld/pageNew.tld" prefix="pgNew"%>
<%@ taglib uri="/WEB-INF/tld/pageMini.tld" prefix="pgMini"%>

<%	
	int i = new java.util.Random().nextInt(6);
	request.setAttribute("imgDownDomain", "http://img"+i+".yiwangimg.com/rc/getimg?rid=");
	request.setAttribute("ctx", request.getContextPath());
	request.setAttribute("imgDownPrefix", "http://img");
	request.setAttribute("imgDownSuffix", ".yiwangimg.com/rc/getimg?rid=");
	request.setAttribute("count", 6);
%>
<%request.setAttribute("prodUrl", "http://item.yiwang.com/detail/"); %>
<%request.setAttribute("prodSnapUrl", "http://member.yiwang.com/trade/order/tradesnapshot/"); %>
