package com.hr319wg.emp.ucc.impl;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.EmpProbationBO;
import com.hr319wg.emp.service.EmpProbationService;
import com.hr319wg.emp.ucc.IEmpProbationUCC;
import java.util.List;

public class EmpProbationUcc implements IEmpProbationUCC {
	private EmpProbationService empprobationservice;

	public void deleteEmpProbationBO(String pid) throws SysException {
		this.empprobationservice.deleteEmpProbationBO(pid);
	}

	public EmpProbationBO findEmpProbationBOByPid(String pid)
			throws SysException {
		return this.empprobationservice.findEmpProbationBOByPid(pid);
	}

	public List findNoPassPerson(PageVO pagevo, String orgId, User user, List status,
			String time1, String time2, String name) throws SysException {
		return this.empprobationservice.findNoPassPerson(pagevo, orgId, user, status,
				time1, time2, name);
	}

	public List findAllPerson(PageVO pagevo, String orgId, String operId,
			boolean selall, String filter) throws SysException {
		return this.empprobationservice.findAllPerson(pagevo, orgId, operId,
				selall, filter);
	}

	public List getAllProbationStatusPerson(String orgId, String status)
			throws SysException {
		return this.empprobationservice.getAllProbationStatusPerson(orgId,
				status);
	}

	public List getAllProbationWageByPid(String personId) throws SysException {
		return this.empprobationservice.getAllProbationWageByPid(personId);
	}

	public void updatePersonType(String personId, String type)
			throws SysException {
		this.empprobationservice.updatePersonType(personId, type);
	}

	public void saveEmpProbationBO(EmpProbationBO bo) throws SysException {
		this.empprobationservice.saveEmpProbationBO(bo);
	}

	public void createEmpProbationBO(EmpProbationBO bo) throws SysException {
		this.empprobationservice.createEmpProbationBO(bo);
	}

	public List getAllProbationWage(PageVO pagevo, String personId)
			throws SysException {
		return this.empprobationservice.getAllProbationWage(pagevo, personId);
	}

	public EmpProbationService getEmpprobationservice() {
		return this.empprobationservice;
	}

	public void setEmpprobationservice(EmpProbationService empprobationservice) {
		this.empprobationservice = empprobationservice;
	}

	public List getMyProbation(String personID) throws SysException {
		return this.empprobationservice.getMyProbation(personID);
	}
}