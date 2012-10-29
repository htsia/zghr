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
			        adjust.setAdjustType("岗位调整");
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
//			        			薪级(A223200) 用户 否 代码 1 启用    
//			        			 
//			        			 标准工资(A223202) 用户 否 小数 3 启用    
//			        			 
//			        			 职务补贴(A223207) 用户 否 小数 4 启用    
//			        			 
//			        			 浮动工资(A223203) 用户 否 小数 5 启用    
//			        			 
//			        			 午餐补助(A223208) 用户 否 代码 6 启用    
//			        			 
//			        			 变动时间(A223204) 用户 否 八位日期 10 启用    
//			        			
			        			if("A223200".equals(fieldID)){ //薪级
			        				sql = "select C001203 from a001 a,c001 c where a.A001715=c.postid and a.id='"+userID+"'";
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}else{
			        					dBo.setNewValue(this.activeapi.queryForString(sql));
			        				}
			        			}else if("A223202".equals(fieldID)){//标准工资
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}
			        			}else if("A223207".equals(fieldID)){//职务补贴
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}
			        			}else if("A223203".equals(fieldID)){//浮动工资
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}
			        			}else if("A223208".equals(fieldID)){//午餐补助
			        				if(dBo.getOldValue()!=null){
			        					dBo.setNewValue(dBo.getOldValue());
			        				}
			        			}else if("A223204".equals(fieldID)){//变动时间
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