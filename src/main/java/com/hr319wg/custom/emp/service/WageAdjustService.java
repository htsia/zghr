package com.hr319wg.custom.emp.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.custom.dao.CommonDAO;
import com.hr319wg.emp.pojo.bo.EmpPostChangeBO;
import com.hr319wg.emp.pojo.bo.OrgPostChangeBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.impl.EmpPostChangeUCC;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;
import com.hr319wg.wage.ucc.IWageAdjustUCC;


public class WageAdjustService {

	private CommonDAO commonDAO;
	private EmpPostChangeUCC empPostChangeUCC;
	private IWageAdjustUCC adjustucc;
	private ActivePageAPI activeapi;
	
	
	public ActivePageAPI getActiveapi() {
		return activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}

	public EmpPostChangeUCC getEmpPostChangeUCC() {
		return empPostChangeUCC;
	}

	public void setEmpPostChangeUCC(EmpPostChangeUCC empPostChangeUCC) {
		this.empPostChangeUCC = empPostChangeUCC;
	}

	public IWageAdjustUCC getAdjustucc() {
		return adjustucc;
	}

	public void setAdjustucc(IWageAdjustUCC adjustucc) {
		this.adjustucc = adjustucc;
	}

	public CommonDAO getCommonDAO() {
		return commonDAO;
	}

	public void setCommonDAO(CommonDAO commonDAO) {
		this.commonDAO = commonDAO;
	}

	public void setPostChangeWage(String orgID) throws SysException{
		List<EmpPostChangeBO> changeList = this.commonDAO.getAllEmpPostChangeBO();
		if(changeList!=null){
			for(EmpPostChangeBO bo : changeList){
				WageAdjustBO adjust = (WageAdjustBO)this.commonDAO.findBoById(WageAdjustBO.class, bo.getPostChangeId());
		        if (adjust == null) {
		        	adjust = new WageAdjustBO();
			        PersonBO pb = SysCacheTool.findPersonById(bo.getPersonId());
			        adjust = new WageAdjustBO();
			        adjust.setPersonID(bo.getPersonId());
			        adjust.setOrgID(pb.getOrgId());
			        adjust.setStatus(WageAdjustBO.STATUS_APPLY);
			        adjust.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			        adjust.setLinkID(bo.getPostChangeId());
			        adjust.setAdjustType("��λ����");
			        this.commonDAO.saveOrUpdateBo(adjust);
	
			        OrgPostChangeBO opo = this.empPostChangeUCC.findOrgPostChangeBO(orgID);
			        if ((opo != null) && (opo.getWageItem() != null) && (!opo.getWageItem().equals(""))){
			        	this.adjustucc.createAdjustDetail(bo.getPersonId(), adjust.getItemID(), opo.getWageItem().split(","));
			        	List<WageAdjustDetailBO> detailList = this.commonDAO.getAllWageAdjustBO(adjust.getItemID());
			        	if(detailList!=null){
			        		String sql = "select person_id from WAGE_ADJUST where item_id='"+bo.getPassPostLevel()+"'";
			        		String userID = this.activeapi.queryForString(sql);
			        		for(WageAdjustDetailBO dBo : detailList){
			        			String fieldID = dBo.getFieldID();
//			        			н��(A223200) �û� �� ���� 1 ����    
//			        			 
//			        			 ��׼����(A223202) �û� �� С�� 3 ����    
//			        			 
//			        			 ְ����(A223207) �û� �� С�� 4 ����    
//			        			 
//			        			 ��������(A223203) �û� �� С�� 5 ����    
//			        			 
//			        			 ��Ͳ���(A223208) �û� �� ���� 6 ����    
//			        			 
//			        			 �䶯ʱ��(A223204) �û� �� ��λ���� 10 ����    
//			        			
			        			if("A223200".equals(fieldID)){ //н��
			        				sql = "select C001203 from a001 a,c001 c where a.A001715=c.postid and a.id='"+userID+"'";
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}else{
			        					dBo.setNewValue(this.activeapi.queryForString(sql));
			        				}
			        			}else if("A223202".equals(fieldID)){//��׼����
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}
			        			}else if("A223207".equals(fieldID)){//ְ����
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}
			        			}else if("A223203".equals(fieldID)){//��������
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}
			        			}else if("A223208".equals(fieldID)){//��Ͳ���
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}
			        			}else if("A223204".equals(fieldID)){//�䶯ʱ��
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}else{
			        					dBo.setNewValue(CommonFuns.getSysDate("yyyy-MM-dd"));
			        				}
			        			}
			        			this.commonDAO.saveOrUpdateBo(dBo);
			        		}
			        	}
			        }
		        }
			}
		}
	}
	
	
}