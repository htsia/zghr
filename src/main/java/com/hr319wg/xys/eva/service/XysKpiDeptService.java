package com.hr319wg.xys.eva.service;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.dao.XysKpiDeptDAO;
import com.hr319wg.xys.eva.pojo.bo.*;
import com.hr319wg.xys.eva.pojo.vo.XysDeptObjExportVO;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-12
 * Time: ÏÂÎç1:34
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiDeptService {
    private XysKpiDeptDAO xysKpiDeptDAO;
    private ActivePageAPI activePageAPI;

    public List getXysKpiDeptObjBO(PageVO pageVO, String planId, String orgId) throws SysException {
        return xysKpiDeptDAO.getXysKpiDeptObjBO(pageVO, planId, orgId);
    }

    public List getXysKpiDeptObjBO(String planId,String gradeItem)throws SysException{
    	return this.xysKpiDeptDAO.getXysKpiDeptObjBO(planId, gradeItem);
    }
    public XysKpiDeptObjBO findEqualsXysKpiDeptObjBO(String planId, String personId) throws SysException {
        return xysKpiDeptDAO.findEqualsXysKpiDeptObjBO(planId, personId);
    }

    public List getXysKpiDeptObjBOInSelf(String personId,String where)throws SysException{
        return xysKpiDeptDAO.getXysKpiDeptObjBOInSelf(personId,where);
    }

    public XysKpiDeptObjBO findXysKpiDeptObjBOById(String objId) throws SysException {
        return (XysKpiDeptObjBO) xysKpiDeptDAO.findBoById(XysKpiDeptObjBO.class, objId);
    }

    public void saveXysKpiDeptObjBO(XysKpiDeptObjBO bo) throws SysException {
        xysKpiDeptDAO.saveOrUpdateBo(bo);
    }

    public void deleteXysKpiDeptObjBO(String objId) throws SysException {
        xysKpiDeptDAO.deleteBo(XysKpiDeptObjBO.class, objId);
    }


    public List getXysKpiObjLibBOByObjId(String objId) throws SysException {
        return xysKpiDeptDAO.getXysKpiObjLibBOByObjId(objId);
    }

    public XysKpiObjLibBO findXysKpiObjLibBOById(String lobId) throws SysException {
        return (XysKpiObjLibBO) xysKpiDeptDAO.findBoById(XysKpiObjLibBO.class, lobId);
    }

    public void saveXysKpiObjLibBO(XysKpiObjLibBO bo) throws SysException {
        xysKpiDeptDAO.saveOrUpdateBo(bo);
    }

    public void deleteXysKpiObjLibBO(String libId) throws SysException {
        xysKpiDeptDAO.deleteBo(XysKpiObjLibBO.class, libId);
    }


    public List getXysKpiObjKeyBOByLibId(String libId) throws SysException {
        return xysKpiDeptDAO.getXysKpiObjKeyBOByLibId(libId);
    }

    public List getXysKpiObjKeyBOByObjId(String objId) throws SysException {
        return xysKpiDeptDAO.getXysKpiObjKeyBOByObjId(objId);
    }

    public XysKpiObjKeyBO findXysKpiObjKeyBOById(String keyId) throws SysException {
        return (XysKpiObjKeyBO) xysKpiDeptDAO.findBoById(XysKpiObjKeyBO.class, keyId);
    }

    public void saveXysKpiObjKeyBO(XysKpiObjKeyBO bo) throws SysException {
        xysKpiDeptDAO.saveOrUpdateBo(bo);
    }

    public void deleteXysKpiObjKeyBO(String keyId) throws SysException {
        xysKpiDeptDAO.deleteBo(XysKpiObjKeyBO.class, keyId);
    }


    public List getXysKpiDeptSbjBOByObjId(String objId) throws SysException {
        return xysKpiDeptDAO.getXysKpiDeptSbjBOByObjId(objId);
    }

    public XysKpiDeptSbjBO findEqualsXysKpiDeptSbjBO(String objId, String personId) throws SysException {
        return xysKpiDeptDAO.findEqualsXysKpiDeptSbjBO(objId, personId);
    }

    public XysKpiDeptSbjBO findXysKpiDeptSbjBOById(String sbjId) throws SysException {
        return (XysKpiDeptSbjBO) xysKpiDeptDAO.findBoById(XysKpiDeptSbjBO.class, sbjId);
    }

    public void saveXysKpiDeptSbjBO(XysKpiDeptSbjBO bo) throws SysException {
        xysKpiDeptDAO.saveOrUpdateBo(bo);
    }

    public void deleteXysKpiDeptSbjBO(String sbjId) throws SysException {
        xysKpiDeptDAO.deleteBo(XysKpiDeptSbjBO.class, sbjId);
    }


    public List getXysKpiDeptObjScoreBOBySbjId(String sbjId) throws SysException {
        return xysKpiDeptDAO.getXysKpiDeptObjScoreBOBySbjId(sbjId);
    }

    public XysKpiDeptObjScoreBO findXysKpiDeptObjScoreBOById(String scoreId) throws SysException {
        return (XysKpiDeptObjScoreBO) xysKpiDeptDAO.findBoById(XysKpiDeptObjScoreBO.class, scoreId);
    }

    public void saveXysKpiDeptObjScoreBO(XysKpiDeptObjScoreBO bo) throws SysException {
        xysKpiDeptDAO.saveOrUpdateBo(bo);
    }

    public void deleteXysKpiDeptObjScoreBO(String scoreId) throws SysException {
        xysKpiDeptDAO.deleteBo(XysKpiDeptObjScoreBO.class, scoreId);
    }
    
    public XysKpiDeptObjScoreBO findEqualsXysKpiDeptObjScoreBO(String sbjId,String key)throws SysException{
    	return this.xysKpiDeptDAO.findEqualsXysKpiDeptObjScoreBO(sbjId, key);
    }


    public String getAuditDeptIdByPersonId(String personId) throws SysException {
        String sql = "select A001705 from A001 where id='" + personId + "'";
        return activePageAPI.queryForString(sql);
    }

    public List getPersonIdsByPostId(String postId) throws SysException {
    	String names = Constants.IN_SERVICE_TYPE;
    	String ids[]=names.split(",");
        String sql = "select ID from A001 where A001715='" + postId + "' and "+CommonFuns.splitInSql(ids, "A001054");
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
    
    public List getAuditXysKpiDeptObjBOByPersonId(String personId)throws SysException{
    	return this.xysKpiDeptDAO.getAuditXysKpiDeptObjBOByPersonId(personId);
    }
    
    public List getXysKpiDeptSbjBOForGrade(String planId,String personId,String gradeItem,String sbjId)throws SysException{
    	return this.xysKpiDeptDAO.getXysKpiDeptSbjBOForGrade(planId, personId, gradeItem,sbjId);
    }
    
    public String beginGradeByPlanId(final String planId)throws SysException{
    	return this.xysKpiDeptDAO.beginGradeByPlanId(planId);
    }
    
    public List getXysKpiDeptObjVO(PageVO pageVO,String planId)throws SysException{
    	return this.xysKpiDeptDAO.getXysKpiDeptObjVO(pageVO, planId);
    }
    
    public List checkSbjGradeData(String objId,String level)throws SysException{
    	return this.xysKpiDeptDAO.checkSbjGradeData(objId,level);
    }
    public void caclDeptKpiByPlanId(String planId)throws SysException{
    	this.xysKpiDeptDAO.caclDeptKpiByPlanId(planId);
    }
    
    
    
    public List getXysDeptKpiDivBOByObjId(String objId)throws SysException{
    	return this.xysKpiDeptDAO.getXysDeptKpiDivBOByObjId(objId);
    }
    public XysDeptKpiDivBO findXysDeptKpiDivBOById(String divId)throws SysException{
    	return (XysDeptKpiDivBO)this.xysKpiDeptDAO.findBoById(XysDeptKpiDivBO.class, divId);
    }
    public XysDeptKpiDivBO findEqualsXysDeptKpiDivBO(String planId,String personId)throws SysException{
    	return this.xysKpiDeptDAO.findEqualsXysDeptKpiDivBO(planId, personId);
    }
    public void saveXysDeptKpiDivBO(XysDeptKpiDivBO bo)throws SysException{
    	this.xysKpiDeptDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysDeptKpiDivBO(String divId)throws SysException{
    	this.xysKpiDeptDAO.deleteBo(XysDeptKpiDivBO.class, divId);
    }
    
    public List getXysDeptObjExportVOByPlanId(String planId)throws SysException{
    	String sql="select (select B001005 from B001 where orguid=dept_id) as dept_name,A001001 as person_name," +
    			"A001735 as person_code,score  from xys_kpi_dept_obj left join A001 on A001.id=xys_kpi_dept_obj.person_id " +
    			"where plan_id='"+planId+"'";
    	CellVO[] cv = new CellVO[4];
        cv[0] = new CellVO();
        cv[0].setItemId("dept_name");
        cv[1] = new CellVO();
        cv[1].setItemId("person_name");
        cv[2] = new CellVO();
        cv[2].setItemId("person_code");
        cv[3] = new CellVO();
        cv[3].setItemId("score");
        Vector rs = activePageAPI.getDataListBySql(cv, sql);
        List list = new ArrayList();
        if(rs!=null&&rs.size()>0){
            for(int i=0;i<rs.size();i++){
                 CellVO row[]=(CellVO[])rs.get(i);
                 XysDeptObjExportVO vo=new XysDeptObjExportVO();
                 vo.setDeptName(CommonFuns.filterNull(row[0].getValue()));
                 vo.setPersonName(CommonFuns.filterNull(row[1].getValue()));
                 vo.setPersonCode(CommonFuns.filterNull(row[2].getValue()));
                 vo.setScore(CommonFuns.filterNull(row[3].getValue()));
                 list.add(vo);
            }
        }
        return list;
    }
    
    public XysKpiDeptDAO getXysKpiDeptDAO() {
        return xysKpiDeptDAO;
    }

    public void setXysKpiDeptDAO(XysKpiDeptDAO xysKpiDeptDAO) {
        this.xysKpiDeptDAO = xysKpiDeptDAO;
    }

    public ActivePageAPI getActivePageAPI() {
        return activePageAPI;
    }

    public void setActivePageAPI(ActivePageAPI activePageAPI) {
        this.activePageAPI = activePageAPI;
    }
}
