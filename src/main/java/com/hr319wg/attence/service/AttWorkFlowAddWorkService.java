/**
 * 加班流程
 */
package com.hr319wg.attence.service;

import java.util.List;

import com.hr319wg.attence.dao.CardMessageDAO;
import com.hr319wg.attence.pojo.bo.AttOverTimeLogBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;

public class AttWorkFlowAddWorkService implements IWFFunction {
	private CardMessageDAO cardMessageDAO;
	private ActivePageAPI activeapi;
	
	public CardMessageDAO getCardMessageDAO() {
		return cardMessageDAO;
	}

	public void setCardMessageDAO(CardMessageDAO cardMessageDAO) {
		this.cardMessageDAO = cardMessageDAO;
	}

	public ActivePageAPI getActiveapi() {
		return activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}
	public void saveAttOverTimeRecBO(AttOverTimeRecBO bo) throws SysException {
		cardMessageDAO.saveOrUpdateBo(bo);
	}
	
	public AttOverTimeRecBO findAttOverTimeRecBObyId(String id) throws SysException {
		return (AttOverTimeRecBO) cardMessageDAO.findBoById(AttOverTimeRecBO.class,
				id);
	}
	
	public void saveorupdateAttOverTimeLogBO(AttOverTimeLogBO bo) throws SysException {
		cardMessageDAO.saveOrUpdateBo(bo);
	}
	
	public List findAttTimeOffRecBO(String overTimeNO) throws SysException {
		return cardMessageDAO.findAttTimeOffRecBO(overTimeNO);
	}
	
	public void UpdateAttTimeOffRecBO(String overTimeNO) throws SysException {
	       String updateSQL = "update ATT_TIME_OFF_REC set STATUS_VALUE='3' where OVER_TIME_NO='" + overTimeNO + "'";
	       activeapi.executeSql(updateSQL);
	}
	
	public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine)
			throws SysException {
		AttOverTimeRecBO attovertimerecbo=findAttOverTimeRecBObyId(wt.getLinkID());
		if(attovertimerecbo!=null){
			String sql = wfdefine.getSql().replaceAll("\\$K\\$",attovertimerecbo.getPersonID());
			String con = activeapi.queryForString(sql);
			if (wfdefine.getConValue().indexOf(con) >= 0) {
				return true;
			}
		}
		return false;
	}

	public void whenEnd(WFTransaction wt) throws SysException {
		AttOverTimeRecBO attovertimerecbo=findAttOverTimeRecBObyId(wt.getLinkID());
		if(attovertimerecbo!=null){
			attovertimerecbo.setStatusValue("3");
			saveAttOverTimeRecBO(attovertimerecbo);
			AttOverTimeLogBO attovertimelogbo=new AttOverTimeLogBO();
			attovertimelogbo.setPersonID(attovertimerecbo.getPersonID());
			attovertimelogbo.setApplyDate(attovertimerecbo.getApplyDate());
			attovertimelogbo.setBeginTime(attovertimerecbo.getBeginTime());
			attovertimelogbo.setEndTime(attovertimerecbo.getEndTime());
			attovertimelogbo.setLastDate(attovertimerecbo.getLastDate());
			attovertimelogbo.setTypeStatus(attovertimerecbo.getTypeStatus());
			attovertimelogbo.setProcess("0");
			saveorupdateAttOverTimeLogBO(attovertimelogbo);
			//设置倒休状态
			List atttimeoffrecbovalue=findAttTimeOffRecBO(attovertimerecbo.getOverTimeNO());
			if(atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0){
				UpdateAttTimeOffRecBO(attovertimerecbo.getOverTimeNO());
			}
		}
	}

	public void whenStart(WFTransaction wt) throws SysException {
	}
    public void whenCreateNextNode(WFTransaction wt, WFNodeBO node) throws SysException{
        //  创建新节点
    }
}
