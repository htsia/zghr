package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttTimeOffRecBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;

public class AttTimeOffBackingBean extends BaseBackingBean {
	private String outTimeNo;
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
		if (super.getRequestParameter("outTimeNo") != null && !super.getRequestParameter("outTimeNo").equals("")) {
			outTimeNo = super.getRequestParameter("outTimeNo");
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

	public String getOutTimeNo() {
		return outTimeNo;
	}

	public void setOutTimeNo(String outTimeNo) {
		this.outTimeNo = outTimeNo;
	}
	
	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			List list=attenceSetUCC.getAllAttTimeOffRecBO(mypage,outTimeNo);
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					AttTimeOffRecBO atttimeoffrecbo=(AttTimeOffRecBO)list.get(i);
					AttClassGroupVO vo=attenceSetUCC.findAttClassGroupVObyId(atttimeoffrecbo.getPersonID().trim());
					atttimeoffrecbo.setPersonName(vo.getName());
					dateList.add(atttimeoffrecbo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
