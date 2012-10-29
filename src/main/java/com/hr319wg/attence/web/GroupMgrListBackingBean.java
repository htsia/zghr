package com.hr319wg.attence.web;


import java.util.List;

import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class GroupMgrListBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
	private String groupId;
	private String superName;
    private List attmachineList;	
    private PageVO mypage = new PageVO();
	private String superId=super.getUserInfo().getOrgId();
	private String pageInit;
	private String initItem;
	private List itemList;
	private String machineID;
	private boolean isExist1 = false;
	private boolean isExist = false;
	private PageVO mypage1 = new PageVO();
    private String queryValue;

    public String getQueryValue() {
        return queryValue;
    }

    public void setQueryValue(String queryValue) {
        this.queryValue = queryValue;
    }

    public String first1() {
		mypage1.setCurrentPage(1);
		doQuery1();
		return "";
	}

	public String pre1() {
		if (mypage1.getCurrentPage() > 1) {
			mypage1.setCurrentPage(mypage1.getCurrentPage() - 1);
		}
		doQuery1();
		return "";
	}

	public String next1() {
		if (mypage1.getCurrentPage() < mypage1.getTotalPage()) {
			mypage1.setCurrentPage(mypage1.getCurrentPage() + 1);
		}
		doQuery1();
		return "";
	}

	public String last1() {
		mypage1.setCurrentPage(mypage1.getTotalPage());
		doQuery1();
		return "";
	}
	
	public PageVO getMypage1() {
		return mypage1;
	}

	public void setMypage1(PageVO mypage1) {
		this.mypage1 = mypage1;
	}

	public boolean getIsExist() {
		return isExist;
	}

	public void setExist(boolean isExist) {
		this.isExist = isExist;
	}

	public boolean getIsExist1() {
		return isExist1;
	}

	public void setExist1(boolean isExist1) {
		this.isExist1 = isExist1;
	}
	
    public String first() {
		mypage.setCurrentPage(1);
		if(groupId!=null && !"".equals(groupId)){
		doQuery();
    	}
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		if(groupId!=null && !"".equals(groupId)){
			doQuery();
	    	}
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		if(groupId!=null && !"".equals(groupId)){
			doQuery();
	    	}
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		if(groupId!=null && !"".equals(groupId)){
			doQuery();
	    	}
		return "";
	}
    
	
	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			attmachineList=attenceSetUCC.getAllAttClassGroupVO(mypage,superId,groupId,queryValue);
			if(attmachineList!=null && attmachineList.size()>0){
				for(int i=0;i<attmachineList.size();i++){
					AttClassGroupVO vo=(AttClassGroupVO)attmachineList.get(i);
		            vo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, vo.getOrgId()));
                    vo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, vo.getDeptId()));
					attmachineList.set(i, vo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
    
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	
	
	public String getPageInit() {
		try {
		if (super.getRequestParameter("groupId") != null && !"".equals(super.getRequestParameter("groupId"))) {
			groupId = super.getRequestParameter("groupId");
			AttClassGroupBO bo3=attenceSetUCC.findAttClassGroupBObyId(groupId);
			if(bo3.getLinkClass()!=null && !"".equals(bo3.getLinkClass())){
				isExist =false;
				isExist1 = false;
			}else{
				if("4".equals(bo3.getGroupType())){
					isExist =false;
					isExist1 = true;
				}else{
					isExist = true;
					isExist1 = false;
				}
			}
		}		
		
		
		} catch (SysException e) {
			e.printStackTrace();
		}
		doQuery();
		
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public List getAttmachineList() {
		return attmachineList;
	}

	public void setAttmachineList(List attmachineList) {
		this.attmachineList = attmachineList;
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


	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
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

	public String getInitItem() {
		if (super.getRequestParameter("groupId") != null && !"".equals(super.getRequestParameter("groupId"))) {
			groupId = super.getRequestParameter("groupId");			
		}
		if (super.getRequestParameter("superId") != null && !"".equals(super.getRequestParameter("superId"))) {
			superId = super.getRequestParameter("superId");			
		}
		doQuery1();
		return initItem;
	}

	public void setInitItem(String initItem) {
		this.initItem = initItem;
	}
	public void doQuery1() {
		try {
			if (mypage1.getCurrentPage() == 0) {
				mypage1.setCurrentPage(1);
			}
			itemList=attenceSetUCC.getAllAttClassGroupVO1(mypage1,superId);
			if(itemList!=null && itemList.size()>0){
				for(int i=0;i<itemList.size();i++){
					AttClassGroupVO vo=(AttClassGroupVO)itemList.get(i);
		            vo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, vo.getOrgId()));
                    vo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, vo.getDeptId()));
					itemList.set(i, vo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public List getItemList() {
		return itemList;
	}

	public void setItemList(List itemList) {
		this.itemList = itemList;
	}
	
	public String openUser() {
		String ids[] = getServletRequest().getParameterValues("selected_ids");
    	try
		{
    		if(ids!=null){
    		for (int i = 0; i < ids.length; i++)
			{
    			AttClassGroupVO vo1=attenceSetUCC.findAttClassGroupVObyId(ids[i]);
    			vo1.setGroupNo(groupId);
    			attenceSetUCC.saveAttClassGroupVO(vo1);
    			
			}
    		return "success";
    		}else{
    			super.showMessageDetail("请先选择人员！");
    		}
		}
		catch (Exception ex)
		{
			msg.setMainMsg(ex, getClass());
		}
		return "";
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
				attenceSetUCC.UpdateAttClassGroupVO(machineID, "");
			}
		} catch (Exception e) {
			super.showMessageDetail("删除失败！");
		}
		return "";
	}
}
