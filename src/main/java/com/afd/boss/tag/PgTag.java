package com.afd.boss.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.afd.common.mybatis.Page;


public class PgTag extends TagSupport {
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
		if (this.page == null || this.page.getTotalRecord() == 0)
			return TagSupport.SKIP_BODY;
		JspWriter out = this.pageContext.getOut();
		StringBuffer pageHtml = new StringBuffer(); // 分页的html代码

		pageHtml.append("<div class=\"pagingWrap\">");

		// 上一页
		if (page.getCurrentPageNo() != 1) {
			pageHtml.append(
					"<div class=\"pageup\"> <a href=\"")
					.append(this.getHref(page.getPrevPageNo()))
					.append("\"><i class=\"ico\"></i>&nbsp;上一页</a></div>");
		} else {
			pageHtml.append("<div class=\"pageup disable\"><i class=\"ico\"></i>&nbsp;上一页</div>");
		}

		/** 中间页码 **/
		pageHtml.append("<ul>");

		// 页数小于7页
		if (page.getTotalPage() <= 7) {
			for (int i = 1; i <= page.getTotalPage(); i++) {
				if (page.getCurrentPageNo() == i) {
					pageHtml.append("<li><span class=\"on\">").append(i)
							.append("</span></li>");
				} else {
					pageHtml.append("<li><a href=\"")
							.append(getHref(i)).append("\">").append(i)
							.append("</a></li>");
				}
			}
		}
		// 页数大于7页
		else {
			if (page.getCurrentPageNo() == 1) {
				pageHtml.append("<li><span class=\"on\">1</span></li>");
			} else {
				pageHtml.append("<li><a href=\"")
				.append(getHref(1)).append("\">1")
				.append("</a></li>");
			}

			if ((page.getCurrentPageNo() - 1 > 3)
					&& (page.getLastPageNo() - page.getCurrentPageNo() > 3)) {
				pageHtml.append("<li><b>...</b></li>");
				
				pageHtml.append("<li><a href=\"")
				.append(getHref(page.getCurrentPageNo() - 2)).append("\">").append(page.getCurrentPageNo() - 2)
				.append("</a></li>");
				
				pageHtml.append("<li><a href=\"")
				.append(getHref(page.getCurrentPageNo() - 1)).append("\">").append(page.getCurrentPageNo() - 1)
				.append("</a></li>");
				
				pageHtml.append("<li><span class=\"on\">")
						.append(page.getCurrentPageNo()).append("</span></li>");

				pageHtml.append("<li><a href=\"")
				.append(getHref(page.getCurrentPageNo() + 1)).append("\">").append(page.getCurrentPageNo() + 1)
				.append("</a></li>");
				
				pageHtml.append("<li><a href=\"")
				.append(getHref(page.getCurrentPageNo() + 2)).append("\">").append(page.getCurrentPageNo() + 2)
				.append("</a></li>");
				pageHtml.append("<li><b>...</b></li>");
			} else if (page.getLastPageNo() - page.getCurrentPageNo() <= 3) {
				pageHtml.append("<li><b>...</b></li>");
				for (int i = 5; i > 0; i--) {
					if (page.getCurrentPageNo() == (page.getLastPageNo() - i)) {
						pageHtml.append("<li><span class=\"on\">")
								.append(page.getLastPageNo() - i)
								.append("</span></li>");
					} else {
						pageHtml.append("<li><a href=\"")
						.append(getHref(page.getLastPageNo() - i)).append("\">").append(page.getLastPageNo() - i)
						.append("</a></li>");
					}
				}
			} else if (page.getCurrentPageNo() - 1 <= 3) {
				for (int i = 2; i < 7; i++) {
					if (page.getCurrentPageNo() == i) {
						pageHtml.append("<li><span class=\"on\">").append(i)
								.append("</span></li>");
					} else {
						pageHtml.append("<li><a href=\"")
						.append(getHref(i)).append("\">").append(i)
						.append("</a></li>");
					}
				}
				pageHtml.append("<li><b>...</b></li>");
			}
			if (page.getCurrentPageNo() == page.getLastPageNo()) {
				pageHtml.append("<li><span class=\"on\">")
						.append(page.getLastPageNo()).append("</span></li>");
			} else {
				pageHtml.append("<li><a href=\"")
				.append(getHref(page.getLastPageNo())).append("\">").append(page.getLastPageNo())
				.append("</a></li>");
			}

		}

		pageHtml.append("</ul>");

		// 下一页
		if (page.getCurrentPageNo() == page.getTotalPage()) {
			pageHtml.append("<div class=\"pagedown disable\">下一页&nbsp;<i class=\"ico\"></i></div>");
		} else {
			pageHtml.append("<div class=\"pagedown\"><a href=\"")
			.append(getHref(page.getNextPageNo())).append("\">下一页&nbsp;<i class=\"ico\"></i></a></div>");
		}

		// 到第..页
		pageHtml.append("<div class=\"goto\"><span>到第</span>")
				.append("<input type=\"text\" class=\"num\" maxPage=\"")
				.append(page.getTotalPage())
				.append("\"><span>页</span><button class=\"btn\" action=\"")
				.append(this.action).append("\">确定</button></div>");

		pageHtml.append("</div>");

		// 总计
		pageHtml.append("<div class=\"count\">共<em>")
				.append(page.getTotalRecord()).append("</em>条记录，本页显示<em>")
				.append(page.getResult().size()).append("</em>条</div>");

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
