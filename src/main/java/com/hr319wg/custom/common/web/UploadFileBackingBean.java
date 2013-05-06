package com.hr319wg.custom.common.web;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.custom.pojo.bo.SetFileBO;

public class UploadFileBackingBean extends BaseBackingBean{

	private String pageInit;
	private String pk;
	private String setID;
	private String itemID;
	private String operID;
	private ICommonService commonService;
	private UploadedFile myFile;
	private String filepath;
	private String filename;
	
	
	public String getOperID() {
		return operID;
	}
	public void setOperID(String operID) {
		this.operID = operID;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public UploadedFile getMyFile() {
		return myFile;
	}
	public void setMyFile(UploadedFile myFile) {
		this.myFile = myFile;
	}
	public ICommonService getCommonService() {
		return commonService;
	}
	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}
	public String getPageInit() {
		String pk1=super.getRequestParameter("pk");
		if(pk1!=null && !"".equals(pk1)){
			this.pk=pk1;
		}
		String setID1=super.getRequestParameter("setID");
		if(setID1!=null && !"".equals(setID1)){
			this.setID=setID1;
		}
		String itemID1=super.getRequestParameter("itemID");
		if(itemID1!=null && !"".equals(itemID1)){
			this.itemID=itemID1;
		}
		doQuery();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public String getPk() {
		return pk;
	}
	public void setPk(String pk) {
		this.pk = pk;
	}
	public String getSetID() {
		return setID;
	}
	public void setSetID(String setID) {
		this.setID = setID;
	}
	public String getItemID() {
		return itemID;
	}
	public void setItemID(String itemID) {
		this.itemID = itemID;
	}
	
	public void doQuery(){
		try {
			SetFileBO bo= this.commonService.getSetFile(this.setID, this.itemID, this.pk);
			if(bo==null){
				bo=new SetFileBO();
			}
			this.filepath=bo.getFilepath();
			if(this.filepath==null){
				this.filepath="";
			}
			this.filename=bo.getFilename();
			if(this.filename==null){
				this.filename="";
			}
			this.operID=bo.getID();
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void delete(){
		try {
			this.commonService.deleteSetFile(this.operID);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}	
	
	public void upload(){
		try {
			String path=super.getServletContext().getRealPath("/");
			String filepath= this.commonService.saveUpdateFile(myFile, path, this.pk, this.setID, this.itemID);
			this.filepath=filepath;
			this.filename=myFile.getName().substring(0, myFile.getName().lastIndexOf("."));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
