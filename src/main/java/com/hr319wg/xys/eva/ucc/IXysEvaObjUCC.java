package com.hr319wg.xys.eva.ucc;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaObjBO;

public interface IXysEvaObjUCC {
	public List getXysEvaObjBOByPlanId(PageVO pagevo,String planId,String orgId,String showMode)throws SysException;
	public List getXysEvaObjBOByQueryValue(PageVO pagevo,String planId,String where)throws SysException;
	public XysEvaObjBO findXysEvaObjBOById(String objId)throws SysException;
	public void saveXysEvaObjBO(XysEvaObjBO bo)throws SysException;
	public void deleteXysEvaObjBO(String objId)throws SysException;
	public void caclEvaObjBOByPlanId(String planId)throws SysException;
	public List getXysEvaObjBOForSort(String planId,String orgId)throws SysException;
	public void publicEvaPlanResult(User user,String planId,String publicType)throws SysException;
	public List getXysEvaObjBOForGrade(String planId,String orgId,String gradeItem)throws SysException;
	
	public List getXysObjExportVOByPlanId(String planId)throws SysException;
	public String getGradeByNameAndPlanId(String planId,String itemName)throws SysException;
	public XysEvaObjBO findEqualsXysEvaObjBO(String planId,String personId)throws SysException;
}
