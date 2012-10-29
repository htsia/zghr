package com.hr319wg.attence.dao;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttItemSetDetailBO;
import com.hr319wg.common.Constants;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;

public class AttDurationDAO extends BaseDAO {
    public List findAttTimeOffRecBO(String overTimeNO) throws SysException {
        String hsql = "select bo from AttTimeOffRecBO bo where  bo.overTimeNO='" + overTimeNO + "'";
        return this.hibernatetemplate.find(hsql);
    }

    public List findAttTimeOffRecBO(String personId, String overTimeNO) throws SysException {
        String hsql = "select bo from AttTimeOffRecBO bo where bo.personID='" + personId + "' and  bo.overTimeNO='" + overTimeNO + "'";
        return this.hibernatetemplate.find(hsql);
    }

    public List findAttTimeOffRecBO1(String personId, String overTimeNO) throws SysException {
        String hsql = "select bo from AttTimeOffRecBO bo where bo.personID='" + personId + "' and  bo.overTimeNO='" + overTimeNO + "' and bo.statusValue<>'3'";
        return this.hibernatetemplate.find(hsql);
    }

    public List findPersonsAttClassGroupVO(String groupId) throws SysException {
        String hsql = "select bo from AttClassGroupVO bo where  bo.groupNo='" + groupId + "'";
        return this.hibernatetemplate.find(hsql);
    }

    public List findPersonsAttClassGroupVO(String groupId, String deptId) throws SysException {
        String hsql = "select bo from AttClassGroupVO bo where  bo.groupNo='" + groupId + "' and bo.deptId='" + deptId + "'";
        return this.hibernatetemplate.find(hsql);
    }



    public List getAttAnnualItemBO1(String personId, String year, String orgId)
            throws SysException {
        String hsql = "select bo from AttAnnualItemBO bo where bo.personID='" + personId + "' and bo.recID in (select a.recID from AttAnnualRecordBO a where a.recodeYear='" + year + "' and a.orgID='" + orgId + "')";
        return this.hibernatetemplate.find(hsql);
    }

    public List findAllOrgBO(String orgID)
            throws SysException {
        String hsql = "select bo from OrgBO bo where bo.orgId='" + orgID + "'";
        return this.hibernatetemplate.find(hsql);
    }

    public List getAllAttOverTimeLogBO(String name, String beginTime, String superId, PageVO mypage)
            throws SysException {
        String hsql = "select bo from AttOverTimeLogBO bo  where bo.personID in (select vo.id from AttClassGroupVO vo where  vo.orgId like '"
                + superId + "' or vo.deptId like '" + superId + "') ";
        String countsql = "select count(bo) from AttOverTimeLogBO bo  where bo.personID in (select vo.id from AttClassGroupVO vo where  vo.orgId like '"
                + superId + "' or vo.deptId like '" + superId + "') ";
        if (name != null && !"".equals(name)) {
            hsql += "  and  bo.personID in (select vo.id from AttClassGroupVO vo where  vo.name like '%" + name + "%' or vo.personSeq like '%" + name + "%')";
            countsql += "  and  bo.personID in (select vo.id from AttClassGroupVO vo where  vo.name like '%" + name + "%' or vo.personSeq like '%" + name + "%')";
        }
        if (beginTime != null && !"".equals(beginTime)) {
            hsql += "  and  bo.applyDate='" + beginTime + "'";
            countsql += "  and  bo.applyDate='" + beginTime + "'";
        }
        return this.pageQuery(mypage, countsql, hsql);

    }

    public List findAllAttItemSetDetailBO(String itemCode, String orgID)
            throws SysException {
        String hsql = "select bo from AttItemSetDetailBO bo where bo.itemCode='" + itemCode + "' and bo.createOrg='" + orgID + "'";
        return this.hibernatetemplate.find(hsql);
    }

    public Hashtable findAllAttItemSetDetailB0ForHash(String orgId){
        String hql="select bo from AttItemSetDetailBO bo where bo.createOrg='"+orgId+"'";
        List list=this.hibernatetemplate.find(hql);
        Hashtable hash=new Hashtable();
        if(list!=null&&list.size()>0){
             for(int i=0;i<list.size();i++){
                  AttItemSetDetailBO bo=(AttItemSetDetailBO)list.get(i);
                  hash.put(bo.getItemCode()+bo.getCreateOrg(),bo);
             }
        }
        return hash;
    }

    public List findAllInfoItemBO(String setId)
            throws SysException {
        String hsql = "select bo from InfoItemBO bo where bo.setId='" + setId + "'";
        return this.hibernatetemplate.find(hsql);
    }

    public List getAllAttItemSetDetailBO(String orgID)
            throws SysException {
        String hsql = "select bo from AttItemSetDetailBO bo where bo.createOrg='" + orgID + "'";
        return this.hibernatetemplate.find(hsql);
    }


    public List getAllAttAnnualItemBO(PageVO pagevo, String recID)
            throws SysException {
        String hsql = "select bo from AttAnnualItemBO bo where bo.recID='"
                + recID + "'";
        String countsql = "select count(bo) from AttAnnualItemBO bo where bo.recID='"
                + recID + "'";
        return this.pageQuery(pagevo, countsql, hsql);
    }


    public List getAllAttDurationBOS() throws SysException {
        String hsql = "select bo from AttDurationBO bo  order by bo.duraYear,bo.duraMonth";
        return this.hibernatetemplate.find(hsql);
    }

    public List getAllAttDurationBO(User user) throws SysException {
        String hsql = "select bo from AttDurationBO bo where bo.orgID='"
                + user.getOrgId() + "' and bo.createUserID='"+user.getUserId()+"' order by bo.duraYear,bo.duraMonth";
        return this.hibernatetemplate.find(hsql);
    }

    public List getAllAttenceSet(PageVO pagevo,  User user)
            throws SysException {
        String hsql = "select bo from AttDurationBO bo where bo.orgID='"
                + user.getOrgId() + "' and bo.createUserID='"+user.getUserId()+"'";
        String countsql = "select count(bo) from AttDurationBO bo where bo.orgID='"
        		+ user.getOrgId() + "' and bo.createUserID='"+user.getUserId()+"'";
        return this.pageQuery(pagevo, countsql, hsql);

    }

    public List getAllAttenceSet1(String orgid, String y, String m)
            throws SysException {
        String hsql = "select bo from AttDurationBO bo where bo.orgID='" + orgid + "' and bo.duraYear='" + y + "' and bo.duraMonth='" + m + "'";
        return this.hibernatetemplate.find(hsql);
    }

    public List getAttClassGroupVO1(String orgid)
            throws SysException {
        String hsql = "";
        if ("ORACLE".equals(Constants.DB_TYPE)) {
            hsql = "select bo from AttClassGroupVO bo where (bo.deptId='" + orgid + "' or bo.deptGroupId='" + orgid + "') and (bo.groupNo is not null or bo.groupNo<>'')";
        } else {
            hsql = "select bo from AttClassGroupVO bo where (bo.deptId='" + orgid + "' or bo.deptGroupId='" + orgid + "') and bo.groupNo is not null and bo.groupNo<>''";
        }

        return this.hibernatetemplate.find(hsql);
    }

    public List getAllAttCardBO(PageVO pagevo, String status, String superId)
            throws SysException {
        String hsql = "select bo from AttCardBO bo  where bo.personID in (select vo.id from AttClassGroupVO vo where  vo.orgId like '"
                + superId + "' or vo.deptId like '" + superId + "') ";
        String countsql = "select count(bo) from AttCardBO bo where bo.personID in (select vo.id from AttClassGroupVO vo where  vo.orgId like '"
                + superId + "' or vo.deptId like '" + superId + "')";
        if (status != null && !"".equals(status)) {
            hsql += " and bo.operType='" + status + "'";
            countsql += " and bo.operType='" + status + "'";
        }
        return this.pageQuery(pagevo, countsql, hsql);

    }

    public List getAllAttClassBO(PageVO pagevo, String orgid)
            throws SysException {
        String hsql = "select bo from AttClassBO bo where bo.orgID='" + orgid + "' or bo.orgID='-1'";
        String countsql = "select count(bo) from AttClassBO bo where bo.orgID='" + orgid + "' or bo.orgID='-1'";
        return this.pageQuery(pagevo, countsql, hsql);

    }

    public List getAllAttClassDetailBOS(String classID) throws SysException {
        String hsql = "select bo from AttClassDetailBO bo where bo.classID='"
                + classID + "'";
        return this.hibernatetemplate.find(hsql);
        
    }

    public List getAllAttClassDetailBO(PageVO pagevo, String classID)
            throws SysException {
        String hsql = "select bo from AttClassDetailBO bo where bo.classID='"
                + classID + "' order by bo.orderFlag";
        String countsql = "select count(bo) from AttClassDetailBO bo where bo.classID='"
                + classID + "'";
        return this.pageQuery(pagevo, countsql, hsql);

    }

    public List getAllAttClassDetailBO1(String classID) throws SysException {
        String hsql = "select bo from AttClassDetailBO bo where bo.classID='"
                + classID + "' order by bo.orderFlag";
        return this.hibernatetemplate.find(hsql);

    }

    public List getAllAttClassDetailBO2(String classID) throws SysException {
        String hsql = "select bo from AttClassDetailBO bo where bo.classID='"
                + classID + "' order by bo.itemName";
        return this.hibernatetemplate.find(hsql);

    }

    public List getAllAttClassDetailBO3(String classID) throws SysException {
        String hsql = "select bo from AttClassDetailBO bo where bo.classID='"
                + classID + "' and bo.dayFlag='1' order by bo.itemTime";
        return this.hibernatetemplate.find(hsql);

    }

    public List getAllAttClassDetailBO4(String classID) throws SysException {
        String hsql = "select bo from AttClassDetailBO bo where bo.classID='"
                + classID + "' and bo.dayFlag='2' order by bo.itemTime";
        return this.hibernatetemplate.find(hsql);

    }

    public List getAttClassBO(String className) throws SysException {
        String hsql = "select bo from AttClassBO bo where bo.className='"
                + className + "'";
        return this.hibernatetemplate.find(hsql);

    }

    public List getAttCaclRuleBO(String orgID) throws SysException {
        String hsql = "select bo from AttCaclRuleBO bo where bo.orgID='" + orgID + "'";
        return this.hibernatetemplate.find(hsql);

    }

    public List findAttAnnualRecordBO(String orgid)
            throws SysException {
        String hsql = "select bo from AttAnnualRecordBO bo where bo.orgID='" + orgid + "' and bo.statusValue='0'";
        return this.hibernatetemplate.find(hsql);

    }

    public List findAttAnnualItemBO(String recID, String personId)
            throws SysException {
        String hsql = "select bo from AttAnnualItemBO bo where bo.personID='" + personId + "' and bo.recID='" + recID + "'";
        return this.hibernatetemplate.find(hsql);
    }

    public List findAttModifyTimeOffList(String name, String beginTime, String superId, PageVO mypage)
            throws SysException {
        String hsql = "select bo from AttTimeOffRecBO bo  where bo.statusValue='3' and bo.personID in (select vo.id from AttClassGroupVO vo where  vo.orgId like '"
                + superId + "' or vo.deptId like '" + superId + "') ";
        String countsql = "select count(bo) from AttTimeOffRecBO bo  where bo.statusValue='3' and bo.personID in (select vo.id from AttClassGroupVO vo where  vo.orgId like '"
                + superId + "' or vo.deptId like '" + superId + "') ";
        if (name != null && !"".equals(name)) {
            hsql += "  and  bo.personID in (select vo.id from AttClassGroupVO vo where  vo.name like '%" + name + "%' or vo.personSeq like '%" + name + "%')";
            countsql += "  and  bo.personID in (select vo.id from AttClassGroupVO vo where  vo.name like '%" + name + "%' or vo.personSeq like '%" + name + "%')";
        }
        if (beginTime != null && !"".equals(beginTime)) {
            hsql += "  and  bo.applyDate='" + beginTime + "'";
            countsql += "  and  bo.applyDate='" + beginTime + "'";
        }
        return this.pageQuery(mypage, countsql, hsql);

    }
    
    public List getAllAttClassUserList(String classId,String userType)
    		throws SysException {
    	String hql="select bo from AttClassUserBO bo where bo.userType='"+userType+"' and bo.classID='"+classId+"'";
    	return this.hibernatetemplate.find(hql);
    }

    public List getAllClassUserBOByOrgIDClassID(String orgIDs,String classID){
    	String hql = "select bo.userID from AttClassGroupVO bo where bo.orgId in("+ orgIDs + "0) and bo.userID not in " +
    			"(select ubo.userID from AttClassUserBO ubo where ubo.userType=1 and ubo.classID='"+classID+"')";
    	return this.hibernatetemplate.find(hql);
    }

    public List getAllClassUserBOByClassID(String classID){
    	String hql = "select bo.userID from AttClassUserBO bo where bo.userType=0 and bo.classID='"+classID+"'";
    	return this.hibernatetemplate.find(hql);
    }
    
    public List getAllCycleCoincidenceSignDetailIDByOrgID(String orgID){
    	String hql = "select a from AttSignDetailBO a,AttSignDetailBO b where a.classType='c' and b.classType='u' and a.day=b.day " +
    			"and a.createOrgID=b.createOrgID and a.userID =b.userID ";
    			if(orgID!=null){
    				hql+=" and a.createOrgID='"+orgID+"'";
    			}
    	return this.hibernatetemplate.find(hql);
    }
    
    public List getAllClassBOByDate(String orgId){
		String hql = "select bo from AttClassBO bo where bo.isUse='1' ";
				if(orgId!=null){
					hql+="and bo.orgID='"+orgId+"' ";
				}
        return this.hibernatetemplate.find(hql);
	}
    
    public List getAttenceLogBOLog(String personId, String cardDate) throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ personId + "' and bo.cardDate='" + cardDate
				+ "' order by bo.cardDate,bo.cardTime";
		return this.hibernatetemplate.find(hsql);
	}
    
    public List getAllSignDetailBOByOrgID(String orgID) throws SysException {
    	String hql = "select bo from AttSignDetailBO bo ";
    			if(orgID!=null){
    				hql+=" where bo.createOrgID='"+orgID+"'";    				
    			}
    	return this.hibernatetemplate.find(hql);
    }
    
    public List getAllSignDetailUserIDByOrgID(String orgID) throws SysException {
    	String hql = "select bo.userID from AttSignDetailBO bo where bo.createOrgID='"+orgID+"' group by bo.userID";
    	return this.hibernatetemplate.find(hql);
    }
    
    public List getAllAttMachineByOrgID(String orgID) throws SysException {
    	String hql = "select bo from attMachineBO bo ";
    	if(orgID!=null){
    		hql+=" where bo.orgID='"+orgID+"'";    		
    	}
    	return this.hibernatetemplate.find(hql);
    }
    
    public List getUserIDBycardNO(String cardNO) throws SysException {
    	String hql = "select bo.userID from AttClassGroupVO bo where bo.card='"+cardNO+"'";
    	return this.hibernatetemplate.find(hql);
    }
    
    public List getAllAttenceLogBOByCardInfo(String cardNO,String cardDate,String cardTime){
    	String hql = "select bo from AttenceLogBO bo where bo.cardNO='"+cardNO+"' and bo.cardDate='"+cardDate+"' and bo.cardTime='"+cardTime+"'";
    	return this.hibernatetemplate.find(hql);
    }
    
    public List getAllAttenceCurrLogBOByUserIDDate(String userID, String date){
    	String hql = "select bo from AttenceCurrLogBO bo where bo.personId='"+userID+"' and bo.attenceDate='"+date+"'";
    	return this.hibernatetemplate.find(hql);
    }
    
}
