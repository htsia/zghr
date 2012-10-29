package com.hr319wg.attence.ucc.impl;

import com.hr319wg.attence.pojo.bo.*;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.service.AttAnnualService;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.WorkFlowService;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-12-2
 * Time: ÉÏÎç11:15
 * To change this template use File | Settings | File Templates.
 */
public class AttAnnualUCC implements IAttAnnualUCC {
    private AttAnnualService attAnnualService;
    private WorkFlowService wfservice;

    public List getAllAttAnnualRecordBO(PageVO pagevo, String orgid)throws SysException{
        return this.attAnnualService.getAllAttAnnualRecordBO(pagevo,orgid);
    }

    public AttAnnualRecordBO findEquealsAttAnnualRecordBO(String orgId, String year) throws SysException {
        return this.attAnnualService.findEquealsAttAnnualRecordBO(orgId, year);
    }

    public AttAnnualRecordBO findExcuteAttAnnualRecordBO(String orgId)throws SysException{
        return this.attAnnualService.findExcuteAttAnnualRecordBO(orgId);
    }

    public AttAnnualRecordBO findAttAnnualRecordBOById(String recID)throws SysException{
        return this.attAnnualService.findAttAnnualRecordBOById(recID);
    }

    public void saveAttAnnualRecordBO(AttAnnualRecordBO bo)throws SysException{
        this.attAnnualService.saveAttAnnualRecordBO(bo);
    }

    public void deleteAttAnnualRecordBO(String id) throws SysException{
        this.attAnnualService.deleteAttAnnualRecordBO(id);
    }


    public void saveAttAnnualDetailBO(AttAnnualDetailBO bo) throws SysException {
        this.attAnnualService.saveAttAnnualDetailBO(bo);
    }
    public void deleteAttAnnualDetailBOByRecID(String recId) throws SysException{
        this.attAnnualService.deleteAttAnnualDetailBOByRecID(recId);
    }

    public AttAnnualDetailBO findAttAnnualDetailBObyId(String id) throws SysException{
        return this.attAnnualService.findAttAnnualDetailBObyId(id);
    }


    public List getAllAttAnnualDetailBOByItemId(String itemID) throws SysException{
        return this.attAnnualService.getAllAttAnnualDetailBOByItemId(itemID);
    }

     public void deleteAttAnnualDetailBO(String id) throws SysException{
         this.attAnnualService.deleteAttAnnualDetailBO(id);
     }



    public List getAllAttAnnualItemBO(PageVO pagevo, String recID, String personValue) throws SysException {
        return this.attAnnualService.getAllAttAnnualItemBO(pagevo, recID, personValue);
    }

    public List getAttAnnualItemBOByPid(PageVO pagevo, String personId)throws SysException{
        return this.attAnnualService.getAttAnnualItemBOByPid(pagevo,personId);
    }

    public  AttAnnualItemBO findEqualsAttAnnualItemBO(String personId,String recId)throws SysException{
        return this.attAnnualService.findEqualsAttAnnualItemBO(personId,recId);
    }

    public List getAttAnnualItemBO(String recID) throws SysException {
        return this.attAnnualService.getAttAnnualItemBO(recID);
    }

    public void deleteAttAnnualItemBOByRecID(String recId) throws SysException{
        this.attAnnualService.deleteAttAnnualItemBOByRecID(recId);
    }

    public void deleteEqualsAttAnnualItemBO(String recId,String id)throws SysException{
        this.attAnnualService.deleteEqualsAttAnnualItemBO(recId,id);
    }

    public AttAnnualItemBO findAttAnnualItemBObyId(String id)throws SysException{
        return this.attAnnualService.findAttAnnualItemBObyId(id);
    }

    public void saveAttAnnualItemBO(AttAnnualItemBO bo)throws SysException{
        this.attAnnualService.saveAttAnnualItemBO(bo);
    }


    public void deleteAttAnnualExcludeBO() throws SysException{
        this.attAnnualService.deleteAttAnnualExcludeBO();
    }

    public void saveAttAnnualExcludeBO(AttAnnualExcludeBO bo)throws SysException{
        this.attAnnualService.saveAttAnnualExcludeBO(bo);
    }

    public AttExecludeRuleBO findAttExecludeRuleBObyId(String id)throws SysException{
        return this.attAnnualService.findAttExecludeRuleBObyId(id);
    }

    public List getAllAttAnnualExcludeBO(PageVO pagevo, String recId)throws SysException{
        return this.attAnnualService.getAllAttAnnualExcludeBO(pagevo,recId);
    }

    public void deleteAttExecludeRuleBO(String id) throws SysException{
        this.attAnnualService.deleteAttExecludeRuleBO(id);
    }

    public void saveAttExecludeRuleBO(AttExecludeRuleBO bo)throws SysException{
        this.attAnnualService.saveAttExecludeRuleBO(bo);
    }

    public List getAttExecludeRuleItemBO(String ruleId) throws SysException{
        return this.attAnnualService.getAttExecludeRuleItemBO(ruleId);
    }

    public void deleteAttExecludeRuleItemBO(String id) throws SysException{
        this.attAnnualService.deleteAttExecludeRuleItemBO(id);
    }

    public void saveAttExecludeRuleItemBO(AttExecludeRuleItemBO bo)throws SysException{
        this.attAnnualService.saveAttExecludeRuleItemBO(bo);
    }

    public AttExecludeRuleItemBO findAttExecludeRuleItemBObyId(String id)throws SysException{
        return this.attAnnualService.findAttExecludeRuleItemBObyId(id);
    }

    public List getAttAnnualRuleItemBO(String ruleID) throws SysException{
        return this.attAnnualService.getAttAnnualRuleItemBO(ruleID);
    }

    public List getAttExecludeRuleBO(String orgid) throws SysException{
        return this.attAnnualService.getAttExecludeRuleBO(orgid);
    }

    public String caleAttAnnualItemBO(String superId, String recID) throws SysException{
        return this.attAnnualService.caleAttAnnualItemBO(superId,recID);
    }

    public void deleteAttenceSecondDayLogBO(String id, String day) throws SysException{
        this.attAnnualService.deleteAttenceSecondDayLogBO(id,day);
    }

    public void saveAttenceSecondDayLogBO(AttenceSecondDayLogBO bo)throws SysException{
        this.attAnnualService.saveAttenceSecondDayLogBO(bo);
    }

    public List getAllAttAnnualRuleBOByOrgId(String orgid) throws SysException{
        return this.attAnnualService.getAllAttAnnualRuleBOByOrgId(orgid);
    }

    public List getAllCommonAttAnnualRuleBO(String orgid) throws SysException{
        return this.attAnnualService.getAllCommonAttAnnualRuleBO(orgid);
    }

    public AttAnnualRuleBO findAttAnnualRuleBObyId(String id)throws SysException{
        return this.attAnnualService.findAttAnnualRuleBObyId(id);
    }

    public void deleteAttAnnualRuleBO(String id) throws SysException{
        this.attAnnualService.deleteAttAnnualRuleBO(id);
    }

    public void saveAttAnnualRuleBO(AttAnnualRuleBO bo)throws SysException{
        this.attAnnualService.saveAttAnnualRuleBO(bo);
    }

    public AttAnnualRuleItemBO findAttAnnualRuleItemBObyId(String id)throws SysException{
        return this.attAnnualService.findAttAnnualRuleItemBObyId(id);
    }

    public void deleteAttAnnualRuleItemBO(String id) throws SysException{
       this.attAnnualService.deleteAttAnnualRuleItemBO(id);
    }

    public void saveAttAnnualRuleItemBO(AttAnnualRuleItemBO bo)throws SysException{
        this.attAnnualService.saveAttAnnualRuleItemBO(bo);
    }

    public AttClassGroupVO findAttClassGroupVObyId(String id)throws SysException{
        return this.attAnnualService.findAttClassGroupVObyId(id);
    }

    public AttAnnualItemBO findEqualsAttAnnualItemBO(String personId, String orgId, String datevalue)throws SysException{
        return this.attAnnualService.findEqualsAttAnnualItemBO(personId,orgId,datevalue);
    }

    public AttAnnualDetailAuditBO findAttAnnualDetailAuditBObyId(String id)throws SysException{
        return this.attAnnualService.findAttAnnualDetailAuditBObyId(id);
    }

    public List getAttAnnualDetailAuditBO(String itemID) throws SysException{
        return this.attAnnualService.getAttAnnualDetailAuditBO(itemID);
    }

    public String getA001737(String personid) throws SysException{
        return this.attAnnualService.getA001737(personid);
    }

    public void deleteAttAnnualDetailAuditBO(String id) throws SysException{
        this.attAnnualService.deleteAttAnnualDetailAuditBO(id);
    }


    public List getAllAttMimicReportRecBO(PageVO pagevo, String orgId,String personValue,String timeValue,String status)throws SysException{
       return this.attAnnualService.getAllAttMimicReportRecBO(pagevo,orgId,personValue,timeValue,status);
    }

    public AttMimicReportRecBO findAttMimicReportRecBOById(String mimicReportNO)throws SysException{
        return this.attAnnualService.findAttMimicReportRecBOById(mimicReportNO);
    }

    public void saveAttMimicReportRecBO(AttMimicReportRecBO bo)throws SysException{
         this.attAnnualService.saveAttMimicReportRecBO(bo);
    }

    public void deleteAttMimicReportRecBO(String mimicReportNO)throws SysException{
         this.attAnnualService.deleteAttMimicReportRecBO(mimicReportNO);
    }

    public void processTrans(WFTransaction wt) throws SysException{
         this.wfservice.processTrans(wt);
    }


    public WorkFlowService getWfservice() {
        return wfservice;
    }

    public void setWfservice(WorkFlowService wfservice) {
        this.wfservice = wfservice;
    }

    public AttAnnualService getAttAnnualService() {
        return attAnnualService;
    }

    public void setAttAnnualService(AttAnnualService attAnnualService) {
        this.attAnnualService = attAnnualService;
    }

}
