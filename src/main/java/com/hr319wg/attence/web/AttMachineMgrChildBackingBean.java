package com.hr319wg.attence.web;

import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.attMachineBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AttMachineMgrChildBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
	private String superId=super.getUserInfo().getOrgId();
	private String superName;
	private String PageInit;
	private PageVO mypage = new PageVO();
	private List attmachineList;
	private attMachineBO bo=new attMachineBO();
	private String initEdit;
	private String machineID;
	private String atttype;
	
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
			attmachineList=attenceSetUCC.getAllAttMachine(mypage, superId);
			if(attmachineList!=null && attmachineList.size()>0){
				for(int i=0;i<attmachineList.size();i++){
					attMachineBO attmachinebo=(attMachineBO)attmachineList.get(i);
					String typeName=attmachinebo.getMachineType();
					if("0".equals(typeName)){
					 	attmachinebo.setMachineTypeName("A");
					}else if("1".equals(typeName)){
					 	attmachinebo.setMachineTypeName("B");
					}else if("2".equals(typeName)){
					 	attmachinebo.setMachineTypeName("C");
					}else{
					 	attmachinebo.setMachineTypeName("无类型");
					}
					OrgBO b = SysCacheTool.findOrgById(this.superId);
					if (b != null) {
					 	attmachinebo.setOrgID(b.getName());
					}
					
					attmachineList.set(i, attmachinebo);
				}    
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

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(this.superId);
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String getPageInit() {
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		doQuery();
		return PageInit;
	}

	public void setPageInit(String pageInit) {
		PageInit = pageInit;
	}

	public List getAttmachineList() {
		return attmachineList;
	}

	public void setAttmachineList(List attmachineList) {
		this.attmachineList = attmachineList;
	}

	public String getInitEdit() {
		try {
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
			OrgBO b = SysCacheTool.findOrgById(this.superId);
			if(b!=null){
				superName = b.getName();
				bo.setOrgID(superName);
			}else{
				bo.setOrgID("");
			}
			bo.setMachineID(null);
			bo.setMachineName("");
			bo.setMachinePlace("");
			bo.setMachineType("");
			bo.setMachineIP("");
		}else if(super.getRequestParameter("machineID") != null && !super.getRequestParameter("machineID").equals("")){
			String machineID = super.getRequestParameter("machineID");
			bo=attenceSetUCC.findBobyId(machineID);
			if(bo!=null){
				OrgBO b = SysCacheTool.findOrgById(bo.getOrgID());
				superName = b.getName();
				superId=bo.getOrgID();
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

	public attMachineBO getBo() {
		return bo;
	}

	public void setBo(attMachineBO bo) {
		this.bo = bo;
	}

	public String save(){
		if(!bo.getMachineName().equals("") && !bo.getMachinePlace().equals("")){
	    bo.setOrgID(superId);
	    bo.setMachineType(atttype);
		
		try {
			attenceSetUCC.saveorupdateAttMachine(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";			
		}else{
			super.showMessageDetail("输入的考勤机名称或安装位置为空，请认真输入！");
			return "";
		}
		
	}

	public String getMachineID() {
		return machineID;
	}

	public void setMachineID(String machineID) {
		this.machineID = machineID;
	}
	
	public String delete(){
		try {
			if (machineID != null) {
				attenceSetUCC.deleteAttMachine(machineID);
			}
		} catch (Exception e) {
			super.showMessageDetail("删除失败！");
		}
		return "";
	}

	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}

	public void changeStatus(ValueChangeEvent event){
		   this.atttype = event.getNewValue().toString();
		}

}
