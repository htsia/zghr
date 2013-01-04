package com.hr319wg.custom.attence.web;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.attence.com.hr319wg.attence.util.DateUtil;
import com.hr319wg.attence.pojo.bo.AttDurationBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.pojo.bo.AttLeaveBO;
import com.hr319wg.custom.attence.pojo.bo.AttMonthBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class AttCalcMgrBackingBean extends BaseBackingBean {
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String editInit;
	private String modifyInit;
	private String verifyInit;
	private String orgID;
	private String operSubID;
	private String isView;
	private String nameStr;
	private String personType;
	private String personTypeValue;
	private AttDurationBO attDurationBO;
	private UserAPI userapi;
	private List<AttMonthBO> list;
	private List<AttMonthBO> editList;
	private List<AttMonthBO> verifyList;
	private List<AttDurationBO> currList;
	private AttMonthBO bo;
	private String lateModify;
    private String awayModify;
    private String leaveReasonsModify;
    private String sickModify;
    private String maternityModify;
    private String weddingModify;
    private String homeModify;
    private String industrialInjuryModify;
    private String arrangingFuneralModify;
    private String outModify;
    private String overtimeModify;
    private IAttBusiService attBusiService;
    private QueryAPI queryapi;
	private JdbcTemplate jdbcTemplate;
	private String dimissionDate;
	private String dimissionInit;
	private String subID;
	private String isDimission;
	private String inself;
    private String beginYearMonth="";
    private String endYearMonth="";
    private String pageInit1;
    
    private String later; //迟到
    private String away;  //旷工
    private String normalLeave; //事假
    private String illLeave;   //病假
    private String chanjiaLeave;   //产假
    private String nanchanjiaLeave;   //难产产假
    private String laterDeduction; //迟到扣款
    private String awayDeduction;  //旷工扣款
    private String normalLeaveDeduction; //事假扣款
    private String illLeaveDeduction;   //病假扣款
    private String chanjiaLeaveDeduction;   //产假扣款
    private String nanchanjiaLeaveDeduction;   //难产产假扣款
    private String nanchanjiaLeaveModify;//难产产假修改
    private String laterDeductionModify; //迟到扣款修改
    private String awayDeductionModify;  //旷工扣款修改
    private String normalLeaveDeductionModify; //事假扣款修改
    private String illLeaveDeductionModify;   //病假扣款修改
    private String chanjiaLeaveDeductionModify;   //产假扣款修改
    private String nanchanjiaLeaveDeductionModify;   //难产产假扣款修改
    private String masterModifyInit;
    private String attDetailInit;
    private String personId;
    private String yearMonth;
    private List leavesList;
    private String attDetail;
    private String personName;
    
    
	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getAttDetail() {
		return attDetail;
	}

	public void setAttDetail(String attDetail) {
		this.attDetail = attDetail;
	}

	public List getLeavesList() {
		return leavesList;
	}

	public void setLeavesList(List leavesList) {
		this.leavesList = leavesList;
	}

	public String getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}


	public String getAttDetailInit() {
		//获取某个人某段时期的考勤详情
		this.yearMonth=super.getRequestParameter("yearMonth");
		this.personId=super.getRequestParameter("personId");
		PersonBO person=SysCacheTool.findPersonById(this.personId);
		this.personName=person.getName();
		try {
			Map map=this.attBusiService.getAttDetailForSomebody(this.personId,this.yearMonth);
			this.attDetail=(String)map.get("result");
			if(attDetail.length()<=0){
				attDetail="没有迟到和旷工记录";
			}
			List list=(List)map.get("list");
			leavesList=null;
			if(list.size()>0){
				leavesList=new ArrayList();
				for (int i=0;i<list.size();i++){
					AttLeaveBO leave=(AttLeaveBO)list.get(i);
					Map temp=new HashMap();
					temp.put("beginTime", leave.getBeginTime());
					temp.put("endTime", leave.getEndTime());
					temp.put("personName", person.getName());
					if("1".equals(leave.getLeaveType())){
						temp.put("leaveType", "正常事假");
						leavesList.add(temp);
					}else if("2".equals(leave.getLeaveType())){
						temp.put("leaveType", "病假");
						leavesList.add(temp);
					}else if("5".equals(leave.getLeaveType())){
						temp.put("leaveType", "产假");
						leavesList.add(temp);
					}else if("6".equals(leave.getLeaveType())){
						temp.put("leaveType", "难产产假");
						leavesList.add(temp);
					}
				}
			}
		} catch (SysException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return attDetailInit;
	}

	public void setAttDetailInit(String attDetailInit) {
		this.attDetailInit = attDetailInit;
	}

	public String getLaterDeductionModify() {
		return laterDeductionModify;
	}

	public void setLaterDeductionModify(String laterDeductionModify) {
		this.laterDeductionModify = laterDeductionModify;
	}

	public String getAwayDeductionModify() {
		return awayDeductionModify;
	}

	public void setAwayDeductionModify(String awayDeductionModify) {
		this.awayDeductionModify = awayDeductionModify;
	}

	public String getNormalLeaveDeductionModify() {
		return normalLeaveDeductionModify;
	}

	public void setNormalLeaveDeductionModify(String normalLeaveDeductionModify) {
		this.normalLeaveDeductionModify = normalLeaveDeductionModify;
	}

	public String getIllLeaveDeductionModify() {
		return illLeaveDeductionModify;
	}

	public void setIllLeaveDeductionModify(String illLeaveDeductionModify) {
		this.illLeaveDeductionModify = illLeaveDeductionModify;
	}

	public String getChanjiaLeaveDeductionModify() {
		return chanjiaLeaveDeductionModify;
	}

	public void setChanjiaLeaveDeductionModify(String chanjiaLeaveDeductionModify) {
		this.chanjiaLeaveDeductionModify = chanjiaLeaveDeductionModify;
	}

	public String getNanchanjiaLeaveDeductionModify() {
		return nanchanjiaLeaveDeductionModify;
	}

	public void setNanchanjiaLeaveDeductionModify(
			String nanchanjiaLeaveDeductionModify) {
		this.nanchanjiaLeaveDeductionModify = nanchanjiaLeaveDeductionModify;
	}

	public void setAttDurationBO(AttDurationBO attDurationBO) {
		this.attDurationBO = attDurationBO;
	}

	public void setMasterModifyInit(String masterModifyInit) {
		this.masterModifyInit = masterModifyInit;
	}

	public String getLater() {
		return later;
	}

	public void setLater(String later) {
		this.later = later;
	}

	public String getAway() {
		return away;
	}

	public void setAway(String away) {
		this.away = away;
	}

	public String getNormalLeave() {
		return normalLeave;
	}

	public void setNormalLeave(String normalLeave) {
		this.normalLeave = normalLeave;
	}

	public String getIllLeave() {
		return illLeave;
	}

	public void setIllLeave(String illLeave) {
		this.illLeave = illLeave;
	}

	public String getChanjiaLeave() {
		return chanjiaLeave;
	}

	public void setChanjiaLeave(String chanjiaLeave) {
		this.chanjiaLeave = chanjiaLeave;
	}

	public String getNanchanjiaLeave() {
		return nanchanjiaLeave;
	}

	public void setNanchanjiaLeave(String nanchanjiaLeave) {
		this.nanchanjiaLeave = nanchanjiaLeave;
	}

	public String getLaterDeduction() {
		return laterDeduction;
	}

	public void setLaterDeduction(String laterDeduction) {
		this.laterDeduction = laterDeduction;
	}

	public String getAwayDeduction() {
		return awayDeduction;
	}

	public void setAwayDeduction(String awayDeduction) {
		this.awayDeduction = awayDeduction;
	}

	public String getNormalLeaveDeduction() {
		return normalLeaveDeduction;
	}

	public void setNormalLeaveDeduction(String normalLeaveDeduction) {
		this.normalLeaveDeduction = normalLeaveDeduction;
	}

	public String getIllLeaveDeduction() {
		return illLeaveDeduction;
	}

	public void setIllLeaveDeduction(String illLeaveDeduction) {
		this.illLeaveDeduction = illLeaveDeduction;
	}

	public String getChanjiaLeaveDeduction() {
		return chanjiaLeaveDeduction;
	}

	public void setChanjiaLeaveDeduction(String chanjiaLeaveDeduction) {
		this.chanjiaLeaveDeduction = chanjiaLeaveDeduction;
	}

	public String getNanchanjiaLeaveDeduction() {
		return nanchanjiaLeaveDeduction;
	}

	public void setNanchanjiaLeaveDeduction(String nanchanjiaLeaveDeduction) {
		this.nanchanjiaLeaveDeduction = nanchanjiaLeaveDeduction;
	}

	public String getPageInit1() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.nameStr=null;
			this.personType=null;
			this.orgID=null;
			this.isView=null;
			this.inself=null;
		}
		
		String inself1 = super.getRequestParameter("inself");
		if("1".equals(inself1)){
			this.inself="1";
		}
		String isView1 = super.getRequestParameter("isView");
		if("1".equals(isView1)){
			this.isView="1";
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		String dID = super.getRequestParameter("dID");
		if(dID!=null){
			try {
				this.attDurationBO=(AttDurationBO)this.attBusiService.findBOById(AttDurationBO.class, dID);
				currList = this.attBusiService.getCurrAttDurationBO();
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		//doQuery();
		doQuery1();
		return pageInit1;
	}

	public void setPageInit1(String pageInit1) {
		this.pageInit1 = pageInit1;
	}

	public String getBeginYearMonth() {
		return beginYearMonth;
	}

	public void setBeginYearMonth(String beginYearMonth) {
		this.beginYearMonth = beginYearMonth;
	}

	public String getEndYearMonth() {
		return endYearMonth;
	}

	public void setEndYearMonth(String endYearMonth) {
		this.endYearMonth = endYearMonth;
	}

	public String getInself() {
		return inself;
	}

	public void setInself(String inself) {
		this.inself = inself;
	}

	public String getIsDimission() {
		return isDimission;
	}

	public void setIsDimission(String isDimission) {
		this.isDimission = isDimission;
	}

	public String getSubID() {
		return subID;
	}

	public void setSubID(String subID) {
		this.subID = subID;
	}

	public String getDimissionDate() {
		return dimissionDate;
	}

	public void setDimissionDate(String dimissionDate) {
		this.dimissionDate = dimissionDate;
	}

	public String getDimissionInit() {
		if(super.getRequestParameter("subID")!=null){
			this.subID=super.getRequestParameter("subID");
		}
		return dimissionInit;
	}

	public void setDimissionInit(String dimissionInit) {
		this.dimissionInit = dimissionInit;
	}

	public QueryAPI getQueryapi() {
		return queryapi;
	}

	public void setQueryapi(QueryAPI queryapi) {
		this.queryapi = queryapi;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}
    
	public String getIsView() {
		return isView;
	}

	public void setIsView(String isView) {
		this.isView = isView;
	}

	public String getVerifyInit() {
		try {
			String act = super.getRequestParameter("act");
			if("init".equals(act)){
				this.orgID=null;
				this.nameStr=null;
				this.personType=null;
				currList=null;
			}
			String orgID1 = super.getRequestParameter("orgID");
			if(orgID1!=null && !"".equals(orgID1)){
				this.orgID=orgID1;
			}
			currList = this.attBusiService.getCurrAttDurationBO();
			if(currList!=null && currList.size()>0){
				doVerifyQuery();
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void setVerifyInit(String verifyInit) {
		this.verifyInit = verifyInit;
	}

	public List<AttMonthBO> getVerifyList() {
		return verifyList;
	}

	public void setVerifyList(List<AttMonthBO> verifyList) {
		this.verifyList = verifyList;
	}
	public List<AttDurationBO> getCurrList() {
		return currList;
	}

	public void setCurrList(List<AttDurationBO> currList) {
		this.currList = currList;
	}

	public void setEditInit(String editInit) {
		this.editInit = editInit;
	}

	public String getLateModify() {
		return lateModify;
	}

	public void setLateModify(String lateModify) {
		this.lateModify = lateModify;
	}

	public String getAwayModify() {
		return awayModify;
	}

	public void setAwayModify(String awayModify) {
		this.awayModify = awayModify;
	}

	public String getLeaveReasonsModify() {
		return leaveReasonsModify;
	}

	public void setLeaveReasonsModify(String leaveReasonsModify) {
		this.leaveReasonsModify = leaveReasonsModify;
	}

	public String getSickModify() {
		return sickModify;
	}

	public void setSickModify(String sickModify) {
		this.sickModify = sickModify;
	}

	public String getMaternityModify() {
		return maternityModify;
	}

	public void setMaternityModify(String maternityModify) {
		this.maternityModify = maternityModify;
	}

	public String getWeddingModify() {
		return weddingModify;
	}

	public void setWeddingModify(String weddingModify) {
		this.weddingModify = weddingModify;
	}

	public String getHomeModify() {
		return homeModify;
	}

	public void setHomeModify(String homeModify) {
		this.homeModify = homeModify;
	}

	public String getIndustrialInjuryModify() {
		return industrialInjuryModify;
	}

	public void setIndustrialInjuryModify(String industrialInjuryModify) {
		this.industrialInjuryModify = industrialInjuryModify;
	}

	public String getArrangingFuneralModify() {
		return arrangingFuneralModify;
	}

	public void setArrangingFuneralModify(String arrangingFuneralModify) {
		this.arrangingFuneralModify = arrangingFuneralModify;
	}

	public String getOutModify() {
		return outModify;
	}

	public void setOutModify(String outModify) {
		this.outModify = outModify;
	}

	public String getOvertimeModify() {
		return overtimeModify;
	}

	public void setOvertimeModify(String overtimeModify) {
		this.overtimeModify = overtimeModify;
	}

	public String getOperSubID() {
		return operSubID;
	}

	public void setOperSubID(String operSubID) {
		this.operSubID = operSubID;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getEditInit() {
		try {
			String act = super.getRequestParameter("act");
			if("init".equals(act)){
				this.orgID=null;
				this.nameStr=null;
				this.personType=null;
				currList=null;
				this.inself=null;
			}
			String orgID1 = super.getRequestParameter("orgID");
			if(orgID1!=null && !"".equals(orgID1)){
				this.orgID=orgID1;
			}
			String inself1 = super.getRequestParameter("inself");
			if(inself1!=null && !"".equals(inself1)){
				this.inself=inself1;
			}
			currList = this.attBusiService.getCurrAttDurationBO();
			if(currList!=null && currList.size()>0){
				doEditQuery();
			}else{
				super.showMessageDetail("考勤结果未发布");
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getModifyInit() {
		try {
			String subID = super.getRequestParameter("subID");
			this.bo =(AttMonthBO)this.attBusiService.findBOById(AttMonthBO.class, subID);
			setValue(this.bo);
			
			this.lateModify=bo.getLateTime();
			this.awayModify=bo.getAwayTime();
			this.leaveReasonsModify=bo.getLeaveReasons();
		    this.sickModify=bo.getLeaveSick();
		    this.maternityModify=bo.getLeaveMaternity();
		    this.nanchanjiaLeaveModify=bo.getNanchanjiaLeave();
		    
		    this.laterDeductionModify=bo.getLaterDeduction();
		    this.awayDeductionModify=bo.getAwayDeduction();
		    this.normalLeaveDeductionModify=bo.getNormalLeaveDeduction();
		    this.illLeaveDeductionModify=bo.getIllLeaveDeduction();
		    this.chanjiaLeaveDeductionModify=bo.getChanjiaLeaveDeduction();
		    this.nanchanjiaLeaveDeductionModify=bo.getNanchanjiaLeaveDeduction();
		    		
		    if(bo.getLateModify()!=null && !"".equals(bo.getLateModify())){
		    	this.lateModify=bo.getLateModify();
		    }
		    if(bo.getAwayModify()!=null && !"".equals(bo.getAwayModify())){
		    	this.awayModify=bo.getAwayModify();
		    }
		    if(bo.getLeaveReasonsModify()!=null && !"".equals(bo.getLeaveReasonsModify())){
		    	this.leaveReasonsModify=bo.getLeaveReasonsModify();
		    }
		    if(bo.getSickModify()!=null && !"".equals(bo.getSickModify())){
		    	this.sickModify=bo.getSickModify();
		    }
		    if(bo.getMaternityModify()!=null && !"".equals(bo.getMaternityModify())){
		    	this.maternityModify=bo.getMaternityModify();
		    }
		    if(bo.getNanchanjiaLeaveModify()!=null && !"".equals(bo.getNanchanjiaLeaveModify())){
		    	this.nanchanjiaLeaveModify=bo.getNanchanjiaLeaveModify();
		    }
		    
		    
		    if(bo.getLaterDeductionModify()!=null && !"".equals(bo.getLaterDeductionModify())){
		    	this.laterDeductionModify=bo.getLaterDeductionModify();
		    }
		    if(bo.getAwayDeductionModify()!=null && !"".equals(bo.getAwayDeductionModify())){
		    	this.awayDeductionModify=bo.getAwayDeductionModify();
		    }
		    if(bo.getNormalLeaveDeductionModify()!=null && !"".equals(bo.getNormalLeaveDeductionModify())){
		    	this.normalLeaveDeductionModify=bo.getNormalLeaveDeductionModify();
		    }
		    if(bo.getIllLeaveDeductionModify()!=null && !"".equals(bo.getIllLeaveDeductionModify())){
		    	this.illLeaveDeductionModify=bo.getIllLeaveDeductionModify();
		    }
		    if(bo.getChanjiaLeaveDeductionModify()!=null && !"".equals(bo.getChanjiaLeaveDeductionModify())){
		    	this.chanjiaLeaveDeductionModify=bo.getChanjiaLeaveDeductionModify();
		    }
		    if(bo.getNanchanjiaLeaveDeductionModify()!=null && !"".equals(bo.getNanchanjiaLeaveDeductionModify())){
		    	this.nanchanjiaLeaveDeductionModify=bo.getNanchanjiaLeaveDeductionModify();
		    }
		} catch (SysException e) {
			e.printStackTrace();
		}
		return modifyInit;
	}

	public void setModifyInit(String modifyInit) {
		this.modifyInit = modifyInit;
	}

	public List<AttMonthBO> getEditList() {
		return editList;
	}

	public void setEditList(List<AttMonthBO> editList) {
		this.editList = editList;
	}

	public AttMonthBO getBo() {
		return bo;
	}

	public void setBo(AttMonthBO bo) {
		this.bo = bo;
	}

	public List<AttMonthBO> getList() {
		return list;
	}

	public void setList(List<AttMonthBO> list) {
		this.list = list;
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
	
	public AttDurationBO getAttDurationBO() {
		return attDurationBO;
	}
//	public void setAttDurationBO(AttDurationBO attDurationBO) {
//		this.attDurationBO = attDurationBO;
//	}
	public PageVO getMypage() {
		return mypage;
	}
	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	public String getPageInit() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.nameStr=null;
			this.personType=null;
			this.orgID=null;
			this.isView=null;
		}
		
		String isView1 = super.getRequestParameter("isView");
		if("1".equals(isView1)){
			this.isView="1";
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		String dID = super.getRequestParameter("dID");
		if(dID!=null && !"".equals(dID)){
			try {
				this.attDurationBO=(AttDurationBO)this.attBusiService.findBOById(AttDurationBO.class, dID);
				currList = this.attBusiService.getCurrAttDurationBO();
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		doQuery();
		//doQuery1();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public void doQuery(){
		if(mypage.getCurrentPage()==0){
			mypage.setCurrentPage(1);
		}
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		try {
			String qryID = this.attDurationBO.getQryID();
			
			Hashtable hash = this.queryapi.getQuerySqlHash(null, qryID);
	        List userList = this.jdbcTemplate.queryForList((String)hash.get("SQL_FULL"));
	        if(userList==null || userList.size()==0){
	        	super.showMessageDetail("查询方案关联人员为空");
	        }
	        String[]userIDs=new String[userList.size()];
	        for(int i=0;i<userList.size();i++){
	        	String userID = ((Map)userList.get(i)).get("ID").toString();
	        	userIDs[i]=userID;
	        }
			String yearMonth = this.attDurationBO.getDuraYear()+"-"+this.attDurationBO.getDuraMonth();
			list = this.attBusiService.getAllAttMonthBO(mypage, this.orgID, nameStr, personType, yearMonth, userIDs);
			if(list==null){
				list = new ArrayList();
			}
			for(AttMonthBO bo : list){
				setValue(bo);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	public synchronized void calc(){
		if(this.attDurationBO.getQryID()==null){
			super.showMessageDetail("请设置关联查询方案");
		}
		try {
			String dId=this.attDurationBO.getQryID();
			String msg = this.attBusiService.updateCalcAttData(super.getUserInfo().getOrgId(), this.attDurationBO.getDuraBegin(), this.attDurationBO.getDuraEnd(), this.attDurationBO.getDuraYear(), this.attDurationBO.getDuraMonth(),dId);
			if(msg!=null && msg.length()!=0){
				super.showMessageDetail(msg);
			}else{
//				doQuery();
				super.showMessageDetail("计算完成");
			}
			
		}  catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("计算出错:"+e.getMessage());		
		}
	}
	
	//查询和显示一段时间内的月汇总
	public void doQuery1(){
		if(mypage.getCurrentPage()==0){
			mypage.setCurrentPage(1);
		}
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		try {
			
			list = this.attBusiService.getAndShowAllAttMonthBO(mypage, this.orgID, nameStr, personType, this.beginYearMonth, this.endYearMonth, this.inself, super.getUserInfo().getUserId());
			if(list==null){
				list = new ArrayList();
			}
			for(AttMonthBO bo : list){
				setValue(bo);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	private void setValue(AttMonthBO bo){
		PersonBO p = SysCacheTool.findPersonById(bo.getPersonId());
		bo.setPersonCode(p.getPersonCode());
		bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
		bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
		bo.setPersonName(p.getName());
	}
	
	public void doEditQuery(){
		if(mypage.getCurrentPage()==0){
			mypage.setCurrentPage(1);
		}
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		try {
			String yearMonth = this.currList.get(0).getDuraYear()+"-"+this.currList.get(0).getDuraMonth();
			List list1 = this.attBusiService.getAllAttMonthBOByOrgIDs(mypage, this.orgID, nameStr, personType, yearMonth, this.inself, super.getUserInfo().getUserId());
			if(list1==null){
				list1 = new ArrayList();
			}
			editList = new ArrayList();
			for(int i=0;i<list1.size();i++){
				Object[]obj = (Object[])list1.get(i);
				AttMonthBO bo = (AttMonthBO)obj[0];
				PersonBO p = SysCacheTool.findPersonById(bo.getPersonId());
				bo.setPersonCode(p.getPersonCode());
				bo.setSecDeptName(CodeUtil.interpertCode(obj[1].toString()));
				bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
				bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
				bo.setPersonName(p.getName());
				if(bo.getLateModify()!=null && !"".equals(bo.getLateModify())){
					bo.setLateTime(bo.getLateModify());
				}
				if(bo.getAwayModify()!=null && !"".equals(bo.getAwayModify())){
					bo.setAwayTime(bo.getAwayModify());
				}
				if(bo.getLeaveReasonsModify()!=null && !"".equals(bo.getLeaveReasonsModify())){
					bo.setLeaveReasons(bo.getLeaveReasonsModify());
				}
				if(bo.getSickModify()!=null && !"".equals(bo.getSickModify())){
					bo.setLeaveSick(bo.getSickModify());
				}
				if(bo.getMaternityModify()!=null && !"".equals(bo.getMaternityModify())){
					bo.setLeaveMaternity(bo.getMaternityModify());
				}
				if(bo.getWeddingModify()!=null && !"".equals(bo.getWeddingModify())){
					bo.setLeaveWedding(bo.getWeddingModify());
				}
				if(bo.getHomeModify()!=null && !"".equals(bo.getHomeModify())){
					bo.setLeaveHome(bo.getHomeModify());
				}
				if(bo.getIndustrialInjuryModify()!=null && !"".equals(bo.getIndustrialInjuryModify())){
					bo.setLeaveIndustrialInjury(bo.getIndustrialInjuryModify());
				}
				if(bo.getArrangingFuneralModify()!=null && !"".equals(bo.getArrangingFuneralModify())){
					bo.setLeaveArrangingFuneral(bo.getArrangingFuneralModify());
				}
				if(bo.getOutModify()!=null && !"".equals(bo.getOutModify())){
					bo.setOutWorkValue(bo.getOutModify());
				}
				if(bo.getOvertimeModify()!=null && !"".equals(bo.getOvertimeModify())){
					bo.setWorkAddValue(bo.getOvertimeModify());
				}
				editList.add(bo);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	public void doVerifyQuery(){
		if(mypage.getCurrentPage()==0){
			mypage.setCurrentPage(1);
		}
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		try {
			String yearMonth = this.currList.get(0).getDuraYear()+"-"+this.currList.get(0).getDuraMonth();
			verifyList = this.attBusiService.getAllVerifyAttMonthBO(mypage, this.orgID, nameStr, personType, yearMonth);
			if(verifyList==null){
				verifyList = new ArrayList();
			}
			for(AttMonthBO bo : verifyList){
				setValue(bo);
				if(bo.getLateModify()!=null && !"".equals(bo.getLateModify())){
			    	bo.setLateTime(bo.getLateModify());
			    }
			    if(bo.getAwayModify()!=null && !"".equals(bo.getAwayModify())){
			    	bo.setAwayTime(bo.getAwayModify());
			    }
			    if(bo.getLeaveReasonsModify()!=null && !"".equals(bo.getLeaveReasonsModify())){
			    	bo.setLeaveReasons(bo.getLeaveReasonsModify());
			    }
			    if(bo.getSickModify()!=null && !"".equals(bo.getSickModify())){
			    	bo.setLeaveSick(bo.getSickModify());
			    }
			    if(bo.getMaternityModify()!=null && !"".equals(bo.getMaternityModify())){
			    	bo.setLeaveMaternity(bo.getMaternityModify());
			    }
			    if(bo.getNanchanjiaLeaveModify()!=null && !"".equals(bo.getNanchanjiaLeaveModify())){
			    	bo.setNanchanjiaLeave(bo.getNanchanjiaLeaveModify());
			    }
			    
			    
			    if(bo.getLaterDeductionModify()!=null && !"".equals(bo.getLaterDeductionModify())){
			    	bo.setLaterDeduction(bo.getLaterDeductionModify());
			    }
			    if(bo.getAwayDeductionModify()!=null && !"".equals(bo.getAwayDeductionModify())){
			    	bo.setAwayDeduction(bo.getAwayDeductionModify());
			    }
			    if(bo.getNormalLeaveDeductionModify()!=null && !"".equals(bo.getNormalLeaveDeductionModify())){
			    	bo.setNormalLeaveDeduction(bo.getNormalLeaveDeductionModify());
			    }
			    if(bo.getIllLeaveDeductionModify()!=null && !"".equals(bo.getIllLeaveDeductionModify())){
			    	bo.setIllLeaveDeduction(bo.getIllLeaveDeductionModify());
			    }
			    if(bo.getChanjiaLeaveDeductionModify()!=null && !"".equals(bo.getChanjiaLeaveDeductionModify())){
			    	bo.setChanjiaLeaveDeduction(bo.getChanjiaLeaveDeductionModify());
			    }
			    if(bo.getNanchanjiaLeaveDeductionModify()!=null && !"".equals(bo.getNanchanjiaLeaveDeductionModify())){
			    	bo.setNanchanjiaLeaveDeduction(bo.getNanchanjiaLeaveDeductionModify());
			    }
			    
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	public void submit(){
		if(this.editList!=null){
			for(AttMonthBO bo : editList){
				if(!"1".equals(bo.getStatus()) && ((bo.getLateModify()!=null && !"".equals(bo.getLateModify())) || (bo.getAwayModify()!=null && !"".equals(bo.getAwayModify())) || (bo.getLeaveReasonsModify()!=null && !"".equals(bo.getLeaveReasonsModify())) || (bo.getIndustrialInjuryModify()!=null && !"".equals(bo.getIndustrialInjuryModify()))
						|| (bo.getSickModify()!=null && !"".equals(bo.getSickModify())) || (bo.getMaternityModify()!=null && !"".equals(bo.getMaternityModify())) || (bo.getWeddingModify()!=null && !"".equals(bo.getWeddingModify())) || (bo.getArrangingFuneralModify()!=null && !"".equals(bo.getArrangingFuneralModify()))
						|| (bo.getOutModify()!=null && !"".equals(bo.getOutModify())) || (bo.getOvertimeModify()!=null && !"".equals(bo.getOvertimeModify())) || (bo.getHomeModify()!=null && !"".equals(bo.getHomeModify())))){
			    	bo.setStatus("0");
			    	try {
						this.attBusiService.saveOrUpdateBO(bo);
					} catch (SysException e) {
						e.printStackTrace();
					}
			    }
			}
		}
	}

	public String save(){
		try {
			this.bo.setLateModify(this.lateModify);
			this.bo.setAwayModify(this.awayModify);
			this.bo.setLeaveReasonsModify(this.leaveReasonsModify);
		    this.bo.setSickModify(this.sickModify);
		    this.bo.setMaternityModify(this.maternityModify);
		    this.bo.setNanchanjiaLeaveModify(this.nanchanjiaLeaveModify);
		    
		    this.bo.setLaterDeductionModify(this.laterDeductionModify);
		    this.bo.setAwayDeductionModify(this.awayDeductionModify);
		    this.bo.setNormalLeaveDeductionModify(this.normalLeaveDeductionModify);
		    this.bo.setIllLeaveDeductionModify(this.illLeaveDeductionModify);
		    this.bo.setChanjiaLeaveDeductionModify(this.chanjiaLeaveDeductionModify);
		    this.bo.setNanchanjiaLeaveDeductionModify(this.nanchanjiaLeaveDeductionModify);
		    
		    this.bo.setStatus("0");
		    this.attBusiService.saveOrUpdateBO(this.bo);
			
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("修改失败");
			e.printStackTrace();
		}
		return null;
	}
	public String verifySave(){
		try {
			this.bo.setLateTime(this.lateModify);
			this.bo.setAwayTime(this.awayModify);
			this.bo.setLeaveReasons(this.leaveReasonsModify);
			this.bo.setLeaveSick(this.sickModify);
			this.bo.setLeaveMaternity(this.maternityModify);
			this.bo.setNanchanjiaLeave(this.nanchanjiaLeaveModify);
			
			this.bo.setLaterDeduction(this.laterDeductionModify);
			this.bo.setAwayDeduction(this.awayDeductionModify);
			this.bo.setNormalLeaveDeduction(this.normalLeaveDeductionModify);
			this.bo.setIllLeaveDeduction(this.illLeaveDeductionModify);
			this.bo.setChanjiaLeaveDeduction(this.chanjiaLeaveDeductionModify);
			this.bo.setNanchanjiaLeaveDeduction(this.nanchanjiaLeaveDeductionModify);
			
			this.attBusiService.saveOrUpdateBO(this.bo);
			
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("修改失败");
			e.printStackTrace();
		}
		return null;
	}
	
	public void pass(){
		if(this.operSubID!=null){
			try {
				AttMonthBO bo1 =(AttMonthBO)this.attBusiService.findBOById(AttMonthBO.class, this.operSubID);
				setMonthBO(bo1);
				this.attBusiService.saveOrUpdateBO(bo1);
				this.operSubID=null;
			} catch (SysException e) {
				super.showMessageDetail("通过失败");
				e.printStackTrace();
			}
		}else{
			if(verifyList!=null){
				for(int i=0;i<verifyList.size();i++){
					AttMonthBO bo1 = verifyList.get(i);
					try {
						setMonthBO(bo1);
						this.attBusiService.saveOrUpdateBO(bo1);
					} catch (SysException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	private void setMonthBO(AttMonthBO bo1){
		bo1.setLateTime(bo1.getLateModify());
		bo1.setAwayTime(bo1.getAwayModify());
		bo1.setLeaveReasons(bo1.getLeaveReasonsModify());
		bo1.setLeaveSick(bo1.getSickModify());
		bo1.setLeaveMaternity(bo1.getMaternityModify());
		bo1.setNanchanjiaLeave(bo1.getNanchanjiaLeaveModify());
		
		bo1.setLaterDeduction(bo1.getLaterDeductionModify());
		bo1.setAwayDeduction(bo1.getAwayDeductionModify());
		bo1.setNormalLeaveDeduction(bo1.getNormalLeaveDeductionModify());
		bo1.setIllLeaveDeduction(bo1.getIllLeaveDeductionModify());
		bo1.setChanjiaLeaveDeduction(bo1.getChanjiaLeaveDeductionModify());
		bo1.setNanchanjiaLeaveDeduction(bo1.getNanchanjiaLeaveDeductionModify());
		
		bo1.setStatus("1");
	}
	
	public void rollback(){
		if(this.operSubID!=null){
			try {
				AttMonthBO bo1 =(AttMonthBO)this.attBusiService.findBOById(AttMonthBO.class, this.operSubID);
				bo1.setStatus("2");
				this.attBusiService.saveOrUpdateBO(bo1);
				this.operSubID=null;
			} catch (SysException e) {
				super.showMessageDetail("否决失败");
				e.printStackTrace();
			}
		}else{
			if(verifyList!=null){
				for(int i=0;i<verifyList.size();i++){
					AttMonthBO bo1 = verifyList.get(i);
					try {
						bo1.setStatus("2");
						this.attBusiService.saveOrUpdateBO(bo1);
					} catch (SysException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	public String updateDimissionDate(){
		if(super.getRequestParameter("fretype")!=null){
			this.isDimission=super.getRequestParameter("fretype");
		}
		try {
			this.attBusiService.updateDimissionDate(this.subID,this.isDimission,this.dimissionDate);
			
		} catch (SysException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "success";
	}
	public String masterSave(){
		try {
			this.bo.setLateTime(this.later);
			this.bo.setAwayTime(this.away);
			this.bo.setLeaveReasons(this.normalLeave);
			this.bo.setLeaveSick(illLeave);
			this.bo.setLeaveMaternity(this.chanjiaLeave);
			this.bo.setNanchanjiaLeave(this.nanchanjiaLeave);
			this.bo.setLaterDeduction(laterDeduction);
			this.bo.setAwayDeduction(awayDeduction);
			this.bo.setNormalLeaveDeduction(normalLeaveDeduction);
			this.bo.setIllLeaveDeduction(illLeaveDeduction);
			this.bo.setChanjiaLeaveDeduction(chanjiaLeaveDeduction);
			this.bo.setNanchanjiaLeaveDeduction(nanchanjiaLeaveDeduction);
			
		    this.attBusiService.saveOrUpdateBO(this.bo);
			
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("修改失败");
			e.printStackTrace();
		}
		return null;
	}
	public String getMasterModifyInit() {
		try {
			String subID = super.getRequestParameter("subID");
			this.bo =(AttMonthBO)this.attBusiService.findBOById(AttMonthBO.class, subID);
			setValue(this.bo);
			
			this.later=bo.getLateTime();
			this.away=bo.getAwayTime();
			this.normalLeave=bo.getLeaveReasons();
		    this.illLeave=bo.getLeaveSick();
		    this.chanjiaLeave=bo.getLeaveMaternity();
		    this.nanchanjiaLeave=bo.getLeaveWedding();
		    
		    this.laterDeduction=bo.getLaterDeduction();
		    this.awayDeduction=bo.getAwayDeduction();
		    this.normalLeaveDeduction=bo.getNormalLeaveDeduction();
		    this.illLeaveDeduction=bo.getIllLeaveDeduction();
		    this.chanjiaLeaveDeduction=bo.getChanjiaLeaveDeduction();
		    this.nanchanjiaLeaveDeduction=bo.getNanchanjiaLeaveDeduction();
		} catch (SysException e) {
			e.printStackTrace();
		}
		return masterModifyInit;
	}

	public String getNanchanjiaLeaveModify() {
		return nanchanjiaLeaveModify;
	}

	public void setNanchanjiaLeaveModify(String nanchanjiaLeaveModify) {
		this.nanchanjiaLeaveModify = nanchanjiaLeaveModify;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}
}
