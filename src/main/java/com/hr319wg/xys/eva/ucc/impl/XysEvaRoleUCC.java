package com.hr319wg.xys.eva.ucc.impl;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaRoleBO;
import com.hr319wg.xys.eva.service.XysEvaRoleService;
import com.hr319wg.xys.eva.ucc.IXysEvaRoleUCC;

public class XysEvaRoleUCC implements IXysEvaRoleUCC{
	private XysEvaRoleService xysEvaRoleService;
	
	public List getXysEvaRoleBOByOrgId(PageVO pagevo,String orgId)throws SysException{
		return this.xysEvaRoleService.getXysEvaRoleBOByOrgId(pagevo, orgId);
	}
	public XysEvaRoleBO findXysEvaRoleBOById(String roleId)throws SysException{
		return this.xysEvaRoleService.findXysEvaRoleBOById(roleId);
	}
	public void saveXysEvaRoleBO(XysEvaRoleBO bo)throws SysException{
		this.xysEvaRoleService.saveXysEvaRoleBO(bo);
	}
	public void deleteXysEvaRoleBO(String roleId)throws SysException{
		this.xysEvaRoleService.deleteXysEvaRoleBO(roleId);
	}
	
	public void deletAll(List list)throws SysException{
		this.xysEvaRoleService.deletAll(list);
	}
	
	
	public XysEvaRoleService getXysEvaRoleService() {
		return xysEvaRoleService;
	}

	public void setXysEvaRoleService(XysEvaRoleService xysEvaRoleService) {
		this.xysEvaRoleService = xysEvaRoleService;
	}
	
}
