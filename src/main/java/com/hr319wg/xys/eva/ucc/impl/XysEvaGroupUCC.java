package com.hr319wg.xys.eva.ucc.impl;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupBO;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupPostBO;
import com.hr319wg.xys.eva.service.XysEvaGroupService;
import com.hr319wg.xys.eva.ucc.IXysEvaGroupUCC;

public class XysEvaGroupUCC implements IXysEvaGroupUCC{
	private XysEvaGroupService xysEvaGroupService;

	public List getEvaGroupBO(PageVO pagevo,String orgId)throws SysException{
		return this.xysEvaGroupService.getEvaGroupBO(pagevo, orgId);
	}
	public EvaGroupBO findEvaGroupBOById(String groupId)throws SysException{
		return this.xysEvaGroupService.findEvaGroupBOById(groupId);
	}
	public void saveEvaGroupBO(EvaGroupBO bo)throws SysException{
		this.xysEvaGroupService.saveEvaGroupBO(bo);
	}
	public void deleteEvaGroupBO(String groupId)throws SysException{
		this.xysEvaGroupService.deleteEvaGroupBO(groupId);
	}
	
	public List getEvaGroupPostBO(PageVO pagevo,String groupId)throws SysException{
		return this.xysEvaGroupService.getEvaGroupPostBO(pagevo, groupId);
	}
	public EvaGroupPostBO findEqualsEvaGroupPostBO(String groupId,String postId)throws SysException{
		return this.xysEvaGroupService.findEqualsEvaGroupPostBO(groupId, postId);
	}
	public EvaGroupPostBO findEvaGroupPostBOById(String id)throws SysException{
		return this.xysEvaGroupService.findEvaGroupPostBOById(id);
	}
	public void saveEvaGroupPostBO(EvaGroupPostBO bo)throws SysException{
		this.xysEvaGroupService.saveEvaGroupPostBO(bo);
	}
	public void deleteEvaGroupPostBO(String id)throws SysException{
		this.xysEvaGroupService.deleteEvaGroupPostBO(id);
	}
	
	public void deleteAll(List list)throws SysException{
		this.xysEvaGroupService.deleteAll(list);
	}
	
	public XysEvaGroupService getXysEvaGroupService() {
		return xysEvaGroupService;
	}

	public void setXysEvaGroupService(XysEvaGroupService xysEvaGroupService) {
		this.xysEvaGroupService = xysEvaGroupService;
	}
	
	
}
