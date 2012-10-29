package com.hr319wg.attence.service;

import com.hr319wg.attence.dao.CardMessageDAO;
import com.hr319wg.attence.pojo.bo.AttMimicReportRecBO;
import com.hr319wg.attence.pojo.bo.AttWorkCalendarBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;

public class AttWorkFlowMrNetWorkHolidayService implements IWFFunction {
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

    public void saveAttMimicReportRecBO(AttMimicReportRecBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public AttMimicReportRecBO findAttMimicReportRecBObyId(String id) throws SysException {
        return (AttMimicReportRecBO) cardMessageDAO.findBoById(AttMimicReportRecBO.class, id);
    }

    public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine)
            throws SysException {
        AttMimicReportRecBO attmimicreportrecbo = findAttMimicReportRecBObyId(wt.getLinkID());
        if (attmimicreportrecbo != null) {
            String sql = wfdefine.getSql().replaceAll("\\$K\\$", attmimicreportrecbo.getPersonID());
            String con = activeapi.queryForString(sql);
            if (wfdefine.getConValue().indexOf(con) >= 0) {
                return true;
            }
        }
        return false;
    }

    public void whenEnd(WFTransaction wt) throws SysException {
        AttMimicReportRecBO attmimicreportrecbo = findAttMimicReportRecBObyId(wt.getLinkID());
        if (attmimicreportrecbo != null) {
            attmimicreportrecbo.setStatusValue("3");
            saveAttMimicReportRecBO(attmimicreportrecbo);
        }
    }

    public void whenStart(WFTransaction wt) throws SysException {
    }

    public void whenCreateNextNode(WFTransaction wt, WFNodeBO node) throws SysException {
        //  创建新节点
        AttMimicReportRecBO bo=this.findAttMimicReportRecBObyId(wt.getLinkID());
        if(bo!=null){
            if("0542".equals(node.getOperID())){
               bo.setDeptAuditResult("0");
            }
            if("0543".equals(node.getOperID())){
               bo.setLeaderAuditResult("0");
            }
            if("0545".equals(node.getOperID())){
               bo.setHrAuditResult("0");
            }
            if("0546".equals(node.getOperID())){
               bo.setHrLeaderAuditResult("0");
            }
            if("0547".equals(node.getOperID())){
               bo.setManAuditResult("0");
            }
        }
    }

}
