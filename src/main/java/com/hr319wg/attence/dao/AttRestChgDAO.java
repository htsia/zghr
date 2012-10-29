package com.hr319wg.attence.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-2-1
 * Time: 上午11:55
 * To change this template use File | Settings | File Templates.
 */
public class AttRestChgDAO extends BaseDAO{
    /**
     * 返回存休记录
     * @param pagevo 分页参数
     * @param orgId  机构ID与PersonId互次
     * @param queryValue 模糊查询值
     * @param begin 开始时间值
     * @param end 结束时间值
     * @return
     * @throws SysException
     */
    public List getAllAttRestStoreBO(PageVO pagevo,String begin,String end,String orgId,String queryValue)throws SysException{
       String hql="select bo from AttRestStoreBO bo where 1=1";
       String countHql="select count(bo) from AttRestStoreBO bo where 1=1";
       if(begin!=null&&!begin.equals("")){
           hql+=" and bo.restTime >='"+begin+"'";
           countHql+=" and bo.restTime >='"+begin+"'";
       }

       if(end!=null&&!end.equals("")){
           hql+=" and bo.restTime <='"+end+"'";
           countHql+=" and bo.restTime <='"+end+"'";
       }
       if((orgId!=null&&!orgId.equals(""))||(queryValue!=null&&!queryValue.equals(""))){
           hql+=" and bo.personId in (select vo.personId from PersonBO vo where 1=1";
           countHql+=" and bo.personId in (select vo.personId from PersonBO vo where 1=1";
           if(queryValue!=null&&!queryValue.equals("")){
                   hql+=" and (vo.name like '%"+queryValue+"%' or vo.shortName like '%"+queryValue+"%' or vo.personCode like '"+queryValue+"')";
                  countHql+=" and (vo.name like '%"+queryValue+"%' or vo.shortName like '%"+queryValue+"%' or vo.personCode like '"+queryValue+"')";
             }
           if(orgId!=null&&!orgId.equals("")){
                  OrgBO org= SysCacheTool.findOrgById(orgId);
                  hql+="  and vo.deptTreeId like '%"+org.getTreeId()+"%'";
                  countHql+="  and vo.deptTreeId like '%"+org.getTreeId()+"%'";
           }
           hql+=")";
           countHql+=")";
       }
       hql+=" order by bo.restTime desc";
       if(pagevo!=null){
           return this.pageQuery(pagevo,countHql,hql);
       }else{
           return this.hibernatetemplate.find(hql);
       }
    }

    /**
     * 返回该人员的存休信息
     * @param pagevo
     * @param personId
     * @return
     * @throws SysException
     */
    public List getAttRestStoreBOByPid(PageVO pagevo,String personId)throws SysException{
        String hql="select bo from AttRestStoreBO bo where bo.personId='"+personId+"'";
        String countHql="select count(bo) from AttRestStoreBO bo where bo.personId='"+personId+"'";
        if(pagevo!=null){
           return this.pageQuery(pagevo,countHql,hql);
        }else{
           return this.hibernatetemplate.find(hql);
        }
    }

    /**
     * 返回调休记录
     * @param pagevo
     * @param begin
     * @param end
     * @param orgId
     * @param queryValue
     * @return
     * @throws SysException
     */
    public List getAllAttRestChangeBO(PageVO pagevo,String begin,String end,String orgId,String queryValue)throws SysException{
          String hql="select bo from AttRestChangeBO bo where 1=1";
       String countHql="select count(bo) from AttRestChangeBO bo where 1=1";
       if(begin!=null&&!begin.equals("")){
           hql+=" and bo.beginTime >='"+begin+"'";
           countHql+=" and bo.beginTime >='"+begin+"'";
       }

       if(end!=null&&!end.equals("")){
           hql+=" and bo.beginTime <='"+end+"'";
           countHql+=" and bo.beginTime <='"+end+"'";
       }
       if((orgId!=null&&!orgId.equals(""))||(queryValue!=null&&!queryValue.equals(""))){
           hql+=" and bo.personId in (select vo.personId from PersonBO vo where 1=1";
           countHql+=" and bo.personId in (select vo.personId from PersonBO vo where 1=1";
           if(queryValue!=null&&!queryValue.equals("")){
                   hql+=" and (vo.name like '%"+queryValue+"%' or vo.shortName like '%"+queryValue+"%' or vo.personCode like '"+queryValue+"')";
                  countHql+=" and (vo.name like '%"+queryValue+"%' or vo.shortName like '%"+queryValue+"%' or vo.personCode like '"+queryValue+"')";
             }
           if(orgId!=null&&!orgId.equals("")){
                  OrgBO org= SysCacheTool.findOrgById(orgId);
                  hql+="  and vo.deptTreeId like '%"+org.getTreeId()+"%'";
                  countHql+="  and vo.deptTreeId like '%"+org.getTreeId()+"%'";
           }
           hql+=")";
           countHql+=")";
       }
       hql+=" order by bo.beginTime desc";
       if(pagevo!=null){
           return this.pageQuery(pagevo,countHql,hql);
       }else{
           return this.hibernatetemplate.find(hql);
       }
    }

    public List getAttRestChangeBOByPid(PageVO pagevo,String personId)throws SysException{
        String hql="select bo from AttRestChangeBO bo where bo.personId='"+personId+"'";
        String countHql="select count(bo) from AttRestChangeBO bo where bo.personId='"+personId+"'";
        if(pagevo!=null){
           return this.pageQuery(pagevo,countHql,hql);
        }else{
           return this.hibernatetemplate.find(hql);
        }
    }

    public List getAttRestChangeBOByStoreId(String storeId)throws SysException{
        String hql="select bo from AttRestChangeBO bo where bo.storeId='"+storeId+"'";
        return this.hibernatetemplate.find(hql);
    }
}
