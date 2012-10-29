package com.hr319wg.attence.dao;

import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRecordBO;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-2
 * Time: 上午11:08
 * To change this template use File | Settings | File Templates.
 */
public class AttAnnualMgrDAO extends BaseDAO{
    /**
     * 返回指定机构和年度的年假记录
     * @param orgId  机构
     * @param year   年度
     * @return
     * @throws SysException
     */
     public AttAnnualRecordBO findEquealsAttAnnualRecordBO(String orgId,String year)throws SysException {
        String hql="select bo from AttAnnualRecordBO bo where bo.recodeYear='"+year+"' and bo.orgID='"+orgId+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
             return (AttAnnualRecordBO)list.get(0);
        }
        return null;
    }

    /**
     * 返回当前机构执行的年假记录
     * @param orgId
     * @return
     * @throws SysException
     */
    public AttAnnualRecordBO findExcuteAttAnnualRecordBO(String orgId)throws SysException {
          String hsql = "select bo from AttAnnualRecordBO bo where bo.orgID='" + orgId + "' and bo.statusValue='0'";
          List list=this.hibernatetemplate.find(hsql);
          if(list!=null&&list.size()>0){
              return (AttAnnualRecordBO)list.get(0);
          }
          return null;
    }


    /**
     *
     * @param pagevo
     * @param orgid
     * @return
     * @throws SysException
     */
    public List getAllAttAnnualRecordBO(PageVO pagevo, String orgid)throws SysException {
        String hsql = "select bo from AttAnnualRecordBO bo where bo.orgID='"+ orgid + "'";
        String countsql = "select count(bo) from AttAnnualRecordBO bo where bo.orgID='"+ orgid + "'";
        return this.pageQuery(pagevo, countsql, hsql);
    }

    /**
     *
     * @param pagevo
     * @param recID  关联年假记录ID
     * @param personValue  查询条件
     * @return
     * @throws SysException
     */
     public List getAllAttAnnualItemBO(PageVO pagevo, String recID,String personValue)throws SysException {
        String hql = "select bo from AttAnnualItemBO bo where bo.recID='"
                + recID + "'";
        String countsql = "select count(bo) from AttAnnualItemBO bo where bo.recID='"
                + recID + "'";
         if(personValue!=null&&!personValue.equals("")){
               hql+=" and bo.personID in(select vo.personId from PersonBO vo where vo.name like '"+personValue+"' or vo.shortName like '"+personValue+"' or vo.personCode like '"+personValue+"')";
               countsql+=" and bo.personID in(select vo.personId from PersonBO vo where vo.name like '"+personValue+"' or vo.shortName like '"+personValue+"' or vo.personCode like '"+personValue+"')";
         }
         if(pagevo!=null){
            return this.pageQuery(pagevo, countsql, hql);
         }else{
             return this.hibernatetemplate.find(hql);
         }
    }

    /**
     *  替换getAllAttAnnualItemBOS
     * @param recID  关联年度记录ID
     * @return   返回全部该年度记录
     * @throws SysException
     */
    public List getAttAnnualItemBO(String recID) throws SysException{
		String hsql = "select bo from AttAnnualItemBO bo where bo.recID='"+recID+"'";
		return this.hibernatetemplate.find(hsql);
	}

    /**
     * 得到指定人员的所有AttAnnualItemBO替换 getAttAnnualItemBO(PageVO pagevo, String personId)
     * @param pagevo
     * @param personId
     * @return
     * @throws SysException
     */
    public List getAttAnnualItemBOByPid(PageVO pagevo, String personId)throws SysException {
        String hsql = "select bo from AttAnnualItemBO bo where bo.personID='"+ personId + "'";
        String countsql = "select count(bo) from AttAnnualItemBO bo where bo.personID='" + personId + "'";
        if(pagevo!=null){
            return this.pageQuery(pagevo, countsql, hsql);
        }else{
            return this.hibernatetemplate.find(hsql);
        }
    }

    /**
     *
     * @param pagevo
     * @param recId 关联年度记录ID
     * @return
     * @throws SysException
     */
    public List getAllAttAnnualExcludeBO(PageVO pagevo, String recId)throws SysException {
        String hsql = "select bo from AttAnnualExcludeBO bo where bo.recId='"
                + recId + "'";
        String countsql = "select count(bo) from AttAnnualExcludeBO bo where bo.recId='"
                + recId + "'";
        return this.pageQuery(pagevo, countsql, hsql);
    }

    /**
     * 得到所有规则下的项目
     * @param ruleID
     * @return
     * @throws SysException
     */
    public List getAttAnnualRuleItemBO(String ruleID) throws SysException{
		String hsql = "select bo from AttAnnualRuleItemBO bo where bo.ruleID='"+ruleID+"'";
		return this.hibernatetemplate.find(hsql);

	}

    /**
     * 返回本机构或是全集团的年假规则
     * @param orgid
     * @return
     * @throws SysException
     */
    public List getAttExecludeRuleBO(String orgid) throws SysException{
		String hsql = "select bo from AttExecludeRuleBO  bo where bo.orgId='"+orgid+"' or bo.orgId='-1'";
		return this.hibernatetemplate.find(hsql);

	}

    /**
     *  替换 getAttAnnualRuleBO
     * @param orgid
     * @return
     * @throws SysException
     */
    public List getAllAttAnnualRuleBOByOrgId(String orgid) throws SysException{
		String hsql = "select bo from AttAnnualRuleBO  bo where bo.orgID='"+orgid+"'";
		return this.hibernatetemplate.find(hsql);

	}

    /**
     *  替换getAttAnnualRuleBOS
     * @param orgid
     * @return
     * @throws SysException
     */
	public List getAllCommonAttAnnualRuleBO(String orgid) throws SysException{
		String hsql = "select bo from AttAnnualRuleBO  bo where bo.orgID='"+orgid+"' or bo.orgID='-1'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttAnnualDetailBOByItemId(String itemID) throws SysException{
		String hsql = "select bo from AttAnnualDetailBO bo where bo.itemID='"+itemID+"'";
		return this.hibernatetemplate.find(hsql);

	}

    public List getAttExecludeRuleItemBO(String ruleId) throws SysException{
		String hsql = "select bo from AttExecludeRuleItemBO bo where bo.ruleId='"+ruleId+"'";
		return this.hibernatetemplate.find(hsql);

	}

    /**
     * 替换 findaallists(String personId, String orgId, String datevalue）
     * @param personId
     * @param orgId
     * @param datevalue
     * @return
     * @throws SysException
     */
    public AttAnnualItemBO findEqualsAttAnnualItemBO(String personId, String orgId, String datevalue)throws SysException {
        String hsql = "select bo from AttAnnualItemBO bo where bo.personID='" + personId + "' and bo.recID in (select vo.recID from AttAnnualRecordBO vo where vo.orgID='" + orgId + "' and vo.recodeYear='" + datevalue + "' and vo.statusValue='0')";
        List list= this.hibernatetemplate.find(hsql);
        if(list!=null&&list.size()>0){
            return (AttAnnualItemBO)list.get(0);
        }
        return null;
    }

    public  AttAnnualItemBO findEqualsAttAnnualItemBO(String personId,String recId)throws SysException{
        String hql="select bo from AttAnnualItemBO bo where bo.personID='" + personId + "' and bo.recID='"+recId+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
           return (AttAnnualItemBO)list.get(0);
        }
        return null;
    }

    public List getAttAnnualDetailAuditBO(String itemID) throws SysException{
		String hsql = "select bo from AttAnnualDetailAuditBO bo where bo.itemId='"+itemID+"'";
		return this.hibernatetemplate.find(hsql);
	}

    /**
     * 年假匿报查询
     * @param pagevo
     * @param orgId
     * @param personValue
     * @param timeValue 拟报月份
     * @return
     * @throws SysException
     */
    public List getAllAttMimicReportRecBO(PageVO pagevo, String orgId,String personValue,String timeValue,String status)throws SysException{
       String hql="select bo from AttMimicReportRecBO bo where 1=1";
       String countHql="select count(bo) from AttMimicReportRecBO bo where 1=1";
       if((orgId!=null&&!orgId.equals(""))||(personValue!=null&&!personValue.equals(""))){
          hql+=" and bo.personID in (select vo.personId from PersonBO vo where 1=1";
          countHql+=" and bo.personID in (select vo.personId from PersonBO vo where 1=1";

             if(personValue!=null&&!personValue.equals("")){
                   hql+=" and (vo.name like '%"+personValue+"%' or vo.shortName like '%"+personValue+"%' or vo.personCode like '"+personValue+"')";
                  countHql+=" and (vo.name like '%"+personValue+"%' or vo.shortName like '%"+personValue+"%' or vo.personCode like '"+personValue+"')";
             }
             if(orgId!=null&&!orgId.equals("")){
                  OrgBO org= SysCacheTool.findOrgById(orgId);
                  hql+="  and vo.deptTreeId like '%"+org.getTreeId()+"%'";
                  countHql+="  and vo.deptTreeId like '%"+org.getTreeId()+"%'";
             }
             hql+=")";
             countHql+=")";
       }
       if(timeValue!=null&&!timeValue.equals("")){
           hql+=" and bo.mrMonth like '%"+timeValue+"%'";
           countHql+=" and bo.mrMonth like '%"+timeValue+"%'";
       }

       if(status!=null&&!status.equals("")){
           hql+=" and bo.statusValue = '"+status+"'";
           countHql+=" and bo.statusValue = '"+status+"'";
       }
       if(pagevo!=null){
          return this.pageQuery(pagevo,countHql,hql);
       }else{
          return this.hibernatetemplate.find(hql);
       }
    }

    /**
     * 查询指定人在指定时间段的年假记录
     * @param personId
     * @param beginTime
     * @param endTime
     * @return
     * @throws SysException
     */
     public List getAllAttAnnualDetailAuditBOByPersonIdAndTime(String personId,String beginTime,String endTime)throws SysException{
          String hql="select bo from AttAnnualDetailAuditBO bo where bo.personID='"+personId+"'and bo.statusValue='3' and " +
                  "((bo.holidayBegin>='"+beginTime+"' and bo.holidayEnd<='"+endTime+"')or(bo.holidayBegin<'"+beginTime+"' and bo.holidayEnd>'"+endTime+"'))";
          return this.hibernatetemplate.find(hql);
     }
}
