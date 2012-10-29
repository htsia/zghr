package com.hr319wg.attence.dao;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.common.Constants;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class GroupMgrDAO extends BaseDAO {
	
	
	public List getAllATTRearrangeDateBO(String orgid) throws SysException {
		String hsql = "select bo from ATTRearrangeDateBO bo where bo.groupNo='"
				+ orgid + "' order by bo.beginDate desc";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAllAttClassGroupBOType(String orgid) throws SysException {
		String hsql = "select bo from AttClassGroupBO bo where bo.orgID='"
				+ orgid + "'";
		return this.hibernatetemplate.find(hsql);
	}
	
	public List getAllAttClassGroupBO()throws SysException{
		String hql="select bo from AttClassGroupBO bo";
		return this.hibernatetemplate.find(hql);
	}

	public List getAllAttClassGroupBOType1(String orgid) throws SysException {
		String hsql = "select bo from AttClassGroupBO bo where bo.orgID='"
				+ orgid + "' and bo.groupType='4'";
		return this.hibernatetemplate.find(hsql);
	}

    public Hashtable getAllAttClassGroupBOForHash()throws SysException{
        String hql="select bo from AttClassGroupBO bo ";
        List list=this.hibernatetemplate.find(hql);
        Hashtable hash=new Hashtable();
        if(list!=null&&list.size()>0){
              for(int i=0;i<list.size();i++){
                  AttClassGroupBO bo=(AttClassGroupBO)list.get(i);
                  hash.put(bo.getGroupNo(),bo);
              }
        }
        return hash;
    }

    /**
     * 查询所有班次
     * @param orgid 所属机构
     * @return
     * @throws SysException
     */
	public List getAllAttClassBOType(String orgid) throws SysException {
		String hsql = "select bo from AttClassBO bo where bo.isUse='1'";
        if(orgid!=null&&!orgid.equals("")){
            hsql+=" and (bo.orgID='-1' or bo.orgID='"+ orgid + "')";
        }
		return this.hibernatetemplate.find(hsql);
	}

    public Hashtable getAllAttClassBOForHash()throws SysException{
        String hql="select bo from AttClassBO bo";
        Hashtable hash=new Hashtable();
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
             for(int i=0;i<list.size();i++){
                     AttClassBO bo=(AttClassBO)list.get(i);
                     hash.put(bo.getClassID(),bo);
             }
        }
        return hash;
    }

	public List getAllAttClassGroupVO(PageVO pagevo, String orgid,
			String groupNo,String queryValue) throws SysException {
		String hsql = "select bo from AttClassGroupVO bo where  bo.orgId='"
				+ orgid + "' and  bo.groupNo='" + groupNo + "'";
		String countsql = "select count(bo) from AttClassGroupVO bo where bo.orgId='"
				+ orgid + "' and  bo.groupNo='" + groupNo + "'";
        if(queryValue!=null&&!queryValue.equals("")){
             hsql+=" and (bo.name like '%"+queryValue+"%' or bo.simpleName like '%"+queryValue+"%' or bo.personSeq like '%"+queryValue+"%')";
            countsql+=" and (bo.name like '%"+queryValue+"%' or bo.simpleName like '%"+queryValue+"%' or bo.personSeq like '%"+queryValue+"%')";
        }
		return this.pageQuery(pagevo, countsql, hsql);

	}

	public List getAllAttClassGroupVO1(PageVO pagevo, String orgid)
			throws SysException {
		OrgBO org=SysCacheTool.findOrgById(orgid);
		String hsql = "";
		String countsql = "";
		hsql = "select bo from AttClassGroupVO bo where bo.id not like '@%' and ( bo.groupNo is null or bo.groupNo='' or bo.groupNo not in(select go.groupNo from AttClassGroupBO go ))   and "
					+" bo.deptTreeId like '%" + org.getTreeId() + "%'";
		countsql = "select count(bo) from AttClassGroupVO bo where bo.id not like '@%' and bo.id not like '#%' and ( bo.groupNo is null or bo.groupNo='' or bo.groupNo not in(select go.groupNo from AttClassGroupBO go ))   and "
					 +" bo.deptTreeId like '%" + org.getTreeId() + "%'";
		return this.pageQuery(pagevo, countsql, hsql);

	}

	public List getAllAttClassGroupVO2(PageVO pagevo, String orgid)
			throws SysException {
		String hsql = "";
		String countsql = "";
		if ("ORACLE".equals(Constants.DB_TYPE)) {
			hsql = "select bo from AttClassGroupVO bo where ( bo.groupNo is not null or bo.groupNo<>'') and  (bo.orgId='"
					+ orgid + "' or bo.deptId='" + orgid + "')";
			countsql = "select count(bo) from AttClassGroupVO bo where ( bo.groupNo is not null or bo.groupNo<>'') and  (bo.orgId='"
					+ orgid + "' or bo.deptId='" + orgid + "')";
		} else {
			hsql = "select bo from AttClassGroupVO bo where  bo.groupNo is not  null and  bo.groupNo<>'' and  (bo.orgId='"
					+ orgid + "' or bo.deptId='" + orgid + "')";
			countsql = "select count(bo) from AttClassGroupVO bo where  bo.groupNo is not  null and  bo.groupNo<>'' and  (bo.orgId='"
					+ orgid + "' or bo.deptId='" + orgid + "')";
		}
		return this.pageQuery(pagevo, countsql, hsql);

	}

	public List getAllAttClassGroupVO3(PageVO pagevo, String orgid,
			String findSeeValue) throws SysException {
		String hsql = "";
		String countsql = "";
		if ("ORACLE".equals(Constants.DB_TYPE)) {
			hsql = "select bo from AttClassGroupVO bo where ( bo.groupNo is not null or bo.groupNo<>'') and  (bo.orgId='"
					+ orgid + "' or bo.deptId='" + orgid + "')";
			countsql = "select count(bo) from AttClassGroupVO bo where ( bo.groupNo is not null or bo.groupNo<>'') and  (bo.orgId='"
					+ orgid + "' or bo.deptId='" + orgid + "')";
		} else {
			hsql = "select bo from AttClassGroupVO bo where  bo.groupNo is not  null and  bo.groupNo<>'' and  (bo.orgId='"
					+ orgid + "' or bo.deptId='" + orgid + "')";
			countsql = "select count(bo) from AttClassGroupVO bo where  bo.groupNo is not  null and  bo.groupNo<>'' and  (bo.orgId='"
					+ orgid + "' or bo.deptId='" + orgid + "')";
		}

		if (findSeeValue != null && !"".equals(findSeeValue)) {
			hsql += " and (bo.name like'%" + findSeeValue
					+ "%' or  bo.personSeq like '%" + findSeeValue + "%')";
			countsql += " and (bo.name like'%" + findSeeValue
					+ "%' or  bo.personSeq like '%" + findSeeValue + "%')";
		}

		return this.pageQuery(pagevo, countsql, hsql);

	}

	public List getAllAttClassGroupVOSS(String personSeq) throws SysException {
		String hql = "select bo from AttClassGroupVO bo where bo.personSeq='"
				+ personSeq + "'";
		return this.hibernatetemplate.find(hql);
	}

	public List getATTRearrangeBO(String orgid) throws SysException {
		String hql = "select bo from ATTRearrangeBO bo where bo.groupNo='"
				+ orgid + "'";
		return this.hibernatetemplate.find(hql);
	}

	public List findATTRearrangeBO1(String orgid, String dayseq)
			throws SysException {
		String hql = "select bo from ATTRearrangeBO bo where bo.groupNo='"
				+ orgid + "' and  bo.daySeq=" + dayseq + "'";
		return this.hibernatetemplate.find(hql);
	}

	public List getAllATTRearrangeBO(PageVO pagevo, String orgid)
			throws SysException {
		String hsql = "select bo from ATTRearrangeBO bo where bo.groupNo='"
				+ orgid + "'";
		String countsql = "select count(bo) from ATTRearrangeBO bo where bo.groupNo='"
				+ orgid + "'";
        if(pagevo!=null){
		    return this.pageQuery(pagevo, countsql, hsql);
        }else{
            return this.hibernatetemplate.find(hsql);
        }

	}

	public List getAllAttPersonArrangeItemBO(String personId, String aDate)
			throws SysException {
		String hsql = "select bo from AttPersonArrangeItemBO bo where bo.personId='"
				+ personId + "' and bo.createDay='" + aDate + "'";
		return this.hibernatetemplate.find(hsql);
	}
	
}
