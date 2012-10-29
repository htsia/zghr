package com.hr319wg.eva.web;

import java.io.File;
import java.util.List;

import com.hr319wg.util.FileUtil;
import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.ucc.IAttachmentUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;

public class SelfInputWorkSumBackBean extends BaseBackingBean {
	private IEvaPlanUCC evaplanucc;
	private IEvaGradeUCC gradeUCC;
	private IEvaObjectsUCC objectUCC;
	private String pageInit;
	private String personId;
	private List planList;

	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}

	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}

	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}

	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
	}

	public String getPageInit() {
		try{
			planList=evaplanucc.getAllTableModeEvaPlanBOByPersonId(super.getUserInfo().getUserId());
			if(planList!=null&&planList.size()>0){
				for(int i=0;i<planList.size();i++){
					EvaPlanBO bo=(EvaPlanBO)planList.get(i);
					bo.setCreatePersonName(SysCacheTool.findPersonById(bo.getCreatePersonId()).getName());
					planList.set(i, bo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public List getPlanList() {
		return planList;
	}

	public void setPlanList(List planList) {
		this.planList = planList;
	}

	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
	//总结编辑
	private String initEdit;
	private String orgName;
	private String deptName;
	private String postName;
	private String personName;
	private String content;
	private EvaObjectsBO objectbo=new EvaObjectsBO();
	private String planId;
	private String method;
	private String showFiled;
	private UploadedFile excelFile;
	private IAttachmentUCC ucc_attachment;
	private String attId;
	private String isExist;

	public String getIsExist() {
		return isExist;
	}

	public void setIsExist(String isExist) {
		this.isExist = isExist;
	}

	public String getAttId() {
		return attId;
	}

	public void setAttId(String attId) {
		this.attId = attId;
	}

	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public IAttachmentUCC getUcc_attachment() {
		return ucc_attachment;
	}

	public void setUcc_attachment(IAttachmentUCC ucc_attachment) {
		this.ucc_attachment = ucc_attachment;
	}

	public String uploadFile() {
		// 得到上传文件
		String path = getRealPath("/") + "file" + File.separator
				+ "eva";
		String fileName = null;
		try {
			String fullName= FileUtil.parseFileName(excelFile.getName());
			String type=fullName.substring(fullName.indexOf(".")+1);
			if(type.equals("doc")){
				fileName = FileUtil.createFile(excelFile, path);
				// 保存到数据库
				String filePath = path + File.separator + fileName;
				byte[] fileContent = FileUtil.ReadInFile(filePath);
				String attID = ucc_attachment.createAttachment(fileContent, null,
						null, 0, "eva", "doc");
				
				objectbo.setSummaryFile(attID);
				objectUCC.savaEvaObject(objectbo);
				String filepath2 = path + File.separator + attID + ".doc";
				FileUtil.createFile(fileContent, filepath2);
			}else{
				super.showMessageDetail("只允许上传word(.doc)文档");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public EvaObjectsBO getObjectbo() {
		return objectbo;
	}

	public void setObjectbo(EvaObjectsBO objectbo) {
		this.objectbo = objectbo;
	}

	public String getShowFiled() {
		return SysCacheTool.findInfoItem("", "A746755").getItemName();
	}

	public void setShowFiled(String showFiled) {
		this.showFiled = showFiled;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public String save(){
		try{
			objectbo.setSummaryText(content);
			objectUCC.savaEvaObject(objectbo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	public String getInitEdit() {
		try{
			if(super.getRequestParameter("planID")!=null){
				planId=super.getRequestParameter("planID");
			}
			if(super.getRequestParameter("method")!=null){
				method=super.getRequestParameter("method");
			}
			if(super.getRequestParameter("sumPid")!=null){
				objectbo=objectUCC.getEvaObjectsBOByPlanIdAndPersonId(planId, super.getRequestParameter("sumPid"));
				personId=super.getRequestParameter("sumPid");
			}else if(super.getRequestParameter("self")!=null){
				objectbo=objectUCC.getEvaObjectsBOByPlanIdAndPersonId(planId,super.getUserInfo().getUserId());
				personId=super.getUserInfo().getUserId();
			}
			if (objectbo.getSummaryFile() != null && !objectbo.getSummaryFile().equals("")) {
				isExist ="1";
				attId=objectbo.getSummaryFile();
			} else {
				isExist ="0";
			}
			if(objectbo.getSummaryText()!=null&&!objectbo.getSummaryText().equals("")){
				content=objectbo.getSummaryText();
			}else{
				content="";
			}
			PersonBO pbo=SysCacheTool.findPersonById(personId);
			orgName=SysCacheTool.findOrgById(pbo.getOrgId()).getName();
			deptName=SysCacheTool.findOrgById(pbo.getDeptId()).getName();
			postName=PostTool.getPostName(pbo.getPostId());
			personName=pbo.getName();
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
