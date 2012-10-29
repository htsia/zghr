package com.hr319wg.common.dao;

import java.util.Collection;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.type.Type;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;

import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.util.CommonFuns;
public class BaseDAO {
    protected HibernateTemplate hibernatetemplate;

    public HibernateTemplate getHibernatetemplate() {
        return hibernatetemplate;
    }
    public void setHibernatetemplate(HibernateTemplate hibernatetemplate) {
        this.hibernatetemplate = hibernatetemplate;
    }

    /**
     * ����һ��po,������ֱ�ӵ���hibernate��save����.��������������.
     */
    public String createBo(Object bo) throws SysException {
        try {
            if (bo != null)
                return (String) hibernatetemplate.save(bo);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RollbackableException("�������ݴ���", "", e, this.getClass());
        }
        return null;
    }

    /**
     * ��������ɾ��һ�м�¼.
     *
     *  clazz ��ɾ��BO������
     *  pk
      */
    public void deleteBo(Class clazz, String pk) throws SysException {
        try {
            Object bo = hibernatetemplate.get(clazz, pk);
            if (bo != null)
                hibernatetemplate.delete(bo);
        } catch (Exception e) {
            throw new RollbackableException("ɾ�����ݴ���", e.getMessage(), e, this.getClass());
        }
    }
    public Object deleteBoAndReturnIt(Class clazz, String pk) throws SysException {
        try {
            Object bo = hibernatetemplate.get(clazz, pk);
            if (bo != null){
                hibernatetemplate.delete(bo);
                return bo;
            }
            else{
                return null;
            }
        } catch (Exception e) {
            throw new RollbackableException("ɾ�����ݴ���", e.getMessage(), e, this.getClass());
        }
    }

    /**
     * ɾ�����м�¼
     */
    public void deleteAll(Collection entities){
        hibernatetemplate.deleteAll(entities);
    }
    /**
     * ִ������ɾ������
     *  String boname��BO������
     *  String attributename,ɾ��������BO��������
     *  Object attributevalue,ɾ��������BO����ֵ
     */
    public Integer bulkDelete(final String boname,final String attributename,final Object attributevalue){
        Integer ret = (Integer)hibernatetemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException {
                String deleteHQL = "delete "+boname+" where "+attributename+"="+attributevalue;
                System.out.println(deleteHQL);
                Query query = session.createQuery(deleteHQL);
                int r = query.executeUpdate();

                return new Integer(r) ;
            }
        });
        return ret;
    }

    /**
     * �������bo���ݸ��µ����ݿ��� ,��Ҫ��������ֵ,bo����
     *
     *  pk ������bo������
     *  bo ������bo
     */
    public void updateBo(String pk, Object bo) throws SysException {
        try {
            if (pk == null || bo == null)
                return;
            Object po = hibernatetemplate.get(bo.getClass(), pk);
            if (po == null)
                return;
            CommonFuns.copyProperties(po, bo);
            hibernatetemplate.update(po);
        } catch (Exception e) {
            throw new RollbackableException("��������ʧ��", "", e, this.getClass());
        }
    }

    public void saveOrUpdateBo(Object bo) throws SysException {
        try{
            if (bo == null)  return;
            hibernatetemplate.saveOrUpdate(bo);
        }
        catch(Exception e){
           throw new  SysException("","����ʧ��:"+e.getMessage(),e,BaseDAO.class);
        }
    }
    /**
     * ִ�������޸Ĳ���
     *  String boname��BO������
     *  String attributename,��Ҫ�޸ĵ�BO��������
     *  Object attributevalue,�޸ĺ��BO����ֵ
     *  String condition,�޸�����
     */
    public Integer bulkUpdate(final String boname,final String setattributename,final Object setattributevalue,final String condition){
        Integer ret = (Integer)hibernatetemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException {
                String updateHQL;
                if(condition == null){
                    updateHQL = "update "+boname+" set "+setattributename+"="+setattributevalue;
                }else{
                    updateHQL = "update "+boname+" set "+setattributename+"="+setattributevalue+" where "+condition;
                }
                Query query = session.createQuery(updateHQL);
                int r = query.executeUpdate();

                return new Integer(r) ;
            }
        });
        return ret;
    }

    /**
     * ����id��ѯһ������,���صĶ�������hibernateʵ�����.
     */
    public Object findBoById(Class clazz, String pk) throws SysException {
        try {
            Object bo = hibernatetemplate.get(clazz, pk);
            if (bo != null) {
                Object pojo = clazz.newInstance();
                CommonFuns.copyProperties(pojo, bo);
                return pojo;
            } else return null;
        } catch (Exception e) {
            throw new RollbackableException("��ѯ������¼ʧ��", "", e, this.getClass());
        }
    }
    /**
     * ͨ������һ��BO���Ի�ü�¼
     *  String boname,BO������
     *  String attributename,BO���Ե�����
     *  Object attributevalue,BO�����Ե�ֵ
     */
    public List findByAny(String boname,String attributename,Object attributevalue,String order){
        if(order == null) order = "";
        String hql = "select bo from "+boname+"  bo where bo."+attributename+"="+attributevalue+order;
        System.out.println(hql);
        return hibernatetemplate.find(hql);
    }

    /**
     * ͨ������һ��String��BO���Ի�ü�¼
     *  String boname,BO������
     *  String attributename,BO���Ե�����
     *  Object attributevalue,BO�����Ե�ֵ
     */
    public List findByAnyString(String boname,String attributename,String attributevalue,String order){
        if(order == null) order = "";
        String hql = "from "+boname+" as bo where bo."+attributename+"='"+attributevalue+"'"+order;
        System.out.println(hql);
        return hibernatetemplate.find(hql);
    }

    /**
     * ͨ��������BO���Ի�ü�¼
     *  String boname,BO������
     *  String[] attributename,���BO���Ե�����
     *  Object[] attributevalue,���BO�����Ե�ֵ
     */
    public List findByAny(String boname,String[] attributename,Object[] attributevalue,String order){
        if(order == null) order = "";
        String hql = "from "+boname+" as bo where ";

        if(attributename.length == attributevalue.length){
            for(int i=0 ; i<attributename.length ; i++){
                if(i == 0){
                    hql = hql+"bo."+attributename[i]+"="+attributevalue[i];
                }else{
                    hql = hql+" and bo."+attributename[i]+"="+attributevalue[i];
                }
            }
            hql = hql+order;
            System.out.println("hql:"+hql);

            return hibernatetemplate.find(hql);
        }else{
            return null;
        }

    }

    /**
     * ͨ��������BO���Ի�ü�¼
     *  String boname,BO������
     *  String[] attributename,���BO���Ե�����
     *  Object[] attributevalue,���BO�����Ե�ֵ
     */
    public List findByAnyString(String boname,String[] attributename,String[] attributevalue,String order){
        if(order == null) order = "";
        String hql = "from "+boname+" as bo where ";

        if(attributename.length == attributevalue.length){
            for(int i=0 ; i<attributename.length ; i++){
                if(i == 0){
                    hql = hql+"bo."+attributename[i]+"='"+attributevalue[i]+"'";
                }else{
                    hql = hql+" and bo."+attributename[i]+"='"+attributevalue[i]+"'";
                }
            }
            hql = hql+order;

            System.out.println("hql:"+hql);

            return hibernatetemplate.find(hql);
        }else{
            return null;
        }

    }

    /**
     * ������м�¼
     *  String boname,BO������
     */
    public List findAll(String boname){
        String hql = "from "+boname;
        System.out.println(hql);
        List list = hibernatetemplate.find(hql);
        return list;
    }

    /**
     * ��ü�¼����
     *  String boname,BO������
     */
    public Integer getBOCount(String boname){
        String hql = "select count(bo) from "+boname+" as bo";
        List list = hibernatetemplate.find(hql);
        Integer ret = (Integer)list.get(0);
        return ret;
    }

    /**
     * ��������������ü�¼����
     *  String boname,BO������
     */
    public Integer getBOCount(String boname,String attributename,Object attributevalue){
        String hql = "select count(bo) from "+boname+" as bo where bo."+attributename+"="+attributevalue;
        List list = hibernatetemplate.find(hql);
        Integer ret = (Integer)list.get(0);
        return ret;
    }

    /**
     * �������hql�ַ���
     *  String boname,BO������
     *  String attributename,��Ҫ�����BO��������
     *  int order,����Ϊ0������Ϊ1
     */
    public String getOrderString(String attributename,int order ){
        if(order == 0){
            return " order by bo."+attributename;
        }else{
            return " order by bo."+attributename+" desc";
        }
    }

    /**
     * �������hql�ַ���
     *  String boname,BO������
     *  String attributename,��Ҫ�����BO��������
     *  int order,����Ϊ0������Ϊ1
     */
    public String getOrderString(String[] attributenames,int[] orders ){
        String orderstring =" ";

        if(attributenames.length == orders.length){
            for(int i=0; i<attributenames.length; i++){
                if(i == 0){
                    if(orders[i] == 0){
                        orderstring = orderstring+"order by bo."+attributenames[i];
                    }else{
                        orderstring = orderstring+"order by bo."+attributenames[i]+" desc";
                    }
                }else{
                    if(orders[i] == 0){
                        orderstring = orderstring+",bo."+attributenames[i];
                    }else{
                        orderstring = orderstring+",bo."+attributenames[i]+" desc";
                    }
                }
            }
            return orderstring;
        }else{
            return null;
        }

    }

    /**
     * ��÷���hql�ַ���
     *  String boname,BO������
     *  String attributename,��Ҫ�����BO��������
     */
    /*public String getGroupString(String attributename){
        return "group by bo."+attributename;
    }*/

    /**
     * ͨ�����ò�ѯ�õ���ѯ���
     *  String queryName����ѯ����
     */
    public List findByNamedQuery(String queryName){
        System.out.println("in dao");
        return hibernatetemplate.findByNamedQuery(queryName);
    }

    /**
     * ͨ�����ò�ѯ�õ���ѯ���
     *  String queryName,��ѯ����
     *  String paramName,����������
     *  String value,������ֵ
     */
    public List findByNamedQueryAndNamedParam(String queryName, String paramName, Object value){
        return hibernatetemplate.findByNamedQueryAndNamedParam(queryName,paramName,value);
    }

    /**
     * ͨ�����ò�ѯ�õ���ѯ���
     *  String queryName����ѯ����
     *  String[] paramName,�������ֵ�����
     *  String[] value,����ֵ������
     */
    public List findByNamedQueryAndNamedParam(String queryName, String[] paramNames, Object[] values){
        return hibernatetemplate.findByNamedQueryAndNamedParam(queryName,paramNames,values);
    }

    public List pageQuery(PageVO vo, String countHql, String queryHql) throws SysException {
        Session s = null;
        try {
            s = SessionFactoryUtils.getSession(hibernatetemplate.getSessionFactory(), true);
            List list;
            list = s.createQuery(countHql).list();
            int runtimePageSize = vo.getRuntimePageSize();
            String count=String.valueOf(list.get(0));
            int rSize =Integer.parseInt(count);
            int totalPage = rSize / runtimePageSize;
            if (rSize % runtimePageSize > 0)             
                totalPage++;

            if (vo.getCurrentPage() > totalPage && totalPage != 0)
                vo.setCurrentPage(totalPage);

            vo.setTotalPage(totalPage);
            vo.setTotalRecord(rSize);

            Query q = s.createQuery(queryHql);
            q.setFirstResult((vo.getCurrentPage() - 1) * runtimePageSize);
            q.setMaxResults(runtimePageSize);

            return q.list();
        } catch (Exception e) {
            String msg="countHql;"+countHql+"\r\n +queryHql:"+queryHql;
            throw new SysException("��ҳ��ѯ����", msg, e, this.getClass());
        } finally {
            if (s != null) {
                try {
                    s.close();
                } catch (Exception e) {
                    new SysException("�ر�session����", "", e, getClass());
                }
            }
        }
    }

    public List pageQuery(PageVO vo, String countHql, String queryHql, Object[] obj, Type[] types) throws SysException {
        Session s = null;
        try {
            s = SessionFactoryUtils.getSession(hibernatetemplate.getSessionFactory(), true);
            List list;
            Query q = s.createQuery(countHql);
            for (int i = 0; i < obj.length; i++)
                q.setParameter(i, obj[i], types[i]);
            list = q.list();
            String count=String.valueOf(list.get(0));
            int rSize =Integer.parseInt(count);
            int runtimePageSize = vo.getRuntimePageSize();

            int totalPage = rSize / runtimePageSize;
            if (rSize % runtimePageSize > 0)
                totalPage++;

            if (vo.getCurrentPage() > totalPage && totalPage != 0)
                vo.setCurrentPage(totalPage);

            vo.setTotalPage(totalPage);
            vo.setTotalRecord(rSize);
            q = null;
            q = s.createQuery(queryHql);
            for (int i = 0; i < obj.length; i++)
                q.setParameter(i, obj[i], types[i]);
            return q.setFirstResult((vo.getCurrentPage() - 1) * runtimePageSize).setMaxResults(runtimePageSize).list();  //add by wangbing 2007-01-10

        } catch (Exception e) {
            throw new SysException("������ҳ��ѯ����", "", e, getClass());
        } finally {
            if (s != null) {
                try {
                    s.close();
                } catch (Exception e) {
                    new SysException("�ر�session����", "", e, getClass());
                }
            }
        }
    }
}
