package com.hr319wg.emp.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.EmpPostChangeBO;
import com.hr319wg.emp.pojo.bo.OrgPostChangeBO;
import java.util.List;

public abstract interface IEmpPostChangeUCC {
	public abstract List findAllEmpPostChangeBO(PageVO pagevo, String orgId,
			User user, String name, List status, String time, String time2)
			throws SysException;

	public abstract List findAllEmpPostChangeBO(PageVO paramPageVO,
			String paramString1, String paramString2, boolean paramBoolean)
			throws SysException;

	public abstract EmpPostChangeBO findEmpPostChangeBOById(String paramString)
			throws SysException;

	public abstract void saveEmpPostChangeBO(
			EmpPostChangeBO paramEmpPostChangeBO) throws SysException;

	public abstract void deleteEmpPostChangeBO(String paramString)
			throws SysException;

	public abstract void saveOrgPostChangeBO(
			OrgPostChangeBO paramOrgPostChangeBO) throws SysException;

	public abstract OrgPostChangeBO findOrgPostChangeBO(String paramString)
			throws SysException;

	public abstract void updateOrgPostChangeBO(
			OrgPostChangeBO paramOrgPostChangeBO) throws SysException;

	public abstract void personMessageChange(User paramUser,
			EmpPostChangeBO paramEmpPostChangeBO) throws SysException;

	public abstract List findAllEmpPostChangeBO(String paramString)
			throws SysException;
}