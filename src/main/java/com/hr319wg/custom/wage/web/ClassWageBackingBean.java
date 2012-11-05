package com.hr319wg.custom.wage.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.custom.wage.pojo.bo.ClassWageBO;
import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class ClassWageBackingBean extends BaseBackingBean {

	private PageVO mypage = new PageVO();
	private String pageInit;
	private String editInit;
	private ClassWageBO classWageBO;
	private String orgID;
	private String nameStr;
	private String personType;
	private String inself;
	private UploadedFile excelFile;
	private String selectedUserIDs;
	private UserAPI api;
	private IWageDataService wageDataService;
	private List<ClassWageBO> list;
	private String operUserID;
	private String currUserName;
	
	public String getCurrUserName() {
		return currUserName;
	}

	public void setCurrUserName(String currUserName) {
		this.currUserName = currUserName;
	}

	public String getOperUserID() {
		return operUserID;
	}

	public void setOperUserID(String operUserID) {
		this.operUserID = operUserID;
	}

	public ClassWageBO getClassWageBO() {
		return classWageBO;
	}

	public void setClassWageBO(ClassWageBO classWageBO) {
		this.classWageBO = classWageBO;
	}

	public UserAPI getApi() {
		return api;
	}

	public void setApi(UserAPI api) {
		this.api = api;
	}

	public List<ClassWageBO> getList() {
		return list;
	}

	public void setList(List<ClassWageBO> list) {
		this.list = list;
	}

	public String getInself() {
		return inself;
	}

	public void setInself(String inself) {
		this.inself = inself;
	}

	public IWageDataService getWageDataService() {
		return wageDataService;
	}

	public void setWageDataService(IWageDataService wageDataService) {
		this.wageDataService = wageDataService;
	}

	public String getSelectedUserIDs() {
		return selectedUserIDs;
	}

	public void setSelectedUserIDs(String selectedUserIDs) {
		this.selectedUserIDs = selectedUserIDs;
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

	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
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
	//页面初始化
	public String getPageInit() {		
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.mypage = new PageVO();
			this.nameStr=null;
			this.orgID=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		String inself1 = super.getRequestParameter("inself");
		if(inself1!=null && !"".equals(inself1)){
			this.inself=inself1;
		}
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
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
			this.list = new ArrayList<ClassWageBO>();
			List list1 = this.wageDataService.getAllClassWageBO(mypage, this.orgID, this.personType, this.nameStr, super.getUserInfo().getUserId(), this.inself);
			
			if(list1!=null){
				for(int i=0;i<list1.size();i++){
					Object[]obj = (Object[]) list1.get(i);
					ClassWageBO bo = (ClassWageBO) obj[0];
					UserBO ubo = (UserBO) obj[1];
					PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
					bo.setName(p.getName());
					PersonBO p1 = SysCacheTool.findPersonById(bo.getCreateUserID());
					bo.setCreateUserID(p1.getName());
					bo.setPersonCode(p.getPersonCode());
					bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
					bo.setSecDeptName(CodeUtil.interpertCode(ubo.getSecDeptID()));
					bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
					bo.setLevel(CodeUtil.interpertCode(ubo.getZhichengLevel()));
					bo.setLevel2(CodeUtil.interpertCode(bo.getLevel2()));
					bo.setXueli(CodeUtil.interpertCode(ubo.getXueli()));
					this.list.add(bo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//导入超课时数
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
							double classNum = Double.valueOf(st.getCell(2, i).getContents());
							ClassWageBO bo = new ClassWageBO();
							bo.setCreateUserID(super.getUserInfo().getUserId());
							bo.setUserID(p.getPersonId());
							bo.setClassNum(String.valueOf(classNum));
							bo.setYear(CommonFuns.getSysDate("yyyy"));
							this.wageDataService.saveOrUpdateObject(bo);
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
	
	//添加人员
	public void addUser(){
		String[]userIDs=this.selectedUserIDs.split(",");
		try {
			this.wageDataService.addClassUser(userIDs, super.getUserInfo().getUserId());
			super.showMessageDetail("添加完成");
		} catch (SysException e) {
			super.showMessageDetail("添加失败");
			e.printStackTrace();
		}
	}
	
	//删除人员
	public void deleteUser(){
		try {
			this.wageDataService.deleteClassUser(this.operUserID);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	//修改人员初始化
	public String getEditInit() {
		String subID = super.getRequestParameter("subID");
		try {
			this.classWageBO=(ClassWageBO)this.wageDataService.findBOById(ClassWageBO.class, subID);
			PersonBO p = SysCacheTool.findPersonById(this.classWageBO.getUserID());
			this.currUserName=p.getName();
		} catch (SysException e) {
			e.printStackTrace();
		}
		return editInit;
	}
	
	//修改人员
	public String updateUser(){
		try {
			this.wageDataService.saveOrUpdateObject(this.classWageBO);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}
	//计算超课时费
	public void calcClassWage(){
		try {
			this.wageDataService.calcClassWage();
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
}
