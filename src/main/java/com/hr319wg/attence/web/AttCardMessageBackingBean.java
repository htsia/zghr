package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttCardBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AttCardMessageBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
	private String pageInit;
	private String superId=super.getUserInfo().getOrgId();
	private PageVO mypage = new PageVO();
	private List attmachineList=new ArrayList();
	private String logID;
	private String status;
	
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

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getPageInit() {
		if(attmachineList!=null){
			attmachineList=new ArrayList();
		}
		if (super.getRequestParameter("superId") != null && !"".equals(super.getRequestParameter("superId"))) {
			superId=super.getRequestParameter("superId");
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

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			List lists=new ArrayList();
			if(!"0".equals(status)&& status!=null && !"".equals(status)){
				lists=attenceSetUCC.getAllAttCardBO(mypage,status,superId); 
			}else{
				status=null;
				lists=attenceSetUCC.getAllAttCardBO(mypage,status,superId); 
			}
			if(lists!=null && lists.size()>0){
				for(int i=0;i<lists.size();i++){
					AttCardBO attCardBO=(AttCardBO)lists.get(i);
					PersonBO person1 = SysCacheTool.findPersonById(attCardBO.getOperID());
					PersonBO person2 = SysCacheTool.findPersonById(attCardBO.getPersonID());
					attCardBO.setManageName(person1.getName());
					attCardBO.setCardName(person2.getName());
					String ok=attCardBO.getOperType();
					if("1".equals(ok)){
						attCardBO.setOperTypeName("·¢¿¨");
					}
					if("2".equals(ok)){
						attCardBO.setOperTypeName("»»¿¨");
					}
					if("3".equals(ok)){
						attCardBO.setOperTypeName("ÍË¿¨");
					}
				    attmachineList.add(attCardBO);
			 
				}
			

			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public List getAttmachineList() {
		return attmachineList;
	}

	public void setAttmachineList(List attmachineList) {
		this.attmachineList = attmachineList;
	}

    
	public String getLogID() {
		return logID;
	}

	public void setLogID(String logID) {
		this.logID = logID;
	}

	public String delete(){
		try {
			if (logID != null) {
				attenceSetUCC.deleteAttCardBO(logID);
			}
		} catch (Exception e) {
			super.showMessageDetail("É¾³ıÊ§°Ü£¡");
		}
		return "";
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}	
	public void changeStatus(ValueChangeEvent event){
		   this.status = event.getNewValue().toString();
		}
	
}
