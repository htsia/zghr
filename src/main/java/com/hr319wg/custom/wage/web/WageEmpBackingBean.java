package com.hr319wg.custom.wage.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

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
import com.hr319wg.custom.wage.service.WageDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.FileUtil;
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
	private String inself;
	private String rightType; //0���� 1�Ǻ���
	private UploadedFile excelFile;
	private String filename;
	private List<Map> list;
	private WageDataService wageDataService;
	private UserBO user = new UserBO();

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

	public WageDataService getWageDataService() {
		return wageDataService;
	}

	public void setWageDataService(WageDataService wageDataService) {
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
	
	//ҳ���ʼ��
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
//			10220	��У��ְ��ʦ����
//			10221	��У��Ŀ������
//			10219	����ѧ������Ŀ������

			//���й�Ͻ������
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
			List<UserBO> list1 = this.wageDataService.getAllWageEmpUserBO(mypage, hasWage, noWage, orgID, personType, nameStr, rightType, inself, super.getUserInfo().getUserId());
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
							m.put("status", "���ͨ��");
						}else if("0".equals(A239202)){
							m.put("status", "�����");						
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
			super.showMessageDetail("�趨���");
		} catch (SysException e) {
			super.showMessageDetail("�趨ʧ��");
			e.printStackTrace();
		}
	}
	
	//�ύ
	public void submitWage(){
		try {
			this.wageDataService.submitWage(this.operYearMonth, this.selectedUserIds, super.getUserInfo().getUserId());
			super.showMessageDetail("�ύ���");
		} catch (SysException e) {
			super.showMessageDetail("�ύʧ��");
			e.printStackTrace();
		}
	}
	//���
	public void passWage(){
		try {
			this.wageDataService.passWage(this.operYearMonth, this.selectedUserIds, super.getUserInfo().getUserId());
			super.showMessageDetail("������");
		} catch (SysException e) {
			super.showMessageDetail("���ʧ��");
			e.printStackTrace();
		}
	}
	//��������
	public void addToWageset(){
		try {
			this.wageDataService.addToWageset(this.rightType);
			super.showMessageDetail("������");
		} catch (SysException e) {
			super.showMessageDetail("���ʧ��");
			e.printStackTrace();
		}
	}
	
	//�޸���Ա
	public String savePerson(){
		try {
			this.wageDataService.saveWageEmpPerson(user);
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("����ʧ��");
			e.printStackTrace();
		}
		return null;
	}
	
	//������Ա
	public void uploadFile(){
		try {
			Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
			Sheet st=wb.getSheet(0);
			int stRow=st.getRows();
			int success=0;
			int fail=0;
			String err ="������Ա���Ϊ��";
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
				super.showMessageDetail("�ɹ�"+success+"��");				
			}else{
				err=err.substring(0, err.length()-1);
				super.showMessageDetail("�ɹ�"+success+"��ʧ��"+fail+"��,"+err+"����Ա������");								
			}
		} catch (BiffException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}
	
	//����execl
	public void exportExcel(){
		ServletContext context = (ServletContext)FacesContext.getCurrentInstance().getExternalContext().getContext();
	    String path = context.getRealPath("/") + File.separator + "file" + File.separator + "custom" + File.separator + "download";
	    List list = new ArrayList();
	    String[] header = new String[15];
	      
	    header[0] = "����";
	    header[1] = "Ա�����";
	    header[2] = "��Ա���";
	    header[3] = "��������";
	    header[4] = "���ڲ���";
	    header[5] = "���֤��";
	    header[6] = "���п���";
	    header[7] = "���ѧ��";
	    header[8] = "���ѧλ";
	    header[9] = "���ְ��";
	    header[10] = "���ְ�Ƶȼ�";
	    header[11] = "���ְ������";
	    header[12] = "����";
	    header[13] = "�����·�";
	    header[14] = "״̬";
	    try {
	      HttpSession session = super.getHttpSession();
	      List<UserBO> list1 = this.wageDataService.getAllWageEmpUserBO(hasWage, noWage, orgID, personType, nameStr);
	      if(list1==null){
	    	  list1=new ArrayList<UserBO>();
	      }
	      for(UserBO bo : list1){
	    	  String[] content = new String[15];
	    	  content[0]=bo.getName();
	    	  content[1]=bo.getPersonSeq();
	    	  content[2]=CodeUtil.interpertCode(bo.getPersonType());
	    	  content[3]=CodeUtil.interpertCode(bo.getSecDeptID());
	    	  content[4]=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, bo.getDeptId());
	    	  content[5]=bo.getCardNO();
	    	  content[6]=bo.getBankNO();
	    	  content[7]="";
	    	  if(bo.getXueli()!=null){
	    		  content[7]=CodeUtil.interpertCode(bo.getXueli());
	    	  }
	    	  content[8]="";
	    	  if(bo.getXuewei()!=null){
	    		  content[8]=CodeUtil.interpertCode(bo.getXuewei());
	    	  }
	    	  content[9]="";
	    	  if(bo.getZhicheng()!=null){
	    		  content[9]=CodeUtil.interpertCode(bo.getZhicheng());
	    	  }
	    	  content[10]="";
	    	  if(bo.getZhichengLevel()!=null){
	    		  content[10]=CodeUtil.interpertCode(bo.getZhichengLevel());
	    	  }
	    	  content[11]="";
	    	  if(bo.getZhichengXulie()!=null){
	    		  content[11]=CodeUtil.interpertCode(bo.getZhichengXulie());
	    	  }
			  JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
			  String sql = "select A239200,A239201,A239202 from A239 where id='"+bo.getUserID()+"'";
			  List wagelist = jdbc.queryForList(sql);
			  if(wagelist!=null){
					Map m1 = (Map)wagelist.get(0);
					content[12]=String.valueOf(m1.get("A239200"));
					Object A239201 = m1.get("A239201");
					content[13]="";
					if(A239201!=null){
						content[13]= String.valueOf(A239201);
					}
					String A239202 = String.valueOf(m1.get("A239202"));
					content[14]="";
					if("1".equals(A239202)){
						content[14]="���ͨ��";
					}else if("0".equals(A239202)){
						content[14]="�����";
					}
			  }
			  list.add(content);
	      }
	      String fileName = FileUtil.exportFile(path, header, null, list, false);

	      String url = super.getServletRequest().getContextPath() + "/file/custom/download/" + fileName;
	      this.filename=url;
	    } catch (Exception e) {
	    }
	}
}
