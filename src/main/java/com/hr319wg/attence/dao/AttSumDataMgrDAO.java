package com.hr319wg.attence.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.cache.SysCacheTool;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-12-12
 * Time: 下午2:00
 * To change this template use File | Settings | File Templates.
 */
public class AttSumDataMgrDAO extends BaseDAO{
    /**
     * 查询日汇总信息
     * @param pagevo 分页参数
     * @param likeDate  日期参数
     * @param orgId  机构表示
     * @param queryValue  查询条件
     * @return
     * @throws SysException
     */
    public List getAllAttenceDayLogBO(PageVO pagevo,String beginDate,String endDate,String orgId,String queryValue)throws SysException{
        String hql="select bo from AttenceDayLogBO bo where 1=1";
        String countHql="select count(bo) from AttenceDayLogBO bo where 1=1";
        if(beginDate!=null&&!beginDate.equals("")){
           hql+=" and bo.attenceDate >= '"+beginDate+"'";
           countHql+=" and bo.attenceDate >= '"+beginDate+"'";
        }
        if(endDate!=null&&!endDate.equals("")){
           hql+=" and bo.attenceDate <= '"+endDate+"'";
           countHql+=" and bo.attenceDate <= '"+endDate+"'";
        }
        if((orgId!=null&&!orgId.equals(""))||(queryValue!=null&&!queryValue.equals(""))){
           hql+=" and bo.personId in (select pbo.personId from PersonBO pbo where 1=1";
           countHql+=" and bo.personId in (select pbo.personId from PersonBO pbo where 1=1";
           if(queryValue!=null&&!queryValue.equals("")){
               hql+=" and (pbo.name like '%"+queryValue+"%' or pbo.shortName like '%"+queryValue+"%' or pbo.personCode='"+queryValue+"')";
               countHql+=" and (pbo.name like '%"+queryValue+"%' or pbo.shortName like '%"+queryValue+"%' or pbo.personCode='"+queryValue+"')";
           }

           if(orgId!=null&&!orgId.equals("")){
               String treeId= SysCacheTool.findOrgById(orgId).getTreeId();
               hql+=" and pbo.deptTreeId like '%"+treeId+"%'";
               countHql+=" and pbo.deptTreeId like '%"+treeId+"%'";
           }
           hql+=")";
           countHql+=")";
        }

        if(pagevo!=null){
            return this.pageQuery(pagevo,countHql,hql);
        }else{
            return this.hibernatetemplate.find(hql);
        }
    }

    /**
     * 查询月汇总信息
     * @param pagevo 分页参数
     * @param likeDate  日期参数
     * @param orgId  机构表示
     * @param queryValue  查询条件
     * @return
     * @throws SysException
     */
    public List getAllAttenceDayMonthBO(PageVO pagevo,String likeDate,String orgId,String queryValue)throws SysException{
        String hql="select bo from AttenceDayMonthBO bo where 1=1";
        String countHql="select count(bo) from AttenceDayMonthBO bo where 1=1";
        if(likeDate!=null&&!likeDate.equals("")){
           hql+=" and bo.attenceDate like '%"+likeDate+"%'";
           countHql+=" and bo.attenceDate like '%"+likeDate+"%'";
        }

        if((orgId!=null&&!orgId.equals(""))||(queryValue!=null&&!queryValue.equals(""))){
           hql+=" and bo.personId in (select pbo.personId from PersonBO pbo where 1=1";
           countHql+=" and bo.personId in (select pbo.personId from PersonBO pbo where 1=1";
           if(queryValue!=null&&!queryValue.equals("")){
               hql+=" and (pbo.name like '%"+queryValue+"%' or pbo.shortName like '%"+queryValue+"%' or pbo.personCode='"+queryValue+"')";
               countHql+=" and (pbo.name like '%"+queryValue+"%' or pbo.shortName like '%"+queryValue+"%' or pbo.personCode='"+queryValue+"')";
           }

           if(orgId!=null&&!orgId.equals("")){
               String treeId= SysCacheTool.findOrgById(orgId).getTreeId();
               hql+=" and pbo.deptTreeId like '%"+treeId+"%'";
               countHql+=" and pbo.deptTreeId like '%"+treeId+"%'";
           }
           hql+=")";
           countHql+=")";
        }

        if(pagevo!=null){
            return this.pageQuery(pagevo,countHql,hql);
        }else{
            return this.hibernatetemplate.find(hql);
        }
    }
}
