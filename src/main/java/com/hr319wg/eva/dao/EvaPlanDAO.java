package com.hr319wg.eva.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.eva.pojo.bo.EvaCaclControlBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaPlanControlBO;
import com.hr319wg.eva.pojo.bo.EvaPlanElectionControlBO;

import com.hr319wg.sys.cache.SysCacheTool;

import java.util.ArrayList;
import java.util.List;

/**
 * 考核计划DAO 关注于考核计划表(eva_plan)的数据库操作封装.
 */
public class EvaPlanDAO extends BaseDAO {

	public List findByStatus(String status) throws SysException {
		String hsql = "";
		if (!"-1".equals(status))
			hsql = "from EvaPlanBO bo where bo.status='" + status + "' and bo.isVirtual!='1'";
		else
			hsql = "from EvaPlanBO bo where  bo.isVirtual!='1'";
		return this.hibernatetemplate.find(hsql);
	}

	public List findPublishPlan(String status, String orgid)
			throws SysException {
		String hql = "select bo from EvaPlanBO bo where bo.orgId='" + orgid
				+ "' and bo.status='" + status + "' and bo.isVirtual!='1'";
		return this.hibernatetemplate.find(hql);
	}

	// qiaolei
	public List findPlanByPersonID(String pesonid, String status, String model)
			throws SysException {
		String orgid = SysCacheTool.findPersonById(pesonid).getOrgId();
		String hql = "from EvaPlanBO bo where bo.status='" + status
				+ "'  and bo.evaModel ='" + model + "' and bo.orgId='" + orgid
				+ "' and bo.isVirtual!='1'";
		List reustList = new ArrayList();
		List planList = this.hibernatetemplate.find(hql);
		if (planList != null && planList.size() > 0) {
			for (int i = 0; i < planList.size(); i++) {
				EvaPlanBO bo = (EvaPlanBO) planList.get(i);
				String hql2 = "from EvaJobEstimateBO bo where bo.personID='"
						+ pesonid + "' and bo.planID='" + bo.getPlanId() + "'";
				List list = this.hibernatetemplate.find(hql2);
				if (list != null && list.size() > 0) {
					reustList.add(bo);
				}
			}
			return reustList;
		} else {
			return null;
		}
	}

	public List findByOrgId(String orgId, String status, String model)
			throws SysException {
		String hsql = "from EvaPlanBO bo where bo.status='" + status
				+ "'  and bo.evaModel ='" + model + "' and bo.orgId='" + orgId
				+ "' and bo.isVirtual!='1'";
		return this.hibernatetemplate.find(hsql);
	}

	public List findByModel(String model) throws SysException {
		String hsql = "from EvaPlanBO bo where bo.evaModel='" + model + "' and bo.isVirtual!='1'";
		return this.hibernatetemplate.find(hsql);
	}
	
	//方霞绩效结果分析
    public List findByOrgAndStatus(String[] status,String orgid) throws SysException {
    	String hsql = "";
    	if(status!=null && status.length>0){
    		hsql="select bo from EvaPlanBO bo where bo.orgId='"+orgid+"'";
    		for(int i=0;i<status.length;i++){
    			String status1=status[i];
    			if(i==0){
    				hsql+=" and (bo.status='"+status1+"'";
    			}else if(i==status.length-1){
    				hsql+=" or bo.status='"+status1+"')";
    			}else{
    				hsql+=" or bo.status='"+status1+"'";
    			}
    			
    		}
    		
    	}

        return this.hibernatetemplate.find(hsql);
    }
    public List getAllTableModeEvaPlanBOByPersonId(String personId)throws SysException{
    	String hql="select bo from EvaPlanBO bo where bo.planId in (select vo.planID from EvaObjectsBO vo where vo.personID='"+personId+"') and bo.isVirtual!='1'";
    	return this.hibernatetemplate.find(hql);
    }
    public List getAllEvaPlanBOByOrgId(String orgId)throws SysException{
    	String hql="select bo from EvaPlanBO bo where bo.orgId='"+orgId+"' and bo.isVirtual!='1'";
    	return this.hibernatetemplate.find(hql);
    }
    public List getAllEvaPlanControlBOByPlanIdAndTemId(String planId,String temId)throws SysException{
    	String hql="select bo from EvaPlanControlBO bo where bo.planId='"+planId+"' and bo.templateId='"+temId+"'";
    	return this.hibernatetemplate.find(hql);
    }
    public EvaPlanControlBO findTheSuitEvaPlanControlBO(String planId,String temId,String gradeId)throws SysException{
    	String hql="select bo from EvaPlanControlBO bo where bo.planId='"+planId+"' and bo.templateId='"+temId+"' and bo.gradeItem='"+gradeId+"'";
    	List list= this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		return (EvaPlanControlBO)list.get(0);
    	}else{
    		return null;
    	}
    }
    public List getAllEvaPlanBObyMaster(String personId)throws SysException{
    	String hql="select bo from EvaPlanBO bo where bo.planId in(select vo.planID from EvaObjectsBO vo where vo.objectID in(select mo.objectID from EvaMasterBO mo where mo.personID='"+personId+"')) and bo.status='3'";
    	return this.hibernatetemplate.find(hql);
    }
    public List getAllEvaPlanElectionControlBOByPlanId(String planId)throws SysException{
    	String hql="select bo from EvaPlanElectionControlBO bo where bo.planId='"+planId+"'";
    	return this.hibernatetemplate.find(hql);
    }
    public EvaPlanElectionControlBO findTheSuitEvaPlanElectionControlBO(String planId,String masterType,String gradeItem)throws SysException{
    	String hql="select bo from EvaPlanElectionControlBO bo where bo.planId='"+planId+"' and bo.masterType='"+masterType+"' and bo.gradeItem='"+gradeItem+"'";
    	List list=this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		return (EvaPlanElectionControlBO)list.get(0);
    	}else{
    		return null;
    	}
    }
    public List getAllEvaPlanMixBOByPlanId(String planId)throws SysException{
    	String hql="select bo from EvaPlanMixBO bo where bo.planId='"+planId+"'";
    	return this.hibernatetemplate.find(hql);
    }

    /**
     * 返回所有指定计划的 EvaCaclControlBO
     * @param planId
     * @return
     * @throws SysException
     */
    public List getAllEvaCaclControlBOByPlanId(String planId)throws SysException{
        String hql="select bo from EvaCaclControlBO bo where bo.planId='"+planId+"'";
        return this.hibernatetemplate.find(hql);
    }

    public EvaCaclControlBO findEqualsEvaCaclControlBO(String planId,String templateId,String masterType)throws SysException{
        String hql="select bo from EvaCaclControlBO bo where bo.planId='"+planId+"' and bo.templateId='"+templateId+"' and bo.masterType='"+masterType+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
            return (EvaCaclControlBO)list.get(0);
        }
        return null;
    }
}
