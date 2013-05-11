package com.hr319wg.wage.ucc.impl;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;
import com.hr319wg.wage.pojo.bo.WageAdjustRuleBO;
import com.hr319wg.wage.pojo.vo.AdjustVO;
import com.hr319wg.wage.service.WageAdjustService;
import com.hr319wg.wage.ucc.IWageAdjustUCC;

public class WageAdjustUCC implements IWageAdjustUCC, IWFFunction {
	private WageAdjustService adjustservice;

	public WageAdjustService getAdjustservice() {
		return this.adjustservice;
	}

	public void setAdjustservice(WageAdjustService adjustservice) {
		this.adjustservice = adjustservice;
	}

	public List getAdjustList(PageVO pagevo, boolean isAppro, User user, String orgID, String name, String time, String time2) throws SysException {
		return this.adjustservice.getAdjustList(pagevo, isAppro, user, orgID, name, time, time2);
	}

	public WageAdjustBO getWageAdjustBO(String itemID) throws SysException {
		return this.adjustservice.getWageAdjustBO(itemID);
	}

	public AdjustVO getAdjustVO(String itemID) throws SysException {
		return this.adjustservice.getAdjustVO(itemID);
	}

	public AdjustVO descriptAdjustVO(AdjustVO vo) throws SysException {
		return this.adjustservice.descriptAdjustVO(vo);
	}

	public void saveWageAdjustBO(WageAdjustBO bo) throws SysException {
		this.adjustservice.saveWageAdjustBO(bo);
	}

	public void deleteAdjust(String itemID) throws SysException {
		this.adjustservice.deleteAdjust(itemID);
	}

	public void saveWageAdjustDetailBO(WageAdjustDetailBO bo)
			throws SysException {
		this.adjustservice.saveWageAdjustDetailBO(bo);
	}

	public WageAdjustRuleBO getWageAdjustRuleBO(String orgid)
			throws SysException {
		return this.adjustservice.getWageAdjustRuleBO(orgid);
	}

	public void saveWageAdjustRuleBO(WageAdjustRuleBO bo) throws SysException {
		this.adjustservice.saveWageAdjustRuleBO(bo);
	}

	public void deleteWageAdjustDetailBO(String adjustID) throws SysException {
		this.adjustservice.deleteWageAdjustDetailBO(adjustID);
	}

	public WageAdjustDetailBO getWageAdjustDetailBO(String adjustID)
			throws SysException {
		return this.adjustservice.getWageAdjustDetailBO(adjustID);
	}

	public List getAdjustDetail(String itemID) throws SysException {
		return this.adjustservice.getAdjustDetail(itemID);
	}

	public String ValidateAdjust(User user, String itemID) throws SysException {
		return this.adjustservice.ValidateAdjust(user, itemID);
	}

	public WageAdjustBO getWageAdjustBOByLinkID(String linkID)
			throws SysException {
		return this.adjustservice.getWageAdjustBOByLinkID(linkID);
	}

	public String getAdjustMemo(String itemID) throws SysException {
		return this.adjustservice.getAdjustMemo(itemID);
	}

	public String getAdjustMemoByLinkID(String linkID) throws SysException {
		return getAdjustMemoByLinkID(linkID);
	}

	public void createAdjustDetail(String personID, String itemID,
			String[] fields) throws SysException {
		this.adjustservice.createAdjustDetail(personID, itemID, fields);
	}

	public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine)
			throws SysException {
		return true;
	}

	public void whenStart(WFTransaction wt) throws SysException {
	}

	public void whenEnd(WFTransaction wt) throws SysException {
		WageAdjustBO bo = getWageAdjustBO(wt.getLinkID());
		if ("1".equals(wt.getStatusValue())) {
			bo.setStatus(WageAdjustBO.STATUS_OK);
		} else {
			bo.setStatus(WageAdjustBO.STATUS_NO);
		}
		saveWageAdjustBO(bo);
	}

	public void whenCreateNextNode(WFTransaction wt, WFNodeBO node)
			throws SysException {
	}
}