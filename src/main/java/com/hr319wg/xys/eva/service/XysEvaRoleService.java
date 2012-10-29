package com.hr319wg.xys.eva.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.dao.XysEvaRoleDAO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaRoleBO;

public class XysEvaRoleService {
	private XysEvaRoleDAO xysEvaRoleDAO;

	
	public List getXysEvaRoleBOByOrgId(PageVO pagevo,String orgId)throws SysException{
		return this.xysEvaRoleDAO.getXysEvaRoleBOByOrgId(pagevo, orgId);
	}
	public XysEvaRoleBO findXysEvaRoleBOById(String roleId)throws SysException{
		return (XysEvaRoleBO)this.xysEvaRoleDAO.findBoById(XysEvaRoleBO.class,roleId);
	}
	public void saveXysEvaRoleBO(XysEvaRoleBO bo)throws SysException{
		this.xysEvaRoleDAO.saveOrUpdateBo(bo);
	}
	public void deleteXysEvaRoleBO(String roleId)throws SysException{
		this.xysEvaRoleDAO.deleteBo(XysEvaRoleBO.class, roleId);
	}
	
	
	public void deletAll(List list)throws SysException{
		this.xysEvaRoleDAO.deleteAll(list);
	}
	public XysEvaRoleDAO getXysEvaRoleDAO() {
		return xysEvaRoleDAO;
	}

	public void setXysEvaRoleDAO(XysEvaRoleDAO xysEvaRoleDAO) {
		this.xysEvaRoleDAO = xysEvaRoleDAO;
	}
	
}
