package com.hr319wg.xys.eva.ucc.impl;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjScoreBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360SbjBO;
import com.hr319wg.xys.eva.service.Xys360Service;
import com.hr319wg.xys.eva.ucc.IXys360UCC;

public class Xys360UCC implements IXys360UCC{
	private Xys360Service xys360Service;
	
	public List getXys360ObjBOByPlanId(PageVO pagevo,String planId,String orgId)throws SysException{
		return this.xys360Service.getXys360ObjBOByPlanId(pagevo, planId, orgId);
	}
	public List getXys360ObjBOByQueryValue(PageVO pagevo, String planId,String queryValue)throws SysException{
		return this.xys360Service.getXys360ObjBOByQueryValue(pagevo, planId, queryValue);
	}
	public Xys360ObjBO findEqualsXys360ObjBO(String planId,String personId)throws SysException{
		return this.xys360Service.findEqualsXys360ObjBO(planId, personId);
	}
	public Xys360ObjBO findXys360ObjBOById(String objId)throws SysException{
		return this.xys360Service.findXys360ObjBOById(objId);
	}
	public void saveXys360ObjBO(Xys360ObjBO bo)throws SysException{
		this.xys360Service.saveXys360ObjBO(bo);
	}
	public void deleteXys360ObjBO(String objId)throws SysException{
		this.xys360Service.deleteXys360ObjBO(objId);
	}
	
	public List getXys360ObjKeyBOByObjId(String objId)throws SysException{
		return this.xys360Service.getXys360ObjKeyBOByObjId(objId);
	}
	public Xys360ObjKeyBO findXys360ObjKeyBOById(String keyId)throws SysException{
		return this.xys360Service.findXys360ObjKeyBOById(keyId);
	}
	public void saveXys360ObjKeyBO(Xys360ObjKeyBO bo)throws SysException{
		this.xys360Service.saveXys360ObjKeyBO(bo);
	}
	public void deleteXys360ObjKeyBO(String keyId)throws SysException{
		this.xys360Service.deleteXys360ObjKeyBO(keyId);
	}
	
	public List getXys360SbjBOByObjId(String objId)throws SysException{
		return this.xys360Service.getXys360SbjBOByObjId(objId);
	}
	public Xys360SbjBO findEqualsXys360SbjBO(String objId,String personId)throws SysException{
		return this.xys360Service.findEqualsXys360SbjBO(objId, personId);
	}
	public Xys360SbjBO findXys360SbjBOById(String sbjId)throws SysException{
		return this.xys360Service.findXys360SbjBOById(sbjId);
	}
	public void saveXys360SbjBO(Xys360SbjBO bo)throws SysException{
		this.xys360Service.saveXys360SbjBO(bo);
	}
	public void deleteXys360SbjBO(String sbjId)throws SysException{
		this.xys360Service.deleteXys360SbjBO(sbjId);
	}
	
	public List getXys360ObjScoreBOBySbjId(String sbjId)throws SysException{
		return this.xys360Service.getXys360ObjScoreBOBySbjId(sbjId);
	}
	public Xys360ObjScoreBO findEqualsXys360ObjScoreBO(String sbjId,String keyId)throws SysException{
		return this.xys360Service.findEqualsXys360ObjScoreBO(sbjId, keyId);
	}
	public Xys360ObjScoreBO findXys360ObjScoreBOById(String scoreId)throws SysException{
		return this.xys360Service.findXys360ObjScoreBOById(scoreId);
	}
	public void saveXys360ObjScoreBO(Xys360ObjScoreBO bo)throws SysException{
		this.xys360Service.saveXys360ObjScoreBO(bo);
	}
	public void deleteXys360ObjScoreBO(String scoreId)throws SysException{
		this.xys360Service.deleteXys360ObjScoreBO(scoreId);
	}
	
	public List getAuditXys360ObjBOByPersonId(String personId)throws SysException{
		return this.xys360Service.getAuditXys360ObjBOByPersonId(personId);
	}
	public List getAuditXys360ObjBOByPersonId(String personId,String planId,String deptId,boolean showSelf)throws SysException{
		return this.xys360Service.getAuditXys360ObjBOByPersonId(personId, planId, deptId, showSelf);
	}
	public List getPersonIdsByPostId(String postId) throws SysException{
		return this.xys360Service.getPersonIdsByPostId(postId);
	}
	
	public List getXys360SbjBOForGrade(String planId,String personId,String gradeItem,String sbjId,String deptId,boolean showSelf)throws SysException{
		return this.xys360Service.getXys360SbjBOForGrade(planId, personId, gradeItem,sbjId,deptId,showSelf);
	}
	
	public String beginGradeByPlanId(final String planId)throws SysException{
		return this.xys360Service.beginGradeByPlanId(planId);
	}
	
	public List getXys360ObjVO(PageVO pagevo,String planId,String orgId)throws SysException{
		return this.xys360Service.getXys360ObjVO(pagevo, planId, orgId);
	}
	public List getXys360ObjVOByQueryValue(PageVO pagevo,String planId,String where)throws SysException{
		return this.xys360Service.getXys360ObjVOByQueryValue(pagevo, planId, where);
	}
	public List checkSbjGradeData(String objId,String level)throws SysException{
		return this.xys360Service.checkSbjGradeData(objId,level);
	}
	public Hashtable getXys360SbjBOByPersonId(String personId)throws SysException{
		return this.xys360Service.getXys360SbjBOByPersonId(personId);
	}
	
	public void caclPerson360ByPlanId(String planId)throws SysException{
		this.xys360Service.caclPerson360ByPlanId(planId);
	}
	
	public void deleteAll(List list)throws SysException{
		 this.xys360Service.deleteAll(list);
	}
	public void exportPerson360ByPlanId( String planId)throws SysException{
		 this.xys360Service.exportPerson360ByPlanId(planId);
	}
	
	public List getXysPerson360ExportVOByPlanId(String planId)throws SysException{
		return this.xys360Service.getXysPerson360ExportVOByPlanId(planId);
	}
	
	public void load360OjbByPlanId(final String planId)throws SysException{
		this.xys360Service.load360OjbByPlanId(planId);
	}
	
	public Xys360Service getXys360Service() {
		return xys360Service;
	}
	public void setXys360Service(Xys360Service xys360Service) {
		this.xys360Service = xys360Service;
	}
	
	
}
