package com.hr319wg.eva.ucc;

import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.eva.pojo.bo.*;

import java.util.List;

/**
 * 考核计划UCC-接口类
 */

public interface IEvaPlanUCC {

    public List findByStatus(String status) throws SysException ;
	/**
     * 新增一条考核计划
     */
	public String createPlan(EvaPlanBO evaPlanBO) throws RollbackableException;
	
	/**
     * 更新一条考核计划
     */
	public void updatePlan(EvaPlanBO evaPlanBO) throws RollbackableException;
	
	/**
     * 删除考核计划
     */
	public void deletePlan(String planId) throws RollbackableException;
	public EvaPlanBO findPlanById(String planId) throws SysException;
	
	//方霞开始
    public List findPublishPlan(String status,String orgid) throws SysException;
    public void saveEvaInfo(EvaInfoBO bo,User user) throws SysException;
    //qiaolei
	public List findPlanByPersonID(String personid,String status,String model) throws SysException;
	public List findByModel(String model) throws SysException;
	public List findByOrgId(String orgId, String status, String model)
	throws SysException;
	 //方霞绩效结果分析
	public List findByOrgAndStatus(String[] status,String orgId) throws SysException;
    public List getAllTableModeEvaPlanBOByPersonId(String personId)throws SysException;
    public void saveMessageToA746(EvaInfoBO bo,User user)throws SysException;
    public List getAllEvaPlanBOByOrgId(String orgId)throws SysException;
    public String getWorkSumByPlanIdAndPid(String planId,String pid)throws SysException;
    public List getAllEvaPlanControlBOByPlanIdAndTemId(String planId,String temId)throws SysException;
    public EvaPlanControlBO findTheSuitEvaPlanControlBO(String planId,String temId,String gradeId)throws SysException;
    public EvaPlanControlBO findEvaPlanControlBOById(String itemId)throws SysException;
    public void saveEvaPlanControlBO(EvaPlanControlBO bo)throws SysException;
    public void deleteEvaPlanControlBO(String itemId)throws SysException;
    public List getAllEvaPlanBObyMaster(String personId)throws SysException;
    
    public List getAllEvaPlanElectionControlBOByPlanId(String planId)throws SysException;
    public EvaPlanElectionControlBO findEvaPlanElectionControlBOById(String itemId)throws SysException;
    public EvaPlanElectionControlBO findTheSuitEvaPlanElectionControlBO(String planId,String masterType,String gradeItem)throws SysException;
    public void saveEvaPlanElectionControlBO(EvaPlanElectionControlBO bo)throws SysException;
    public void deleteEvaPlanElectionControlBO(String itemId)throws SysException;
    
    public List getAllEvaPlanMixBOByPlanId(String planId)throws SysException;
    public EvaPlanMixBO findEvaPlanMixBOById(String mixId)throws SysException;
    public void saveEvaPlanMixBO(EvaPlanMixBO bo)throws SysException;
    public void deleteEvaPlanMixBO(String mixId)throws SysException;

    public List getAllEvaCaclControlBOByPlanId(String planId)throws SysException;
    public EvaCaclControlBO findEqualsEvaCaclControlBO(String planId,String templateId,String masterType)throws SysException;
    public EvaCaclControlBO findEvaCaclControlBOByItemId(String itemId)throws SysException;
    public void saveEvaCaclControlBO(EvaCaclControlBO bo)throws SysException;
    public void deleteEvaCaclControlBO(String itemId)throws SysException;
}
