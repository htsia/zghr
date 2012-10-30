package com.hr319wg.custom.attence.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.task.Task;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.attence.pojo.bo.AttLeaveBO;
import com.hr319wg.custom.attence.pojo.bo.AttLogBO;
import com.hr319wg.custom.attence.pojo.bo.AttOvertimeBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.attence.util.AttConstants;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.workflow.service.ActivitiToolsService;

public class AttOvertimeAuditBackingBean extends BaseBackingBean {
	private IAttBusiService attBusiService;
	private ActivitiToolsService activitiToolService;
	private String initAudit;
	private List list;
	
	
	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public void setInitAudit(String initAudit) {
		this.initAudit = initAudit;
	}

	public void setInitAuditEdit(String initAuditEdit) {
		this.initAuditEdit = initAuditEdit;
	}

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}

	public ActivitiToolsService getActivitiToolService() {
		return activitiToolService;
	}
	public void setActivitiToolService(ActivitiToolsService activitiToolService) {
		this.activitiToolService = activitiToolService;
	}
	public void queryAuditTask(){
		try{
			list= attBusiService.queryOvertimeAuditTask(super.getUserInfo().getUserId());
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitAudit() {
		queryAuditTask();
		return null;
	}
	
	//ÉóÅú
	private String initAuditEdit;
	private String id;
	private String taskId;
	private String result;
	private String reason;
	
	public String saveAudit(){
		try {
			AttOvertimeBO bo1= (AttOvertimeBO)attBusiService.findBOById(AttOvertimeBO.class, id);
			this.attBusiService.saveOvertimeAudit(result, bo1, reason, taskId,
					super.getUserInfo().getUserId());
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("²Ù×÷Ê§°Ü£¡");
		}
		return null;
	}
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getInitAuditEdit() {
		if(super.getRequestParameter("taskId")!=null){
			taskId=super.getRequestParameter("taskId");
		}
		if(super.getRequestParameter("id")!=null){
			id=super.getRequestParameter("id");
		}
		return null;
	}

}
