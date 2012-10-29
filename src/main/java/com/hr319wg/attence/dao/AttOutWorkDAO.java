package com.hr319wg.attence.dao;

import com.hr319wg.attence.pojo.bo.AttOutWorkBO;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-3
 * Time: 下午1:14
 * To change this template use File | Settings | File Templates.
 */
public class AttOutWorkDAO extends BaseDAO{
    /**
     *
     * @param pagevo 分页参数 传入null查询全部
     * @param orgId  机构ID
     * @param beginTime  开始时间
     * @param endTime    结束时间
     * @param personValue 查询值
     * @param postName 岗位名称
     * @return
     * @throws SysException
     */
    public List getAllAttOutWorkCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName)throws SysException{
         String hql="select bo from AttOutWorkCollectBO bo where 1=1";
         String countHql="select count(bo) from AttOutWorkCollectBO bo where 1=1";

         if((orgId!=null&&!orgId.equals(""))||(personValue!=null&&!personValue.equals(""))||(postName!=null&&!postName.equals(""))){
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

             if(postName!=null&&!postName.equals("")){
                  hql+=" and vo.postId in(select po.postId from PostBO po where po.name like '%"+postName+"%')";
                  countHql+=" and vo.postId in(select po.postId from PostBO po where po.name like '%"+postName+"%')";
             }
             hql+=")";
             countHql+=")";
         }
         if(beginTime!=null&&!beginTime.equals("")){
                 hql+=" and bo.beginTime >='"+beginTime+"'";
                 countHql+=" and bo.beginTime >='"+beginTime+"'";
          }

          if(endTime!=null&&!endTime.equals("")){
                 hql+=" and bo.beginTime <='"+endTime+"'";
                 countHql+=" and bo.beginTime <='"+endTime+"'";
          }

         if(pagevo!=null){
            return this.pageQuery(pagevo,countHql,hql);
         }else{
            return this.hibernatetemplate.find(hql);
         }
    }

    /**
     *
     * @param pagevo 分页参数 传入null查询全部
     * @param orgId  机构ID
     * @param beginTime  开始时间
     * @param endTime    结束时间
     * @return
     * @throws SysException
     */
    public List getAllAttOutWorkBO(PageVO pagevo,String orgId,String beginTime,String endTime)throws SysException{
        String hql="select bo from AttOutWorkBO bo where 1=1";
        String countHql="select count(bo) from AttOutWorkBO bo where 1=1";

        if(orgId!=null&&!orgId.equals("")){
             OrgBO org= SysCacheTool.findOrgById(orgId);
             hql+=" and bo.personID in (select vo.personId from PersonBO vo where vo.deptTreeId like '%"+org.getTreeId()+"%')";
             countHql+=" and bo.personID in (select vo.personId from PersonBO vo where vo.deptTreeId like '%"+org.getTreeId()+"%')";
        }

        if(beginTime!=null&&!beginTime.equals("")){
              hql+=" and bo.beginTime >='"+beginTime+"'";
              countHql+=" and bo.beginTime >='"+beginTime+"'";
        }

        if(endTime!=null&&!endTime.equals("")){
              hql+=" and bo.beginTime <='"+endTime+"'";
              countHql+=" and bo.beginTime <='"+endTime+"'";
        }

        if(pagevo!=null){
            return this.pageQuery(pagevo,countHql,hql);
        }else{
            return this.hibernatetemplate.find(hql);
        }
    }

    public AttOutWorkBO findAttOutWorkBOBySuperId(String superFurloughNo)throws SysException{
        String hql="select bo from AttOutWorkBO bo where bo.superFurloughNo='"+superFurloughNo+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
              return (AttOutWorkBO)list.get(0);
        }
        return null;
    }

    /**
     * 查询指定人在指定时间段的公出记录
     * @param personId
     * @param beginTime
     * @param endTime
     * @return
     * @throws SysException
     */
     public List getAllAttOutWorkBOByPersonIdAndTime(String personId,String beginTime,String endTime)throws SysException{
          String hql="select bo from AttOutWorkBO bo where bo.personID='"+personId+"'and bo.statusValue='3' and " +
                  "((bo.beginTime>='"+beginTime+"' and bo.beginTime<='"+endTime+"')or(bo.beginTime<'"+beginTime+"' and bo.endTime>'"+endTime+"'))";
          return this.hibernatetemplate.find(hql);
     }

}
