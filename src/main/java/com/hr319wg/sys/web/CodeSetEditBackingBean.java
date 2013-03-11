package com.hr319wg.sys.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.pojo.bo.CodeSetBO;
import com.hr319wg.sys.ucc.ICodeSetUCC;
import com.hr319wg.util.CommonFuns;

public class CodeSetEditBackingBean extends BaseBackingBean {
	private ICodeSetUCC codesetucc;
	private String setName;
	private String setDesc;
	private String setLayer;
	private String setStatus = "1";
	private String publicFlag;
	private String setId;
	private String hintMsg;
	private boolean editStatus;
	private String scaleCode;
	private String moudleID;
	private boolean operRight;
	private UserAPI userAPI;

	public String getPublicFlag() {
		return publicFlag;
	}

	public void setPublicFlag(String publicFlag) {
		this.publicFlag = publicFlag;
	}

	public UserAPI getUserAPI() {
		return userAPI;
	}

	public void setUserAPI(UserAPI userAPI) {
		this.userAPI = userAPI;
	}

	public boolean isOperRight() {
		return operRight;
	}

	public void setOperRight(boolean operRight) {
		this.operRight = operRight;
	}

	public String getMoudleID() {
		return moudleID;
	}

	public void setMoudleID(String moudleID) {
		this.moudleID = moudleID;
	}

	public boolean isEditStatus() {
		return this.editStatus;
	}

	public void setEditStatus(boolean editStatus) {
		this.editStatus = editStatus;
	}

	public String getHintMsg() {
		return this.hintMsg;
	}

	public void setHintMsg(String hintMsg) {
		this.hintMsg = hintMsg;
	}

	public String getSetId() {
		return this.setId;
	}

	public void setSetId(String setId) {
		this.setId = setId;
	}

	public String getSetName() {
		return this.setName;
	}

	public void setSetName(String setName) {
		this.setName = setName;
	}

	public String getSetDesc() {
		return this.setDesc;
	}

	public void setSetDesc(String setDesc) {
		this.setDesc = setDesc;
	}

	public String getSetLayer() {
		return this.setLayer;
	}

	public void setSetLayer(String setLayer) {
		this.setLayer = setLayer;
	}

	public String getSetStatus() {
		return this.setStatus;
	}

	public void setSetStatus(String setStatus) {
		this.setStatus = setStatus;
	}

	public ICodeSetUCC getCodesetucc() {
		return this.codesetucc;
	}

	public void setCodesetucc(ICodeSetUCC codesetucc) {
		this.codesetucc = codesetucc;
	}

	public String getScaleCode() {
		return this.scaleCode;
	}

	public void setScaleCode(String scaleCode) {
		this.scaleCode = scaleCode;
	}

	public String getPageInit() {
		try {
			this.operRight=userAPI.checkButtonOperate(super.getUserInfo(), "06200");
			queryCodeSet();
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
		}

		return this.pageInit;
	}

	public String saveCodeSet() {
		try {
			CodeSetBO cs = new CodeSetBO();
			CommonFuns.copyProperties(cs, this);
			
			if (!this.editStatus) {
				cs.setCreateUnit(super.getUserInfo().getOrgId());
				if("1".equals(this.publicFlag)){
					cs.setPublicFlag("1");
				}
				String sId = this.codesetucc.getNewSetId();
				cs.setSetId(sId);
				this.codesetucc.createCodeSet(cs);

				List list = new ArrayList();
				list.add(cs);
				SysCache.setMap(list, 1, 1);

				showMessageDetail("添加成功!");
			} else {
				if("1".equals(this.publicFlag)){
					cs.setPublicFlag("1");
				}
				cs.setSetId(this.setId);
				this.codesetucc.updateCodeSet(cs);

				List list = new ArrayList();
				list.add(cs);
				SysCache.setMap(list, 3, 1);
				showMessageDetail("修改成功!");
			}
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "setlist";
	}

	public void queryCodeSet() throws SysException {
		if ((this.setId == null) || (this.setId == ""))
			return;
		CodeSetBO cs = this.codesetucc.queryCodeSet(this.setId);
		CommonFuns.copyProperties(this, cs);
	}
}