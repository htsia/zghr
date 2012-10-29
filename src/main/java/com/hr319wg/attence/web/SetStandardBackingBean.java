package com.hr319wg.attence.web;

import java.util.List;

import com.hr319wg.attence.pojo.bo.AttenceStandBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class SetStandardBackingBean extends BaseBackingBean {
	private String orgIdsss=super.getUserInfo().getOrgId();
	private String initEdit;
	private String initEdit1;
	private String orgId;
	private String orgId1;
	private AttenceStandBO bo=new AttenceStandBO();
	private List dateList;
	private List dateList1;
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;
	private PageVO mypage = new PageVO();
	private boolean isExist;
	
	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
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

	public List getDateList() {
		return dateList;
	}

	public void setDateList(List dateList) {
		this.dateList = dateList;
	}

	public AttenceStandBO getBo() {
		return bo;
	}

	public void setBo(AttenceStandBO bo) {
		this.bo = bo;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getInitEdit() {
		try{
		if (super.getRequestParameter("subId") != null
				&& !super.getRequestParameter("subId").equals("")
				&& super.getRequestParameter("orgId") != null
				&& !super.getRequestParameter("orgId").equals("")) {
			String subId1 = super.getRequestParameter("subId");
			String orgId1 = super.getRequestParameter("orgId");
			List lists=attenceSetUCC.findAttenceStandBO(subId1,orgId1);
			bo=(AttenceStandBO)lists.get(0);
			OrgBO b = SysCacheTool.findOrgById(bo.getOrguid());
			bo.setOrguidName(b.getName());
			orgId=bo.getOrguid();
			isExist = false;
		}else if(super.getRequestParameter("ok") != null && !super.getRequestParameter("ok").equals("")){
			bo=new AttenceStandBO();
			isExist = true;
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public List getDateList1() {
		return dateList1;
	}

	public void setDateList1(List dateList1) {
		this.dateList1 = dateList1;
	}

	public String getOrgId1() {
		return orgId1;
	}

	public void setOrgId1(String orgId1) {
		this.orgId1 = orgId1;
	}

	public String getInitEdit1() {
		 if(super.getRequestParameter("orgId") != null && !super.getRequestParameter("orgId").equals("")){
			 orgId1=super.getRequestParameter("orgId");
		  }
		doQuery1();
		return initEdit1;
	}

	public void setInitEdit1(String initEdit1) {
		this.initEdit1 = initEdit1;
	}

	public String getOrgIdsss() {
		return orgIdsss;
	}

	public void setOrgIdsss(String orgIdsss) {
		this.orgIdsss = orgIdsss;
	}

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if(super.getUserInfo().getprocessUnit().equals(RoleInfoBO.ORGTYPE_ALL)){
				dateList=attenceSetUCC.getAllAttenceStandBO(mypage);
			}else{
				dateList=attenceSetUCC.getAllAttenceStandBO(mypage,orgIdsss);
			}
			if (dateList != null && dateList.size() > 0) {
				for (int i = 0; i < dateList.size(); i++) {
					AttenceStandBO attencestandbo=(AttenceStandBO)dateList.get(i);
					OrgBO b = SysCacheTool.findOrgById(attencestandbo.getOrguid());
					attencestandbo.setOrguidName(b.getName());
					dateList.set(i, attencestandbo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void doQuery1() {
		try {
			dateList1=attenceSetUCC.findAttenceStandBO1(orgId1);
			if (dateList1 != null && dateList1.size() > 0) {
				for (int i = 0; i < dateList1.size(); i++) {
					AttenceStandBO attencestandbo=(AttenceStandBO)dateList1.get(i);
					OrgBO b = SysCacheTool.findOrgById(attencestandbo.getOrguid());
					attencestandbo.setOrguidName(b.getName());
					dateList1.set(i, attencestandbo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String save(){
		try{
		if(orgId!=null && !"".equals(orgId)){
			String[] orgIds=orgId.split(",");
			for(int i=0;i<orgIds.length;i++){
				String names=attenceSetUCC.selectB737(orgIds[i]);
				if(names!=null && !"".equals(names)){
					OrgBO b = SysCacheTool.findOrgById(orgIds[i]);
					super.showMessageDetail("应用范围是：（"+b.getName()+"）已经选择");
					return "";
				}else{
					AttenceStandBO attencestandbo=new AttenceStandBO();
					attencestandbo.setSubID(SequenceGenerator.getKeyId("B737"));
					attencestandbo.setOrguid(orgIds[i]);
					attencestandbo.setRecord(Constants.YES);
					attencestandbo.setAttenceDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
					attencestandbo.setStandWork(bo.getStandWork());
					attencestandbo.setPersonNumber(bo.getPersonNumber());
					attenceSetUCC.saveorupdateAttenceStandBO(attencestandbo);
				}
			}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	public String save1(){
		try{
			attenceSetUCC.UpdateB737(bo.getOrguid());
			bo.setSubID(SequenceGenerator.getKeyId("B737"));
			bo.setRecord(Constants.YES);
			bo.setAttenceDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
			attenceSetUCC.saveorupdateAttenceStandBO(bo);
			}catch(Exception e){
				e.printStackTrace();
			}
		return "success";
	}
	
}
