package com.hr319wg.custom.wage.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.wage.pojo.bo.WageDataSetUserBO;
import com.hr319wg.custom.wage.pojo.bo.WageLitleBaseBO;
import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class WageDataLitleBackingBean extends BaseBackingBean {
	private User user = super.getUserInfo();
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String editInit;

	private String operUserID;
	private String operYearMonth;
	private String orgID;
	private String nameStr;
	private String itemType;
	private String itemName;
	private String operMoney;
	private String selectedUserIds;
	private String personType;
	private String personTypeValue;
	private List userList;
	private UploadedFile excelFile;
	
	
	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public String getOperMoney() {
		return operMoney;
	}

	public void setOperMoney(String operMoney) {
		this.operMoney = operMoney;
	}

	private IWageDataService wageDataService;

	public IWageDataService getWageDataService() {
		return wageDataService;
	}

	public void setWageDataService(IWageDataService wageDataService) {
		this.wageDataService = wageDataService;
	}

	public List<WageDataSetUserBO> getUserList() {
		return userList;
	}

	public void setUserList(List<WageDataSetUserBO> userList) {
		this.userList = userList;
	}

	public String getOperYearMonth() {
		return operYearMonth;
	}

	public void setOperYearMonth(String operYearMonth) {
		this.operYearMonth = operYearMonth;
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

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
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
			this.operYearMonth=null;
			this.operMoney=null;
			this.nameStr=null;
		}
		String itemType1 = super.getRequestParameter("itemType");
		if(itemType1!=null){
			this.itemType=itemType1;
			if("1".equals(itemType1)){
				this.itemName="加班费";
			}else if("2".equals(itemType1)){
				this.itemName="档案管理费";
			}
		}
		doQuery();
		return null;
	}
	
	public void doQuery(){
		if(this.mypage.getCurrentPage()==0){
			this.mypage.setCurrentPage(1);
		}
		try {
			List<WageLitleBaseBO> list = this.wageDataService.getAllWageLitleUserBO(mypage, itemType, orgID, personType, nameStr, super.getUserInfo().getUserId());
			if(list==null){
				list = new ArrayList();
			}
			this.userList = new ArrayList();
			for(WageLitleBaseBO bo : list){
				Map m = new HashMap();
				PersonBO p = SysCacheTool.findPersonById(bo.getID());
				m.put("ID", bo.getID());
				m.put("name", p.getName());
				m.put("money", bo.getMoney());
				m.put("statusDesc", bo.getStatusDesc());
				m.put("personCode", p.getPersonCode());
				m.put("personType", CodeUtil.interpertCode(p.getPersonType()));
		        m.put("deptName", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
		        this.userList.add(m);
			}		
			
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	//修改人员初始化
	public String getEditInit() {
		this.operUserID = super.getRequestParameter("userID");
		this.itemType = super.getRequestParameter("itemType");
		return editInit;
	}
	
	//添加设置人员
	public void adduser(){
		try {
			this.wageDataService.addWageLitleUser(this.itemType, this.selectedUserIds, super.getUserInfo().getUserId());
			super.showMessageDetail("添加完成");
		} catch (SysException e) {
			super.showMessageDetail("添加失败");
			e.printStackTrace();
		}
	}
	
	//删除人员
	public void deleteUser(){
		try {
			this.wageDataService.deleteWageLitleUser(this.itemType, this.operUserID, "0", super.getUserInfo().getUserId());
			this.operUserID=null;
			super.showMessageDetail("删除完成");
		} catch (SysException e) {
			this.operUserID=null;
			super.showMessageDetail("删除失败");
			e.printStackTrace();
		}
	}	
	//清空人员
	public void deleteAllUser(){
		try {
			this.wageDataService.deleteWageLitleUser(this.itemType, this.operUserID, "1", super.getUserInfo().getUserId());
			this.operUserID=null;
			super.showMessageDetail("清空完成");
		} catch (SysException e) {
			this.operUserID=null;
			super.showMessageDetail("清空失败");
			e.printStackTrace();
		}
	}
	
	//修改金额
	public String updateMoney(){
		try {
			this.wageDataService.updateWageLitleUser(this.itemType, this.operMoney, this.operUserID, super.getUserInfo().getUserId());
			super.showMessageDetail("修改完成");
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("修改失败");
			e.printStackTrace();
		}
		return null;
	}
	
	//批量修改金额
	public void batchUpdateMoney(){
		try {
			this.wageDataService.updateWageLitleUser(this.itemType, this.operMoney, null, super.getUserInfo().getUserId());
			super.showMessageDetail("修改完成");
		} catch (SysException e) {
			super.showMessageDetail("修改失败");
			e.printStackTrace();
		}
	}
	
	//归档
	public void updateLitleDate(){
		try {
			this.wageDataService.updateWageLitle(this.itemType, this.operYearMonth, super.getUserInfo().getUserId());
			super.showMessageDetail("归档完成");
		} catch (SysException e) {
			super.showMessageDetail("归档失败");
			e.printStackTrace();
		}
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
						String money = st.getCell(2, i).getContents();
						double money1=0;
						if(money!=null || !"".equals(money)){
							money1=Double.valueOf(money);
						}
						this.wageDataService.batchAddWageLitleUser(this.itemType, p.getPersonId(), money1+"", super.getUserInfo().getUserId());
						success++;
					}else{
						fail++;
						errperson+=pCode+",";
					}
				}
			}
			if(fail==0){
				this.orgID=null;
				super.showMessageDetail("成功"+success+"个");				
			}else{
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
			e.printStackTrace();
		}
	}
}
