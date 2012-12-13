package com.hr319wg.custom.wage.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.custom.wage.pojo.bo.WageDataSetBO;
import com.hr319wg.custom.wage.pojo.bo.WageDataSetUserBO;
import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class WageDataOtherBackingBean extends BaseBackingBean {
	private User user = super.getUserInfo();
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String editInit;
	private String userInit;
	private String dataInit;
	
	private String operSetID;
	private String operUserID;
	private String operYearMonth;
	private String orgID;
	private String nameStr;
	private String isView;
	private String itemType;
	private String itemName;
	private String batchMoney;
	private String selectedUserIds;
	private String selectedItemIDs;
	private String personType;
	private String personTypeValue;
	private String beginDate;
	private String endDate;
	private boolean editting=true;
	private boolean issueing=true;
	private boolean includeEnd;
	private String inself;
	
	private List<WageDataSetBO> setList;
	private List<WageDataSetUserBO> userList;
	private List<Map> dataList;
	private WageDataSetBO item;
	private WageDataSetUserBO userBo;
	private IWageDataService wageDataService;
	private UploadedFile excelFile;
	private String totalMoney = "0";
	
	public String getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(String totalMoney) {
		this.totalMoney = totalMoney;
	}

	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public String getInself() {
		return inself;
	}

	public void setInself(String inself) {
		this.inself = inself;
	}

	public String getSelectedItemIDs() {
		return selectedItemIDs;
	}

	public void setSelectedItemIDs(String selectedItemIDs) {
		this.selectedItemIDs = selectedItemIDs;
	}

	public String getOperYearMonth() {
		return operYearMonth;
	}

	public void setOperYearMonth(String operYearMonth) {
		this.operYearMonth = operYearMonth;
	}

	public String getBatchMoney() {
		return batchMoney;
	}

	public void setBatchMoney(String batchMoney) {
		this.batchMoney = batchMoney;
	}

	public boolean isEditting() {
		return editting;
	}

	public void setEditting(boolean editting) {
		this.editting = editting;
	}

	public boolean isIssueing() {
		return issueing;
	}

	public void setIssueing(boolean issueing) {
		this.issueing = issueing;
	}

	public boolean isIncludeEnd() {
		return includeEnd;
	}

	public void setIncludeEnd(boolean includeEnd) {
		this.includeEnd = includeEnd;
	}

	public String getNameStr() {
		return nameStr;
	}

	public void setNameStr(String nameStr) {
		this.nameStr = nameStr;
	}

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

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public WageDataSetUserBO getUserBo() {
		return userBo;
	}

	public void setUserBo(WageDataSetUserBO userBo) {
		this.userBo = userBo;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public IWageDataService getWageDataService() {
		return wageDataService;
	}

	public void setWageDataService(IWageDataService wageDataService) {
		this.wageDataService = wageDataService;
	}

	public String getIsView() {
		return isView;
	}

	public void setIsView(String isView) {
		this.isView = isView;
	}

	public List<Map> getDataList() {
		return dataList;
	}

	public void setDataList(List<Map> dataList) {
		this.dataList = dataList;
	}

	public String getOperUserID() {
		return operUserID;
	}

	public void setOperUserID(String operUserID) {
		this.operUserID = operUserID;
	}

	public String getSelectedUserIds() {
		return selectedUserIds;
	}

	public void setSelectedUserIds(String selectedUserIds) {
		this.selectedUserIds = selectedUserIds;
	}

	public List<WageDataSetUserBO> getUserList() {
		return userList;
	}

	public void setUserList(List<WageDataSetUserBO> userList) {
		this.userList = userList;
	}

	public String getOperSetID() {
		return operSetID;
	}

	public void setOperSetID(String operSetID) {
		this.operSetID = operSetID;
	}

	public void setSetList(List<WageDataSetBO> setList) {
		this.setList = setList;
	}

	public WageDataSetBO getItem() {
		return item;
	}

	public void setItem(WageDataSetBO item) {
		this.item = item;
	}

	public List getSetList() {
		return setList;
	}

	public String first() {
		mypage.setCurrentPage(1);
		return null;
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return null;
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return null;
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return null;
	}

	public String getPageInit() {		
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.mypage = new PageVO();
			this.beginDate=null;
			this.endDate=null;
			this.selectedItemIDs=null;
			this.operYearMonth=null;
		}
		
		String inself = super.getRequestParameter("inself");
		if("1".equals(inself)){
			this.inself="1";
		}
		if("0".equals(inself)){
			this.inself="0";
		}
		String itemType1 = super.getRequestParameter("itemType");
		if(itemType1!=null){
			this.itemType=itemType1;
			if("1".equals(itemType1)){
				this.itemName="其他1";
			}else if("2".equals(itemType1)){
				this.itemName="捐款";
			}else if("3".equals(itemType1)){
				this.itemName="其他2";
			}else if("4".equals(itemType1)){
				this.itemName="扣其他1";
			}else if("5".equals(itemType1)){
				this.itemName="扣其他2";
			}
		}
		
		queryWageSet();
		return null;
	}
	
	
	/**
	 * 按权限查询项目
	 */
	public void queryWageSet(){
		if(mypage.getCurrentPage()==0){
			mypage.setCurrentPage(1);
		}
		
		List sList = new ArrayList();
		if (editting) {
			sList.add("0");
		}
		if (issueing) {
			sList.add("1");
		}
		if (includeEnd) {
			sList.add("2");
		}
		String[] status=new String[sList.size()];
		if(sList!=null&&sList.size()>0){
			for(int i=0;i<sList.size();i++){
				status[i]=(String)sList.get(i);
			}
		}
		try {
			setList=this.wageDataService.getAllWageDataSetBOByUserID(this.mypage, super.getUserInfo().getUserId(), this.itemType, this.beginDate, this.endDate, status, super.getUserInfo().getUserId());
		} catch (SysException e) {
			e.printStackTrace();
		}
		if(setList!=null){
			double m=0;
			for(WageDataSetBO bo : setList ){
				m+=bo.getTotalmoney();
				PersonBO p = SysCacheTool.findPersonById(bo.getCreateUserID());
				bo.setCreateUserName(p.getName());
				if(!"1".equals(bo.getItemType()) && !"2".equals(bo.getItemType()) && !"4".equals(bo.getItemType())){
					bo.setApplyDate(bo.getBeginDate());												
				}else{
					bo.setApplyDate(bo.getBeginDate()+" 至 "+bo.getEndDate());						
				}
				if("1".equals(inself)){//自助
					if("0".equals(bo.getStatus())){
						bo.setStatusDesc("编辑中");
					}else if("1".equals(bo.getStatus())){
						bo.setStatusDesc("审核中");
					}else if("2".equals(bo.getStatus())){
						bo.setStatusDesc("审核通过");						
					}
				}else{
					if("0".equals(bo.getStatus())){
						bo.setStatusDesc("编辑中");
					}else if("1".equals(bo.getStatus()) && !"1".equals(this.itemType) && !"2".equals(this.itemType)){
						bo.setStatusDesc("归档中");
					}else if("1".equals(bo.getStatus()) ){
						bo.setStatusDesc("分发中");
					}else if("2".equals(bo.getStatus()) && !"1".equals(this.itemType) && !"2".equals(this.itemType)){
						bo.setStatusDesc("归档结束");
					}else if("2".equals(bo.getStatus())){
						bo.setStatusDesc("分发结束");						
					}
				}
			}
			BigDecimal bg = new BigDecimal(m);
			double f1 = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			this.totalMoney=f1+"";
		}else{
			setList = new ArrayList();				
		}
	}
	
	public String getEditInit() {
		String itemType1 = super.getRequestParameter("itemType");
		if(itemType1!=null){
			this.itemType=itemType1;
			this.itemType=itemType1;
			if("1".equals(itemType1)){
				this.itemName="其他1";
			}else if("2".equals(itemType1)){
				this.itemName="捐款";
			}else if("3".equals(itemType1)){
				this.itemName="其他2";
			}else if("4".equals(itemType1)){
				this.itemName="扣其他1";
			}else if("5".equals(itemType1)){
				this.itemName="扣其他2";
			}
		}
		String inself = super.getRequestParameter("inself");
		if("1".equals(inself)){
			this.inself="1";
		}
		String id = super.getRequestParameter("itemID");
		try {
			if(id!=null && !"".equals(id)){
				item = (WageDataSetBO)this.wageDataService.getObjectByID(WageDataSetBO.class, id);				
			}else{
				item = new WageDataSetBO();	
			}
			
		} catch (SysException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 人员设置页面初始化
	 * @return
	 */
	public String getUserInit(){
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.mypage = new PageVO();
			this.personType=null;
			this.isView=null;
			this.nameStr=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null){
			this.orgID = orgID1;			
		}
		String itemType1 = super.getRequestParameter("itemType");
		if(itemType1!=null){
			this.itemType=itemType1;
		}
		String view = super.getRequestParameter("view");
		if("1".equals(view)){
			this.isView="1";
		}
		String inself = super.getRequestParameter("inself");
		if("1".equals(inself)){
			this.inself="1";
		}
		if("0".equals(inself)){
			this.inself="0";
		}
		String id = super.getRequestParameter("itemID");
		if(id!=null && !"".equals(id)){
			try {
				item = (WageDataSetBO)this.wageDataService.getObjectByID(WageDataSetBO.class, id);				
			} catch (SysException e) {
				e.printStackTrace();
			}
		}else{
			try {
				item = (WageDataSetBO)this.wageDataService.getObjectByID(WageDataSetBO.class, item.getID());
			} catch (SysException e) {
				e.printStackTrace();
			}							
		}
		if(item!=null){
			queryUser();			
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
		queryUser();
		return null;
	}
	
	public String getEditUser(){
		String id = super.getRequestParameter("id");
		String setID = super.getRequestParameter("setID");
		
		try {
			if(id!=null && !"".equals(id)){
				this.item= (WageDataSetBO)this.wageDataService.getObjectByID(WageDataSetBO.class, setID);
				this.userBo  = (WageDataSetUserBO)this.wageDataService.getObjectByID(WageDataSetUserBO.class, id);				
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//保存项目
	public String saveSet(){
		try {
			if(item.getID()==null){
				item.setCreateUserID(user.getUserId());
				item.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
				item.setItemType(this.itemType);
				item.setStatus("1");
			}
			if("3".equals(this.itemType) || "5".equals(this.itemType)){
				item.setEndDate(item.getBeginDate());
			}
//			if("1".equals(inself) && ("2".equals(item.getItemType()) || "3".equals(item.getItemType()))){
//				item.setSelfstatus("1");//自助平台
//			}
			this.wageDataService.saveOrUpdateObject(item);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//删除项目
	public void deleteSet(){
		try {
			this.wageDataService.deleteWageDataSetBOByID(this.operSetID);
			super.showMessageDetail("删除完成");
		} catch (SysException e) {
			super.showMessageDetail("删除失败");			
			e.printStackTrace();
		}
	}
	
	//提交项目审核
	public void submitSet(){
//		try {
//			item = (WageDataSetBO)this.wageDataService.getObjectByID(WageDataSetBO.class, this.operSetID);
//			item.setStatus("1");
//			item.setSelfstatus(null);
//			this.wageDataService.saveOrUpdateObject(item);
//			super.showMessageDetail("提交完成");
//		} catch (SysException e1) {
//			e1.printStackTrace();
//		}
	}
	
	//添加人员
	public void adduser(){
		String[]ids=this.selectedUserIds.split(",");
		List<String> ids2= new ArrayList();
		
		for(int i=0;i<ids.length;i++){
			int count;
			try {
				count = this.wageDataService.getWageDataSetUserCount(item.getID(), ids[i]);
				if(count==0){
					ids2.add(ids[i]);
				}
			} catch (SysException e) {
				e.printStackTrace();
			}			
		}
		for(String id : ids2){
			WageDataSetUserBO bo = new WageDataSetUserBO();
			bo.setSetID(item.getID());
			bo.setUserID(id);
			try {
				this.wageDataService.saveOrUpdateObject(bo);
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		setTotalMoney();
//		queryUser();
		super.showMessageDetail("添加完成");
	}
	
	//删除人员设置人员
	public void deleteUser(){
		try {
			for(WageDataSetUserBO bo : userList){
				if(bo.getID().equals(this.operUserID)){
					this.wageDataService.deleteWageDataSetUserBOByID(this.operUserID);
					setTotalMoney();
					super.showMessageDetail("删除完成");									
					break;
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//修改人员信息
	public String modifyUser(){
		try {
			this.wageDataService.saveOrUpdateObject(this.userBo);
			setTotalMoney();
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("保存失败");
			e.printStackTrace();
		}
		return null;
	}
	
	private void setTotalMoney(){
		try {
			this.wageDataService.setTotalMoney(this.item.getID());
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//查询人员
	public void queryUser(){
		userList = new ArrayList<WageDataSetUserBO>();
		try {
			List list = this.wageDataService.getAllWageDataSetUserBO(this.mypage,this.item, orgID,this.personType, this.nameStr, this.inself, super.getUserInfo().getUserId());
			if(list!=null){
				for(int i=0;i<list.size();i++){
					Object[]obj = (Object[]) list.get(i);
					WageDataSetUserBO bo = (WageDataSetUserBO) obj[0];
					setUserInfo(bo, String.valueOf(obj[1]));
					userList.add(bo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//查询审核人员明细
	public void queryDataUser(){
//		try {
//			List list = this.wageDataService.getAllWageDataSetUserBOByInfo(this.mypage, this.operYearMonth, this.selectedItemIDs, this.orgID, this.itemType, this.personType, this.nameStr, super.getUserInfo().getUserId());
//			if(list!=null && list.size()>0){
//				for(int i =0;i<list.size();i++){
//					Object[]obj = (Object[]) list.get(i);
//					WageDataSetUserBO bo = (WageDataSetUserBO) obj[0];
//					String setName = String.valueOf(obj[1]);
//					
//					Map m = new HashMap();
//					PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
//					String status = this.wageDataService.getWageUserVerifyStatus(bo.getID(), this.operYearMonth);
//					if("1".equals(status)){
//						m.put("statusDesc", "通过");
//						m.put("status", "1");						
//					}else if("0".equals(status)){
//						m.put("statusDesc", "退回");
//						m.put("status", "1");						
//					}else{
//						m.put("status", "0");						
//					}
//					m.put("userID", bo.getUserID());
//					m.put("userName", p.getName());
//					m.put("userType", CodeUtil.interpertCode(p.getPersonType()));
//					m.put("userCode", p.getPersonCode());
//					m.put("deptName",CodeUtil.interpertCode(p.getDeptId()));
//					m.put("deptName",CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
//					m.put("orgName",CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getOrgId()));
//					m.put("money", bo.getMoney());
//					m.put("setID", bo.getSetID());
//					m.put("setName", setName);
//					m.put("remark", bo.getRemark());
//					dataList.add(m);
//				}
//			}
//		} catch (SysException e) {
//			e.printStackTrace();
//		}
	}
	
	private void setUserInfo(WageDataSetUserBO bo, String secDeptID){
		PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
		bo.setUserCode(p.getPersonCode());
		bo.setUserName(p.getName());
		bo.setUserType(CodeUtil.interpertCode(p.getPersonType()));
		bo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getOrgId()));
        bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
        bo.setSecDeptName(CodeUtil.interpertCode(secDeptID));
	}
	
	//审核人员数据初始化
	public String getDataInit(){
//		String act = super.getRequestParameter("act");
//		if("init".equals(act)){
//			this.mypage = new PageVO();
//			this.personType=null;
//			this.nameStr=null;
//		}
//		dataList = new ArrayList();
//		String itemType1 = super.getRequestParameter("itemType");
//		if(itemType1!=null){
//			this.itemType=itemType1;
//		}
//		String orgID1 = super.getRequestParameter("orgID");
//		if(orgID1!=null){
//			this.orgID = orgID1;			
//		}
//		String operYearMonth1 = super.getRequestParameter("operYearMonth");
//		if(operYearMonth1!=null){
//			this.operYearMonth = operYearMonth1;			
//		}
//		String selectedItemIDs1 = super.getRequestParameter("selectedItemIDs");
//		if(selectedItemIDs1!=null){
//			this.selectedItemIDs = selectedItemIDs1;			
//		}
//		try {
//			if(this.personType==null || "".equals(this.personType)){
//				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
//			}
//			if (mypage.getCurrentPage() == 0) {
//				mypage.setCurrentPage(1);
//			}
//			queryDataUser();
//		} catch (SysException e) {
//			e.printStackTrace();
//		}
		return null;
	}

	//更新其他1并更新项目状态
	public void updateWageOther1(){
		try {
			this.wageDataService.updateWageDataOther1(this.itemType, this.operYearMonth, this.selectedItemIDs, super.getUserInfo().getUserId());
			super.showMessageDetail(this.operYearMonth+"数据归档完成");
		} catch (SysException e) {
			super.showMessageDetail("归档失败");
			e.printStackTrace();
		}
	}
	
	//通过捐款其他2数据
	public String updateWageDataPass(){
//		try {
//			this.wageDataService.updateWageData(this.operYearMonth, this.operUserID, user.getOrgId(), this.itemType, this.operSetID, "1");
//			this.operUserID=null;
//			if(this.operUserID!=null){
//				return "success";				
//			}
//		} catch (SysException e) {
//			e.printStackTrace();
//		}
		return null;
	}
	//驳回捐款其他2数据
	public String updateWageDataRollback(){
//		try {
//			this.wageDataService.updateWageData(this.operYearMonth, this.operUserID, user.getOrgId(), this.itemType, this.operSetID, "0");
//			this.operUserID=null;
//			if(this.operUserID!=null){
//				return "success";				
//			}
//		} catch (SysException e) {
//			e.printStackTrace();
//		}
		return null;
	}
	
	//批量修改金额
	public void batchUpdateMoney(){
		if(this.userList!=null){
			for(WageDataSetUserBO bo : userList){
				bo.setMoney(this.batchMoney);
				try {
					this.wageDataService.saveOrUpdateObject(bo);
				} catch (SysException e) {
					super.showMessageDetail("修改失败");
					e.printStackTrace();
				}
			}
			setTotalMoney();
		}
	}
	
	public void setEditting(ValueChangeEvent event) {
		this.editting = event.getNewValue().toString().equals("true");
	}
	
	public void setIssueing(ValueChangeEvent event) {
		this.issueing = event.getNewValue().toString().equals("true");
	}
	
	public void setIncludeEnd(ValueChangeEvent event) {
		this.includeEnd = event.getNewValue().toString().equals("true");
	}
	
	public void uploadFile(){
		try {
			Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
			Sheet st=wb.getSheet(0);
			int stRow=st.getRows();
			int success=0;
			int fail=0;
			String errperson="";
			
			for(int i=1;i<stRow;i++){
				String pCode = st.getCell(0, i).getContents();
				if(pCode==null || "".equals(pCode)){
					break;
				}else{
					PersonBO p = SysCacheTool.findPersonByCode(pCode.trim());
					if(p!=null){
						int count = this.wageDataService.getWageDataSetUserCount(item.getID(), p.getPersonId());
						if(count>0){
							continue;
						}
						String money = st.getCell(2, i).getContents();
						double money1=0;
						String remark = st.getCell(3, i).getContents();
						if(money!=null || !"".equals(money)){
							money1=Double.valueOf(money);
						}
						WageDataSetUserBO bo = new WageDataSetUserBO();
						bo.setSetID(item.getID());
						bo.setUserID(p.getPersonId());
						bo.setMoney(money1+"");
						bo.setRemark(remark);
						try {
							this.wageDataService.saveOrUpdateObject(bo);
							success++;
						} catch (SysException e) {
							fail++;
							e.printStackTrace();
						}
					}else{
						fail++;
						errperson+=pCode+",";
					}
				}
			}
			if(fail==0){
				this.orgID=null;
				setTotalMoney();
				super.showMessageDetail("成功"+success+"个");				
			}else{
				setTotalMoney();
				String err="成功"+success+"个失败"+fail+"个";
				if(errperson.length()!=0){
					err+=",其中人员编号"+errperson+"的人员不存在";
				}
				super.showMessageDetail(err);								
			}
		} catch (BiffException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (SysException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
