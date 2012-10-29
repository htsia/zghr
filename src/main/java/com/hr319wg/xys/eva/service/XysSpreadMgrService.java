package com.hr319wg.xys.eva.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.xys.eva.dao.XysSpreadMgrDAO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadDeptSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetItemBO;

public class XysSpreadMgrService {
	private XysSpreadMgrDAO xysSpreadMgrDao;

	public List getXysSpreadSetBOByPlanId(String planId)throws SysException{
		return this.xysSpreadMgrDao.getXysSpreadSetBOByPlanId(planId);
	}
	public XysSpreadSetBO findEqualsXysSpreadSetBO(String planId,String gradeItem)throws SysException{
		return this.xysSpreadMgrDao.findEqualsXysSpreadSetBO(planId, gradeItem);
	}
	public XysSpreadSetBO findXysSpreadSetBOById(String setId)throws SysException{
		return (XysSpreadSetBO)this.xysSpreadMgrDao.findBoById(XysSpreadSetBO.class,setId);
	}
	public void saveXysSpreadSetBO(XysSpreadSetBO bo)throws SysException{
		this.xysSpreadMgrDao.saveOrUpdateBo(bo);
	}
	public void deleteXysSpreadSetBO(String setId)throws SysException{
		this.xysSpreadMgrDao.deleteBo(XysSpreadSetBO.class, setId);
	}
	
	
	public List getXysSpreadSetItemBOBySetId(String setId)throws SysException{
		return this.xysSpreadMgrDao.getXysSpreadSetItemBOBySetId(setId);
	}
	public XysSpreadSetItemBO findXysSpreadSetItemBO(String itemId)throws SysException{
		return (XysSpreadSetItemBO)this.xysSpreadMgrDao.findBoById(XysSpreadSetItemBO.class, itemId);
	}
	public void saveXysSpreadSetItemBO(XysSpreadSetItemBO bo)throws SysException{
		this.xysSpreadMgrDao.saveOrUpdateBo(bo);
	}
	public void deleteXysSpreadSetItemBO(String itemId)throws SysException{
		this.xysSpreadMgrDao.deleteBo(XysSpreadSetItemBO.class, itemId);
	}
	
	public List getXysSpreadDeptSetBO(String planId,String deptId)throws SysException{
		return this.xysSpreadMgrDao.getXysSpreadDeptSetBO(planId, deptId);
	}
	public XysSpreadDeptSetBO findXysSpreadDeptSetBOById(String setId)throws SysException{
		return (XysSpreadDeptSetBO)this.xysSpreadMgrDao.findBoById(XysSpreadDeptSetBO.class, setId);
	}
	public void saveXysSpreadDeptSetBO(XysSpreadDeptSetBO bo)throws SysException{
		this.xysSpreadMgrDao.saveOrUpdateBo(bo);
	}
	public void deleteXysSpreadDeptSetBO(String setId)throws SysException{
		this.xysSpreadMgrDao.deleteBo(XysSpreadDeptSetBO.class, setId);
	}
	public XysSpreadDeptSetBO findEquealsXysSpreadDeptSetBO(String planId,String deptId,String gradeItem)throws SysException{
		return this.xysSpreadMgrDao.findEquealsXysSpreadDeptSetBO(planId, deptId, gradeItem);
	}
	
	
	public XysSpreadMgrDAO getXysSpreadMgrDao() {
		return xysSpreadMgrDao;
	}

	public void setXysSpreadMgrDao(XysSpreadMgrDAO xysSpreadMgrDao) {
		this.xysSpreadMgrDao = xysSpreadMgrDao;
	}
	
}
