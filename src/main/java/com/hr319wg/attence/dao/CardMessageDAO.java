package com.hr319wg.attence.dao;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttChangeWorkBO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class CardMessageDAO extends BaseDAO {
	public List findAttOutWorkBO(String personId, PageVO mypage, String argment)
			throws SysException {
		String hsql = "select bo from AttOutWorkBO bo where (bo.personID='"
				+ personId + "' or bo.personGroupID like '%" + personId
				+ "%') ";
		String countsql = "select count(bo) from AttOutWorkBO bo where (bo.personID='"
				+ personId
				+ "' or bo.personGroupID like '%"
				+ personId
				+ "%') ";
		if ("2".equals(argment) || "3".equals(argment) || "4".equals(argment)) {
			hsql += " and  (bo.statusValue='-1' or bo.statusValue='0' or bo.statusValue='1' or bo.statusValue='2')";
			countsql += " and  (bo.statusValue='-1' or bo.statusValue='0' or bo.statusValue='1' or bo.statusValue='2')";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List findAttEvcctionRecBO(String personId, PageVO mypage,
			String argment) throws SysException {
		String hsql = "select bo from AttEvcctionRecBO bo where (bo.personID='"
				+ personId + "' or bo.personGroupID like '%" + personId
				+ "%') ";
		String countsql = "select count(bo) from AttEvcctionRecBO bo where (bo.personID='"
				+ personId
				+ "'  or bo.personGroupID like '%"
				+ personId
				+ "%') ";

		if ("2".equals(argment) || "3".equals(argment) || "4".equals(argment)) {
			hsql += " and  (bo.statusValue='-1' or bo.statusValue='0' or bo.statusValue='1' or bo.statusValue='2')";
			countsql += " and  (bo.statusValue='-1' or bo.statusValue='0' or bo.statusValue='1' or bo.statusValue='2')";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List findAttFurloughRecBO(String personId, PageVO mypage,
			String argment) throws SysException {
		String hsql = "select bo from AttFurloughRecBO bo where bo.personID='"
				+ personId + "' ";
		String countsql = "select count(bo) from AttFurloughRecBO bo where bo.personID='"
				+ personId + "' ";
		if ("2".equals(argment) || "3".equals(argment) || "4".equals(argment)) {
			hsql += " and  (bo.statusValue='-1' or bo.statusValue='0' or bo.statusValue='1' or bo.statusValue='2')";
			countsql += " and  (bo.statusValue='-1' or bo.statusValue='0' or bo.statusValue='1' or bo.statusValue='2')";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAttFurloughRecCollectBO(String personId, PageVO mypage)
			throws SysException {
		String hsql = "select bo from AttFurloughRecCollectBO bo where bo.personID='"
				+ personId + "' ";
		String countsql = "select count(bo) from AttFurloughRecCollectBO bo where bo.personID='"
				+ personId + "' ";
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAttEvcctionRecCollectBO(String personId, PageVO mypage)
			throws SysException {
		String hsql = "select bo from AttEvcctionRecCollectBO bo where bo.personID='"
				+ personId + "' ";
		String countsql = "select count(bo) from AttEvcctionRecCollectBO bo where bo.personID='"
				+ personId + "' ";
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAttOutWorkCollectBO(String personId, PageVO mypage)
			throws SysException {
		String hsql = "select bo from AttOutWorkCollectBO bo where bo.personID='"
				+ personId + "' ";
		String countsql = "select count(bo) from AttOutWorkCollectBO bo where bo.personID='"
				+ personId + "' ";
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List findAttFurloughRecCollectBO(String id) throws SysException {
		String hsql = "select bo from AttFurloughRecCollectBO bo where bo.furloughNO='"
				+ id + "'";
		return this.hibernatetemplate.find(hsql);

	}

	public List findAttEvcctionRecCollectBO(String id, String personID)
			throws SysException {
		String hsql = "select bo from AttEvcctionRecCollectBO bo where bo.evcctionNo='"
				+ id + "' and bo.personID='" + personID + "'";
		return this.hibernatetemplate.find(hsql);

	}

	public List findAttOutWorkCollectBO(String id, String personID)
			throws SysException {
		String hsql = "select bo from AttOutWorkCollectBO bo where bo.outWorkNo='"
				+ id + "' and bo.personID='" + personID + "'";
		return this.hibernatetemplate.find(hsql);

	}

	public List findAttFurloughRecBO(String id) throws SysException {
		String hsql = "select bo from AttFurloughRecBO bo where bo.superFurloughNo='"
				+ id + "'";
		return this.hibernatetemplate.find(hsql);

	}

	public List findAttEvcctionRecBO(String id) throws SysException {
		String hsql = "select bo from AttEvcctionRecBO bo where bo.superFurloughNo='"
				+ id + "'";
		return this.hibernatetemplate.find(hsql);

	}

	public List findAttOutWorkBO(String id) throws SysException {
		String hsql = "select bo from AttOutWorkBO bo where bo.superFurloughNo='"
				+ id + "'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttAnnualDetailAuditBO(String orgId, PageVO mypage,
			boolean isExist, String operID, String deptID, String cancel,String queryValue)
			throws SysException {
		String hsql = "select bo from AttAnnualDetailAuditBO bo where bo.personID in ";

		String countsql = "select count(bo) from AttAnnualDetailAuditBO bo where bo.personID in ";

		if ("0562".equals(operID)) {
			hsql += "(select vo.id from AttClassGroupVO vo where (vo.name like '%"+queryValue+"%' or vo.simpleName like '%"+queryValue+"%' or vo.personSeq like '%"+queryValue+"%') and vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where (vo.name like '%"+queryValue+"%' or vo.simpleName like '%"+queryValue+"%' or vo.personSeq like '%"+queryValue+"%') and vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
		} else {
			hsql += "(select vo.id from AttClassGroupVO vo where (vo.name like '%"+queryValue+"%' or vo.simpleName like '%"+queryValue+"%' or vo.personSeq like '%"+queryValue+"%') and vo.orgId like '"
					+ orgId + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where (vo.name like '%"+queryValue+"%' or vo.simpleName like '%"+queryValue+"%' or vo.personSeq like '%"+queryValue+"%') and vo.orgId like '"
					+ orgId + "' and " + cancel + ")";
		}

		hsql += " and bo.statusValue<>'-1'";
		countsql += " and bo.statusValue<>'-1'";

		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);

	}

	public List getAttOverTimeRecBO(String id, String day) throws SysException {
		String hsql = "select bo from AttOverTimeRecBO bo where bo.personID='"
				+ id + "' and (bo.beginTime like '" + day
				+ "%' or bo.endTime like '" + day + "%')";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttAddWorkRecBO(String personId, PageVO mypage,
			boolean isExist) throws SysException {
		String hsql = "select bo from AttOverTimeRecBO bo where bo.personID='"
				+ personId + "'";
		String countsql = "select count(bo) from AttOverTimeRecBO bo where bo.personID='"
				+ personId + "' ";
		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List findAttChangeWorkBO(String id, String day) throws SysException {
		String hsql = "select bo from AttChangeWorkBO bo where bo.personID='"
				+ id + "' and bo.applyDate='" + day + "'";
		return this.hibernatetemplate.find(hsql);
	}
	
	public Hashtable findALLMonthAttChangeWorkBO(String month)throws SysException{
		Hashtable hash=new Hashtable();
		String hsql = "select bo from AttChangeWorkBO bo where bo.applyDate like '%" + month + "%' and bo.statusValue='3'";
		List list=this.hibernatetemplate.find(hsql);
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				AttChangeWorkBO bo=(AttChangeWorkBO)list.get(i);
				hash.put(bo.getPersonID()+bo.getApplyDate(), bo);
			}
		}
		return hash;
	}
	
	public List findAttenceSecondDayLogBO(String id, String day,
			String secondDay) throws SysException {
		String hsql = "select bo from AttenceSecondDayLogBO bo where bo.personId='"
				+ id
				+ "' and bo.attenceDate='"
				+ day
				+ "' and bo.secondDay like '%" + secondDay + "%'";
		return this.hibernatetemplate.find(hsql);
	}
	

	public List findA807(String personID, String day) throws SysException {
		String hsql = "select bo from AttenceSecondDayLogBO bo where bo.personId='"
				+ personID + "' and bo.attenceDate like '" + day + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List findA809(String personID, String day) throws SysException {
		String hsql = "select bo from AttenceDayLogBO bo where bo.personId='"
				+ personID + "' and bo.attenceDate='" + day + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttChangeWorkBO(String personId, PageVO mypage,
			boolean isExist) throws SysException {
		String hsql = "select bo from AttChangeWorkBO bo where bo.personID='"
				+ personId + "'";
		String countsql = "select count(bo) from AttChangeWorkBO bo where bo.personID='"
				+ personId + "' ";
		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAttChangeWorkBO1(String personId, PageVO mypage,
			boolean isExist) throws SysException {
		String hsql = "select bo from AttChangeWorkBO bo where bo.personID in ";
		hsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
				+ personId + "')";
		String countsql = "select count(bo) from AttChangeWorkBO bo where bo.personID in ";
		countsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
				+ personId + "')";
		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAttChangeWorkBO2(String personId) throws SysException {
		String hsql = "select bo from AttChangeWorkBO bo where bo.personID='"
				+ personId + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttChangeWorkBO3(String personId, String aDate)
			throws SysException {
		String hsql = "select bo from AttChangeWorkBO bo where bo.personID='"
				+ personId + "' and bo.applyDate like '" + aDate
				+ "%' and bo.statusValue='3'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAllAttEvcctionRecBO(String id, String day, AttClassBO b)
			throws SysException {
		String hsql = "select bo from AttEvcctionRecBO bo where bo.personID='"
				+ id + "' and bo.beginTime like '" + day
				+ "%' and bo.endTime like '" + day + "%'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttEvcctionRecBO1(String id, String day)
			throws SysException {
		String hsql = "select bo from AttEvcctionRecBO bo where bo.personID='"
				+ id + "' and (bo.beginTime like '" + day
				+ "%' or bo.endTime like '" + day
				+ "%') and bo.statusValue='3'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttEvcctionRecCollectBO(String id, String day)
			throws SysException {
		String hsql = "select bo from AttEvcctionRecCollectBO bo where bo.personID='"
				+ id
				+ "' and (bo.beginTime like '"
				+ day
				+ "%' or bo.endTime like '" + day + "%')";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttOutWorkCollectBO(String id, String day)
			throws SysException {
		String hsql = "select bo from AttOutWorkCollectBO bo where bo.personID='"
				+ id
				+ "' and (bo.beginTime like '"
				+ day
				+ "%' or bo.endTime like '" + day + "%')";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttOverTimeLogCollectBO(String id, String day)
			throws SysException {
		String hsql = "select bo from AttOverTimeLogBO bo where bo.personID='"
				+ id + "' and (bo.beginTime like '" + day
				+ "%' or bo.endTime like '" + day + "%')";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttAnnualDetailAuditBO(String id, String day)
			throws SysException {
		String hsql = "select bo from AttAnnualDetailAuditBO bo where bo.personID='"
				+ id
				+ "' and (bo.holidayBegin like '"
				+ day
				+ "%' or bo.holidayEnd like '"
				+ day
				+ "%') and bo.statusValue='3'";
		return this.hibernatetemplate.find(hsql);

	}

	public List findAttFurloughRecAndAttAnnualDetailAuditBO(String id,
			String furloughNo) throws SysException {
		String hsql = "select bo from AttAnnualDetailAuditBO bo where bo.personID='"
				+ id
				+ "' and bo.furloughno='"
				+ furloughNo
				+ "' and bo.statusValue='3'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttTimeOffCollectBO(String id, String day)
			throws SysException {
		String hsql = "select bo from AttTimeOffRecBO bo where bo.personID='"
				+ id + "' and (bo.beginTime like '" + day
				+ "%' or bo.endTime like '" + day + "%')";
		return this.hibernatetemplate.find(hsql);

	}

	public List findAttenceDayLogBO(String id, String day) throws SysException {
		String hsql = "select bo from AttenceDayLogBO bo where bo.personId='"
				+ id + "' and bo.attenceDate='" + day + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttFurloughRecBO(String id, String day, AttClassBO b)
			throws SysException {
		String hsql = "select bo from AttFurloughRecBO bo where bo.personID='"
				+ id + "' and (bo.beginTime like '" + day
				+ "%' or bo.endTime like '" + day + "%') and bo.superFlId='1'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttFurloughRecBO1(String id, String day) throws SysException {
		String hsql = "select bo from AttFurloughRecBO bo where bo.personID='"
				+ id + "' and (bo.beginTime like '" + day
				+ "%' or bo.endTime like '" + day
				+ "%') and bo.statusValue='3'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttFurloughRecCollectBO(String id, String day)
			throws SysException {
		String hsql = "select bo from AttFurloughRecCollectBO bo where bo.personID='"
				+ id
				+ "' and (bo.beginTime like '"
				+ day
				+ "%' or bo.endTime like '" + day + "%')";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttEvcctionRecBO(String personId, PageVO mypage,
			boolean isExist) throws SysException {
		String hsql = "select bo from AttEvcctionRecBO bo where bo.personID='"
				+ personId + "'";
		String countsql = "select count(bo) from AttEvcctionRecBO bo where bo.personID='"
				+ personId + "' ";
		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAttEvcctionRecBO1(String personId, PageVO mypage,
			boolean isExist, String operID, String deptID, String cancel)
			throws SysException {
		String hsql = "select bo from AttEvcctionRecBO bo where bo.personID in ";

		String countsql = "select count(bo) from AttEvcctionRecBO bo where bo.personID in ";

		if ("0533".equals(operID)) {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
		} else {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
		}

		hsql += " and bo.statusValue<>'-1'";
		countsql += " and bo.statusValue<>'-1'";

		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAttOutWorkBO1(String personId, PageVO mypage,
			boolean isExist, String operID, String deptID, String cancel)
			throws SysException {
		String hsql = "select bo from AttOutWorkBO bo where bo.personID in ";

		String countsql = "select count(bo) from AttOutWorkBO bo where bo.personID in ";

		if ("0573".equals(operID)) {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
		} else {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
		}

		hsql += " and bo.statusValue<>'-1'";
		countsql += " and bo.statusValue<>'-1'";

		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAttOverTimeRecBO(String personId, PageVO mypage,
			boolean isExist, String operID, String deptID, String cancel)
			throws SysException {
		String hsql = "select bo from AttOverTimeRecBO bo where bo.personID in ";

		String countsql = "select count(bo) from AttOverTimeRecBO bo where bo.personID in ";

		if ("0555".equals(operID)) {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
		} else {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
		}

		hsql += " and bo.statusValue<>'-1'";
		countsql += " and bo.statusValue<>'-1'";

		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAllAttfurloughBO() throws SysException {
		String hsql = "select bo from AttfurloughBO bo ";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttClassGroupVO(String orgid) throws SysException {
		OrgBO org=SysCacheTool.findOrgById(orgid);
		String hsql = "select bo from AttClassGroupVO bo where   bo.orgTreeId like '%"
				+ org.getTreeId() + "%' or  bo.deptTreeId like '%" + org.getTreeId() + "%'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllPersonTable(String orgid, String name, String personType)
			throws SysException {
		String hsql = "select bo from AttClassGroupVO bo where bo.id not like '@%' and bo.id not like '#%' and bo.orgId='"
				+ orgid
				+ "' and (bo.name like '%"
				+ name
				+ "%' or bo.simpleName like '%"
				+ name
				+ "%' or bo.personSeq like '%"
				+ name
				+ "%' or bo.oldPersonSeq like '%" + name + "%') ";
		if (personType != null && !"".equals(personType)) {
			hsql += " and bo.personType in (" + personType + ")";
		}
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttFurloughRecBO(String personId, PageVO mypage,
			boolean isExist) throws SysException {
		String hsql = "select bo from AttFurloughRecBO bo where bo.personID='"
				+ personId + "' ";
		String countsql = "select count(bo) from AttFurloughRecBO bo where bo.personID='"
				+ personId + "' ";
		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List getAttFurloughRecBO1(String personId, PageVO mypage,
			boolean isExist, String operID, String deptID, String cancel)
			throws SysException {
		// OrgBO orgbo = SysCacheTool.findOrgById(personId);
		String hsql = "select bo from AttFurloughRecBO bo where bo.personID in ";

		String countsql = "select count(bo) from AttFurloughRecBO bo where bo.personID in ";

		if ("0530".equals(operID)) {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
		} else {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
		}

		hsql += " and bo.statusValue<>'-1'";
		countsql += " and bo.statusValue<>'-1'";

		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);

	}

    public List getAttenceLogBOLogByPidAndMonth(String personId,String month)throws SysException{
        String hql="select bo from AttenceLogBO bo where bo.personId='"+personId+"' and bo.cardDate like '%"+month+"%' order by bo.cardTime";
        return this.hibernatetemplate.find(hql);
    }

	public List getAttenceLogBOLog(String personId, String cardDate)
			throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ personId + "' and bo.cardDate='" + cardDate
				+ "' order by bo.cardDate,bo.cardTime";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttenceLogBOLogs(String personId, String cardDate,
			String beginTime, String endTime) throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ personId + "' and bo.cardDate='" + cardDate
				+ "' and bo.cardTime>='" + beginTime + "' and  bo.cardTime<='"
				+ endTime + "'  order by bo.cardTime";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttenceLogBOLog1(String personId, String beginDate,
			String beginTime, String endDate, String endTime)
			throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ personId + "' and  (bo.cardDate='" + beginDate
				+ "' and bo.cardTime>='" + beginTime + "') and  (bo.cardDate='"
				+ endDate + "' and bo.cardTime<='" + endTime
				+ "')  order by bo.cardTime";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttenceLogBOLog2(String personId, String cardDate,
			String cardTime) throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ personId + "' and bo.cardDate='" + cardDate
				+ "' and bo.cardTime>'" + cardTime + "' order by bo.cardTime";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttenceLogBOLog3(String personId, String cardDate,
			String cardTime) throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ personId + "' and bo.cardDate='" + cardDate
				+ "' and bo.cardTime<'" + cardTime + "' order by bo.cardTime";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttenceLogBO(String personId, String cardDate)
			throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ personId + "' and bo.cardDate like'" + cardDate
				+ "%' order by bo.personId";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttenceDayMonthBO(String personId) throws SysException {
		String hsql = "select bo from AttenceDayMonthBO bo where bo.personId='"
				+ personId + "' and bo.record like '00901'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttenceLogBO(PageVO pagevo,String userid, String beginDate, String endDate,String findseevalue)
			throws SysException {
		OrgBO org=SysCacheTool.findOrgById(userid);
		String hsql = "select bo from AttenceLogBO bo where bo.personId in ";
		String countHql="select count(bo) from AttenceLogBO bo where bo.personId in ";
		hsql += "(select vo.id from AttClassGroupVO vo where  (vo.deptTreeId like '%"
				+ org.getTreeId() + "%' or vo.orgTreeId like '%" + org.getTreeId() + "%')";
		countHql+="(select vo.id from AttClassGroupVO vo where  (vo.deptTreeId like '%"
			+ org.getTreeId() + "%' or vo.orgTreeId like '%" + org.getTreeId() + "%')";
		
		if(findseevalue!=null&&!"".equals(findseevalue)){
			hsql+=" and (vo.name like '%"+findseevalue+"%' or vo.simpleName like '%"+findseevalue+"%')";
			countHql+=" and (vo.name like '%"+findseevalue+"%' or vo.simpleName like '%"+findseevalue+"%')";
		}
		hsql+=") ";
		countHql+=") ";
		if (beginDate != null && !"".equals(beginDate)) {
			hsql += "  and bo.cardDate>='" + beginDate + "'";
			countHql+="  and bo.cardDate>='" + beginDate + "'";
		}

		if (endDate != null && !"".equals(endDate)) {
			hsql += "  and bo.cardDate<='" + endDate + "'";
			countHql+="  and bo.cardDate<='" + endDate + "'";
		}

		hsql += " order by bo.cardDate";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql, hsql);
		}else{
			return this.hibernatetemplate.find(hsql);
		}
	}

	public List getAttenceLogBO1(String userid, String beginDate, String endDate)
			throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ userid + "'";

		if (beginDate != null && !"".equals(beginDate)) {
			hsql += "  and bo.cardDate>='" + beginDate + "'";
		}

		if (endDate != null && !"".equals(endDate)) {
			hsql += "  and bo.cardDate<='" + endDate + "'";
		}

		hsql += " order by bo.cardDate desc,bo.cardTime asc";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttenceLogBO2(String userid, String day) throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ userid + "'";

		if (day != null && !"".equals(day)) {
			hsql += "  and bo.cardDate='" + day + "'";
		}

		hsql += " order by bo.cardDate desc,bo.cardTime asc";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttenceLogBO3(String userid, String day) throws SysException {
		String hsql = "select bo from AttenceLogBO bo where bo.personId='"
				+ userid + "'";

		if (day != null && !"".equals(day)) {
			hsql += "  and bo.cardDate='" + day + "'";
		}

		hsql += " order by bo.cardDate desc,bo.cardTime asc";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttenceDayLogBO(String userid, String beginDate,
			String endDate) throws SysException {
		String hsql = "select bo from AttenceDayLogBO bo where bo.personId='"
				+ userid + "'";

		if (beginDate != null && !"".equals(beginDate)) {
			hsql += "  and bo.attenceDate>='" + beginDate + "'";
		}

		if (endDate != null && !"".equals(endDate)) {
			hsql += "  and bo.attenceDate<='" + endDate + "'";
		}

		hsql += " order by bo.attenceDate";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttenceDayLogBO(String userid, String beginDate)
			throws SysException {
		String hsql = "select bo from AttenceDayLogBO bo where bo.personId='"
				+ userid + "' and bo.attenceDate like'" + beginDate + "%'";
		hsql += " order by bo.personId";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttenceDayMonthBOS(String userid, String beginDate,
			String endDate) throws SysException {
		String hsql = "select bo from AttenceDayLogBO bo where bo.personId='"
				+ userid + "' and bo.attenceDate>='" + beginDate
				+ "' and bo.attenceDate<='" + endDate + "'";
		hsql += " order by bo.personId";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttenceDayMonthBO(String userid, String beginDate,
			String endDate) throws SysException {
		String hsql = "select bo from AttenceDayMonthBO bo where bo.personId='"
				+ userid + "'";

		if (beginDate != null && !"".equals(beginDate)) {
			hsql += "  and bo.attenceDate>='" + beginDate + "'";
		}

		if (endDate != null && !"".equals(endDate)) {
			hsql += "  and bo.attenceDate<='" + endDate + "'";
		}

		hsql += " order by bo.attenceDate";
		return this.hibernatetemplate.find(hsql);

	}

	public List getEvcctionStateSearch(String orgId, PageVO mypage)
			throws SysException {
		String hsql = "select bo from AttEvcctionRecCollectBO bo where bo.personID in ";
		String countsql = "select count(bo) from AttEvcctionRecCollectBO bo where bo.personID in ";

		hsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
				+ orgId + "' or vo.deptId like '" + orgId + "') ";
		countsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
				+ orgId + "' or vo.deptId like '" + orgId + "') ";

		hsql += " and  bo.statusValue='3'";
		countsql += " and  bo.statusValue='3'";

		return this.pageQuery(mypage, countsql, hsql);

	}

	public List getAttMimicReportRecBO(String personId, PageVO mypage,
			boolean isExist) throws SysException {
		String hsql = "select bo from AttMimicReportRecBO bo where bo.personID='"
				+ personId + "'";
		String countsql = "select count(bo) from AttMimicReportRecBO bo where bo.personID='"
				+ personId + "' ";
		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List findAttOverTimeRecBO(String personId, PageVO mypage,
			boolean isExist, String operID, String deptID, String cancel)
			throws SysException {
		String hsql = "select bo from AttMimicReportRecBO bo where bo.personID in ";

		String countsql = "select count(bo) from AttMimicReportRecBO bo where bo.personID in ";

		if ("0542".equals(operID)) {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.deptId like '"
					+ deptID + "' and " + cancel + ")";
		} else {
			hsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
			countsql += "(select vo.id from AttClassGroupVO vo where  vo.orgId like '"
					+ personId + "' and " + cancel + ")";
		}

		hsql += " and bo.statusValue<>'-1'";
		countsql += " and bo.statusValue<>'-1'";

		if (!isExist) {
			hsql += " and  bo.statusValue<>'3'";
			countsql += " and  bo.statusValue<>'3'";
		}
		return this.pageQuery(mypage, countsql, hsql);
	}

	public List findAttOverTimeLogBO(String personId, String date)
			throws SysException {
		String hsql = "select bo from AttOverTimeRecBO bo where bo.personID='"
				+ personId + "' and  (bo.beginTime like'" + date
				+ "%' or bo.endTime like'" + date + "%')";
		hsql += " order by bo.personID";
		return this.hibernatetemplate.find(hsql);
	}

	public List findAttTimeOffRecBO(String overTimeNO) throws SysException {
		String hsql = "select bo from AttTimeOffRecBO bo where bo.overTimeNO='"
				+ overTimeNO + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttAnnualDetailAuditBO(String personId, String furloughno)
			throws SysException {
		String hsql = "select bo from AttAnnualDetailAuditBO bo where bo.personID='"
				+ personId + "' and bo.furloughno='" + furloughno + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAttAnnualDetailBO(String itemID, String furloughNo)
			throws SysException {
		String hsql = "select bo from AttAnnualDetailBO bo where bo.itemID='"
				+ itemID + "' and bo.furloughNo='" + furloughNo + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List findAttTimeOffRecBO(String personId, String overTimeNO)
			throws SysException {
		String hsql = "select bo from AttTimeOffRecBO bo where bo.personID='"
				+ personId + "' and  bo.overTimeNO='" + overTimeNO
				+ "' and bo.statusValue<>'3'";
		return this.hibernatetemplate.find(hsql);
	}
}
