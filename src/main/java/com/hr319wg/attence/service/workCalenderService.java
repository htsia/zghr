package com.hr319wg.attence.service;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.attence.dao.AttWorkCalenderDAO;
import com.hr319wg.attence.pojo.bo.AttWorkCalendarBO;
import com.hr319wg.common.exception.SysException;

public class workCalenderService {
    private AttWorkCalenderDAO attWorkCalenderDAO;

    public AttWorkCalenderDAO getAttWorkCalenderDAO() {
        return attWorkCalenderDAO;
    }

    public void setAttWorkCalenderDAO(AttWorkCalenderDAO attWorkCalenderDAO) {
        this.attWorkCalenderDAO = attWorkCalenderDAO;
    }

    public Hashtable getAttWorkCalendarBO(String personID, String date) throws SysException {
        Hashtable hashTable = new Hashtable();
        String personID1 = personID;
        String date1 = date;
        try {
            List lists = findAttWorkCalendarBO(personID1, date1);
            if (lists != null && lists.size() > 0) {
                for (int i = 0; i < lists.size(); i++) {
                    AttWorkCalendarBO bo = (AttWorkCalendarBO) lists.get(i);
                    String bos = (String) hashTable.get(bo.getDate());
                    if (bos != null && !"".equals(bos)) {
                        String bosss = bos + ";" + bo.getActivity();
                        hashTable.put(bo.getDate(), bosss);
                    } else {
                        hashTable.put(bo.getDate(), bo.getActivity());
                    }
                }
            }
        } catch (SysException e) {
        }
        return hashTable;
    }

    public List findAttWorkCalendarBO(String personID, String date) throws SysException {
        return attWorkCalenderDAO.getAttWorkCalendarBO(personID, date);
    }

    public List findAttWorkCalendarBO1(String personID, String date) throws SysException {
        return attWorkCalenderDAO.getAttWorkCalendarBO1(personID, date);
    }

    public List getAttMimicReportRecBO(String personID, String date) throws SysException {
        return attWorkCalenderDAO.getAttMimicReportRecBO(personID, date);
    }

    public AttWorkCalendarBO findBobyId(String id) throws SysException {
        return (AttWorkCalendarBO) attWorkCalenderDAO.findBoById(AttWorkCalendarBO.class, id);
    }

    public void deleteAttWorkCalendarBO(String id) throws SysException {
        attWorkCalenderDAO.deleteBo(AttWorkCalendarBO.class, id);
    }

    public void saveorupdateAttWorkCalendarBO(AttWorkCalendarBO bo) throws SysException {
        attWorkCalenderDAO.saveOrUpdateBo(bo);
    }

    public List getEmployeeCalendar(String superId) throws SysException {
        return attWorkCalenderDAO.getEmployeeCalendar(superId);
    }
}
