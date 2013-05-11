package com.hr319wg.emp.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.EmpProbationBO;
import java.util.List;

public abstract interface IEmpProbationUCC {
	public abstract List findNoPassPerson(PageVO paramPageVO, String orgID,
			User user, List paramList, String paramString2,
			String paramString3, String paramString4) throws SysException;

	public abstract List findAllPerson(PageVO paramPageVO, String paramString1,
			String paramString2, boolean paramBoolean, String paramString3)
			throws SysException;

	public abstract List getAllProbationStatusPerson(String paramString1,
			String paramString2) throws SysException;

	public abstract EmpProbationBO findEmpProbationBOByPid(String paramString)
			throws SysException;

	public abstract void saveEmpProbationBO(EmpProbationBO paramEmpProbationBO)
			throws SysException;

	public abstract void deleteEmpProbationBO(String paramString)
			throws SysException;

	public abstract void updatePersonType(String paramString1,
			String paramString2) throws SysException;

	public abstract List getAllProbationWage(PageVO paramPageVO,
			String paramString) throws SysException;

	public abstract List getAllProbationWageByPid(String paramString)
			throws SysException;

	public abstract void createEmpProbationBO(EmpProbationBO paramEmpProbationBO)
			throws SysException;

	public abstract List getMyProbation(String paramString) throws SysException;
}