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
	 * �����������̶���
	 * @param selAll true�������а汾  false�������°汾
	 * @return
	 */
	public List getProcessDefinitionList(boolean selAll)throws SysException{
		if(selAll){
			return repositoryService.createProcessDefinitionQuery().list();
		}
		return repositoryService.createProcessDefinitionQuery().latestVersion().list();
	}
	
	/**
	 * ����ɾ���������̶���
	 * @param deploymentId �������̶���Id
	 * @throws SysException
	 */
	public void deleteProcessDefinition(String deploymentId)throws SysException{
		repositoryService.deleteDeployment(deploymentId, true);
	}
	
	
	
	/**
	 * ��������
	 * @param inputStream �����ļ�������
	 * @throws SysException
	 */
	public void deployProcessDefinition(InputStream inputStream)throws SysException{
		ZipInputStream zis = new ZipInputStream(inputStream);
		repositoryService.createDeployment().addZipInputStream(zis).deploy();
	}
	
	/**
	 * �ж������Ƿ����
	 * @param processInstanceId
	 * @return
	 * @throws SysException
	 */
	public boolean checkProcessIsFinish(String processInstanceId)throws SysException{
		HistoricProcessInstance historicProcessInstance =(HistoricProcessInstance)historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).finished().singleResult();
		return historicProcessInstance!=null;
	}
	
	/**
	 * ȡ�ý������̵����̶���
	 * @param processInstanceId
	 * @return
	 * @throws SysException
	 */
	public String getProcessDefinitionId(String processInstanceId)throws SysException{
		HistoricProcessInstance historicProcessInstance =(HistoricProcessInstance)historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
		return historicProcessInstance.getProcessDefinitionId();
	}
	
	/**
	 * ��õ�ǰ����ʵ����������(��ѡ��)
	 * @param processInstanceId
	 * @return ���û�ҵ�����һ������Ϊ0��list
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
	 * ��������ͼ
	 * @param processDefinitionId ���̶���Id
	 * @return ͼƬ��������
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
	 * ��ȡ������Ϣ
	 * @param processInstanceId ����ʵ��ID
	 * @return
	 * @throws SysException
	 */
	public Map getProcessImgMap(String processInstanceId)throws SysException{
		Map map=new HashMap();
		try{
			ProcessInstance processInstance =(ProcessInstance)runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
			ProcessDefinition processDefinition=(ProcessDefinition)repositoryService.createProcessDefinitionQuery().processDefinitionId(processInstance.getProcessDefinitionId()).singleResult();
			
		    ProcessDefinitionImpl pdImpl = (ProcessDefinitionImpl) processDefinition;   
			String processDefinitionId = pdImpl.getId();// ���̱�ʶ
			ProcessDefinitionEntity def = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService).getDeployedProcessDefinition(processDefinitionId);   
			ActivityImpl actImpl = null;
			Execution execution =(Execution)runtimeService.createExecutionQuery().executionId(processInstanceId).singleResult();//ִ��ʵ��
			Object property = PropertyUtils.getProperty(execution, "activityId");
			String activityId = "";
			if (property != null) {
				activityId = property.toString();
			}
			List activitiList = def.getActivities();// ��õ�ǰ��������нڵ�
			if(activitiList!=null&&activitiList.size()>0){
				for(int i=0;i<activitiList.size();i++){
					ActivityImpl activityImpl=(ActivityImpl)activitiList.get(i);
					String id = activityImpl.getId();  
					 if (id.equals(activityId)) {// ���ִ�е��Ǹ��ڵ�   
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
	 * ��������
	 * @param definitionKey ���̶���KEY
	 * @param bussiKey ҵ��ID
	 * @return ��������ʵ��ID
	 * @throws SysException
	 */
	public String startProcessInstance(String definitionKey,String bussiKey,Map map)throws SysException{
		ProcessInstance processInstance=this.runtimeService.startProcessInstanceByKey(definitionKey, bussiKey,map);
		System.out.println("=================����������ȷ����===============");
		return processInstance.getId();
	}
	
	/**
	 * ɾ������ʵ��
	 * @param instanceId
	 * @throws SysException
	 */
	public void deleteProcessInstance(String instanceId)throws SysException{
		this.runtimeService.deleteProcessInstance(instanceId, "�����˻�ɾ������ʵ��");
	}
	
	/**
	 * ������Ҫ����ǩ�������
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
	 * ��������ʵ�����ص�һ������
	 * @param instanceId
	 * @return
	 * @throws SysException
	 */
	public Task getTaskByInstanceId(String instanceId)throws SysException{
		Task task=(Task)this.taskService.createTaskQuery().processInstanceId(instanceId).singleResult();
		return task;
	}
	
	/**
	 * �������
	 * @param taskId �����ʶ
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
