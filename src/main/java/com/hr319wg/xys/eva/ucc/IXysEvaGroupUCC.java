package com.hr319wg.xys.eva.ucc;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupBO;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupPostBO;

public interface IXysEvaGroupUCC {
	public List getEvaGroupBO(PageVO pagevo,String orgId)throws SysException;
	public EvaGroupBO findEvaGroupBOById(String groupId)throws SysException;
	public void saveEvaGroupBO(EvaGroupBO bo)throws SysException;
	public void deleteEvaGroupBO(String groupId)throws SysException;
	
	public List getEvaGroupPostBO(PageVO pagevo,String groupId)throws SysException;
	public EvaGroupPostBO findEqualsEvaGroupPostBO(String groupId,String postId)throws SysException;
	public EvaGroupPostBO findEvaGroupPostBOById(String id)throws SysException;
	public void saveEvaGroupPostBO(EvaGroupPostBO bo)throws SysException;
	public void deleteEvaGroupPostBO(String id)throws SysException;
	
	public void deleteAll(List list)throws SysException;
}
