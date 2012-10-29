/**
 * 年假流程
 */
package com.hr319wg.attence.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.hr319wg.attence.dao.CardMessageDAO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailAuditBO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;

public class AttWorkFlowNetWorkHolidayService implements IWFFunction {
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
	public void saveorupdateAttAnnualDetailAuditBO(AttAnnualDetailAuditBO bo)
	throws SysException {
		cardMessageDAO.saveOrUpdateBo(bo);
}

	public AttAnnualDetailAuditBO findAttAnnualDetailAuditBObyId(String id)
	throws SysException {
return (AttAnnualDetailAuditBO) cardMessageDAO.findBoById(
		AttAnnualDetailAuditBO.class, id);
}
	
	public void saveorupdateAttAnnualDetailBO(AttAnnualDetailBO bo)
	throws SysException {
		cardMessageDAO.saveOrUpdateBo(bo);
}
	
	public AttAnnualItemBO findAttAnnualItemBObyId(String id)
	throws SysException {
return (AttAnnualItemBO) cardMessageDAO.findBoById(
		AttAnnualItemBO.class, id);
}
	
	public void saveorupdateAttAnnualItemBO(AttAnnualItemBO bo)
	throws SysException {
		cardMessageDAO.saveOrUpdateBo(bo);
}
	
	public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine)
			throws SysException {
		AttAnnualDetailAuditBO attannualdetailauditbo=findAttAnnualDetailAuditBObyId(wt.getLinkID());
		if(attannualdetailauditbo!=null){
			String sql = wfdefine.getSql().replaceAll("\\$K\\$",attannualdetailauditbo.getPersonID());
			String con = activeapi.queryForString(sql);
			if (wfdefine.getConValue().indexOf(con) >= 0) {
				return true;
			}
		}
		return false;
	}

	public void whenEnd(WFTransaction wt) throws SysException {
		try{
		AttAnnualDetailAuditBO attannualdetailauditbo=findAttAnnualDetailAuditBObyId(wt.getLinkID());
		if(attannualdetailauditbo!=null){
			attannualdetailauditbo.setStatusValue("3");
			saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
			
			  AttAnnualDetailBO attannualdetailbo=new AttAnnualDetailBO();
			  attannualdetailbo.setItemID(attannualdetailauditbo.getItemId());
			  attannualdetailbo.setHolidayBegin(attannualdetailauditbo.getHolidayBegin());
			  attannualdetailbo.setHolidayEnd(attannualdetailauditbo.getHolidayEnd());
			  attannualdetailbo.setDaySpan(attannualdetailauditbo.getDaySpan());
			  saveorupdateAttAnnualDetailBO(attannualdetailbo);
			  AttAnnualItemBO attannualitembo=findAttAnnualItemBObyId(attannualdetailauditbo.getItemId());
			  if(attannualitembo.getCriticalDate()!=null && !"".equals(attannualitembo.getCriticalDate())){
					String systemdayvalue=attannualitembo.getCriticalDate();
					DateFormat systemdayvaluedf = new SimpleDateFormat("yyyy-MM-dd");
					String beginDateValue=attannualdetailauditbo.getHolidayBegin().substring(0,10);
		            Date s1 = systemdayvaluedf.parse(systemdayvalue);
		            Date s2 = systemdayvaluedf.parse(beginDateValue);
		            if(s1.getTime()<s2.getTime()){
						String annDay=attannualitembo.getCriticalAnnDay(); // 临界后假期天数
						String useDay=attannualitembo.getCalcAnnDay(); // 临界后已休天数
						String avaDay=attannualitembo.getCriticalAvaDay(); // 临界后可用天数
						  String daySpan=attannualdetailauditbo.getDaySpan();
						  float annDayNumber=Float.parseFloat(annDay);
						  float useDayNumber=Float.parseFloat(useDay);
						  float avaDayNumber=Float.parseFloat(avaDay);
						  float daySpanNumber=Float.parseFloat(daySpan);
						  String uses=(useDayNumber+daySpanNumber)+"";
						  String avas=(avaDayNumber-daySpanNumber)+"";
						  attannualitembo.setCalcAnnDay(uses);
						  attannualitembo.setCriticalAvaDay(avas); 
						  saveorupdateAttAnnualItemBO(attannualitembo);
		            }else{
						  String annDay=attannualitembo.getAnnDay();
						  String useDay=attannualitembo.getUseDay();
						  String avaDay=attannualitembo.getAvaDay();
						  String daySpan=attannualdetailauditbo.getDaySpan();
						  float annDayNumber=Float.parseFloat(annDay);
						  float useDayNumber=Float.parseFloat(useDay);
						  float avaDayNumber=Float.parseFloat(avaDay);
						  float daySpanNumber=Float.parseFloat(daySpan);
						  String uses=(useDayNumber+daySpanNumber)+"";
						  String avas=(avaDayNumber-daySpanNumber)+"";
						  attannualitembo.setUseDay(uses);
						  attannualitembo.setAvaDay(avas);
						  saveorupdateAttAnnualItemBO(attannualitembo);
		            }
			  }else{
				  String annDay=attannualitembo.getAnnDay();
				  String useDay=attannualitembo.getUseDay();
				  String avaDay=attannualitembo.getAvaDay();
				  String daySpan=attannualdetailauditbo.getDaySpan();
				  float annDayNumber=Float.parseFloat(annDay);
				  float useDayNumber=Float.parseFloat(useDay);
				  float avaDayNumber=Float.parseFloat(avaDay);
				  float daySpanNumber=Float.parseFloat(daySpan);
				  String uses=(useDayNumber+daySpanNumber)+"";
				  String avas=(avaDayNumber-daySpanNumber)+"";
				  attannualitembo.setUseDay(uses);
				  attannualitembo.setAvaDay(avas);
				  saveorupdateAttAnnualItemBO(attannualitembo);
			  }
		}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public void whenStart(WFTransaction wt) throws SysException {
	}
    public void whenCreateNextNode(WFTransaction wt, WFNodeBO node) throws SysException{
        //  创建新节点
    }
    
}
