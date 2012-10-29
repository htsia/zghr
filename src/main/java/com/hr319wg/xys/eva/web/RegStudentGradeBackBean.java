package com.hr319wg.xys.eva.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysXspjScoreBO;
import com.hr319wg.xys.eva.pojo.vo.KPIItemVO;
import com.hr319wg.xys.eva.ucc.IStudentGradeUCC;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;

public class RegStudentGradeBackBean extends BaseBackingBean {
	private IXysEvaPlanUCC xysEvaPlanUCC;
	private IStudentGradeUCC studentGradeUcc;
	private String pageInit;
	private PageVO mypage = new PageVO();
	private List planList;
	private IEvaGradeUCC evaGradeUCC;
	private String planId;
	private boolean selectAll = false;

	public IStudentGradeUCC getStudentGradeUcc() {
		return studentGradeUcc;
	}

	public void setStudentGradeUcc(IStudentGradeUCC studentGradeUcc) {
		this.studentGradeUcc = studentGradeUcc;
	}

	public IXysEvaPlanUCC getXysEvaPlanUCC() {
		return xysEvaPlanUCC;
	}

	public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
		this.xysEvaPlanUCC = xysEvaPlanUCC;
	}

	public void queryAll(ValueChangeEvent event) {
		selectAll = "true".equals(event.getNewValue().toString());
		doQuery();
	}

	public String first() {
		mypage.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuery();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuery();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuery();
		return "";
	}

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if (selectAll) {
				planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage, super
						.getUserInfo().getOrgId(), null);
			} else {
				planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage, super
						.getUserInfo().getOrgId(),
						new String[] { XysEvaPlanBO.STATUS_ZHIXING });
			}
			if (planList != null && planList.size() > 0) {
				for (int i = 0; i < planList.size(); i++) {
					XysEvaPlanBO bo = (XysEvaPlanBO) planList.get(i);
					EvaGradeBO grade = evaGradeUCC.getGradeByID(bo
							.getPlanGrade());
					bo.setPlanGrade(grade.getGradeName());
					bo.setPlanType(CodeUtil.interpertCode(bo.getPlanType()));
					planList.set(i, bo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public List getPlanList() {
		return planList;
	}

	public void setPlanList(List planList) {
		this.planList = planList;
	}

	public IEvaGradeUCC getEvaGradeUCC() {
		return evaGradeUCC;
	}

	public void setEvaGradeUCC(IEvaGradeUCC evaGradeUCC) {
		this.evaGradeUCC = evaGradeUCC;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public boolean isSelectAll() {
		return selectAll;
	}

	public void setSelectAll(boolean selectAll) {
		this.selectAll = selectAll;
	}

	// 录入学生评价
	private String initIndex;
	private String superId;
	private String initInput;
	private String queryValue;
	private List personList;
	private String scoreId;

	public String delete() {
		try {
			this.studentGradeUcc.deleteXysXspjScoreBO(scoreId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getScoreId() {
		return scoreId;
	}

	public void setScoreId(String scoreId) {
		this.scoreId = scoreId;
	}

	public String first1() {
		mypage.setCurrentPage(1);
		queryScoere();
		return "";
	}

	public String pre1() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryScoere();
		return "";
	}

	public String next1() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryScoere();
		return "";
	}

	public String last1() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryScoere();
		return "";
	}

	public void queryScoere() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if (queryValue != null && !queryValue.equals("")) {
				String where = " and bo.personId in(select po.personId from PersonBO po "
						+ "where po.name like '%"
						+ queryValue
						+ "%' or po.shortName like '%"
						+ queryValue
						+ "%' or po.personCode like '%" + queryValue + "%')";
				personList = this.studentGradeUcc.getXysXspjScoreBO(mypage,
						planId, where);
			} else {
				if (superId == null || superId.equals("")) {
					superId = super.getUserInfo().getOrgId();
				}
				String treeId = SysCacheTool.findOrgById(superId).getTreeId();
				String where = " and bo.personId in(select po.personId from PersonBO po "
						+ "where po.deptTreeId like '%" + treeId + "%')";
				personList = this.studentGradeUcc.getXysXspjScoreBO(mypage,
						planId, where);
			}

			if (personList != null && personList.size() > 0) {
				for (int i = 0; i < personList.size(); i++) {
					XysXspjScoreBO score = (XysXspjScoreBO) personList.get(i);
					PersonBO pbo = SysCacheTool.findPersonById(score
							.getPersonId());
					score.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
							.getName());
					score.setPersonCode(pbo.getPersonCode());
					score.setPersonName(pbo.getName());
					score.setPostName(PostTool.getPostName(pbo.getPostId()));
					personList.set(i, score);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getInitInput() {
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
		}
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		queryScoere();
		return initInput;
	}

	public void setInitInput(String initInput) {
		this.initInput = initInput;
	}

	public String getQueryValue() {
		return queryValue;
	}

	public void setQueryValue(String queryValue) {
		this.queryValue = queryValue;
	}

	public List getPersonList() {
		return personList;
	}

	public void setPersonList(List personList) {
		this.personList = personList;
	}

	public String getInitIndex() {
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
		}
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		return initIndex;
	}

	public void setInitIndex(String initIndex) {
		this.initIndex = initIndex;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	// 录入分数
	private String initEdit;
	private XysXspjScoreBO scoreBo = new XysXspjScoreBO();

	public String saveScore() {
		try {
			PersonBO pbo = SysCacheTool.findPersonByCode(scoreBo
					.getPersonCode());
			scoreBo.setPersonId(pbo.getPersonId());
			scoreBo.setPlanId(planId);
			double avgScore = Double.parseDouble(CommonFuns
					.filterNullToZero(scoreBo.getScore()))
					+ Double.parseDouble(CommonFuns.filterNullToZero(scoreBo
							.getScore2()));
			scoreBo.setAvgScore(String.valueOf(avgScore / 2));
			studentGradeUcc.saveXysXspjScoreBO(scoreBo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("planId") != null) {
				planId = super.getRequestParameter("planId");
				scoreBo.initRow();
			} else if (super.getRequestParameter("scoreId") != null) {
				scoreId = super.getRequestParameter("scoreId");
				scoreBo = studentGradeUcc.findXysXspjScoreBOById(scoreId);
				PersonBO pbo = SysCacheTool.findPersonById(scoreBo
						.getPersonCode());
				scoreBo.setPersonCode(pbo.getPersonCode());
				planId = scoreBo.getPlanId();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public XysXspjScoreBO getScoreBo() {
		return scoreBo;
	}

	public void setScoreBo(XysXspjScoreBO scoreBo) {
		this.scoreBo = scoreBo;
	}

	// 指标导入
	private String initUpload;
	private UploadedFile excelFile;

	public String getInitUpload() {
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
		}
		return initUpload;
	}

	public void setInitUpload(String initUpload) {
		this.initUpload = initUpload;
	}

	public String uploadFile() {
		try {
			String fileName = excelFile.getName();
			String type = fileName.substring(fileName.indexOf(".") + 1);
			if (type.equals("xls")) {
				System.out.println("==============开始导入！===================");
				Workbook wb = Workbook.getWorkbook(excelFile.getInputStream());
				Sheet sheet = wb.getSheet(0);
				int rows = sheet.getRows();
				System.out.println("行数：" + rows);
				List superNameList = new ArrayList();
				List itemVoList = new ArrayList();
				KPIItemVO itemVo = null;
				NumberFormat format=NumberFormat.getInstance();
				format.setMaximumFractionDigits(2);
				for (int i = 1; i < rows; i++) {// 便利excel封装 KPIItemVO
					Cell[] cell = sheet.getRow(i);
					PersonBO pbo = SysCacheTool.findPersonByCode(CommonFuns
							.filterNull(cell[0].getContents().trim()));
					if(pbo!=null){
						XysXspjScoreBO bo=this.studentGradeUcc.findEqualsXysXspjScoreBO(planId,pbo.getPersonId());
						if(bo==null){
							bo=new XysXspjScoreBO();
						}
						bo.setPlanId(planId);
						bo.setPersonId(pbo.getPersonId());
						String score=cell[1].getContents().trim();
						if(score!=null&&!score.equals("")){
							double s=Double.parseDouble(score); 
							bo.setAvgScore(format.format(s));
							studentGradeUcc.saveXysXspjScoreBO(bo);
						}
					}
				}
				wb.close();
				System.out.println("==============导入成功！===================");
			} else {
				super.showMessageDetail("只允许上传Excel（.xls）文档！");
				return "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

}
