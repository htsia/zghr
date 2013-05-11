package com.hr319wg.custom.emp.service;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.emp.dao.EmpTypeChangeDAO;
import com.hr319wg.custom.emp.pojo.bo.EmpPersonTypeChangeBO;
import com.hr319wg.custom.emp.pojo.bo.OrgPersonTypeChangeBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.ucc.IWageAdjustUCC;


public class EmpTypeChangeServiceImpl implements IEmpTypeChangeService{

	private JdbcTemplate jdbcTemplate;
	private ActivePageAPI pageAPI;
	private EmpTypeChangeDAO changeDAO;
	private IWageAdjustUCC adjustucc;
	
	public IWageAdjustUCC getAdjustucc() {
		return adjustucc;
	}

	public void setAdjustucc(IWageAdjustUCC adjustucc) {
		this.adjustucc = adjustucc;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public ActivePageAPI getPageAPI() {
		return pageAPI;
	}

	public void setPageAPI(ActivePageAPI pageAPI) {
		this.pageAPI = pageAPI;
	}

	public EmpTypeChangeDAO getChangeDAO() {
		return changeDAO;
	}

	public void setChangeDAO(EmpTypeChangeDAO changeDAO) {
		this.changeDAO = changeDAO;
	}

	public List getEmpTypeChangeBO(PageVO pagevo, String orgId, User user,
			String name, boolean apprived, String time, String time2)
			throws SysException {
		return this.changeDAO.getEmpTypeChangeBO(pagevo, orgId, user, name, apprived, time, time2);
	}

	public void batchSaveTypeChange(String[] IDs, String newType, User user)
			throws SysException {
		for(int i=0; i<IDs.length; i++){
			PersonBO pbo = SysCacheTool.findPersonById(IDs[i]);
			EmpPersonTypeChangeBO bo = new EmpPersonTypeChangeBO();
			bo.setPersonID(IDs[i]);
			bo.setOldType(pbo.getPersonType());
			bo.setNewType(newType);
			bo.setChangeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			bo.setApplyPersonID(user.getUserId());
			bo.setApplyPersonName(user.getName());
			bo.setStatus("0");
			
			PersonBO pb = SysCacheTool.findPersonById(IDs[i]);
			WageAdjustBO adjust = new WageAdjustBO();
			adjust.setPersonID(IDs[i]);
			adjust.setOrgID(pb.getOrgId());
			adjust.setStatus(WageAdjustBO.STATUS_APPLY);
			adjust.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			adjust.setAdjustType("人员类别调整");
			this.adjustucc.saveWageAdjustBO(adjust);
			
			bo.setLinkAdjustID(adjust.getItemID());
			this.changeDAO.saveOrUpdateBo(bo);
			
			OrgPersonTypeChangeBO cbo=(OrgPersonTypeChangeBO) this.changeDAO.findBoById(OrgPersonTypeChangeBO.class, user.getOrgId());
			if(cbo!=null && cbo.getWageItem()!=null && !"".equals(cbo.getWageItem())){
				this.adjustucc.createAdjustDetail(IDs[i], adjust.getItemID(), cbo.getWageItem().split(","));					
			}
		}
	}

	public void deleteTypeChange(String ID) throws SysException {
		this.changeDAO.deleteBo(EmpPersonTypeChangeBO.class, ID);
	}

	public Object getObjByID(Class c, String ID) throws SysException {
		return this.changeDAO.findBoById(c, ID);
	}

	public void saveObj(Object obj) throws SysException {
		this.changeDAO.saveOrUpdateBo(obj);
	}

	public void batchUpdateTypeChange(String[] typeChangeIDs)
			throws SysException {
		for(int i=0; i<typeChangeIDs.length; i++){
			EmpPersonTypeChangeBO bo=(EmpPersonTypeChangeBO) this.changeDAO.findBoById(EmpPersonTypeChangeBO.class, typeChangeIDs[i]);
			if(bo!=null && "0".equals(bo.getStatus())){
				bo.setStatus("1");
				bo.setChangedDate(CommonFuns.getSysDate("yyyy-MM-dd"));
				this.changeDAO.updateBo(bo.getTypeChangeID(), bo);
				String sql="update a001 a set a.a001054='"+bo.getNewType()+"' where id ='"+bo.getPersonID()+"'";
				this.jdbcTemplate.execute(sql);
				sql="update wage_adjust w set w.approstatus='1' where w.item_id='"+bo.getLinkAdjustID()+"'";
				this.jdbcTemplate.execute(sql);
				PersonBO p=SysCacheTool.findPersonById(bo.getPersonID());
				this.jdbcTemplate.execute("begin PROC_CHANGETYPE('"+p.getPersonId()+"', '"+p.getOrgId()+"', '"+p.getDeptId()+"', '"+bo.getOldType()+"', '"+bo.getNewType()+"'); end;");
			}
		}
	}
}
