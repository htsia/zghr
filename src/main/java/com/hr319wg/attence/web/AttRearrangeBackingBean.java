package com.hr319wg.attence.web;

import java.util.List;

import com.hr319wg.attence.pojo.bo.ATTRearrangeBO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;

public class AttRearrangeBackingBean extends BaseBackingBean {
	private String rearrangeNo1;
	private IAttenceSetUCC attenceSetUCC;
	private String pageInit;
	private PageVO mypage = new PageVO();
	private List attmachineList;
	private String groupNo;
	private String groupNoName;
	private String groupNoTypeName = "ÖÜÆÚ°à";
	private String initEdit;
	private String rearrangeNo;
	private ATTRearrangeBO rearrangeBO = new ATTRearrangeBO();
	private String className;

	public String first() {
		mypage.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuery();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuery();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuery();
		return "";
	}

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			attmachineList = attenceSetUCC
					.getAllATTRearrangeBO(mypage, groupNo);
			if (attmachineList != null && attmachineList.size() > 0) {
				for (int i = 0; i < attmachineList.size(); i++) {
					ATTRearrangeBO bo = (ATTRearrangeBO) attmachineList.get(i);
					if (bo.getLinkClass() != null
							&& !"".equals(bo.getLinkClass())) {
						AttClassBO bo2 = attenceSetUCC.findAttClassBObyId(bo
								.getLinkClass());
						if ("1".equals(bo.getLinkClass())) {
							bo.setLinkClassName("ĞİÏ¢");
						} else {
							if (bo2 != null) {
								bo.setLinkClassName(bo2.getClassName());
							} else {
								bo.setLinkClassName("");
							}
						}
					} else {
						bo.setLinkClassName("");
					}
					attmachineList.set(i, bo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String getPageInit() {
		try {
			if (super.getRequestParameter("WeekOkID") != null
					&& !super.getRequestParameter("WeekOkID").equals("")) {
				groupNo = super.getRequestParameter("WeekOkID");
				AttClassGroupBO bo1 = attenceSetUCC
						.findAttClassGroupBObyId(groupNo);
				groupNoName = bo1.getGroupName();
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public List getAttmachineList() {
		return attmachineList;
	}

	public void setAttmachineList(List attmachineList) {
		this.attmachineList = attmachineList;
	}

	public String getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(String groupNo) {
		this.groupNo = groupNo;
	}

	public String getGroupNoName() {
		return groupNoName;
	}

	public void setGroupNoName(String groupNoName) {
		this.groupNoName = groupNoName;
	}

	public String getGroupNoTypeName() {
		return groupNoTypeName;
	}

	public void setGroupNoTypeName(String groupNoTypeName) {
		this.groupNoTypeName = groupNoTypeName;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("rearrangeNo") != null) {
				rearrangeNo = super.getRequestParameter("rearrangeNo");
			}
			rearrangeBO = attenceSetUCC.findATTRearrangeBObyId(rearrangeNo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getRearrangeNo() {
		return rearrangeNo;
	}

	public void setRearrangeNo(String rearrangeNo) {
		this.rearrangeNo = rearrangeNo;
	}

	public ATTRearrangeBO getRearrangeBO() {
		return rearrangeBO;
	}

	public void setRearrangeBO(ATTRearrangeBO rearrangeBO) {
		this.rearrangeBO = rearrangeBO;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String save() {
		try {
			attenceSetUCC.saveATTRearrangeBO(rearrangeBO);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String repeart() {
		try {
			if (rearrangeNo1 != null && !"".equals(rearrangeNo1)) {
				attenceSetUCC
						.UpdateATTRearrangeBO(rearrangeNo1);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getRearrangeNo1() {
		return rearrangeNo1;
	}

	public void setRearrangeNo1(String rearrangeNo1) {
		this.rearrangeNo1 = rearrangeNo1;
	}
	
}
