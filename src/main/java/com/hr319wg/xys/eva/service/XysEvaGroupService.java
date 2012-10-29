package com.hr319wg.xys.eva.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.dao.XysEvaGroupDAO;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupBO;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupPostBO;

public class XysEvaGroupService {
	private  XysEvaGroupDAO xysEvaGroupDAO;

	
	public List getEvaGroupBO(PageVO pagevo,String orgId)throws SysException{
		return this.xysEvaGroupDAO.getEvaGroupBO(pagevo, orgId);
	}
	public EvaGroupBO findEvaGroupBOById(String groupId)throws SysException{
		return (EvaGroupBO)this.xysEvaGroupDAO.findBoById(EvaGroupBO.class, groupId);
	}
	public void saveEvaGroupBO(EvaGroupBO bo)throws SysException{
		this.xysEvaGroupDAO.saveOrUpdateBo(bo);
	}
	public void deleteEvaGroupBO(String groupId)throws SysException{
		this.xysEvaGroupDAO.deleteBo(EvaGroupBO.class, groupId);
	}
	
	
	public List getEvaGroupPostBO(PageVO pagevo,String groupId)throws SysException{
		return this.xysEvaGroupDAO.getEvaGroupPostBO(pagevo, groupId);
	}
	
	public EvaGroupPostBO findEqualsEvaGroupPostBO(String groupId,String postId)throws SysException{
		return this.xysEvaGroupDAO.findEqualsEvaGroupPostBO(groupId, postId);
	}
	public EvaGroupPostBO findEvaGroupPostBOById(String id)throws SysException{
		return (EvaGroupPostBO)this.xysEvaGroupDAO.findBoById(EvaGroupPostBO.class,id);
	}
	public void saveEvaGroupPostBO(EvaGroupPostBO bo)throws SysException{
		this.xysEvaGroupDAO.saveOrUpdateBo(bo);
	}
	public void deleteEvaGroupPostBO(String id)throws SysException{
		this.xysEvaGroupDAO.deleteBo(EvaGroupPostBO.class, id);
	}
	
	public void deleteAll(List list)throws SysException{
		this.xysEvaGroupDAO.deleteAll(list);
	}
	
	public XysEvaGroupDAO getXysEvaGroupDAO() {
		return xysEvaGroupDAO;
	}

	public void setXysEvaGroupDAO(XysEvaGroupDAO xysEvaGroupDAO) {
		this.xysEvaGroupDAO = xysEvaGroupDAO;
	}
	
}
