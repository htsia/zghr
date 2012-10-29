package com.hr319wg.xys.workflow.service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.ProcessDefinitionImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;
import org.apache.commons.beanutils.PropertyUtils;

import com.hr319wg.common.exception.SysException;

public class ActivitiToolsService {
	private RuntimeService runtimeService;
	private TaskService taskService;
	private RepositoryService repositoryService;
	private HistoryService historyService;
	
	/**
	 * 返回所有流程定义
	 * @param selAll true返回所有版本  false返回最新版本
	 * @return
	 */
	public List getProcessDefinitionList(boolean selAll)throws SysException{
		if(selAll){
			return repositoryService.createProcessDefinitionQuery().list();
		}
		return repositoryService.createProcessDefinitionQuery().latestVersion().list();
	}
	
	/**
	 * 级联删除部署流程定义
	 * @param deploymentId 部署流程定义Id
	 * @throws SysException
	 */
	public void deleteProcessDefinition(String deploymentId)throws SysException{
		repositoryService.deleteDeployment(deploymentId, true);
	}
	
	
	
	/**
	 * 部署流程
	 * @param inputStream 流程文件输入流
	 * @throws SysException
	 */
	public void deployProcessDefinition(InputStream inputStream)throws SysException{
		ZipInputStream zis = new ZipInputStream(inputStream);
		repositoryService.createDeployment().addZipInputStream(zis).deploy();
	}
	
	/**
	 * 判断流程是否结束
	 * @param processInstanceId
	 * @return
	 * @throws SysException
	 */
	public boolean checkProcessIsFinish(String processInstanceId)throws SysException{
		HistoricProcessInstance historicProcessInstance =(HistoricProcessInstance)historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).finished().singleResult();
		return historicProcessInstance!=null;
	}
	
	/**
	 * 取得结束流程的流程定义
	 * @param processInstanceId
	 * @return
	 * @throws SysException
	 */
	public String getProcessDefinitionId(String processInstanceId)throws SysException{
		HistoricProcessInstance historicProcessInstance =(HistoricProcessInstance)historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
		return historicProcessInstance.getProcessDefinitionId();
	}
	
	/**
	 * 获得当前任务实例的所有者(候选人)
	 * @param processInstanceId
	 * @return 如果没找到返回一个长度为0的list
	 * @throws SysException
	 */
	public List<String> getOwners(String processInstanceId)throws SysException{
		Task task = taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();
		List<String> users = new ArrayList<String>();
		if(task != null){
			List<IdentityLink> is = taskService.getIdentityLinksForTask(task.getId());
			for(IdentityLink i : is){
				users.add(i.getUserId());
			}
		}
		return users;
	}
	
	
	/**
	 * 返回流程图
	 * @param processDefinitionId 流程定义Id
	 * @return 图片的输入流
	 * @throws SysException
	 */
	public InputStream getProcessImg(String processDefinitionId)throws SysException{
		ProcessDefinition def=(ProcessDefinition)this.repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
		String diagramResourceName = def.getDiagramResourceName();
		InputStream imageStream = repositoryService.getResourceAsStream(
				def.getDeploymentId(), diagramResourceName);
		return imageStream;
	}
	
	/**
	 * 获取跟踪信息
	 * @param processInstanceId 流程实例ID
	 * @return
	 * @throws SysException
	 */
	public Map getProcessImgMap(String processInstanceId)throws SysException{
		Map map=new HashMap();
		try{
			ProcessInstance processInstance =(ProcessInstance)runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
			ProcessDefinition processDefinition=(ProcessDefinition)repositoryService.createProcessDefinitionQuery().processDefinitionId(processInstance.getProcessDefinitionId()).singleResult();
			
		    ProcessDefinitionImpl pdImpl = (ProcessDefinitionImpl) processDefinition;   
			String processDefinitionId = pdImpl.getId();// 流程标识
			ProcessDefinitionEntity def = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService).getDeployedProcessDefinition(processDefinitionId);   
			ActivityImpl actImpl = null;
			Execution execution =(Execution)runtimeService.createExecutionQuery().executionId(processInstanceId).singleResult();//执行实例
			Object property = PropertyUtils.getProperty(execution, "activityId");
			String activityId = "";
			if (property != null) {
				activityId = property.toString();
			}
			List activitiList = def.getActivities();// 获得当前任务的所有节点
			if(activitiList!=null&&activitiList.size()>0){
				for(int i=0;i<activitiList.size();i++){
					ActivityImpl activityImpl=(ActivityImpl)activitiList.get(i);
					String id = activityImpl.getId();  
					 if (id.equals(activityId)) {// 获得执行到那个节点   
		                    actImpl = activityImpl;   
		                    break;   
		                }   
				}
			}
			map.put("coordinateObj", actImpl);
			map.put("processDefinitionId", processDefinitionId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	
	
	/**
	 * 开启流程
	 * @param definitionKey 流程定义KEY
	 * @param bussiKey 业务ID
	 * @return 返回流程实例ID
	 * @throws SysException
	 */
	public String startProcessInstance(String definitionKey,String bussiKey,Map map)throws SysException{
		ProcessInstance processInstance=this.runtimeService.startProcessInstanceByKey(definitionKey, bussiKey,map);
		System.out.println("=================考勤流程正确开启===============");
		return processInstance.getId();
	}
	
	/**
	 * 删除流程实例
	 * @param instanceId
	 * @throws SysException
	 */
	public void deleteProcessInstance(String instanceId)throws SysException{
		this.runtimeService.deleteProcessInstance(instanceId, "审批退回删除流程实例");
	}
	
	/**
	 * 返回需要个人签署的任务
	 * @param personId
	 * @return
	 * @throws SysException
	 */
	public List getTaskAssgineeByPersonId(String personId)throws SysException{
		List list1=this.taskService.createTaskQuery().taskAssignee(personId).list();
		List list=this.taskService.createTaskQuery().taskCandidateUser(personId).list();
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				Task task=(Task)list.get(i);
				taskService.claim(task.getId(), personId);
			}
		}
		list1.addAll(list);
		return list1;
	}
	
	/**
	 * 根据流程实例返回第一个任务
	 * @param instanceId
	 * @return
	 * @throws SysException
	 */
	public Task getTaskByInstanceId(String instanceId)throws SysException{
		Task task=(Task)this.taskService.createTaskQuery().processInstanceId(instanceId).singleResult();
		return task;
	}
	
	/**
	 * 完成任务
	 * @param taskId 任务标识
	 * @param map
	 * @throws SysException
	 */
	public void completeTask(String taskId,Map map)throws SysException{
		taskService.complete(taskId, map);
	}
	
	
	public RuntimeService getRuntimeService() {
		return runtimeService;
	}
	public void setRuntimeService(RuntimeService runtimeService) {
		this.runtimeService = runtimeService;
	}
	public TaskService getTaskService() {
		return taskService;
	}
	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}
	public RepositoryService getRepositoryService() {
		return repositoryService;
	}
	public void setRepositoryService(RepositoryService repositoryService) {
		this.repositoryService = repositoryService;
	}
	public HistoryService getHistoryService() {
		return historyService;
	}
	public void setHistoryService(HistoryService historyService) {
		this.historyService = historyService;
	}
	
}
