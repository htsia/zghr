package com.hr319wg.custom.wage.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

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
import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class WageDataSigleBackingBean extends BaseBackingBean {
	private User user = super.getUserInfo();
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String editInit;
	private String orgID;
	private String itemType;
	private String isVerify;
	private boolean verifyFlag;
	private String userID;
	private String nameStr;
	private String money;
	private List<Map> userList;
	private IWageDataService wageDataService;
	private String personType;
	private String personTypeValue;
	private UploadedFile excelFile;
	private String operUserID;
	private String inself;
	
	public String getInself() {
		return inself;
	}
	public void setInself(String inself) {
		this.inself = inself;
	}
	public String getOperUserID() {
		return operUserID;
	}
	public void setOperUserID(String operUserID) {
		this.operUserID = operUserID;
	}
	public void chengeVerifyFlag(ValueChangeEvent event) {
		verifyFlag = event.getNewValue().toString().equals("true");		
	}
	public boolean isVerifyFlag() {
		return verifyFlag;
	}

	public void setVerifyFlag(boolean verifyFlag) {
		this.verifyFlag = verifyFlag;
	}

	public String getNameStr() {
		return nameStr;
	}

	public void setNameStr(String nameStr) {
		this.nameStr = nameStr;
	}

	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
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

	public String getIsVerify() {
		return isVerify;
	}

	public void setIsVerify(String isVerify) {
		this.isVerify = isVerify;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public IWageDataService getWageDataService() {
		return wageDataService;
	}

	public void setWageDataService(IWageDataService wageDataService) {
		this.wageDataService = wageDataService;
	}

	public List<Map> getuserList() {
		return userList;
	}

	public void setuserList(List<Map> userList) {
		this.userList = userList;
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
			this.isVerify=null;
			this.nameStr=null;
			this.verifyFlag=false;
		}
		
		String isVerify1 = super.getRequestParameter("isVerify");
		String itemType1 = super.getRequestParameter("itemType");
		String orgID1 = super.getRequestParameter("orgID");
		String inself1 = super.getRequestParameter("inself");
		if(isVerify1!=null){
			this.isVerify=isVerify1;
		}
		if(orgID1!=null){
			this.orgID=orgID1;
		}
		if(inself1!=null){
			this.inself=inself1;
		}
		if(itemType1!=null){
			this.itemType=itemType1;
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
	
	public String getEditInit(){
		this.userID=super.getRequestParameter("userID");
		this.money=super.getRequestParameter("money");
		this.itemType=super.getRequestParameter("itemType");
		return null;
	}
	
	public String modifyUserMoney(){
		try {
			this.wageDataService.modifyUserMoney(this.userID, this.money, CommonFuns.getSysDate("yyyy-MM"), this.itemType);
		} catch (SysException e) {
			e.printStackTrace();
		}
		queryUser();
		return "success";
	}
	
	public void queryUser(){
		userList = new ArrayList();
		try {		
			List list = this.wageDataService.getAllWageDateSigleBO(this.mypage, this.orgID, this.itemType, this.isVerify, CommonFuns.getSysDate("yyyy-MM"), this.personType, this.nameStr, this.verifyFlag, this.inself, super.getUserInfo().getUserId());
			if(list!=null && list.size()>0){
				for(int i =0;i<list.size();i++){
					Object[]obj = (Object[]) list.get(i);
					String userID = String.valueOf(obj[0]);
					String modifyMoney = String.valueOf(obj[2]);
					String modifyDate = String.valueOf(obj[3]);
					
					Map m = new HashMap();
					PersonBO p = SysCacheTool.findPersonById(userID);
					if(obj[1]!=null){
						m.put("money", obj[1]);						
					}
					m.put("userID", userID);
					m.put("userName", p.getName());
					m.put("userCode", p.getPersonCode());
					m.put("userType",CodeUtil.interpertCode(p.getPersonType()));
					m.put("deptName",CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
					m.put("orgName",CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getOrgId()));
					String status = null;
					if(modifyDate!=null && CommonFuns.getSysDate("yyyy-MM").equals(modifyDate)){
						status = "未审核,金额被修改为"+modifyMoney;
					}
					m.put("status", status);
					userList.add(m);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	//同步数据
	public void updateWageDataSigle(){
		try {
			this.wageDataService.updateWageDataSigle(user.getOrgId(), this.itemType, this.operUserID, super.getUserInfo().getUserId());
			this.operUserID=null;
			super.showMessageDetail("操作完成");
		} catch (SysException e) {
			super.showMessageDetail("操作失败");
			e.printStackTrace();
		}
	}
	//退回
	public void deleteWageDataSigle(){
		try {
			this.wageDataService.deleteWageDataSigle(this.itemType, this.operUserID, super.getUserInfo().getUserId());
			this.operUserID=null;
			super.showMessageDetail("操作完成");
		} catch (SysException e) {
			super.showMessageDetail("操作失败");
			e.printStackTrace();
		}
	}
	
	public void uploadFile(){
		try {
			String yearMonth = CommonFuns.getSysDate("yyyy-MM");
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
								this.wageDataService.modifyUserMoney(p.getPersonId(), money.trim(), yearMonth, this.itemType);
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
