package com.hr319wg.attence.web;

import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttManagerArgumentBO;
import com.hr319wg.attence.pojo.bo.AttManagerArrangeBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class AutoClassManagerBackingBean extends BaseBackingBean {
	private String amaId;
	private String personName = super.getUserInfo().getName();
	private String superName;
	private AttManagerArrangeBO bo=new AttManagerArrangeBO();
	private String initEdit;
	private List dateList;
	private String superId=super.getUserInfo().getOrgId();
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
		try{
			List lists=attenceSetUCC.getAllAttManagerArgumentBO(superId);
			if(lists!=null && lists.size()>0){
				String[] orgIdStr=new String[lists.size()];
				for(int i=0;i<lists.size();i++){
					AttManagerArgumentBO attmanagerargumentbo=(AttManagerArgumentBO)lists.get(i);
					orgIdStr[i]=attmanagerargumentbo.getOrgId();
				}
				String[] argmentStr={"1","2"};
				Hashtable hashTable=new Hashtable();
				for(int i=0;i<orgIdStr.length;i++){
					String orgIdValue=orgIdStr[i];
					OrgBO b = SysCacheTool.findOrgById(orgIdValue.trim());
					hashTable.put(orgIdValue, b.getName());
				}
				super.getHttpSession().removeAttribute("orgIdStr");
				super.getHttpSession().removeAttribute("argmentStr");
				super.getHttpSession().removeAttribute("hashTableValue");
				
				super.getHttpSession().setAttribute("orgIdStr",orgIdStr);
				super.getHttpSession().setAttribute("argmentStr",argmentStr);
				super.getHttpSession().setAttribute("hashTableValue",hashTable);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public List getDateList() {
		return dateList;
	}

	public void setDateList(List dateList) {
		this.dateList = dateList;
	}

	public String getInitEdit() {
		if(bo!=null){
			bo=new AttManagerArrangeBO();
		}
		if (super.getRequestParameter("superId") != null && !super.getRequestParameter("superId").equals("")) {
			superId = super.getRequestParameter("superId");
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	
	public AttManagerArrangeBO getBo() {
		return bo;
	}

	public void setBo(AttManagerArrangeBO bo) {
		this.bo = bo;
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

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getAmaId() {
		return amaId;
	}

	public void setAmaId(String amaId) {
		this.amaId = amaId;
	}

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			dateList=attenceSetUCC.getAllAttManagerArrangeBO(mypage,superId);
			if (dateList != null && dateList.size() > 0) {
				for (int i = 0; i < dateList.size(); i++) {
					AttManagerArrangeBO attmanagerarrangebo=(AttManagerArrangeBO)dateList.get(i);
					OrgBO b = SysCacheTool.findOrgById(attmanagerarrangebo.getOrgId());
					if (b != null) {
						attmanagerarrangebo.setOrgIdName(b.getName());
					}else{
						attmanagerarrangebo.setOrgIdName("");
					}
					attmanagerarrangebo.setStatus(attmanagerarrangebo.getStatus().trim());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String save(){
		try {
			 boolean success=true;
			 List lists=attenceSetUCC.findAttManagerArrangeBO(superId);
			 if (lists != null && lists.size() > 0) {
				 for (int i = 0; i < lists.size(); i++) {
					 AttManagerArrangeBO attmanagerarrangebo=(AttManagerArrangeBO)lists.get(i);
						if ("-1".equals(attmanagerarrangebo.getStatus().trim())
								|| "0".equals(attmanagerarrangebo.getStatus().trim())) {
							success=false;
							break;
						}
				 }
			 }
				if(success){
					bo.setOrgId(superId);
					bo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
					bo.setCreateOper(personName);;
					bo.setStatus("-1");
					attenceSetUCC.saveorupdateAttManagerArrangeBO(bo);
				}else{
					super.showMessageDetail("上个月自动排班未结束，不能进行此步操作！");
					return "";
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public String finish(){
		try{
		AttManagerArrangeBO attmanagerarrangebo=attenceSetUCC.findAttManagerArrangeBObyId(amaId);
		attmanagerarrangebo.setStatus("9");
		attenceSetUCC.saveorupdateAttManagerArrangeBO(attmanagerarrangebo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
}
