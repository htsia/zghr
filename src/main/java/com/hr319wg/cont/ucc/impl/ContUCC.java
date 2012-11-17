package com.hr319wg.cont.ucc.impl;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.cont.pojo.bo.ContBO;
import com.hr319wg.cont.pojo.bo.ContPersonBO;
import com.hr319wg.cont.pojo.bo.ContSignBO;
import com.hr319wg.cont.service.ContPersonService;
import com.hr319wg.cont.service.ContService;
import com.hr319wg.cont.ucc.IContUCC;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.service.UserManageService;
import com.hr319wg.util.CommonFuns;

public class ContUCC implements IContUCC {
	private ContService contservice;
	private ContPersonService contpersonservice;
	private ActivePageAPI sysactivepageapi;
	private UserManageService userservice;

	public UserManageService getUserservice() {
		return this.userservice;
	}

	public void setUserservice(UserManageService personservice) {
		this.userservice = personservice;
	}

	public ContPersonService getContpersonservice() {
		return this.contpersonservice;
	}

	public void setContpersonservice(ContPersonService contpersonservice) {
		this.contpersonservice = contpersonservice;
	}

	public ContService getContservice() {
		return this.contservice;
	}

	public void setContservice(ContService contservice) {
		this.contservice = contservice;
	}

	public String getMaxContNo() throws SysException {
		String sql = "select max(cont_code) from cont_info";
		return this.sysactivepageapi.queryForString(sql);
	}

	public String getMaxContNo(String pre) throws SysException {
		String sql = "select max(cont_code) from cont_info where cont_code like '"
				+ pre + "%'";
		return this.sysactivepageapi.queryForString(sql);
	}

	public ActivePageAPI getSysactivepageapi() {
		return this.sysactivepageapi;
	}

	public void setSysactivepageapi(ActivePageAPI sysactivepageapi) {
		this.sysactivepageapi = sysactivepageapi;
	}

	public ContBO[] queryAll(String createOrgId, String personName,
			String approveStatus, PageVO vo) throws SysException {
		return this.contservice.queryAll(createOrgId, personName,
				approveStatus, vo);
	}

	public ContBO[] queryAllByApproveOrgId(String approveOrgId,
			String personName, String approveStatus, PageVO vo, String contOper)
			throws SysException {
		return this.contservice.queryAllByApproveOrgId(approveOrgId,
				personName, approveStatus, vo, contOper);
	}

	public ContBO[] queryAllByApproveOrgId(String approveOrgId,
			String personName, String approveStatus, PageVO vo)
			throws SysException {
		return this.contservice.queryAllByApproveOrgId(approveOrgId,
				personName, approveStatus, vo);
	}

	public ContBO[] queryAllByPersonId(String createOrgId, String personId)
			throws SysException {
		return this.contservice.queryAllByPersonId(createOrgId, personId);
	}

	public ContBO[] queryAllByTemplateId(String createOrgId, String templateId)
			throws SysException {
		return this.contservice.queryAllByTemplateId(createOrgId, templateId);
	}

	public String createCont(ContBO bo) throws SysException {
		return this.contservice.createCont(bo);
	}

	public void updateCont(String contId, ContBO bo) throws SysException {
		this.contservice.updateCont(contId, bo);
	}

	public void deleteCont(String contId) throws SysException {
		this.contservice.deleteCont(contId);
	}

	public ContBO findContById(String contId) throws SysException {
		return this.contservice.findContById(contId);
	}

	public List makeLink(String[] ids, String validDate) throws SysException {
		String errorInfo = "";
		List contPersonBO_List = new ArrayList();
		try {
			for (int i = 0; i < ids.length; i++) {
				String[] temp = CommonFuns.getStringArray(ids[i], ",");
				ContBO contbo = this.contservice.findContById(temp[0]);
				String personId = contbo.getContPersonBO().getPersonId();
				ContPersonBO bo = this.contpersonservice
						.findContPersonById(personId);
				contPersonBO_List.add(bo);

				if ((("1".equals(Constants.CONT_AUDIT_MODE)) || ("2"
						.equals(Constants.CONT_AUDIT_MODE)))
						&& (!contbo.getApproveStatus().equals("201003"))) {
					errorInfo = "该人员的合同尚未审批通过,不允许进行合同执行：[" + bo.getPersonName()
							+ "]";
					throw new SysException("", "", null, getClass());
				}

				contbo.setIsValid("202002");
				contbo.setValidDate(validDate);

				bo.setIsValid("202002");

				String contStartDate = contbo.getContStartDate();
				String contEndDate = contbo.getContEndDate();
				String contTerm = "";
				if ((contStartDate != null) && (!contStartDate.equals(""))
						&& (contEndDate != null) && (!contEndDate.equals(""))) {
					int endYear = Integer.parseInt(contEndDate.substring(0, 4));
					int startYear = Integer.parseInt(contStartDate.substring(0,
							4));
					int endMon = Integer.parseInt(contEndDate.substring(5, 7));
					int startMon = Integer.parseInt(contStartDate.substring(5,
							7));
					int endDay = Integer.parseInt(contEndDate.substring(8));
					int startDay = Integer.parseInt(contStartDate.substring(8));

					int plus = 0;
					if ((endDay < 15) && (startDay > 15))
						plus = -1;
					else if ((endDay > 15) && (startDay < 15)) {
						plus = 1;
					}
					contTerm = String.valueOf((endYear - startYear) * 12
							+ (endMon - startMon) + plus);
				}

				String[] infoItems5 = { "A708703", "A708701", "A708705",
						"A708710", "A708715", "A708720", "A708205", "A708211",
						"A708213", "A708216", "A708217", "A708210", "A708209" };
				String[] ietmValues5 = {
						CommonFuns.filterNull(contbo.getContCode()),
						CommonFuns.filterNull(contbo.getContTermClass()),
						CommonFuns.filterNull(contbo.getContClass()),
						CommonFuns.filterNull(contbo.getContStartDate()),
						CommonFuns.filterNull(contbo.getContEndDate()),
						CommonFuns.filterNull(contbo.getSalaryClass()),
						CommonFuns.filterNull(contTerm),
						CommonFuns.filterNull(contbo.getProbationEndDate()),
						CommonFuns.filterNull(contbo.getProbationSalaryMoney()),
						CommonFuns.filterNull(contbo.getPraxisEndDate()),
						CommonFuns.filterNull(contbo.getBasicSalaryMoney()),
						CommonFuns.filterNull(contbo.getServiceStartDate()),
						CommonFuns.filterNull(contbo.getServiceEndDate()) };

				this.sysactivepageapi.updatePageInfo("A708", null,
						bo.getPersonId(), null, false, null, null, infoItems5,
						ietmValues5);

				String[] infoItems6 = { "A710000", "A710701", "A710705",
						"A710708", "A710715", "A710720", "A710727", "A710729",
						"A710731", "A710735", "A710738", "A710749", "A710755",
						"A710760", "A710725", "A710222", "A710200", "A710223",
						"A710215", "A710216" };

				String[] ietmValues6 = {
						"00901",
						CommonFuns.filterNull(contbo.getContCode()),
						CommonFuns.filterNull(contbo.getContTermClass()),
						CommonFuns.filterNull(contbo.getContClass()),
						CommonFuns.filterNull(contbo.getContStartDate()),
						CommonFuns.filterNull(contbo.getContEndDate()),
						CommonFuns.filterNull(contbo.getValidDate()),
						CommonFuns.filterNull(contbo.getPostName()),
						CommonFuns.filterNull(contbo.getWorkContent()),
						CommonFuns.filterNull(contbo.getWorkPlace()),
						CommonFuns.filterNull(contbo.getSalaryClass()),
						CommonFuns.filterNull(contbo.getContRemark()),
						CommonFuns.filterNull(contbo.getAttachmentId()),
						CommonFuns.filterNull(contbo.getAgreeTestify()),
						CommonFuns.filterNull(contbo.getProbationEndDate()),
						CommonFuns.filterNull(contbo.getProbationSalaryMoney()),
						CommonFuns.filterNull(contbo.getPraxisEndDate()),
						CommonFuns.filterNull(contbo.getBasicSalaryMoney()),
						CommonFuns.filterNull(contbo.getServiceStartDate()),
						CommonFuns.filterNull(contbo.getServiceEndDate()) };

				this.sysactivepageapi.addPageInfo("A710", null, null,
						bo.getPersonId(), false, infoItems6, ietmValues6);

				String[] infoItems7 = { "A725701", "A725705", "A725710",
						"A725715" };
				String[] ietmValues7 = {
						CommonFuns.filterNull(contbo.getApproveStatus()),
						CommonFuns.filterNull(contbo.getUptoValidDate()),
						CommonFuns.filterNull(contbo.getApprovePersonId()),
						CommonFuns.filterNull(contbo.getApproveDate()) };

				this.sysactivepageapi.updatePageInfo("A725", null,
						bo.getPersonId(), null, false, null, null, infoItems7,
						ietmValues7);

				if ("1".equals(Constants.EMP_ADD_AFTER_APPROVE)) {
					String updateSQL = "update a001 set A001730='00900' where id='"
							+ personId + "'";
					this.sysactivepageapi.executeSql(updateSQL);
				}

				this.contservice.updateCont(contbo.getContId(), contbo);
				this.contpersonservice.updateContPerson(bo.getPersonId(), bo);

				String[] tempStringArray = { bo.getPersonId() };
				SysCache.setMap(tempStringArray, 1, 6);
			}
		} catch (SysException ex) {
			throw new RollbackableException("E0600217", errorInfo, ex,
					getClass());
		}
		return contPersonBO_List;
	}

	public String getDismissPerson(TableVO table, User user, String orgid,
			String selectNewPersonIds) throws SysException {
		return this.contservice.getDismissPerson(table, user, orgid,
				selectNewPersonIds);
	}

	public String findContPostBObyId(String id) throws SysException {
		String sql = "SELECT C001005 FROM C001 WHERE POSTID in (select A001715 from A001 where ID='"
				+ id + "')";
		return this.sysactivepageapi.queryForString(sql);
	}

	public String findC019(String id) throws SysException {
		String sql = "SELECT C019700 FROM C019 WHERE POSTID in (select A001715 from A001 where ID='"
				+ id + "')";
		return this.sysactivepageapi.queryForString(sql);
	}

	public TableVO getContSheet(String superId, String where)
			throws SysException {
		return this.contservice.getContSheet(superId, where);
	}

	public void changeContMaster(String chgId) throws SysException {
		String sql = "update emp_chginfo set cont_old_end='1',cont_new_begin='1' where chg_id='"
				+ chgId + "'";
		this.sysactivepageapi.executeSql(sql);
	}

	public void batchAddFollowCont(List<ContSignBO> list) throws SysException {
		this.contservice.batchAddFollowCont(list);
	}
	
	public void updateContPerson(String ID) throws SysException{
		String sql = "update cont_person c set c.cont_class='022001' where c.person_id='"+ID+"'";
		this.sysactivepageapi.executeSql(sql);
	}
}