package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaTaskProcessBO;
import com.hr319wg.eva.ucc.IEvaTaskEstimateUcc;
import com.hr319wg.util.CommonFuns;

public class EvaTaskProcessMgrBankBean extends BaseBackingBean {
	private IEvaTaskEstimateUcc taskucc;
	private String pageInit;
	private List processList;
	private String itemId;
	private String processId;
	private EvaTaskProcessBO processbo=new EvaTaskProcessBO();
	private String initEdit;
	private String selfscore;
	
	public String saveSelfScore(){
		try{
			if(selfscore!=null&&!selfscore.equals("")){
				EvaTaskEstimateBO estiomatbo=taskucc.findEvaTaskEstimateBO(itemId);
				estiomatbo.setSelfScore(selfscore);
				taskucc.saveEvaTaskEstimateBO(estiomatbo);
				super.showMessageDetail("打分操作成功！");
			}else{
				super.showMessageDetail("请输入自评分！");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String getSelfscore() {
		return selfscore;
	}
	public void setSelfscore(String selfscore) {
		this.selfscore = selfscore;
	}
	public String save(){
		try{
			processbo.setItemId(itemId);
			processbo.setReportDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			taskucc.saveEvaTaskProcessBO(processbo);
			List processList1=taskucc.getAllProcessByItemId(itemId);
			if(processList1!=null && processList1.size()>0){
				EvaTaskProcessBO bo1=(EvaTaskProcessBO)processList1.get(0);
				EvaTaskEstimateBO bo2=taskucc.findEvaTaskEstimateBO(itemId);
				bo2.setProcess(bo1.getProcess());
				taskucc.saveEvaTaskEstimateBO(bo2);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String delete(){
		try{
			taskucc.deleteEvaTaskProcessBO(processId);
			List processList1=taskucc.getAllProcessByItemId(itemId);
			if(processList1!=null && processList1.size()>0){
				EvaTaskProcessBO bo1=(EvaTaskProcessBO)processList1.get(0);
				EvaTaskEstimateBO bo2=taskucc.findEvaTaskEstimateBO(itemId);
				bo2.setProcess(bo1.getProcess());
				taskucc.saveEvaTaskEstimateBO(bo2);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String getInitEdit() {
		try{
			if(super.getRequestParameter("itemId")!=null){
				itemId=super.getRequestParameter("itemId");
				processbo.initrow();
			}else if(super.getRequestParameter("processId")!=null){
				processId=super.getRequestParameter("processId");
				processbo=taskucc.findEvaTaskProcessBOById(processId);
				itemId=processbo.getItemId();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}
	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	public EvaTaskProcessBO getProcessbo() {
		return processbo;
	}
	public void setProcessbo(EvaTaskProcessBO processbo) {
		this.processbo = processbo;
	}
	public String getProcessId() {
		return processId;
	}
	public void setProcessId(String processId) {
		this.processId = processId;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public IEvaTaskEstimateUcc getTaskucc() {
		return taskucc;
	}
	public void setTaskucc(IEvaTaskEstimateUcc taskucc) {
		this.taskucc = taskucc;
	}
	public void queryProcessList(){
		try{
			processList=taskucc.getAllProcessByItemId(itemId);
			if(null==processList){
				processList=new ArrayList();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getPageInit() {
		try{
			if(super.getRequestParameter("itemId")!=null){
				itemId=super.getRequestParameter("itemId");
				String personId=taskucc.findEvaTaskMasterBO(taskucc.findEvaTaskEstimateBO(itemId).getMasterId()).getPersonId();
				super.getHttpSession().setAttribute("personId", personId);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		queryProcessList();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public List getProcessList() {
		return processList;
	}
	public void setProcessList(List processList) {
		this.processList = processList;
	}
}
