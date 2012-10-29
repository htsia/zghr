package com.hr319wg.attence.service;

import com.hr319wg.attence.util.DateUtil;
import com.hr319wg.attence.dao.AttFeastDAO;
import com.hr319wg.attence.dao.AttRestChgDAO;
import com.hr319wg.attence.dao.AttRestWeekDAO;
import com.hr319wg.attence.pojo.bo.AttFeastBO;
import com.hr319wg.attence.pojo.bo.AttRestChangeBO;
import com.hr319wg.attence.pojo.bo.AttRestOfWeekBO;
import com.hr319wg.attence.pojo.bo.AttRestStoreBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-2-1
 * Time: 下午1:40
 * To change this template use File | Settings | File Templates.
 */
public class AttRestChgService {
    private AttRestChgDAO attRestChgDAO;
    private AttFeastDAO attFeastDAO;
    private AttRestWeekDAO attRestWeekDAO;


    // AttRestStoreBO
    public List getAllAttRestStoreBO(PageVO pagevo, String begin, String end, String orgId, String queryValue) throws SysException {
        return this.attRestChgDAO.getAllAttRestStoreBO(pagevo, begin, end, orgId, queryValue);
    }

    public List getAttRestStoreBOByPid(PageVO pagevo, String personId) throws SysException {
        return this.attRestChgDAO.getAttRestChangeBOByPid(pagevo, personId);
    }

    public AttRestStoreBO findAttRestStoreBOById(String storeId) throws SysException {
        return (AttRestStoreBO) this.attRestChgDAO.findBoById(AttRestStoreBO.class, storeId);
    }

    public void saveAttRestStoreBO(AttRestStoreBO bo) throws SysException {
        this.attRestChgDAO.saveOrUpdateBo(bo);
    }

    public void deleteAttRestStoreBO(String storeId) throws SysException {
        this.attRestChgDAO.deleteBo(AttRestStoreBO.class, storeId);
    }

    /**
     * 录入存休
     *
     * @param orgId
     * @param begin
     * @param end
     * @param personId
     * @param itemId
     * @param type
     * @throws SysException
     */
    public void saveAttRestStoreBOByRestAndPid(String orgId, String begin, String end, String personId, String itemId, String type) throws SysException {
        List dateList = DateUtil.getAllBetweenDates(begin, end);
        List feastList = this.attFeastDAO.getAllEqualsAttFeast(orgId);
        AttRestOfWeekBO restOfWeekBo = this.attRestWeekDAO.getAttRestOfWeekBOByOrgid(orgId);
        AttRestStoreBO bo = new AttRestStoreBO();
        bo.setItemId(itemId);
        bo.setRecordType(type);
        bo.setPersonId(personId);
        bo.setStatus(AttRestStoreBO.STATUS_IS_USE);

        String daysDes = "";
        String beginDate = "";
        int count = 0;
        boolean flag = false;//判断是否有公休日和节假日
        if (dateList != null && dateList.size() > 0) {
            for (int m = 0; m < dateList.size(); m++) {
                boolean sflag=false;
                String day = (String) dateList.get(m);
                if (feastList != null && feastList.size() > 0) {//判断是否节假日
                    for (int i = 0; i < feastList.size(); i++) {
                        AttFeastBO fest = (AttFeastBO) feastList.get(i);
                        if (fest.getYear().equals("-1")) {//每年
                            String date[] = fest.getFeastDate().split(",");
                            for (int j = 0; j < date.length; j++) {
                                if (date[j] != null && date[j].equals(day.substring(5, 10))) {
                                    flag = true;
                                    sflag=true;
                                }
                            }
                        } else if (fest.getYear().equals("0")) {//当年
                            if (fest.getFeastDate().equals(day)) {
                                flag = true;
                                sflag=true;
                            }
                        }

                    }
                }
                String days = DateUtil.getDayByDate(day);
                if (restOfWeekBo != null) {

                    if (days.equals("1")) {
                        if (restOfWeekBo.getMon().equals("0")) {
                           flag = true;
                            sflag=true;
                        }
                    }

                    if (days.equals("2")) {
                        if (restOfWeekBo.getTues().equals("0")) {
                           flag = true;
                            sflag=true;
                        }
                    }

                    if (days.equals("3")) {
                        if (restOfWeekBo.getWed().equals("0")) {
                            flag = true;
                            sflag=true;
                        }
                    }

                    if (days.equals("4")) {
                        if (restOfWeekBo.getThur().equals("0")) {
                            flag = true;
                            sflag=true;
                        }
                    }

                    if (days.equals("5")) {
                        if (restOfWeekBo.getFri().equals("0")) {
                            flag = true;
                            sflag=true;
                        }
                    }

                    if (days.equals("6")) {
                        if (restOfWeekBo.getSat().equals("0")) {
                            flag = true;
                            sflag=true;
                        }
                    }

                    if (days.equals("7")) {
                        if (restOfWeekBo.getSun().equals("0")) {
                            flag = true;
                            sflag=true;
                        }
                    }
                }

                if(sflag){
                   count++;
                   if(beginDate.equals("")){
                       beginDate=day;
                   }
                   if(daysDes.equals("")){
                        daysDes+=day;
                   }else{
                        daysDes+=","+day;
                   }
                }
            }

        }

        bo.setDays(String.valueOf(count));
        bo.setUseDays("0");
        bo.setLevDays(String.valueOf(count));
        bo.setDaysDesc(daysDes);
        if(flag){
           this.saveAttRestStoreBO(bo);
        }
    }

    //AttRestChangeBO
    public List getAllAttRestChangeBO(PageVO pagevo, String begin, String end, String orgId, String queryValue) throws SysException {
        return this.attRestChgDAO.getAllAttRestChangeBO(pagevo, begin, end, orgId, queryValue);
    }

    public List getAttRestChangeBOByPid(PageVO pagevo, String personId) throws SysException {
        return this.attRestChgDAO.getAttRestChangeBOByPid(pagevo, personId);
    }

    public List getAttRestChangeBOByStoreId(String storeId) throws SysException {
        return this.attRestChgDAO.getAttRestChangeBOByStoreId(storeId);
    }

    public AttRestChangeBO findAttRestChangeBOById(String chgId) throws SysException {
        return (AttRestChangeBO) this.attRestChgDAO.findBoById(AttRestChangeBO.class, chgId);
    }

    public void saveAttRestChangeBO(AttRestChangeBO bo) throws SysException {
        this.attRestChgDAO.saveOrUpdateBo(bo);
    }

    public void deleteAttRestChangeBO(String chgId) throws SysException {
        this.attRestChgDAO.deleteBo(AttRestChangeBO.class, chgId);
    }

    //get and set
    public AttRestChgDAO getAttRestChgDAO() {
        return attRestChgDAO;
    }

    public void setAttRestChgDAO(AttRestChgDAO attRestChgDAO) {
        this.attRestChgDAO = attRestChgDAO;
    }

    public AttFeastDAO getAttFeastDAO() {
        return attFeastDAO;
    }

    public void setAttFeastDAO(AttFeastDAO attFeastDAO) {
        this.attFeastDAO = attFeastDAO;
    }

    public AttRestWeekDAO getAttRestWeekDAO() {
        return attRestWeekDAO;
    }

    public void setAttRestWeekDAO(AttRestWeekDAO attRestWeekDAO) {
        this.attRestWeekDAO = attRestWeekDAO;
    }

}
