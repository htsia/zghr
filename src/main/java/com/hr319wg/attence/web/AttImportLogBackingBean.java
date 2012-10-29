package com.hr319wg.attence.web;

import java.util.List;

import com.hr319wg.attence.pojo.bo.AttImportLogBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;

public class AttImportLogBackingBean extends BaseBackingBean {
	private String logID;
	private IAttenceSetUCC attenceSetUCC;
private String pageInit;
private List lists;
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
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}
	
	public String getLogID() {
		return logID;
	}

	public void setLogID(String logID) {
		this.logID = logID;
	}

	public String doQuery(){
		try{
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			lists=attenceSetUCC.getAttImportAll(mypage);
			if(lists!=null && lists.size()>0){
				for(int i=0;i<lists.size();i++){
					AttImportLogBO attimportlogbo=(AttImportLogBO)lists.get(i);
					lists.set(i, attimportlogbo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String delete(){
		try{
			attenceSetUCC.deleteAttImportLogBO(logID);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
}
