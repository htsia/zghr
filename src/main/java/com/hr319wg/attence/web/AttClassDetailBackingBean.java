package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassDetailBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.service.IAttBusiService;

public class AttClassDetailBackingBean extends BaseBackingBean {
	private boolean isExist = false;
	private String setStatus = "1";
	private String superID=super.getUserInfo().getOrgId();
	private String createOrg;
	private String newDetailValue;
	private String newDetailValue1;
	private List detailList=new ArrayList();
	private List detailList1=new ArrayList();
	private IAttenceSetUCC attenceSetUCC;
	private String pageInit;
	private List attmachineList;
	private String classID;
	private String itemID;
	private PageVO mypage = new PageVO();
	private String className;
	private String initEdit;
    private AttClassDetailBO attClassDetailBO=new AttClassDetailBO();
    private String status="0";
    private IAttBusiService attBusiService;
    


	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}

	public boolean getIsExist() {
		return isExist;
	}

	public void setExist(boolean isExist) {
		this.isExist = isExist;
	}
	
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

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public String getClassID() {
		return classID;
	}

	public void setClassID(String classID) {
		this.classID = classID;
	}

	public String getInitEdit() {
		if(detailList!=null && detailList.size()>0){
			detailList=new ArrayList();
		}
		if(detailList1!=null && detailList1.size()>0){
			detailList1=new ArrayList();
		}
		try {
		if(super.getRequestParameter("classID") != null && !super.getRequestParameter("classID").equals("")){
			classID=super.getRequestParameter("classID");
			attClassDetailBO.setItemID(null);
			attClassDetailBO.setItemTime("");
		}else if(super.getRequestParameter("itemID") != null && !super.getRequestParameter("itemID").equals("")){
			itemID=super.getRequestParameter("itemID");
			attClassDetailBO=attenceSetUCC.findAttClassDetailBObyId(itemID);
			classID=attClassDetailBO.getClassID();
			if(attClassDetailBO.getItemTime()!=null && !"".equals(attClassDetailBO.getItemTime())){
				String[] timevalues=attClassDetailBO.getItemTime().split(":");
				newDetailValue=timevalues[0];
				newDetailValue1=timevalues[1];
			}else{
				newDetailValue="00";
				newDetailValue1="00";
			}
			AttClassBO attClassBO=attenceSetUCC.findAttClassBObyId(classID);
			if("1".equals(attClassBO.getDaySpan())){
				isExist=false;
			}else{
				isExist=true;
			}
		}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public List getAttmachineList() {
		return attmachineList;
	}

	public void setAttmachineList(List attmachineList) {
		this.attmachineList = attmachineList;
	}

	public String getPageInit() {
		
		if(super.getRequestParameter("classID") != null && !super.getRequestParameter("classID").equals("")){
			classID=super.getRequestParameter("classID");
			try {
				AttClassBO cBo = (AttClassBO)this.attBusiService.findBOById(AttClassBO.class, classID);
				if(cBo!=null){
					this.className=cBo.getClassName();
				}
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		if(super.getRequestParameter("createOrg") != null && !super.getRequestParameter("createOrg").equals("")){
			createOrg=super.getRequestParameter("createOrg");
		}
		   if("0".equals(status)){
			   this.doQuery();
		   }
		   if("1".equals(status)){
			   this.doQuery1();
		   }
		   if("2".equals(status)){
			   this.doQuery2();
		   }
		
		//doQuery();
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
			attmachineList=attenceSetUCC.getAllAttClassDetailBO(mypage, classID);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String del(){
		try {
			attClassDetailBO.setClassID(classID);
			attClassDetailBO.setItemTime(null);
			attenceSetUCC.saveAttClassDetailBO(attClassDetailBO);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	public String add(){
		try {
		attClassDetailBO.setClassID(classID);
		String timevalue=newDetailValue.trim()+":"+newDetailValue1.trim();
		attClassDetailBO.setItemTime(timevalue);
		attClassDetailBO.setDayFlag(setStatus);
		attenceSetUCC.saveAttClassDetailBO(attClassDetailBO);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
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
	
	public AttClassDetailBO getAttClassDetailBO() {
		return attClassDetailBO;
	}

	public void setAttClassDetailBO(AttClassDetailBO attClassDetailBO) {
		this.attClassDetailBO = attClassDetailBO;
	}

	public String delete(){		
		try {
		
			attClassDetailBO.setItemID(itemID);
		
			attenceSetUCC.deleteAttClassDetailBO(attClassDetailBO);
			} catch (SysException e) {
				e.printStackTrace();
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
	public void doQuery1() {
		try {
			attmachineList=attenceSetUCC.getAllAttClassDetailBO1(classID);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	public void doQuery2() {
		try {
			attmachineList=attenceSetUCC.getAllAttClassDetailBO2(classID);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public void doQueryDetail(){
		String[] details=new String[24];
		for(int i=0;i<details.length;i++){
			if(i<10){
				details[i]="0"+i;
			}else{
				details[i]=""+i;
			}
		}
	    for(int i=0;i<details.length;i++){
			   SelectItem si=new  SelectItem();
               si.setLabel(details[i]);
               si.setValue(details[i]);
               detailList.add(si);
	    }
	}
	public List getDetailList() {
		doQueryDetail();
		return detailList;
	}

	public void setDetailList(List detailList) {
		this.detailList = detailList;
	}
    public void changeDetailValue(ValueChangeEvent event){
        this.newDetailValue=event.getNewValue().toString();
     }
    
	public void doQueryDetail1(){
		String[] details=new String[60];
		for(int i=0;i<details.length;i++){
			if(i<10){
				details[i]="0"+i;
			}else{
				details[i]=""+i;
			}
		}
	    for(int i=0;i<details.length;i++){
			   SelectItem si=new  SelectItem();
               si.setLabel(details[i]);
               si.setValue(details[i]);
               detailList1.add(si);
	    }
	}
    
    public List getDetailList1() {
    	doQueryDetail1();
		return detailList1;
	}

	public void setDetailList1(List detailList1) {
		this.detailList1 = detailList1;
	}

	public void changeDetailValue1(ValueChangeEvent event){
        this.newDetailValue1=event.getNewValue().toString();
     }
	public String getNewDetailValue() {
		return newDetailValue;
	}

	public void setNewDetailValue(String newDetailValue) {
		this.newDetailValue = newDetailValue;
	}

	public String getCreateOrg() {
		return createOrg;
	}

	public void setCreateOrg(String createOrg) {
		this.createOrg = createOrg;
	}

	public String getSuperID() {
		return superID;
	}

	public void setSuperID(String superID) {
		this.superID = superID;
	}

	public String getNewDetailValue1() {
		return newDetailValue1;
	}

	public void setNewDetailValue1(String newDetailValue1) {
		this.newDetailValue1 = newDetailValue1;
	}

	public String getSetStatus() {
		return setStatus;
	}

	public void setSetStatus(String setStatus) {
		this.setStatus = setStatus;
	}
    
}
