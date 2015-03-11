package com.afd.boss.web;

import java.lang.reflect.InvocationTargetException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.afd.boss.util.PageUtils;
import com.afd.boss.util.PageUtils.PageInfo;
import com.afd.common.mybatis.Page;
import com.afd.common.util.CapthaUtils;
import com.afd.model.user.User;
import com.afd.service.user.IUserService;
import com.afd.service.user.IUserService.UserQueryCondition;

/**
 * 
 * 会员管理
 * 
 * @author xuzunyuan
 * @date 2015年3月11日
 */
@Controller
@RequestMapping("/user")
public class UserController {
	private static final Logger logger = LoggerFactory
			.getLogger(UserController.class);

	@Autowired
	IUserService userService;

	@RequestMapping("/query")
	public String userQuery(HttpServletRequest request) {
		// 处理分页信息
		PageInfo pageInfo = null;

		if (request.getParameter("query") != null) { // 查询
			pageInfo = PageUtils.registerPageInfo(request);

		} else if (request.getParameter("pageNo") != null) { // 分页
			int pageNo = NumberUtils.toInt(request.getParameter("pageNo"), 1);

			pageInfo = PageUtils.getPageInfo(request);
			pageInfo.setPageNo(pageNo);
		} else {
			pageInfo = PageUtils.getPageInfo(request);

			if (pageInfo == null) {
				pageInfo = PageUtils.registerPageInfo(request);
			}
		}

		request.setAttribute("pageInfo", pageInfo);

		UserQueryCondition cond = new UserQueryCondition();

		try {
			BeanUtils.copyProperties(cond, pageInfo.getConditions());
		} catch (IllegalAccessException | InvocationTargetException e) {
			logger.error(e.getMessage(), e);
		}

		Page<User> userPage = userService.queryUserByPage(cond,
				pageInfo.getPageNo());

		request.setAttribute("userPage", userPage);

		return "/user/query";
	}

	@RequestMapping("/resetPwd")
	@ResponseBody
	public String resetPwd(@Param("userId") long userId) {
		String randomPwd = CapthaUtils.getNumber(6);

		int result = userService.chgPwdById(userId, randomPwd);

		return result > 0 ? randomPwd : "";
	}
}
