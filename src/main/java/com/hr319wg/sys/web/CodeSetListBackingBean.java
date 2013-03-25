package com.hr319wg.sys.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;
import javax.servlet.http.HttpServletRequest;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeSetBO;
import com.hr319wg.sys.ucc.ICodeSetUCC;
import com.hr319wg.user.dao.UserInfoDAO;
import com.hr319wg.user.ucc.IUserManageUCC;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;

public class CodeSetListBackingBean extends BaseBackingBean {
	private String moudleID;
	private String MODICODE = "091001";
	private ICodeSetUCC codesetucc;
	private List codesets;
	private boolean operRight;
	private IUserManageUCC usermanageucc;
	private boolean orderByName;
	private String[] exportField;
	private List exportSetList;

	public String getMoudleID() {
		return moudleID;
	}

	public void setMoudleID(String moudleID) {
		this.moudleID = moudleID;
	}

	public String[] getExportField() {
		return this.exportField;
	}

	public void setExportField(String[] st) {
		this.exportField = st;
	}

	public List getExportSetList() {
		this.exportSetList = new ArrayList();
		try {
			List list = this.codesetucc.queryCodeSets();
			for (int i = 0; i < list.size(); i++) {
				SelectItem si = new SelectItem();
				CodeSetBO ib = (CodeSetBO) list.get(i);
				si.setLabel(ib.getSetName());
				si.setValue(ib.getSetId());
				this.exportSetList.add(si);
			}
		} catch (Exception e) {
		}
		return this.exportSetList;
	}

	public void setExportSetList(List l) {
		this.exportSetList = l;
	}

	public boolean getorderByName() {
		return this.orderByName;
	}

	public void setorderByName(boolean b) {
		this.orderByName = b;
	}

	public boolean isOperRight() {
		return this.operRight;
	}

	public void setOperRight(boolean operRight) {
		this.operRight = operRight;
	}

	public IUserManageUCC getUsermanageucc() {
		return this.usermanageucc;
	}

	public void setUsermanageucc(IUserManageUCC usermanageucc) {
		this.usermanageucc = usermanageucc;
	}

	public List getCodesets() {
		return this.codesets;
	}

	public void setCodesets(List codesets) {
		this.codesets = codesets;
	}

	public ICodeSetUCC getCodesetucc() {
		return this.codesetucc;
	}

	public void setCodesetucc(ICodeSetUCC codesetucc) {
		this.codesetucc = codesetucc;
	}

	public String getPageInit() {
		try {
			String flag = this.usermanageucc.isSysManager(super.getUserInfo().getUserId());
			if ((UserInfoDAO.SUPERMAN.equals(flag)) || (UserInfoDAO.MAJORDOMO.equals(flag)))
				this.operRight = true;
			else {
				this.operRight = UserAPI.checkButtonOperate(super.getUserInfo(), this.MODICODE);
			}
			String act=super.getRequestParameter("act");
			if("init".equals(act)){
				this.moudleID=super.getRequestParameter("moudleID");				
			}
			querySetList();
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		}
		return this.pageInit;
	}

	public String setStatusOpen() {
		try {
			HttpServletRequest request = super.getServletRequest();
			String[] ids = request.getParameterValues("selectItem");
			this.codesetucc.makeStatus(ids, true);

			List list = new ArrayList();
			for (int i = 0; i < ids.length; i++) {
				CodeSetBO cSet = SysCacheTool.findCodeSet(ids[i]);
				cSet.setSetStatus(CodeSetBO.STATUS_OPEN);
				list.add(cSet);
			}
			SysCache.setMap(list, 3, 1);
			querySetList();
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "";
	}

	private void querySetList() throws SysException {
		this.codesets = this.codesetucc.queryCodeSets(this.orderByName, this.moudleID, super.getUserInfo().getOrgId());
		SetCN(this.codesets);
	}

	public String setStatusBan() {
		try {
			HttpServletRequest request = super.getServletRequest();
			String[] ids = request.getParameterValues("selectItem");
			this.codesetucc.makeStatus(ids, false);

			List list = new ArrayList();
			for (int i = 0; i < ids.length; i++) {
				CodeSetBO cSet = SysCacheTool.findCodeSet(ids[i]);
				cSet.setSetStatus(CodeSetBO.STATUS_BAN);
				list.add(cSet);
			}
			SysCache.setMap(list, 3, 1);
			querySetList();
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "";
	}

	public String deleteCodeSets() {
		try {
			HttpServletRequest request = super.getServletRequest();
			String[] ids = request.getParameterValues("selectItem");
			boolean bl = otherRestrict(ids);
			if (bl) {
				showMessageDetail("国标码和系统码不允许删除！");
				return "";
			}
			String str = this.codesetucc.checkUsing(ids);
			str = CommonFuns.filterNull(str);
			if (!"".equals(str)) {
				showMessageDetail(str + "正在使用，无法删除！");
				return "";
			}
			this.codesetucc.deleteCodeSets(ids);

			SysCache.setMap(ids, 2, 1);
			querySetList();
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "";
	}

	public void SetCN(List cItems) {
		for (int i = 0; i < cItems.size(); i++) {
			CodeSetBO b = (CodeSetBO) cItems.get(i);

			if (!CodeSetBO.STATUS_OPEN.equals(b.getSetStatus()))
				b.setSetStatus("<font color=red>禁用</font>");
			else {
				b.setSetStatus("启用");
			}
			if (CodeSetBO.LAYER_LEAF.equals(b.getSetLayer()))
				b.setSetLayer("录到最低层");
			else {
				b.setSetLayer("录到任意层");
			}
			int st = Integer.parseInt(b.getSetId());
			if (st < 1000)
				b.setSetScaleName("<font color='green'>国标</font>");
			else if ((Integer.parseInt(b.getSetId()) >= 1000) && (st < 2000))
				b.setSetScaleName("用户");
			else if ((Integer.parseInt(b.getSetId()) >= 2000) && (st < 3000))
				b.setSetScaleName("<font color='red'>系统</font>");
			else
				b.setSetScaleName("用户");
		}
	}

	public boolean otherRestrict(String[] setIds) {
		for (int i = 0; i < setIds.length; i++) {
			int st = Integer.parseInt(setIds[i]);
			if (((st >= 2000) && (st < 3000)) || (st < 1000)) {
				return true;
			}
		}
		return false;
	}

	public void outputByName(ValueChangeEvent e) {
		try {
			if (e.getNewValue().toString().equals("true")) {
				this.orderByName = true;
			} else {
				this.orderByName = false;
			}
			querySetList();
		} catch (Exception ee) {
		}
	}
	public String createInfoFile() {
		try {
			String fileName = FileUtil.exportCodeInfo(BaseBackingBean
					.getServletContext().getRealPath("/file/tmp/"),
					this.exportField);
			if ((fileName != null) && (!"".equals(fileName))) {
				super.getHttpSession().setAttribute("FileURL",
						"/file/tmp/" + fileName);
				return "success";
			}
		} catch (Exception e) {
			super.getServletRequest().setAttribute("FileURL", "");
		}
		return "";
	}
}