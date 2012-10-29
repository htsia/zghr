package com.hr319wg.eva.web;

import com.hr319wg.common.ucc.IAttachmentUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.util.CommonFuns;

import java.io.File;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.util.FileUtil;
import org.apache.myfaces.custom.fileupload.UploadedFile;

/**
 * 绩效管理BackingBean
 * 负责绩效管理模块后台和展现之间的数据中转处理
 */
public class EvaPlanEditBackingBean extends BaseBackingBean {
    private IEvaPlanUCC evaplanucc;
    private IEvaGradeUCC gradeUCC;
	private EvaPlanBO planbo=new EvaPlanBO();
    private String initAudit;
    private String initEdit;
    private UploadedFile excelFile;
    private IAttachmentUCC ucc_attachment;
    private String uploadeFileName;
    
    public String getUploadeFileName() {
		return uploadeFileName;
	}

	public void setUploadeFileName(String uploadeFileName) {
		this.uploadeFileName = uploadeFileName;
	}

	public void changeMode(ValueChangeEvent evnt){
    	planbo.setEvaModel(evnt.getNewValue().toString());
    }
    
    public String uploadFile() {
		// 得到上传文件
		String path = getRealPath("/") + "file" + File.separator
				+ "eva";
		System.out.println(path);
		String fileName = null;
		try {
			fileName = FileUtil.createFile(excelFile, path);
			System.out.println(fileName);
			String type=fileName.substring(fileName.indexOf(".")+1);
			if(type.equals("doc")){
				uploadeFileName=fileName;
				// 保存到数据库
				String filePath = path + File.separator + fileName;
				System.out.println(filePath);
				byte[] fileContent = FileUtil.ReadInFile(filePath);
				String attID = ucc_attachment.createAttachment(fileContent, null,
						null, 0, "eva", "doc");
				planbo.setEvaFile(attID);
				String filepath2 = path + File.separator + attID + ".doc";
				FileUtil.createFile(fileContent, filepath2);
				super.showMessageDetail("上传成功");
			}else{
				super.showMessageDetail("只允许上传word(.doc)文档");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
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
	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}
	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
	}
    public String getInitEdit() {
    	try{
            if (super.getRequestParameter("planID")!=null){
                 planbo=evaplanucc.findPlanById(super.getRequestParameter("planID"));
                 if(planbo.getPlanGrade()!=null&&!planbo.getPlanGrade().equals("")){
                	 planbo.setPlanGradeName(gradeUCC.getGradeByID(planbo.getPlanGrade()).getGradeName());
                 }
            }
            
        }
        catch(SysException e){

        }
        return initAudit;
	}
	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	public String modify(){
        try{
            User user=super.getUserInfo();
            planbo.setCreatePersonId(user.getUserId());
            planbo.setOrgId(super.getUserInfo().getOrgId());
            planbo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            planbo.setStatus(EvaPlanBO.EVA_PLANSTATUS_SCRIPT);
            planbo.setAllowMark("0");
            planbo.setIsVirtual("0");
            evaplanucc.updatePlan(planbo);
        }
        catch(Exception e){

        }
        return "success";
    }
	public String getInitAudit() {
        try{
            if (super.getRequestParameter("planID")!=null){
                 planbo=evaplanucc.findPlanById(super.getRequestParameter("planID"));
            }
        }
        catch(SysException e){

        }
        return initAudit;
    }
    public void setInitAudit(String initAudit) {
        this.initAudit = initAudit;
    }

    public String getOrguid() {
        orguid=super.getUserInfo().getOrgId();
        return orguid;
    }

    public void setOrguid(String orguid) {
        this.orguid = orguid;
    }

    private String orguid;


    public  EvaPlanBO getPlanbo(){
        return planbo;
    }
    public void setPlanbo(EvaPlanBO bo){
        planbo=bo;
    }
    public String audit(){
        try{
            User user=super.getUserInfo();
            planbo.setAduitPersonId(user.getUserId());
            if(planbo.getAduitResult().trim().equals("1")){
            	planbo.setStatus(EvaPlanBO.EVA_PLANSTATUS_APPROVED);
            }
            if(planbo.getAduitResult().trim().equals("0")){
            	planbo.setStatus(EvaPlanBO.EVA_PLANSTATUS_MODFIY);
            }
            evaplanucc.updatePlan(planbo);
        }
        catch(SysException e){

        }
        return "success";
    }
    public String save(){
        try{
            User user=super.getUserInfo();
            planbo.setCreatePersonId(user.getUserId());
            planbo.setOrgId(super.getUserInfo().getOrgId());
            planbo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            planbo.setStatus(EvaPlanBO.EVA_PLANSTATUS_SCRIPT);
            planbo.setAllowMark("0");
            planbo.setIsVirtual("0");
            evaplanucc.createPlan(planbo);
            super.showMessageDetail("增加计划成功！");
        }
        catch(Exception e){

        }
        return "list";
    }
    public  IEvaPlanUCC getEvaplanucc(){
        return evaplanucc;
    }
    public void setEvaplanucc(IEvaPlanUCC ucc){
        evaplanucc=ucc;
    }

}
