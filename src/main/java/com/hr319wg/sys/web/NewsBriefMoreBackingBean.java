package com.hr319wg.sys.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.sys.pojo.vo.NewsEditVO;
import com.hr319wg.sys.ucc.INewsManageUCC;
import com.hr319wg.sys.ucc.INewsQueryUCC;
import com.hr319wg.util.CommonFuns;

public class NewsBriefMoreBackingBean extends BaseBackingBean {
	private INewsManageUCC newsmanageucc;
	private List newsList;
	private List newsList2;
	private String initDetail;
	private NewsEditVO newsvo = new NewsEditVO();
	private INewsQueryUCC newsqueryucc;
	private String status = "1";

	public List getNewsList2() {
		try {
			this.newsList2 = this.newsqueryucc.queryPublicNews();
		} catch (Exception e) {
		}
		return this.newsList2;
	}

	public void setNewsList2(List newsList2) {
		this.newsList2 = newsList2;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String st) {
		this.status = st;
	}

	public void setNewsqueryucc(INewsQueryUCC vo) {
		this.newsqueryucc = vo;
	}

	public INewsQueryUCC getNewsqueryucc() {
		return this.newsqueryucc;
	}

	public void setNewsvo(NewsEditVO vo) {
		this.newsvo = vo;
	}

	public NewsEditVO getNewsvo() {
		return this.newsvo;
	}

	public void changeStatus(ValueChangeEvent event) {
		this.status = event.getNewValue().toString();
		getNewsList();
	}

	public String getInitDetail() {
		try {
			String id = getServletRequest().getParameter("newsid");
			if ((id == null) && ("".equalsIgnoreCase(id))) {
				return "";
			}
			HashMap hm = this.newsqueryucc.queryNewsParamAndContent(id);
			this.newsvo.setTopic((String) hm.get("topic"));
			this.newsvo.setEndDate((String) hm.get("endDate"));
			this.newsvo.setStartDate((String) hm.get("startDate"));
			this.newsvo.setContent((String) hm.get("content"));
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		}
		return this.initDetail;
	}

	public void setInitDetail(String detail) {
		this.initDetail = detail;
	}

	public List getNewsList() {
		try {
			String strToday = CommonFuns.getSysDate("yyyy-MM-dd");
			User user = super.getUserInfo();
			this.newsList = new ArrayList();
			String superID=super.getRequestParameter("superId");
			boolean orNotWork=false;
			if("0".equals(this.status)){
				orNotWork=true;
			}
			if ( superID!= null) {
				this.newsList = this.newsmanageucc.queryNewsParamByOrgId(superID, null, null, orNotWork);
			} else {
				this.newsList = this.newsmanageucc.queryNewsParam(user, orNotWork);
			}
		} catch (Exception e) {
			this.msg.setMainMsg(e, NewsBriefMoreBackingBean.class);
		}

		return this.newsList;
	}

	public void setNewsList(List newsList) {
		this.newsList = newsList;
	}

	public INewsManageUCC getNewsmanageucc() {
		return this.newsmanageucc;
	}

	public void setNewsmanageucc(INewsManageUCC newsmanageucc) {
		this.newsmanageucc = newsmanageucc;
	}
}