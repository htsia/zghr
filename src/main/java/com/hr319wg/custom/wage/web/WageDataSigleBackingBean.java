package com.hr319wg.custom.wage.web;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.myfaces.custom.fileupload.UploadedFile;
import org.springframework.jdbc.core.JdbcTemplate;

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
import com.hr319wg.util.FileUtil;

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
	private String errorFileUrl;
	private List uploadFileList;
	private boolean showError; 
	private JdbcTemplate jdbcTemplate; 
	
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	public String getErrorFileUrl() {
		return errorFileUrl;
	}
	public void setErrorFileUrl(String errorFileUrl) {
		this.errorFileUrl = errorFileUrl;
	}
	public List getUploadFileList() {
		return uploadFileList;
	}
	public void setUploadFileList(List uploadFileList) {
		this.uploadFileList = uploadFileList;
	}
	public boolean isShowError() {
		return showError;
	}
	public void setShowError(boolean showError) {
		this.showError = showError;
	}
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
					if(modifyDate!=null && !"".equals(modifyDate) && !"null".equals(modifyDate) && modifyMoney!=null && !"".equals(modifyMoney) && !"null".equals(modifyMoney)){
						status = "未审核,于"+modifyDate+"被修改为"+modifyMoney;
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
	
	//批量上传文件
	public String uploadFile(){
		this.showError=false;
		try {
			Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
			Sheet st=wb.getSheet(0);
			int row=st.getRows();
			if(row<=1){
				super.showMessageDetail("上传文件工作薄没有内容");			
				return null;
			}
			int col=st.getColumns();
			if(col<3){
				super.showMessageDetail("上传文件工作薄没有足够的列");				
				return null;
			}
			this.uploadFileList=new ArrayList();
			Long d=new Date().getTime();
			String path=super.getRealPath("/")+"file\\wage\\upload\\"+d+".txt";
			BufferedWriter bw = new BufferedWriter(new FileWriter(path));
			for(int i=1;i<row;i++){
				boolean pass=true;
				Map uploadMap=new HashMap();
				String pCode = st.getCell(0, i).getContents().trim();
				String name=st.getCell(1, i).getContents().trim();
				String wage=st.getCell(2, i).getContents().trim();
				if(pCode==null || "".equals(pCode)){
					break;
				}				
				PersonBO p = SysCacheTool.findPersonByCode(pCode.trim());
				if(p==null){
					FileUtil.addErrorFormatLabel(bw, i+1, 0, "人员编号"+pCode+"不存在");
					pass=false;
					this.showError=true;
				}else if(pCode.startsWith("@")){
					FileUtil.addErrorFormatLabel(bw, i+1, 0, "人员编号"+pCode+"为兼职人员不能导入");
					pass=false;
					this.showError=true;
				}else{
					if(!p.getName().equals(name)){
						FileUtil.addErrorFormatLabel(bw, i+1, 1, "姓名不匹配,系统中为"+p.getName()+"此处为"+name);
						pass=false;
						this.showError=true;
					}else{
						String sql="select count(*) from (select id from wage_set_pers_r where id='"+p.getPersonId()+"' union select id from wage_set_pers_r_bak where id='"+p.getPersonId()+"')";
						if(this.jdbcTemplate.queryForInt(sql)==0){
							FileUtil.addErrorFormatLabel(bw, i+1, 1, p.getName()+"不在帐套中");
							pass=false;
							this.showError=true;
						}else{
							uploadMap.put("id", p.getPersonId());
							uploadMap.put("code", p.getPersonCode());
							uploadMap.put("name", p.getName());
							uploadMap.put("dept", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));							
						}
					}
				}
				try {
					Double.valueOf(wage);
					uploadMap.put("wage", wage);
				} catch (Exception e) {
					FileUtil.addErrorFormatLabel(bw, i+1, 2, "数字格式错误");
					pass=false;
					this.showError=true;
				}
				
				if(pass){
					this.uploadFileList.add(uploadMap);
				}
			}
			if(this.showError){
				this.errorFileUrl=super.getServletRequest().getContextPath()+"\\file\\wage\\upload\\"+d+".txt";
			}
			super.getHttpSession().setAttribute("infoList", this.uploadFileList);
			bw.close();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return "batchAddSigleWageList";
	}
	
	//批量保存文件
	public String saveFile(){
		try {
			this.wageDataService.batchModifyUserMoney(this.uploadFileList, CommonFuns.getSysDate("yyyy-MM"), this.itemType);
			super.getHttpSession().removeAttribute("infoList");
			super.showMessageDetail("上传完成");
		} catch (SysException e) {
			super.showMessageDetail("上传失败");
			e.printStackTrace();
		}
		return "upload";
	}
}
