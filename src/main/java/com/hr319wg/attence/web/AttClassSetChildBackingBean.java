package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassDetailBO;
import com.hr319wg.attence.pojo.bo.AttClassUserBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.vo.UserQryVO;
import com.hr319wg.user.ucc.IUserQryUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class AttClassSetChildBackingBean extends BaseBackingBean {
	private String overtimeflag = "0";
	private IAttenceSetUCC attenceSetUCC;
	private PageVO mypage = new PageVO();
	private List itemList;
	private String superID = super.getUserInfo().getOrgId();
	private String initItem;
	private String superName;
	private String initEdit;
	private String initFrequency;
	private String addPersonInit;	
	private AttClassBO attClassBO = new AttClassBO();
	private String atttype;
	private String setStatus = "1";
	private String setStatuss = "1";
	private String setStatusss = "1";
	private String classID;
	private String frequencyType;
	private String frequencyTxt;
	private String applyBeginDate;
	private String applyEndDate;
	private String currUserId;
	private IUserQryUCC userqryucc;
	private List qryList;
	private String qryID;
	private String nameStr;
	private String personType;
	private String personTypeValue;
	private String orgID;
	private UserAPI userapi;
	private List<AttClassUserBO> personList;
	private String selectedUserIDs;
	private String operClassUserID;
	private IAttBusiService attBusiService;
	
	
	public List<AttClassUserBO> getPersonList() {
		return personList;
	}

	public void setPersonList(List<AttClassUserBO> personList) {
		this.personList = personList;
	}


	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}

	public String getOperClassUserID() {
		return operClassUserID;
	}

	public void setOperClassUserID(String operClassUserID) {
		this.operClassUserID = operClassUserID;
	}

	public void setAddPersonInit(String addPersonInit) {
		
		this.addPersonInit = addPersonInit;
	}

	public String getSelectedUserIDs() {
		return selectedUserIDs;
	}

	public void setSelectedUserIDs(String selectedUserIDs) {
		this.selectedUserIDs = selectedUserIDs;
	}

	public UserAPI getUserapi() {
		return userapi;
	}

	public void setUserapi(UserAPI userapi) {
		this.userapi = userapi;
	}

	public String getNameStr() {
		return nameStr;
	}

	public void setNameStr(String nameStr) {
		this.nameStr = nameStr;
	}

	public String getPersonType() {
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getPersonTypeValue() {
		return personTypeValue;
	}

	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public void setInitFrequency(String initFrequency) {
		this.initFrequency = initFrequency;
	}

	public String first1() {
		mypage.setCurrentPage(1);
		return "";
	}

	public String pre1() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return "";
	}

	public String next1() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return "";
	}

	public String last1() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return "";
	}

	public String getAddPersonInit() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.nameStr=null;
			this.personType=null;
			this.orgID=null;
			this.selectedUserIDs=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null){
			this.orgID=orgID1;
		}
		String classID1 = super.getRequestParameter("classID");
		if(classID1!=null){
			this.classID=classID1;
		}
		doPersonQuery();
		return addPersonInit;
	}

	
	public IUserQryUCC getUserqryucc() {
		return userqryucc;
	}

	public void setUserqryucc(IUserQryUCC userqryucc) {
		this.userqryucc = userqryucc;
	}

	public List getQryList() {
		return qryList;
	}

	public void setQryList(List qryList) {
		this.qryList = qryList;
	}

	public String getQryID() {
		return qryID;
	}

	public void setQryID(String qryID) {
		this.qryID = qryID;
	}


	public String getCurrUserId() {
		return currUserId;
	}

	public void setCurrUserId(String currUserId) {
		this.currUserId = currUserId;
	}

	public String getApplyBeginDate() {
		return applyBeginDate;
	}

	public void setApplyBeginDate(String applyBeginDate) {
		this.applyBeginDate = applyBeginDate;
	}

	public String getApplyEndDate() {
		return applyEndDate;
	}

	public void setApplyEndDate(String applyEndDate) {
		this.applyEndDate = applyEndDate;
	}


	public String getFrequencyTxt() {
		return frequencyTxt;
	}

	public void setFrequencyTxt(String frequencyTxt) {
		this.frequencyTxt = frequencyTxt;
	}

	public String getClassID() {
		return classID;
	}

	public void setClassID(String classID) {
		this.classID = classID;
	}

	public AttClassBO getAttClassBO() {
		return attClassBO;
	}

	public void setAttClassBO(AttClassBO attClassBO) {
		this.attClassBO = attClassBO;
	}

	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}

	public String getSetStatus() {
		return setStatus;
	}

	public void setSetStatus(String setStatus) {
		this.setStatus = setStatus;
	}

	public String getSetStatuss() {
		return setStatuss;
	}

	public void setSetStatuss(String setStatuss) {
		this.setStatuss = setStatuss;
	}

	public String getSetStatusss() {
		return setStatusss;
	}

	public void setSetStatusss(String setStatusss) {
		this.setStatusss = setStatusss;
	}

	public String getOvertimeflag() {
		return overtimeflag;
	}

	public void setOvertimeflag(String overtimeflag) {
		this.overtimeflag = overtimeflag;
	}
	public String getFrequencyType() {
		return frequencyType;
	}

	public void setFrequencyType(String frequencyType) {
		this.frequencyType = frequencyType;
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

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			itemList = attenceSetUCC.getAllAttClassBO(mypage, superID);
			if (itemList != null && itemList.size() > 0) {
				for (int i = 0; i < itemList.size(); i++) {
					AttClassBO attClassBO = (AttClassBO) itemList.get(i);
					if (!"-1".equals(attClassBO.getOrgID())) {
						OrgBO b = SysCacheTool.findOrgById(attClassBO
								.getOrgID());
						if (b != null) {
							attClassBO.setOrgName(b.getName());
						}
					} else {
						attClassBO.setOrgName("全集团");
					}

					String isUse = attClassBO.getIsUse();
					if ("0".equals(isUse)) {
						attClassBO.setIsUseName("禁用");
					} else if ("1".equals(isUse)) {
						attClassBO.setIsUseName("启用");
					}

					String overtimeflag = attClassBO.getOverTimeFlag();
					if ("0".equals(overtimeflag)) {
						attClassBO.setOverTimeFlagName("否");
					} else if ("1".equals(overtimeflag)) {
						attClassBO.setOverTimeFlagName("是");
					}

					itemList.set(i, attClassBO);

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

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public List getItemList() {
		return itemList;
	}

	public void setItemList(List itemList) {
		this.itemList = itemList;
	}

	public String getSuperID() {
		return superID;
	}

	public void setSuperID(String superID) {
		this.superID = superID;
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(superID);
		superName = b.getName();
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public String getInitItem() {
		if (super.getRequestParameter("superID") != null) {
			superID = super.getRequestParameter("superID");
			OrgBO b = SysCacheTool.findOrgById(superID);
			superName = b.getName();
		} else {
			String orgID = super.getUserInfo().getOrgId();
			OrgBO org = SysCacheTool.findOrgById(orgID);
			superName = org.getName();
		}
		doQuery();
		return initItem;
	}

	public void setInitItem(String initItem) {
		this.initItem = initItem;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("superID") != null) {
				superID = super.getRequestParameter("superID");
				attClassBO = new AttClassBO();
				OrgBO b = SysCacheTool.findOrgById(this.superID);
				if (b != null) {
					attClassBO.setOrgName(b.getName());
				} else {
					attClassBO.setOrgName("");
				}
				User user = this.getUserInfo();
				PersonBO person = SysCacheTool.findPersonById(user.getUserId());
				attClassBO.setCreateUser(person.getName());
				attClassBO.setClassName("");
				attClassBO.setCreateDate("");
				attClassBO.setSectionCount("");
			} else if (super.getRequestParameter("classID") != null
					&& !super.getRequestParameter("classID").equals("")
					&& super.getRequestParameter("oid") != null
					&& !super.getRequestParameter("oid").equals("")) {
				String classID = super.getRequestParameter("classID");
				String oid = super.getRequestParameter("oid");
				attClassBO = attenceSetUCC.findAttClassBObyId(classID);
				attClassBO.setSectionCounts(attClassBO.getSectionCount());
				if (attClassBO != null) {
					String isUse3 = attClassBO.getDaySpan();
					if ("1".equals(isUse3)) {
						setStatuss = "1";
					} else if ("2".equals(isUse3)) {
						setStatuss = "2";
					}
					String isUse4 = attClassBO.getDayTake();
					if ("1".equals(isUse4)) {
						setStatusss = "1";
					} else if ("2".equals(isUse4)) {
						setStatusss = "2";
					}
					String isUse5 = attClassBO.getOverTimeFlag();
					if ("0".equals(isUse5)) {
						overtimeflag = "0";
					} else if ("1".equals(isUse5)) {
						overtimeflag = "1";
					}
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public String save() {
		attClassBO.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		attClassBO.setCreateOrg(superID);
		attClassBO.setOrgID(atttype);
		attClassBO.setIsUse(setStatus);
		attClassBO.setDaySpan(setStatuss);
		attClassBO.setDayTake(setStatusss);
		attClassBO.setSectionCount(" ");
		attClassBO.setOverTimeFlag(overtimeflag);
//		attClassBO.setFrequencyType("0");
//		attClassBO.setUserOrOrgType("0");
		try {
			attenceSetUCC.saveAttClassBO(attClassBO);
			if (!attClassBO.getSectionCount().equals(
					attClassBO.getSectionCounts())) {
				List lists = attenceSetUCC.getAllAttClassDetailBOS(attClassBO
						.getClassID());
				if (lists != null && lists.size() > 0) {
					for (int x = 0; x < lists.size(); x++) {
						AttClassDetailBO attclassdetailbo = (AttClassDetailBO) lists
								.get(x);
						attenceSetUCC.deleteAttClassDetailBO(attclassdetailbo);
					}
				}
				String[] details = { "上午上限打卡开始", "上班时刻", "迟到时刻", "旷工时刻",
						"下午上限打卡开始", "上班时刻", "迟到时刻", "旷工时刻"};
				for (int j = 0; j < 8; j++) {
					AttClassDetailBO attClassDetailBO = new AttClassDetailBO();
					attClassDetailBO.setClassID(attClassBO.getClassID());
					attClassDetailBO.setItemName(details[j]);
					attClassDetailBO.setItemTime("");
					attClassDetailBO.setDayFlag("1");
					attClassDetailBO.setOrderFlag(""+j);
					attenceSetUCC.saveAttClassDetailBO(attClassDetailBO);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String openUser() {
		String ids[] = getServletRequest().getParameterValues("selected_ids");
		try {
			String name = "";
			if (ids != null) {
				for (int i = 0; i < ids.length; i++) {
					AttClassBO attClassBO1 = attenceSetUCC
							.findAttClassBObyId(ids[i]);
					if (!superID.equals(attClassBO1.getCreateOrg())) {
						name += attClassBO1.getClassName() + ",";
						continue;
					}
					AttClassBO attClassBO3 = attenceSetUCC
							.findAttClassBObyId(ids[i]);
					attClassBO3.setIsUse("1");
					attenceSetUCC.saveAttClassBO(attClassBO3);
				}
			}
			if (name != null && !"".equals(name)) {
				super.showMessageDetail("对班次：【" + name + "】你无权进行启用操作");
			}
		} catch (Exception ex) {
			msg.setMainMsg(ex, getClass());
		}
		return "";
	}

	public String closeUser() {
		String ids[] = getServletRequest().getParameterValues("selected_ids");
		try {
			String name = "";
			if (ids != null) {
				for (int i = 0; i < ids.length; i++) {
					AttClassBO attClassBO1 = attenceSetUCC
							.findAttClassBObyId(ids[i]);
					if (!superID.equals(attClassBO1.getCreateOrg())) {
						name += attClassBO1.getClassName() + ",";
						continue;
					}
					AttClassBO attClassBO4 = attenceSetUCC
							.findAttClassBObyId(ids[i]);
					attClassBO4.setIsUse("0");
					attenceSetUCC.saveAttClassBO(attClassBO4);
				}
			}
			if (name != null && !"".equals(name)) {
				super.showMessageDetail("对班次：【" + name + "】你无权进行禁用操作");
			}
		} catch (Exception ex) {
			msg.setMainMsg(ex, getClass());
		}
		return "";
	}

	public String deleteBatch() {
		String ids[] = getServletRequest().getParameterValues("selected_ids");
		try {
			String name = "";
			for (int i = 0; i < ids.length; i++) {
				AttClassBO attClassBO1 = attenceSetUCC
						.findAttClassBObyId(ids[i]);
				if (!superID.equals(attClassBO1.getCreateOrg())) {
					name += attClassBO1.getClassName() + ",";
					continue;
				}
                boolean isUse=attenceSetUCC.checkAttClassIsUse(ids[i]);
                if(isUse){
                    name += attClassBO1.getClassName() + ",";
                    continue;
                }
                
                List detailList = this.attenceSetUCC.getAllAttClassDetailBO1(ids[i]);
                if(detailList!=null && detailList.size()>0){
                	attenceSetUCC.deleteAllByList(detailList);                	
                }
				AttClassBO attClassBO2 = new AttClassBO();
				attClassBO2.setClassID(ids[i]);
				attenceSetUCC.deleteAttClassBO(attClassBO2);
			}
			if (name != null && !"".equals(name)) {
				super.showMessageDetail("对班次：【" + name + "】正在使用中");
			}
		} catch (Exception ex) {
			msg.setMainMsg(ex, getClass());
		}
		return "";
	}
    
	public void changeStatus(ValueChangeEvent event) {
		this.atttype = event.getNewValue().toString();
	}

	/**
	 * 频率初始化页面
	 * @return
	 */
	public String getInitFrequency() {
		String id = super.getRequestParameter("classId");
		if(id != null){
			try {
				attClassBO = attenceSetUCC.findAttClassBObyId(id);
				frequencyType=attClassBO.getFrequencyType();
				frequencyTxt=attClassBO.getFrequencyTxt();
				applyBeginDate=attClassBO.getApplyBeginDate();
				applyEndDate=attClassBO.getApplyEndDate();
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		return "";
	}
	
	/**
	 * 人员设置初始化页面
	 * @return
	 */
	public String getInitPerson() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			qryList = new ArrayList();
		}
		String id = super.getRequestParameter("classId");
		if(id != null){
			classID=id;
			try {
				attClassBO = attenceSetUCC.findAttClassBObyId(id);
				this.qryID = attClassBO.getRaleQry();
				List list = this.userqryucc.queryUserQry(super.getUserInfo().getUserId(), "0311");
				qryList = new ArrayList();
				SelectItem item1 = new SelectItem("-1", "--选择查询方案--");
				qryList.add(item1);
				for (int i = 0; i < list.size(); i++) {
			        UserQryVO role = (UserQryVO)list.get(i);
			        SelectItem item = new SelectItem();
			        item.setLabel(role.getQryName());
			        item.setValue(role.getQryID());
			        qryList.add(item);
				}
		        
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		
		return "";
	}
	
	/**
	 * 保存频率设置
	 * @return
	 */
	public String saveFrequency() {
		attClassBO.setFrequencyType(this.frequencyType);
		attClassBO.setFrequencyTxt(this.frequencyTxt);
		attClassBO.setApplyBeginDate(this.applyBeginDate);
		attClassBO.setApplyEndDate(this.applyEndDate);
		try {
			attenceSetUCC.saveAttClassBO(attClassBO);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	/**
	 * 保存人员设置
	 * @return
	 */
	public String savePerson() {
		try {
			attClassBO.setRaleQry(this.qryID);
			attenceSetUCC.saveAttClassBO(attClassBO);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public void changeRaleType(ValueChangeEvent event) {
		this.attClassBO.setRaleType(event.getNewValue().toString());
	}
	
	public void doPersonQuery(){
		
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		if(mypage.getCurrentPage()==0){
			mypage.setCurrentPage(1);
		}
		try {
			this.personList = this.attBusiService.getAllAttClassUserBOByClassID(mypage, this.orgID, this.nameStr, this.personType, this.classID);
			if(this.personList==null){
				this.personList=new ArrayList();
			}
			for(AttClassUserBO bo : this.personList){
				PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
				bo.setName(p.getName());
				bo.setBianhao(p.getPersonCode());
				bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
				bo.setUserType(CodeUtil.interpertCode(p.getPersonType()));
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void saveSelectedPerson(){
		if(this.selectedUserIDs!=null && !"".equals(this.selectedUserIDs)){
			String[]userIDs = this.selectedUserIDs.split(",");
			for(int i=0;i<userIDs.length;i++){
				boolean flag = true;
				if(this.personList!=null){
					for(AttClassUserBO cBo : this.personList){
						if(cBo.getUserID().equals(userIDs[i])){
							flag=false;
							break;
						}
					}
				}
				if(flag){
					AttClassUserBO userBO = new AttClassUserBO();
					userBO.setClassID(this.classID);
					userBO.setUserID(userIDs[i]);
					try {
						this.attBusiService.saveOrUpdateBO(userBO);
					} catch (SysException e) {
						e.printStackTrace();
					}					
				}
			}
		}
	}
	
	public void deletePerson(){
		try {
			this.attBusiService.deleteBO(AttClassUserBO.class, this.operClassUserID);
			super.showMessageDetail("删除成功");
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	public String colse1(){
		//super.showMessageDetail("删除成功");
		return "success";
	}
}
