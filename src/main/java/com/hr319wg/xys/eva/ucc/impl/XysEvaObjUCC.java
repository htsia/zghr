package com.hr319wg.xys.eva.ucc.impl;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.service.EvaGradeService;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.service.ActivePageService;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysEvaObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.service.XysEvaObjService;
import com.hr319wg.xys.eva.ucc.IXysEvaObjUCC;

public class XysEvaObjUCC implements IXysEvaObjUCC {
	private XysEvaObjService xysEvaObjService;
	private ActivePageService activePageService;
	private EvaGradeService evaGradeService;

	public List getXysEvaObjBOByPlanId(PageVO pagevo, String planId,
			String orgId, String showMode) throws SysException {
		return this.xysEvaObjService.getXysEvaObjBOByPlanId(pagevo, planId,
				orgId, showMode);
	}

	public List getXysEvaObjBOByQueryValue(PageVO pagevo, String planId,
			String where) throws SysException {
		return this.xysEvaObjService.getXysEvaObjBOByQueryValue(pagevo, planId,
				where);
	}

	public XysEvaObjBO findXysEvaObjBOById(String objId) throws SysException {
		return this.xysEvaObjService.findXysEvaObjBOById(objId);
	}

	public void saveXysEvaObjBO(XysEvaObjBO bo) throws SysException {
		this.xysEvaObjService.saveXysEvaObjBO(bo);
	}

	public void deleteXysEvaObjBO(String objId) throws SysException {
		this.xysEvaObjService.deleteXysEvaObjBO(objId);
	}

	public void caclEvaObjBOByPlanId(String planId) throws SysException {
		this.xysEvaObjService.caclEvaObjBOByPlanId(planId);
	}

	public List getXysEvaObjBOForSort(String planId, String orgId)
			throws SysException {
		return this.xysEvaObjService.getXysEvaObjBOForSort(planId, orgId);
	}
	public List getXysEvaObjBOForGrade(String planId,String orgId,String gradeItem)throws SysException{
		return this.xysEvaObjService.getXysEvaObjBOForGrade(planId, orgId, gradeItem);
	}

	/**
	 * 发布计划 （publicType=1发布自然分布结果 =2发布强制分布结果）
	 */
	public void publicEvaPlanResult(User user,String planId, String publicType)
			throws SysException {
		List objList = this.getXysEvaObjBOByPlanId(null, planId, null, null);
		XysEvaPlanBO plan = (XysEvaPlanBO) xysEvaObjService.getXysEvaObjDao()
				.findBoById(XysEvaPlanBO.class, planId);
		List list = this.evaGradeService.getAllGradeItem(plan.getPlanGrade());
		Hashtable map = new Hashtable();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				EvaGradeItemBO item = (EvaGradeItemBO) list.get(i);
				map.put(item.getItemID(), item);
			}
		}
		String deleteSql="delete from A746 where A746702='"+planId+"'";
		this.activePageService.executeSql(deleteSql);
		if (objList != null && objList.size() > 0) {
			for (int i = 0; i < objList.size(); i++) {
				XysEvaObjBO obj = (XysEvaObjBO) objList.get(i);
				String[] infoItems = { "A746730", "A746735", "A746705",
						"A746710", "A746715", "A746750", "A746702", "A746701",
						"A746720", "A746740" };
				EvaGradeItemBO item = null;
				if (obj.getNatureGrade() != null
						&& !obj.getNatureGrade().equals("")) {
					item = (EvaGradeItemBO) map.get(obj.getNatureGrade());
				} else {
					item = (EvaGradeItemBO) list.get(list.size() - 1);
				}
				String[] infoValues = {
						"",
						CommonFuns.filterNull(item.getItemName()),
						CommonFuns.filterNull(plan.getPlanType()),
						CommonFuns.filterNull(plan.getBeginTime()),
						CommonFuns.filterNull(plan.getEndTime()),
						CommonFuns.filterNull(obj.getNatureSort()),
						CommonFuns.filterNull(plan.getPlanId()),
						CommonFuns.filterNull(plan.getPlanName()),
						CommonFuns.filterNull(SysCacheTool.findOrgById(plan.getCreateOrg()).getName()),
						CommonFuns.filterNull(item.getEvaRatio())};
				if (publicType.equals("2")) {
					if (obj.getForceGrade() != null
							&& !obj.getForceGrade().equals("")) {
						item = (EvaGradeItemBO) map.get(obj.getForceGrade());
					} else {
						item = (EvaGradeItemBO) list.get(list.size() - 1);
					}
				    String[]   infoValues2 = {
							"",
							CommonFuns.filterNull(item.getItemName()),
							CommonFuns.filterNull(plan.getPlanType()),
							CommonFuns.filterNull(plan.getBeginTime()),
							CommonFuns.filterNull(plan.getEndTime()),
							CommonFuns.filterNull(obj.getForceSort()),
							CommonFuns.filterNull(plan.getPlanId()),
							CommonFuns.filterNull(plan.getPlanName()),
							CommonFuns.filterNull(SysCacheTool.findOrgById(plan.getCreateOrg()).getName()),
							CommonFuns.filterNull(item.getEvaRatio())};
				    infoValues=infoValues2;
				}
				this.activePageService.addPageInfo("A746", user, null, obj.getPersonId(), false, infoItems, infoValues);
			}
		}
		plan.setStatus(XysEvaPlanBO.STATUS_JGFB);
		xysEvaObjService.getXysEvaObjDao().saveOrUpdateBo(plan);
	}

	public List getXysObjExportVOByPlanId(String planId)throws SysException{
		return this.xysEvaObjService.getXysObjExportVOByPlanId(planId);
	}
	
	public String getGradeByNameAndPlanId(String planId,String itemName)throws SysException{
		return this.xysEvaObjService.getGradeByNameAndPlanId(planId, itemName);
	}
	
	public XysEvaObjBO findEqualsXysEvaObjBO(String planId,String personId)throws SysException{
		return this.xysEvaObjService.findEqualsXysEvaObjBO(planId, personId);
	}
	
	
	
	
	
	public XysEvaObjService getXysEvaObjService() {
		return xysEvaObjService;
	}

	public void setXysEvaObjService(XysEvaObjService xysEvaObjService) {
		this.xysEvaObjService = xysEvaObjService;
	}

	public ActivePageService getActivePageService() {
		return activePageService;
	}

	public void setActivePageService(ActivePageService activePageService) {
		this.activePageService = activePageService;
	}

	public EvaGradeService getEvaGradeService() {
		return evaGradeService;
	}

	public void setEvaGradeService(EvaGradeService evaGradeService) {
		this.evaGradeService = evaGradeService;
	}

}
