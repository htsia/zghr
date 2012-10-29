package com.hr319wg.xys.eva.ucc;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.XysXspjScoreBO;

public interface IStudentGradeUCC {
	public List getXysXspjScoreBO(PageVO pagevo,String planId,String queryValue)throws SysException;
	public XysXspjScoreBO findEqualsXysXspjScoreBO(String planId,String personId)throws SysException;
	public XysXspjScoreBO findXysXspjScoreBOById(String id)throws SysException;
	public void saveXysXspjScoreBO(XysXspjScoreBO bo)throws SysException;
	public void deleteXysXspjScoreBO(String id)throws SysException;
}
