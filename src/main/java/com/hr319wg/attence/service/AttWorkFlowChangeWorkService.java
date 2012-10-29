/**
 * 换班流程
 */
package com.hr319wg.attence.service;

import com.hr319wg.attence.dao.CardMessageDAO;
import com.hr319wg.attence.pojo.bo.AttChangeWorkBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;

public class AttWorkFlowChangeWorkService implements IWFFunction {
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

    public AttChangeWorkBO findAttChangeWorkBObyId(String id)
            throws SysException {
        return (AttChangeWorkBO) cardMessageDAO.findBoById(
                AttChangeWorkBO.class, id);
    }

    public void saveorupdateAttChangeWorkBO(AttChangeWorkBO bo)
            throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine)
            throws SysException {
        AttChangeWorkBO attchangeworkbo = findAttChangeWorkBObyId(wt.getLinkID());
        if (attchangeworkbo != null) {
            String sql = wfdefine.getSql().replaceAll("\\$K\\$", attchangeworkbo.getPersonID());
            String con = activeapi.queryForString(sql);
            if (wfdefine.getConValue().indexOf(con) >= 0) {
                return true;
            }
        }
        return false;
    }

    public void whenEnd(WFTransaction wt) throws SysException {
        AttChangeWorkBO attchangeworkbo = findAttChangeWorkBObyId(wt.getLinkID());
        if (attchangeworkbo != null) {
            attchangeworkbo.setStatusValue("3");
            saveorupdateAttChangeWorkBO(attchangeworkbo);
        }
    }

    public void whenStart(WFTransaction wt) throws SysException {
    }

    public void whenCreateNextNode(WFTransaction wt, WFNodeBO node) throws SysException {
        //  创建新节点
    }

}
