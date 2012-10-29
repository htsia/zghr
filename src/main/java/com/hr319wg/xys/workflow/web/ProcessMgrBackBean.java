package com.hr319wg.xys.workflow.web;

import java.util.List;

import javax.faces.event.ValueChangeEvent;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.xys.workflow.service.ActivitiToolsService;

public class ProcessMgrBackBean extends BaseBackingBean {
	private ActivitiToolsService activitiToolService;
	private String pageInit;
	private List flowList;
	private boolean selAll=false;
	private String deploymentId;
	
	public void deleteFlow(){
		try{
			activitiToolService.deleteProcessDefinition(deploymentId);
			super.showMessageDetail("操作成功！");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public boolean isSelAll() {
		return selAll;
	}
	public void setSelAll(boolean selAll) {
		this.selAll = selAll;
	}
	public void selAllProcess(ValueChangeEvent event){
		selAll=event.getNewValue().toString().equals("true");
		queryFlow();
	}
	public void queryFlow(){
		try{
			flowList=activitiToolService.getProcessDefinitionList(selAll);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getPageInit() {
		queryFlow();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public List getFlowList() {
		return flowList;
	}
	public void setFlowList(List flowList) {
		this.flowList = flowList;
	}
	
	public ActivitiToolsService getActivitiToolService() {
		return activitiToolService;
	}
	public void setActivitiToolService(ActivitiToolsService activitiToolService) {
		this.activitiToolService = activitiToolService;
	}
	public String getDeploymentId() {
		return deploymentId;
	}
	public void setDeploymentId(String deploymentId) {
		this.deploymentId = deploymentId;
	}
	
	//部署流程
	private UploadedFile zipFile;
	
	public String uploadFile() {
		
		try {
			String fileName = zipFile.getName();
			String type=fileName.substring(fileName.indexOf(".")+1);
			if(type.equals("zip")){
				activitiToolService.deployProcessDefinition(zipFile.getInputStream());
			}else{
				super.showMessageDetail("只允许上传(.zip)文档");
				return "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	public UploadedFile getZipFile() {
		return zipFile;
	}
	public void setZipFile(UploadedFile zipFile) {
		this.zipFile = zipFile;
	} 
	 
	 
}
