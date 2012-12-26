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
import com.hr319wg.custom.wage.pojo.bo.WageEmpBO;
import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class WageEmpBackingBean extends BaseBackingBean {
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String editInit;

	private String orgID;
	private String nameStr;
	private String personType="0135700572,0135700574";
	private String operYearMonth;
	private String operUserID;
	private String wage;
	private String other;
	private String importType;
	private boolean hasWage=true;
	private boolean noWage=true;
	private boolean hasCash=true;
	private boolean hasNoCash=true;
	private UploadedFile excelFile;
	private String filename;
	private List<Map> list;
	private IWageDataService wageDataService;
	private UserBO user = new UserBO();

	public String getImportType() {
		return importType;
	}

	public void setImportType(String importType) {
		this.importType = importType;
	}

	public String getOperUserID() {
		return operUserID;
	}

	public void setOperUserID(String operUserID) {
		this.operUserID = operUserID;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}

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
		this.wage=null;
		this.other=null;
		String userID = super.getRequestParameter("userID");
		if(userID!=null && !"".equals(userID)){
			try {
				this.user = (UserBO) this.wageDataService.findBOById(UserBO.class, userID);
				WageEmpBO wbo = (WageEmpBO) this.wageDataService.findBOById(WageEmpBO.class, userID);
				this.wage=wbo.getWage();
				this.other=wbo.getOther();
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		if(this.user==null){
			this.user=new UserBO();
		}
		return editInit;
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
			this.orgID=null;
			this.nameStr=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
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
			List list1 = this.wageDataService.getAllWageEmpUserBO(mypage, hasWage, noWage, hasCash, hasNoCash, orgID, personType, nameStr);
			if(list1!=null){
				for(int i=0;i<list1.size();i++){
					Object[]obj=(Object[])list1.get(i);
					UserBO bo = (UserBO)obj[0];
					WageEmpBO wbo = (WageEmpBO)obj[1];
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
					if("1".equals(bo.getHasCashStr())){
						m.put("hasCash", "是");
					}
					m.put("wage", wbo.getWage());
					m.put("other", wbo.getOther());
					this.list.add(m);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	//加入帐套
	public void addToWageset(){
		try {
			this.wageDataService.addToWageset();
			super.showMessageDetail("添加完成");
		} catch (SysException e) {
			super.showMessageDetail("添加失败");
			e.printStackTrace();
		}
	}
	
	//修改人员
	public String savePerson(){
		try {
			this.wageDataService.saveWageEmpPerson(user, wage, other);
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("保存失败");
			e.printStackTrace();
		}
		return null;
	}
	//删除人员
	public void delete(){
		try {
			this.wageDataService.deleteWageEmpPerson(this.operUserID);
			super.showMessageDetail("删除完成");
		} catch (SysException e) {
			super.showMessageDetail("删除失败");
			e.printStackTrace();
		}
	}
	
	//导入人员
	public void uploadFile(){
		try {
			Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
			Sheet st=wb.getSheet(0);
			int stRow=st.getRows();
			List<Map> listEmp = new ArrayList<Map>();
			JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
			String sql=null; 
			for(int i=1;i<stRow;i++){
				Map m = new HashMap();
				String name = st.getCell(0, i).getContents();
				if(name==null || "".equals(name)){
					break;
				}
				m.put("name", name);
				String dept = st.getCell(1, i).getContents();
				sql="select orguid from b001 where b001005='"+dept+"' and b001730='00900'";
				List deptList = jdbc.queryForList(sql);
				if(deptList==null || deptList.size()==0){
					super.showMessageDetail("第"+i+"行姓名为"+name+"的所在部门"+dept+"不存在");
					break;
				}
				m.put("deptID", ((Map)deptList.get(0)).get("orguid"));
				
				String personType = st.getCell(2, i).getContents();
				if(!"项目工".equals(personType) && !"兼职教师".equals(personType)){
					super.showMessageDetail("第"+i+"行姓名为"+name+"的人员类别"+personType+"不存在");
					break;					
				}
				if("项目工".equals(personType)){
					m.put("personType", "0135700572");
				}else if("兼职教师".equals(personType)){
					m.put("personType", "0135700574");					
				}
				
				String card = st.getCell(3, i).getContents();
				if(card==null || "".equals(card)){
					break;
				}
				m.put("card", card);
				
				String bank = st.getCell(4, i).getContents();
				String hasCash = st.getCell(7, i).getContents();
				if("是".equals(hasCash)){
					m.put("hasCash", "1");					
				}else{
					if(bank==null || "".equals(bank)){
						super.showMessageDetail("第"+i+"行姓名为"+name+"的银行账号不能为空");
						break;
					}
					m.put("bank", bank);										
					m.put("hasCash", "0");										
				}
				
				String wage1 = st.getCell(5, i).getContents();
				if(wage1!=null && wage1.length()>0){
					wage1=wage1.trim();
					try {
						Double.valueOf(wage1);						
					} catch (NumberFormatException e) {
						super.showMessageDetail("第"+i+"行姓名为"+name+"的基础工资格式有误");
						break;
					}
				}
				m.put("wage", wage1.trim());
				
				String other1 = st.getCell(6, i).getContents();
				if(other1!=null && other1.length()>0){
					other1=other1.trim();
					try {
						Double.valueOf(other1);						
					} catch (NumberFormatException e) {
						super.showMessageDetail("第"+i+"行姓名为"+name+"的其他补贴格式有误");
						break;
					}
				}
				m.put("other", other1.trim());
				sql="select id from a001 where A001054 in ('0135700572','0135700574') and A001077='"+card+"'";
				List cardList=jdbc.queryForList(sql);
				if(cardList!=null && cardList.size()==1){
					Map id=(Map)cardList.get(0);
					m.put("id", id.get("id"));
				}else if(cardList!=null && cardList.size()>1){
					super.showMessageDetail("第"+i+"行姓名为"+name+"的身份证在系统中已经存在"+cardList.size()+"个");
					break;
				}
				listEmp.add(m);
			}
			this.wageDataService.batchSaveWageEmpPerson(listEmp, this.importType);
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
