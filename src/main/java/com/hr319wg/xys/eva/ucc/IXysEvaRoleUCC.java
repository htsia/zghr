package com.hr319wg.xys.eva.ucc;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaRoleBO;


public interface IXysEvaRoleUCC {
	public List getXysEvaRoleBOByOrgId(PageVO pagevo,String orgId)throws SysException;
	public XysEvaRoleBO findXysEvaRoleBOById(String roleId)throws SysException;
	public void saveXysEvaRoleBO(XysEvaRoleBO bo)throws SysException;
	public void deleteXysEvaRoleBO(String roleId)throws SysException;
	
	public void deletAll(List list)throws SysException;
}
