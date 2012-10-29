package com.hr319wg.xys.eva.ucc.impl;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.XysXspjScoreBO;
import com.hr319wg.xys.eva.service.StudentGradeService;
import com.hr319wg.xys.eva.ucc.IStudentGradeUCC;

public class StudentGradeUCC implements IStudentGradeUCC{
	private StudentGradeService studentGradeService;
	
	public List getXysXspjScoreBO(PageVO pagevo,String planId,String queryValue)throws SysException{
		return this.studentGradeService.getXysXspjScoreBO(pagevo, planId, queryValue);
	}
	public XysXspjScoreBO findEqualsXysXspjScoreBO(String planId,String personId)throws SysException{
		return this.studentGradeService.findEqualsXysXspjScoreBO(planId, personId);
	}
	public XysXspjScoreBO findXysXspjScoreBOById(String id)throws SysException{
		return this.studentGradeService.findXysXspjScoreBOById(id);
	}
	public void saveXysXspjScoreBO(XysXspjScoreBO bo)throws SysException{
		this.studentGradeService.saveXysXspjScoreBO(bo);
	}
	public void deleteXysXspjScoreBO(String id)throws SysException{
		this.studentGradeService.deleteXysXspjScoreBO(id);
	}
	
	public StudentGradeService getStudentGradeService() {
		return studentGradeService;
	}

	public void setStudentGradeService(StudentGradeService studentGradeService) {
		this.studentGradeService = studentGradeService;
	}
	
	
}
