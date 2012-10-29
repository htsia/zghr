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
     * 保存一个po,本方法直接调用hibernate的save保存.不负责主键生成.
     */
    public String createBo(Object bo) throws SysException {
        try {
            if (bo != null)
                return (String) hibernatetemplate.save(bo);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RollbackableException("插入数据错误", "", e, this.getClass());
        }
        return null;
    }

    /**
     * 根据主键删除一行记录.
     *
     *  clazz 待删除BO的类名
     *  pk
      */
    public void deleteBo(Class clazz, String pk) throws SysException {
        try {
            Object bo = hibernatetemplate.get(clazz, pk);
            if (bo != null)
                hibernatetemplate.delete(bo);
        } catch (Exception e) {
            throw new RollbackableException("删除数据错误", e.getMessage(), e, this.getClass());
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
            throw new RollbackableException("删除数据错误", e.getMessage(), e, this.getClass());
        }
    }

    /**
     * 删除所有记录
     */
    public void deleteAll(Collection entities){
        hibernatetemplate.deleteAll(entities);
    }
    /**
     * 执行批量删除操作
     *  String boname，BO的名字
     *  String attributename,删除条件：BO属性名字
     *  Object attributevalue,删除条件：BO属性值
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
     * 将传入的bo数据更新到数据库中 ,需要传入主键值,bo数据
     *
     *  pk 待更新bo的主键
     *  bo 待更新bo
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
            throw new RollbackableException("更新数据失败", "", e, this.getClass());
        }
    }

    public void saveOrUpdateBo(Object bo) throws SysException {
        try{
            if (bo == null)  return;
            hibernatetemplate.saveOrUpdate(bo);
        }
        catch(Exception e){
           throw new  SysException("","保存失败:"+e.getMessage(),e,BaseDAO.class);
        }
    }
    /**
     * 执行批量修改操作
     *  String boname，BO的名字
     *  String attributename,需要修改的BO属性名字
     *  Object attributevalue,修改后的BO属性值
     *  String condition,修改条件
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
     * 根据id查询一个对象,返回的对象脱离hibernate实体管理.
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
            throw new RollbackableException("查询单个记录失败", "", e, this.getClass());
        }
    }
    /**
     * 通过任意一个BO属性获得记录
     *  String boname,BO的名字
     *  String attributename,BO属性的名字
     *  Object attributevalue,BO的属性的值
     */
    public List findByAny(String boname,String attributename,Object attributevalue,String order){
        if(order == null) order = "";
        String hql = "select bo from "+boname+"  bo where bo."+attributename+"="+attributevalue+order;
        System.out.println(hql);
        return hibernatetemplate.find(hql);
    }

    /**
     * 通过任意一个String型BO属性获得记录
     *  String boname,BO的名字
     *  String attributename,BO属性的名字
     *  Object attributevalue,BO的属性的值
     */
    public List findByAnyString(String boname,String attributename,String attributevalue,String order){
        if(order == null) order = "";
        String hql = "from "+boname+" as bo where bo."+attributename+"='"+attributevalue+"'"+order;
        System.out.println(hql);
        return hibernatetemplate.find(hql);
    }

    /**
     * 通过任意多个BO属性获得记录
     *  String boname,BO的名字
     *  String[] attributename,多个BO属性的名字
     *  Object[] attributevalue,多个BO的属性的值
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
     * 通过任意多个BO属性获得记录
     *  String boname,BO的名字
     *  String[] attributename,多个BO属性的名字
     *  Object[] attributevalue,多个BO的属性的值
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
     * 获得所有记录
     *  String boname,BO的名字
     */
    public List findAll(String boname){
        String hql = "from "+boname;
        System.out.println(hql);
        List list = hibernatetemplate.find(hql);
        return list;
    }

    /**
     * 获得记录总数
     *  String boname,BO的名字
     */
    public Integer getBOCount(String boname){
        String hql = "select count(bo) from "+boname+" as bo";
        List list = hibernatetemplate.find(hql);
        Integer ret = (Integer)list.get(0);
        return ret;
    }

    /**
     * 根据属性条件获得记录总数
     *  String boname,BO的名字
     */
    public Integer getBOCount(String boname,String attributename,Object attributevalue){
        String hql = "select count(bo) from "+boname+" as bo where bo."+attributename+"="+attributevalue;
        List list = hibernatetemplate.find(hql);
        Integer ret = (Integer)list.get(0);
        return ret;
    }

    /**
     * 获得排序hql字符串
     *  String boname,BO的名字
     *  String attributename,需要排序的BO属性名字
     *  int order,升序为0，降序为1
     */
    public String getOrderString(String attributename,int order ){
        if(order == 0){
            return " order by bo."+attributename;
        }else{
            return " order by bo."+attributename+" desc";
        }
    }

    /**
     * 获得排序hql字符串
     *  String boname,BO的名字
     *  String attributename,需要排序的BO属性名字
     *  int order,升序为0，降序为1
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
     * 获得分组hql字符串
     *  String boname,BO的名字
     *  String attributename,需要排序的BO属性名字
     */
    /*public String getGroupString(String attributename){
        return "group by bo."+attributename;
    }*/

    /**
     * 通过引用查询得到查询结果
     *  String queryName，查询名字
     */
    public List findByNamedQuery(String queryName){
        System.out.println("in dao");
        return hibernatetemplate.findByNamedQuery(queryName);
    }

    /**
     * 通过引用查询得到查询结果
     *  String queryName,查询名字
     *  String paramName,参数的名字
     *  String value,参数的值
     */
    public List findByNamedQueryAndNamedParam(String queryName, String paramName, Object value){
        return hibernatetemplate.findByNamedQueryAndNamedParam(queryName,paramName,value);
    }

    /**
     * 通过引用查询得到查询结果
     *  String queryName，查询名字
     *  String[] paramName,参数名字的数组
     *  String[] value,参数值的数组
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
            throw new SysException("分页查询错误", msg, e, this.getClass());
        } finally {
            if (s != null) {
                try {
                    s.close();
                } catch (Exception e) {
                    new SysException("关闭session错误", "", e, getClass());
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
            throw new SysException("参数分页查询错误", "", e, getClass());
        } finally {
            if (s != null) {
                try {
                    s.close();
                } catch (Exception e) {
                    new SysException("关闭session错误", "", e, getClass());
                }
            }
        }
    }
}
