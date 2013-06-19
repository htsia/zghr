package com.hr319wg.sys.web;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.user.pojo.bo.SelfInfoPowerBO;
import com.hr319wg.user.ucc.ISelfInfoPowerUCC;

public class SelfInfoListBackingBean extends BaseBackingBean {
	public static String INFOITEM_NAME = "infoitem_name";
	public static String INFOSET_NAME = "infoset_name";
	private ISelfInfoPowerUCC selfinfoUCC;
	private ICommonService commonService;

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public String getPageInit() {
		try {
			List setList = this.selfinfoUCC.getSelfInfoSet(super.getUserInfo().getOrgId());
			super.getServletRequest().setAttribute(INFOSET_NAME, setList);

			Hashtable itemList = this.selfinfoUCC.getSelfInfoItem(super.getUserInfo().getOrgId());
			super.getServletRequest().setAttribute(INFOITEM_NAME, itemList);
		} catch (Exception e) {
		}
		return this.pageInit;
	}

	public String Save() {
		try {
			HttpServletRequest request = getServletRequest();
			Enumeration enum1 = request.getParameterNames();
			Hashtable dataHash = new Hashtable();
			while (enum1.hasMoreElements()) {
				String name = (String) enum1.nextElement();
				String pmsType = request.getParameter(name);
				if ((name.startsWith("tab")) || (name.startsWith("fld"))) {
					SelfInfoPowerBO data = new SelfInfoPowerBO();
					data.setDataId(name.substring(3));
					data.setOrgID(super.getUserInfo().getOrgId());
					data.setPmsType(pmsType);
					if (name.startsWith("tab"))
						data.setDataType("0");
					else
						data.setDataType("1");
					dataHash.put(data.getDataId(), data);
				}
			}
			this.selfinfoUCC.updatePowerData(super.getUserInfo().getOrgId(), dataHash);
			this.commonService.updateSelfDataPower(super.getUserInfo().getOrgId());
			showMessageDetail("´æ´¢³É¹¦£¡");
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "";
	}

	public ISelfInfoPowerUCC getSelfinfoUCC() {
		return this.selfinfoUCC;
	}

	public void setSelfinfoUCC(ISelfInfoPowerUCC ucc) {
		this.selfinfoUCC = ucc;
	}
}