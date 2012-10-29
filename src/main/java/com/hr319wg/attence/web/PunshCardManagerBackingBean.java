package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttenceLogBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class PunshCardManagerBackingBean extends BaseBackingBean {
	private String superID = super.getUserInfo().getOrgId();
	private String findSeeValue = "";
	private List itemList = new ArrayList();
	private List lists;
	private String monthManager;
	private String yearManager;
	private String superId;
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;
	private PageVO mypage=new PageVO();

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
		if (super.getRequestParameter("superId") != null
				&& !super.getRequestParameter("superId").equals("")
				&& super.getRequestParameter("yearManager") != null
				&& !super.getRequestParameter("yearManager").equals("")
				&& super.getRequestParameter("monthManager") != null
				&& !super.getRequestParameter("monthManager").equals("")) {
			superId = super.getRequestParameter("superId");
			yearManager = super.getRequestParameter("yearManager");
			monthManager = super.getRequestParameter("monthManager");
			findSeeValue = "";
		}
		if (findSeeValue == null || "".equals(findSeeValue)) {
			doQuery();
		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public String first(){
		mypage.setCurrentPage(1);
    	doQuery();
    	return "";
    }
    public String pre(){
    	if (mypage.getCurrentPage()>1){
    		mypage.setCurrentPage(mypage.getCurrentPage()-1);    		
    	}
    	doQuery();
    	return "";
    }
    public String next(){
    	if (mypage.getCurrentPage()<mypage.getTotalPage()){
    		mypage.setCurrentPage(mypage.getCurrentPage()+1);    		
    	}
    	doQuery();
    	return "";
    }
    public String last(){
    	mypage.setCurrentPage(mypage.getTotalPage());    		
    	doQuery();
    	return "";
    }
	
	public String doQuery() {
		if (lists != null) {
			lists = new ArrayList();
		}
		if (itemList != null) {
			itemList = new ArrayList();
		}
		try {
			if(mypage.getCurrentPage()==0) mypage.setCurrentPage(1);
			List itemList1 = attenceSetUCC.getAttenceLogBO(mypage,superId,
					yearManager, monthManager,findSeeValue);
			List groupVOList=attenceSetUCC.getAllAttClassGroupVO(superId);
			Hashtable grouphash=new Hashtable();
			if(groupVOList!=null&&groupVOList.size()>0){
				for(int i=0;i<groupVOList.size();i++){
					AttClassGroupVO vo=(AttClassGroupVO)groupVOList.get(i);
					grouphash.put(vo.getId(), vo);
				}
			}
			if (itemList1 != null && itemList1.size() > 0) {
				for (int j = 0; j < itemList1.size(); j++) {
					AttenceLogBO attencelogbo = (AttenceLogBO) itemList1.get(j);
					//String attcard = attenceSetUCC.insertDatapersonid(attencelogbo.getPersonId());
					AttClassGroupVO vo =(AttClassGroupVO)grouphash.get(attencelogbo.getPersonId());
					attencelogbo.setPersonName(vo.getName());
					attencelogbo.setAttCard(vo.getCard());
					OrgBO a = SysCacheTool.findOrgById(vo.getDeptId());
					attencelogbo.setDeptName(a.getName());
					OrgBO b1 = SysCacheTool.findOrgById(vo.getOrgId());
					attencelogbo.setOrgName(b1.getName());
					itemList.add(attencelogbo);
				}

			}
		} catch (Exception e) {

		}
		return "";
	}

	public String signData(){
		try {
			String err = this.attenceSetUCC.readSign(superID);
			if(err!=null && !"".equals(err)){
				err=err.substring(0, err.length()-1)+"。";
				super.showMessageDetail("读取考勤记录完成,其中"+err);
			}else{
				super.showMessageDetail("读取考勤记录完成");
			}
		} catch (SysException e) {
			e.printStackTrace();
		} 
		return null;
	}
	
	public String getMonthManager() {
		return monthManager;
	}

	public void setMonthManager(String monthManager) {
		this.monthManager = monthManager;
	}

	public String getYearManager() {
		return yearManager;
	}

	public void setYearManager(String yearManager) {
		this.yearManager = yearManager;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public List getItemList() {
		return itemList;
	}

	public void setItemList(List itemList) {
		this.itemList = itemList;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}


	public String getFindSeeValue() {
		return findSeeValue;
	}

	public void setFindSeeValue(String findSeeValue) {
		this.findSeeValue = findSeeValue;
	}

}
