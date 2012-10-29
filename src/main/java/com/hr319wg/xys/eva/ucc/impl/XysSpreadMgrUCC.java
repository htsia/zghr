package com.hr319wg.xys.eva.ucc.impl;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadDeptSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetItemBO;
import com.hr319wg.xys.eva.service.XysSpreadMgrService;
import com.hr319wg.xys.eva.ucc.IXysSpreadMgrUCC;

public class XysSpreadMgrUCC implements IXysSpreadMgrUCC{
	private XysSpreadMgrService xysSpreadMgrService;

	public List getXysSpreadSetBOByPlanId(String planId)throws SysException{
		return this.xysSpreadMgrService.getXysSpreadSetBOByPlanId(planId);
	}
	public XysSpreadSetBO findEqualsXysSpreadSetBO(String planId,String gradeItem)throws SysException{
		return this.xysSpreadMgrService.findEqualsXysSpreadSetBO(planId, gradeItem);
	}
	public XysSpreadSetBO findXysSpreadSetBOById(String setId)throws SysException{
		return this.xysSpreadMgrService.findXysSpreadSetBOById(setId);
	}
	public void saveXysSpreadSetBO(XysSpreadSetBO bo)throws SysException{
		this.xysSpreadMgrService.saveXysSpreadSetBO(bo);
	}
	public void deleteXysSpreadSetBO(String setId)throws SysException{
		this.xysSpreadMgrService.deleteXysSpreadSetBO(setId);
	}
	
	
	public List getXysSpreadSetItemBOBySetId(String setId)throws SysException{
		return this.xysSpreadMgrService.getXysSpreadSetItemBOBySetId(setId);
	}
	public XysSpreadSetItemBO findXysSpreadSetItemBO(String itemId)throws SysException{
		return this.xysSpreadMgrService.findXysSpreadSetItemBO(itemId);
	}
	public void saveXysSpreadSetItemBO(XysSpreadSetItemBO bo)throws SysException{
		this.xysSpreadMgrService.saveXysSpreadSetItemBO(bo);
	}
	public void deleteXysSpreadSetItemBO(String itemId)throws SysException{
		this.xysSpreadMgrService.deleteXysSpreadSetItemBO(itemId);
	}
	
	
	public List getXysSpreadDeptSetBO(String planId,String deptId)throws SysException{
		return this.xysSpreadMgrService.getXysSpreadDeptSetBO(planId, deptId);
	}
	public XysSpreadDeptSetBO findXysSpreadDeptSetBOById(String setId)throws SysException{
		return this.xysSpreadMgrService.findXysSpreadDeptSetBOById(setId);
	}
	public void saveXysSpreadDeptSetBO(XysSpreadDeptSetBO bo)throws SysException{
		this.xysSpreadMgrService.saveXysSpreadDeptSetBO(bo);
	}
	public void deleteXysSpreadDeptSetBO(String setId)throws SysException{
		this.xysSpreadMgrService.deleteXysSpreadDeptSetBO(setId);
	}
	public XysSpreadDeptSetBO findEquealsXysSpreadDeptSetBO(String planId,String deptId,String gradeItem)throws SysException{
		return this.xysSpreadMgrService.findEquealsXysSpreadDeptSetBO(planId, deptId, gradeItem);
	}
	
	public XysSpreadMgrService getXysSpreadMgrService() {
		return xysSpreadMgrService;
	}

	public void setXysSpreadMgrService(XysSpreadMgrService xysSpreadMgrService) {
		this.xysSpreadMgrService = xysSpreadMgrService;
	}
	
}
