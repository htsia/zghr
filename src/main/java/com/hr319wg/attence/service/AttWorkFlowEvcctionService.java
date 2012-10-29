/**
 * ��������
 */
package com.hr319wg.attence.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.hr319wg.attence.dao.CardMessageDAO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecCollectBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;
import com.hr319wg.util.CommonFuns;

public class AttWorkFlowEvcctionService implements IWFFunction {
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

	public AttEvcctionRecBO findAttEvcctionRecBObyId(String id)
	throws SysException {
return (AttEvcctionRecBO) cardMessageDAO.findBoById(
		AttEvcctionRecBO.class, id);
}
	
	public AttEvcctionRecCollectBO findAttEvcctionRecCollectBO(String id,String personID)
	throws SysException {
		AttEvcctionRecCollectBO attevcctionreccollectbo=null;
		List list=cardMessageDAO.findAttEvcctionRecCollectBO(id,personID);
		if(list!=null && list.size()>0){
			attevcctionreccollectbo=(AttEvcctionRecCollectBO)list.get(0);
		}
return attevcctionreccollectbo;
}
	
	public void deleteAttEvcctionRecCollectBO(String id)
	throws SysException {
		cardMessageDAO.deleteBo(AttEvcctionRecCollectBO.class, id);
}
	
	public void saveAttEvcctionRecBO(AttEvcctionRecBO bo) throws SysException {
		cardMessageDAO.saveOrUpdateBo(bo);
	}
	
	public void saveAttEvcctionRecCollectBO(AttEvcctionRecCollectBO bo) throws SysException {
		cardMessageDAO.saveOrUpdateBo(bo);
	}
	
	public List findAttTimeOffRecBO(String overTimeNO) throws SysException {
		return cardMessageDAO.findAttTimeOffRecBO(overTimeNO);
	}
	
	public void UpdateAttTimeOffRecBO(String overTimeNO) throws SysException {
       String updateSQL = "update ATT_TIME_OFF_REC set STATUS_VALUE='3' where OVER_TIME_NO='" + overTimeNO + "'";
       activeapi.executeSql(updateSQL);
    }
	
	public void UpdateAttTimeOffRecBO1(String personId,String overTimeNO) throws SysException {
	       String updateSQL = "update ATT_TIME_OFF_REC set STATUS_VALUE='3' where PERSON_ID='"+personId+"' and OVER_TIME_NO='" + overTimeNO + "'";
	       activeapi.executeSql(updateSQL);
	}
	
	public List findAttTimeOffRecBO(String personId,String overTimeNO) throws SysException {
		return cardMessageDAO.findAttTimeOffRecBO(personId,overTimeNO);
	}
	
	public void deleteAttTimeOffRecBO(String personId,String overTimeNO) throws SysException {
		String sql = "delete from ATT_TIME_OFF_REC where PERSON_ID='"+personId+"' and OVER_TIME_NO='" + overTimeNO + "' and STATUS_VALUE='3'";
		activeapi.executeSql(sql);
	}
	
	public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine)
			throws SysException {
	   if(wt.getLinkID()!=null && !"".equals(wt.getLinkID())){
		AttEvcctionRecBO attevcctionrecbo=findAttEvcctionRecBObyId(wt.getLinkID());
		if(attevcctionrecbo!=null){
			String sql = wfdefine.getSql().replaceAll("\\$K\\$",attevcctionrecbo.getPersonID());
			String con = activeapi.queryForString(sql);
			if (wfdefine.getConValue().indexOf(con) >= 0) {
				return true;
			}
		}
	   }else{
			String sql = wfdefine.getSql().replaceAll("\\$K\\$",wt.getUser().getUserId());
			String con = activeapi.queryForString(sql);
			if (wfdefine.getConValue().indexOf(con) >= 0) {
				return true;
			}
	   }
		return false;
	}

	public void whenEnd(WFTransaction wt) throws SysException {
		AttEvcctionRecBO attevcctionrecbo=findAttEvcctionRecBObyId(wt.getLinkID());
		if(attevcctionrecbo!=null){
			if("2".equals(attevcctionrecbo.getSuperFlId())){ //����
				AttEvcctionRecCollectBO attevcctionreccollectbo=findAttEvcctionRecCollectBO(attevcctionrecbo.getSuperFurloughNo(),attevcctionrecbo.getPersonID());
				if(attevcctionreccollectbo!=null){
					attevcctionreccollectbo.setEndTime(attevcctionrecbo.getEndTime());
					attevcctionreccollectbo.setStatusValue("3");
					attevcctionreccollectbo.setSuperFlId("0");
					saveAttEvcctionRecCollectBO(attevcctionreccollectbo);
					attevcctionrecbo.setStatusValue("3");
					attevcctionrecbo.setSuperFurloughNo(attevcctionreccollectbo.getEvcctionNo());
					saveAttEvcctionRecBO(attevcctionrecbo);
					
					//���õ���״̬
					List atttimeoffrecbovalue=findAttTimeOffRecBO(attevcctionreccollectbo.getPersonID(),attevcctionreccollectbo.getEvcctionNo());
					if(atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0){
						deleteAttTimeOffRecBO(attevcctionreccollectbo.getPersonID(),attevcctionreccollectbo.getEvcctionNo());
						UpdateAttTimeOffRecBO1(attevcctionreccollectbo.getPersonID(),attevcctionreccollectbo.getEvcctionNo());
					}else{
						deleteAttTimeOffRecBO(attevcctionreccollectbo.getPersonID(),attevcctionreccollectbo.getEvcctionNo());
					}
				}
			}else if("3".equals(attevcctionrecbo.getSuperFlId())){ //����
				AttEvcctionRecCollectBO attevcctionreccollectbo=findAttEvcctionRecCollectBO(attevcctionrecbo.getSuperFurloughNo(),attevcctionrecbo.getPersonID());
				if(attevcctionreccollectbo!=null){
					String old_begin_date=attevcctionreccollectbo.getBeginTime().trim();
					String old_end_time=attevcctionreccollectbo.getEndTime().trim();
					String new_begin_date=attevcctionrecbo.getBeginTime().trim();
					String new_end_time=attevcctionrecbo.getEndTime().trim();					
					String i= compare_date(old_begin_date,new_begin_date);
					String j= compare_date(old_end_time,new_end_time);
					if("-1".equals(i)){
						if("1".endsWith(j)){
							AttEvcctionRecCollectBO attevcctionreccollectbo1=new AttEvcctionRecCollectBO();
							attevcctionreccollectbo1.setEvcctionNo(attevcctionrecbo.getSuperFurloughNo());
							attevcctionreccollectbo1.setPersonID(attevcctionrecbo.getPersonID());
							attevcctionreccollectbo1.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
							attevcctionreccollectbo1.setBeginTime(attevcctionreccollectbo.getBeginTime());
							attevcctionreccollectbo1.setEndTime(attevcctionrecbo.getBeginTime());
							attevcctionreccollectbo1.setStatusValue("3");
							attevcctionreccollectbo1.setSuperFlId("0");
							saveAttEvcctionRecCollectBO(attevcctionreccollectbo1);
							
							AttEvcctionRecCollectBO attevcctionreccollectbo2=new AttEvcctionRecCollectBO();
							attevcctionreccollectbo2.setEvcctionNo(attevcctionrecbo.getSuperFurloughNo());
							attevcctionreccollectbo2.setPersonID(attevcctionrecbo.getPersonID());
							attevcctionreccollectbo2.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
							attevcctionreccollectbo2.setBeginTime(attevcctionrecbo.getEndTime());
							attevcctionreccollectbo2.setEndTime(attevcctionreccollectbo.getEndTime());
							attevcctionreccollectbo2.setStatusValue("3");
							attevcctionreccollectbo2.setSuperFlId("0");
							saveAttEvcctionRecCollectBO(attevcctionreccollectbo2);
							
							deleteAttEvcctionRecCollectBO(attevcctionreccollectbo.getEvcctionCollectNo());
							
							attevcctionrecbo.setStatusValue("3");
							attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getSuperFurloughNo());
							saveAttEvcctionRecBO(attevcctionrecbo);
						}else if("0".equals(j)){
							attevcctionreccollectbo.setEndTime(attevcctionrecbo.getBeginTime());
							attevcctionreccollectbo.setStatusValue("3");
							attevcctionreccollectbo.setSuperFlId("0");
							saveAttEvcctionRecCollectBO(attevcctionreccollectbo);
							attevcctionrecbo.setStatusValue("3");
							attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getSuperFurloughNo());
							saveAttEvcctionRecBO(attevcctionrecbo);
						}
					}else if("0".equals(i)){
						if("1".endsWith(j)){
							attevcctionreccollectbo.setBeginTime(attevcctionrecbo.getEndTime());
							attevcctionreccollectbo.setStatusValue("3");
							attevcctionreccollectbo.setSuperFlId("0");
							saveAttEvcctionRecCollectBO(attevcctionreccollectbo);
							attevcctionrecbo.setStatusValue("3");
							attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getSuperFurloughNo());
							saveAttEvcctionRecBO(attevcctionrecbo);
						}else if("0".equals(j)){
							deleteAttEvcctionRecCollectBO(attevcctionreccollectbo.getEvcctionCollectNo());
							attevcctionrecbo.setStatusValue("3");
							attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getSuperFurloughNo());
							saveAttEvcctionRecBO(attevcctionrecbo);
						}
					}
					
					//���õ���״̬
					List atttimeoffrecbovalue=findAttTimeOffRecBO(attevcctionrecbo.getPersonID(),attevcctionrecbo.getSuperFurloughNo());
					if(atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0){
						deleteAttTimeOffRecBO(attevcctionrecbo.getPersonID(),attevcctionrecbo.getSuperFurloughNo());
						UpdateAttTimeOffRecBO1(attevcctionrecbo.getPersonID(),attevcctionrecbo.getSuperFurloughNo());
					}else{
						deleteAttTimeOffRecBO(attevcctionrecbo.getPersonID(),attevcctionrecbo.getSuperFurloughNo());
					}
				}
			}else{
				if("1".equals(attevcctionrecbo.getEvcctionType().trim())){
					AttEvcctionRecCollectBO attevcctionreccollectbo =new AttEvcctionRecCollectBO();
					attevcctionreccollectbo.setEvcctionNo(attevcctionrecbo.getEvcctionNO());
					attevcctionreccollectbo.setPersonID(attevcctionrecbo.getPersonID());
					attevcctionreccollectbo.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
					attevcctionreccollectbo.setBeginTime(attevcctionrecbo.getBeginTime());
					attevcctionreccollectbo.setEndTime(attevcctionrecbo.getEndTime());
					attevcctionreccollectbo.setStatusValue("3");
					attevcctionreccollectbo.setSuperFlId("0");
					saveAttEvcctionRecCollectBO(attevcctionreccollectbo);
				}else if("2".equals(attevcctionrecbo.getEvcctionType().trim())){
					String[] persongroupids=attevcctionrecbo.getPersonGroupID().split(",");
					for(int x=0;x<persongroupids.length;x++){
					   String ids=persongroupids[x];
					   AttEvcctionRecCollectBO attevcctionreccollectbo =new AttEvcctionRecCollectBO();
					   attevcctionreccollectbo.setEvcctionNo(attevcctionrecbo.getEvcctionNO());
					   attevcctionreccollectbo.setPersonID(ids);
					   attevcctionreccollectbo.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
					   attevcctionreccollectbo.setBeginTime(attevcctionrecbo.getBeginTime());
					   attevcctionreccollectbo.setEndTime(attevcctionrecbo.getEndTime());
					   attevcctionreccollectbo.setStatusValue("3");
					   attevcctionreccollectbo.setSuperFlId("0");
					   saveAttEvcctionRecCollectBO(attevcctionreccollectbo);
					}
				}
				//���ó���״̬
				attevcctionrecbo.setStatusValue("3");
				attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getEvcctionNO());
				saveAttEvcctionRecBO(attevcctionrecbo);
				//���õ���״̬
				List atttimeoffrecbovalue=findAttTimeOffRecBO(attevcctionrecbo.getEvcctionNO());
				if(atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0){
					UpdateAttTimeOffRecBO(attevcctionrecbo.getEvcctionNO());
				}
			}
		}
	}

	public void whenStart(WFTransaction wt) throws SysException {
	}
    public void whenCreateNextNode(WFTransaction wt, WFNodeBO node) throws SysException{
        //  �����½ڵ�
    }
    
	/*
	 * java���ڱȽϴ�С
	 */
	public static String compare_date(String DATE1, String DATE2) {
       String argments="0";	        
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        try {
            Date dt1 = df.parse(DATE1);
            Date dt2 = df.parse(DATE2);
            if (dt1.getTime() > dt2.getTime()) {
            	argments="1";	
                return argments;
            } else if (dt1.getTime() < dt2.getTime()) {
            	argments="-1";	
                return argments;
            } else {	
                return argments;
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return argments;
    }
}
