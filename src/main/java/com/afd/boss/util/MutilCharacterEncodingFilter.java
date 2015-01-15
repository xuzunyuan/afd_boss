package com.afd.boss.util;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.ClassUtils;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * 自定义编码过滤器
 */
public class MutilCharacterEncodingFilter extends OncePerRequestFilter {

	static final Pattern inputPattern = Pattern
			.compile(".*_input_encode=([\\w-]+).*");

	static final Pattern outputPattern = Pattern
			.compile(".*_output_encode=([\\w-]+).*");

	// Determine whether the Servlet 2.4
	// HttpServletResponse.setCharacterEncoding(String)
	// method is available, for use in the "doFilterInternal" implementation.
	private final static boolean responseSetCharacterEncodingAvailable = ClassUtils
			.hasMethod(HttpServletResponse.class, "setCharacterEncoding",
					new Class[] { String.class });

	private String encoding;

	private boolean forceEncoding = false;

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		String url = request.getQueryString();
		Matcher m = null;
		if (url != null && (m = inputPattern.matcher(url)).matches()) {// 输入编码
			String inputEncoding = m.group(1);
			request.setCharacterEncoding(inputEncoding);
			m = outputPattern.matcher(url);
			if (m.matches()) {// 输出编码
				response.setCharacterEncoding(m.group(1));
			} else {
				if (this.forceEncoding && responseSetCharacterEncodingAvailable) {
					response.setCharacterEncoding(this.encoding);
				}
			}
		} else {
			if (this.encoding != null
					&& (this.forceEncoding || request.getCharacterEncoding() == null)) {
				request.setCharacterEncoding(this.encoding);
				if (this.forceEncoding && responseSetCharacterEncodingAvailable) {
					response.setCharacterEncoding(this.encoding);
				}
			}
		}
		filterChain.doFilter(request, response);
	}

	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	public void setForceEncoding(boolean forceEncoding) {
		this.forceEncoding = forceEncoding;
	}
}
