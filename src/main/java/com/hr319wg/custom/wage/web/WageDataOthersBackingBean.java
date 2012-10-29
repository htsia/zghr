package com.hr319wg.custom.wage.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.commons.lang.StringUtils;
import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.custom.wage.pojo.bo.WageOthersDataSetBO;
import com.hr319wg.custom.wage.pojo.bo.WageOthersDataSetUserBO;
import com.hr319wg.custom.wage.service.WageDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class WageDataOthersBackingBean extends BaseBackingBean {
	private User user = super.getUserInfo();
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String editInit;
	private String operSetID;
	private String operUserID;
	private String orgID;
	private String nameStr;
	private String isView;
	private String selectedUserIds;
	private String personType;
	private String personTypeValue;
	private String beginDate;	
	private String endDate;
	private List<WageOthersDataSetBO> setList;
	private List<WageOthersDataSetUserBO> userList;
	private WageOthersDataSetBO item;
	private WageOthersDataSetUserBO userBo;
	private WageDataService wageDataService;
	private List itemList;
	private String targetdata;
	private boolean notReview=true;
	private boolean reviewed=false;
    private String averageMoney;
    private UploadedFile excelFile;
    private String itemID;
    private String yearmonth;
    private String selectedItemIDs;
    
    
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getSelectedItemIDs() {
		return selectedItemIDs;
	}

	public void setSelectedItemIDs(String selectedItemIDs) {
		this.selectedItemIDs = selectedItemIDs;
	}

	public String getYearmonth() {
		return yearmonth;
	}

	public void setYearmonth(String yearmonth) {
		this.yearmonth = yearmonth;
	}

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public String getAverageMoney() {
		return averageMoney;
	}

	public void setAverageMoney(String averageMoney) {
		this.averageMoney = averageMoney;
	}

	public boolean isNotReview() {
		return notReview;
	}

	public void setNotReview(boolean notReview) {
		this.notReview = notReview;
	}

	public boolean isReviewed() {
		return reviewed;
	}

	public void setReviewed(boolean reviewed) {
		reviewed = reviewed;
	}

	public String getTargetdata() {
		return targetdata;
	}

	public void setTargetdata(String targetdata) {
		this.targetdata = targetdata;
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

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public WageOthersDataSetUserBO getUserBo() {
		return userBo;
	}

	public void setUserBo(WageOthersDataSetUserBO userBo) {
		this.userBo = userBo;
	}

	public WageDataService getWageDataService() {
		return wageDataService;
	}

	public void setWageDataService(WageDataService wageDataService) {
		this.wageDataService = wageDataService;
	}

	public String getIsView() {
		return isView;
	}

	public void setIsView(String isView) {
		this.isView = isView;
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

	public List<WageOthersDataSetUserBO> getUserList() {
		return userList;
	}

	public void setUserList(List<WageOthersDataSetUserBO> userList) {
		this.userList = userList;
	}

	public String getOperSetID() {
		return operSetID;
	}

	public void setOperSetID(String operSetID) {
		this.operSetID = operSetID;
	}

	public void setSetList(List<WageOthersDataSetBO> setList) {
		this.setList = setList;
	}

	public WageOthersDataSetBO getItem() {
		return item;
	}

	public void setItem(WageOthersDataSetBO item) {
		this.item = item;
	}

	public List getSetList() {
		return setList;
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

	public String getPageInit() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.mypage = new PageVO();
			this.beginDate=null;
			this.endDate=null;
			this.notReview=true;
			this.reviewed=false;
			this.yearmonth=null;
			this.selectedItemIDs=null;
		}
		queryWageSet();
		return null;
	}
	
	public void queryWageSet(){
		try {
			if(mypage.getCurrentPage()==0){
				mypage.setCurrentPage(1);
			}
			setList=this.wageDataService.getAllWageOthersDataSetBOByUserID(this.mypage, super.getUserInfo().getUserId(), this.beginDate, this.endDate,this.notReview,this.reviewed);
			if(setList!=null){
				for(WageOthersDataSetBO bo : setList ){
					PersonBO p = SysCacheTool.findPersonById(bo.getCreateUserID());
					bo.setDesc("0".equals(bo.getStatus())?"编辑中":"归档结束");
					bo.setCreateUserName(p.getName());
				}
			}else{
				setList = new ArrayList();				
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String getEditInit() {
		this.itemList=getItemList();
		String itemType1 = super.getRequestParameter("itemType");
		
		String id = super.getRequestParameter("itemID");
		try {
			if(id!=null && !"".equals(id)){
				item = (WageOthersDataSetBO)this.wageDataService.getObjectByID(WageOthersDataSetBO.class, id);				
			}else{
				item = new WageOthersDataSetBO();	
			}
			
		} catch (SysException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
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
		String itemID1 =super.getRequestParameter("itemID");
		if(itemID1!=null && !"".equals(itemID1)){
			this.itemID = itemID1;			
		}
		String view = super.getRequestParameter("view");
		if("1".equals(view)){
			this.isView="1";
		}
		String id = super.getRequestParameter("itemID");
		if(id!=null && !"".equals(id)){
			try {
				item = (WageOthersDataSetBO)this.wageDataService.getObjectByID(WageOthersDataSetBO.class, id);				
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
			this.item= (WageOthersDataSetBO)this.wageDataService.getObjectByID(WageOthersDataSetBO.class, setID);
			this.userBo  = (WageOthersDataSetUserBO)this.wageDataService.getObjectByID(WageOthersDataSetUserBO.class, id);
		} catch (SysException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String saveSet(){
		try {
			if(item.getID()==null){
				item.setCreateUserID(user.getUserId());
				item.setStatus("0");
				item.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
			}
			this.wageDataService.saveOrUpdateObject(item);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void deleteSet(){
		try {
			this.wageDataService.deleteWageOthersDataSetBOByID(this.operSetID);
			super.showMessageDetail("删除完成");
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void submitSet(){
		try {
			item = (WageOthersDataSetBO)this.wageDataService.getObjectByID(WageOthersDataSetBO.class, this.operSetID);
			item.setStatus("1");
			this.wageDataService.saveOrUpdateObject(item);
			super.showMessageDetail("提交完成");
		} catch (SysException e1) {
			e1.printStackTrace();
		}
	}
	
	public void adduser(){
		String[]ids=this.selectedUserIds.split(",");
		List<String> ids2= new ArrayList();
		
		for(int i=0;i<ids.length;i++){
			int count;
			try {
				count = this.wageDataService.getWageDataOthersSetUserCount(item.getID(), ids[i]);
				if(count==0){
					ids2.add(ids[i]);
				}
			} catch (SysException e) {
				e.printStackTrace();
			}			
		}
		for(String id : ids2){
			WageOthersDataSetUserBO bo = new WageOthersDataSetUserBO();
			bo.setSetID(item.getID());
			bo.setUserID(id);
			try {
				this.wageDataService.saveOrUpdateObject(bo);
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		queryUser();
		super.showMessageDetail("添加完成");
	}
	
	public void deleteUser(){
		try {
			for(WageOthersDataSetUserBO bo : userList){
				if(bo.getID().equals(this.operUserID)){
					this.wageDataService.deleteWageOthersDataSetUserBOByID(this.operUserID);
					queryUser();
					super.showMessageDetail("删除完成");									
					break;
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String modifyUser(){
		try {
			this.wageDataService.saveOrUpdateObject(this.userBo);
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("保存失败");
			e.printStackTrace();
		}
		return null;
	}
	
	public void averageMoney(){
		try {
			this.wageDataService.averageMoney(item.getID(), this.averageMoney);
			queryUser();				
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void queryUser(){
		try {
			userList= this.wageDataService.getAllWageOthersDataSetUserBO(this.mypage,this.item.getID(), orgID,this.personType, this.nameStr, super.getUserInfo().getUserId());
		} catch (SysException e) {
			e.printStackTrace();
		}
		if(userList==null){
			userList = new ArrayList<WageOthersDataSetUserBO>();
		}
		for(WageOthersDataSetUserBO bo : userList){
			setUserInfo(bo);
		}
	}
	
	private void setUserInfo(WageOthersDataSetUserBO bo){
		PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
		if(p!=null){
			bo.setUserCode(CodeUtil.interpertCode(p.getPersonCode()));
			bo.setUserName(p.getName());
			bo.setUserType(CodeUtil.interpertCode(p.getPersonType()));
			bo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getOrgId()));
	        bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
		}
		
	}
	
	public List getItemList(){
		List list= this.wageDataService.getItemList("A234");
		List slist=new ArrayList();
		if(list!=null){
			for(int i=0;i<list.size();i++){
				Map<String,Object> map=(Map<String,Object>)list.get(i);
				SelectItem si=new SelectItem();
				si.setLabel(map.get("ITEM_NAME").toString());
				si.setValue(map.get("ITEM_ID"));
				slist.add(si);
			}			
		}
		return slist;
	}
	//数据归档
	public void confirm(){
		try {
			this.wageDataService.confirm(this.selectedItemIDs.split(","), this.yearmonth, super.getUserInfo().getUserId());
			super.showMessageDetail(this.yearmonth+"数据归档完成");
		} catch (SysException e) {
			super.showMessageDetail(this.yearmonth+"数据归档失败");
			e.printStackTrace();
		}
	}
	public void haveReview(ValueChangeEvent event) {
		notReview = event.getNewValue().toString().equals("true");
	}
	public void haveReviewed(ValueChangeEvent event) {
        reviewed = event.getNewValue().toString().equals("true");
	}
	
	public void uploadFile(){
		try {
			Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
			Sheet st=wb.getSheet(0);
			int stRow=st.getRows();
			int success=0;
			int fail=0;
			String err ="其中人员编号为：";
			
			for(int i=1;i<stRow;i++){
				String pCode = st.getCell(0, i).getContents();
				if(pCode==null || "".equals(pCode)){
					break;
				}else{
					PersonBO p = SysCacheTool.findPersonByCode(pCode.trim());
					if(p!=null){
						String money = st.getCell(2, i).getContents();
						if(StringUtils.isNumeric(money.trim())){
							try {
								this.wageDataService.modifyUserMoney1(this.itemID, p.getPersonId(), money.trim());
								success++;
							} catch (SysException e) {
								e.printStackTrace();
							}		
						}
					}else{
						fail++;
						err+=pCode+",";
					}
				}
			}
			if(fail==0){
				this.orgID=null;
				queryUser();
				super.showMessageDetail("成功"+success+"个");				
			}else{
				err=err.substring(0, err.length()-1);
				super.showMessageDetail("成功"+success+"个失败"+fail+"个,"+err+"的人员不存在");								
			}
		} catch (BiffException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
	}
}
