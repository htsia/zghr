package com.hr319wg.xys.eva.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.dao.XysEvaObjDAO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.vo.XysObjExportVO;

public class XysEvaObjService {
	private XysEvaObjDAO xysEvaObjDao;
	private ActivePageAPI activePageAPI;
	
	public List getXysEvaObjBOByPlanId(PageVO pagevo,String planId,String orgId,String showMode)throws SysException{
		return this.xysEvaObjDao.getXysEvaObjBOByPlanId(pagevo, planId, orgId,showMode);
	}
	public List getXysEvaObjBOByQueryValue(PageVO pagevo,String planId,String where)throws SysException{
		return this.xysEvaObjDao.getXysEvaObjBOByQueryValue(pagevo, planId, where);
	}
	public XysEvaObjBO findXysEvaObjBOById(String objId)throws SysException{
		return (XysEvaObjBO)this.xysEvaObjDao.findBoById(XysEvaObjBO.class, objId);
	}
	public void saveXysEvaObjBO(XysEvaObjBO bo)throws SysException{
		this.xysEvaObjDao.saveOrUpdateBo(bo);
	}
	public void deleteXysEvaObjBO(String objId)throws SysException{
		this.xysEvaObjDao.deleteBo(XysEvaObjBO.class, objId);
	}
	public void caclEvaObjBOByPlanId(String planId)throws SysException{
		this.xysEvaObjDao.caclEvaObjBOByPlanId(planId);
	}
	public List getXysEvaObjBOForSort(String planId,String orgId)throws SysException{
		return this.xysEvaObjDao.getXysEvaObjBOForSort(planId, orgId);
	}
	public List getXysEvaObjBOForGrade(String planId,String orgId,String gradeItem)throws SysException{
		return this.xysEvaObjDao.getXysEvaObjBOForGrade(planId, orgId, gradeItem);
	}
	
	public List getXysObjExportVOByPlanId(String planId)throws SysException{
    	String sql="select (select code_item_name from sys_code_item where code_item_id=A001239) as erji_dept," +
    			"(select B001005 from B001 where orguid=A001705) as dept,A001001 as name,A001735 as code," +
    			"score_kpi ,score_360,score_xspj ,total_score,nature_sort,(select item_name from eva_grade_item where item_id=nature_grade) as nature_grade," +
    			"force_sort,(select item_name from eva_grade_item where item_id=force_grade) force_grade" +
    			"  from xys_eva_obj left join A001 on A001.id=xys_eva_obj.person_id " +
    			"where plan_id='"+planId+"' order by erji_dept,dept";
    	CellVO[] cv = new CellVO[12];
        cv[0] = new CellVO();
        cv[0].setItemId("erji_dept");
        cv[1] = new CellVO();
        cv[1].setItemId("dept");
        cv[2] = new CellVO();
        cv[2].setItemId("name");
        cv[3] = new CellVO();
        cv[3].setItemId("code");
        cv[4] = new CellVO();
        cv[4].setItemId("score_kpi");
        cv[5] = new CellVO();
        cv[5].setItemId("score_360");
        cv[6] = new CellVO();
        cv[6].setItemId("score_xspj");
        cv[7] = new CellVO();
        cv[7].setItemId("total_score");
        cv[8] = new CellVO();
        cv[8].setItemId("nature_sort");
        cv[9] = new CellVO();
        cv[9].setItemId("nature_grade");
        cv[10] = new CellVO();
        cv[10].setItemId("force_sort");
        cv[11] = new CellVO();
        cv[11].setItemId("force_grade");
        Vector rs = activePageAPI.getDataListBySql(cv, sql);
        List list = new ArrayList();
        if(rs!=null&&rs.size()>0){
            for(int i=0;i<rs.size();i++){
                 CellVO row[]=(CellVO[])rs.get(i);
                 XysObjExportVO vo=new XysObjExportVO();
                 vo.setErjiDept(CommonFuns.filterNull(row[0].getValue()));
                 vo.setDept(CommonFuns.filterNull(row[1].getValue()));
                 vo.setName(CommonFuns.filterNull(row[2].getValue()));
                 vo.setCode(CommonFuns.filterNull(row[3].getValue()));
                 vo.setScoreKpi(CommonFuns.filterNull(row[4].getValue()));
                 vo.setScore360(CommonFuns.filterNull(row[5].getValue()));
                 vo.setScoreXspj(CommonFuns.filterNull(row[6].getValue()));
                 vo.setTotalScore(CommonFuns.filterNull(row[7].getValue()));
                 vo.setNatureSort(CommonFuns.filterNull(row[8].getValue()));
                 vo.setNatureGrade(CommonFuns.filterNull(row[9].getValue()));
                 vo.setForceSort(CommonFuns.filterNull(row[10].getValue()));
                 vo.setForceGrade(CommonFuns.filterNull(row[11].getValue()));
                 list.add(vo);
            }
        }
        return list;
    }
	
	public String getGradeByNameAndPlanId(String planId,String itemName)throws SysException{
		String value="";
		XysEvaPlanBO plan=(XysEvaPlanBO)this.xysEvaObjDao.findBoById(XysEvaPlanBO.class, planId);
		if(plan.getPlanGrade()!=null&&!plan.getPlanGrade().equals("")){
			String sql="select ITEM_ID from EVA_GRADE_ITEM where GRADE_ID='"+plan.getPlanGrade()+"' and ITEM_NAME='"+itemName+"'";
			value=this.activePageAPI.queryForString(sql);
		}
		return value;
	}
	
	public XysEvaObjBO findEqualsXysEvaObjBO(String planId,String personId)throws SysException{
		return this.xysEvaObjDao.findEqualsXysEvaObjBO(planId, personId);
	}
	
	
	
	public XysEvaObjDAO getXysEvaObjDao() {
		return xysEvaObjDao;
	}

	public void setXysEvaObjDao(XysEvaObjDAO xysEvaObjDao) {
		this.xysEvaObjDao = xysEvaObjDao;
	}
	public ActivePageAPI getActivePageAPI() {
		return activePageAPI;
	}
	public void setActivePageAPI(ActivePageAPI activePageAPI) {
		this.activePageAPI = activePageAPI;
	}
	
}
