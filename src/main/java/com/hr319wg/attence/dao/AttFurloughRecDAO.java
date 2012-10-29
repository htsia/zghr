package com.hr319wg.attence.dao;

import java.util.List;

import com.hr319wg.attence.pojo.bo.AttFurloughRecBO;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

/**
 * Created by IntelliJ IDEA.
 * User: 高海星
 * Date: 11-12-3
 * Time: 下午3:51
 * To change this template use File | Settings | File Templates.
 */
public class AttFurloughRecDAO extends BaseDAO{

    public List  getAllAttfurloughBO()throws SysException{
        String hql="select bo from AttfurloughBO bo";
        return this.hibernatetemplate.find(hql);
    }
    /**
     *
     * @param pagevo  分页为null查询全部
     * @param orgId
     * @param beginTime
     * @param endTime
     * @param personValue
     * @param type   假期类型
     * @param postName   岗位名称
     * @return
     * @throws SysException
     */
      public List getAllAttFurloughRecCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String type,String postName)throws SysException{
          String hql="select bo from AttFurloughRecCollectBO bo where 1=1";
          String countHql="select count(bo) from AttFurloughRecCollectBO bo where 1=1";
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

          if(type!=null&&!type.equals("")){
                  hql+=" and bo.flID ='"+type+"'";
                 countHql+=" and bo.flID ='"+type+"'";
          }

          if(pagevo!=null){
             return this.pageQuery(pagevo,countHql,hql);
          } else{
             return this.hibernatetemplate.find(hql);
          }
      }


    /**
     *
     * @param pagevo
     * @param orgId
     * @param beginTime
     * @param endTime
     * @param personValue
     * @param type
     * @return
     * @throws SysException
     */
      public List getAllAttFurloughRecBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String type)throws SysException{
           String hql="select bo from AttFurloughRecBO bo where 1=1";
           String countHql="select count(bo) from AttFurloughRecBO bo where 1=1";
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
          if(beginTime!=null&&!beginTime.equals("")){
                 hql+=" and bo.beginTime >='"+beginTime+"'";
                 countHql+=" and bo.beginTime >='"+beginTime+"'";
          }

          if(endTime!=null&&!endTime.equals("")){
                 hql+=" and bo.beginTime <='"+endTime+"'";
                 countHql+=" and bo.beginTime <='"+endTime+"'";
          }

          if(type!=null&&!type.equals("")){
                  hql+=" and bo.flID ='"+type+"'";
                 countHql+=" and bo.flID ='"+type+"'";
          }

          if(pagevo!=null){
             return this.pageQuery(pagevo,countHql,hql);
          } else{
             return this.hibernatetemplate.find(hql);
          }

      }

      public AttFurloughRecBO findAttFurlouoghRecBOBySuperId(String superFurloughNo)throws SysException{
          String hql="select bo from AttFurloughRecBO bo where bo.superFurloughNo='"+superFurloughNo+"'";
          List list=this.hibernatetemplate.find(hql);
          if(list!=null&&list.size()>0){
             return (AttFurloughRecBO)list.get(0);
          }
          return null;
      }

    /**
     * 查询指定人在指定时间段的请假
     * @param personId
     * @param beginTime
     * @param endTime
     * @return
     * @throws SysException
     */
     public List getAllAttFurloughRecBOByPersonIdAndTime(String personId,String beginTime,String endTime)throws SysException{
          String hql="select bo from AttFurloughRecBO bo where bo.personID='"+personId+"'and bo.statusValue='3' and " +        		  
                  "((bo.beginTime>='"+beginTime+"' and bo.beginTime<='"+endTime+"')or(bo.beginTime<'"+beginTime+"' and bo.endTime>'"+endTime+"'))";
          return this.hibernatetemplate.find(hql);
     }

}
