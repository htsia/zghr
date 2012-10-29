/**
 * 公出流程
 */
package com.hr319wg.attence.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.hr319wg.attence.dao.CardMessageDAO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkCollectBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;
import com.hr319wg.util.CommonFuns;

public class AttWorkFlowOutWorkService implements IWFFunction {
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

    public AttOutWorkBO findAttOutWorkBObyId(String id)
            throws SysException {
        return (AttOutWorkBO) cardMessageDAO.findBoById(
                AttOutWorkBO.class, id);
    }

    public AttOutWorkCollectBO findAttOutWorkCollectBO(String id, String personID)
            throws SysException {
        AttOutWorkCollectBO attevcctionreccollectbo = null;
        List list = cardMessageDAO.findAttOutWorkCollectBO(id, personID);
        if (list != null && list.size() > 0) {
            attevcctionreccollectbo = (AttOutWorkCollectBO) list.get(0);
        }
        return attevcctionreccollectbo;
    }

    public void saveAttOutWorkCollectBO(AttOutWorkCollectBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public void saveAttOutWorkBO(AttOutWorkBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public void deleteAttOutWorkCollectBO(String id)
            throws SysException {
        cardMessageDAO.deleteBo(AttOutWorkCollectBO.class, id);
    }

    public List findAttTimeOffRecBO(String overTimeNO) throws SysException {
        return cardMessageDAO.findAttTimeOffRecBO(overTimeNO);
    }

    public void UpdateAttTimeOffRecBO(String overTimeNO) throws SysException {
        String updateSQL = "update ATT_TIME_OFF_REC set STATUS_VALUE='3' where OVER_TIME_NO='" + overTimeNO + "'";
        activeapi.executeSql(updateSQL);
    }

    public void deleteAttTimeOffRecBO(String personId, String overTimeNO) throws SysException {
        String sql = "delete from ATT_TIME_OFF_REC where PERSON_ID='" + personId + "' and OVER_TIME_NO='" + overTimeNO + "' and STATUS_VALUE='3'";
        activeapi.executeSql(sql);
    }

    public List findAttTimeOffRecBO(String personId, String overTimeNO) throws SysException {
        return cardMessageDAO.findAttTimeOffRecBO(personId, overTimeNO);
    }

    public void UpdateAttTimeOffRecBO1(String personId, String overTimeNO) throws SysException {
        String updateSQL = "update ATT_TIME_OFF_REC set STATUS_VALUE='3' where PERSON_ID='" + personId + "' and OVER_TIME_NO='" + overTimeNO + "'";
        activeapi.executeSql(updateSQL);
    }

    public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine)
            throws SysException {
        if (wt.getLinkID() != null && !"".equals(wt.getLinkID())) {
            AttOutWorkBO attevcctionrecbo = findAttOutWorkBObyId(wt.getLinkID());
            if (attevcctionrecbo != null) {
                String sql = wfdefine.getSql().replaceAll("\\$K\\$", attevcctionrecbo.getPersonID());
                String con = activeapi.queryForString(sql);
                if (wfdefine.getConValue().indexOf(con) >= 0) {
                    return true;
                }
            }
        } else {
            String sql = wfdefine.getSql().replaceAll("\\$K\\$", wt.getUser().getUserId());
            String con = activeapi.queryForString(sql);
            if (wfdefine.getConValue().indexOf(con) >= 0) {
                return true;
            }
        }
        return false;
    }

    public void whenEnd(WFTransaction wt) throws SysException {
        AttOutWorkBO attevcctionrecbo = findAttOutWorkBObyId(wt.getLinkID());
//		attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getEvcctionNO());
//		saveAttEvcctionRecBO(attevcctionrecbo);
        if (attevcctionrecbo != null) {
            if ("2".equals(attevcctionrecbo.getSuperFlId())) { //续增
                AttOutWorkCollectBO attevcctionreccollectbo = findAttOutWorkCollectBO(attevcctionrecbo.getSuperFurloughNo(), attevcctionrecbo.getPersonID());
                if (attevcctionreccollectbo != null) {
                    attevcctionreccollectbo.setEndTime(attevcctionrecbo.getEndTime());
                    attevcctionreccollectbo.setStatusValue("3");
                    attevcctionreccollectbo.setSuperFlId("0");
                    saveAttOutWorkCollectBO(attevcctionreccollectbo);
                    attevcctionrecbo.setStatusValue("3");
                    attevcctionrecbo.setSuperFurloughNo(attevcctionreccollectbo.getOutWorkNo());
                    saveAttOutWorkBO(attevcctionrecbo);

                    //设置倒休状态
                    List atttimeoffrecbovalue = findAttTimeOffRecBO(attevcctionreccollectbo.getPersonID(), attevcctionreccollectbo.getOutWorkNo());
                    if (atttimeoffrecbovalue != null && atttimeoffrecbovalue.size() > 0) {
                        deleteAttTimeOffRecBO(attevcctionreccollectbo.getPersonID(), attevcctionreccollectbo.getOutWorkNo());
                        UpdateAttTimeOffRecBO1(attevcctionreccollectbo.getPersonID(), attevcctionreccollectbo.getOutWorkNo());
                    } else {
                        deleteAttTimeOffRecBO(attevcctionreccollectbo.getPersonID(), attevcctionreccollectbo.getOutWorkNo());
                    }
                }
            } else if ("3".equals(attevcctionrecbo.getSuperFlId())) { //销减
                AttOutWorkCollectBO attevcctionreccollectbo = findAttOutWorkCollectBO(attevcctionrecbo.getSuperFurloughNo(), attevcctionrecbo.getPersonID());
                if (attevcctionreccollectbo != null) {
                    String old_begin_date = attevcctionreccollectbo.getBeginTime().trim();
                    String old_end_time = attevcctionreccollectbo.getEndTime().trim();
                    String new_begin_date = attevcctionrecbo.getBeginTime().trim();
                    String new_end_time = attevcctionrecbo.getEndTime().trim();
                    String i = compare_date(old_begin_date, new_begin_date);
                    String j = compare_date(old_end_time, new_end_time);
                    if ("-1".equals(i)) {
                        if ("1".endsWith(j)) {
                            AttOutWorkCollectBO attevcctionreccollectbo1 = new AttOutWorkCollectBO();
                            attevcctionreccollectbo1.setOutWorkNo(attevcctionrecbo.getSuperFurloughNo());
                            attevcctionreccollectbo1.setPersonID(attevcctionrecbo.getPersonID());
                            attevcctionreccollectbo1.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                            attevcctionreccollectbo1.setBeginTime(attevcctionreccollectbo.getBeginTime());
                            attevcctionreccollectbo1.setEndTime(attevcctionrecbo.getBeginTime());
                            attevcctionreccollectbo1.setStatusValue("3");
                            attevcctionreccollectbo1.setSuperFlId("0");
                            saveAttOutWorkCollectBO(attevcctionreccollectbo1);

                            AttOutWorkCollectBO attevcctionreccollectbo2 = new AttOutWorkCollectBO();
                            attevcctionreccollectbo2.setOutWorkNo(attevcctionrecbo.getSuperFurloughNo());
                            attevcctionreccollectbo2.setPersonID(attevcctionrecbo.getPersonID());
                            attevcctionreccollectbo2.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                            attevcctionreccollectbo2.setBeginTime(attevcctionrecbo.getEndTime());
                            attevcctionreccollectbo2.setEndTime(attevcctionreccollectbo.getEndTime());
                            attevcctionreccollectbo2.setStatusValue("3");
                            attevcctionreccollectbo2.setSuperFlId("0");
                            saveAttOutWorkCollectBO(attevcctionreccollectbo2);

                            deleteAttOutWorkCollectBO(attevcctionreccollectbo.getOutWorkCollectNo());

                            attevcctionrecbo.setStatusValue("3");
                            attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getSuperFurloughNo());
                            saveAttOutWorkBO(attevcctionrecbo);
                        } else if ("0".equals(j)) {
                            attevcctionreccollectbo.setEndTime(attevcctionrecbo.getBeginTime());
                            attevcctionreccollectbo.setStatusValue("3");
                            attevcctionreccollectbo.setSuperFlId("0");
                            saveAttOutWorkCollectBO(attevcctionreccollectbo);
                            attevcctionrecbo.setStatusValue("3");
                            attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getSuperFurloughNo());
                            saveAttOutWorkBO(attevcctionrecbo);
                        }
                    } else if ("0".equals(i)) {
                        if ("1".endsWith(j)) {
                            attevcctionreccollectbo.setBeginTime(attevcctionrecbo.getEndTime());
                            attevcctionreccollectbo.setStatusValue("3");
                            attevcctionreccollectbo.setSuperFlId("0");
                            saveAttOutWorkCollectBO(attevcctionreccollectbo);
                            attevcctionrecbo.setStatusValue("3");
                            attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getSuperFurloughNo());
                            saveAttOutWorkBO(attevcctionrecbo);
                        } else if ("0".equals(j)) {
                            deleteAttOutWorkCollectBO(attevcctionreccollectbo.getOutWorkCollectNo());
                            attevcctionrecbo.setStatusValue("3");
                            attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getSuperFurloughNo());
                            saveAttOutWorkBO(attevcctionrecbo);
                        }
                    }

                    //设置倒休状态
                    List atttimeoffrecbovalue = findAttTimeOffRecBO(attevcctionrecbo.getPersonID(), attevcctionrecbo.getSuperFurloughNo());
                    if (atttimeoffrecbovalue != null && atttimeoffrecbovalue.size() > 0) {
                        deleteAttTimeOffRecBO(attevcctionrecbo.getPersonID(), attevcctionrecbo.getSuperFurloughNo());
                        UpdateAttTimeOffRecBO1(attevcctionrecbo.getPersonID(), attevcctionrecbo.getSuperFurloughNo());
                    } else {
                        deleteAttTimeOffRecBO(attevcctionrecbo.getPersonID(), attevcctionrecbo.getSuperFurloughNo());
                    }
                }
            } else {
                if ("1".equals(attevcctionrecbo.getOutWorkType().trim())) {
                    AttOutWorkCollectBO attevcctionreccollectbo = new AttOutWorkCollectBO();
                    attevcctionreccollectbo.setOutWorkNo(attevcctionrecbo.getOutWorkNo());
                    attevcctionreccollectbo.setPersonID(attevcctionrecbo.getPersonID());
                    attevcctionreccollectbo.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                    attevcctionreccollectbo.setBeginTime(attevcctionrecbo.getBeginTime());
                    attevcctionreccollectbo.setEndTime(attevcctionrecbo.getEndTime());
                    attevcctionreccollectbo.setStatusValue("3");
                    attevcctionreccollectbo.setSuperFlId("0");
                    saveAttOutWorkCollectBO(attevcctionreccollectbo);
                } else if ("2".equals(attevcctionrecbo.getOutWorkType().trim())) {
                    String[] persongroupids = attevcctionrecbo.getPersonGroupID().split(",");
                    for (int x = 0; x < persongroupids.length; x++) {
                        String ids = persongroupids[x];
                        AttOutWorkCollectBO attevcctionreccollectbo = new AttOutWorkCollectBO();
                        attevcctionreccollectbo.setOutWorkNo(attevcctionrecbo.getOutWorkNo());
                        attevcctionreccollectbo.setPersonID(ids);
                        attevcctionreccollectbo.setCaclDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                        attevcctionreccollectbo.setBeginTime(attevcctionrecbo.getBeginTime());
                        attevcctionreccollectbo.setEndTime(attevcctionrecbo.getEndTime());
                        attevcctionreccollectbo.setStatusValue("3");
                        attevcctionreccollectbo.setSuperFlId("0");
                        saveAttOutWorkCollectBO(attevcctionreccollectbo);
                    }
                }

                //设置公出状态
                attevcctionrecbo.setStatusValue("3");
                attevcctionrecbo.setSuperFurloughNo(attevcctionrecbo.getOutWorkNo());
                saveAttOutWorkBO(attevcctionrecbo);
                //设置倒休状态
                List atttimeoffrecbovalue = findAttTimeOffRecBO(attevcctionrecbo.getOutWorkNo());
                if (atttimeoffrecbovalue != null && atttimeoffrecbovalue.size() > 0) {
                    UpdateAttTimeOffRecBO(attevcctionrecbo.getOutWorkNo());
                }
            }
        }
    }

    public void whenStart(WFTransaction wt) throws SysException {
    }

    public void whenCreateNextNode(WFTransaction wt, WFNodeBO node) throws SysException {
        //  创建新节点
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
