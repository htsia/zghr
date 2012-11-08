
package com.hr319wg.custom.wage.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.custom.wage.pojo.bo.WageDataSetBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class WageDataDAO extends BaseDAO{
	
	//获取超课时
	public List getAllClassWageBO(PageVO pageVo, String orgID, String personType, String nameStr, String operUserID, String inself) throws SysException{
		String hql = " from ClassWageBO bo,UserBO u where bo.userID=u.userID and bo.year='"+CommonFuns.getSysDate("yyyy")+"' ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if("1".equals(inself)){
			hql += " and bo.createUserID='"+operUserID+"'";
		}
		String boHql = "select bo,u "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(u) "+hql;
		
		return this.pageQuery(pageVo, countHql, boHql);
	}
	
	//获取管辖的帐套
	public List getAllWagesetBOByUserID(String operUserID) throws SysException{
		String sql = "select bo from WageSetBO bo where bo.operPersons like '%"+operUserID+"%'";
		return this.hibernatetemplate.find(sql);
	}
	
	
	//短期工
	public List getAllWageEmpUserBO(PageVO pageVo, boolean hasWage, boolean noWage, boolean hasCash, boolean hasNoCash, String orgID, String personType, String nameStr, String rightType, String inself, String operUserID) throws SysException{
		String hql = " from UserBO u where u.personType in ('0135700572','0135700573','0135700574') ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		if(!(hasWage && noWage)){
			if(hasWage){
				hql+=" and u.userID in (select w.ID from WageEmpBO w where w.wage is not null)";
			}
			if(noWage){
				hql+=" and u.userID in (select w.ID from WageEmpBO w where w.wage is null)";
			}
		}
		if(!hasWage && !noWage){
			hql+=" and 1=0 ";
		}
		if(!(hasCash && hasNoCash)){
			if(hasCash){
				hql+=" and u.hasCash='1'";
			}
			if(noWage){
				hql+=" and u.hasCash is null";
			}
		}
		if(!hasCash && !hasNoCash){
			hql+=" and 1=0 ";
		}
		
		if("1".equals(rightType)){
			hql += " and u.deptSort not like '001002011%'";			
		}else if("0".equals(rightType)){
			hql += " and u.deptSort like '001002011%'";						
		}else if("1".equals(inself)){
			hql += " and u.deptSort like '"+CommonUtil.getSecDeptTreeId(operUserID)+"%'";
		}
		String boHql = "select u "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(u) "+hql;
		
		return this.pageQuery(pageVo, countHql, boHql);
	}
	
	public List getAllWageDataSetBO(String yearMonth, String selectedItemIDs, String itemType) throws SysException{
		String[]itemIDs=selectedItemIDs.split(",");
		String hql ="select bo from WageDataSetBO bo where bo.itemType='"+itemType+"' and bo.status=1 " +
				"and (bo.excludeDate is null or bo.excludeDate not like '%"+yearMonth+"%') and bo.beginDate <='"+yearMonth+"' and bo.endDate >='"+yearMonth+"'" +
						" and "+CommonFuns.splitInSql(itemIDs, "bo.ID");
		return this.hibernatetemplate.find(hql);
	}
	
	public List getAllWageSetBO(String itemType, String wageDate){
		String hql = "select bo from WageDataSetBO bo where bo.itemType='"+itemType+"' and " +
				"bo.ID in (select r.setID from WageDataRecordBO r where r.yearMonth='"+wageDate+"')";
		return this.hibernatetemplate.find(hql);
	}
	
	public List getWageOtherItemDetail(String itemType, String itemID, String wageDate, String userID, String wageSetID) throws SysException{
		String hql ="select bo from WageDataRecordBO bo,UserBO u where bo.userID=u.userID and bo.setID='"+itemID+"' and bo.yearMonth='"+wageDate+"'";
		if(userID!=null){
			hql += " and bo.ID ='"+userID+"'";	
		}else{
			hql += " and bo.userID in (select bo.ID from WageSetPersonBO bo,WageSetBO w where bo.wageSetID=w.setId and w.setId='"+wageSetID+"') ";
		}
		if(itemType!=null){
			hql+= " and bo.ID in (select concat(v.datasetUserID,'"+wageDate+"') from WageDataSetVerifyBO v where v.status=1 and v.yearMonth='"+wageDate+"') order by u.secDeptID,u.deptId";						
		}
		return this.hibernatetemplate.find(hql);
	}
	
	
	public List getWageLitleItemDetail(String itemType, String wageDate, String userID, String wageSetID) throws SysException{
		//1加班费、2车公里补贴、3扣其他1、4扣其他2、5科研费
		String set = "";
		if("1".equals(itemType)){
			set = "WageOvertimeBO";
		}else if("2".equals(itemType)){
			set = "WageCarBO";
		}else if("3".equals(itemType)){
			set = "WageKouOther1BO";			
		}else if("4".equals(itemType)){
			set = "WageKouOther2BO";			
		}else if("5".equals(itemType)){
			set = "WageScienceBO";			
		}
		String hql = "select bo from "+set+" bo,UserBO u where bo.ID=u.userID and bo.status =2 ";
		if(userID!=null){
			hql += " and bo.ID ='"+userID+"'";						
		}else{
			hql += " and bo.ID in (select bo.ID from WageSetPersonBO bo,WageSetBO w where bo.wageSetID=w.setId and w.setId='"+wageSetID+"') order by u.secDeptID,u.deptId";			
		}
		
		return this.hibernatetemplate.find(hql);
	}
	
	//获取加班费、档案管理费人员
	public List getAllWageLitleUserBO(PageVO pageVo, String itemType, String orgID, String personType, String nameStr, String operUserID) throws SysException{
		//1加班费、2车公里补贴、3扣其他1、4扣其他2、5科研费
		String set = "";
		if("1".equals(itemType)){
			set = "WageOvertimeBO";
		}else if("2".equals(itemType)){
			set = "WageCarBO";			
		}else if("3".equals(itemType)){
			set = "WageKouOther1BO";			
		}else if("4".equals(itemType)){
			set = "WageKouOther2BO";			
		}else if("5".equals(itemType)){
			set = "WageScienceBO";			
		}
		String hql = " from "+set+" bo,UserBO u where bo.ID=u.userID and bo.status in ('1','2')";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
//		hql += " and bo.ID in ("+CommonUtil.getHQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		
		String boHql = "select bo "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(bo) "+hql;
		
		return this.pageQuery(pageVo, countHql, boHql);
	}
	
	public List getWageSigleDetail(String itemType){
		String setBO=null;
		if("1".equals(itemType)){
			setBO="WageNuanqiBO";
		}else if("2".equals(itemType)){
			setBO="WageFangzuBO";
		}else if("3".equals(itemType)){
			setBO="WageFangbuBO";
		}
		
		String hql = "select bo from "+setBO+" bo where bo.money is not null or bo.money<>0";
		return this.hibernatetemplate.find(hql);
	}
	public List getWageSetDetail(String setID){
		String hql ="select bo from WageDataSetUserBO bo where bo.setID='"+setID+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	//获取其他1其他2捐款项目
	public List getAllWageDataSetBOByUserID(PageVO pageVo, String createUserID, String itemType, String beginDate, String endDate, String[]status, String operUserID) throws SysException{
		String hql = " from WageDataSetBO bo1 where bo1.itemType='"+itemType+"' and ( bo1.selfstatus is null or (bo1.selfstatus='1' and bo1.createUserID='"+createUserID+"'))";
		
		if(beginDate!=null && !"".equals(beginDate)){
			hql+=" and bo1.createDate>='"+beginDate+"'";
		}
		if(endDate!=null && !"".equals(endDate)){
			hql+=" and bo1.createDate<='"+endDate+"'";
		}
		if(status!=null && status.length>0){
			hql+=" and "+CommonFuns.splitInSql(status, "bo1.status");
		}
		hql+=" and (bo1.createUserID='"+createUserID+"' or bo1.ID in (select u.setID from WageDataSetUserBO u where u.userID in ("+CommonUtil.getHQLAllWageSetPersonIDsByOperUserID(operUserID)+")))";
		
		String boHql = "select bo1 "+hql+" order by bo1.createDate desc";
		String countHql = "select count(*) "+hql;
        return this.pageQuery(pageVo, countHql, boHql);
	}

	
	//获取人员设置人员
	public List getAllWageDataSetUserBO(PageVO pageVo, WageDataSetBO item, String orgID, String personType, String nameStr, String inself, String operUserID) throws SysException{
		String hql = " from WageDataSetUserBO bo,UserBO u,User p where bo.userID=u.userID and p.userId=u.userID and p.status=1 and bo.setID='"+item.getID()+"'";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}

		String boHql = "select bo,u.secDeptID "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(bo) "+hql;
		
		return this.pageQuery(pageVo, countHql, boHql);
	}
	
	//获取审核人员
	public List getAllWageDataSetUserBOByInfo(PageVO vo, String yearMonth, String selectedItemIDs, String orgID, String itemType, String personType, String nameStr, String operUserID) throws SysException{
		String hql = " from WageDataSetUserBO bo,UserBO u,WageDataSetBO s,User p where bo.userID=u.userID and p.userId=u.userID and p.status=1 and " +CommonFuns.splitInSql(selectedItemIDs.split(","), "s.ID")+
				" and bo.setID=s.ID and s.status in (1,2) and s.itemType='"+itemType+"' and '"+yearMonth+"' between s.beginDate and s.endDate and nvl(instr(s.excludeDate,'"+yearMonth+"'),0)=0";
						
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){			
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		hql += " and bo.userID in ("+CommonUtil.getHQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		
		String boHql = "select bo,s.name "+hql + " order by s.createDate,u.deptId";
		String countHql = "select count(bo) "+hql;
		return this.pageQuery(vo, countHql, boHql);
	}

	/**
	 * 单记录人员
	 * @param pageVo
	 * @param orgID
	 * @param itemType
	 * @param isVerify
	 * @param yearMonth
	 * @param personType
	 * @param nameStr
	 * @param verifyFlag
	 * @return
	 * @throws SysException
	 */
	public List getAllWageDateSigleBO(PageVO pageVo, String orgID, String itemType, String isVerify, String yearMonth, String personType, String nameStr, boolean verifyFlag, String inself, String operUserID) throws SysException{
		String setBO=null;
		if("1".equals(itemType)){
			setBO="WageNuanqiBO";
		}else if("2".equals(itemType)){
			setBO="WageFangzuBO";
		}else if("3".equals(itemType)){
			setBO="WageFangbuBO";
		}
		
		String hql = " from "+setBO+" bo,UserBO u,User p where bo.id=u.userID and p.userId=u.userID and p.status=1";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if("1".equals(isVerify) || verifyFlag){
			hql+=" and bo.modifyDate='"+yearMonth+"' ";
		}
		if(personType!=null && !"".equals(personType)){			
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		//业务平台只能看到所管辖帐套人员
		if(!"1".equals(inself)){
			hql += " and bo.ID in ("+CommonUtil.getHQLAllWageSetPersonIDsByOperUserID(operUserID)+")";			
		}
		String boHql = "select bo.ID,bo.money,bo.modifyMoney,bo.modifyDate "+hql +" order by u.secDeptID,u.deptId";;
		String countHql = "select count(bo) "+hql;
		return this.pageQuery(pageVo, countHql, boHql);
	}

	public List getAllWageOthersDataSetBOByUserID(PageVO pageVo, String operUserID, String beginDate, String endDate, boolean notReview, boolean Reviewed) throws SysException{
		String hql = " from WageOthersDataSetBO bo where 1=1 ";
		if(beginDate!=null && !"".equals(beginDate)){
			hql+=" and bo.createDate>='"+beginDate+"'";
		}
		if(endDate!=null && !"".equals(endDate)){
			hql+=" and bo.createDate<='"+endDate+"'";
		}
		//显示所有的
		if(notReview && Reviewed){
			hql+=" and bo.status in ('0','2') ";			
		}else if(notReview){
			hql+=" and bo.status='0' ";
		}else if(Reviewed){
			hql+=" and bo.status='2' ";
		}
		hql+=" and (bo.createUserID='"+operUserID+"' or bo.ID in (select u.setID from WageOthersDataSetUserBO u where u.userID in ("+CommonUtil.getHQLAllWageSetPersonIDsByOperUserID(operUserID)+")))";
		String boHql = "select bo "+hql+" order by bo.createDate desc";
		String countHql = "select count(*) "+hql;
        return this.pageQuery(pageVo, countHql, boHql);
	}
	public List getAllWageOthersDataSetUserBO(PageVO pageVo, String setID, String orgID, String personType, String nameStr, String operUserID) throws SysException{
		String hql = " from WageOthersDataSetUserBO bo,UserBO u where bo.userID=u.userID and bo.setID='"+setID+"'";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){			
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		hql += " and bo.userID in ("+CommonUtil.getHQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		
		String boHql = "select bo "+hql ;
		String countHql = "select count(bo) "+hql;
		
		return this.pageQuery(pageVo, countHql, boHql);
	}
	
	public List getAllWageOthersDataSetUserBOByInfo(PageVO vo, String yearMonth, String orgID, String personType, String nameStr) throws SysException{
		String hql = " from WageOthersDataSetUserBO bo,UserBO u,WageDataSetBO s,User p where bo.userID=u.userID and p.userId=u.userID and p.status=1" +
				" and bo.setID=s.ID and s.status in ('1','2') and '"+yearMonth+"' between s.beginDate and s.endDate and nvl(instr(s.excludeDate,'"+yearMonth+"'),0)=0" +
						" and bo.ID not in (select v.datasetUserID from WageDataSetVerifyBO v where v.yearMonth='"+yearMonth+"')";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){			
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		String boHql = "select bo,s.name "+hql + " order by s.createDate,u.deptId";
		String countHql = "select count(bo) "+hql;
		return this.pageQuery(vo, countHql, boHql);
	}
}
