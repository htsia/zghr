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

import org.apache.myfaces.custom.fileupload.UploadedFile;
import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.wage.pojo.bo.WageSetBO;

public class WageEmpBackingBean extends BaseBackingBean {
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String editInit;
	private String editWageInit;

	private String orgID;
	private String nameStr;
	private String personType="0135700572,0135700573,0135700574";
	private String operYearMonth;
	private String selectedUserIds;
	private String wage;
	private boolean hasWage=true;
	private boolean noWage=true;
	private boolean hasCash=true;
	private boolean hasNoCash=true;
	private String inself;
	private String rightType; //0后勤 1非后勤
	private UploadedFile excelFile;
	private String filename;
	private List<Map> list;
	private IWageDataService wageDataService;
	private UserBO user = new UserBO();

	public boolean isHasCash() {
		return hasCash;
	}

	public void setHasCash(boolean hasCash) {
		this.hasCash = hasCash;
	}

	public boolean isHasNoCash() {
		return hasNoCash;
	}

	public void setHasNoCash(boolean hasNoCash) {
		this.hasNoCash = hasNoCash;
	}

	public String getRightType() {
		return rightType;
	}

	public void setRightType(String rightType) {
		this.rightType = rightType;
	}

	public String getOperYearMonth() {
		return operYearMonth;
	}

	public void setOperYearMonth(String operYearMonth) {
		this.operYearMonth = operYearMonth;
	}
	
	public String getWage() {
		return wage;
	}

	public void setWage(String wage) {
		this.wage = wage;
	}

	public UserBO getUser() {
		return user;
	}

	public void setUser(UserBO user) {
		this.user = user;
	}

	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public boolean isHasWage() {
		return hasWage;
	}

	public void setHasWage(boolean hasWage) {
		this.hasWage = hasWage;
	}

	public boolean isNoWage() {
		return noWage;
	}

	public void setNoWage(boolean noWage) {
		this.noWage = noWage;
	}

	public List<Map> getList() {
		return list;
	}

	public void setList(List<Map> list) {
		this.list = list;
	}

	public String getEditInit() {
		String userID = super.getRequestParameter("userID");
		if(userID!=null && !"".equals(userID)){
			try {
				this.user = (UserBO) this.wageDataService.findBOById(UserBO.class, userID);
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		if(this.user==null){
			this.user=new UserBO();
		}
		return editInit;
	}

	public String getEditWageInit() {
		return editWageInit;
	}

	public String getInself() {
		return inself;
	}

	public void setInself(String inself) {
		this.inself = inself;
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

	public IWageDataService getWageDataService() {
		return wageDataService;
	}

	public void setWageDataService(IWageDataService wageDataService) {
		this.wageDataService = wageDataService;
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

	public void setHasWage(ValueChangeEvent event) {
		this.hasWage = event.getNewValue().toString().equals("true");
	}
	
	public void setNoWage(ValueChangeEvent event) {
		this.noWage = event.getNewValue().toString().equals("true");
	}
	
	public void setHasCash(ValueChangeEvent event) {
		this.hasCash = event.getNewValue().toString().equals("true");
	}
	
	public void setHasNoCash(ValueChangeEvent event) {
		this.hasNoCash = event.getNewValue().toString().equals("true");
	}
	
	//页面初始化
	public String getPageInit() {		
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.mypage = new PageVO();
		}
		
		String inself1 = super.getRequestParameter("inself");
		if(!"".equals(inself1)){
			this.inself=inself1;
		}
		try {
//			10220	大校兼职教师帐套
//			10221	大校项目工帐套
//			10219	后勤学生工项目工帐套

			//所有管辖的帐套
			List<WageSetBO> list = this.wageDataService.getAllWagesetBOByUserID(super.getUserInfo().getUserId());
			if(list!=null){
				for(WageSetBO bo : list){
					if("10220".equals(bo.getSetId()) || "10221".equals(bo.getSetId())){
						this.rightType="1";
						break;
					}
					if("10219".equals(bo.getSetId())){
						this.rightType="0";
						break;
					}					
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		doQuery();
		return null;
	}
	
	public void doQuery(){
		if(this.mypage.getCurrentPage()==0){
			this.mypage.setCurrentPage(1);
		}
		try {
			this.list = new ArrayList();
			List<UserBO> list1 = this.wageDataService.getAllWageEmpUserBO(mypage, hasWage, noWage, hasCash, hasNoCash, orgID, personType, nameStr, rightType, inself, super.getUserInfo().getUserId());
			if(list1!=null){
				for(UserBO bo : list1){
					Map m = new HashMap();
					m.put("ID", bo.getUserID());
					m.put("name", bo.getName());
					m.put("cardNO", bo.getCardNO());
					m.put("bankNO", bo.getBankNO());
					m.put("personCode", bo.getPersonSeq());
					m.put("personType", CodeUtil.interpertCode(bo.getPersonType()));					
					m.put("orgName", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, bo.getOrgId()));
					m.put("deptName", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, bo.getDeptId()));
					m.put("secDeptName", CodeUtil.interpertCode(bo.getSecDeptID()));
					if(bo.getXueli()!=null){
						m.put("xueliDesc", CodeUtil.interpertCode(bo.getXueli()));					
					}
					if(bo.getXuewei()!=null){
						m.put("xueweiDesc", CodeUtil.interpertCode(bo.getXuewei()));					
					}
					if(bo.getZhicheng()!=null){
						m.put("zhichengDesc", CodeUtil.interpertCode(bo.getZhicheng()));					
					}
					if(bo.getZhichengLevel()!=null){
						m.put("zhichengLevelDesc", CodeUtil.interpertCode(bo.getZhichengLevel()));					
					}
					if(bo.getZhichengXulie()!=null){
						m.put("zhichengXulieDesc", CodeUtil.interpertCode(bo.getZhichengXulie()));					
					}
					if("1".equals(bo.getHasCashStr())){
						m.put("hasCash", "是");
					}
					JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
					String sql = "select A239200,A239201,A239202 from A239 where id='"+bo.getUserID()+"'";
					List wagelist = jdbc.queryForList(sql);
					if(wagelist!=null){
						Map m1 = (Map)wagelist.get(0);
						m.put("wage", m1.get("A239200"));
						Object A239201 = m1.get("A239201");
						if(A239201!=null){
							m.put("yearMonth", A239201);
						}
						String A239202 = String.valueOf(m1.get("A239202"));
						if("1".equals(A239202)){
							m.put("status", "审核通过");
						}else if("0".equals(A239202)){
							m.put("status", "审核中");						
						}
					}
					this.list.add(m);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void setWage(){
		try {
			this.wageDataService.setEmpWage(this.wage, this.selectedUserIds, this.inself, super.getUserInfo().getUserId());
			super.showMessageDetail("设定完成");
		} catch (SysException e) {
			super.showMessageDetail("设定失败");
			e.printStackTrace();
		}
	}
	
	//提交
	public void submitWage(){
		try {
			this.wageDataService.submitWage(this.operYearMonth, this.selectedUserIds, super.getUserInfo().getUserId());
			super.showMessageDetail("提交完成");
		} catch (SysException e) {
			super.showMessageDetail("提交失败");
			e.printStackTrace();
		}
	}
	//审核
	public void passWage(){
		try {
			this.wageDataService.passWage(this.operYearMonth, this.selectedUserIds, super.getUserInfo().getUserId());
			super.showMessageDetail("审核完成");
		} catch (SysException e) {
			super.showMessageDetail("审核失败");
			e.printStackTrace();
		}
	}
	//加入帐套
	public void addToWageset(){
		try {
			this.wageDataService.addToWageset(this.rightType);
			super.showMessageDetail("添加完成");
		} catch (SysException e) {
			super.showMessageDetail("添加失败");
			e.printStackTrace();
		}
	}
	
	//修改人员
	public String savePerson(){
		try {
			this.wageDataService.saveWageEmpPerson(user);
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("保存失败");
			e.printStackTrace();
		}
		return null;
	}
	
	//导入人员
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
						try{
							double money = Double.valueOf(st.getCell(2, i).getContents());
							this.wageDataService.setEmpWage(money+"", null, p.getPersonId(), super.getUserInfo().getUserId());
							success++;
						}catch (Exception e) {
							fail++;
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
