package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttAnnualDetailAuditBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;

public class PersonLeaveNetworkholidayBackingBean extends BaseBackingBean {
	private String furloughNO;
	private List dateList=new ArrayList();
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;
	private PageVO mypage = new PageVO();
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
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getPageInit() {
		if(dateList!=null && dateList.size()>0){
			dateList=new ArrayList();
		}
		if (super.getRequestParameter("furloughNO") != null && !super.getRequestParameter("furloughNO").equals("")) {
			furloughNO = super.getRequestParameter("furloughNO");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public List getDateList() {
		return dateList;
	}

	public void setDateList(List dateList) {
		this.dateList = dateList;
	}

	public String getFurloughNO() {
		return furloughNO;
	}

	public void setFurloughNO(String furloughNO) {
		this.furloughNO = furloughNO;
	}
	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			List list=attenceSetUCC.getAllAttAnnualDetailAuditBO(mypage,furloughNO);
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)list.get(i);
					AttClassGroupVO vo=attenceSetUCC.findAttClassGroupVObyId(attannualdetailauditbo.getPersonID().trim());
					attannualdetailauditbo.setPersonName(vo.getName());
					dateList.add(attannualdetailauditbo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
