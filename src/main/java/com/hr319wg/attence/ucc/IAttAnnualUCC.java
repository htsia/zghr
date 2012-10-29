package com.hr319wg.attence.ucc;

import com.hr319wg.attence.pojo.bo.*;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.pojo.vo.WFTransaction;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-12-2
 * Time: ÉÏÎç11:15
 * To change this template use File | Settings | File Templates.
 */
public interface IAttAnnualUCC {
    public List getAllAttAnnualRecordBO(PageVO pagevo, String orgid)throws SysException;

    public AttAnnualRecordBO findEquealsAttAnnualRecordBO(String orgId,String year)throws SysException;

    public AttAnnualRecordBO findExcuteAttAnnualRecordBO(String orgId)throws SysException;

    public AttAnnualRecordBO findAttAnnualRecordBOById(String recID)throws SysException;

    public void saveAttAnnualRecordBO(AttAnnualRecordBO bo)throws SysException;

    public void deleteAttAnnualRecordBO(String id) throws SysException;

    public List getAllAttAnnualItemBO(PageVO pagevo, String recID,String personValue) throws SysException;

    public List getAttAnnualItemBO(String recID) throws SysException;

    public void deleteAttAnnualItemBOByRecID(String recId) throws SysException;

    public void deleteEqualsAttAnnualItemBO(String recId,String id)throws SysException;

    public AttAnnualItemBO findAttAnnualItemBObyId(String id)throws SysException;

    public  AttAnnualItemBO findEqualsAttAnnualItemBO(String personId,String recId)throws SysException;

    public void saveAttAnnualItemBO(AttAnnualItemBO bo)throws SysException;

    public List getAttAnnualItemBOByPid(PageVO pagevo, String personId)throws SysException;


    public void deleteAttAnnualDetailBOByRecID(String recId) throws SysException;

    public void saveAttAnnualDetailBO(AttAnnualDetailBO bo) throws SysException;

    public AttAnnualDetailBO findAttAnnualDetailBObyId(String id) throws SysException;

    public List getAllAttAnnualDetailBOByItemId(String itemID) throws SysException;

     public void deleteAttAnnualDetailBO(String id) throws SysException;


    public void deleteAttAnnualExcludeBO() throws SysException;

    public void saveAttAnnualExcludeBO(AttAnnualExcludeBO bo)throws SysException;

    public List getAllAttAnnualExcludeBO(PageVO pagevo, String recId)throws SysException;

    public void deleteAttExecludeRuleBO(String id) throws SysException;

    public void saveAttExecludeRuleBO(AttExecludeRuleBO bo)throws SysException;

    public List getAttAnnualRuleItemBO(String ruleID) throws SysException;

    public void saveAttExecludeRuleItemBO(AttExecludeRuleItemBO bo)throws SysException;

    public List getAttExecludeRuleBO(String orgid) throws SysException;

    public AttExecludeRuleItemBO findAttExecludeRuleItemBObyId(String id)throws SysException;

    public List getAttExecludeRuleItemBO(String ruleId) throws SysException;

    public void deleteAttExecludeRuleItemBO(String id) throws SysException;

    public AttExecludeRuleBO findAttExecludeRuleBObyId(String id)throws SysException;

    public String caleAttAnnualItemBO(String superId, String recID) throws SysException;

    public void deleteAttenceSecondDayLogBO(String id, String day) throws SysException;

    public void saveAttenceSecondDayLogBO(AttenceSecondDayLogBO bo)throws SysException;

    public List getAllAttAnnualRuleBOByOrgId(String orgid) throws SysException;

    public List getAllCommonAttAnnualRuleBO(String orgid) throws SysException;

    public AttAnnualRuleBO findAttAnnualRuleBObyId(String id)throws SysException;

    public void deleteAttAnnualRuleBO(String id) throws SysException;

    public void saveAttAnnualRuleBO(AttAnnualRuleBO bo)throws SysException;

    public AttAnnualRuleItemBO findAttAnnualRuleItemBObyId(String id)throws SysException;

    public void deleteAttAnnualRuleItemBO(String id) throws SysException;

    public void saveAttAnnualRuleItemBO(AttAnnualRuleItemBO bo)throws SysException;

    public AttClassGroupVO findAttClassGroupVObyId(String id)throws SysException;

    public AttAnnualItemBO findEqualsAttAnnualItemBO(String personId, String orgId, String datevalue)throws SysException;

    public AttAnnualDetailAuditBO findAttAnnualDetailAuditBObyId(String id)throws SysException;

    public List getAttAnnualDetailAuditBO(String itemID) throws SysException;

    public String getA001737(String personid) throws SysException;

    public void deleteAttAnnualDetailAuditBO(String id) throws SysException;


    public List getAllAttMimicReportRecBO(PageVO pagevo, String orgId,String personValue,String timeValue,String status)throws SysException;

    public AttMimicReportRecBO findAttMimicReportRecBOById(String mimicReportNO)throws SysException;

    public void saveAttMimicReportRecBO(AttMimicReportRecBO bo)throws SysException;

    public void deleteAttMimicReportRecBO(String mimicReportNO)throws SysException;

    public void processTrans(WFTransaction wt) throws SysException;

}
