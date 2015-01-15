package com.afd.boss.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.afd.common.mybatis.Page;


public class PageTag extends TagSupport {
	private static final Logger logger = Logger.getLogger(TagSupport.class);
	private static final long serialVersionUID = 6349370307595637390L;

	private Page<?> page;
	private String action;

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public Page<?> getPage() {
		return page;
	}

	public void setPage(Page<?> page) {
		this.page = page;
	}

	@Override
	public int doStartTag() throws JspException {
		if (this.page.getTotalRecord() == 0)
			return TagSupport.SKIP_BODY;
		JspWriter out = this.pageContext.getOut();
		StringBuffer pageHtml = new StringBuffer(); // 分页的html代码

		pageHtml.append("<div class=\"pagination\">")
				.append("<div class=\"page-allnum\">").append("共")
				.append(page.getTotalRecord()).append("条记录，本页显示")
				.append(page.getResult().size()).append("条").append("</div>")
				.append("  <div class=\"inner\">");

		// 上一页
		if (page.getCurrentPageNo() != 1) {
			pageHtml.append(
					"<span class=\"prev\" onclick=\"javascript:location.href='")
					.append(this.getHref(page.getCurrentPageNo() - 1))
					.append("'\"><i class=\"triangle\"></i><span>上一页</span></span>");
		} else {
			pageHtml.append("<span class=\"prev disabled\"><i class=\"triangle\"></i><span>上一页</span></span>");
		}

		int start = ((page.getCurrentPageNo() - 1) / 5) * 5 + 1;
		int end = ((page.getCurrentPageNo() - 1) / 5) * 5 + 5;

		// 第一页
		if (start > 1) {
			pageHtml.append("<a class=\"btn\" href=\"").append(getHref(1))
					.append("\">1</a><span>...</span>");
		}

		// 中间5条
		for (int i = start; i <= end; i++) {
			if (i <= page.getTotalPage()) {
				pageHtml.append("<a class=\"")
						.append(i == page.getCurrentPageNo() ? "active" : "btn")
						.append("\" href=\"").append(getHref(i)).append("\">")
						.append(i).append("</a>");
			}
		}

		// 最后一页
		if (page.getTotalPage() > end) {
			pageHtml.append("<span>...</span><a class=\"btn\" href=\"")
					.append(getHref(page.getTotalPage())).append("\">")
					.append(page.getTotalPage()).append("</a>");
		}

		// 下一页
		if (page.getCurrentPageNo() == page.getTotalPage()) {
			pageHtml.append("<span class=\"next disabled\"><i class=\"triangle\"></i><span>下一页</span></span>");
		} else {
			pageHtml.append(
					"<span class=\"next\" onclick=\"javascript:location.href='")
					.append(this.getHref(page.getCurrentPageNo() + 1))
					.append("'\"><i class=\"triangle\"></i><span>下一页</span></span>");
		}

		// 到第..页
		pageHtml.append("<span class=\"text\">到第</span>")
				.append("<input class=\"num\" name=\"pageNo\">")
				.append("<span class=\"text\">页</span>")
				.append("<button class=\"submit\" type=\"button\" ")
				.append("action=\"").append(this.action)
				.append("\">确定</button>");

		pageHtml.append("</div></div>");

		try {
			out.print(pageHtml.toString());
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		return TagSupport.SKIP_BODY;
	}

	private String getHref(int pageNo) {
		return (this.action + (this.action.indexOf("?") != -1 ? "&" : "?")
				+ "pageNo=" + pageNo);
	}

	@Override
	public int doEndTag() throws JspException {
		return TagSupport.EVAL_PAGE;
	}
}
