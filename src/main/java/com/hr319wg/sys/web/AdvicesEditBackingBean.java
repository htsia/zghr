package com.hr319wg.sys.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.OrgAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.AdvicesBO;
import com.hr319wg.sys.ucc.IAdvicesUCC;
import com.hr319wg.util.CommonFuns;

public class AdvicesEditBackingBean extends BaseBackingBean {
	private IAdvicesUCC advucc;
	private OrgAPI orgapi;
	private List orgList;
	private AdvicesBO advbo = new AdvicesBO();
	private String initSend;
	private String initReply;

	public void setInitSend(String str) {
		this.initSend = str;
	}

	public String getInitSend() {
		this.advbo = new AdvicesBO();
		this.advbo.setAdvReplyed("0");
		return this.initSend;
	}

	public void setInitReply(String str) {
		this.initReply = str;
	}

	public String getInitReply() {
		try {
			String advID = super.getRequestParameter("advID");
			this.advbo = this.advucc.getAdviceByID(advID);
			this.advbo.setAdvSendName(SysCacheTool.findPersonById(
					this.advbo.getAdvSender()).getName());
			this.advbo.setAdvOrgName(SysCacheTool.findOrgById(
					this.advbo.getAdvOrg()).getName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.initReply;
	}

	public void setOrgapi(OrgAPI api) {
		this.orgapi = api;
	}

	public OrgAPI getOrgapi() {
		return this.orgapi;
	}

	public List getOrgList() {
		if (this.orgList != null)
			return this.orgList;
		this.orgList = new ArrayList();
		try {
			String[] org = this.orgapi.getOrgTree(super.getUserInfo()
					.getOrgId());
			for (int i = 0; i < org.length; i++) {
				OrgBO obo = SysCacheTool.findOrgById(org[i]);
				if(obo==null){
					continue;
				}
				SelectItem si = new SelectItem();
				si.setLabel(obo.getName());
				si.setValue(obo.getOrgId());
				this.orgList.add(si);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.orgList;
	}

	public void setOrgList(List list) {
		this.orgList = list;
	}

	public void setAdvbo(AdvicesBO bo) {
		this.advbo = bo;
	}

	public AdvicesBO getAdvbo() {
		return this.advbo;
	}

	public String saveAdvices() {
		try {
			this.advbo.setAdvSender(super.getUserInfo().getUserId());
			this.advbo.setAdvSenddate(CommonFuns.getSysDate("yyyy-MM-dd"));
			this.advucc.SaveAdvice(this.advbo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String replyAdvices() {
		try {
			this.advbo.setAdvReplyer(super.getUserInfo().getUserId());
			this.advbo.setAdvReplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			this.advbo.setAdvReplyed("1");
			this.advucc.SaveAdvice(this.advbo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public IAdvicesUCC getAdvucc() {
		return this.advucc;
	}

	public void setAdvucc(IAdvicesUCC ucc) {
		this.advucc = ucc;
	}
}