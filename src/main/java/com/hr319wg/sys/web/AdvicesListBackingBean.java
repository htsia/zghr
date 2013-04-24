package com.hr319wg.sys.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.AdvicesBO;
import com.hr319wg.sys.ucc.IAdvicesUCC;
import com.hr319wg.user.pojo.bo.RoleInfoBO;

public class AdvicesListBackingBean extends BaseBackingBean {
	private IAdvicesUCC advucc;
	private List advList;
	private String initSender;
	private String initRec;
	private String operID;
	private boolean all;
	private ICommonService commonService;
	
	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public String getOperID() {
		return operID;
	}

	public void setOperID(String operID) {
		this.operID = operID;
	}

	public boolean isAll() {
		return this.all;
	}

	public void setAll(boolean b) {
		this.all = b;
	}

	public void setInitRec(String init) {
		this.initRec = init;
	}

	public List getAdvList() {
		if (this.advList == null) {
			this.advList = new ArrayList();
		}
		return this.advList;
	}

	public void setAdvList(List li) {
		this.advList = li;
	}

	public void changeAll(ValueChangeEvent event) {
		if (event.getNewValue().toString().equals("true")) {
			this.all = true;
		} else
			this.all = false;
	}

	public IAdvicesUCC getAdvucc() {
		return this.advucc;
	}

	public void setAdvucc(IAdvicesUCC ucc) {
		this.advucc = ucc;
	}
	
	public String getInitSender() {
		try {
			if (this.all) {
				this.advList = this.advucc.getALLMyAdvice(super.getUserInfo()
						.getUserId());
			} else {
				this.advList = this.advucc.getALLMyAdviceNotReply(super
						.getUserInfo().getUserId());
			}
			for (int i = 0; i < this.advList.size(); i++) {
				AdvicesBO abo = (AdvicesBO) this.advList.get(i);
				if ("1".equals(abo.getAdvReplyed())) {
					abo.setAdvReplyed("ÊÇ");
				} else {
					abo.setAdvReplyed("·ñ");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.initSender;
	}

	public void setInitSender(String init) {
		this.initSender = init;
	}

	public String getInitRec() {
		try {
			User user = super.getUserInfo();
			boolean getAll = RoleInfoBO.ORGTYPE_ALL.equals(user
					.getprocessUnit());
			if (this.all) {
				this.advList = this.advucc.getALL(user.getOrgId(), getAll);
			} else {
				this.advList = this.advucc.getALLNotReply(user.getOrgId(),
						getAll);
			}
			for (int i = 0; i < this.advList.size(); i++) {
				AdvicesBO abo = (AdvicesBO) this.advList.get(i);
				if ("1".equals(abo.getAdvReplyed())) {
					abo.setAdvReplyed("ÊÇ");
				} else {
					abo.setAdvReplyed("·ñ");
				}
				abo.setAdvSendName(SysCacheTool.findPersonById(
						abo.getAdvSender()).getName());
				abo.setAdvOrgName(SysCacheTool.findOrgById(abo.getAdvOrg())
						.getName());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.initRec;
	}

	public void delete(){
		try {
			this.commonService.deleteAdvice(this.operID);
			super.showMessageDetail("É¾³ýÍê³É");
		} catch (SysException e) {
			super.showMessageDetail("É¾³ýÊ§°Ü");
			e.printStackTrace();
		}
	}
}