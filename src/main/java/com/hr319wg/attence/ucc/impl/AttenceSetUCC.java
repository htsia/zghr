package com.hr319wg.attence.ucc.impl;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.attence.pojo.bo.ATTRearrangeBO;
import com.hr319wg.attence.pojo.bo.ATTRearrangeDateBO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailAuditBO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailBO;
import com.hr319wg.attence.pojo.bo.AttCaclInfoBO;
import com.hr319wg.attence.pojo.bo.AttCaclRuleBO;
import com.hr319wg.attence.pojo.bo.AttCardBO;
import com.hr319wg.attence.pojo.bo.AttChangeWorkBO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassDetailBO;
import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.pojo.bo.AttClassUserBO;
import com.hr319wg.attence.pojo.bo.AttDurationBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttFeastBO;
import com.hr319wg.attence.pojo.bo.AttFileImportBO;
import com.hr319wg.attence.pojo.bo.AttFileImportItemBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttItemSetDetailBO;
import com.hr319wg.attence.pojo.bo.AttManagerArgumentBO;
import com.hr319wg.attence.pojo.bo.AttManagerArrangeBO;
import com.hr319wg.attence.pojo.bo.AttMimicReportRecBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkCollectBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeLogBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeItemBO;
import com.hr319wg.attence.pojo.bo.AttRestOfWeekBO;
import com.hr319wg.attence.pojo.bo.AttTimeOffRecBO;
import com.hr319wg.attence.pojo.bo.AttWorkDateBO;
import com.hr319wg.attence.pojo.bo.AttenceLogBO;
import com.hr319wg.attence.pojo.bo.AttenceSecondDayLogBO;
import com.hr319wg.attence.pojo.bo.AttenceStandBO;
import com.hr319wg.attence.pojo.bo.AttenceWaterBO;
import com.hr319wg.attence.pojo.bo.AttenceWeekWaterBO;
import com.hr319wg.attence.pojo.bo.AttfurloughBO;
import com.hr319wg.attence.pojo.bo.attMachineBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.service.AttDataCaclService;
import com.hr319wg.attence.service.AttDataProcessService;
import com.hr319wg.attence.service.AttenceSetService;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.bo.WFProcessBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.ActivePageService;
import com.hr319wg.sys.service.WorkFlowService;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class AttenceSetUCC implements IAttenceSetUCC {
    public final static String dayNames[] = {"日", "一", "二", "三", "四", "五", "六"};
    private WorkFlowService wfservice;
    private AttDataProcessService attDataProcessService;
    private ActivePageService activepageservice;
    private AttenceSetService attSetService;
    private AttDataCaclService attDataCaclService;

    public AttDataCaclService getAttDataCaclService() {
        return attDataCaclService;
    }

    public void setAttDataCaclService(AttDataCaclService attDataCaclService) {
        this.attDataCaclService = attDataCaclService;
    }
    
    public WorkFlowService getWfservice() {
        return wfservice;
    }

    public void setWfservice(WorkFlowService wfservice) {
        this.wfservice = wfservice;
    }

    public AttDataProcessService getAttDataProcessService() {
        return attDataProcessService;
    }

    public void setAttDataProcessService(
            AttDataProcessService attDataProcessService) {
        this.attDataProcessService = attDataProcessService;
    }

    public ActivePageService getActivepageservice() {
        return activepageservice;
    }

    public void setActivepageservice(ActivePageService activepageservice) {
        this.activepageservice = activepageservice;
    }

    public AttenceSetService getAttSetService() {
        return attSetService;
    }

    public void setAttSetService(AttenceSetService attSetService) {
        this.attSetService = attSetService;
    }

    public List getAllAttenceSet(PageVO pagevo, User user)
            throws SysException {
        return attSetService.getAllAttenceSet(pagevo, user);
    }

    public List getAllAttenceSet1(String orgid, String y, String m)
            throws SysException {
        return attSetService.getAllAttenceSet1(orgid, y, m);
    }

    public List getAttClassGroupVO1(String orgid)
            throws SysException {
        return attSetService.getAttClassGroupVO1(orgid);
    }

    public List getAllAttDurationBOS() throws SysException {
        return attSetService.getAllAttDurationBOS();
    }

    public void saveorupdateAttenceSet(AttDurationBO bo) throws SysException {
        attSetService.saveorupdateAttenceSet(bo);
    }

    public AttDurationBO findAttenceSetBObyId(String id) throws SysException {
        return attSetService.findAttenceSetBObyId(id);
    }

    public void deleteAttenceSetBO(String id) throws SysException {
        attSetService.deleteAttenceSetBO(id);
    }

    public List getAllAttDurationBO(User user) throws SysException {
        return attSetService.getAllAttDurationBO(user);
    }

    // 节假日和公休日管理
    public AttRestOfWeekBO findAttRestOfWeekBObyId(String id)
            throws SysException {
        return attSetService.findAttRestOfWeekBObyId(id);
    }

    public void saveorupdateAttRestOfWeek(AttRestOfWeekBO bo)
            throws SysException {
        attSetService.saveorupdateAttRestOfWeek(bo);
    }

    public void saveAttRestOfWeek(AttRestOfWeekBO bo) throws SysException {
        attSetService.saveAttRestOfWeek(bo);
    }

    public List getAllAttFeast(PageVO pagevo, String orgid) throws SysException {
        return attSetService.getAllAttFeast(pagevo, orgid);
    }

    public List getAllAttWorkDate(String feastID, String orgid) throws SysException {
        return attSetService.getAllAttWorkDate(feastID, orgid);
    }

    public void saveorupdateAttFeast(AttFeastBO bo) throws SysException {
        attSetService.saveorupdateAttFeast(bo);
    }

    public AttFeastBO findAttFeastBObyId(String id) throws SysException {
        return attSetService.findAttFeastBObyId(id);
    }

    public void deleteAttFeastBO(String id) throws SysException {
        attSetService.deleteAttFeastBO(id);
    }

    public void deleteAttWorkDateIsFeastId(String id) throws SysException {
        String sql = "delete from ATT_WORK_DATE where Feast_ID='" + id + "'";
        activepageservice.executeSql(sql);
    }

    public void deleteAttWorkDateBO(String id) throws SysException {
        attSetService.deleteAttWorkDateBO(id);
    }

    public AttWorkDateBO findAttWorkDateBObyId(String id) throws SysException {
        return attSetService.findAttWorkDateBObyId(id);
    }

    public void saveorupdateAttWorkDate(AttWorkDateBO bo) throws SysException {
        attSetService.saveorupdateAttWorkDate(bo);
    }

    // 考勤机管理
    public List findAllAttMachine() throws SysException {
        return attSetService.findAllAttMachine();
    }

    public List getAllAttMachine(PageVO pagevo, String orgid)
            throws SysException {
        return attSetService.getAllAttMachine(pagevo, orgid);
    }

    public void saveorupdateAttMachine(attMachineBO bo) throws SysException {
        attSetService.saveorupdateAttMachine(bo);
    }

    public attMachineBO findBobyId(String id) throws SysException {
        return attSetService.findBobyId(id);
    }

    public void deleteAttMachine(String id) throws SysException {
        attSetService.deleteAttMachine(id);
    }

    // 考勤卡管理
    public void UpdateA001736(String personid, String A001736)
            throws SysException {
        String updateSQL = "update a001 set A001736='" + A001736
                + "' where id='" + personid + "'";
        activepageservice.executeSql(updateSQL);
    }

    public String insertDataA001736(String A001736) throws SysException {
        String sql = "select id from a001 where A001736='" + A001736 + "'";
        return activepageservice.queryForString(sql);
    }

    public void saveAttCard(AttCardBO bo) throws SysException {
        attSetService.saveAttCard(bo);
    }

    public List getAllAttCardBO(PageVO pagevo, String status, String superId)
            throws SysException {
        return attSetService.getAllAttCardBO(pagevo, status, superId);
    }

    public void deleteAttCardBO(String id) throws SysException {
        attSetService.deleteAttCardBO(id);
    }

    public String findInfoItemBObyId(String id) throws SysException {
        String sql = "select ITEM_LENGTH from SYS_INFO_ITEM where ITEM_ID='"
                + id + "'";
        return activepageservice.queryForString(sql);
    }

    // 班次设置
    public List getAllAttClassBO(PageVO pagevo, String orgid)
            throws SysException {
        return attSetService.getAllAttClassBO(pagevo, orgid);
    }

    public List getAttClassBO(String className) throws SysException {
        return attSetService.getAttClassBO(className);
    }

    public void saveAttClassBO(AttClassBO bo) throws SysException {
        attSetService.saveAttClassBO(bo);
    }

    public AttClassBO findAttClassBObyId(String id) throws SysException {
        return attSetService.findAttClassBObyId(id);
    }

    public boolean checkAttClassIsUse(String id)throws SysException{
        return attSetService.checkAttClassIsUse(id);
    }

    public void deleteAttClassBO(AttClassBO bo) throws SysException {
        attSetService.deleteAttClassBO(bo);
    }

    public List getAllAttClassDetailBOS(String classID) throws SysException {
        return attSetService.getAllAttClassDetailBOS(classID);
    }

    public List getAllAttClassDetailBO(PageVO pagevo, String classID)
            throws SysException {
        return attSetService.getAllAttClassDetailBO(pagevo, classID);
    }

    public void saveAttClassDetailBO(AttClassDetailBO bo) throws SysException {
        attSetService.saveAttClassDetailBO(bo);
    }

    public void deleteAttClassDetailBO(AttClassDetailBO bo) throws SysException {
        attSetService.deleteAttClassDetailBO(bo);
    }

    public AttClassDetailBO findAttClassDetailBObyId(String id)
            throws SysException {
        return attSetService.findAttClassDetailBObyId(id);
    }

    public List getAllAttClassDetailBO1(String classID) throws SysException {
        return attSetService.getAllAttClassDetailBO1(classID);
    }

    public List getAllAttClassDetailBO2(String classID) throws SysException {
        return attSetService.getAllAttClassDetailBO2(classID);
    }

    public List getAllAttClassDetailBO3(String classID) throws SysException {
        return attSetService.getAllAttClassDetailBO3(classID);
    }

    public List getAllAttClassDetailBO4(String classID) throws SysException {
        return attSetService.getAllAttClassDetailBO4(classID);
    }

    public String findCountAttClassGroupVO(String groupNo) throws SysException {
        String sql = "select count(a001737) from a001 where a001737 like '"
                + groupNo + "'";
        return activepageservice.queryForString(sql);
    }

    // 查看企业日历
    public List getAttFeastBO(String orgid, String date) throws SysException {
        return attSetService.getAttFeastBO(orgid, date);
    }

    public List getAttFeastBOByOrgId(String orgid, String date)
            throws SysException {
        return attSetService.getAttFeastBOByOrgId(orgid, date);
    }

    public AttRestOfWeekBO getAttRestOfWeekBOByOrgid(String orgid)
            throws SysException {
        return attSetService.getAttRestOfWeekBOByOrgid(orgid);
    }

    // 排班设置
    public List getAllAttClassGroupBOType(String orgid) throws SysException {
        return attSetService.getAllAttClassGroupBOType(orgid);
    }

    public List getAllAttClassGroupBOType1(String orgid) throws SysException {
        return attSetService.getAllAttClassGroupBOType1(orgid);
    }

    public List getAllAttClassBOType(String orgid) throws SysException {
        return attSetService.getAllAttClassBOType(orgid);
    }

    public void saveorupdateAttClassGroupBO(AttClassGroupBO bo)
            throws SysException {
        attSetService.saveorupdateAttClassGroupBO(bo);
    }

    public void saveorupdateAttClassGroupBO1(AttClassGroupBO bo)
            throws SysException {
        attSetService.saveorupdateAttClassGroupBO1(bo);
    }

    public AttClassGroupBO findAttClassGroupBObyId(String id)
            throws SysException {
        return attSetService.findAttClassGroupBObyId(id);
    }

    public void deleteAttClassGroupBO(String id) throws SysException {
        attSetService.deleteAttClassGroupBO(id);
    }

    public List getAllAttClassGroupVO(PageVO pagevo, String orgid,
                                      String groupNo,String queryValue) throws SysException {
        return attSetService.getAllAttClassGroupVO(pagevo, orgid, groupNo,queryValue);
    }

    public List getAllAttClassGroupVO1(PageVO pagevo, String orgid)
            throws SysException {
        return attSetService.getAllAttClassGroupVO1(pagevo, orgid);
    }

    public List getAllAttClassGroupVO2(PageVO pagevo, String orgid)
            throws SysException {
        return attSetService.getAllAttClassGroupVO2(pagevo, orgid);
    }

    public List getAllAttClassGroupVO3(PageVO pagevo, String orgid, String findSeeValue)
            throws SysException {
        return attSetService.getAllAttClassGroupVO3(pagevo, orgid, findSeeValue);
    }

    public List findAllOrgBO(String orgID)
            throws SysException {
        return attSetService.findAllOrgBO(orgID);
    }

    public String findDeptmentVObyId(String id) throws SysException {
        String sql = "select B001005 from B001 where ORGUID='" + id + "'";
        return activepageservice.queryForString(sql);
    }

    public AttClassGroupVO findAttClassGroupVObyId(String id)
            throws SysException {
        return attSetService.findAttClassGroupVObyId(id);
    }

    public void saveAttClassGroupVO(AttClassGroupVO bo) throws SysException {
        attSetService.saveAttClassGroupVO(bo);
    }

    public void UpdateAttClassGroupVO(String personid, String A001737)
            throws SysException {
        String updateSQL = "update a001 set a001737='" + A001737
                + "' where id='" + personid + "'";
        activepageservice.executeSql(updateSQL);
    }

    public List getAllAttClassGroupVOSS(String personSeq) throws SysException {
        return attSetService.getAllAttClassGroupVOSS(personSeq);
    }

    public void saveATTRearrangeBO(ATTRearrangeBO bo) throws SysException {
        attSetService.saveATTRearrangeBO(bo);
    }

    public List getATTRearrangeBO(String orgid) throws SysException {
        return attSetService.getATTRearrangeBO(orgid);
    }

    public List getAllATTRearrangeBO(PageVO pagevo, String orgid)
            throws SysException {
        return attSetService.getAllATTRearrangeBO(pagevo, orgid);
    }

    public void UpdateATTRearrangeBO(String rearrangeNo) throws SysException {
        String updateSQL = "update ATT_Rearrange set LINK_CLASS='' where RearrangeNo='"
                + rearrangeNo + "'";
        activepageservice.executeSql(updateSQL);
    }

    public ATTRearrangeBO findATTRearrangeBObyId(String id) throws SysException {
        return attSetService.findATTRearrangeBObyId(id);
    }

    public List findATTRearrangeBO1(String orgid, String dayseq)
            throws SysException {
        return attSetService.findATTRearrangeBO1(orgid, dayseq);
    }

    public void deleteATTRearrangeBO1(String id) throws SysException {
        attSetService.deleteATTRearrangeBO1(id);
    }

    public void saveATTRearrangeDateBO(ATTRearrangeDateBO bo)
            throws SysException {
        attSetService.saveATTRearrangeDateBO(bo);
    }

    public Hashtable getPeriodInfo(String groupID, String aDate, int num) {
        return attDataProcessService.getPeriodInfo(groupID, aDate, num);
    }

    public Hashtable getPeriodInfoDate(String groupID, String aDate1) {
        return attDataProcessService.getPeriodInfoDate(groupID, aDate1);
    }

    // 考勤数据文件接收规则
    public List getAttFileImportBO(PageVO pagevo, String orgid)
            throws SysException {
        return attSetService.getAttFileImportBO(pagevo, orgid);
    }

    public void saveorupdateAttFileImportBO(AttFileImportBO bo)
            throws SysException {
        attSetService.saveorupdateAttFileImportBO(bo);
    }

    public AttFileImportBO findAttFileImportBObyId(String id)
            throws SysException {
        return attSetService.findAttFileImportBObyId(id);
    }

    public void deleteAttFileImportBO(String id) throws SysException {
        attSetService.deleteAttFileImportBO(id);
    }

    public List getAttFileImportItemBO(String itemID) throws SysException {
        return attSetService.getAttFileImportItemBO(itemID);
    }

    public void saveorupdateAttFileImportItemBO(AttFileImportItemBO bo)
            throws SysException {
        attSetService.saveorupdateAttFileImportItemBO(bo);
    }

    public AttFileImportItemBO findAttFileImportItemBObyId(String id)
            throws SysException {
        return attSetService.findAttFileImportItemBObyId(id);
    }

    public void deleteAttFileImportItemBO(String id) throws SysException {
        attSetService.deleteAttFileImportItemBO(id);
    }

    // 年假管理


    public void saveAttenceSecondDayLogBO(AttenceSecondDayLogBO bo) throws SysException {
        attSetService.saveAttenceSecondDayLogBO(bo);
    }

    public List getInfoItemBO(String setId) throws SysException {
        return attSetService.getInfoItemBO(setId);
    }

    public List getAllAttAnnualItemBO(PageVO pagevo, String recID)
            throws SysException {
        return attSetService.getAllAttAnnualItemBO(pagevo, recID);
    }

    public List getAttAnnualItemBO1(String personId, String year, String orgId)
            throws SysException {
        return attSetService.getAttAnnualItemBO1(personId, year, orgId);
    }

    public void deleteAttAnnualItemBO(String id) throws SysException {
        attSetService.deleteAttAnnualItemBO(id);
    }

    public void saveorupdateAttAnnualDetailAuditBO(AttAnnualDetailAuditBO bo) throws SysException {
        attSetService.saveorupdateAttAnnualDetailAuditBO(bo);
    }

    public void saveorupdateAttAnnualDetailBO(AttAnnualDetailBO bo) throws SysException {
        attSetService.saveorupdateAttAnnualDetailBO(bo);
    }

    public AttAnnualDetailBO findAttAnnualDetailBObyId(String id) throws SysException {
        return attSetService.findAttAnnualDetailBObyId(id);
    }


    // 个人考勤服务
    public void deleteWFProcessBO(String id) throws SysException {
        attSetService.deleteWFProcessBO(id);
    }

    public void deleteSysInProcessBO(String processId) throws SysException {
        String sql = "delete from SYS_INPROCESS where processID='" + processId + "'";
        activepageservice.executeSql(sql);
    }

    public void deleteWFLogBO(String processId) throws SysException {
        String sql = "delete from WF_PROCESS_LOG where PROCESS_ID='" + processId + "'";
        activepageservice.executeSql(sql);
    }

    public WFProcessBO findWFProcessBO(String linkID) throws SysException {
        return attSetService.findWFProcessBO(linkID);
    }

    public String findAttAnnualDetailAuditBOStatusValue(String personid) throws SysException {
        String sql = "select STATUS_VALUE from ATT_ANNUAL_DETAIL_AUDIT where PERSON_ID='" + personid + "' and STATUS_VALUE<>'3'";
        return activepageservice.queryForString(sql);
    }

    public void deleteAttAnnualDetailAuditBO1(String FurloughNo) throws SysException {
        String sql = "delete from ATT_ANNUAL_DETAIL_AUDIT where FurloughNo='" + FurloughNo + "'";
        activepageservice.executeSql(sql);
    }

     public void deleteAttenceSecondDayLogBO(String id, String day) throws SysException{
        String sql = "delete from A807 where ID='" + id + "' and A807700='" + day + "'";
        this.activepageservice.executeSql(sql);
     }

    public List getAttAnnualDetailAuditBO(String personId, String furloughno)
            throws SysException {
        return attSetService.getAttAnnualDetailAuditBO(personId, furloughno);
    }

    public List getAttenceLogBO(PageVO pagevo, String userid, String beginDate, String endDate, String findseevalue)
            throws SysException {
        return attSetService.getAttenceLogBO(pagevo, userid, beginDate, endDate, findseevalue);
    }

    public List getAttenceLogBO1(String userid, String beginDate, String endDate)
            throws SysException {
        return attSetService.getAttenceLogBO1(userid, beginDate, endDate);
    }

    public List getAttenceLogBO2(String userid, String day)
            throws SysException {
        return attSetService.getAttenceLogBO2(userid, day);
    }

    public List getAttenceLogBO3(String userid, String day)
            throws SysException {
        return attSetService.getAttenceLogBO3(userid, day);
    }

    public void saveAttenceLogBO(AttenceLogBO bo) throws SysException {
        attSetService.saveAttenceLogBO(bo);
    }

    public List getAttenceDayLogBO(String userid, String beginDate,
                                   String endDate) throws SysException {
        return attSetService.getAttenceDayLogBO(userid, beginDate, endDate);
    }

    public List getAttenceDayMonthBO(String userid, String beginDate,
                                     String endDate) throws SysException {
        return attSetService.getAttenceDayMonthBO(userid, beginDate, endDate);
    }

    public List getAttFurloughRecBO(String personId, PageVO mypage,
                                    boolean isExist) throws SysException {
        return attSetService.getAttFurloughRecBO(personId, mypage, isExist);
    }

    public List findAttFurloughRecBO(String personId, PageVO mypage,
                                     String argment) throws SysException {
        return attSetService.findAttFurloughRecBO(personId, mypage, argment);
    }

    public List findAttEvcctionRecBO(String personId, PageVO mypage,
                                     String argment) throws SysException {
        return attSetService.findAttEvcctionRecBO(personId, mypage, argment);
    }

    public List findAttOutWorkBO(String personId, PageVO mypage,
                                 String argment) throws SysException {
        return attSetService.findAttOutWorkBO(personId, mypage, argment);
    }

    public List getAttFurloughRecCollectBO(String personId, PageVO mypage) throws SysException {
        return attSetService.getAttFurloughRecCollectBO(personId, mypage);
    }

    public void saveAttFurloughRecCollectBO(AttFurloughRecCollectBO bo) throws SysException {
        attSetService.saveAttFurloughRecCollectBO(bo);
    }

    public List getAttEvcctionRecCollectBO(String personId, PageVO mypage) throws SysException {
        return attSetService.getAttEvcctionRecCollectBO(personId, mypage);
    }

    public List getAttOutWorkCollectBO(String personId, PageVO mypage) throws SysException {
        return attSetService.getAttOutWorkCollectBO(personId, mypage);
    }

    public List getAttFurloughRecBO1(String personId, PageVO mypage,
                                     boolean isExist, String operID, String deptID, User user) throws SysException {
        return attSetService.getAttFurloughRecBO1(personId, mypage, isExist, operID, deptID, user);
    }

    public List getAttAnnualDetailAuditBO(String orgId, PageVO mypage,
                                          boolean isExist, String operID, String deptID, User user,String queryValue) throws SysException {
        return attSetService.getAttAnnualDetailAuditBO(orgId, mypage, isExist, operID, deptID, user,queryValue);
    }

    public List findAttFurloughRecBO(String id)
            throws SysException {
        return attSetService.findAttFurloughRecBO(id);
    }

    public List findAttEvcctionRecBO(String id)
            throws SysException {
        return attSetService.findAttEvcctionRecBO(id);
    }

    public List findAttOutWorkBO(String id)
            throws SysException {
        return attSetService.findAttOutWorkBO(id);
    }

    public AttFurloughRecCollectBO findAttFurloughRecCollectBObyId(String id)
            throws SysException {
        return attSetService.findAttFurloughRecCollectBObyId(id);
    }

    public List findAttFurloughRecCollectBO(String id)
            throws SysException {
        return attSetService.findAttFurloughRecCollectBO(id);
    }

    public AttEvcctionRecCollectBO findAttEvcctionRecCollectBObyId(String id)
            throws SysException {
        return attSetService.findAttEvcctionRecCollectBObyId(id);
    }

    public AttOutWorkCollectBO findAttOutWorkCollectBObyId(String id)
            throws SysException {
        return attSetService.findAttOutWorkCollectBObyId(id);
    }

    public void saveAttFurloughRecBO(AttFurloughRecBO bo) throws SysException {
        attSetService.saveAttFurloughRecBO(bo);
    }

    public void deleteAttFurloughRecBO(String id) throws SysException {
        attSetService.deleteAttFurloughRecBO(id);
    }

    public void deleteAttEvcctionRecBO(String id) throws SysException {
        attSetService.deleteAttEvcctionRecBO(id);
    }

    public void deleteAttOutWorkBO(String id) throws SysException {
        attSetService.deleteAttOutWorkBO(id);
    }

    public List getAllAttClassGroupVO(String orgid) throws SysException {
        return attSetService.getAllAttClassGroupVO(orgid);
    }

    public List getAllPersonTable(String orgid, String name, String personType)
            throws SysException {
        return attSetService.getAllPersonTable(orgid, name, personType);
    }

    public AttFurloughRecBO findAttFurloughRecBObyId(String id)
            throws SysException {
        return attSetService.findAttFurloughRecBObyId(id);
    }

    public List getAllAttfurloughBO() throws SysException {
        return attSetService.getAllAttfurloughBO();
    }

    public AttfurloughBO findAttfurloughBObyId(String id) throws SysException {
        return attSetService.findAttfurloughBObyId(id);
    }

    public List getAttEvcctionRecBO(String personId, PageVO mypage,
                                    boolean isExist) throws SysException {
        return attSetService.getAttEvcctionRecBO(personId, mypage, isExist);
    }

    public List getAttEvcctionRecBO1(String personId, PageVO mypage,
                                     boolean isExist, String operID, String deptID, User user) throws SysException {
        return attSetService.getAttEvcctionRecBO1(personId, mypage, isExist, operID, deptID, user);
    }

    public List getAttOutWorkBO1(String personId, PageVO mypage, boolean isExist, String operID, String deptID, User user) throws SysException {
        return attSetService.getAttOutWorkBO1(personId, mypage, isExist, operID, deptID, user);
    }

    public List getAttOverTimeRecBO(String personId, PageVO mypage,
                                    boolean isExist, String operID, String deptID, User user) throws SysException {
        return attSetService.getAttOverTimeRecBO(personId, mypage, isExist, operID, deptID, user);
    }

    public void saveAttEvcctionRecBO(AttEvcctionRecBO bo) throws SysException {
        attSetService.saveAttEvcctionRecBO(bo);
    }

    public void saveAttOutWorkBO(AttOutWorkBO bo) throws SysException {
        attSetService.saveAttOutWorkBO(bo);
    }

    public AttEvcctionRecBO findAttEvcctionRecBObyId(String id)
            throws SysException {
        return attSetService.findAttEvcctionRecBObyId(id);
    }

    public AttOutWorkBO findAttOutWorkBObyId(String id)
            throws SysException {
        return attSetService.findAttOutWorkBObyId(id);
    }

    public List getAttChangeWorkBO(String personId, PageVO mypage,
                                   boolean isExist) throws SysException {
        return attSetService.getAttChangeWorkBO(personId, mypage, isExist);
    }

    public List getAttChangeWorkBO1(String personId, PageVO mypage,
                                    boolean isExist) throws SysException {
        return attSetService.getAttChangeWorkBO1(personId, mypage, isExist);
    }

    public List getAttChangeWorkBO2(String personId) throws SysException {
        return attSetService.getAttChangeWorkBO2(personId);
    }

    public List getAttChangeWorkBO3(String personId, String aDate)
            throws SysException {
        return attSetService.getAttChangeWorkBO3(personId, aDate);
    }

    public void saveorupdateAttChangeWorkBO(AttChangeWorkBO bo)
            throws SysException {
        attSetService.saveorupdateAttChangeWorkBO(bo);
    }

    public AttChangeWorkBO findAttChangeWorkBObyId(String id)
            throws SysException {
        return attSetService.findAttChangeWorkBObyId(id);
    }

    public void deleteAttChangeWorkBO(String id, String day) throws SysException {
        String sql = "delete from ATT_ChangeWork where PERSON_ID='" + id + "' and  WORK_DATE='" + day + "'";
        activepageservice.executeSql(sql);
    }


    public List getAttAddWorkRecBO(String personId, PageVO mypage,
                                   boolean isExist) throws SysException {
        return attSetService.getAttAddWorkRecBO(personId, mypage, isExist);
    }

    public void saveAttOverTimeRecBO(AttOverTimeRecBO bo) throws SysException {
        attSetService.saveAttOverTimeRecBO(bo);
    }

    public AttOverTimeRecBO findAttOverTimeRecBObyId(String id) throws SysException {
        return attSetService.findAttOverTimeRecBObyId(id);
    }

    // 考勤计算
    public void saveAttCaclInfoBO(AttCaclInfoBO bo) throws SysException {
        attSetService.saveAttCaclInfoBO(bo);
    }

    public AttDurationBO findAttDurationBObyId(String id) throws SysException {
        return attSetService.findAttDurationBObyId(id);
    }

    public void saveorupdateAttDurationBO(AttDurationBO bo) throws SysException {
        attSetService.saveorupdateAttDurationBO(bo);
    }

    public List getAttClassGroupVO(String orgID) throws SysException {
        return attSetService.getAttClassGroupVO(orgID);
    }

    public List getAttenceMonthBO(String userid, String duraYearMonth)
            throws SysException {
        return attSetService.getAttenceMonthBO(userid, duraYearMonth);
    }

    public List getAttCaclInfoBO(String duraId) throws SysException {
        return attSetService.getAttCaclInfoBO(duraId);
    }

    public void deleteAttCaclInfoBO(String duraID) throws SysException {
        String sql = "delete from ATT_CACL_INFO where DURA_ID='" + duraID + "'";
        activepageservice.executeSql(sql);
    }

    public List getAttenceDayMonthBO(String userid, String beginDate)
            throws SysException {
        return attSetService.getAttenceDayLogBO(userid, beginDate);
    }

    public List getAttenceDayMonthBOS(String userid, String beginDate, String endDate)
            throws SysException {
        return attSetService.getAttenceDayMonthBOS(userid, beginDate, endDate);
    }

    public List getAttenceLogBO(String personId, String cardDate)
            throws SysException {
        return attSetService.getAttenceLogBO(personId, cardDate);
    }

    public void processTrans(WFTransaction wt) throws SysException {
        wfservice.processTrans(wt);
    }

    public WFNodeBO getCurrentNode(String furloughNO) throws SysException {
        return wfservice.getCurrentNode(furloughNO);
    }

    public String getA001(String personid) throws SysException {
        String sql = "select ID from a001 where A001735='" + personid + "'";
        return activepageservice.queryForString(sql);
    }

    public void insertInfoByCode(List lists, String itemId[])
            throws SysException {
        String str = (String) lists.get(0);
        String[] strs = str.split(",");
        String sql = "insert into A808(subID,A808000,ID,";
        for (int i = 0; i < itemId.length; i++) {
            if (i == (itemId.length - 1)) {
                sql += itemId[i] + ")";
            } else if (i == 0) {
                sql += itemId[0] + ",";
            } else {
                sql += itemId[i] + ",";
            }
        }

        for (int i = 1; i < lists.size(); i++) {
            String sql1 = " values('";
            String str1 = (String) lists.get(i);
            String[] str1s = str1.split(",");
            String pk = SequenceGenerator.getKeyId("A808");
            String ids = getA001(str1s[0]);
            if (ids == null || "".equals(ids)) {
                continue;
            }
            for (int j = 2; j < str1s.length; j++) {
                if (j == (str1s.length - 1)) {
                    sql1 += str1s[j] + "')";
                } else if (j == 2) {
                    sql1 += pk + "','00900','" + ids + "','" + str1s[2] + "','";
                } else {
                    sql1 += str1s[j] + "','";
                }
            }
            String sqls = sql + sql1;
            activepageservice.executeSql(sqls);
        }
    }

    // 换班
    public AttClassBO changeWork(String orguid, String bo, String day)
            throws SysException {
        return attDataProcessService.changeWork(orguid, bo, day);
    }

    // 换班
    public AttClassBO changeWork1(String id, String orguid, String bo, String day)
            throws SysException {
        return attDataProcessService.changeWork1(id, orguid, bo, day);
    }

    public Hashtable getRightDate(String orguid, String groupID, String aDate) {
        return attDataProcessService.getRightDate(orguid, groupID, aDate);
    }

    public Hashtable getAllAttClassGroupBOForHash() throws SysException {
        return this.attDataProcessService.getAllAttClassGroupBOForHash();
    }

    public Hashtable getAllAttClassBOForHash() throws SysException {
        return this.attDataProcessService.getAllAttClassBOForHash();
    }

    //查看导入日志
    public List getAttImportAll(PageVO mypage) throws SysException {
        return attSetService.getAttImportAll(mypage);
    }

    //设置考勤计算规则
    public List getAttCaclRuleBO(String orgID) throws SysException {
        return attSetService.getAttCaclRuleBO(orgID);
    }

    public void saveorupdateAttCaclRuleBO(AttCaclRuleBO bo) throws SysException {
        attSetService.saveorupdateAttCaclRuleBO(bo);
    }

    public String findPersonID(String cardNo) throws SysException {
        String sql = "select ID  from a001 where a001736='" + cardNo + "'";
        return activepageservice.queryForString(sql);
    }

    public String findPersonNoToID(String personNo) throws SysException {
        String sql = "select ID  from a001 where a001735='" + personNo + "'";
        return activepageservice.queryForString(sql);
    }

    public String findPersonNoToIDS(String oldPersonNo) throws SysException {
        String sql = "select ID  from a001 where a001999='" + oldPersonNo + "'";
        return activepageservice.queryForString(sql);
    }

    //刷卡数据查询
    public String queryPersonList(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel,
               User user, String qryID, String addConditon, String beginDate, String endDate, String popuppostid, String argments,String cardtype)
            throws Exception {
        StringBuffer sql;
        StringBuffer where = new StringBuffer();
        if (name != null && !"".equals(name.trim())) {
            String namecon = "1=0";
            String namestr[] = name.split(",");
            for (int i = 0; i < namestr.length; i++)
                if (!"".equals(namestr[i]))
                    namecon = namecon + " or A001.A001001 LIKE '%" + namestr[i] + "%' or A001.A001735 like '%" + namestr[i] + "%' or A001002 like '%" + namestr[i] + "%' or A001999 like '%" + namestr[i] + "%'";

            namecon = " and (" + namecon + ")";
            where.append(namecon);
        }
        if (perType != null && !"".equals(perType.trim())) {
            String pers[] = perType.split(",");
            where.append(" and ").append(CommonFuns.splitInSql(pers, "A001.A001054"));
        }
        if (superId != null && !"".equals(superId.trim())) {
            OrgBO bo = SysCacheTool.findOrgById(superId);
            if (bo != null)
                where.append(" and A001.A001738 LIKE '" + bo.getTreeId() + "%'");
        }
        String addCondition = "";
        if (!"".equals(cancel))
            addCondition = "A001730 = '" + cancel + "'";
        if(cardtype!=null&&!cardtype.equals("")){
            addCondition+=" and A808704 like '%"+cardtype+"%'";
        }
        if (qryID == null)
            qryID = Constants.DEFAULT_QUERY_PERSON;
        CellVO c1[] = attSetService.queryInfoItem(qryID);
        table.setHeader(c1);
        table.setSetType("A");
        Hashtable hash = attSetService.getQuerySqlHash(user, qryID, addCondition, beginDate, endDate);
        String select = CommonFuns.filterNull((String) hash.get("SQL_SELECT_PART"));
        String from = CommonFuns.filterNull((String) hash.get("SQL_FROM_PART"));
        String condition = CommonFuns.filterNull((String) hash.get("SQL_WHERE_PART"));
        String scale = CommonFuns.filterNull((String) hash.get("SQL_SCALE_PART"));
        String order = CommonFuns.filterNull((String) hash.get("SQL_ORDER_PART"));
        sql = new StringBuffer();
        if (!"".equals(select) && !"".equals(from)) {
            sql.append("SELECT ").append(select).append(" FROM ").append(from);
            if (!"".equals(condition) || !"".equals(scale) || where != null && where.length() > 0) {
                if ("ORACLE".equals(Constants.DB_TYPE)) {
                    sql.append(" WHERE 1=1 and (A001.A001736<>'' or  A001.A001736 is not null)  and  A001.ID in (select ID from A808 WHERE A808.A808700<>'' or  A808.A808700 is not null  ) ");
                } else {
                    sql.append(" WHERE 1=1 and (A001.A001736<>'' and  A001.A001736 is not null)  and  A001.ID in (select ID from A808 WHERE A808700<>'' and  A808700 is not null) ");
                }
            }
            if (popuppostid != null && !"".equals(popuppostid)) {
                sql.append(" and A001.A001715 in (select POSTID from C001 where C001005 like '%" + popuppostid.trim() + "%')");
            }
            if (!"".equals(condition))
                sql.append(" and ").append(condition);
            if (!"".equals(scale))
                sql.append(" and ").append(scale);
            if (where != null && where.length() > 0)
                sql.append(where);
            if (addConditon != null && !"".equals(addConditon))
                sql.append(" and ").append(addConditon);
            if (!"".equals(order))
                sql.append(" order by A001.A001001,A808.A808700 desc,A808.A808701 desc,").append(order);
            else
                sql.append(" order by A001.A001001,A808.A808700 desc,A808.A808701 desc,").append("A001.A001746");
        }
        activepageservice.querySql(table, sql.toString(), user, pageNum, rowNum, true);
        return sql.toString();
    }

    //汇总刷卡数据查询
    public String queryPersonList(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel,
                                  User user, String qryID, String addConditon, String beginDate, String endDate, String perIds)
            throws Exception {
        StringBuffer sql;
        StringBuffer where = new StringBuffer();
        if (name != null && !"".equals(name.trim())) {
            String namecon = "1=0";
            String namestr[] = name.split(",");
            for (int i = 0; i < namestr.length; i++)
                if (!"".equals(namestr[i]))
                    namecon = namecon + " or A001.A001001 LIKE '%" + namestr[i] + "%' or A001.A001735 like '%" + namestr[i] + "%' or A001002 like '%" + namestr[i] + "%' or A001999 like '%" + namestr[i] + "%'";

            namecon = " and (" + namecon + ")";
            where.append(namecon);
        }
        if (perType != null && !"".equals(perType.trim())) {
            String pers[] = perType.split(",");
            where.append(" and ").append(CommonFuns.splitInSql(pers, "A001.A001054"));
        }
        if (superId != null && !"".equals(superId.trim())) {
            OrgBO bo = SysCacheTool.findOrgById(superId);
            if (bo != null)
                where.append(" and A001.A001738 LIKE '" + bo.getTreeId() + "%'");
        }
        String addCondition = "";
        if (!"".equals(cancel))
            addCondition = "A001730 = '" + cancel + "'";
        if (qryID == null)
            qryID = Constants.DEFAULT_QUERY_PERSON;
        CellVO c1[] = attSetService.queryInfoItem(qryID);
        table.setHeader(c1);
        table.setSetType("A");
        Hashtable hash = attSetService.getQuerySqlHash(user, qryID, addCondition, beginDate, endDate);
        String select = CommonFuns.filterNull((String) hash.get("SQL_SELECT_PART"));
        String from = CommonFuns.filterNull((String) hash.get("SQL_FROM_PART"));
        String condition = CommonFuns.filterNull((String) hash.get("SQL_WHERE_PART"));
        String scale = CommonFuns.filterNull((String) hash.get("SQL_SCALE_PART"));
        String order = CommonFuns.filterNull((String) hash.get("SQL_ORDER_PART"));
        sql = new StringBuffer();
        if (!"".equals(select) && !"".equals(from)) {
            sql.append("SELECT ").append(select).append(" FROM ").append(from);
            if (!"".equals(condition) || !"".equals(scale) || where != null && where.length() > 0) {
                if ("ORACLE".equals(Constants.DB_TYPE)) {
                    sql.append(" WHERE 1=1 and (A001.A001736<>'' or  A001.A001736 is not null)  and  A001.ID in (select ID from A808 WHERE (A808.A808700<>'' or  A808.A808700 is not null) and A808.ID in (" + perIds + "))");
                } else {
                    sql.append(" WHERE 1=1 and (A001.A001736<>'' and  A001.A001736 is not null)  and  A001.ID in (select ID from A808 WHERE A808700<>'' and  A808700 is not null and ID in (" + perIds + "))");
                }
            }
            if (!"".equals(condition))
                sql.append(" and ").append(condition);
            if (!"".equals(scale))
                sql.append(" and ").append(scale);
            if (where != null && where.length() > 0)
                sql.append(where);
            if (addConditon != null && !"".equals(addConditon))
                sql.append(" and ").append(addConditon);
            if (!"".equals(order))
                sql.append(" order by A001.A001001,A808.A808700 desc,A808.A808701 desc,").append(order);
            else
                sql.append(" order by A001.A001001,A808.A808700 desc,A808.A808701 desc,").append("A001.A001746");
        }
        activepageservice.querySql(table, sql.toString(), user, pageNum, rowNum, true);
        return sql.toString();
    }

    //考勤月汇总查询
    public String queryPersonListandmonth(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel,
                                          User user, String qryID, String addConditon, String beginDate, String endDate, String perIds)
            throws Exception {
        StringBuffer sql;
        StringBuffer where = new StringBuffer();
        if (name != null && !"".equals(name.trim())) {
            String namecon = "1=0";
            String namestr[] = name.split(",");
            for (int i = 0; i < namestr.length; i++)
                if (!"".equals(namestr[i]))
                    namecon = namecon + " or A001.A001001 LIKE '%" + namestr[i] + "%' or A001.A001735 like '%" + namestr[i] + "%' or A001002 like '%" + namestr[i] + "%' or A001999 like '%" + namestr[i] + "%'";

            namecon = " and (" + namecon + ")";
            where.append(namecon);
        }
        if (perType != null && !"".equals(perType.trim())) {
            String pers[] = perType.split(",");
            where.append(" and ").append(CommonFuns.splitInSql(pers, "A001.A001054"));
        }
        if (superId != null && !"".equals(superId.trim())) {
            OrgBO bo = SysCacheTool.findOrgById(superId);
            if (bo != null)
                where.append(" and A001.A001738 LIKE '" + bo.getTreeId() + "%'");
        }
        String addCondition = "";
        if (!"".equals(cancel))
            addCondition = "A001730 = '" + cancel + "'";
        if (qryID == null)
            qryID = Constants.DEFAULT_QUERY_PERSON;
        CellVO c1[] = attSetService.queryInfoItem(qryID);
        table.setHeader(c1);
        table.setSetType("A");
        Hashtable hash = attSetService.getQuerySqlHash(user, qryID, addCondition, beginDate, endDate);
        String select = CommonFuns.filterNull((String) hash.get("SQL_SELECT_PART"));
        String from = CommonFuns.filterNull((String) hash.get("SQL_FROM_PART"));
        String condition = CommonFuns.filterNull((String) hash.get("SQL_WHERE_PART"));
        String scale = CommonFuns.filterNull((String) hash.get("SQL_SCALE_PART"));
        String order = CommonFuns.filterNull((String) hash.get("SQL_ORDER_PART"));
        sql = new StringBuffer();
        if (!"".equals(select) && !"".equals(from)) {
            sql.append("SELECT ").append(select).append(" FROM ").append(from);
            if (!"".equals(condition) || !"".equals(scale) || where != null && where.length() > 0) {
                if ("ORACLE".equals(Constants.DB_TYPE)) {
                    sql.append(" WHERE 1=1 and A001.ID in (select ID from A810 WHERE (A810.A810700<>'' or  A810.A810700 is not null)  ");
                    if (perIds != null && !"".equals(perIds)) {
                        sql.append(" and A810.ID in (" + perIds + ")");
                    }
                    sql.append(")");
                } else {
                    sql.append(" WHERE 1=1 and A001.ID in (select ID from A810 WHERE A810700<>'' and  A810700 is not null  ");
                    if (perIds != null && !"".equals(perIds)) {
                        sql.append(" and ID in (" + perIds + ")");
                    }
                    sql.append(")");
                }
            }
            if (!"".equals(condition))
                sql.append(" and ").append(condition);
            if (!"".equals(scale))
                sql.append(" and ").append(scale);
            if (where != null && where.length() > 0)
                sql.append(where);
            if (addConditon != null && !"".equals(addConditon))
                sql.append(" and ").append(addConditon);
            if (!"".equals(order))
                sql.append(" order by ").append(order);
            else
                sql.append(" order by ").append("A001.A001746");
        }
        activepageservice.querySql(table, sql.toString(), user, pageNum, rowNum, true);
        return sql.toString();
    }

    //考勤日汇总查询
    public String queryPersonListandday(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel,
                                        User user, String qryID, String addConditon, String beginDate, String endDate, String perIds)
            throws Exception {
        StringBuffer sql;
        StringBuffer where = new StringBuffer();
        if (name != null && !"".equals(name.trim())) {
            String namecon = "1=0";
            String namestr[] = name.split(",");
            for (int i = 0; i < namestr.length; i++)
                if (!"".equals(namestr[i]))
                    namecon = namecon + " or A001.A001001 LIKE '%" + namestr[i] + "%' or A001.A001735 like '%" + namestr[i] + "%' or A001002 like '%" + namestr[i] + "%' or A001999 like '%" + namestr[i] + "%'";

            namecon = " and (" + namecon + ")";
            where.append(namecon);
        }
        if (perType != null && !"".equals(perType.trim())) {
            String pers[] = perType.split(",");
            where.append(" and ").append(CommonFuns.splitInSql(pers, "A001.A001054"));
        }
        if (superId != null && !"".equals(superId.trim())) {
            OrgBO bo = SysCacheTool.findOrgById(superId);
            if (bo != null)
                where.append(" and A001.A001738 LIKE '" + bo.getTreeId() + "%'");
        }
        String addCondition = "";
        if (!"".equals(cancel))
            addCondition = "A001730 = '" + cancel + "'";
        if (qryID == null)
            qryID = Constants.DEFAULT_QUERY_PERSON;
        CellVO c1[] = attSetService.queryInfoItem(qryID);
        table.setHeader(c1);
        table.setSetType("A");
        Hashtable hash = attSetService.getQuerySqlHash(user, qryID, addCondition, beginDate, endDate);
        String select = CommonFuns.filterNull((String) hash.get("SQL_SELECT_PART"));
        String from = CommonFuns.filterNull((String) hash.get("SQL_FROM_PART"));
        String condition = CommonFuns.filterNull((String) hash.get("SQL_WHERE_PART"));
        String scale = CommonFuns.filterNull((String) hash.get("SQL_SCALE_PART"));
        String order = CommonFuns.filterNull((String) hash.get("SQL_ORDER_PART"));
        sql = new StringBuffer();
        if (!"".equals(select) && !"".equals(from)) {
            sql.append("SELECT ").append(select).append(" FROM ").append(from);
            if (!"".equals(condition) || !"".equals(scale) || where != null && where.length() > 0) {
                if ("ORACLE".equals(Constants.DB_TYPE)) {
                    sql.append(" WHERE 1=1 and A001.ID in (select ID from A809 WHERE (A809.A809700<>'' or  A809.A809700 is not null) and A809.ID in (" + perIds + "))");
                } else {
                    sql.append(" WHERE 1=1 and A001.ID in (select ID from A809 WHERE A809700<>'' and  A809700 is not null and ID in (" + perIds + "))");
                }
            }
            if (!"".equals(condition))
                sql.append(" and ").append(condition);
            if (!"".equals(scale))
                sql.append(" and ").append(scale);
            if (where != null && where.length() > 0)
                sql.append(where);
            if (addConditon != null && !"".equals(addConditon))
                sql.append(" and ").append(addConditon);
            if (!"".equals(order))
                sql.append(" order by A809.A809700 desc,").append(order);
            else
                sql.append(" order by A809.A809700 desc,").append("A001.A001746");
        }
        activepageservice.querySql(table, sql.toString(), user, pageNum, rowNum, true);
        return sql.toString();
    }

    //考勤项目规则
    public List getAllAttItemSetDetailBO(String orgID)
            throws SysException {
        return attSetService.getAllAttItemSetDetailBO(orgID);
    }

    public void saveorupdateAttItemSetDetailBO(AttItemSetDetailBO bo) throws SysException {
        attSetService.saveorupdateAttItemSetDetailBO(bo);
    }

    public AttItemSetDetailBO findAttItemSetDetailBObyId(String id)
            throws SysException {
        return attSetService.findAttItemSetDetailBObyId(id);
    }

    public void deleteAttItemSetDetailBO(String id) throws SysException {
        attSetService.deleteAttItemSetDetailBO(id);
    }

    public List findAllAttItemSetDetailBO(String itemCode, String orgID)
            throws SysException {
        return attSetService.findAllAttItemSetDetailBO(itemCode, orgID);
    }

    public String getA001737(String personid) throws SysException{
         String sql = "select A001737 from a001 where id='" + personid + "'";
		return activepageservice.queryForString(sql);
    }

    public String insertDatapersonid(String personid) throws SysException {
		String sql = "select A001736 from a001 where id='" + personid + "'";
		return activepageservice.queryForString(sql);
	}

    public List findAllInfoItemBO(String setId)
            throws SysException {
        return attSetService.findAllInfoItemBO(setId);
    }

    public String findFlagChara807andsum(String personID, String day, String flagchar) throws SysException {
        String sql = "select sum(cast(A807" + flagchar + " as float)) from a807 where ID='" + personID
                + "' and A807700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String findFlagChar(String id, String day, String orgID) throws Exception {
        String names = "";
        String[] m = {"704", "705", "706", "707", "708", "709", "710", "711", "712", "713", "714", "715", "716", "717", "718", "719", "720", "721"};
        Hashtable nhash = new Hashtable();
        Hashtable itemHash = attSetService.findAllAttItemSetDetailB0ForHash(orgID);
        for (int i = 0; i < m.length; i++) {
            String n = findFlagChara807andsum(id, day, m[i]);
            if (n != null && !"".equals(n)) {
                nhash.put(id + day + m[i], n);
                float sum = Float.parseFloat(n);
                if (sum > 0) {
                    AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) itemHash.get(m[i] + orgID);
                    if (attitemsetdetailbo != null) {
                        String w1 = attitemsetdetailbo.getFlagChar();
                        names += w1;
                    }
                }
            }
        }

        if (null == names || "".equals(names)) {
            String days = day.substring(0, 7);
            String days1 = day.substring(8, 10);
            int dayint = Integer.parseInt(days1);
            String oldClassValue1 = getA001737(id);
            AttClassBO attclassbo1 = changeWork1(id, orgID, oldClassValue1, day);
            List dList = attDataProcessService.getAllAttClassDetailBO1(attclassbo1.getClassID());
            if (attclassbo1 != null) {
                attDataProcessService.calcAttFurloughRec(id, day, attclassbo1, dList);//计算请假
                attDataProcessService.calcAttEvcctionRecBO(id, day, attclassbo1, dList);//计算出差
                attDataProcessService.calcAttOutWorkRecBO(id, day, attclassbo1, attDataProcessService.getAllAttClassDetailBO1(attclassbo1.getClassID()));//计算公出
                attDataProcessService.calcAttTimeOffRecBO(id, day, attclassbo1, dList);//计算倒休
                attDataProcessService.calcAttOverTimeLogBO(id, day);//计算加班
                for (int i = 0; i < m.length; i++) {
                    String n = (String) nhash.get(id + day + m[i]);
                    if (n != null && !"".equals(n)) {
                        float sum = Float.parseFloat(n);
                        if (sum > 0) {
                            AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) itemHash.get(m[i] + orgID);
                            if (attitemsetdetailbo != null) {
                                String w1 = attitemsetdetailbo.getFlagChar();
                                names += w1;
                            }
                        }
                    }
                }
            }

            List attencecardlists = getAttenceLogBO2(id, day);//判断打卡数据是否为空
            if (attencecardlists != null && attencecardlists.size() > 0) {
                String oldClassValue = getA001737(id);
                AttClassBO attclassbo = changeWork1(id, orgID, oldClassValue, day);
                if (attclassbo != null) {
                    DateFormat fomat = new SimpleDateFormat("yyyy-MM-dd");
                    Date d1 = fomat.parse(day);
                    String nowday = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
                    Date d2 = fomat.parse(nowday);
                    if (d1.compareTo(d2) != 0) {
                        if (attclassbo.getSectionCount() != null && !"".equals(attclassbo.getSectionCount())) {
                            int p = 0;
                            List lists = getAttCaclRuleBO(orgID);
                            if (lists != null && lists.size() > 0) {
                                AttCaclRuleBO attcaclrulebo = (AttCaclRuleBO) lists.get(0);
                                String caclLaterName = attcaclrulebo.getCaclLater();
                                String caclEarlyName = attcaclrulebo.getCaclEarly();
                                p += Integer.parseInt(caclLaterName.trim());
                                p += Integer.parseInt(caclEarlyName.trim());
                            } else {
                                p = 2;
                            }
                            int a = Integer.parseInt(attclassbo.getSectionCount()) * p;
                            if (attencecardlists.size() >= a) {
                                List w = findAllAttItemSetDetailBO("00", orgID);
                                if (w != null && w.size() > 0) {
                                    AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) w.get(0);
                                    String w1 = attitemsetdetailbo.getFlagChar();
                                    names += w1;
                                }
                            } else {
                                names += "A";
                            }
                        } else {
                            names += "";
                        }
                    }
                } else {
                    names += "";
                }
            } else {
                DateFormat fomat = new SimpleDateFormat("yyyy-MM-dd");
                Date d1 = fomat.parse(day);
                String nowday = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
                Date d2 = fomat.parse(nowday);
                if (d1.compareTo(d2) > 0) {
                    names += "B";
                } else if (d1.compareTo(d2) == 0) {
                    names += "C";
                } else {
                    names += "D";
                }
            }

        }
        return names;
    }

    public String findFlagCharIsa807(String id, String day, String m, String secondDay) throws SysException {
        String sql = "select A807" + m + " from A807 where A807" + m + " not in ('0','0.0') and A807700='" + day + "' and ID='" + id + "' and A807001='" + secondDay + "'";
        return activepageservice.queryForString(sql);
    }

    public String findFlagChara809(String id, String day, String m) throws SysException {
        String sql = "select A809" + m + " from A809 where A809" + m + " not in ('0','0.0') and A809700='" + day + "' and ID='" + id + "'";
        return activepageservice.queryForString(sql);
    }

    public String findFlagCharAttItemSetDetail(String m) throws SysException {
        String sql = "select FLAG_CHAR from ATT_ITEM_SET_DETAIL where ITEM_CODE='" + m + "'";
        return activepageservice.queryForString(sql);
    }

    public String findFlagChar1(String id, String superId, String day) throws SysException {
        String names = "";
        String str = attDataProcessService.changeWork2(id, day);
        if (str != null && !"".equals(str)) {
            if ("1".equals(str)) {
                List w = findAllAttItemSetDetailBO("01", superId);
                if (w != null && w.size() > 0) {
                    AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) w.get(0);
                    String w1 = attitemsetdetailbo.getFlagChar();
                    names += w1;
                } else {
                    names = "-";
                }
                return names;
            } else if ("str".equals(str)) {
                List w = findAllAttItemSetDetailBO("00", superId);
                if (w != null && w.size() > 0) {
                    AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) w.get(0);
                    String w1 = attitemsetdetailbo.getFlagChar();
                    names += w1;
                } else {
                    names = "-";
                }
                return names;
            }
        }

        String oldClassValue = getA001737(id);
        AttClassBO attclassbo = changeWork(superId, oldClassValue, day);
        if (attclassbo != null) {
            if ("1".equals(attclassbo.getClassID())) {
                List w = findAllAttItemSetDetailBO("01", superId);
                if (w != null && w.size() > 0) {
                    AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) w.get(0);
                    String w1 = attitemsetdetailbo.getFlagChar();
                    names += w1;
                } else {
                    names = "-";
                }
                return names;
            } else if ("2".equals(attclassbo.getClassID())) {
                List w = findAllAttItemSetDetailBO("01", superId);
                if (w != null && w.size() > 0) {
                    AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) w.get(0);
                    String w1 = attitemsetdetailbo.getFlagChar();
                    names += w1;
                } else {
                    names = "-";
                }
                return names;
            } else if ("3".equals(attclassbo.getClassID())) {
                List w = findAllAttItemSetDetailBO("01", superId);
                if (w != null && w.size() > 0) {
                    AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) w.get(0);
                    String w1 = attitemsetdetailbo.getFlagChar();
                    names += w1;
                } else {
                    names = "-";
                }
                return names;
            }
        } else {
            List w = findAllAttItemSetDetailBO("01", superId);
            if (w != null && w.size() > 0) {
                AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) w.get(0);
                String w1 = attitemsetdetailbo.getFlagChar();
                names += w1;
            } else {
                names = "-";
            }
            return names;
        }


        String[] m = {"704", "705", "706", "707", "708", "709", "710", "711", "712", "713", "714", "715"};
        List lists = attDataProcessService.findA807(id, day);
        if (lists != null && lists.size() > 0) {
            String names1 = "";
            for (int i = 0; i < lists.size(); i++) {
                AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) lists.get(i);
                for (int j = 0; j < m.length; j++) {
                    String n = findFlagChara807(day, attenceseconddaylogbo.getSecondDay(), m[j]);
                    if (n != null && !"".equals(n)) {
                        List w = findAllAttItemSetDetailBO(m[j], superId);
                        if (w != null && w.size() > 0) {
                            AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) w.get(0);
                            String w1 = attitemsetdetailbo.getFlagChar();
                            names1 = w1;
                        } else {
                            names1 = "-";
                        }
                    }
                }
                names = names1;
            }
        }

        if (names != null && !"".equals(names)) {

        } else {
            List w = findAllAttItemSetDetailBO("00", superId);
            if (w != null && w.size() > 0) {
                AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) w.get(0);
                String w1 = attitemsetdetailbo.getFlagChar();
                names += w1;
            } else {
                names = "-";
            }
        }
        return names;
    }

    public String findFlagChara807(String day, String secondday, String m) throws SysException {
        String sql = "select A807" + m + " from A807 where A807" + m + " not in ('0','0.0') and A807700='" + day + "' and A807001='" + secondday + "'";
        return activepageservice.queryForString(sql);
    }

    public List getCaclDay(String beginTime, String endTime) throws SysException {
        List lists = new ArrayList();
        String beginyear = beginTime.substring(0, 4);
        String beginmonth = beginTime.substring(5, 7);
        String beginday = beginTime.substring(8, 10);
        String beginday1 = beginTime.substring(8, 9);
        String beginday2 = beginTime.substring(9, 10);
        String endTimeyear = endTime.substring(0, 4);
        String endTimemonth = endTime.substring(5, 7);
        String endTimeday = endTime.substring(8, 10);
        String endTimeday1 = endTime.substring(8, 9);
        String endTimeday2 = endTime.substring(9, 10);
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

    public static Date getdate(String date) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.parse(date);
    }

    public String getWeek(String day) throws Exception {
        String weekname = "";
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(getdate(day));
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        weekname = dayNames[dayOfWeek - 1];
        return weekname;
    }

    public String selectA810707(String personID, String day) throws SysException {
        String sql = "select A810707  from a810 where ID='" + personID + "' and A810700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String selectA810708(String personID, String day) throws SysException {
        String sql = "select A810708  from a810 where ID='" + personID + "' and A810700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String selectA810709(String personID, String day) throws SysException {
        String sql = "select A810709  from a810 where ID='" + personID + "' and A810700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String selectA810710(String personID, String day) throws SysException {
        String sql = "select A810710  from a810 where ID='" + personID + "' and A810700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String selectA810711(String personID, String day) throws SysException {
        String sql = "select A810711  from a810 where ID='" + personID + "' and A810700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String selectA810712(String personID, String day) throws SysException {
        String sql = "select A810712  from a810 where ID='" + personID + "' and A810700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String selectA810713(String personID, String day) throws SysException {
        String sql = "select A810713  from a810 where ID='" + personID + "' and A810700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String selectA810714(String personID, String day) throws SysException {
        String sql = "select A810714  from a810 where ID='" + personID + "' and A810700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String selectA810715(String personID, String day) throws SysException {
        String sql = "select A810715  from a810 where ID='" + personID + "' and A810700='" + day + "'";
        return activepageservice.queryForString(sql);
    }

    public String selectA810(String personID, String day) throws SysException {
        String a1 = "a";
        String a2 = "a";
        String a3 = "a";
        String a4 = "a";
        String a5 = "a";
        String a6 = "a";
        String a7 = "a";
        String a8 = "a";
        String a9 = "a";
        String b1 = selectA810707(personID, day);
        if (b1 != null && !"".equals(b1)) {
            a1 = b1;
        }
        String b2 = selectA810708(personID, day);
        if (b2 != null && !"".equals(b2)) {
            a2 = b2;
        }
        String b3 = selectA810709(personID, day);
        if (b3 != null && !"".equals(b3)) {
            a3 = b3;
        }
        String b4 = selectA810710(personID, day);
        if (b4 != null && !"".equals(b4)) {
            a4 = b4;
        }
        String b5 = selectA810711(personID, day);
        if (b5 != null && !"".equals(b5)) {
            a5 = b5;
        }
        String b6 = selectA810712(personID, day);
        if (b6 != null && !"".equals(b6)) {
            a6 = b6;
        }
        String b7 = selectA810713(personID, day);
        if (b7 != null && !"".equals(b7)) {
            a7 = b7;
        }
        String b8 = selectA810714(personID, day);
        if (b8 != null && !"".equals(b8)) {
            a8 = b8;
        }
        String b9 = selectA810715(personID, day);
        if (b9 != null && !"".equals(b9)) {
            a9 = b9;
        }
        String name = a1 + "," + a2 + "," + a3 + "," + a4 + "," + a5 + "," + a6 + "," + a7 + "," + a8 + "," + a9;
        return name;
    }

    //浏览加班
    public void saveorupdateAttOverTimeLogBO(AttOverTimeLogBO bo) throws SysException {
        attSetService.saveorupdateAttOverTimeLogBO(bo);
    }

    public List getAllAttOverTimeLogBO(String name, String beginTime, String superId, PageVO mypage)
            throws SysException {
        return attSetService.getAllAttOverTimeLogBO(name, beginTime, superId, mypage);
    }

    //网上申请天数的自动计算
    public String cacldays(String id, String day, AttClassBO b) throws Exception {
        return attDataProcessService.cacldays(id, day, b);
    }

    public String cacldays1(String id, String day, AttClassBO b) throws Exception {
        return attDataProcessService.cacldays1(id, day, b);
    }

    public void deleteAttenceLogBO(String orgId, String beginDate, String endDate, String name)
            throws SysException {
        String hsql = "delete from A808 where ID in ";
        if (name != null && !"".equals(name)) {
            hsql += "(select ID from A001  where  A001001 like '%" + name + "%' or A001735 like '%" + name + "%' or A001002 like '%" + name + "%' or A001999 like '%" + name + "%')";
        } else {
            hsql += "(select ID from A001 where  A001701 like '" + orgId + "' or A001705 like '" + orgId + "') ";
        }

        if (beginDate != null && !"".equals(beginDate)) {
            hsql += "  and A808700>='" + beginDate + "'";
        }

        if (endDate != null && !"".equals(endDate)) {
            hsql += "  and A808700<='" + endDate + "'";
        }

        activepageservice.executeSql(hsql);

    }

    public List getAttClassGroupVO(PageVO mypage, String orgId, String personType) throws SysException {
        return attSetService.getAttClassGroupVO(mypage, orgId, personType);
    }

    //自动排班
    public List getAllAttenceStandBO(PageVO mypage) throws SysException {
        return attSetService.getAllAttenceStandBO(mypage);
    }

    public List getAllAttenceStandBO(PageVO mypage, String orgId) throws SysException {
        return attSetService.getAllAttenceStandBO(mypage, orgId);
    }

    public List getAllAttenceWaterBO(PageVO mypage, String date) throws SysException {
        return attSetService.getAllAttenceWaterBO(mypage, date);
    }

    public List getAllAttenceWeekWaterBO(PageVO mypage, String date) throws SysException {
        return attSetService.getAllAttenceWeekWaterBO(mypage, date);
    }

    public List getAllAttenceWaterBO(PageVO mypage, String date, String orgId) throws SysException {
        return attSetService.getAllAttenceWaterBO(mypage, date, orgId);
    }

    public List getAllAttenceWeekWaterBO(PageVO mypage, String date, String orgId) throws SysException {
        return attSetService.getAllAttenceWeekWaterBO(mypage, date, orgId);
    }

    public void saveorupdateAttenceStandBO(AttenceStandBO bo) throws SysException {
        attSetService.saveorupdateAttenceStandBO(bo);
    }

    public void saveorupdateAttenceWaterBO(AttenceWaterBO bo) throws SysException {
        attSetService.saveorupdateAttenceWaterBO(bo);
    }

    public void saveorupdateAttenceWeekWaterBO(AttenceWeekWaterBO bo) throws SysException {
        attSetService.saveorupdateAttenceWeekWaterBO(bo);
    }

    public List findAttenceStandBO(String subId, String orgId) throws SysException {
        return attSetService.findAttenceStandBO(subId, orgId);
    }

    public List findAttenceWaterBO(String subId, String orgId) throws SysException {
        return attSetService.findAttenceWaterBO(subId, orgId);
    }

    public List findAttenceWeekWaterBO(String subId, String orgId) throws SysException {
        return attSetService.findAttenceWeekWaterBO(subId, orgId);
    }

    public void UpdateB737(String orgId)
            throws SysException {
        String updateSQL = "update B737 set B737000='00900' where ORGUID='" + orgId + "'";
        activepageservice.executeSql(updateSQL);
    }

    public void UpdateB738(String orgId, String day)
            throws SysException {
        String updateSQL = "update B738 set B738000='00900' where ORGUID='" + orgId + "' and B738700='" + day + "'";
        activepageservice.executeSql(updateSQL);
    }

    public void UpdateB739(String orgId, String day, String weekday)
            throws SysException {
        String updateSQL = "update B739 set B739000='00900' where ORGUID='" + orgId + "' and B739700='" + day + "' and B739701='" + weekday + "'";
        activepageservice.executeSql(updateSQL);
    }

    public String selectB737(String orgId)
            throws SysException {
        String selecctSQL = "select B737700 from B737 where ORGUID='" + orgId + "' and B737000='00901'";
        return activepageservice.queryForString(selecctSQL);
    }

    public List findAttenceStandBO2(String orgId) throws SysException {
        return attSetService.findAttenceStandBO2(orgId);
    }

    public List findAttenceStandBO1(String orgId) throws SysException {
        return attSetService.findAttenceStandBO1(orgId);
    }

    public List findAttenceWaterBO1(String orgId, String date) throws SysException {
        return attSetService.findAttenceWaterBO1(orgId, date);
    }

    public List findAttenceWaterBO2(String orgId, String date) throws SysException {
        return attSetService.findAttenceWaterBO2(orgId, date);
    }

    public List findAttenceWaterBO3(String orgId, String date) throws SysException {
        return attSetService.findAttenceWaterBO3(orgId, date);
    }

    public List findAttenceWeekWaterBO1(String orgId, String date, String weekdate) throws SysException {
        return attSetService.findAttenceWeekWaterBO1(orgId, date, weekdate);
    }

    public List getAllAttPersonArrangeBO(PageVO mypage, String superId) throws SysException {
        return attSetService.getAllAttPersonArrangeBO(mypage, superId);
    }

    public List findAttPersonArrangeBO(String orgId) throws SysException {
        return attSetService.findAttPersonArrangeBO(orgId);
    }

    public void saveorupdateAttPersonArrangeBO(AttPersonArrangeBO bo) throws SysException {
        attSetService.saveorupdateAttPersonArrangeBO(bo);
    }

    public List findGroupValues(String orgId) throws SysException {
        return attSetService.findGroupValues(orgId);
    }

    public AttPersonArrangeBO findAttPersonArrangeBObyId(String id) throws SysException {
        return attSetService.findAttPersonArrangeBObyId(id);
    }

    public List findPersonsAttClassGroupVO(String groupId) throws SysException {
        return attSetService.findPersonsAttClassGroupVO(groupId);
    }

    public List findPersonsAttClassGroupVO(String groupId, String deptId) throws SysException {
        return attSetService.findPersonsAttClassGroupVO(groupId, deptId);
    }

    public String selectB738(String orgId, String day) throws SysException {
        String selecctSQL = "select B738701 from B738 where ORGUID='" + orgId + "' and B738700='" + day + "' and B738000='00901'";
        return activepageservice.queryForString(selecctSQL);
    }

    public String selectB739(String orgId, String day, String weekday) throws SysException {
        String selecctSQL = "select B739701 from B739 where ORGUID='" + orgId + "' and B739700='" + day + "' and B739000='00901' and B739701='" + weekday + "'";
        return activepageservice.queryForString(selecctSQL);
    }

    public void saveorupdateAttPersonArrangeItemBO(AttPersonArrangeItemBO bo) throws SysException {
        attSetService.saveorupdateAttPersonArrangeItemBO(bo);
    }

    public String countAttPersonArrangeItemBO(String arrangeId, String day) throws SysException {
        String sql = "select count(PERSON_ID) from ATT_PERSON_ARRANGE_ITEM  where ARRANGE_ID='" + arrangeId + "' and CREATE_DAY='" + day + "' and LINK_CLASS<>'1'";
        return activepageservice.queryForString(sql);
    }

    public String countAttPersonArrangeItemBO1(String arrangeId, String day) throws SysException {
        String sql = "select count(PERSON_ID) from ATT_PERSON_ARRANGE_ITEM  where ARRANGE_ID='" + arrangeId + "' and CREATE_DAY='" + day + "' and LINK_CLASS='1'";
        return activepageservice.queryForString(sql);
    }

    public String countAttPersonArrangeItemBO3(String arrangeId, String day, String orgId) throws SysException {
        String sql = "select count(PERSON_ID) from ATT_PERSON_ARRANGE_ITEM  where ARRANGE_ID='" + arrangeId + "' and CREATE_DAY='" + day + "' and LINK_CLASS<>'1' and PERSON_ID in (select a.id from a001 a where a.a001705='" + orgId + "')";
        return activepageservice.queryForString(sql);
    }

    public String countAttPersonArrangeItemBO4(String arrangeId, String day, String orgId) throws SysException {
        String sql = "select count(PERSON_ID) from ATT_PERSON_ARRANGE_ITEM  where ARRANGE_ID='" + arrangeId + "' and CREATE_DAY='" + day + "' and LINK_CLASS='1' and PERSON_ID in (select a.id from a001 a where a.a001705='" + orgId + "')";
        return activepageservice.queryForString(sql);
    }

    public List getAllAttPersonArrangeItemBO(String arrangeId, String createDay) throws SysException {
        return attSetService.getAllAttPersonArrangeItemBO(arrangeId, createDay);
    }

    public List getAllAttPersonArrangeItemBO(String arrangeId, String createDay, String deptId) throws SysException {
        return attSetService.getAllAttPersonArrangeItemBO(arrangeId, createDay, deptId);
    }

    public List getAllAttPersonArrangeItemBO1(String arrangeId, String createDay) throws SysException {
        return attSetService.getAllAttPersonArrangeItemBO1(arrangeId, createDay);
    }

    public List getAllAttPersonArrangeItemBO1(String arrangeId, String createDay, String deptId) throws SysException {
        return attSetService.getAllAttPersonArrangeItemBO1(arrangeId, createDay, deptId);
    }

    public AttPersonArrangeItemBO findAttPersonArrangeItemBObyId(String id) throws SysException {
        return attSetService.findAttPersonArrangeItemBObyId(id);
    }

    public String countAttPersonArrangeItemBOEfficiency(String arrangeId) throws SysException {
        String sql = "select count(PERSON_ID) from ATT_PERSON_ARRANGE_ITEM  where ARRANGE_ID='" + arrangeId + "'";
        return activepageservice.queryForString(sql);
    }

    public String countAttPersonArrangeItemBOEfficiency1(String arrangeId) throws SysException {
        String sql = "select count(PERSON_ID) from ATT_PERSON_ARRANGE_ITEM  where ARRANGE_ID='" + arrangeId + "' and LINK_CLASS<>'1'";
        return activepageservice.queryForString(sql);
    }

    //存休
    public List findAttExistRestBO(String personId, String date) throws SysException {
        return attSetService.findAttExistRestBO(personId, date);
    }

    public int caclFeast(List daylists, String orgId) throws SysException {
        return attSetService.caclFeast(daylists, orgId);
    }

    public void caclRest(List personGroupLists, AttPersonArrangeBO attpersonarrangebo, int sum) throws SysException {
        attSetService.caclRest(personGroupLists, attpersonarrangebo, sum);
    }

    public String workflow(String linkId) throws SysException {
        String sql = "select PROCESS_STATUS from WF_PROCESS  where LINK_ID='" + linkId + "'";
        return activepageservice.queryForString(sql);
    }

    public boolean weekCalendar(String orguid, String day) throws Exception {
        return attSetService.weekCalendar(orguid, day);
    }

    public boolean weekFeast(String orguid, String day) throws Exception {
        return attSetService.weekFeast(orguid, day);
    }

    //倒休
    public void saveorupdateAttTimeOffRecBO(AttTimeOffRecBO bo) throws SysException {
        attSetService.saveorupdateAttTimeOffRecBO(bo);
    }

    public AttTimeOffRecBO findAttTimeOffRecBObyId(String id) throws SysException {
        return attSetService.findAttTimeOffRecBObyId(id);
    }

    public List findAttTimeOffRecBO(String overTimeNO) throws SysException {
        return attSetService.findAttTimeOffRecBO(overTimeNO);
    }

    public List findAttTimeOffRecBO(String personId, String overTimeNO) throws SysException {
        return attSetService.findAttTimeOffRecBO(personId, overTimeNO);
    }

    public List findAttTimeOffRecBO1(String personId, String overTimeNO) throws SysException {
        return attSetService.findAttTimeOffRecBO1(personId, overTimeNO);
    }

    public void deleteAttTimeOffRecBO(String overTimeNO) throws SysException {
        String sql = "delete from ATT_TIME_OFF_REC where OVER_TIME_NO='" + overTimeNO + "'";
        activepageservice.executeSql(sql);
    }

    public void deleteAttTimeOffRecBO1(String personId, String overTimeNO) throws SysException {
        String sql = "delete from ATT_TIME_OFF_REC where PERSON_ID='" + personId + "' and OVER_TIME_NO='" + overTimeNO + "' and STATUS_VALUE='3'";
        activepageservice.executeSql(sql);
    }

    public void deleteAttTimeOffRecBO2(String personId, String overTimeNO) throws SysException {
        String sql = "delete from ATT_TIME_OFF_REC where PERSON_ID='" + personId + "' and OVER_TIME_NO='" + overTimeNO + "' and STATUS_VALUE<>'3'";
        activepageservice.executeSql(sql);
    }

    public String calcpersongroup(String orgId, List daylists, List flagcharlists, String yearValueCale, String monthValueCale, String beginTime, String endTime, boolean isMon, boolean isExist, String perIdsValue) throws Exception {
        return attDataProcessService.calcpersongroup(orgId, daylists, flagcharlists, yearValueCale, monthValueCale, beginTime, endTime, isMon, isExist, perIdsValue);
    }

    public List getEvcctionStateSearch(String orgId, PageVO mypage)
            throws SysException {
        return attSetService.getEvcctionStateSearch(orgId, mypage);
    }

    //年假拟报
    public List getAttMimicReportRecBO(String personId, PageVO mypage,
                                       boolean isExist) throws SysException {
        return attSetService.getAttMimicReportRecBO(personId, mypage, isExist);
    }

    public List findAttAnnualRecordBO(String orgid)
            throws SysException {
        return attSetService.findAttAnnualRecordBO(orgid);
    }

    public List findAttAnnualItemBO(String recID, String personId)
            throws SysException {
        return attSetService.findAttAnnualItemBO(recID, personId);
    }

    public void saveAttMimicReportRecBO(AttMimicReportRecBO bo) throws SysException {
        attSetService.saveAttMimicReportRecBO(bo);
    }

    public AttMimicReportRecBO findAttMimicReportRecBObyId(String id) throws SysException {
        return attSetService.findAttMimicReportRecBObyId(id);
    }

    public void deleteAttMimicReportRecBO(String id) throws SysException {
        attSetService.deleteAttMimicReportRecBO(id);
    }

    public List findAttOverTimeRecBO(String personId, PageVO mypage, boolean isExist, String operID, String deptID, User user) throws SysException {
        return attSetService.findAttOverTimeRecBO(personId, mypage, isExist, operID, deptID, user);
    }

    public void UpdateAttenceDayMonthBO1(String orgId, String ym)
            throws SysException {
        String updateSQL = "update A810 set A810000='00901' where A810700='" + ym + "' and id in (select id from A001 where A001701='" + orgId + "' or A001705='" + orgId + "')";
        activepageservice.executeSql(updateSQL);
    }

    public void UpdateAttenceDayMonthBO2(String orgId, String ym)
            throws SysException {
        String updateSQL = "update A810 set A810000='00900' where A810700<>'" + ym + "' and id in (select id from A001 where A001701='" + orgId + "' or A001705='" + orgId + "')";
        activepageservice.executeSql(updateSQL);
    }

    public List findAttOverTimeLogBO(String personId, String date)
            throws SysException {
        return attSetService.findAttOverTimeLogBO(personId, date);
    }

    public List getAllAttManagerArrangeBO(PageVO mypage, String superId) throws SysException {
        return attSetService.getAllAttManagerArrangeBO(mypage, superId);
    }

    public List findAttManagerArrangeBO(String orgId) throws SysException {
        return attSetService.findAttManagerArrangeBO(orgId);
    }

    public void saveorupdateAttManagerArrangeBO(AttManagerArrangeBO bo) throws SysException {
        attSetService.saveorupdateAttManagerArrangeBO(bo);
    }

    public List getAllAttManagerArgumentBO(PageVO mypage, String superId) throws SysException {
        return attSetService.getAllAttManagerArgumentBO(mypage, superId);
    }

    public void saveorupdateAttManagerArgumentBO(AttManagerArgumentBO bo) throws SysException {
        attSetService.saveorupdateAttManagerArgumentBO(bo);
    }

    public List getAllAttManagerArgumentBO(String superId) throws SysException {
        return attSetService.getAllAttManagerArgumentBO(superId);
    }

    public List getAllAttManagerArgumentBO1(String deptId) throws SysException {
        return attSetService.getAllAttManagerArgumentBO1(deptId);
    }

    public List getAllAttPersonArrangeItemBO2(String arrangeId, String deptId) throws SysException {
        return attSetService.getAllAttPersonArrangeItemBO2(arrangeId, deptId);
    }

    public void deleteAttPersonArrangeItemBO(String amaId, String deptId) throws SysException {
        String sql = "delete from ATT_PERSON_ARRANGE_ITEM where ARRANGE_ID='" + amaId + "' and PERSON_ID in (select a.id from a001 a where a.a001705='" + deptId + "')";
        activepageservice.executeSql(sql);
    }

    public AttManagerArrangeBO findAttManagerArrangeBObyId(String id) throws SysException {
        return attSetService.findAttManagerArrangeBObyId(id);
    }

    public List findAttManagerArgumentBO(String deptId) throws SysException {
        return attSetService.findAttManagerArgumentBO(deptId);
    }

    public void deleteAttManagerArgumentBO(String id) throws SysException {
        attSetService.deleteAttManagerArgumentBO(id);
    }

    public AttManagerArgumentBO findAttManagerArgumentBObyId(String id) throws SysException {
        return attSetService.findAttManagerArgumentBObyId(id);
    }

    public List findCountAttPersonArrangeItemBO1(String arrangeId, String day, String orgId) throws SysException {
        return attSetService.findCountAttPersonArrangeItemBO1(arrangeId, day, orgId);
    }

    public List findCountAttPersonArrangeItemBO2(String arrangeId, String day, String orgId) throws SysException {
        return attSetService.findCountAttPersonArrangeItemBO2(arrangeId, day, orgId);
    }

    public List getAllAttTimeOffRecBO(PageVO mypage, String overTimeNO) throws SysException {
        return attSetService.getAllAttTimeOffRecBO(mypage, overTimeNO);
    }

    public List getAllAttTimeOffRecBO(String overTimeNO) throws SysException {
        return attSetService.getAllAttTimeOffRecBO(overTimeNO);
    }

    public void deleteAttImportLogBO(String id) throws SysException {
        attSetService.deleteAttImportLogBO(id);
    }

    public void saveAttOutWorkCollectBO(AttOutWorkCollectBO bo) throws SysException {
        attSetService.saveAttOutWorkCollectBO(bo);
    }

    public void saveAttEvcctionRecCollectBO(AttEvcctionRecCollectBO bo) throws SysException {
        attSetService.saveAttEvcctionRecCollectBO(bo);
    }

    public List getAllAttAnnualDetailAuditBO(PageVO mypage, String furloughNO) throws SysException {
        return attSetService.getAllAttAnnualDetailAuditBO(mypage, furloughNO);
    }

    public List getAllAttAnnualDetailAuditBO(String furloughNO) throws SysException {
        return attSetService.getAllAttAnnualDetailAuditBO(furloughNO);
    }

    public String getFlowProcess(String pid, String judgeFun, String type) throws SysException {
        return wfservice.getFlowProcess(pid, judgeFun, type);
    }

    public List findAttModifyTimeOffList(String name, String beginTime, String superId, PageVO mypage)
            throws SysException {
        return attSetService.findAttModifyTimeOffList(name, beginTime, superId, mypage);
    }

	public void deleteAllByList(List list) throws SysException {
		attSetService.deleteAllByList(list);
	}

	public List getAllAttClassUserList(String classId, String userType) throws SysException {
		return attSetService.getAllAttClassUserList(classId, userType);
	}
	public void deleteAttClassUserBO(AttClassUserBO user) throws SysException {
		attSetService.deleteAttClassUserBO(user);
	}
	
	public void saveAttClassUserBO(AttClassUserBO user) throws SysException {
		attSetService.saveAttClassUserBO(user);
	}

	public String readSign(String orgID) throws SysException {
		return null;
	}
    
	public List getSelfSignInfo(String userID, String date) throws SysException {
		return this.attDataCaclService.getSelfSignInfo(userID, date);
	}
}
