package com.hr319wg.xys.eva.service;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.dao.Xys360DAO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjScoreBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360SbjBO;
import com.hr319wg.xys.eva.pojo.vo.XysPerson360ExportVO;

public class Xys360Service {
	private Xys360DAO xys360DAO;
	private ActivePageAPI activePageAPI;
	
	public List getXys360ObjBOByPlanId(PageVO pagevo,String planId,String orgId)throws SysException{
		return this.xys360DAO.getXys360ObjBOByPlanId(pagevo, planId, orgId);
	}
	public List getXys360ObjBOByQueryValue(PageVO pagevo, String planId,String queryValue)throws SysException{
		return this.xys360DAO.getXys360ObjBOByQueryValue(pagevo, planId, queryValue);
	}
	public Xys360ObjBO findEqualsXys360ObjBO(String planId,String personId)throws SysException{
		return this.xys360DAO.findEqualsXys360ObjBO(planId, personId);
	}
	public Xys360ObjBO findXys360ObjBOById(String objId)throws SysException{
		return (Xys360ObjBO)this.xys360DAO.findBoById(Xys360ObjBO.class, objId);
	}
	public void saveXys360ObjBO(Xys360ObjBO bo)throws SysException{
		this.xys360DAO.saveOrUpdateBo(bo);
	}
	public void deleteXys360ObjBO(String objId)throws SysException{
		this.xys360DAO.deleteBo(Xys360ObjBO.class,objId);
	}
	
	
	public List getXys360ObjKeyBOByObjId(String objId)throws SysException{
		return this.xys360DAO.getXys360ObjKeyBOByObjId(objId);
	}
	public Xys360ObjKeyBO findXys360ObjKeyBOById(String keyId)throws SysException{
		return (Xys360ObjKeyBO)this.xys360DAO.findBoById(Xys360ObjKeyBO.class, keyId);
	}
	public void saveXys360ObjKeyBO(Xys360ObjKeyBO bo)throws SysException{
		this.xys360DAO.saveOrUpdateBo(bo);
	}
	public void deleteXys360ObjKeyBO(String keyId)throws SysException{
		this.xys360DAO.deleteBo(Xys360ObjKeyBO.class,keyId);
	}
	
	
	public List getXys360SbjBOByObjId(String objId)throws SysException{
		return this.xys360DAO.getXys360SbjBOByObjId(objId);
	}
	public Xys360SbjBO findEqualsXys360SbjBO(String objId,String personId)throws SysException{
		return this.xys360DAO.findEqualsXys360SbjBO(objId, personId);
	}
	public Xys360SbjBO findXys360SbjBOById(String sbjId)throws SysException{
		return (Xys360SbjBO)this.xys360DAO.findBoById(Xys360SbjBO.class, sbjId);
	}
	public void saveXys360SbjBO(Xys360SbjBO bo)throws SysException{
		this.xys360DAO.saveOrUpdateBo(bo);
	}
	public void deleteXys360SbjBO(String sbjId)throws SysException{
		this.xys360DAO.deleteBo(Xys360SbjBO.class,sbjId);
	}
	
	
	public List getXys360ObjScoreBOBySbjId(String sbjId)throws SysException{
		return this.xys360DAO.getXys360ObjScoreBOBySbjId(sbjId);
	}
	public Xys360ObjScoreBO findEqualsXys360ObjScoreBO(String sbjId,String keyId)throws SysException{
		return this.xys360DAO.findEqualsXys360ObjScoreBO(sbjId, keyId);
	}
	public Xys360ObjScoreBO findXys360ObjScoreBOById(String scoreId)throws SysException{
		return (Xys360ObjScoreBO)this.xys360DAO.findBoById(Xys360ObjScoreBO.class,scoreId);
	}
	public void saveXys360ObjScoreBO(Xys360ObjScoreBO bo)throws SysException{
		this.xys360DAO.saveOrUpdateBo(bo);
	}
	public void deleteXys360ObjScoreBO(String scoreId)throws SysException{
		this.xys360DAO.deleteBo(Xys360ObjScoreBO.class,scoreId);
	}
	
	public List getAuditXys360ObjBOByPersonId(String personId)throws SysException{
		return this.xys360DAO.getAuditXys360ObjBOByPersonId(personId);
	}
	public List getAuditXys360ObjBOByPersonId(String personId,String planId,String deptId,boolean showSelf)throws SysException{
		return this.xys360DAO.getAuditXys360ObjBOByPersonId(personId,planId,deptId, showSelf);
	}
	
	public List getPersonIdsByPostId(String postId) throws SysException {
    	String names = Constants.IN_SERVICE_TYPE;
    	String ids[]=names.split(",");
        String sql = "select ID from A001 where A001715='" + postId + "' and "+CommonFuns.splitInSql(ids, "A001054");
        System.out.println("sql="+sql);
        CellVO[] cv = new CellVO[1];
        cv[0] = new CellVO();
        cv[0].setItemId("ID");
        Vector rs = activePageAPI.getDataListBySql(cv, sql);
        List list = new ArrayList();
        if(rs!=null&&rs.size()>0){
            for(int i=0;i<rs.size();i++){
                 CellVO row[]=(CellVO[])rs.get(i);
                 list.add(CommonFuns.filterNull(row[0].getValue()));
            }
        }
        return list;
    }
	public List getXys360SbjBOForGrade(String planId,String personId,String gradeItem,String sbjId,String deptId,boolean showSelf)throws SysException{
		return this.xys360DAO.getXys360SbjBOForGrade(planId, personId, gradeItem,sbjId,deptId,showSelf);
	}
	
	public String beginGradeByPlanId(final String planId)throws SysException{
		return this.xys360DAO.beginGradeByPlanId(planId);
	}
	
	
	public List getXys360ObjVO(PageVO pagevo,String planId,String orgId)throws SysException{
		return this.xys360DAO.getXys360ObjVO(pagevo, planId, orgId);
	}
	public List getXys360ObjVOByQueryValue(PageVO pagevo,String planId,String where)throws SysException{
		return this.xys360DAO.getXys360ObjVOByQueryValue(pagevo, planId, where);
	}
	public List checkSbjGradeData(String objId,String level)throws SysException{
		return this.xys360DAO.checkSbjGradeData(objId,level);
	}
	public Hashtable getXys360SbjBOByPersonId(String personId)throws SysException{
		return this.xys360DAO.getXys360SbjBOByPersonId(personId);
	}
	
	public void deleteAll(List list)throws SysException{
		this.xys360DAO.deleteAll(list);
	}
	public void caclPerson360ByPlanId(String planId)throws SysException{
		this.xys360DAO.caclPerson360ByPlanId(planId);
	}
	public void exportPerson360ByPlanId( String planId)throws SysException{
		this.xys360DAO.exportPerson360ByPlanId(planId);
	}
	
	public List getXysPerson360ExportVOByPlanId(String planId)throws SysException{
    	String sql="select (select code_item_name from sys_code_item where code_item_id=A001239) as erji_dept," +
    			"(select B001005 from B001 where orguid=A001705) as dept,A001001 as name,A001735 as code," +
    			"score  from xys_360_obj left join A001 on A001.id=xys_360_obj.person_id " +
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
                 XysPerson360ExportVO vo=new XysPerson360ExportVO();
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
	
	public void load360OjbByPlanId(final String planId)throws SysException{
		this.xys360DAO.load360OjbByPlanId(planId);
	}
	
	public Xys360DAO getXys360DAO() {
		return xys360DAO;
	}
	public void setXys360DAO(Xys360DAO xys360dao) {
		xys360DAO = xys360dao;
	}
	public ActivePageAPI getActivePageAPI() {
		return activePageAPI;
	}
	public void setActivePageAPI(ActivePageAPI activePageAPI) {
		this.activePageAPI = activePageAPI;
	}
	
	
}
