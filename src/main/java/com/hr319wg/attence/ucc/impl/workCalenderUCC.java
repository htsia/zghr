package com.hr319wg.attence.ucc.impl;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttWorkCalendarBO;
import com.hr319wg.attence.service.workCalenderService;
import com.hr319wg.attence.ucc.IworkCalenderUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.service.ActivePageService;

public class workCalenderUCC implements IworkCalenderUCC {
private workCalenderService attWorkCalenderService;
private ActivePageService activepageservice;
public workCalenderService getAttWorkCalenderService() {
	return attWorkCalenderService;
}
public void setAttWorkCalenderService(workCalenderService attWorkCalenderService) {
	this.attWorkCalenderService = attWorkCalenderService;
}
public ActivePageService getActivepageservice() {
	return activepageservice;
}
public void setActivepageservice(ActivePageService activepageservice) {
	this.activepageservice = activepageservice;
}

public Hashtable getAttWorkCalendarBO(String personID,String date) throws SysException{
  return attWorkCalenderService.getAttWorkCalendarBO(personID, date);	
}
public List findAttWorkCalendarBO(String personID,String date) throws SysException{
	return attWorkCalenderService.findAttWorkCalendarBO(personID, date);	
}
public List findAttWorkCalendarBO1(String personID,String date) throws SysException{
	return attWorkCalenderService.findAttWorkCalendarBO1(personID, date);	
}
public List getAttMimicReportRecBO(String personID,String date) throws SysException{
	return attWorkCalenderService.getAttMimicReportRecBO(personID, date);	
}
public AttWorkCalendarBO findBobyId(String id) throws SysException {
	return attWorkCalenderService.findBobyId(id);
}
public void deleteAttWorkCalendarBO(String id) throws SysException {
	attWorkCalenderService.deleteAttWorkCalendarBO(id);
}
public void saveorupdateAttWorkCalendarBO(AttWorkCalendarBO bo) throws SysException {
	attWorkCalenderService.saveorupdateAttWorkCalendarBO(bo);
}
public List getEmployeeCalendar(String superId) throws SysException {
	return attWorkCalenderService.getEmployeeCalendar(superId);
}
}
