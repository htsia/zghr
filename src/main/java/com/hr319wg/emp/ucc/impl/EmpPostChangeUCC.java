package com.hr319wg.emp.ucc.impl;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.EmpPostChangeBO;
import com.hr319wg.emp.pojo.bo.OrgPostChangeBO;
import com.hr319wg.emp.service.EmpPostChangeService;
import com.hr319wg.emp.ucc.IEmpPostChangeUCC;

public class EmpPostChangeUCC implements IEmpPostChangeUCC {
	private EmpPostChangeService emppostchangeservice;

	public void deleteEmpPostChangeBO(String changeId) throws SysException {
		this.emppostchangeservice.deleteEmpPostChangeBO(changeId);
	}

	public List findAllEmpPostChangeBO(PageVO pagevo, String orgId, User user,
			String name, List status, String time, String time2)
			throws SysException {
		return this.emppostchangeservice.findAllEmpPostChangeBO(pagevo, orgId,
				user, name, status, time, time2);
	}

	public List findAllEmpPostChangeBO(PageVO pagevo, String orgId,
			String operId, boolean sellApply) throws SysException {
		return this.emppostchangeservice.findAllEmpPostChangeBO(pagevo, orgId,
				operId, sellApply);
	}

	public void personMessageChange(User user, EmpPostChangeBO bo)
			throws SysException {
		this.emppostchangeservice.personMessageChange(user, bo);
	}

	public EmpPostChangeBO findEmpPostChangeBOById(String changId)
			throws SysException {
		return this.emppostchangeservice.findEmpPostChangeBOById(changId);
	}

	public OrgPostChangeBO findOrgPostChangeBO(String orgId)
			throws SysException {
		return this.emppostchangeservice.findOrgPostChangeBO(orgId);
	}

	public void saveEmpPostChangeBO(EmpPostChangeBO bo) throws SysException {
		this.emppostchangeservice.saveEmpPostChangeBO(bo);
	}

	public void updateOrgPostChangeBO(OrgPostChangeBO bo) throws SysException {
		this.emppostchangeservice.updateOrgPostChangeBO(bo);
	}

	public void saveOrgPostChangeBO(OrgPostChangeBO bo) throws SysException {
		this.emppostchangeservice.saveOrgPostChangeBO(bo);
	}

	public EmpPostChangeService getEmppostchangeservice() {
		return this.emppostchangeservice;
	}

	public void setEmppostchangeservice(
			EmpPostChangeService emppostchangeservice) {
		this.emppostchangeservice = emppostchangeservice;
	}

	public List findAllEmpPostChangeBO(String personID) throws SysException {
		return this.emppostchangeservice.findAllEmpPostChangeBO(personID);
	}
}