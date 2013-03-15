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
	private String setId;
	private String hintMsg;
	private boolean editStatus;
	private String moudleID;
	private boolean operRight;
	private UserAPI userAPI;
	private CodeSetBO cs;

	public CodeSetBO getCs() {
		return cs;
	}

	public void setCs(CodeSetBO cs) {
		this.cs = cs;
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

	public ICodeSetUCC getCodesetucc() {
		return this.codesetucc;
	}

	public void setCodesetucc(ICodeSetUCC codesetucc) {
		this.codesetucc = codesetucc;
	}

	public String getPageInit() {
		try {
			this.operRight=userAPI.checkButtonOperate(super.getUserInfo(), "06200");
			if (this.setId == null || "".equals(this.setId)){
				this.cs = new CodeSetBO();
				this.cs.setSetStatus("1");
				if("wage".equals(this.moudleID)){
					this.cs.setScaleCode("1");
				}
			}else{
				this.cs = this.codesetucc.queryCodeSet(this.setId);				
			}
			
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
		}

		return this.pageInit;
	}

	public String saveCodeSet() {
		try {
			if (!this.editStatus) {
				this.cs.setCreateUnit(super.getUserInfo().getOrgId());
				String sId = this.codesetucc.getNewSetId();
				this.cs.setSetId(sId);
				this.codesetucc.createCodeSet(cs);

				List list = new ArrayList();
				list.add(this.cs);
				SysCache.setMap(list, 1, 1);

				showMessageDetail("添加成功!");
			} else {
				this.cs.setSetId(this.setId);
				this.codesetucc.updateCodeSet(this.cs);

				List list = new ArrayList();
				list.add(this.cs);
				SysCache.setMap(list, 3, 1);
				showMessageDetail("修改成功!");
			}
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "setlist";
	}

}