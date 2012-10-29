package com.hr319wg.xys.eva.ucc;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadDeptSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetItemBO;

public interface IXysSpreadMgrUCC {
	public List getXysSpreadSetBOByPlanId(String planId)throws SysException;
	public XysSpreadSetBO findEqualsXysSpreadSetBO(String planId,String gradeItem)throws SysException;
	public XysSpreadSetBO findXysSpreadSetBOById(String setId)throws SysException;
	public void saveXysSpreadSetBO(XysSpreadSetBO bo)throws SysException;
	public void deleteXysSpreadSetBO(String setId)throws SysException;
	
	public List getXysSpreadSetItemBOBySetId(String setId)throws SysException;
	public XysSpreadSetItemBO findXysSpreadSetItemBO(String itemId)throws SysException;
	public void saveXysSpreadSetItemBO(XysSpreadSetItemBO bo)throws SysException;
	public void deleteXysSpreadSetItemBO(String itemId)throws SysException;
	
	public List getXysSpreadDeptSetBO(String planId,String deptId)throws SysException;
	public XysSpreadDeptSetBO findXysSpreadDeptSetBOById(String setId)throws SysException;
	public void saveXysSpreadDeptSetBO(XysSpreadDeptSetBO bo)throws SysException;
	public void deleteXysSpreadDeptSetBO(String setId)throws SysException;
	public XysSpreadDeptSetBO findEquealsXysSpreadDeptSetBO(String planId,String deptId,String gradeItem)throws SysException;
}
