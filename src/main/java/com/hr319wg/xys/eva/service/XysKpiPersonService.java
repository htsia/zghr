package com.hr319wg.xys.eva.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.dao.XysKpiPersonDAO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonScoreBO;
import com.hr319wg.xys.eva.pojo.vo.XysPersonKPIExportVO;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-13
 * Time: 下午4:22
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiPersonService {
    private XysKpiPersonDAO xysKpiPersonDAO;
    private ActivePageAPI activePageAPI;
    
    //操作客体
    public List getXysKpiPersonObjBO(PageVO pageVO,String planId,String orgId)throws SysException{
          return xysKpiPersonDAO.getXysKpiPersonObjBO(pageVO,planId,orgId);
    }
    public List getXysKpiPersonObjBOByQueryValue(PageVO pageVO,String planId,String where)throws SysException{
    	return this.xysKpiPersonDAO.getXysKpiPersonObjBOByQueryValue(pageVO, planId, where);
    }
    public XysKpiPersonObjBO findEqualsXysKpiPersonObjBO(String planId,String personId)throws SysException{
        return xysKpiPersonDAO.findEqualsXysKpiPersonObjBO(planId,personId);
    }
    public List getXysKpiPersonObjBOForSelf(String deptId,String where)throws SysException{
        return xysKpiPersonDAO.getXysKpiPersonObjBOForSelf(deptId,where);
    }
    
    public List getSelfXysKpiPersonObjBO(String personId,String where)throws SysException{
    	return xysKpiPersonDAO.getSelfXysKpiPersonObjBO(personId,where);
    }
    public XysKpiPersonObjBO findXysKpiPersonObjBOById(String objId)throws SysException{
        return (XysKpiPersonObjBO)xysKpiPersonDAO.findBoById(XysKpiPersonObjBO.class,objId);
    }
    public void saveXysKpiPersonObjBO(XysKpiPersonObjBO bo)throws SysException{
        xysKpiPersonDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysKpiPersonObjBO(String objId)throws SysException{
        xysKpiPersonDAO.deleteBo(XysKpiPersonObjBO.class,objId);
    }
    public List getAuditXysKpiPersonObjBOByPersonId(String personId)throws SysException{
    	return this.xysKpiPersonDAO.getAuditXysKpiPersonObjBOByPersonId(personId);
    }


    //操作主体
    public List getXysKpiPersonSbjBOByObjId(String objId)throws SysException{
        return xysKpiPersonDAO.getXysKpiPersonSbjBOByObjId(objId);
    }
    public XysKpiPersonSbjBO findEqualsXysKpiPersonSbjBO(String objId,String personId)throws SysException{
        return xysKpiPersonDAO.findEqualsXysKpiPersonSbjBO(objId,personId);
    }
    public XysKpiPersonSbjBO findXysKpiPersonSbjBOById(String sbjId)throws SysException{
        return (XysKpiPersonSbjBO)xysKpiPersonDAO.findBoById(XysKpiPersonSbjBO.class,sbjId);
    }
    public void saveXysKpiPersonSbjBO(XysKpiPersonSbjBO bo)throws SysException{
        xysKpiPersonDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysKpiPersonSbjBO(String sbjId)throws SysException{
        xysKpiPersonDAO.deleteBo(XysKpiPersonSbjBO.class,sbjId);
    }

    //操作分数表
    public List  getXysKpiPersonScoreBOBySbjId(String sbjId)throws SysException{
        return xysKpiPersonDAO.getXysKpiPersonScoreBOBySbjId(sbjId);
    }
    public XysKpiPersonScoreBO findXysKpiPersonScoreBOById(String scoreId)throws SysException{
        return (XysKpiPersonScoreBO)xysKpiPersonDAO.findBoById(XysKpiPersonScoreBO.class,scoreId);
    }
    public void saveXysKpiPersonScoreBO(XysKpiPersonScoreBO bo)throws SysException{
        xysKpiPersonDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysKpiPersonScoreBO(String scoreId)throws SysException{
        xysKpiPersonDAO.deleteBo(XysKpiPersonScoreBO.class,scoreId);
    }
    public XysKpiPersonScoreBO findEqualsXysKpiPersonScoreBO(String sbjId,String key)throws SysException{
    	return this.xysKpiPersonDAO.findEqualsXysKpiPersonScoreBO(sbjId, key);
    }
    
    
    public List getXysKpiPersonSbjBOForGrade(String planId,String personId,String gradeItem,String sbjId)throws SysException{
    	return this.xysKpiPersonDAO.getXysKpiPersonSbjBOForGrade(planId, personId, gradeItem,sbjId);
    }

    public String beginGradeByPlanId(String planId)throws SysException{
    	 return this.xysKpiPersonDAO.beginGradeByPlanId(planId);
    }
    
    public List getXysKpiPersonObjVO(PageVO pagevo,String planId,String orgId)throws SysException{
    	return this.xysKpiPersonDAO.getXysKpiPersonObjVO(pagevo, planId, orgId);
    }
    public List getXysKpiPersonObjVOByQueryValue(PageVO pagevo,String planId,String where)throws SysException{
    	return this.xysKpiPersonDAO.getXysKpiPersonObjVOByQueryValue(pagevo, planId, where);
    }
    public List checkSbjGradeData(String objId,String level)throws SysException{
    	return this.xysKpiPersonDAO.checkSbjGradeData(objId,level);
    }
    public void caclPersonKpiByPlanId(String planId)throws SysException{
    	this.xysKpiPersonDAO.caclPersonKpiByPlanId(planId);
    }
    public void exportPersonKpiByPlanId(String planId)throws SysException{
    	this.xysKpiPersonDAO.exportPersonKpiByPlanId(planId);
    }
    
    public void deleteAll(List list)throws SysException{
    	this.xysKpiPersonDAO.deleteAll(list);
    }
    
    public List getXysPersonKPIExportVOByPlanId(String planId)throws SysException{
    	String sql="select (select code_item_name from sys_code_item where code_item_id=A001239) as erji_dept," +
    			"(select B001005 from B001 where orguid=A001705) as dept,A001001 as name,A001735 as code," +
    			"score  from xys_kpi_person_obj left join A001 on A001.id=xys_kpi_person_obj.person_id " +
    			"where plan_id='"+planId+"' order by erji_dept,dept";
    	CellVO[] cv = new CellVO[5];
        cv[0] = new CellVO();
        cv[0].setItemId("erji_dept");
        cv[1] = new CellVO();
        cv[1].setItemId("dept");
        cv[2] = new CellVO();
        cv[2].setItemId("name");
        cv[3] = new CellVO();
        cv[3].setItemId("code");
        cv[4] = new CellVO();
        cv[4].setItemId("score");
        Vector rs = activePageAPI.getDataListBySql(cv, sql);
        List list = new ArrayList();
        if(rs!=null&&rs.size()>0){
            for(int i=0;i<rs.size();i++){
                 CellVO row[]=(CellVO[])rs.get(i);
                 XysPersonKPIExportVO vo=new XysPersonKPIExportVO();
                 vo.setErjiDept(CommonFuns.filterNull(row[0].getValue()));
                 vo.setDept(CommonFuns.filterNull(row[1].getValue()));
                 vo.setName(CommonFuns.filterNull(row[2].getValue()));
                 vo.setCode(CommonFuns.filterNull(row[3].getValue()));
                 vo.setScore(CommonFuns.filterNull(row[4].getValue()));
                 list.add(vo);
            }
        }
        return list;
    }
    
    
    public void loadPersonKpiObjByPlanId(final String planId)throws SysException{
    	this.xysKpiPersonDAO.loadPersonKpiObjByPlanId(planId);
    }
    
    public ActivePageAPI getActivePageAPI() {
		return activePageAPI;
	}
	public void setActivePageAPI(ActivePageAPI activePageAPI) {
		this.activePageAPI = activePageAPI;
	}
	public XysKpiPersonDAO getXysKpiPersonDAO() {
        return xysKpiPersonDAO;
    }

    public void setXysKpiPersonDAO(XysKpiPersonDAO xysKpiPersonDAO) {
        this.xysKpiPersonDAO = xysKpiPersonDAO;
    }
}
