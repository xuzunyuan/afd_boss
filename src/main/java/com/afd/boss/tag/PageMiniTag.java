package com.afd.boss.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.afd.common.mybatis.Page;


public class PageMiniTag extends TagSupport{
	private static final long serialVersionUID = -1785744234603993353L;
	
	private Page<?> page;
	private String name;
	private String formId;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFormId() {
		return formId;
	}

	public void setFormId(String formId) {
		this.formId = formId;
	}

	public Page<?> getPage() {
		return page;
	}

	public void setPage(Page<?> page) {
		this.page = page;
	}

	@Override
	public int doStartTag() throws JspException {
		//获取分页bean
		JspWriter out = this.pageContext.getOut();
		
		//分页的html代码
		StringBuffer pageHtml = new StringBuffer();
		
		pageHtml.append("<div class=\"pagingMini\">");
		pageHtml.append("	<div class=\"pagingBtn\">");
		if(page.getCurrentPageNo() == 1){			
			pageHtml.append("		<a href=\"javascript:void(0)\" class=\"pageUp disable\"></a>");
		}else{
			pageHtml.append("		<a href=\"javascript:void(0)\" onclick=\""+this.name+"("+page.getPrevPageNo()+");\" class=\"pageUp\"></a>");
		}
		if(page.getCurrentPageNo() == page.getLastPageNo()){			
			pageHtml.append("		<a href=\"javascript:void(0)\" class=\"pageDown disable\"></a>");
		}else{
			pageHtml.append("		<a href=\"javascript:void(0)\" onclick=\""+this.name+"("+page.getNextPageNo()+");\" class=\"pageDown\"></a>");
		}
		pageHtml.append("	</div>");
		pageHtml.append("	<div class=\"pageNum\"><span><b>"+page.getCurrentPageNo()+"</b></span>/<span>"+page.getPageSize()+"</span></div>");
		pageHtml.append("	<div class=\"count\">共<em>"+page.getTotalRecord()+"</em>条记录，本页显示<em>"+page.getPageSize()+"</em>条</div>");
		pageHtml.append("</div>");
		
		pageHtml.append("<script>");
		pageHtml.append("function "+this.name+"(selectPageNo){");
		pageHtml.append("$(\"#"+this.formId+"\").append('<input type=\"hidden\" name=\"currentPageNo\" value=\"'+selectPageNo+'\" />');");
		pageHtml.append("$(\"#"+this.formId+"\").submit();");
		pageHtml.append("}");
		pageHtml.append("</script>");
		
		try {
			out.print(pageHtml.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return super.doStartTag();
	}
	
	@Override
	public int doEndTag() throws JspException {
		return super.doEndTag();
	}
}
