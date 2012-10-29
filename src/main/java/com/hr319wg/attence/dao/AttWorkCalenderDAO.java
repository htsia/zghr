package com.hr319wg.attence.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;

public class AttWorkCalenderDAO extends BaseDAO {
	public List getAttWorkCalendarBO(String personID,String date) throws SysException {
		String hsql = "select bo from AttWorkCalendarBO bo where bo.personID='"+ personID + "' and bo.date like '%"+date+"%' order by bo.seq";
		return this.hibernatetemplate.find(hsql);
	}
	public List getAttWorkCalendarBO1(String personID,String date) throws SysException {
		String hsql = "select bo from AttWorkCalendarBO bo where bo.personID='"+ personID + "' and bo.date='"+date+"' order by bo.seq";
		return this.hibernatetemplate.find(hsql);
	}
	public List getAttMimicReportRecBO(String personID,String date) throws SysException {
		String hsql = "select bo from AttMimicReportRecBO bo where bo.personID='"+ personID + "' and bo.mrMonth like '%"+date+"%' and bo.statusValue='3' order by bo.mrYear";
		return this.hibernatetemplate.find(hsql);
	}
	public List getEmployeeCalendar(String superId) throws SysException {
		String hsql = "select bo from PersonBO bo where bo.postId in (select pb.postId from PostBO pb where pb.superId='"+superId+"')";
		return this.hibernatetemplate.find(hsql);
	}
}
