package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttFeastBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.dao.CodeItemDAO;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.util.CommonFuns;

public class AttFeastChildBackingBean extends BaseBackingBean {
	private String nowyearvalue;
	private IAttenceSetUCC attenceSetUCC;
	private String superId=super.getUserInfo().getOrgId();
	private String superName;
	private String PageInit;
	private PageVO mypage = new PageVO();
	private List attmachineList;
	private String initEdit;
	private String feastID;
	private AttFeastBO bo=new AttFeastBO();
    private String atttype;
    private String timeObject;
	
    private CodeItemDAO codeItemDAO;
    private String[]postLeiXing;
    private List<SelectItem> postLeiXingList = new ArrayList<SelectItem>();
    

	public List<SelectItem> getPostLeiXingList() {
		return postLeiXingList;
	}

	public void setPostLeiXingList(List<SelectItem> postLeiXingList) {
		this.postLeiXingList = postLeiXingList;
	}

	public CodeItemDAO getCodeItemDAO() {
		return codeItemDAO;
	}

	public void setCodeItemDAO(CodeItemDAO codeItemDAO) {
		this.codeItemDAO = codeItemDAO;
	}

	public String[] getPostLeiXing() {
		return postLeiXing;
	}

	public void setPostLeiXing(String[] postLeiXing) {
		this.postLeiXing = postLeiXing;
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
	public PageVO getMypage() {
		return mypage;
	}
	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	
	
	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			attmachineList=attenceSetUCC.getAllAttFeast(mypage, superId); 
			if(attmachineList!=null && attmachineList.size()>0){
				for(int i=0;i<attmachineList.size();i++){
					AttFeastBO attfeastbo=(AttFeastBO)attmachineList.get(i);
					attfeastbo.setFeastDate(attfeastbo.getBeginDate()+" 至 "+attfeastbo.getEndDate());
					if(!"-1".equals(attfeastbo.getOrgID())){
						OrgBO b = SysCacheTool.findOrgById(attfeastbo.getOrgID());
						if (b != null) {
							attfeastbo.setOrgIDName(b.getName());
						}
					}else{
						attfeastbo.setOrgIDName("全集团");
					}
				attmachineList.set(i, attfeastbo);
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

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("superId") != null  && !super.getRequestParameter("superId").equals("") ) {
				superId = super.getRequestParameter("superId");
				bo=new AttFeastBO();			
				OrgBO b = SysCacheTool.findOrgById(this.superId);
				if(b!=null){
					superName = b.getName();
					bo.setOrgID(superName);
				}else{
					bo.setOrgID("");
				}
				
				bo.setFeastName("");
				bo.setDescription("");
			}else if(super.getRequestParameter("feastID") != null && !super.getRequestParameter("feastID").equals("") && super.getRequestParameter("oid")!=null && !super.getRequestParameter("oid").equals("")  ){
				String feastID = super.getRequestParameter("feastID");
				String oid = super.getRequestParameter("oid");
				bo=attenceSetUCC.findAttFeastBObyId(feastID);
				if(bo.getPostLeiXing()!=null){
					this.postLeiXing=bo.getPostLeiXing().split(",");
				}
				if(bo!=null){
					if("-1".equals(bo.getOrgID())){
						superName="全集团";
						superId=oid;
					}else{
					OrgBO b = SysCacheTool.findOrgById(bo.getOrgID());
					superName = b.getName();
					superId=bo.getOrgID();
					}
				}
			}
			
			List<CodeItemBO> itemList = this.codeItemDAO.queryAllCodeItemForTree("2244");
			if(itemList!=null){
				List leixingList = new ArrayList();
				for(CodeItemBO bo: itemList){
					if("1".equals(bo.getItemStatus())){
						SelectItem item = new SelectItem(bo.getItemId(), bo.getItemName());
						leixingList.add(item);
					}
				}
				this.setPostLeiXingList(leixingList);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getFeastID() {
		return feastID;
	}

	public void setFeastID(String feastID) {
		this.feastID = feastID;
	}

	public AttFeastBO getBo() {
		return bo;
	}

	public void setBo(AttFeastBO bo) {
		this.bo = bo;
	}

	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}
		
	public String getTimeObject() {
		return timeObject;
	}

	public void setTimeObject(String timeObject) {
		this.timeObject = timeObject;
	}

	public String save(){
		    if(nowyearvalue!=null && !"".equals(nowyearvalue)){
		      if("0".equals(nowyearvalue)){
		    	  bo.setYear("0");
		      }else{
		    	  bo.setYear("-1");
		      }
		    }else{
		      bo.setYear("0");
		    }
		    bo.setOrgID(atttype);
			bo.setRegTime(CommonFuns.getSysDate("yyyy-MM-dd"));
			String leixing="";
			if(this.postLeiXing!=null){
				for(int i=0;i<this.postLeiXing.length;i++){
					leixing+=this.postLeiXing[i]+",";
				}
			}
			bo.setPostLeiXing(leixing);
			
			try {
				attenceSetUCC.saveorupdateAttFeast(bo);
			} catch (SysException e) {
				e.printStackTrace();
			}
			return "success";			
		
	}
	
	public String delete(){
		try {
			if (feastID != null) {
				attenceSetUCC.deleteAttFeastBO(feastID);
				attenceSetUCC.deleteAttWorkDateIsFeastId(feastID);
			}
		} catch (Exception e) {
			super.showMessageDetail("删除失败！");
		}
		return "";
	}
	
	public void changeStatus(ValueChangeEvent event){
		   this.atttype = event.getNewValue().toString();
		}
	
	
    public String getNowyearvalue() {
		return nowyearvalue;
	}

	public void setNowyearvalue(String nowyearvalue) {
		this.nowyearvalue = nowyearvalue;
	}

	public void changeNowYearValue(ValueChangeEvent event){
        this.nowyearvalue=event.getNewValue().toString();
    }

}
