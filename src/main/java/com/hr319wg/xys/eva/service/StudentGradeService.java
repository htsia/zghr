package com.hr319wg.xys.eva.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.dao.StudentGradeDAO;
import com.hr319wg.xys.eva.pojo.bo.XysXspjScoreBO;

public class StudentGradeService {
	private StudentGradeDAO studentGradeDAO;
	
	public List getXysXspjScoreBO(PageVO pagevo,String planId,String queryValue)throws SysException{
		return this.studentGradeDAO.getXysXspjScoreBO(pagevo, planId, queryValue);
	}
	public XysXspjScoreBO findEqualsXysXspjScoreBO(String planId,String personId)throws SysException{
		return this.studentGradeDAO.findEqualsXysXspjScoreBO(planId, personId);
	}
	public XysXspjScoreBO findXysXspjScoreBOById(String id)throws SysException{
		return (XysXspjScoreBO)this.studentGradeDAO.findBoById(XysXspjScoreBO.class, id);
	}
	public void saveXysXspjScoreBO(XysXspjScoreBO bo)throws SysException{
		this.studentGradeDAO.saveOrUpdateBo(bo);
	}
	public void deleteXysXspjScoreBO(String id)throws SysException{
		this.studentGradeDAO.deleteBo(XysXspjScoreBO.class, id);
	}
	
	
	public StudentGradeDAO getStudentGradeDAO() {
		return studentGradeDAO;
	}

	public void setStudentGradeDAO(StudentGradeDAO studentGradeDAO) {
		this.studentGradeDAO = studentGradeDAO;
	}
	
}
