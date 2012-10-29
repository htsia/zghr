package com.hr319wg.custom.eva.web;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.eva.pojo.bo.EvaWageBO;
import com.hr319wg.custom.eva.service.EvaWageService;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class EvaWageBackingBean extends BaseBackingBean {

	private PageVO mypage = new PageVO();
	private String pageInit;
	private String addUserInit;
	private String koushuiInit;
	private String xishuInit;
	private String editWageInit;
	private String orgID;
	private String nameStr;
	private String personType;
	private UploadedFile excelFile;
	private EvaWageBO evaWage;
	private List<EvaWageBO> list;
	private List<UserBO> userList;
	private String koushuiType;
	private String koushui;
	private String xishus;
	private String xishuIDs;
	private List xishuList;
	private boolean hasChanged;
	private String selectedUserIDs;
	private EvaWageService evaWageService;
	

	public EvaWageBO getEvaWage() {
		return evaWage;
	}

	public void setEvaWage(EvaWageBO evaWage) {
		this.evaWage = evaWage;
	}

	public String getSelectedUserIDs() {
		return selectedUserIDs;
	}

	public void setSelectedUserIDs(String selectedUserIDs) {
		this.selectedUserIDs = selectedUserIDs;
	}

	public List<UserBO> getUserList() {
		return userList;
	}

	public void setUserList(List<UserBO> userList) {
		this.userList = userList;
	}

	public String getKoushuiType() {
		return koushuiType;
	}

	public void setKoushuiType(String koushuiType) {
		this.koushuiType = koushuiType;
	}

	public String getKoushui() {
		return koushui;
	}

	public void setKoushui(String koushui) {
		this.koushui = koushui;
	}

	public String getXishus() {
		return xishus;
	}

	public void setXishus(String xishus) {
		this.xishus = xishus;
	}

	public String getXishuIDs() {
		return xishuIDs;
	}

	public void setXishuIDs(String xishuIDs) {
		this.xishuIDs = xishuIDs;
	}

	public List getXishuList() {
		return xishuList;
	}

	public void setXishuList(List xishuList) {
		this.xishuList = xishuList;
	}

	public List<EvaWageBO> getList() {
		return list;
	}

	public void setList(List<EvaWageBO> list) {
		this.list = list;
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

	public EvaWageService getEvaWageService() {
		return evaWageService;
	}

	public void setEvaWageService(EvaWageService evaWageService) {
		this.evaWageService = evaWageService;
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
			this.list = new ArrayList<EvaWageBO>();
			List list1 = this.evaWageService.getAllEvaWageBO(mypage, orgID, personType, nameStr);
			
			if(list1!=null){
				for(int i=0;i<list1.size();i++){
					Object[]obj = (Object[]) list1.get(i);
					EvaWageBO bo = (EvaWageBO) obj[0];
					PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
					bo.setName(p.getName());
					bo.setPersonCode(p.getPersonCode());
					bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
					bo.setSecDeptDesc(CodeUtil.interpertCode((String)obj[1]));
					bo.setDeptDesc(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
					bo.setEvaType(CodeUtil.interpertCode(bo.getEvaType()));
					this.list.add(bo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//导入出勤率
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
							String level = st.getCell(2, i).getContents();
							double rate = Double.valueOf(st.getCell(3, i).getContents());
							this.evaWageService.updateEvaWageChuqinlv(p.getPersonId(), level, rate+"");
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
	
	//同步出勤率
	public void updateChuqinlv(){
		
	}
	
	//计算绩效工资
	public void updateEvaWage(){
		try {
			this.evaWageService.updateEvaWage();
			super.showMessageDetail("计算成功");
		} catch (SysException e) {
			super.showMessageDetail("计算失败");
			e.printStackTrace();
		}
	}
	
	//绩效系数设置初始化
	public String getXishuInit() {
		this.xishuList = this.evaWageService.getAllEvaWageXishu();
		if(this.xishuList==null || this.xishuList.size()==0){
			this.evaWageService.reloadEvaWageXishu();
			this.xishuList = this.evaWageService.getAllEvaWageXishu();
		}
		if(this.xishuList==null){
			this.xishuList = new ArrayList();
		}
		return xishuInit;
	}
	
	//重新加载绩效系数
	public void reloadXishu(){
		this.evaWageService.reloadEvaWageXishu();
	}
	//保存绩效系数
	public String saveXishu(){
		try {
			this.evaWageService.updateEvaWageXishu(xishuIDs, xishus);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//扣税页面初始化
	public String getKoushuiInit() {
		this.koushui=null;
		List koushui = this.evaWageService.getEvaWageKoushui();
		Map m =(Map)koushui.get(0);
		if(!hasChanged){
			this.koushuiType=String.valueOf(m.get("koushuiType"));			
			hasChanged=false;
		}
		if(m.get("koushui")!=null){
			this.koushui=String.valueOf(m.get("koushui"));
		}
		return koushuiInit;
	}
	
	//保存绩效扣税
	public String saveKoushui(){
		try {
			this.evaWageService.updateEvaWageKoushui(koushuiType, koushui);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}
	public void changeType(ValueChangeEvent event){
		this.hasChanged=true;
	}
	
	//添加未考核人员初始化
	public String getAddUserInit() {
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
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		doQueryUser();
		return null;		
	}
	
	public void doQueryUser(){
		if(this.mypage.getCurrentPage()==0){
			this.mypage.setCurrentPage(1);
		}
		try {
			this.userList = this.evaWageService.getAllNotinEvaUserBO(mypage, orgID, personType, nameStr);
			if(this.userList==null || this.userList.size()==0){
				this.userList = new ArrayList<UserBO>();
			}
			for(UserBO bo : this.userList){
				bo.setPersonType(CodeUtil.interpertCode(bo.getPersonType()));
				bo.setSecondDeptName(CodeUtil.interpertCode(bo.getSecDeptID()));
				bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, bo.getDeptId()));
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//添加未考核人员
	public void addEvaUser(){
		String[]userIDs=this.selectedUserIDs.split(",");
		for(int i=0;i<userIDs.length;i++){
			try {
				this.evaWageService.addEvaUser(userIDs[i]);
			} catch (SysException e) {
				super.showMessageDetail("添加失败");
				e.printStackTrace();
			}
		}
		super.showMessageDetail("添加完成");
	}

	//修改绩效数据
	public String getEditWageInit() {
		String subID = super.getRequestParameter("subID");
		try {
			this.evaWage = (EvaWageBO)this.evaWageService.findBOById(EvaWageBO.class, subID);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return editWageInit;
	}
	
	//保存修改绩效数据
	public String saveEvaWage(){
		try {
			this.evaWageService.saveOrUpdateBO(this.evaWage);
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("保存失败"); 
			e.printStackTrace();
		}
		return null;
	}
	
	public void setworkday() throws ParseException, SysException{
		
		List list = new ArrayList();
		list.add("2011-09-10");
		list.add("2011-09-11");
		list.add("2011-09-12");
		list.add("2011-10-01");
		list.add("2011-10-02");
		list.add("2011-10-03");
		list.add("2011-10-04");
		list.add("2011-10-05");
		list.add("2011-10-06");
		list.add("2011-10-07");
		list.add("2012-01-01");
		list.add("2012-01-02");
		list.add("2012-01-03");
		list.add("2012-01-22");
		list.add("2012-01-23");
		list.add("2012-01-24");
		list.add("2012-01-25");
		list.add("2012-01-26");
		list.add("2012-01-27");
		list.add("2012-01-28");
		list.add("2012-04-02");
		list.add("2012-04-04");
		list.add("2012-04-29");
		list.add("2012-04-30");
		list.add("2012-05-01");
		list.add("2012-06-22");
		list.add("2012-06-23");
		list.add("2012-06-24");
		
		List userlist = this.evaWageService.getworkday();
		for(int i=0;i<userlist.size();i++){
			Map m = (Map)userlist.get(i);
			String userid1=m.get("id").toString();
			String enter=m.get("A001044").toString();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date begin = df.parse(enter);
            Date end = df.parse("2012-08-31");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.setTime(begin);
            c2.setTime(end);
            int day=0;
            while (!c1.after(c2)){
                Calendar c3 = (Calendar) c1.clone();
                c1.add(Calendar.DAY_OF_MONTH, 1);
                boolean isleave=false;
                for(int j=0;j<list.size();j++){
                	 Date t = df.parse(list.get(j).toString());
                     Calendar t1 = Calendar.getInstance();
                     t1.setTime(t);
                     if(t1.getTimeInMillis()==c3.getTimeInMillis()){
                    	 isleave=true;
                    	 break;
                     }
                }
                if(isleave){
                	continue;
                }
                int w=c3.get(Calendar.DAY_OF_WEEK);
                if(w==7 || w==1){
                	continue;
                }
                day++;
            }
            this.evaWageService.setworkday(day, userid1);
		}
		
//        	A001044
//        	A001247 
	}
	
	public static void main(String[] args) throws ParseException {
		List list = new ArrayList();
		list.add("2011-09-10");
		list.add("2011-09-11");
		list.add("2011-09-12");
		list.add("2011-10-01");
		list.add("2011-10-02");
		list.add("2011-10-03");
		list.add("2011-10-04");
		list.add("2011-10-05");
		list.add("2011-10-06");
		list.add("2011-10-07");
		list.add("2012-01-01");
		list.add("2012-01-02");
		list.add("2012-01-03");
		list.add("2012-01-22");
		list.add("2012-01-23");
		list.add("2012-01-24");
		list.add("2012-01-25");
		list.add("2012-01-26");
		list.add("2012-01-27");
		list.add("2012-01-28");
		list.add("2012-04-02");
		list.add("2012-04-04");
		list.add("2012-04-29");
		list.add("2012-04-30");
		list.add("2012-05-01");
		list.add("2012-06-22");
		list.add("2012-06-23");
		list.add("2012-06-24");
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date begin = df.parse("2011-09-01");
            Date end = df.parse("2012-08-31");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.setTime(begin);
            c2.setTime(end);
            int i=0;
            while (!c1.after(c2)){
                Calendar c3 = (Calendar) c1.clone();
                c1.add(Calendar.DAY_OF_MONTH, 1);
                boolean isleave=false;
                for(int j=0;j<list.size();j++){
                	 Date t = df.parse(list.get(j).toString());
                     Calendar t1 = Calendar.getInstance();
                     t1.setTime(t);
                     if(t1.getTimeInMillis()==c3.getTimeInMillis()){
                    	 isleave=true;
                    	 break;
                     }
                }
                if(isleave){
                	continue;
                }
                int w=c3.get(Calendar.DAY_OF_WEEK);
                if(w==7 || w==1){
                	continue;
                }
                i++;
            }
	}
 
}
