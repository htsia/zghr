package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttChangeWorkBO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AdjustClassChildBackingBean extends BaseBackingBean {
	private String applydatevalues;
	private String newvalues;
	private String oldvalues;
	private String findSeeValue;
	private String ids;
	private List attmachineList=new ArrayList();
	private String initEdit;
	private String className;
	private String name;
	private AttChangeWorkBO bo=new AttChangeWorkBO();
	private String initset;
	private List itemList = new ArrayList();
	private String superId=super.getUserInfo().getOrgId();
	private String pageInit;
	private PageVO mypage = new PageVO();
	private IAttenceSetUCC attenceSetUCC;

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
		if (super.getRequestParameter("superId") != null
				&& !super.getRequestParameter("superId").equals("")) {
			superId = super.getRequestParameter("superId");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String doQuery() {
		if (itemList != null) {
			itemList = new ArrayList();
		}
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			List lists=attenceSetUCC.getAllAttClassGroupVO3(mypage,superId,findSeeValue);
			if(lists!=null && lists.size()>0){
				for(int i=0;i<lists.size();i++){
					AttClassGroupVO vo=(AttClassGroupVO)lists.get(i);
//					String deptName=attenceSetUCC.findDeptmentVObyId(vo.getDeptId());
					OrgBO a=SysCacheTool.findOrgById(vo.getDeptId());
					vo.setDeptName(a.getName());
					OrgBO b1 = SysCacheTool.findOrgById(vo.getOrgId());
					vo.setOrgName(b1.getName());
					String oldClassValue=attenceSetUCC.getA001737(vo.getId());
					AttClassGroupBO attclassgroupbos=attenceSetUCC.findAttClassGroupBObyId(oldClassValue);
					vo.setGroupName(attclassgroupbos.getGroupName());
					itemList.add(vo);
				}
			}
		} catch (Exception e) {

		}
		return "";
	}

	public String getInitset1() {
		try {
			String oldclassname="";
			String[] names=name.split(",");
			if(names!=null){
			  for(int i=1;i<names.length;i++){
			            String personname=SysCacheTool.findPersonById(names[i]).getName();
			       	    String oldClassValue=attenceSetUCC.getA001737(names[i]);
						AttClassBO attclassbo=attenceSetUCC.changeWork1(names[i],superId,oldClassValue,applydatevalues);
						if(attclassbo!=null){
							oldclassname+=",["+personname+" "+attclassbo.getClassName()+"]";	
						}else{
			                                oldclassname+=",["+personname+" 未设]";
						}
			   }
			  oldvalues=oldclassname;	
			}
			} catch (Exception e) {

			}
		return "";
	}
	
	public String SaveSet(){
		try {
			String[] names=name.split(",");
			if(names!=null){
			  for(int i=1;i<names.length;i++){
				  AttChangeWorkBO bos=new AttChangeWorkBO();
					bos.setPersonID(names[i]);
					bos.setApplyDate(applydatevalues);
					bos.setNewClass(newvalues);
	       			String oldClassValue=attenceSetUCC.getA001737(names[i]);
					AttClassBO attclassbo=attenceSetUCC.changeWork1(names[i],superId,oldClassValue,bos.getApplyDate());
					if(attclassbo!=null){
						bos.setOldClass(attclassbo.getClassID());
					}else{
						bos.setOldClass("");
					}
					bos.setStatusValue("3");
			        attenceSetUCC.deleteAttChangeWorkBO(names[i],bos.getApplyDate());
			        attenceSetUCC.saveorupdateAttChangeWorkBO(bos);
			  }}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
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

	public String getInitset() {
		if (super.getRequestParameter("name") != null
				&& !super.getRequestParameter("name").equals("")) {
			name = super.getRequestParameter("name");
		}
		return initset;
	}

	public void setInitset(String initset) {
		this.initset = initset;
	}

	public AttChangeWorkBO getBo() {
		return bo;
	}

	public void setBo(AttChangeWorkBO bo) {
		this.bo = bo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getInitEdit() {
		if (super.getRequestParameter("ids") != null
				&& !super.getRequestParameter("ids").equals("")) {
			ids = super.getRequestParameter("ids");
		}
		doQuery1();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String doQuery1() {
		if (attmachineList != null) {
			attmachineList = new ArrayList();
		}
		try {
			List lists=attenceSetUCC.getAttChangeWorkBO2(ids);
			if(lists!=null && lists.size()>0){
				for(int i=0;i<lists.size();i++){
					AttChangeWorkBO attchangeworkbo=(AttChangeWorkBO)lists.get(i);
					if(attchangeworkbo.getDeptAuditResult()!=null && !"".equals(attchangeworkbo.getDeptAuditResult())){
						if("1".equals(attchangeworkbo.getDeptAuditResult())){
							attchangeworkbo.setDeptAuditCausevalue("同意");
						}else{
							attchangeworkbo.setDeptAuditCausevalue("不同意");
						}						
					}
					if(attchangeworkbo.getHrAuditResult()!=null && !"".equals(attchangeworkbo.getHrAuditResult())){
						if("1".equals(attchangeworkbo.getHrAuditResult())){
							attchangeworkbo.setHrAuditResultvalue("同意");
						}else{
							attchangeworkbo.setHrAuditResultvalue("不同意");
						}
					}
					if(attchangeworkbo.getOldClass()!=null && !"".equals(attchangeworkbo.getOldClass())){
						if("1".equals(attchangeworkbo.getOldClass())){
							attchangeworkbo.setOldClassName("休息");
						}else if("2".equals(attchangeworkbo.getOldClass())){
							attchangeworkbo.setOldClassName("节假日");
						}else if("3".equals(attchangeworkbo.getOldClass())){
							attchangeworkbo.setOldClassName("公休日");
						}else{
							AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(attchangeworkbo.getOldClass());
							attchangeworkbo.setOldClassName(attclassbo.getClassName());
						}
					}else{
						attchangeworkbo.setOldClassName("未设");
					}
					if(attchangeworkbo.getNewClass()!=null && !"".equals(attchangeworkbo.getNewClass())){
						if("1".equals(attchangeworkbo.getNewClass())){
							attchangeworkbo.setNewClassName("休息");
						}else if("2".equals(attchangeworkbo.getNewClass())){
							attchangeworkbo.setNewClassName("节假日");
						}else if("3".equals(attchangeworkbo.getNewClass())){
							attchangeworkbo.setNewClassName("公休日");
						}else{
							AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(attchangeworkbo.getNewClass());
							attchangeworkbo.setNewClassName(attclassbo.getClassName());
						}
					}else{
						attchangeworkbo.setNewClassName("未设");
					}
					attmachineList.add(attchangeworkbo);
				}
			}
		} catch (Exception e) {

		}
		return "";
	}
	
	public List getAttmachineList() {
		return attmachineList;
	}

	public void setAttmachineList(List attmachineList) {
		this.attmachineList = attmachineList;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getFindSeeValue() {
		return findSeeValue;
	}

	public void setFindSeeValue(String findSeeValue) {
		this.findSeeValue = findSeeValue;
	}
	
	public String findSee(){
		doQuery();
        return "";		
	}

	public String getApplydatevalues() {
		return applydatevalues;
	}

	public void setApplydatevalues(String applydatevalues) {
		this.applydatevalues = applydatevalues;
	}

	public String getNewvalues() {
		return newvalues;
	}

	public void setNewvalues(String newvalues) {
		this.newvalues = newvalues;
	}

	public String getOldvalues() {
		return oldvalues;
	}

	public void setOldvalues(String oldvalues) {
		this.oldvalues = oldvalues;
	}
	
}
