package com.hr319wg.custom.attence.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;

import com.hr319wg.attence.pojo.bo.AttenceLogBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.pojo.bo.AttMachineBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class AttLogMgrBackingBean extends BaseBackingBean {
	
	private User user = super.getUserInfo();
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String checkinInit;
	private String orgID;
	private String logDateTime;
	private String nameStr;
	private String personType;
	private String personTypeValue;
	private String creteType;
	private UserAPI userapi;
	private List logList;
	private String selectedUserIds;
	private String selectPersonNames;
	private IAttBusiService attBusiService;
	private String beginDate;
	private String endDate;
	
	
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getSelectedUserIds() {
		return selectedUserIds;
	}
	public void setSelectedUserIds(String selectedUserIds) {
		this.selectedUserIds = selectedUserIds;
	}
	public String getSelectPersonNames() {
		return selectPersonNames;
	}
	public void setSelectPersonNames(String selectPersonNames) {
		this.selectPersonNames = selectPersonNames;
	}
	public String getCreteType() {
		return creteType;
	}
	public void setCreteType(String creteType) {
		this.creteType = creteType;
	}
	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}
	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}
	public List getLogList() {
		return logList;
	}
	public void setLogList(List logList) {
		this.logList = logList;
	}
	public String getLogDateTime() {
		return logDateTime;
	}
	public void setLogDateTime(String logDateTime) {
		this.logDateTime = logDateTime;
	}

	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public PageVO getMypage() {
		return mypage;
	}
	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String first() {
		mypage.setCurrentPage(1);
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return "";
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
	public UserAPI getUserapi() {
		return userapi;
	}
	public void setUserapi(UserAPI userapi) {
		this.userapi = userapi;
	}
	
	
	public String getCheckinInit(){
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.selectedUserIds=null;
			this.selectPersonNames=null;
			this.logDateTime=CommonFuns.getSysDate("yyyy-MM-dd HH:mm");
		}
		return null;
	}
	
	public String checkin(){
		if(this.selectedUserIds!=null){
			String[]dateTime = this.logDateTime.split(" ");
			String[]userIDs=this.selectedUserIds.split(",");
			for(int i=0;i<userIDs.length;i++){
				try {
					this.attBusiService.checkin(userIDs[i], dateTime[0], dateTime[1]);
					this.logDateTime=null;
					if(i==userIDs.length-1){
						return "success";						
					}
				} catch (SysException e) {
					super.showMessageDetail("签到失败");
					e.printStackTrace();
				}
			}
		}
		
		return null;
	}
	
	public String getPageInit(){
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
			this.nameStr=null;
		}
		String createType1 = super.getRequestParameter("createType");
		if(createType1!=null && !"".equals(createType1)){
			this.creteType="1";
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		if (mypage.getCurrentPage() == 0) {
			mypage.setCurrentPage(1);
		}
		
		queryLog();
		return null;
	}
	public void selPerson(){
		if(this.selectedUserIds!=null && !"".equals(this.selectedUserIds)){
			String[]userIDs=this.selectedUserIds.split(",");
			for(int i=0;i<userIDs.length;i++){
				PersonBO p = SysCacheTool.findPersonById(userIDs[i]);
				this.selectPersonNames+=p.getName();
				if(i!=userIDs.length){
					this.selectPersonNames+=",";
				}
			}
		}
	}
	public void queryLog(){
		try {
			List list = this.attBusiService.getAllLogBO(this.mypage, this.orgID, this.nameStr, this.personType, this.creteType,this.beginDate,this.endDate);
			logList = new ArrayList();
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					Object[]obj = (Object[])list.get(i);
					AttenceLogBO log = (AttenceLogBO)obj[0];
					PersonBO p = SysCacheTool.findPersonById(log.getPersonId());
					Map m = new HashedMap();
					m.put("name", p.getName());
					m.put("personType", CodeUtil.interpertCode(p.getPersonType()));
					m.put("personSeq", p.getPersonCode());
					m.put("secDeptName", CodeUtil.interpertCode(obj[1].toString()));
					m.put("deptName", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
					m.put("date", log.getCardDate());
					m.put("time", log.getCardTime());
					logList.add(m);
				}
			}
		} catch (SysException e) {
			super.showMessageDetail("查询失败");
			e.printStackTrace();
		}	
	}		
	
	public void downloadLog(){
		try {
			List<AttMachineBO> mList = this.attBusiService.getAllAttMachineBO();
			if(mList!=null && mList.size()>0){
				String msg = this.attBusiService.downloadLog(super.getUserInfo().getOrgId(), mList);
				if(msg!=null && !"".equals(msg)){
					super.showMessageDetail(msg);
				}else{
					super.showMessageDetail("读取完成");
				}
			}else{
				super.showMessageDetail("请添加考勤机");
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
}
