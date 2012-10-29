package com.hr319wg.attence.dao;

import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
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
 * Time: ����5:05
 * To change this template use File | Settings | File Templates.
 */
public class AttOverTimeDAO extends BaseDAO{
    /**
     *
     * @param pagevo ��ҳ���� null���ȫ��
     * @param orgId  ����ID
     * @param beginTime  ��ʼʱ��
     * @param endTime    ����ʱ��
     * @param personValue ������Ա�����
     * @param postName ��λ����
     * @return
     * @throws SysException
     */
    public List getAllAttOverTimeLogBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName) throws SysException{
          String hql="select bo from AttOverTimeLogBO bo where 1=1";
          String countHql="select count(bo) from AttOverTimeLogBO bo where 1=1";
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
     * @param superFurloughNo  ����AttOverTimeLogBO
     * @return
     * @throws SysException
     */
    public AttOverTimeRecBO findAttOverTimeRecBOBySuperId(String superFurloughNo)throws SysException{
        String hql="select bo from AttOverTimeRecBO bo where bo.superFurloughNo='"+superFurloughNo+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
           return (AttOverTimeRecBO)list.get(0);
        }
        return null;
    }

     /**
     *
     * @param pagevo ��ҳ���� null���ȫ��
     * @param orgId  ����ID
     * @param beginTime  ��ʼʱ��
     * @param endTime    ����ʱ��
     * @return
     * @throws SysException
     */
    public List getAllAttOverTimeRecBO(PageVO pagevo,String orgId,String beginTime,String endTime)throws SysException{
         String hql="select bo from AttOverTimeRecBO bo where 1=1";
         String countHql="select bo from AttOverTimeRecBO bo where 1=1";
         if(orgId!=null&&orgId.equals("")){
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

    /**
     * ��ѯָ������ָ��ʱ��ε�
     * @param personId
     * @param beginTime
     * @param endTime
     * @return
     * @throws SysException
     */
     public List getAllAttOverTimeRecBOByPersonIdAndTime(String personId,String beginTime,String endTime)throws SysException{
          String hql="select bo from AttOverTimeRecBO bo where bo.personID='"+personId+"'and bo.statusValue='3' and " +
                  "((bo.beginTime>='"+beginTime+"' and bo.beginTime<='"+endTime+"')or(bo.beginTime<'"+beginTime+"' and bo.endTime>'"+endTime+"'))";
          return this.hibernatetemplate.find(hql);
     }


}
