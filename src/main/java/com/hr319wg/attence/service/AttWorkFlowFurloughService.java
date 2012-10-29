/**
 * 请假流程
 */
package com.hr319wg.attence.service;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.dao.CardMessageDAO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailAuditBO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecCollectBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;
import com.hr319wg.util.CommonFuns;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AttWorkFlowFurloughService implements IWFFunction {
    private CardMessageDAO cardMessageDAO;
    private ActivePageAPI activeapi;

    public CardMessageDAO getCardMessageDAO() {
        return cardMessageDAO;
    }

    public void setCardMessageDAO(CardMessageDAO cardMessageDAO) {
        this.cardMessageDAO = cardMessageDAO;
    }

    public ActivePageAPI getActiveapi() {
        return activeapi;
    }

    public void setActiveapi(ActivePageAPI activeapi) {
        this.activeapi = activeapi;
    }

    public AttFurloughRecBO findAttFurloughRecBObyId(String id)
            throws SysException {
        return (AttFurloughRecBO) cardMessageDAO.findBoById(
                AttFurloughRecBO.class, id);
    }

    public AttFurloughRecCollectBO findAttFurloughRecCollectBO(String id)
            throws SysException {
        AttFurloughRecCollectBO attfurloughreccollectbo = null;
        List list = cardMessageDAO.findAttFurloughRecCollectBO(id);
        if (list != null && list.size() > 0) {
            attfurloughreccollectbo = (AttFurloughRecCollectBO) list.get(0);
        }
        return attfurloughreccollectbo;
    }

    public void deleteAttFurloughRecCollectBOList(String id)
            throws SysException {
        String sql = "delete from ATT_FurloughRec_Collect where FurloughNo='" + id + "'";
        activeapi.executeSql(sql);
    }

    public void deleteAttFurloughRecCollectBO(String id)
            throws SysException {
        cardMessageDAO.deleteBo(AttFurloughRecCollectBO.class, id);
    }

    public void saveAttFurloughRecBO(AttFurloughRecBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public void saveAttFurloughRecCollectBO(AttFurloughRecCollectBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public List getAttAnnualDetailAuditBO(String personId, String furloughno) throws SysException {
        return cardMessageDAO.getAttAnnualDetailAuditBO(personId, furloughno);
    }

    public AttAnnualItemBO findAttAnnualItemBObyId(String id)
            throws SysException {
        return (AttAnnualItemBO) cardMessageDAO.findBoById(
                AttAnnualItemBO.class, id);
    }

    public void saveorupdateAttAnnualItemBO(AttAnnualItemBO bo)
            throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public void saveorupdateAttAnnualDetailAuditBO(AttAnnualDetailAuditBO bo)
            throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public void saveorupdateAttAnnualDetailBO(AttAnnualDetailBO bo)
            throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public void deleteAttAnnualDetailBO(String id)
            throws SysException {
        String sql = "delete from ATT_ANNUAL_DETAIL where FurloughNo='" + id + "'";
        activeapi.executeSql(sql);
    }

    public List getAttAnnualDetailBO(String itemID, String furloughNo)
            throws SysException {
        return cardMessageDAO.getAttAnnualDetailBO(itemID, furloughNo);
    }

    public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine)
            throws SysException {
        AttFurloughRecBO attfurloughrecbo = findAttFurloughRecBObyId(wt.getLinkID());
        if (attfurloughrecbo != null) {
            String sql = wfdefine.getSql().replaceAll("\\$K\\$", attfurloughrecbo.getPersonID());
            String con = activeapi.queryForString(sql);
            if (wfdefine.getConValue().indexOf(con) >= 0) {
                return true;
            }
        }
        return false;
    }

    public void whenEnd(WFTransaction wt) throws SysException {
        AttFurloughRecBO attfurloughrecbo = findAttFurloughRecBObyId(wt.getLinkID());
        if (attfurloughrecbo != null) {
            if ("2".equals(attfurloughrecbo.getSuperFlId())) { //续假
                AttFurloughRecCollectBO attfurloughreccollectbo = findAttFurloughRecCollectBO(attfurloughrecbo.getSuperFurloughNo());
                if (attfurloughreccollectbo != null) {
                    attfurloughreccollectbo.setEndTime(attfurloughrecbo.getEndTime());
                    attfurloughreccollectbo.setStatusValue("3");
                    attfurloughreccollectbo.setSuperFlId("0");
                    saveAttFurloughRecCollectBO(attfurloughreccollectbo);
                    attfurloughrecbo.setStatusValue("3");
                    attfurloughrecbo.setSuperFurloughNo(attfurloughreccollectbo.getFurloughNO());
                    saveAttFurloughRecBO(attfurloughrecbo);

                    //年假信息表调整
                    List attannualdetailauditbovalue = getAttAnnualDetailAuditBO(attfurloughreccollectbo.getPersonID(), attfurloughreccollectbo.getFurloughNO());
                    if (attannualdetailauditbovalue != null && attannualdetailauditbovalue.size() > 0) {
                        AttAnnualDetailAuditBO attannualdetailauditbo = (AttAnnualDetailAuditBO) attannualdetailauditbovalue.get(0);
                        attannualdetailauditbo.setStatusValue("3");
                        saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
                        String daySpan1 = attannualdetailauditbo.getDaySpan();//年假申请表
                        float daySpanNumber1 = Float.parseFloat(daySpan1);
                        float daySpanNumber3 = 0;

                        List attannualdetailbovalue = getAttAnnualDetailBO(attannualdetailauditbo.getItemId(), attannualdetailauditbo.getFurloughno());
                        if (attannualdetailbovalue != null && attannualdetailbovalue.size() > 0) {
                            AttAnnualDetailBO attannualdetailbo = (AttAnnualDetailBO) attannualdetailbovalue.get(0);
                            String daySpan2 = attannualdetailbo.getDaySpan();//年假汇总表
                            float daySpanNumber2 = Float.parseFloat(daySpan2);
                            AttAnnualItemBO attannualitembo = findAttAnnualItemBObyId(attannualdetailbo.getItemID());//年假人员列表
                            if (attannualitembo.getCriticalDate() != null && !"".equals(attannualitembo.getCriticalDate())) {
                                String criticalAnnDay = attannualitembo.getCriticalAnnDay(); // 临界后假期天数
                                String criticalUseDay = attannualitembo.getCalcAnnDay(); // 临界后已休天数
                                String criticalAvaDay = attannualitembo.getCriticalAvaDay(); // 临界后可用天数
                                float criticalAnnDayNumber = Float.parseFloat(criticalAnnDay);// 临界后假期天数
                                float criticalUseDayNumber = Float.parseFloat(criticalUseDay);// 临界后已休天数
                                float criticalAvaDayNumber = Float.parseFloat(criticalAvaDay);// 临界后可用天数
                                if (daySpanNumber1 > daySpanNumber2) {
                                    String criticaluses = (criticalUseDayNumber + (daySpanNumber1 - daySpanNumber2)) + "";
                                    String criticalavas = (criticalAvaDayNumber - (daySpanNumber1 - daySpanNumber2)) + "";
                                    attannualitembo.setCalcAnnDay(criticaluses);
                                    attannualitembo.setCriticalAvaDay(criticalavas);
                                    saveorupdateAttAnnualItemBO(attannualitembo);
                                } else if (daySpanNumber1 < daySpanNumber2) {
                                    String criticaluses = (criticalUseDayNumber - (daySpanNumber2 - daySpanNumber1)) + "";
                                    String criticalavas = (criticalAvaDayNumber + (daySpanNumber2 - daySpanNumber1)) + "";
                                    attannualitembo.setCalcAnnDay(criticaluses);
                                    attannualitembo.setCriticalAvaDay(criticalavas);
                                    saveorupdateAttAnnualItemBO(attannualitembo);
                                }

                                attannualdetailbo.setHolidayBegin(attannualdetailauditbo.getHolidayBegin());
                                attannualdetailbo.setHolidayEnd(attannualdetailauditbo.getHolidayEnd());
                                attannualdetailbo.setDaySpan(attannualdetailauditbo.getDaySpan());
                                attannualdetailbo.setFurloughNo(attannualdetailauditbo.getFurloughno());
                                saveorupdateAttAnnualDetailBO(attannualdetailbo);
                            } else {
                                String annDay = attannualitembo.getAnnDay();
                                String useDay = attannualitembo.getUseDay();
                                String avaDay = attannualitembo.getAvaDay();
                                float annDayNumber = Float.parseFloat(annDay);
                                float useDayNumber = Float.parseFloat(useDay);
                                float avaDayNumber = Float.parseFloat(avaDay);
                                if (daySpanNumber1 > daySpanNumber2) {
                                    String uses = (useDayNumber + (daySpanNumber1 - daySpanNumber2)) + "";
                                    String avas = (avaDayNumber - (daySpanNumber1 - daySpanNumber2)) + "";
                                    attannualitembo.setUseDay(uses);
                                    attannualitembo.setAvaDay(avas);
                                    saveorupdateAttAnnualItemBO(attannualitembo);
                                } else if (daySpanNumber1 < daySpanNumber2) {
                                    String uses = (useDayNumber - (daySpanNumber2 - daySpanNumber1)) + "";
                                    String avas = (avaDayNumber + (daySpanNumber2 - daySpanNumber1)) + "";
                                    attannualitembo.setUseDay(uses);
                                    attannualitembo.setAvaDay(avas);
                                    saveorupdateAttAnnualItemBO(attannualitembo);
                                }

                                attannualdetailbo.setHolidayBegin(attannualdetailauditbo.getHolidayBegin());
                                attannualdetailbo.setHolidayEnd(attannualdetailauditbo.getHolidayEnd());
                                attannualdetailbo.setDaySpan(attannualdetailauditbo.getDaySpan());
                                attannualdetailbo.setFurloughNo(attannualdetailauditbo.getFurloughno());
                                saveorupdateAttAnnualDetailBO(attannualdetailbo);
                            }
                        }
                    } else {
                        deleteAttAnnualDetailBO(attfurloughreccollectbo.getFurloughNO());
                    }
                }
            } else if ("3".equals(attfurloughrecbo.getSuperFlId())) { //销假
                AttFurloughRecCollectBO attfurloughreccollectbo = findAttFurloughRecCollectBO(attfurloughrecbo.getSuperFurloughNo());
                if (attfurloughreccollectbo != null) {
                    String old_begin_date = attfurloughreccollectbo.getBeginTime().trim();
                    String old_end_time = attfurloughreccollectbo.getEndTime().trim();
                    String new_begin_date = attfurloughrecbo.getBeginTime().trim();
                    String new_end_time = attfurloughrecbo.getEndTime().trim();
                    String i = compare_date(old_begin_date, new_begin_date);
                    String j = compare_date(old_end_time, new_end_time);
                    if ("-1".equals(i)) {
                        if ("1".endsWith(j)) {
                            AttFurloughRecCollectBO attfurloughreccollectbo1 = new AttFurloughRecCollectBO();
                            attfurloughreccollectbo1.setFurloughNO(attfurloughrecbo.getSuperFurloughNo());
                            attfurloughreccollectbo1.setPersonID(attfurloughrecbo.getPersonID());
                            attfurloughreccollectbo1.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                            attfurloughreccollectbo1.setBeginTime(attfurloughreccollectbo.getBeginTime());
                            attfurloughreccollectbo1.setEndTime(attfurloughrecbo.getBeginTime());
                            attfurloughreccollectbo1.setFlID(attfurloughreccollectbo.getFlID());
                            attfurloughreccollectbo1.setStatusValue("3");
                            attfurloughreccollectbo1.setSuperFlId("0");
                            attfurloughreccollectbo1.setFlIdProcess(attfurloughreccollectbo.getFlIdProcess());
                            if (attfurloughreccollectbo.getFlIdStatus() != null && !"".equals(attfurloughreccollectbo.getFlIdStatus())) {
                                attfurloughreccollectbo1.setFlIdStatus(attfurloughreccollectbo.getFlIdStatus());
                            }
                            saveAttFurloughRecCollectBO(attfurloughreccollectbo1);

                            AttFurloughRecCollectBO attfurloughreccollectbo2 = new AttFurloughRecCollectBO();
                            attfurloughreccollectbo2.setFurloughNO(attfurloughrecbo.getSuperFurloughNo());
                            attfurloughreccollectbo2.setPersonID(attfurloughrecbo.getPersonID());
                            attfurloughreccollectbo2.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                            attfurloughreccollectbo2.setBeginTime(attfurloughrecbo.getEndTime());
                            attfurloughreccollectbo2.setEndTime(attfurloughreccollectbo.getEndTime());
                            attfurloughreccollectbo2.setFlID(attfurloughreccollectbo.getFlID());
                            attfurloughreccollectbo2.setStatusValue("3");
                            attfurloughreccollectbo2.setSuperFlId("0");
                            attfurloughreccollectbo2.setFlIdProcess(attfurloughreccollectbo.getFlIdProcess());
                            if (attfurloughreccollectbo.getFlIdStatus() != null && !"".equals(attfurloughreccollectbo.getFlIdStatus())) {
                                attfurloughreccollectbo2.setFlIdStatus(attfurloughreccollectbo.getFlIdStatus());
                            }
                            saveAttFurloughRecCollectBO(attfurloughreccollectbo2);

                            deleteAttFurloughRecCollectBO(attfurloughreccollectbo.getFurloughCollectNO());

                            attfurloughrecbo.setStatusValue("3");
                            attfurloughrecbo.setSuperFurloughNo(attfurloughrecbo.getSuperFurloughNo());
                            saveAttFurloughRecBO(attfurloughrecbo);
                        } else if ("0".equals(j)) {
                            attfurloughreccollectbo.setEndTime(attfurloughrecbo.getBeginTime());
                            attfurloughreccollectbo.setStatusValue("3");
                            attfurloughreccollectbo.setSuperFlId("0");
                            saveAttFurloughRecCollectBO(attfurloughreccollectbo);
                            attfurloughrecbo.setStatusValue("3");
                            attfurloughrecbo.setSuperFurloughNo(attfurloughrecbo.getSuperFurloughNo());
                            saveAttFurloughRecBO(attfurloughrecbo);
                        }
                    } else if ("0".equals(i)) {
                        if ("1".endsWith(j)) {
                            attfurloughreccollectbo.setBeginTime(attfurloughrecbo.getEndTime());
                            attfurloughreccollectbo.setStatusValue("3");
                            attfurloughreccollectbo.setSuperFlId("0");
                            saveAttFurloughRecCollectBO(attfurloughreccollectbo);
                            attfurloughrecbo.setStatusValue("3");
                            attfurloughrecbo.setSuperFurloughNo(attfurloughrecbo.getSuperFurloughNo());
                            saveAttFurloughRecBO(attfurloughrecbo);
                        } else if ("0".equals(j)) {
                            deleteAttFurloughRecCollectBO(attfurloughreccollectbo.getFurloughCollectNO());
                            attfurloughrecbo.setStatusValue("3");
                            attfurloughrecbo.setSuperFurloughNo(attfurloughrecbo.getSuperFurloughNo());
                            saveAttFurloughRecBO(attfurloughrecbo);
                        }
                    }

                    //年假信息表调整
                    List attannualdetailauditbovalue = getAttAnnualDetailAuditBO(attfurloughreccollectbo.getPersonID(), attfurloughreccollectbo.getFurloughNO());
                    if (attannualdetailauditbovalue != null && attannualdetailauditbovalue.size() > 0) {
                        AttAnnualDetailAuditBO attannualdetailauditbo = (AttAnnualDetailAuditBO) attannualdetailauditbovalue.get(0);
                        attannualdetailauditbo.setStatusValue("3");
                        saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
                        String daySpan1 = attannualdetailauditbo.getDaySpan();//年假申请表
                        float daySpanNumber1 = Float.parseFloat(daySpan1);
                        float daySpanNumber3 = 0;

                        List attannualdetailbovalue = getAttAnnualDetailBO(attannualdetailauditbo.getItemId(), attannualdetailauditbo.getFurloughno());
                        if (attannualdetailbovalue != null && attannualdetailbovalue.size() > 0) {
                            AttAnnualDetailBO attannualdetailbo = (AttAnnualDetailBO) attannualdetailbovalue.get(0);
                            String daySpan2 = attannualdetailbo.getDaySpan();//年假汇总表
                            float daySpanNumber2 = Float.parseFloat(daySpan2);
                            AttAnnualItemBO attannualitembo = findAttAnnualItemBObyId(attannualdetailbo.getItemID());//年假人员列表
                            if (attannualitembo.getCriticalDate() != null && !"".equals(attannualitembo.getCriticalDate())) {
                                String criticalAnnDay = attannualitembo.getCriticalAnnDay(); // 临界后假期天数
                                String criticalUseDay = attannualitembo.getCalcAnnDay(); // 临界后已休天数
                                String criticalAvaDay = attannualitembo.getCriticalAvaDay(); // 临界后可用天数
                                float criticalAnnDayNumber = Float.parseFloat(criticalAnnDay);// 临界后假期天数
                                float criticalUseDayNumber = Float.parseFloat(criticalUseDay);// 临界后已休天数
                                float criticalAvaDayNumber = Float.parseFloat(criticalAvaDay);// 临界后可用天数
                                if (daySpanNumber1 > daySpanNumber2) {
                                    String criticaluses = (criticalUseDayNumber + (daySpanNumber1 - daySpanNumber2)) + "";
                                    String criticalavas = (criticalAvaDayNumber - (daySpanNumber1 - daySpanNumber2)) + "";
                                    attannualitembo.setCalcAnnDay(criticaluses);
                                    attannualitembo.setCriticalAvaDay(criticalavas);
                                    saveorupdateAttAnnualItemBO(attannualitembo);
                                } else if (daySpanNumber1 < daySpanNumber2) {
                                    String criticaluses = (criticalUseDayNumber - (daySpanNumber2 - daySpanNumber1)) + "";
                                    String criticalavas = (criticalAvaDayNumber + (daySpanNumber2 - daySpanNumber1)) + "";
                                    attannualitembo.setCalcAnnDay(criticaluses);
                                    attannualitembo.setCriticalAvaDay(criticalavas);
                                    saveorupdateAttAnnualItemBO(attannualitembo);
                                }

                                attannualdetailbo.setHolidayBegin(attannualdetailauditbo.getHolidayBegin());
                                attannualdetailbo.setHolidayEnd(attannualdetailauditbo.getHolidayEnd());
                                attannualdetailbo.setDaySpan(attannualdetailauditbo.getDaySpan());
                                attannualdetailbo.setFurloughNo(attannualdetailauditbo.getFurloughno());
                                saveorupdateAttAnnualDetailBO(attannualdetailbo);
                            } else {
                                String annDay = attannualitembo.getAnnDay();
                                String useDay = attannualitembo.getUseDay();
                                String avaDay = attannualitembo.getAvaDay();
                                float annDayNumber = Float.parseFloat(annDay);
                                float useDayNumber = Float.parseFloat(useDay);
                                float avaDayNumber = Float.parseFloat(avaDay);
                                if (daySpanNumber1 > daySpanNumber2) {
                                    String uses = (useDayNumber + (daySpanNumber1 - daySpanNumber2)) + "";
                                    String avas = (avaDayNumber - (daySpanNumber1 - daySpanNumber2)) + "";
                                    attannualitembo.setUseDay(uses);
                                    attannualitembo.setAvaDay(avas);
                                    saveorupdateAttAnnualItemBO(attannualitembo);
                                } else if (daySpanNumber1 < daySpanNumber2) {
                                    String uses = (useDayNumber - (daySpanNumber2 - daySpanNumber1)) + "";
                                    String avas = (avaDayNumber + (daySpanNumber2 - daySpanNumber1)) + "";
                                    attannualitembo.setUseDay(uses);
                                    attannualitembo.setAvaDay(avas);
                                    saveorupdateAttAnnualItemBO(attannualitembo);
                                }

                                attannualdetailbo.setHolidayBegin(attannualdetailauditbo.getHolidayBegin());
                                attannualdetailbo.setHolidayEnd(attannualdetailauditbo.getHolidayEnd());
                                attannualdetailbo.setDaySpan(attannualdetailauditbo.getDaySpan());
                                attannualdetailbo.setFurloughNo(attannualdetailauditbo.getFurloughno());
                                saveorupdateAttAnnualDetailBO(attannualdetailbo);
                            }
                        }
                    } else {
                        deleteAttAnnualDetailBO(attfurloughreccollectbo.getFurloughNO());
                    }
                }
            } else {
                AttFurloughRecCollectBO attfurloughreccollectbo = new AttFurloughRecCollectBO();
                attfurloughreccollectbo.setFurloughNO(attfurloughrecbo.getFurloughNO());
                attfurloughreccollectbo.setPersonID(attfurloughrecbo.getPersonID());
                attfurloughreccollectbo.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                attfurloughreccollectbo.setBeginTime(attfurloughrecbo.getBeginTime());
                attfurloughreccollectbo.setEndTime(attfurloughrecbo.getEndTime());
                attfurloughreccollectbo.setFlID(attfurloughrecbo.getFlIdProcess());
                attfurloughreccollectbo.setStatusValue("3");
                attfurloughreccollectbo.setSuperFlId("0");
                attfurloughreccollectbo.setFlIdProcess(attfurloughrecbo.getFlID());
                if (attfurloughrecbo.getFlIdStatus() != null && !"".equals(attfurloughrecbo.getFlIdStatus())) {
                    attfurloughreccollectbo.setFlIdStatus(attfurloughrecbo.getFlIdStatus());
                } else {
                    attfurloughreccollectbo.setFlIdStatus("");
                }
                //设置请假状态
                saveAttFurloughRecCollectBO(attfurloughreccollectbo);
                attfurloughrecbo.setStatusValue("3");
                attfurloughrecbo.setSuperFurloughNo(attfurloughrecbo.getFurloughNO());
                saveAttFurloughRecBO(attfurloughrecbo);
                //设置年假状态
                List attannualdetailauditbovalue = getAttAnnualDetailAuditBO(attfurloughrecbo.getPersonID(), attfurloughrecbo.getFurloughNO());
                if (attannualdetailauditbovalue != null && attannualdetailauditbovalue.size() > 0) {
                    AttAnnualDetailAuditBO attannualdetailauditbo = (AttAnnualDetailAuditBO) attannualdetailauditbovalue.get(0);
                    attannualdetailauditbo.setStatusValue("3");
                    saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);

                    AttAnnualDetailBO attannualdetailbo = new AttAnnualDetailBO();
                    attannualdetailbo.setItemID(attannualdetailauditbo.getItemId());
                    attannualdetailbo.setHolidayBegin(attannualdetailauditbo.getHolidayBegin());
                    attannualdetailbo.setHolidayEnd(attannualdetailauditbo.getHolidayEnd());
                    attannualdetailbo.setDaySpan(attannualdetailauditbo.getDaySpan());
                    attannualdetailbo.setFurloughNo(attfurloughrecbo.getFurloughNO());
                    saveorupdateAttAnnualDetailBO(attannualdetailbo);

                    AttAnnualItemBO attannualitembo = findAttAnnualItemBObyId(attannualdetailauditbo.getItemId());
                    if (attannualitembo.getCriticalDate() != null && !"".equals(attannualitembo.getCriticalDate())) {
                        String annDay = attannualitembo.getAnnDay();// 临界前假期天数
                        String useDay = attannualitembo.getUseDay();// 临界前已休天数
                        String avaDay = attannualitembo.getAvaDay();// 临界前可用天数
                        String criticalAnnDay = attannualitembo.getCriticalAnnDay(); // 临界后假期天数
                        String criticalUseDay = attannualitembo.getCalcAnnDay(); // 临界后已休天数
                        String criticalAvaDay = attannualitembo.getCriticalAvaDay(); // 临界后可用天数
                        String daySpan = attannualdetailauditbo.getDaySpan();
                        float annDayNumber = Float.parseFloat(annDay);// 临界前假期天数
                        float useDayNumber = Float.parseFloat(useDay);// 临界前已休天数
                        float avaDayNumber = Float.parseFloat(avaDay);// 临界前可用天数
                        float criticalAnnDayNumber = Float.parseFloat(criticalAnnDay);// 临界后假期天数
                        float criticalUseDayNumber = Float.parseFloat(criticalUseDay);// 临界后已休天数
                        float criticalAvaDayNumber = Float.parseFloat(criticalAvaDay);// 临界后可用天数
                        float daySpanNumber = Float.parseFloat(daySpan);
                        float sum = avaDayNumber + criticalAvaDayNumber;
                        String uses = "0";
                        String avas = "0";
                        String criticaluses = "0";
                        String criticalavas = "0";
                        if (daySpanNumber <= avaDayNumber) {
                            uses = (useDayNumber + daySpanNumber) + "";
                            avas = (avaDayNumber - daySpanNumber) + "";
                        } else if (avaDayNumber < daySpanNumber && daySpanNumber <= criticalAvaDayNumber) {
                            uses = "0";
                            avas = "0";
                            criticaluses = (criticalUseDayNumber + (daySpanNumber - avaDayNumber)) + "";
                            criticalavas = (criticalAvaDayNumber - (daySpanNumber - avaDayNumber)) + "";
                        } else if (criticalAvaDayNumber < daySpanNumber && daySpanNumber <= sum) {
                            uses = "0";
                            avas = "0";
                            criticaluses = (criticalUseDayNumber + (daySpanNumber - avaDayNumber)) + "";
                            criticalavas = (criticalAvaDayNumber - (daySpanNumber - avaDayNumber)) + "";
                        }
                        attannualitembo.setUseDay(uses);
                        attannualitembo.setAvaDay(avas);
                        attannualitembo.setCalcAnnDay(criticaluses);
                        attannualitembo.setCriticalAvaDay(criticalavas);
                        saveorupdateAttAnnualItemBO(attannualitembo);
                    } else {
                        String annDay = attannualitembo.getAnnDay();
                        String useDay = attannualitembo.getUseDay();
                        String avaDay = attannualitembo.getAvaDay();
                        String daySpan = attannualdetailauditbo.getDaySpan();
                        float annDayNumber = Float.parseFloat(annDay);
                        float useDayNumber = Float.parseFloat(useDay);
                        float avaDayNumber = Float.parseFloat(avaDay);
                        float daySpanNumber = Float.parseFloat(daySpan);
                        String uses = (useDayNumber + daySpanNumber) + "";
                        String avas = (avaDayNumber - daySpanNumber) + "";
                        attannualitembo.setUseDay(uses);
                        attannualitembo.setAvaDay(avas);
                        saveorupdateAttAnnualItemBO(attannualitembo);
                    }
                }
            }
        }
    }

    public void whenStart(WFTransaction arg0) throws SysException {
    }

    public void whenCreateNextNode(WFTransaction wt, WFNodeBO node) throws SysException {
        //  创建新节点
    }

    /*
      * 日期区间计算
      */
    public List cacl(String beginTime1, String endTime1) {
        String beginyear = beginTime1.substring(0, 4);
        String beginmonth = beginTime1.substring(5, 7);
        String beginday = beginTime1.substring(8, 10);
        String beginday1 = beginTime1.substring(8, 9);
        String beginday2 = beginTime1.substring(9, 10);
        String endTimeyear = endTime1.substring(0, 4);
        String endTimemonth = endTime1.substring(5, 7);
        String endTimeday = endTime1.substring(8, 10);
        String endTimeday1 = endTime1.substring(8, 9);
        String endTimeday2 = endTime1.substring(9, 10);
        List lists = new ArrayList();
        if (!beginmonth.equals(endTimemonth)) {
            int m = 0;
            int n = 0;
            if (!"0".equals(beginday1)) {
                m = Integer.parseInt(beginday);
            } else {
                m = Integer.parseInt(beginday2);
            }
            if (!"0".equals(endTimeday1)) {
                n = Integer.parseInt(endTimeday);
            } else {
                n = Integer.parseInt(endTimeday2);
            }
            Integer.parseInt(endTimeday2);
            int mn = MonthDays(Integer.parseInt(beginmonth), Integer
                    .parseInt(beginmonth));
            for (int i = m; i <= mn; i++) {
                String datevalue = new String();
                if (i >= 10) {
                    datevalue = beginyear + "-" + beginmonth + "-" + i;
                } else {
                    datevalue = beginyear + "-" + beginmonth + "-0" + i;
                }
                lists.add(datevalue);
            }
            List lists1 = new ArrayList();
            for (int i = 1; i <= n; i++) {
                String datevalue = new String();
                if (i >= 10) {
                    datevalue = endTimeyear + "-" + endTimemonth + "-" + i;
                } else {
                    datevalue = endTimeyear + "-" + endTimemonth + "-0" + i;
                }
                lists1.add(datevalue);
            }
            lists.addAll(lists1);
        } else {
            int m = 0;
            int n = 0;
            if (!"0".equals(beginday1)) {
                m = Integer.parseInt(beginday);
            } else {
                m = Integer.parseInt(beginday2);
            }
            if (!"0".equals(endTimeday1)) {
                n = Integer.parseInt(endTimeday);
            } else {
                n = Integer.parseInt(endTimeday2);
            }
            for (int i = m; i <= n; i++) {
                String datevalue = new String();
                if (i >= 10) {
                    datevalue = beginyear + "-" + beginmonth + "-" + i;
                } else {
                    datevalue = beginyear + "-" + beginmonth + "-0" + i;
                }
                lists.add(datevalue);
            }
        }
        return lists;
    }

    public static boolean LeapYear(int year) {
        if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
            return true;
        } else {
            return false;
        }
    }

    public static int MonthDays(int Month, int year) {
        switch (Month) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                return 31;
            case 2:
                if (LeapYear(year)) {
                    return 29;
                } else {
                    return 28;
                }
            default:
                return 30;

        }
    }

    /*
          * java日期比较大小
          */
    public static String compare_date(String DATE1, String DATE2) {
        String argments = "0";
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        try {
            Date dt1 = df.parse(DATE1);
            Date dt2 = df.parse(DATE2);
            if (dt1.getTime() > dt2.getTime()) {
                argments = "1";
                return argments;
            } else if (dt1.getTime() < dt2.getTime()) {
                argments = "-1";
                return argments;
            } else {
                return argments;
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return argments;
    }
}
