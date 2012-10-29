package com.hr319wg.attence.ucc;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttWorkCalendarBO;
import com.hr319wg.common.exception.SysException;

public interface IworkCalenderUCC {
	public Hashtable getAttWorkCalendarBO(String personID,String date) throws SysException;
	public List findAttWorkCalendarBO(String personID,String date) throws SysException;
	public List findAttWorkCalendarBO1(String personID,String date) throws SysException;
	public AttWorkCalendarBO findBobyId(String id) throws SysException;
	public void deleteAttWorkCalendarBO(String id) throws SysException;
	public void saveorupdateAttWorkCalendarBO(AttWorkCalendarBO bo) throws SysException;
	public List getEmployeeCalendar(String superId) throws SysException;
}
