package com.hr319wg.custom.emp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.emp.pojo.bo.EmpPersonTypeChangeBO;
import com.hr319wg.custom.emp.pojo.bo.OrgPersonTypeChangeBO;
import com.hr319wg.custom.emp.service.IEmpTypeChangeService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CodeUtil;

public class EmpTypeChangeBackingBean extends BaseBackingBean{

	private String pageInit;
	private String editInit;
	private String initOrgEdit;
	private String orgID;
	private String orgName;
	private String name;
	private boolean apprived;
	private String time;
	private String time2;
	private String newType;
	private PageVO mypage= new PageVO();
	private Map selMap = new HashMap();
	private String personIDs="";
	private String personNames="";
	private String operID;
	private List<EmpPersonTypeChangeBO> list;
	private IEmpTypeChangeService changeService;
	private OrgPersonTypeChangeBO orgchangebo;
	private List baseFields;
	private String infoItem;
	private String typeChangeIDs;
	
	public String getTypeChangeIDs() {
		return typeChangeIDs;
	}
	public void setTypeChangeIDs(String typeChangeIDs) {
		this.typeChangeIDs = typeChangeIDs;
	}
	public OrgPersonTypeChangeBO getOrgchangebo() {
		return orgchangebo;
	}
	public void setOrgchangebo(OrgPersonTypeChangeBO orgchangebo) {
		this.orgchangebo = orgchangebo;
	}
	public String getInfoItem() {
		return infoItem;
	}
	public void setInfoItem(String infoItem) {
		this.infoItem = infoItem;
	}
	public List getBaseFields() {
		return baseFields;
	}
	public void setBaseFields(List baseFields) {
		this.baseFields = baseFields;
	}
	public OrgPersonTypeChangeBO getorgchangebo() {
		return orgchangebo;
	}
	public void setorgchangebo(OrgPersonTypeChangeBO orgchangebo) {
		this.orgchangebo = orgchangebo;
	}
	public String getOperID() {
		return operID;
	}
	public void setOperID(String operID) {
		this.operID = operID;
	}
	public String getNewType() {
		return newType;
	}
	public void setNewType(String newType) {
		this.newType = newType;
	}
	public Map getSelMap() {
		return selMap;
	}
	public void setSelMap(Map selMap) {
		this.selMap = selMap;
	}
	public String getPersonIDs() {
		return personIDs;
	}
	public void setPersonIDs(String personIDs) {
		this.personIDs = personIDs;
	}
	public String getPersonNames() {
		return personNames;
	}
	public void setPersonNames(String personNames) {
		this.personNames = personNames;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getTime2() {
		return time2;
	}
	public void setTime2(String time2) {
		this.time2 = time2;
	}
	public List<EmpPersonTypeChangeBO> getList() {
		return list;
	}
	public void setList(List<EmpPersonTypeChangeBO> list) {
		this.list = list;
	}
	public boolean isApprived() {
		return apprived;
	}
	public void setApprived(boolean apprived) {
		this.apprived = apprived;
	}
	public PageVO getMypage() {
		return mypage;
	}
	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	public IEmpTypeChangeService getChangeService() {
		return changeService;
	}
	public void setChangeService(IEmpTypeChangeService changeService) {
		this.changeService = changeService;
	}
	public String getPageInit() {
		
		String orgID1=super.getRequestParameter("superId");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
			this.orgName=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.orgID);
		}
	    doQuery();
	    return this.pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public String getOrgID() {
		return orgID;
	}
	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String first() {
		this.mypage.setCurrentPage(1);
		return null;
	}

	public String pre() {
		if (this.mypage.getCurrentPage() > 1){
			this.mypage.setCurrentPage(this.mypage.getCurrentPage() - 1);
		}
		return null;
	}

	public String next() {
		if (this.mypage.getCurrentPage() < this.mypage.getTotalPage()) {
			this.mypage.setCurrentPage(this.mypage.getCurrentPage() + 1);
		}
		return null;
	}

	public String last() {
		this.mypage.setCurrentPage(this.mypage.getTotalPage());
		return null;
	}
	
	public void doQuery(){
		if (this.mypage.getCurrentPage() == 0){
	        this.mypage.setCurrentPage(1);
		}
		try {
			this.list=this.changeService.getEmpTypeChangeBO(mypage, this.orgID, super.getUserInfo(), this.name, this.apprived, this.time, this.time2);
		} catch (SysException e) {
			e.printStackTrace();
		}
		if(this.list==null){
			this.list=new ArrayList<EmpPersonTypeChangeBO>();			
		}
		for(EmpPersonTypeChangeBO bo : this.list){
			PersonBO p=SysCacheTool.findPersonById(bo.getPersonID());
			bo.setName(p.getName());
			bo.setPersonCode(p.getPersonCode());
			bo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getOrgId()));
			bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
			if(bo.getOldType()!=null){
				bo.setOldTypeDes(CodeUtil.interpertCode(bo.getOldType()));				
			}
			bo.setNewTypeDes(CodeUtil.interpertCode(bo.getNewType()));
			p=SysCacheTool.findPersonById(bo.getApplyPersonID());
			if(p!=null){
				bo.setApplyPersonName(p.getName());
			}
		}
	}
	
	public void queryApprived(ValueChangeEvent event) {
		this.apprived = "true".equals(event.getNewValue().toString());
	}
	
	public String getEditInit() {
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			this.selMap=new HashMap();
			this.personIDs="";
			this.personNames="";
		}
		return editInit;
	}
	public void setEditInit(String editInit) {
		this.editInit = editInit;
	}
	
	public void selPerson() {
		PersonBO[] pbos = (PersonBO[]) super.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
		if (pbos != null && pbos.length > 0) {
			for (PersonBO p : pbos) {
				if (!selMap.containsKey(p.getPersonId())) {
					selMap.put(p.getPersonId(), p.getName());
					this.personIDs += p.getPersonId() + ",";
					this.personNames += p.getName() + ",";
				}
			}
		}
	}
	
	// 保存人员类别变动
	public String save() {
		try {
			String[] ids = this.personIDs.split(",");
			this.changeService.batchSaveTypeChange(this.personIDs.split(","), this.newType, super.getUserInfo());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public void delete(){
		try {
			this.changeService.deleteTypeChange(this.operID);
			this.operID=null;
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void effect(){
		try {
			this.changeService.batchUpdateTypeChange(this.typeChangeIDs.split(","));
			this.typeChangeIDs=null;
			super.showMessageDetail("操作完成");
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String getInitOrgEdit() {
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			try {
				this.orgchangebo= (OrgPersonTypeChangeBO) this.changeService.getObjByID(OrgPersonTypeChangeBO.class, super.getUserInfo().getOrgId());
				if(this.orgchangebo==null){
					this.orgchangebo=new OrgPersonTypeChangeBO();
					this.orgchangebo.setOrgID(super.getUserInfo().getOrgId());
					this.changeService.saveObj(this.orgchangebo);
				}else{
					if (this.orgchangebo.getWageItem() != null && !"".equals(this.orgchangebo.getWageItem())) {
						this.baseFields=new ArrayList();
						String[] fs = this.orgchangebo.getWageItem().split(",");
						for (int i = 0; i < fs.length; i++) {
							InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
							ib.setItemSequence(String.valueOf(i + 1));
							ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, ib.getSetId()));
							if (!this.baseFields.contains(ib)){
								this.baseFields.add(ib);
							}
						}
					}
				}
				this.orgchangebo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.orgchangebo.getOrgID()));
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		
		return initOrgEdit;
	}
	public void setInitOrgEdit(String initOrgEdit) {
		this.initOrgEdit = initOrgEdit;
	}
	
	public String addfield() {
		if ((this.infoItem != null) && (!"".equals(this.infoItem))) {
			String[] inf = this.infoItem.replace('.', ',').split(",");
			InfoItemBO ib = SysCacheTool.findInfoItem("", inf[1]);
			ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, inf[0]));
			ib.setItemSequence(String.valueOf(this.baseFields.size() + 1));
			this.baseFields.add(ib);
		}
		return null;
	}
	
	public String saveOrgTypeChangeBO() {
		try {
			if ((this.baseFields != null) && (this.baseFields.size() > 0)) {
				String fs = ((InfoItemBO) this.baseFields.get(0)).getItemId();
				for (int i = 1; i < this.baseFields.size(); i++) {
					fs = fs + "," + ((InfoItemBO) this.baseFields.get(i)).getItemId();
				}
				this.orgchangebo.setWageItem(fs);
			} else {
				this.orgchangebo.setWageItem("");
			}
			this.changeService.saveObj(this.orgchangebo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public String delfield() {
		if ((this.infoItem != null) && (!"".equals(this.infoItem)) && (this.baseFields != null)) {
			int i = 0;
			while (i < this.baseFields.size()) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i);
				if (this.infoItem.equals(ib.getItemId())) {
					this.baseFields.remove(i);
					if ((this.orgchangebo.getWageItem() == null) || ("".equals(this.orgchangebo.getWageItem())))
						break;
					String items = "";
					String[] fs = this.orgchangebo.getWageItem().split(",");
					for (int j = 0; j < fs.length; j++) {
						InfoItemBO ib1 = SysCacheTool.findInfoItem("", fs[j]);
						if (!ib1.getItemId().equals(ib.getItemId())) {
							items = items + ib1.getItemId() + ",";
						}
					}
					break;
				}
				i++;
			}
		}
		return null;
	}

	public String movePre() {
		if ((this.infoItem != null) && (!"".equals(this.infoItem)) && (this.baseFields != null)) {
			int i = 0;
			while (i < this.baseFields.size()) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i);
				if (this.infoItem.equals(ib.getItemId()))
					break;
				i++;
			}
			if ((i < this.baseFields.size()) && (i > 0)) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i);
				this.baseFields.set(i, this.baseFields.get(i - 1));
				this.baseFields.set(i - 1, ib);
			}
		}
		return null;
	}

	public String moveNext() {
		if ((this.infoItem != null) && (!"".equals(this.infoItem))
				&& (this.baseFields != null)) {
			int i = 0;
			while (i < this.baseFields.size()) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i);
				if (this.infoItem.equals(ib.getItemId()))
					break;
				i++;
			}
			if (i < this.baseFields.size() - 1) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i + 1);
				this.baseFields.set(i + 1, this.baseFields.get(i));
				this.baseFields.set(i, ib);
			}
		}
		return null;
	}
}
