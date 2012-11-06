package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.service.IAttBusiService;

public class AttClassDetailBackingBean extends BaseBackingBean {
	private List detailList;
	private IAttenceSetUCC attenceSetUCC;
	private String pageInit;
	private String classID;
	private String operItemID;
	private PageVO mypage = new PageVO();
	private String className;
    private IAttBusiService attBusiService;

	public String getOperItemID() {
		return operItemID;
	}

	public void setOperItemID(String operItemID) {
		this.operItemID = operItemID;
	}

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}
	
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String getClassID() {
		return classID;
	}

	public void setClassID(String classID) {
		this.classID = classID;
	}

	public String getPageInit() {
		String classID1=super.getRequestParameter("classID");
		if(classID1 != null && !"".equals(classID1)){
			this.classID=classID1;
		}
		try {
			AttClassBO cBo = (AttClassBO)this.attBusiService.findBOById(AttClassBO.class, classID);
			if(cBo!=null){
				this.className=cBo.getClassName();
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

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			detailList=attenceSetUCC.getAllAttClassDetailBO(mypage, classID);
			if(detailList==null){
				detailList = new ArrayList();
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}
	
	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public List getDetailList() {
		return detailList;
	}

	public void setDetailList(List detailList) {
		this.detailList = detailList;
	}
}
