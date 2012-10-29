package com.hr319wg.eva.web;

import java.io.File;


import com.hr319wg.util.FileUtil;
import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.ucc.IAttachmentUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;

public class EvaWorkReportBackingBean extends BaseBackingBean {
	private String objectID;
	private UploadedFile excelFile;
	private IEvaObjectsUCC objectUCC;
	private String initEdit;
	private EvaObjectsBO objectbo;
	private IAttachmentUCC ucc_attachment;
	private boolean isExist;
	private String pathFile;
	private String attId;


	public String getAttId() {
		return attId;
	}

	public void setAttId(String attId) {
		this.attId = attId;
	}

	public String getPathFile() {
		return pathFile;
	}

	public void setPathFile(String pathFile) {
		this.pathFile = pathFile;
	}

	public boolean getIsExist() {
		return isExist;
	}

	public void setExist(boolean isExist) {
		this.isExist = isExist;
	}

	public IAttachmentUCC getUcc_attachment() {
		return ucc_attachment;
	}

	public void setUcc_attachment(IAttachmentUCC ucc_attachment) {
		this.ucc_attachment = ucc_attachment;
	}

	public EvaObjectsBO getObjectbo() {
		return objectbo;
	}

	public void setObjectbo(EvaObjectsBO objectbo) {
		this.objectbo = objectbo;
	}

	public String getInitEdit() {
     	try {
			if (super.getRequestParameter("objectID") != null) {
				objectID = super.getRequestParameter("objectID");
			}
			objectbo = objectUCC.findEvaObjectBOById(objectID);
			if (objectbo.getSummaryFile() != null && !objectbo.getSummaryFile().equals("")) {
				isExist = true;
				attId=objectbo.getSummaryFile();
			} else {
				isExist = false;
			}
			
		} catch (SysException e) {
			e.printStackTrace();
		}
        

		
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getObjectID() {
		return objectID;
	}

	public void setObjectID(String objectID) {
		this.objectID = objectID;
	}

	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}

	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
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
				System.out.println(fileName);
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
	


}
