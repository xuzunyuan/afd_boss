/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.afd.boss.web;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 登入、登出控制器
 * 
 * @author xuzunyuan
 * @date 2013年12月25日
 */
@Controller
public class LoginController {
	private final static Logger logger = LoggerFactory
			.getLogger(LoginController.class);

	/**
	 * 进入登录界面
	 * 
	 * @return
	 */
	@RequestMapping("/login")
	public String login() {
		Subject currentUser = SecurityUtils.getSubject();

		// 如已登录直接定向到主工作台，否则显示登录界面
		return currentUser.isAuthenticated() ? "redirect:/" : "login/login";
	}

	/**
	 * 登录验证，通过进入主工作台，否则返回登录界面并提示错误信息
	 * 
	 * @param loginName
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "/login/validate", method = RequestMethod.POST)
	public String validate(@RequestParam("loginName") String loginName,
			@RequestParam("password") String password,
			RedirectAttributes redirectAttributes) {
		Subject currentUser = SecurityUtils.getSubject();

		UsernamePasswordToken token = new UsernamePasswordToken(loginName,
				password);

		token.setRememberMe(false);
		try {
			currentUser.login(token);
			return "redirect:/";

		} catch (AuthenticationException e) {
			redirectAttributes.addFlashAttribute("loginError", e.getMessage());

			return "redirect:/login";
		}
	}

	/**
	 * 登出功能，完成后定向到登录界面
	 * 
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout() {
		SecurityUtils.getSubject().logout();

		return "login/login";
	}
}
