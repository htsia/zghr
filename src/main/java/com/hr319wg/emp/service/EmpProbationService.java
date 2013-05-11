package com.hr319wg.emp.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.dao.EmpProbationDAO;
import com.hr319wg.emp.pojo.bo.EmpProbationBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;
import java.util.List;

public class EmpProbationService implements IWFFunction {
	private EmpProbationDAO empprobationdao;
	private ActivePageAPI activeapi;

	public ActivePageAPI getActiveapi() {
		return this.activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}

	public List findNoPassPerson(PageVO pagevo, String orgId, User user, List statuses,
			String time1, String time2, String name) throws SysException {
		return this.empprobationdao.findNoPassPerson(pagevo, orgId, user, statuses,
				time1, time2, name);
	}

	public List findAllPerson(PageVO pagevo, String orgId, String operId,
			boolean selall, String filter) throws SysException {
		return this.empprobationdao.findAllPerson(pagevo, orgId, operId,
				selall, filter);
	}

	public List getAllProbationStatusPerson(String orgId, String status)
			throws SysException {
		return this.empprobationdao.getAllProbationStatusPerson(orgId, status);
	}

	public List getAllProbationWageByPid(String personId) throws SysException {
		return this.empprobationdao.getAllProbationWageByPid(personId);
	}

	public EmpProbationBO findEmpProbationBOByPid(String pid)
			throws SysException {
		return (EmpProbationBO) this.empprobationdao.findBoById(
				EmpProbationBO.class, pid);
	}

	public void saveEmpProbationBO(EmpProbationBO bo) throws SysException {
		this.empprobationdao.saveOrUpdateBo(bo);
	}

	public void createEmpProbationBO(EmpProbationBO bo) throws SysException {
		this.empprobationdao.createBo(bo);
	}

	public void deleteEmpProbationBO(String pid) throws SysException {
		this.empprobationdao.deleteBo(EmpProbationBO.class, pid);
	}

	public void updatePersonType(String personId, String type)
			throws SysException {
		String sql = "update a001 set a001054='" + type + "' where id='"
				+ personId + "'";
		this.activeapi.executeSql(sql);
		String sql1 = "update A020 set a020700=(select plan_passdate from emp_probation where person_Id='"
				+ personId + "') where id='" + personId + "'";
		this.activeapi.executeSql(sql1);
		SysCache.setPerson(personId, 3);
	}

	public List getAllProbationWage(PageVO pagevo, String personId)
			throws SysException {
		return this.empprobationdao.getAllProbationWage(pagevo, personId);
	}

	public EmpProbationDAO getEmpprobationdao() {
		return this.empprobationdao;
	}

	public void setEmpprobationdao(EmpProbationDAO empprobationdao) {
		this.empprobationdao = empprobationdao;
	}

	public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine)
			throws SysException {
		EmpProbationBO pb = findEmpProbationBOByPid(wt.getLinkID());
		if (pb == null)
			return false;
		String sql = wfdefine.getSql();

		if ((sql == null) || ("".equals(sql)))
			return true;
		sql = sql.replaceAll("\\$K\\$", pb.getPersonId());
		String con = this.activeapi.queryForString(sql);

		return wfdefine.getConValue().indexOf(con) >= 0;
	}

	public void whenStart(WFTransaction wt) throws SysException {
	}

	public void whenEnd(WFTransaction wt) throws SysException {
		if ("1".equals(wt.getStatusValue())) {
			EmpProbationBO pb = findEmpProbationBOByPid(wt.getLinkID());
			pb.setStatus(EmpProbationBO.PASS);
			saveEmpProbationBO(pb);
		} else if ("2".equals(wt.getStatusValue())) {
			EmpProbationBO pb = findEmpProbationBOByPid(wt.getLinkID());
			pb.setStatus(EmpProbationBO.HAVENOTPASS);
			saveEmpProbationBO(pb);
		}
	}

	public void whenCreateNextNode(WFTransaction wt, WFNodeBO node)
			throws SysException {
		EmpProbationBO pb = findEmpProbationBOByPid(wt.getLinkID());
		if (pb != null) {
			if ("0347".equals(node.getOperID())) {
				pb.setAuditResult("0");
			} else if ("0348".equals(node.getOperID())) {
				pb.setAuditResult2("0");
			} else if ("0349".equals(node.getOperID())) {
				pb.setAuditResult3("0");
			} else if ("0352".equals(node.getOperID())) {
				pb.setAuditResult4("0");
			} else if ("0353".equals(node.getOperID())) {
				pb.setAuditResult5("0");
			} else if ("0354".equals(node.getOperID())) {
				pb.setAuditResult6("0");
			}
			saveEmpProbationBO(pb);
		}
	}

	public List getMyProbation(String personID) throws SysException {
		return this.empprobationdao.getMyProbation(personID);
	}
}