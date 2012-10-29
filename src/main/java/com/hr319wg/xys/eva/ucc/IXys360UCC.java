package com.hr319wg.xys.eva.ucc;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjScoreBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360SbjBO;

public interface IXys360UCC {
	public List getXys360ObjBOByPlanId(PageVO pagevo,String planId,String orgId)throws SysException;
	public List getXys360ObjBOByQueryValue(PageVO pagevo, String planId,String queryValue)throws SysException;
	public Xys360ObjBO findEqualsXys360ObjBO(String planId,String personId)throws SysException;
	public Xys360ObjBO findXys360ObjBOById(String objId)throws SysException;
	public void saveXys360ObjBO(Xys360ObjBO bo)throws SysException;
	public void deleteXys360ObjBO(String objId)throws SysException;
	
	public List getXys360ObjKeyBOByObjId(String objId)throws SysException;
	public Xys360ObjKeyBO findXys360ObjKeyBOById(String keyId)throws SysException;
	public void saveXys360ObjKeyBO(Xys360ObjKeyBO bo)throws SysException;
	public void deleteXys360ObjKeyBO(String keyId)throws SysException;
	
	public List getXys360SbjBOByObjId(String objId)throws SysException;
	public Xys360SbjBO findEqualsXys360SbjBO(String objId,String personId)throws SysException;
	public Xys360SbjBO findXys360SbjBOById(String sbjId)throws SysException;
	public void saveXys360SbjBO(Xys360SbjBO bo)throws SysException;
	public void deleteXys360SbjBO(String sbjId)throws SysException;
	
	public List getXys360ObjScoreBOBySbjId(String sbjId)throws SysException;
	public Xys360ObjScoreBO findEqualsXys360ObjScoreBO(String sbjId,String keyId)throws SysException;
	public Xys360ObjScoreBO findXys360ObjScoreBOById(String scoreId)throws SysException;
	public void saveXys360ObjScoreBO(Xys360ObjScoreBO bo)throws SysException;
	public void deleteXys360ObjScoreBO(String scoreId)throws SysException;
	
	public List getAuditXys360ObjBOByPersonId(String personId)throws SysException;
	public List getAuditXys360ObjBOByPersonId(String personId,String planId,String deptId,boolean showSelf)throws SysException;
	public List getPersonIdsByPostId(String postId) throws SysException;
	public List getXys360SbjBOForGrade(String planId,String personId,String gradeItem,String sbjId,String deptId,boolean showSelf)throws SysException;
	
	public String beginGradeByPlanId(final String planId)throws SysException;
	public List getXys360ObjVO(PageVO pagevo,String planId,String orgId)throws SysException;
	public List getXys360ObjVOByQueryValue(PageVO pagevo,String planId,String where)throws SysException;
	public List checkSbjGradeData(String objId,String level)throws SysException;
	public Hashtable getXys360SbjBOByPersonId(String personId)throws SysException;
	
	public void deleteAll(List list)throws SysException;
	public void caclPerson360ByPlanId(String planId)throws SysException;
	public void exportPerson360ByPlanId( String planId)throws SysException;
	
	public List getXysPerson360ExportVOByPlanId(String planId)throws SysException;
	public void load360OjbByPlanId(final String planId)throws SysException;
}
