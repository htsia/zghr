
package com.hr319wg.custom.attence.dao;

import java.util.List;

import com.hr319wg.attence.util.DateUtil;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.pojo.bo.AttLeaveBO;
import com.hr319wg.custom.attence.pojo.bo.AttOutBO;
import com.hr319wg.custom.attence.pojo.bo.AttOvertimeBO;
import com.hr319wg.custom.attence.pojo.bo.AttRestBO;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.attence.pojo.bo.AttDurationBO;
public class AttBusiDAO extends BaseDAO{

	public int isAttIssue(String dualID, String yearMonth){
		String hql = "select bo from AttDurationBO bo where bo.createDate='"+yearMonth+"'";
		return 0;
	}
	
	public List getAllAttClassUserBOByClassID(String classID) throws SysException{
		String hql = "select bo from AttClassUserBO bo where bo.classID='"+classID+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	public List getAllAttPutoffDataBO(PageVO pageVO, String orgID, String nameStr, String personType) throws SysException{
		//String hql = " from a236 ";
		String hql = " from AttPutoff2BO bo,UserBO u where u.userID=bo.id ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		//String boHql = "select * "+hql +" order by id";
		String boHql = "select bo,u.secDeptID "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}

	public List getAllAttClassUserBOByClassID(PageVO pageVO, String orgID, String nameStr, String personType, String classID) throws SysException{
		String hql = " from AttClassUserBO bo,UserBO u where u.userID=bo.userID and bo.classID='"+classID+"'";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		String boHql = "select bo "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}
	
	public List getAllAttLeaveBO(String userID, String beginDate, String endDate) throws SysException{
		String hql = "select bo from AttLeaveBO bo where bo.personId= '"+userID+"' and bo.beginTime>='"+beginDate+"' and bo.endTime<='"+endDate+"'";
		return this.hibernatetemplate.find(hql);
	}
	/**获得所有请假条，这些请假条跨过了  开始时间到结束时间里面的某些天
	 * 主要为了辅助完成月统计
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List getAllAttLeaveBO(String beginDate,String endDate){
		String hql="select bo from AttLeaveBO bo where  bo.beginTime<='"+endDate+"' and bo.endTime>='"+beginDate+"'";
		return this.hibernatetemplate.find(hql);
	}
	public List getAllAttOutBO(String userID, String beginDate, String endDate) throws SysException{
		String hql = "select bo from AttOutBO bo where bo.personId= '"+userID+"' and bo.beginTime>='"+beginDate+"' and bo.endTime<='"+endDate+"'";
		return this.hibernatetemplate.find(hql);
	}
	public List getAllAttOvertimeBO(String userID, String beginDate, String endDate) throws SysException{
		String hql = "select bo from AttOvertimeBO bo where bo.personId= '"+userID+"' and bo.beginTime>='"+beginDate+"' and bo.endTime<='"+endDate+"'";
		return this.hibernatetemplate.find(hql);
	}
	public List getAllAttRestBO(String userID, String beginDate, String endDate) throws SysException{
		String hql = "select bo from AttRestBO bo where bo.personId= '"+userID+"' and bo.beginTime>='"+beginDate+"' and bo.endTime<='"+endDate+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	public List getAllAttMonthBO(String userID, String yearMonth) throws SysException{
		String hql = "select bo from AttMonthBO bo where bo.personId ='"+userID+"' and bo.attenceDate='"+yearMonth+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	public List getAllAttMonthBO(PageVO pageVO, String orgID, String nameStr, String personType, String yearMonth, String[]userIDs) throws SysException{
		String hql = " from AttMonthBO bo,UserBO u where u.userID=bo.personId and bo.attenceDate='"+yearMonth+"' and "+CommonFuns.splitInSql(userIDs, "bo.personId");
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		String boHql = "select bo "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}
	//显示一段时间内的月汇总记录(分月分条显示)
	public List getAndShowAllAttMonthBO(PageVO pageVO, String orgID, String nameStr, String personType, String beginYearMonth, String endYearMonth, String inself, String operUserID) throws SysException{
		
		if(beginYearMonth==null||"".equals(beginYearMonth)){
			beginYearMonth="1900-01";
		}
		if(endYearMonth==null||"".equals(endYearMonth)){
			endYearMonth="2300-12";
		}
		String hql = " from AttMonthBO bo,UserBO u where u.userID=bo.personId and to_date(bo.attenceDate,'yyyy-MM')>=to_date('"+beginYearMonth+"','yyyy-MM') and " +
				"to_date(bo.attenceDate,'yyyy-MM')<=to_date('"+endYearMonth+"','yyyy-MM') ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if("1".equals(inself)){
			hql += " and u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%'";
		}
		String boHql = "select bo "+hql +" order by u.userID";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}
	
	public List<UserBO> getAllCurrApprover(String[]userIDs) throws SysException{
		String hql = "select bo from UserBO bo where "+CommonFuns.splitInSql(userIDs, "bo.userID");
		return this.hibernatetemplate.find(hql);
	}
	
	public List getCurrAttDurationBO() throws SysException{
		String hql = "select bo from AttDurationBO bo where bo.status=1";
		return this.hibernatetemplate.find(hql);
	}
	
	public List getAllVerifyAttMonthBO(PageVO pageVO, String orgID, String nameStr, String personType, String yearMonth) throws SysException{
		String hql = " from AttMonthBO bo,UserBO u where u.userID=bo.personId and bo.attenceDate='"+yearMonth+"' and (bo.status = 0 or bo.isDimission='1')";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		String boHql = "select bo "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}
	public List getAllAttMonthBOByOrgIDs(PageVO pageVO, String orgID, String nameStr, String personType, String yearMonth, String inself, String operUserID) throws SysException{
		String hql = " from AttMonthBO bo,UserBO u where u.userID=bo.personId and bo.attenceDate='"+yearMonth+"' and bo.status is null ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if("1".equals(inself)){
			hql += " and u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%'";
		}
		String boHql = "select bo,u.secDeptID "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}
	
	public List getAllFingerInfo(PageVO pageVO, String orgID, String nameStr, String personType, boolean collected, boolean uncollected, boolean hasPwd, boolean notHasPwd) throws SysException{
		String hql = " from AttFingerBO bo,UserBO u where u.userID=bo.ID ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if(!(collected && uncollected)){
			if(collected){
				hql += " and (bo.finger0 is not null or bo.finger1 is not null or bo.finger2 is not null or bo.finger3 is not null or bo.finger4 is not null or bo.finger5 is not null" +
						" or bo.finger6 is not null or bo.finger7 is not null or bo.finger8 is not null or bo.finger9 is not null)";
			}
			if(uncollected){
				hql += " and (bo.finger0 is null and bo.finger1 is null and bo.finger2 is null and bo.finger3 is null and bo.finger4 is null and bo.finger5 is null" +
						" and bo.finger6 is null and bo.finger7 is null and bo.finger8 is null and bo.finger9 is null)";
			}
		}
		if(!(hasPwd && notHasPwd)){
			if(hasPwd){
				hql += " and (bo.password is not null)";
			}
			if(notHasPwd){
				hql += " and (bo.password is null)";
			}
		}
		String boHql = "select bo,u.secDeptID "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}
	
	public List getMasterMachineBO() throws SysException{
		String hql = "select bo from AttMachineBO bo where bo.machineType=0";
		return this.hibernatetemplate.find(hql);
	}
	public List getMasterMachineBOExcludeSelf(String ip) throws SysException{
		String hql = "select bo from AttMachineBO bo where bo.machineType=0 and bo.machineIP<>'"+ip+"'";
		return this.hibernatetemplate.find(hql);
	}
	public List getAllMachineBO(PageVO pageVo, String machineType) throws SysException{
		String hql = " from AttMachineBO bo ";
		if("1".equals(machineType)){
			hql += " where bo.machineType=1 ";
		}else if("0".equals(machineType)){
			hql += " where bo.machineType=0 ";			
		}
		String boHql = "select bo "+hql +" order by bo.machineType";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVo, countHql, boHql);
	}
	public List getAllAttMachineBO() throws SysException{
		String hql = "select bo from AttMachineBO bo";
		return this.hibernatetemplate.find(hql);
	}
	public List getAllMachineBOByIPs(String IPs) throws SysException{
		String[]ips=IPs.split(",");
		String hql = "select bo from AttMachineBO bo where "+CommonFuns.splitInSql(ips, "bo.machineIP");
		return this.hibernatetemplate.find(hql);
	}
	
	public List getAllLogBO(PageVO pageVo, String orgID,String nameStr, String personType, String createType,String beginDate,String endDate) throws SysException{
		String hql = " from AttenceLogBO log,UserBO u where u.userID=log.personId ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if(createType!=null && !"".equals(createType)){
			hql += " and log.registerCard=1";
		}
		if(beginDate!=null && !"".equals(beginDate)){
			hql += " and (to_date(log.cardDate,'yyyy-mm-dd')>=to_date('"+beginDate+"','yyyy-mm-dd') ) ";
		}
		if(endDate!=null && !"".equals(endDate)){
			hql += " and (to_date(log.cardDate,'yyyy-mm-dd')<=to_date('"+endDate+"','yyyy-mm-dd') ) ";
		}
		String boHql = "select log,u.secDeptID "+hql +" order by log.cardDate desc,log.cardTime desc,u.secDeptID,u.deptId,u.userID";
		String countHql = "select count(u) "+hql;
		return this.pageQuery(pageVo, countHql, boHql);
	}
	
	//请假查询
	public List getAttLeaveBO(PageVO pagevo, String personId, String[] status, String beginDate, String endDate, String orgID, String personType, String nameStr, String createType, String inself, String isManager, String operUserID, boolean myAtt)throws SysException{
		String hql="from AttLeaveBO bo,UserBO u where u.userID=bo.personId ";
		if(personId!=null&&!"".equals(personId)){
			hql+=" and bo.personId='"+personId+"'";
		}
		if(status.length>0){
			hql+=" and "+CommonFuns.splitInSql(status,"bo.status");
		}else{
			hql+=" and 1=0 ";			
		}
		if(myAtt){
			hql+=" and bo.personId='"+operUserID+"' ";			
		}
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if(beginDate!=null && !"".equals(beginDate)){
			hql += " and bo.beginTime>='"+beginDate+"'";
		}
		if(endDate!=null && !"".equals(endDate)){
			hql += " and bo.beginTime<'"+DateUtil.getNextDate(endDate)+"'";
		}
		if(createType!=null && !"".equals(createType)){
			hql += " and bo.createType='"+createType+"'";
		}
		if("1".equals(inself)){//在自助平台
			int role = CommonUtil.getRoleCount("5a9ded4739e906c70139f6e9dc170242", operUserID);
			String postIDs = CommonUtil.getAllSubPostIDs(operUserID);
			
			if(isManager==null && role==0){//不是管理员且不是秘书
				if(postIDs==null || "".equals(postIDs)){//没有下级岗位
					hql += " and (bo.personId='"+operUserID+"' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttLeaveBO", operUserID)+"))";
				}else{
					hql += " and ("+CommonFuns.splitInSql(postIDs.split(","), "u.postId")+" or bo.personId='"+operUserID+"' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttLeaveBO", operUserID)+"))";				
				}
			}else if(role==1 && postIDs!=null && !"".equals(postIDs)){//是秘书且有下级岗位
				hql += " and ("+CommonFuns.splitInSql(postIDs.split(","), "u.postId")+" or u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttLeaveBO", operUserID)+"))";							
			}else if(role==1){//是秘书
				hql += " and u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%'";										
			}
		}
		String countHql="select count(bo) "+hql;
		hql = "select bo "+hql+" order by bo.applyTime desc,u.secDeptID,u.deptId";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql,hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
	//公出查询
	public List getAttOutBO(PageVO pagevo, String personId, String[] status, String beginDate, String endDate, String orgID, String personType, String nameStr, String createType, String inself, String isManager, String operUserID, boolean myAtt)throws SysException{
		String hql="from AttOutBO bo,UserBO u where u.userID=bo.personId ";
		if(personId!=null&&!"".equals(personId)){
			hql+=" and bo.personId='"+personId+"'";
		}
		if(status.length>0){
			hql+=" and "+CommonFuns.splitInSql(status,"bo.status");
		}else{
			hql+=" and 1=0 ";			
		}
		if(myAtt){
			hql+=" and bo.personId='"+operUserID+"' ";			
		}
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if(beginDate!=null && !"".equals(beginDate)){
			hql += " and bo.beginTime>='"+beginDate+"'";
		}
		if(endDate!=null && !"".equals(endDate)){
			hql += " and bo.beginTime<'"+DateUtil.getNextDate(endDate)+"'";
		}
		if(createType!=null && !"".equals(createType)){
			hql += " and bo.createType='"+createType+"'";
		}
		if("1".equals(inself)){//在自助平台
			int role = CommonUtil.getRoleCount("5a9ded4739e906c70139f6e9dc170242", operUserID);
			String postIDs = CommonUtil.getAllSubPostIDs(operUserID);
			
			if(isManager==null && role==0){//不是管理员且不是秘书
				if(postIDs==null || "".equals(postIDs)){//没有下级岗位
					hql += " and (bo.personId='"+operUserID+"' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttOutBO", operUserID)+"))";
				}else{
					hql += " and ("+CommonFuns.splitInSql(postIDs.split(","), "u.postId")+" or bo.personId='"+operUserID+"' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttLeaveBO", operUserID)+"))";				
				}
			}else if(role==1 && postIDs!=null && !"".equals(postIDs)){//是秘书且有下级岗位
				hql += " and ("+CommonFuns.splitInSql(postIDs.split(","), "u.postId")+" or u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttLeaveBO", operUserID)+"))";							
			}else if(role==1){//是秘书
				hql += " and u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%'";										
			}
		}
		String countHql="select count(bo) "+hql;
		hql = "select bo "+hql+"order by bo.applyTime desc,u.secDeptID,u.deptId";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql,hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
	//加班查询
	public List getAttOvertimeBO(PageVO pagevo, String personId, String[] status, String beginDate, String endDate, String orgID, String personType, String nameStr, String createType, String inself, String isManager, String operUserID, boolean myAtt)throws SysException{
		String hql="from AttOvertimeBO bo,UserBO u where u.userID=bo.personId ";
		if(personId!=null&&!personId.equals("")){
			hql+=" and bo.personId='"+personId+"'";
		}
		if(status.length>0){
			hql+=" and "+CommonFuns.splitInSql(status,"bo.status");
		}else{
			hql+=" and 1=0 ";			
		}
		if(myAtt){
			hql+=" and bo.personId='"+operUserID+"' ";			
		}
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if(beginDate!=null && !"".equals(beginDate)){
			hql += " and bo.beginTime>='"+beginDate+"'";
		}
		if(endDate!=null && !"".equals(endDate)){
			hql += " and bo.beginTime<'"+DateUtil.getNextDate(endDate)+"'";
		}
		if(createType!=null && !"".equals(createType)){
			hql += " and bo.createType='"+createType+"'";
		}
		if("1".equals(inself)){//在自助平台
			int role = CommonUtil.getRoleCount("5a9ded4739e906c70139f6e9dc170242", operUserID);
			String postIDs = CommonUtil.getAllSubPostIDs(operUserID);
			
			if(isManager==null && role==0){//不是管理员且不是秘书
				if(postIDs==null || "".equals(postIDs)){//没有下级岗位
					hql += " and (bo.personId='"+operUserID+"' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttOvertimeBO", operUserID)+"))";
				}else{
					hql += " and ("+CommonFuns.splitInSql(postIDs.split(","), "u.postId")+" or bo.personId='"+operUserID+"' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttLeaveBO", operUserID)+"))";				
				}
			}else if(role==1 && postIDs!=null && !"".equals(postIDs)){//是秘书且有下级岗位
				hql += " and ("+CommonFuns.splitInSql(postIDs.split(","), "u.postId")+" or u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttLeaveBO", operUserID)+"))";							
			}else if(role==1){//是秘书
				hql += " and u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%'";										
			}
		}
		String countHql="select count(bo) "+hql;
		hql = "select bo "+hql+"order by bo.applyTime desc,u.secDeptID,u.deptId";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql,hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
	//调休查询
	public List getAttRestBO(PageVO pagevo, String personId, String[] status, String beginDate, String endDate, String orgID, String personType, String nameStr, String createType, String inself, String isManager, String operUserID, boolean myAtt)throws SysException{
		String hql="from AttRestBO bo,UserBO u where u.userID=bo.personId ";
		if(personId!=null&&!personId.equals("")){
			hql+=" and bo.personId='"+personId+"'";
		}
		if(status.length>0){
			hql+=" and "+CommonFuns.splitInSql(status,"bo.status");
		}else{
			hql+=" and 1=0 ";			
		}
		if(myAtt){
			hql+=" and bo.personId='"+operUserID+"' ";			
		}
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if(beginDate!=null && !"".equals(beginDate)){
			hql += " and bo.beginTime>='"+beginDate+"'";
		}
		if(endDate!=null && !"".equals(endDate)){
			hql += " and bo.beginTime<'"+DateUtil.getNextDate(endDate)+"'";
		}
		if(createType!=null && !"".equals(createType)){
			hql += " and bo.createType='"+createType+"'";
		}
		if("1".equals(inself)){//在自助平台
			int role = CommonUtil.getRoleCount("5a9ded4739e906c70139f6e9dc170242", operUserID);
			String postIDs = CommonUtil.getAllSubPostIDs(operUserID);
			
			if(isManager==null && role==0){//不是管理员且不是秘书
				if(postIDs==null || "".equals(postIDs)){//没有下级岗位
					hql += " and (bo.personId='"+operUserID+"' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttRestBO", operUserID)+"))";
				}else{
					hql += " and ("+CommonFuns.splitInSql(postIDs.split(","), "u.postId")+" or bo.personId='"+operUserID+"' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttLeaveBO", operUserID)+"))";				
				}
			}else if(role==1 && postIDs!=null && !"".equals(postIDs)){//是秘书且有下级岗位
				hql += " and ("+CommonFuns.splitInSql(postIDs.split(","), "u.postId")+" or u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%' or bo.personId in ("+CommonUtil.getHQLAllAttLog("AttLeaveBO", operUserID)+"))";							
			}else if(role==1){//是秘书
				hql += " and u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%'";										
			}
		}
		String countHql="select count(bo) "+hql;
		hql = "select bo "+hql+"order by bo.applyTime desc,u.secDeptID,u.deptId";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql,hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
	
	public AttLeaveBO findAttLeaveBOByProcessInstanceId(String processId)throws SysException{
		String hql="select bo from AttLeaveBO bo where bo.processId='"+processId+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (AttLeaveBO)list.get(0);
		}
		return null;
	}
	public AttOutBO findAttOutBOByProcessInstanceId(String processId)throws SysException{
		String hql="select bo from AttOutBO bo where bo.processId='"+processId+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (AttOutBO)list.get(0);
		}
		return null;
	}
	public AttOvertimeBO findAttOvertimeBOByProcessInstanceId(String processId)throws SysException{
		String hql="select bo from AttOvertimeBO bo where bo.processId='"+processId+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (AttOvertimeBO)list.get(0);
		}
		return null;
	}
	public AttRestBO findAttRestBOByProcessInstanceId(String processId)throws SysException{
		String hql="select bo from AttRestBO bo where bo.processId='"+processId+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (AttRestBO)list.get(0);
		}
		return null;
	}
	
	
	public List getAttLogBOById(String leaveId)throws SysException{
		String hql="select bo from AttLogBO bo where bo.leaveId='"+leaveId+"'";
		return this.hibernatetemplate.find(hql);
	}
	//获取加班费子集的数据
	public List getOvertimePayBO(PageVO pageVO, String orgID, String nameStr, String personType,String yearMonth) throws SysException{
		//String hql = " from a243 ";
		String hql = " from AttOvertimePayBO bo,UserBO u where u.userID=bo.userID ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if(yearMonth!=null&&!"".equals(yearMonth)){
			hql+=" and bo.yearMonth ='"+yearMonth+"'";
		}
		//String boHql = "select * "+hql +" order by id";
		String boHql = "select bo,u.secDeptID "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}
	//获取年出勤数据
	public List getYearBO(PageVO pageVO, String orgID, String nameStr, String personType,String yearStr) throws SysException{
		//String hql = " from a236 ";
		String hql = " from AttYearBO bo,UserBO u where u.userID=bo.id ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}

		if(yearStr!=null&&!"".equals(yearStr)){
			hql+= " and bo.year='"+yearStr+"'";
		}
		String boHql = "select bo,u.secDeptID "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}
	//获取临时考勤统计数据
	public List getAttTempDataBO(PageVO pageVO, String orgID, String nameStr, String personType) throws SysException{
		String hql = " from AttTempDataBO bo,UserBO u where u.userID=bo.id ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		
		if(personType!=null && !"".equals(personType)){			
			String[]types = personType.split(",");
			hql += " and "+CommonFuns.splitInSql(types, "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '"+nameStr+"')";
		}
		String boHql = "select bo,u.secDeptID "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(*) "+hql;
		return this.pageQuery(pageVO, countHql, boHql);
	}
	//获取临时考勤统计数据(邮件用)
	public List getAttTempDataBO(String orgID, String nameStr, String personType, String selectedUserIDs) throws SysException{
		String hql = "select u.OAName,bo.attDetail from AttTempDataBO bo,UserBO u where u.userID=bo.id";
		if(selectedUserIDs==null || "".equals(selectedUserIDs)){
			if(orgID!=null && !"".equals(orgID)){
				OrgBO org = SysCacheTool.findOrgById(orgID);
				hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
			}
			
			if(personType!=null && !"".equals(personType)){			
				String[]types = personType.split(",");
				hql += " and "+CommonFuns.splitInSql(types, "u.personType");
			}
			if(nameStr!=null && !"".equals(nameStr)){
				hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '"+nameStr+"')";
			}
		}else{
			hql += " and "+CommonFuns.splitInSql(selectedUserIDs.split(","), "u.userID");
		}
		return this.hibernatetemplate.find(hql);
	}

	public AttDurationBO getAttDurationBOById(String id) {
		// TODO Auto-generated method stub
		String hql="from AttDurationBO bo where bo.duraID='"+id+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list.size()>0){
			return (AttDurationBO) list.get(0);
		}else{
			return null;
		}
	}
	//获取某人某月的请假列表
	public List<AttLeaveBO> getAttDetailForSomebody(String personId,String yearMonth){
		String beginDate= yearMonth+"-"+"01";
		String endDate= yearMonth+"-"+DateUtil.getEndDayByMonth(yearMonth);
		String hql="select bo from AttLeaveBO bo,UserBO u where u.userID=bo.personId and bo.personId='"+personId+"' " +
				"and bo.beginTime<'"+endDate+"' and bo.endTime>'"+beginDate+"' ";
		return (List<AttLeaveBO>)this.hibernatetemplate.find(hql);
	}
}
