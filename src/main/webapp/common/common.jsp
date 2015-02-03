<%@page import="com.afd.common.util.PropertyUtils"%>
<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %> 
<%@taglib prefix="my" uri="/WEB-INF/tld/my.tld"%>
<%@taglib uri="/WEB-INF/tld/page.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/tld/pg.tld" prefix="p"%>
<%@ taglib uri="/WEB-INF/tld/pageNew.tld" prefix="pgNew"%>
<%@ taglib uri="/WEB-INF/tld/pageMini.tld" prefix="pgMini"%>

<%	
	request.setAttribute("ctx", request.getContextPath()); 
	PropertyUtils.setRequestProperties(request);
%>

