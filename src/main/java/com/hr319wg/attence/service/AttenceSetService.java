package com.hr319wg.attence.service;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import org.apache.log4j.Logger;

import com.hr319wg.attence.dao.AttCaclInfoDAO;
import com.hr319wg.attence.dao.AttDurationDAO;
import com.hr319wg.attence.dao.AttFeastDAO;
import com.hr319wg.attence.dao.AttMachineMgrChildDAO;
import com.hr319wg.attence.dao.AttPersonServiceDAO;
import com.hr319wg.attence.dao.AttRestWeekDAO;
import com.hr319wg.attence.dao.CardMessageDAO;
import com.hr319wg.attence.dao.FileImportDAO;
import com.hr319wg.attence.dao.GroupMgrDAO;
import com.hr319wg.attence.pojo.bo.ATTRearrangeBO;
import com.hr319wg.attence.pojo.bo.ATTRearrangeDateBO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailAuditBO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
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
import com.hr319wg.attence.pojo.bo.AttExistRestBO;
import com.hr319wg.attence.pojo.bo.AttFeastBO;
import com.hr319wg.attence.pojo.bo.AttFileImportBO;
import com.hr319wg.attence.pojo.bo.AttFileImportItemBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttImportLogBO;
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
import com.hr319wg.ccp.pojo.bo.PartyBO;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.dao.QueryConditionDAO;
import com.hr319wg.qry.dao.QueryDAO;
import com.hr319wg.qry.dao.QueryItemDAO;
import com.hr319wg.qry.dao.QueryStaticDAO;
import com.hr319wg.qry.pojo.bo.QueryBO;
import com.hr319wg.qry.pojo.bo.QueryConditionBO;
import com.hr319wg.qry.pojo.bo.QueryItemBO;
import com.hr319wg.qry.pojo.bo.QueryStaticBO;
import com.hr319wg.qry.pojo.vo.QueryVO;
import com.hr319wg.qry.pojo.vo.StaticVO;
import com.hr319wg.qry.util.Criteria;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.WFProcessBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class AttenceSetService {
    private AttPersonServiceDAO attPersonServiceDAO;
    static Logger log;
    private QueryStaticDAO staticdao;
    private QueryConditionDAO conditiondao;
    private QueryDAO querydao;
    private QueryItemDAO itemdao;
    private ActivePageAPI activeapi;
    private AttCaclInfoDAO attCaclinfoDAO;
    private CardMessageDAO cardMessageDAO;
    private FileImportDAO fileImportDAO;
    private GroupMgrDAO groupMgrDAO;
    private AttDurationDAO attenceSetDAO;
    private AttFeastDAO attFeastDAO;
    private AttRestWeekDAO attRestWeekDAO;
    private AttMachineMgrChildDAO attmachinedao;
    public final static String dayNames[] = {"sun", "mon", "tues", "wed",
            "thur", "fri", "sat"};

    public AttPersonServiceDAO getAttPersonServiceDAO() {
        return attPersonServiceDAO;
    }

    public void setAttPersonServiceDAO(AttPersonServiceDAO attPersonServiceDAO) {
        this.attPersonServiceDAO = attPersonServiceDAO;
    }

    public QueryStaticDAO getStaticdao() {
        return staticdao;
    }

    public void setStaticdao(QueryStaticDAO staticdao) {
        this.staticdao = staticdao;
    }

    public QueryConditionDAO getConditiondao() {
        return conditiondao;
    }

    public void setConditiondao(QueryConditionDAO conditiondao) {
        this.conditiondao = conditiondao;
    }

    public QueryDAO getQuerydao() {
        return querydao;
    }

    public void setQuerydao(QueryDAO querydao) {
        this.querydao = querydao;
    }

    public QueryItemDAO getItemdao() {
        return itemdao;
    }

    public void setItemdao(QueryItemDAO itemdao) {
        this.itemdao = itemdao;
    }

    public ActivePageAPI getActiveapi() {
        return activeapi;
    }

    public void setActiveapi(ActivePageAPI activeapi) {
        this.activeapi = activeapi;
    }

    public AttCaclInfoDAO getAttCaclinfoDAO() {
        return attCaclinfoDAO;
    }

    public void setAttCaclinfoDAO(AttCaclInfoDAO attCaclinfoDAO) {
        this.attCaclinfoDAO = attCaclinfoDAO;
    }

    public CardMessageDAO getCardMessageDAO() {
        return cardMessageDAO;
    }

    public void setCardMessageDAO(CardMessageDAO cardMessageDAO) {
        this.cardMessageDAO = cardMessageDAO;
    }

    public FileImportDAO getFileImportDAO() {
        return fileImportDAO;
    }

    public void setFileImportDAO(FileImportDAO fileImportDAO) {
        this.fileImportDAO = fileImportDAO;
    }

    public GroupMgrDAO getGroupMgrDAO() {
        return groupMgrDAO;
    }

    public void setGroupMgrDAO(GroupMgrDAO groupMgrDAO) {
        this.groupMgrDAO = groupMgrDAO;
    }

    public AttDurationDAO getAttenceSetDAO() {
        return attenceSetDAO;
    }

    public void setAttenceSetDAO(AttDurationDAO attenceSetDAO) {
        this.attenceSetDAO = attenceSetDAO;
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

    public AttMachineMgrChildDAO getAttmachinedao() {
        return attmachinedao;
    }

    public void setAttmachinedao(AttMachineMgrChildDAO attmachinedao) {
        this.attmachinedao = attmachinedao;
    }

    public List getAllAttenceSet(PageVO pagevo,  User user)
            throws SysException {
        return attenceSetDAO.getAllAttenceSet(pagevo, user);
    }

    public List getAllAttenceSet1(String orgid, String y, String m)
            throws SysException {
        return attenceSetDAO.getAllAttenceSet1(orgid, y, m);
    }

    public List getAttClassGroupVO1(String orgid) throws SysException {
        return attenceSetDAO.getAttClassGroupVO1(orgid);
    }

    public List getAllAttDurationBOS() throws SysException {
        return attenceSetDAO.getAllAttDurationBOS();
    }

    public void saveorupdateAttenceSet(AttDurationBO bo) throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public AttDurationBO findAttenceSetBObyId(String id) throws SysException {
        return (AttDurationBO) attenceSetDAO
                .findBoById(AttDurationBO.class, id);
    }

    public void deleteAttenceSetBO(String id) throws SysException {
        
      //清除本次计算的结果
      		AttDurationBO bo=(AttDurationBO)this.attenceSetDAO.findBoById(AttDurationBO.class, id);
      		String yearMonth="";
      		if(bo!=null){
      			yearMonth=bo.getDuraYear()+"-"+bo.getDuraMonth();
      			if(("2".equals(bo.getStatus())||"1".equals(bo.getStatus()))){
          			String sql="delete from a245 a where a.a245200='"+yearMonth+"'";
          			this.activeapi.executeSql(sql);
          			sql="delete from a810 a where a.a810700='"+yearMonth+"'";
          			this.activeapi.executeSql(sql);
          		}
      		}
      		attenceSetDAO.deleteBo(AttDurationBO.class, id);
    }

    public List getAllAttDurationBO(User user) throws SysException {
        return attenceSetDAO.getAllAttDurationBO(user);
    }

    // 公休日管理
    public AttRestOfWeekBO findAttRestOfWeekBObyId(String id)
            throws SysException {
        return (AttRestOfWeekBO) attRestWeekDAO.findBoById(
                AttRestOfWeekBO.class, id);
    }

    public void saveorupdateAttRestOfWeek(AttRestOfWeekBO bo)
            throws SysException {
        attRestWeekDAO.saveOrUpdateBo(bo);
    }

    public void saveAttRestOfWeek(AttRestOfWeekBO bo) throws SysException {
        attRestWeekDAO.createBo(bo);
    }

    // 节假日管理
    public List getAllAttFeast(PageVO pagevo, String orgid) throws SysException {
        return attFeastDAO.getAllAttFeast(pagevo, orgid);
    }

    public List getAllAttWorkDate(String feastID, String orgid)
            throws SysException {
        return attFeastDAO.getAllAttWorkDate(feastID, orgid);
    }

    public void saveorupdateAttFeast(AttFeastBO bo) throws SysException {
        attFeastDAO.saveOrUpdateBo(bo);
    }

    public AttFeastBO findAttFeastBObyId(String id) throws SysException {
        return (AttFeastBO) attFeastDAO.findBoById(AttFeastBO.class, id);
    }

    public void deleteAttFeastBO(String id) throws SysException {
        attFeastDAO.deleteBo(AttFeastBO.class, id);
    }

    public void deleteAttWorkDateBO(String id) throws SysException {
        attFeastDAO.deleteBo(AttWorkDateBO.class, id);
    }

    public AttWorkDateBO findAttWorkDateBObyId(String id) throws SysException {
        return (AttWorkDateBO) attFeastDAO.findBoById(AttWorkDateBO.class, id);
    }

    public void saveorupdateAttWorkDate(AttWorkDateBO bo) throws SysException {
        attFeastDAO.saveOrUpdateBo(bo);
    }

    // 考勤机管理
    public List findAllAttMachine() throws SysException {
        return attmachinedao.findAllAttMachine();
    }

    public List getAllAttMachine(PageVO pagevo, String orgid)
            throws SysException {
        return attmachinedao.getAllAttMachine(pagevo, orgid);
    }

    public void saveorupdateAttMachine(attMachineBO bo) throws SysException {
        attmachinedao.saveOrUpdateBo(bo);
    }

    public attMachineBO findBobyId(String id) throws SysException {
        return (attMachineBO) attmachinedao.findBoById(attMachineBO.class, id);
    }

    public void deleteAttMachine(String id) throws SysException {
        attmachinedao.deleteBo(attMachineBO.class, id);
    }

    // 考勤卡管理
    public void saveAttCard(AttCardBO bo) throws SysException {
        attenceSetDAO.createBo(bo);
    }

    public List getAllAttCardBO(PageVO pagevo, String status, String superId)
            throws SysException {
        return attenceSetDAO.getAllAttCardBO(pagevo, status, superId);
    }

    public void deleteAttCardBO(String id) throws SysException {
        attenceSetDAO.deleteBo(AttCardBO.class, id);
    }

    // 班次设置
    public List getAllAttClassBO(PageVO pagevo, String orgid)
            throws SysException {
        return attenceSetDAO.getAllAttClassBO(pagevo, orgid);
    }

    public List getAttClassBO(String className) throws SysException {
        return attenceSetDAO.getAttClassBO(className);
    }

    public void saveAttClassBO(AttClassBO bo) throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public AttClassBO findAttClassBObyId(String id) throws SysException {
        return (AttClassBO) attenceSetDAO.findBoById(AttClassBO.class, id);
    }

    /**
     * 判断班次是否使用中
     * @param id
     * @return
     * @throws SysException
     */
    public boolean checkAttClassIsUse(String id)throws SysException{
        String sql="select count(groupno) from att_classgroup where link_class='"+id+"'";
        return this.activeapi.queryForInt(sql)>0;
    }

    public void deleteAttClassBO(AttClassBO bo) throws SysException {
        attenceSetDAO.deleteBo(AttClassBO.class, bo.getClassID());
    }

    public List getAllAttClassDetailBOS(String classID) throws SysException {
        return attenceSetDAO.getAllAttClassDetailBOS(classID);
    }

    public List getAllAttClassDetailBO(PageVO pagevo, String classID)
            throws SysException {
        return attenceSetDAO.getAllAttClassDetailBO(pagevo, classID);
    }

    public void saveAttClassDetailBO(AttClassDetailBO bo) throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public void deleteAttClassDetailBO(AttClassDetailBO bo) throws SysException {
        attenceSetDAO.deleteBo(AttClassDetailBO.class, bo.getItemID());
    }

    public AttClassDetailBO findAttClassDetailBObyId(String id)
            throws SysException {
        return (AttClassDetailBO) attenceSetDAO.findBoById(
                AttClassDetailBO.class, id);
    }

    public List getAllAttClassDetailBO1(String classID) throws SysException {
        return attenceSetDAO.getAllAttClassDetailBO1(classID);
    }

    public List getAllAttClassDetailBO2(String classID) throws SysException {
        return attenceSetDAO.getAllAttClassDetailBO2(classID);
    }

    public List getAllAttClassDetailBO3(String classID) throws SysException {
        return attenceSetDAO.getAllAttClassDetailBO3(classID);
    }

    public List getAllAttClassDetailBO4(String classID) throws SysException {
        return attenceSetDAO.getAllAttClassDetailBO4(classID);
    }

    // 查看企业日历
    public List getAttFeastBO(String orgid, String date) throws SysException {
        return attFeastDAO.getAttFeastBO(orgid, date);
    }

    public List getAttFeastBOByOrgId(String orgid, String date)
            throws SysException {
        return attFeastDAO.getAttFeastBOByOrgId(orgid, date);
    }

    public AttRestOfWeekBO getAttRestOfWeekBOByOrgid(String orgid)
            throws SysException {
        return attRestWeekDAO.getAttRestOfWeekBOByOrgid(orgid);
    }

    // 排班设置
    public List getAllAttClassGroupBOType(String orgid) throws SysException {
        return groupMgrDAO.getAllAttClassGroupBOType(orgid);
    }

    public List getAllAttClassGroupBOType1(String orgid) throws SysException {
        return groupMgrDAO.getAllAttClassGroupBOType1(orgid);
    }

    public List getAllAttClassBOType(String orgid) throws SysException {
        return groupMgrDAO.getAllAttClassBOType(orgid);
    }

    public void saveorupdateAttClassGroupBO(AttClassGroupBO bo)
            throws SysException {
        groupMgrDAO.saveOrUpdateBo(bo);
    }

    public void saveorupdateAttClassGroupBO1(AttClassGroupBO bo)
            throws SysException {
        groupMgrDAO.createBo(bo);
    }

    public AttClassGroupBO findAttClassGroupBObyId(String id)
            throws SysException {
        return (AttClassGroupBO) groupMgrDAO.findBoById(AttClassGroupBO.class,
                id);
    }

    public void deleteAttClassGroupBO(String id) throws SysException {
        attenceSetDAO.deleteBo(AttClassGroupBO.class, id);
    }

    public List getAllAttClassGroupVO(PageVO pagevo, String orgid,
                                      String groupNo,String queryValue) throws SysException {
        return groupMgrDAO.getAllAttClassGroupVO(pagevo, orgid, groupNo,queryValue);
    }

    public List getAllAttClassGroupVO1(PageVO pagevo, String orgid)
            throws SysException {
        return groupMgrDAO.getAllAttClassGroupVO1(pagevo, orgid);
    }

    public List getAllAttClassGroupVO2(PageVO pagevo, String orgid)
            throws SysException {
        return groupMgrDAO.getAllAttClassGroupVO2(pagevo, orgid);
    }

    public List getAllAttClassGroupVO3(PageVO pagevo, String orgid,
                                       String findSeeValue) throws SysException {
        return groupMgrDAO.getAllAttClassGroupVO3(pagevo, orgid, findSeeValue);
    }

    public AttClassGroupVO findAttClassGroupVObyId(String id)
            throws SysException {
        return (AttClassGroupVO) groupMgrDAO.findBoById(AttClassGroupVO.class,
                id);
    }

    public List getAllAttClassGroupVOSS(String personSeq) throws SysException {
        return groupMgrDAO.getAllAttClassGroupVOSS(personSeq);
    }

    public void saveAttClassGroupVO(AttClassGroupVO bo) throws SysException {
        groupMgrDAO.saveOrUpdateBo(bo);
    }

    public void saveATTRearrangeBO(ATTRearrangeBO bo) throws SysException {
        groupMgrDAO.saveOrUpdateBo(bo);
    }

    public List getATTRearrangeBO(String orgid) throws SysException {
        return groupMgrDAO.getATTRearrangeBO(orgid);
    }

    public List getAllATTRearrangeBO(PageVO pagevo, String orgid)
            throws SysException {
        return groupMgrDAO.getAllATTRearrangeBO(pagevo, orgid);
    }

    public ATTRearrangeBO findATTRearrangeBObyId(String id) throws SysException {
        return (ATTRearrangeBO) groupMgrDAO
                .findBoById(ATTRearrangeBO.class, id);
    }

    public List findATTRearrangeBO1(String orgid, String dayseq)
            throws SysException {
        return groupMgrDAO.findATTRearrangeBO1(orgid, dayseq);
    }

    public void deleteATTRearrangeBO1(String id) throws SysException {
        groupMgrDAO.deleteBo(ATTRearrangeBO.class, id);
    }

    public void saveATTRearrangeDateBO(ATTRearrangeDateBO bo)
            throws SysException {
        groupMgrDAO.saveOrUpdateBo(bo);
    }

    // 考勤数据文件接收规则
    public List getAttFileImportBO(PageVO pagevo, String orgid)
            throws SysException {
        return this.fileImportDAO.getAttFileImportBO(pagevo, orgid);
    }

    public void saveorupdateAttFileImportBO(AttFileImportBO bo)
            throws SysException {
        this.fileImportDAO.saveOrUpdateBo(bo);
    }

    public AttFileImportBO findAttFileImportBObyId(String id)
            throws SysException {
        return (AttFileImportBO) fileImportDAO.findBoById(
                AttFileImportBO.class, id);
    }

    public void deleteAttFileImportBO(String id) throws SysException {
        fileImportDAO.deleteBo(AttFileImportBO.class, id);
    }

    public List getAttFileImportItemBO(String itemID) throws SysException {
        return this.fileImportDAO.getAttFileImportItemBO(itemID);
    }

    public void saveorupdateAttFileImportItemBO(AttFileImportItemBO bo)
            throws SysException {
        this.fileImportDAO.saveOrUpdateBo(bo);
    }

    public AttFileImportItemBO findAttFileImportItemBObyId(String id)
            throws SysException {
        return (AttFileImportItemBO) fileImportDAO.findBoById(
                AttFileImportItemBO.class, id);
    }

    public void deleteAttFileImportItemBO(String id) throws SysException {
        fileImportDAO.deleteBo(AttFileImportItemBO.class, id);
    }

    // 年假管理
    public void saveAttenceSecondDayLogBO(AttenceSecondDayLogBO bo)
            throws SysException {
        cardMessageDAO.createBo(bo);
    }

    public List getInfoItemBO(String setId) throws SysException {
        return fileImportDAO.getInfoItemBO(setId);
    }

    public List getAllAttAnnualItemBO(PageVO pagevo, String recID)
            throws SysException {
        return attenceSetDAO.getAllAttAnnualItemBO(pagevo, recID);
    }

    public List getAttAnnualItemBO1(String personId, String year, String orgId)
            throws SysException {
        return attenceSetDAO.getAttAnnualItemBO1(personId, year, orgId);
    }

    public void deleteAttAnnualItemBO(String id) throws SysException {
        fileImportDAO.deleteBo(AttAnnualItemBO.class, id);
    }

    public void saveorupdateAttAnnualDetailBO(AttAnnualDetailBO bo)
            throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public void saveorupdateAttAnnualDetailAuditBO(AttAnnualDetailAuditBO bo)
            throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public AttAnnualDetailBO findAttAnnualDetailBObyId(String id)
            throws SysException {
        return (AttAnnualDetailBO) fileImportDAO.findBoById(
                AttAnnualDetailBO.class, id);
    }


    // 个人考勤服务
    public void deleteWFProcessBO(String id) throws SysException {
        attPersonServiceDAO.deleteBo(WFProcessBO.class, id);
    }

    public WFProcessBO findWFProcessBO(String linkID) throws SysException {
        return attPersonServiceDAO.findWFProcessBO(linkID);
    }



    public List getAttAnnualDetailAuditBO(String personId, String furloughno)
            throws SysException {
        return cardMessageDAO.getAttAnnualDetailAuditBO(personId, furloughno);
    }

    public List getAttenceLogBO(PageVO pagevo, String userid, String beginDate, String endDate, String findseevalue)
            throws SysException {
        return cardMessageDAO.getAttenceLogBO(pagevo, userid, beginDate, endDate, findseevalue);
    }

    public List getAttenceLogBO1(String userid, String beginDate, String endDate)
            throws SysException {
        return cardMessageDAO.getAttenceLogBO1(userid, beginDate, endDate);
    }

    public List getAttenceLogBO2(String userid, String day) throws SysException {
        return cardMessageDAO.getAttenceLogBO2(userid, day);
    }

    public List getAttenceLogBO3(String userid, String day) throws SysException {
        return cardMessageDAO.getAttenceLogBO3(userid, day);
    }

    public void saveAttenceLogBO(AttenceLogBO bo) throws SysException {
        cardMessageDAO.createBo(bo);
    }

    public List getAttenceDayLogBO(String userid, String beginDate,
                                   String endDate) throws SysException {
        return cardMessageDAO.getAttenceDayLogBO(userid, beginDate, endDate);
    }

    public List getAttenceDayMonthBO(String userid, String beginDate,
                                     String endDate) throws SysException {
        return cardMessageDAO.getAttenceDayMonthBO(userid, beginDate, endDate);
    }

    public List getAttFurloughRecBO(String personId, PageVO mypage,
                                    boolean isExist) throws SysException {
        return cardMessageDAO.getAttFurloughRecBO(personId, mypage, isExist);
    }

    public List findAttFurloughRecBO(String personId, PageVO mypage,
                                     String argment) throws SysException {
        return cardMessageDAO.findAttFurloughRecBO(personId, mypage, argment);
    }

    public List findAttEvcctionRecBO(String personId, PageVO mypage,
                                     String argment) throws SysException {
        return cardMessageDAO.findAttEvcctionRecBO(personId, mypage, argment);
    }

    public List findAttOutWorkBO(String personId, PageVO mypage, String argment)
            throws SysException {
        return cardMessageDAO.findAttOutWorkBO(personId, mypage, argment);
    }

    public List getAttFurloughRecCollectBO(String personId, PageVO mypage)
            throws SysException {
        return cardMessageDAO.getAttFurloughRecCollectBO(personId, mypage);
    }

    public List getAttEvcctionRecCollectBO(String personId, PageVO mypage)
            throws SysException {
        return cardMessageDAO.getAttEvcctionRecCollectBO(personId, mypage);
    }

    public List getAttOutWorkCollectBO(String personId, PageVO mypage)
            throws SysException {
        return cardMessageDAO.getAttOutWorkCollectBO(personId, mypage);
    }

    public List getAttFurloughRecBO1(String personId, PageVO mypage,
                                     boolean isExist, String operID, String deptID, User user) throws SysException {
        UserAPI userApi = (UserAPI) SysContext.getBean("user_pmsAPI");
        String cancel = userApi.getScaleConditionByType(user, "A001738", "", "", "A", false, false);
        return cardMessageDAO.getAttFurloughRecBO1(personId, mypage, isExist, operID, deptID, cancel);
    }

    public List getAttAnnualDetailAuditBO(String orgId, PageVO mypage,
                                          boolean isExist, String operID, String deptID, User user,String queryValue) throws SysException {
        UserAPI userApi = (UserAPI) SysContext.getBean("user_pmsAPI");
        String cancel = userApi.getScaleConditionByType(user, "A001738", "", "", "A", false, false);
        return cardMessageDAO.getAttAnnualDetailAuditBO(orgId, mypage, isExist, operID, deptID, cancel,queryValue);
    }

    public List findAttFurloughRecBO(String id) throws SysException {
        return cardMessageDAO.findAttFurloughRecBO(id);
    }

    public List findAttEvcctionRecBO(String id) throws SysException {
        return cardMessageDAO.findAttEvcctionRecBO(id);
    }

    public List findAttOutWorkBO(String id) throws SysException {
        return cardMessageDAO.findAttOutWorkBO(id);
    }

    public void saveAttFurloughRecBO(AttFurloughRecBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public void deleteAttFurloughRecBO(String id) throws SysException {
        attFeastDAO.deleteBo(AttFurloughRecBO.class, id);
    }

    public void deleteAttEvcctionRecBO(String id) throws SysException {
        attFeastDAO.deleteBo(AttEvcctionRecBO.class, id);
    }

    public void deleteAttOutWorkBO(String id) throws SysException {
        attFeastDAO.deleteBo(AttOutWorkBO.class, id);
    }

    public List getAllAttClassGroupVO(String orgid) throws SysException {
        return cardMessageDAO.getAllAttClassGroupVO(orgid);
    }

    public List getAllPersonTable(String orgid, String name, String personType)
            throws SysException {
        return cardMessageDAO.getAllPersonTable(orgid, name, personType);
    }

    public AttFurloughRecBO findAttFurloughRecBObyId(String id)
            throws SysException {
        return (AttFurloughRecBO) cardMessageDAO.findBoById(
                AttFurloughRecBO.class, id);
    }

    public AttFurloughRecCollectBO findAttFurloughRecCollectBObyId(String id)
            throws SysException {
        return (AttFurloughRecCollectBO) cardMessageDAO.findBoById(
                AttFurloughRecCollectBO.class, id);
    }

    public void saveAttFurloughRecCollectBO(AttFurloughRecCollectBO bo)
            throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public List findAttFurloughRecCollectBO(String id) throws SysException {
        return cardMessageDAO.findAttFurloughRecCollectBO(id);
    }

    public AttEvcctionRecCollectBO findAttEvcctionRecCollectBObyId(String id)
            throws SysException {
        return (AttEvcctionRecCollectBO) cardMessageDAO.findBoById(
                AttEvcctionRecCollectBO.class, id);
    }

    public AttOutWorkCollectBO findAttOutWorkCollectBObyId(String id)
            throws SysException {
        return (AttOutWorkCollectBO) cardMessageDAO.findBoById(
                AttOutWorkCollectBO.class, id);
    }

    public List getAllAttfurloughBO() throws SysException {
        return cardMessageDAO.getAllAttfurloughBO();
    }

    public AttfurloughBO findAttfurloughBObyId(String id) throws SysException {
        return (AttfurloughBO) cardMessageDAO.findBoById(AttfurloughBO.class,
                id);
    }

    public List getAttEvcctionRecBO(String personId, PageVO mypage,
                                    boolean isExist) throws SysException {
        return cardMessageDAO.getAttEvcctionRecBO(personId, mypage, isExist);
    }

    public List getAttEvcctionRecBO1(String personId, PageVO mypage,
                                     boolean isExist, String operID, String deptID, User user) throws SysException {
        UserAPI userApi = (UserAPI) SysContext.getBean("user_pmsAPI");
        String cancel = userApi.getScaleConditionByType(user, "A001738", "", "", "A", false, false);
        return cardMessageDAO.getAttEvcctionRecBO1(personId, mypage, isExist, operID, deptID, cancel);
    }

    public List getAttOutWorkBO1(String personId, PageVO mypage, boolean isExist, String operID, String deptID, User user)
            throws SysException {
        UserAPI userApi = (UserAPI) SysContext.getBean("user_pmsAPI");
        String cancel = userApi.getScaleConditionByType(user, "A001738", "", "", "A", false, false);
        return cardMessageDAO.getAttOutWorkBO1(personId, mypage, isExist, operID, deptID, cancel);
    }

    public List getAttOverTimeRecBO(String personId, PageVO mypage,
                                    boolean isExist, String operID, String deptID, User user) throws SysException {
        UserAPI userApi = (UserAPI) SysContext.getBean("user_pmsAPI");
        String cancel = userApi.getScaleConditionByType(user, "A001738", "", "", "A", false, false);
        return cardMessageDAO.getAttOverTimeRecBO(personId, mypage, isExist, operID, deptID, cancel);
    }

    public void saveAttEvcctionRecBO(AttEvcctionRecBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public void saveAttOutWorkBO(AttOutWorkBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public AttEvcctionRecBO findAttEvcctionRecBObyId(String id)
            throws SysException {
        return (AttEvcctionRecBO) cardMessageDAO.findBoById(
                AttEvcctionRecBO.class, id);
    }

    public AttOutWorkBO findAttOutWorkBObyId(String id) throws SysException {
        return (AttOutWorkBO) cardMessageDAO.findBoById(AttOutWorkBO.class, id);
    }

    public List getAttChangeWorkBO(String personId, PageVO mypage,
                                   boolean isExist) throws SysException {
        return cardMessageDAO.getAttChangeWorkBO(personId, mypage, isExist);
    }

    public List getAttChangeWorkBO1(String personId, PageVO mypage,
                                    boolean isExist) throws SysException {
        return cardMessageDAO.getAttChangeWorkBO1(personId, mypage, isExist);
    }

    public List getAttChangeWorkBO2(String personId) throws SysException {
        return cardMessageDAO.getAttChangeWorkBO2(personId);
    }

    public List getAttChangeWorkBO3(String personId, String aDate)
            throws SysException {
        return cardMessageDAO.getAttChangeWorkBO3(personId, aDate);
    }

    public void saveorupdateAttChangeWorkBO(AttChangeWorkBO bo)
            throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public AttChangeWorkBO findAttChangeWorkBObyId(String id)
            throws SysException {
        return (AttChangeWorkBO) cardMessageDAO.findBoById(
                AttChangeWorkBO.class, id);
    }

    public List getAttAddWorkRecBO(String personId, PageVO mypage,
                                   boolean isExist) throws SysException {
        return cardMessageDAO.getAttAddWorkRecBO(personId, mypage, isExist);
    }

    public void saveAttOverTimeRecBO(AttOverTimeRecBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public AttOverTimeRecBO findAttOverTimeRecBObyId(String id)
            throws SysException {
        return (AttOverTimeRecBO) cardMessageDAO.findBoById(
                AttOverTimeRecBO.class, id);
    }

    // 考勤计算
    public void saveAttCaclInfoBO(AttCaclInfoBO bo) throws SysException {
        cardMessageDAO.createBo(bo);
    }

    public AttDurationBO findAttDurationBObyId(String id) throws SysException {
        return (AttDurationBO) cardMessageDAO.findBoById(AttDurationBO.class,
                id);
    }

    public void saveorupdateAttDurationBO(AttDurationBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public List getAttClassGroupVO(String orgID) throws SysException {
        return attCaclinfoDAO.getAttClassGroupVO(orgID);
    }

    public List getAttenceMonthBO(String userid, String duraYearMonth)
            throws SysException {
        return attCaclinfoDAO.getAttenceMonthBO(userid, duraYearMonth);
    }

    public List getAttCaclInfoBO(String duraId) throws SysException {
        return attCaclinfoDAO.getAttCaclInfoBO(duraId);
    }

    public List getAttenceDayLogBO(String userid, String beginDate)
            throws SysException {
        return cardMessageDAO.getAttenceDayLogBO(userid, beginDate);
    }

    public List getAttenceDayMonthBOS(String userid, String beginDate,
                                      String endDate) throws SysException {
        return cardMessageDAO.getAttenceDayMonthBOS(userid, beginDate, endDate);
    }

    public List getAttenceLogBO(String personId, String cardDate)
            throws SysException {
        return cardMessageDAO.getAttenceLogBO(personId, cardDate);
    }

    // 查询导入日志
    public List getAttImportAll(PageVO mypage) throws SysException {
        return fileImportDAO.getAttImportAll(mypage);
    }

    // 设置考勤计算规则
    public List getAttCaclRuleBO(String orgID) throws SysException {
        return attCaclinfoDAO.getAttCaclRuleBO(orgID);
    }

    public void saveorupdateAttCaclRuleBO(AttCaclRuleBO bo) throws SysException {
        attCaclinfoDAO.saveOrUpdateBo(bo);
    }

    // 刷卡数据查询
    public CellVO[] queryInfoItem(String qryId) throws SysException {
        return getCellVO(qryId);
    }

    public CellVO[] getCellVO(String qryId) throws SysException {
        if (qryId == null)
            return null;
        QueryItemBO bos[] = itemdao.queryQueryItem(qryId);
        QueryBO bo = (QueryBO) querydao.findBoById(
                com.hr319wg.qry.pojo.bo.QueryBO.class, qryId);
        if (bos == null || bo == null)
            return null;
        else
            return getCellVO(bos, bo.getSetType());
    }

    public CellVO[] getCellVO(QueryItemBO bos[], String setType) {
        if (bos == null)
            return null;
        CellVO vos[] = new CellVO[bos.length + 1];
        if ("A".equals(setType)) {
            InfoItemBO b = SysCacheTool.findInfoItem("A001", "ID");
            CellVO v = new CellVO();
            CommonFuns.copyProperties(v, b);
            vos[0] = v;
        } else if ("B".equals(setType)) {
            InfoItemBO b = SysCacheTool.findInfoItem("B001", "ORGUID");
            CellVO v = new CellVO();
            CommonFuns.copyProperties(v, b);
            vos[0] = v;
        } else if ("C".equals(setType)) {
            InfoItemBO b = SysCacheTool.findInfoItem("C001", "POSTID");
            CellVO v = new CellVO();
            CommonFuns.copyProperties(v, b);
            vos[0] = v;
        } else {
            InfoItemBO b = SysCacheTool.findInfoItem("D001", "PARTYID");
            CellVO v = new CellVO();
            CommonFuns.copyProperties(v, b);
            vos[0] = v;
        }
        for (int i = 1; i < vos.length; i++) {
            InfoItemBO bo = SysCacheTool.findInfoItem(null, bos[i - 1]
                    .getItemId());
            CellVO v = new CellVO();
            CommonFuns.copyProperties(v, bo);
            if (bos[i - 1].getShowId() != 0)
                v.setShowId(true);
            vos[i] = v;
        }

        return vos;
    }

    public Hashtable getQuerySqlHash(User user, String qryId,
                                     String addedCondition, String beginDate, String endDate)
            throws Exception {
        QueryVO vo = findQueryVO(qryId);
        if (vo == null)
            return null;
        if (CommonFuns.filterNull(vo.getAddedCondition()).length() > 0
                && CommonFuns.filterNull(addedCondition).length() > 0)
            vo.setAddedCondition(CommonFuns.filterNull(vo.getAddedCondition())
                    + " and " + CommonFuns.filterNull(addedCondition));
        else
            vo.setAddedCondition(CommonFuns.filterNull(vo.getAddedCondition())
                    + CommonFuns.filterNull(addedCondition));
        return getQuerySqlHash(user, vo, beginDate, endDate);
    }

    private QueryVO findQueryVO(String qryId) throws SysException {
        if (qryId == null || "".equals(qryId))
            return null;
        QueryVO vo;
        vo = new QueryVO();
        QueryBO bo = (QueryBO) querydao.findBoById(
                com.hr319wg.qry.pojo.bo.QueryBO.class, qryId);
        if (bo == null)
            return null;
        CommonFuns.copyProperties(vo, bo);
        QueryItemBO ibos[] = itemdao.queryQueryItem(qryId);
        if (ibos == null)
            return null;
        vo.setItem(ibos);
        StaticVO svos[] = queryStaticVO(qryId);
        vo.setStatics(svos);
        return vo;
    }

    private StaticVO[] queryStaticVO(String qryId) throws SysException {
        if (qryId == null || "".equals(qryId))
            return null;
        QueryStaticBO staticbos[] = staticdao.queryStatic(qryId);
        if (staticbos == null || staticbos.length <= 0)
            return null;
        StaticVO svo[];
        svo = new StaticVO[staticbos.length];
        for (int i = 0; i < svo.length; i++) {
            svo[i] = new StaticVO();
            svo[i].setStatics(staticbos[i]);
            svo[i].setCondi(conditiondao.queryCondition(staticbos[i]
                    .getStaticId()));
        }

        return svo;
    }

    private Hashtable getQuerySqlHash(User user, QueryVO vo, String beginDate,
                                      String endDate) throws Exception {
        if (vo == null || vo.getItem() == null) {
            return null;
        } else {
            QueryBO bo = new QueryBO();
            CommonFuns.copyProperties(bo, vo);
            return buildQuerySql(user, vo.getItem(), vo.getStatics()[0], bo,
                    beginDate, endDate);
        }
    }

    public Hashtable buildQuerySql(User user, QueryItemBO bos[],
                                   StaticVO staticvo, QueryBO bo, String beginDate, String endDate)
            throws Exception {
        Hashtable ht;
        ht = new Hashtable();
        String scaleField = getScaleField(bo.getSetType(), bo.getUnitType());
        String scaleTable = getScaleTable(bo.getSetType(), bo.getUnitType());
        String pk = getSetPk(bo.getSetType());
        StringBuffer scaleCondition = new StringBuffer();
        String scale = "";
        if (user != null) {
            UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
            boolean flag = false;
            if ("PARTY".equals(bo.getUnitType()))
                flag = true;
            boolean isOper = false;
            if ("2".equals(bo.getOperFlag()))
                isOper = true;
            scale = api.getScaleConditionByType(user, scaleField,
                    getCardeField(bo.getSetType(), bo.getUnitType()),
                    getPerTypeField(bo.getSetType(), bo.getUnitType()), bo
                    .getSetType(), isOper, flag);
        }
        if (!"".equals(CommonFuns.filterNull(bo.getOrgIds()))) {
            String oIds[] = bo.getOrgIds().split(",");
            scaleCondition.append(" (");
            for (int i = 0; i < oIds.length; i++) {
                String treeId;
                if ("ORG".equals(bo.getUnitType())) {
                    OrgBO o = SysCacheTool.findOrgById(oIds[i]);
                    treeId = ((OrgBO) CommonFuns.filterNull(
                            com.hr319wg.org.pojo.bo.OrgBO.class, o))
                            .getTreeId();
                } else {
                    PartyBO p = SysCacheTool.findParty(oIds[i]);
                    treeId = ((PartyBO) CommonFuns.filterNull(
                            com.hr319wg.ccp.pojo.bo.PartyBO.class, p))
                            .getTreeId();
                }
                scaleCondition.append(scaleField).append(" like '").append(
                        treeId).append("%' or ");
            }

            if (oIds.length > 0) {
                scaleCondition.delete(scaleCondition.length() - 3,
                        scaleCondition.length());
                scaleCondition.append(") ");
            } else {
                scaleCondition.delete(0, scaleCondition.length());
            }
        }
        if (CommonFuns.filterNull(scale).length() > 0
                && scaleCondition.length() > 0)
            scaleCondition.insert(0, scale + " and ");
        else
            scaleCondition.insert(0, scale);
        ht.put("SQL_SCALE_PART", scaleCondition.toString());
        String ids[] = new String[bos.length];
        for (int i = 0; i < bos.length; i++)
            ids[i] = bos[i].getItemId();

        StringBuffer select = parseSelect(ids);
        select.insert(0, scaleTable + "." + pk + ", ");
        if (ht != null)
            ht.put("SQL_SELECT_PART", select.toString());
        select.insert(0, "select ");
        String condition = null;
        String from = null;
        StringBuffer conditionPart = new StringBuffer();
        Criteria c = new Criteria();
        if (staticvo.getStatics() != null) {
            c.init(staticvo.getStatics().getGroup(), bo.getSetType(), "");
            if (staticvo.getCondi() != null) {
                for (int i = 0; i < staticvo.getCondi().length; i++) {
                    QueryConditionBO b = staticvo.getCondi()[i];
                    Method m = (com.hr319wg.qry.util.Criteria.class).getMethod(
                            b.getOperator(), new Class[]{
                                    java.lang.String.class,
                                    java.lang.String.class,
                                    java.lang.String.class,
                                    java.lang.String.class});
                    m.invoke(c, new Object[]{b.getGroupId(), b.getItemId(),
                            b.getText(), b.getValue()});
                }

            }
            String condi = CommonFuns.filterNull(c.getCondition()).trim();
            conditionPart.append(condi);
            if (bo.getAddedCondition() != null
                    && !"".equals(bo.getAddedCondition()))
                if (conditionPart.length() > 0)
                    conditionPart.append(" and (").append(
                            bo.getAddedCondition()).append(") ");
                else
                    conditionPart.append(" (").append(bo.getAddedCondition())
                            .append(") ");
            condition = c.addDefaultCondition(conditionPart.toString());
            conditionPart = new StringBuffer(condition);
            from = c.getJoinTable(ids, scaleTable, bo.getHistorySet(),
                    beginDate, endDate);
        } else if (bo.getAddedCondition() != null
                && !"".equals(bo.getAddedCondition()))
            conditionPart = new StringBuffer(bo.getAddedCondition());
        StringBuffer order = parseOrder(bos);
        if (order == null || order.length() == 0)
            order.append(getDefaultOrder(bo.getSetType()));
        if (order.indexOf("A001701") >= 0) {
            from = from + " left join B001 bbbb1 on A001.A001701=bbbb1.orguid";
            String tmp = order.toString();
            order.delete(0, order.length());
            order.append(tmp.replaceAll("A001701", "bbbb1.B001715"));
        }
        if (order.indexOf("A001705") >= 0) {
            from = from + " left join B001 bbbb2 on A001.A001705=bbbb2.orguid";
            String tmp = order.toString();
            order.delete(0, order.length());
            order.append(tmp.replaceAll("A001705", "bbbb2.B001715"));
        }
        if (ht != null) {
            ht.put("SQL_WHERE_PART", CommonFuns.filterNull(condition));
            ht.put("SQL_FROM_PART", CommonFuns.filterNull(from));
        }
        select.append(" from ").append(from);
        if (scaleCondition.length() > 0
                && conditionPart.toString().trim().length() > 0)
            conditionPart.append(" and (").append(scaleCondition).append(") ");
        else
            conditionPart.append(scaleCondition);
        if (conditionPart.length() > 0)
            select.append(" where ").append(conditionPart);
        select.append(" order by ").append(order);
        if (ht != null)
            ht.put("SQL_ORDER_PART", order.toString());
        ht.put("SQL_FULL", select.toString());
        log.debug(select.toString());
        return ht;
    }

    public String getSetPk(String setType) {
        if ("A".equals(setType))
            return "ID";
        if ("B".equals(setType))
            return "ORGUID";
        if ("C".equals(setType))
            return "POSTID";
        if ("D".equals(setType))
            return "PARTYID";
        else
            return "ID";
    }

    public String getScaleField(String setType, String unitType) {
        if ("A".equals(setType) && "ORG".equals(unitType))
            return "A001738";
        if ("A".equals(setType) && "PARTY".equals(unitType))
            return "A001740";
        if ("A".equals(setType) && "WAGE".equals(unitType))
            return "A815700";
        if ("B".equals(setType))
            return "B001003";
        if ("C".equals(setType))
            return "C001701";
        if ("D".equals(setType))
            return "D001003";
        else
            return "A001738";
    }

    public String getScaleTable(String setType, String unitType) {
        if ("A".equals(setType) && "ORG".equals(unitType))
            return "A001";
        if ("A".equals(setType) && "PARTY".equals(unitType))
            return "A001";
        if ("A".equals(setType) && "WAGE".equals(unitType))
            return "A815";
        if ("B".equals(setType))
            return "B001";
        if ("C".equals(setType))
            return "C001";
        if ("D".equals(setType))
            return "D001";
        else
            return "A001";
    }

    public String getCardeField(String setType, String unitType) {
        if ("A".equals(setType) && "ORG".equals(unitType))
            return "A001750";
        else
            return null;
    }

    public String getPerTypeField(String setType, String unitType) {
        if ("A".equals(setType) && "ORG".equals(unitType))
            return "A001054";
        else
            return null;
    }

    private StringBuffer parseSelect(String ids[]) throws SysException {
        StringBuffer sb = new StringBuffer();
        if (ids == null || ids.length <= 0)
            return sb;
        for (int i = 0; i < ids.length; i++)
            sb.append(ids[i]).append(",");

        return sb.deleteCharAt(sb.length() - 1);
    }

    private String getDefaultOrder(String setType) {
        if ("A".equals(setType))
            return "A001.A001746, A001.ID";
        if ("B".equals(setType))
            return "B001.B001715, B001.ORGUID";
        if ("C".equals(setType))
            return "C001.C001002";
        if ("D".equals(setType))
            return "D001.D001715, D001.PARTYID";
        else
            return "";
    }

    public StringBuffer parseOrder(QueryItemBO bos[]) throws SysException {
        StringBuffer sb = new StringBuffer();
        if (bos == null)
            return sb;
        ArrayList list = new ArrayList();
        for (int i = 0; i < bos.length; i++)
            list.add(null);

        for (int i = 0; i < bos.length; i++)
            if (bos[i].getOrderFlag() != null)
                list.add(bos[i].getOrderSeq(), bos[i]);

        for (int i = 0; i < list.size(); i++) {
            QueryItemBO b = (QueryItemBO) list.get(i);
            if (b != null && "0".equals(b.getOrderFlag())) {
                sb.append(b.getItemId()).append(" ASC, ");
                continue;
            }
            if (b != null && "1".equals(b.getOrderFlag()))
                sb.append(b.getItemId()).append(" DESC, ");
        }

        if (sb.length() > 0)
            sb.delete(sb.length() - 2, sb.length());
        return sb;
    }

    static {
        log = Logger.getLogger(com.hr319wg.qry.util.QueryUtil.class);
    }

    // 考勤项目规则
    public List getAllAttItemSetDetailBO(String orgID) throws SysException {
        return attenceSetDAO.getAllAttItemSetDetailBO(orgID);
    }

    public void saveorupdateAttItemSetDetailBO(AttItemSetDetailBO bo)
            throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public AttItemSetDetailBO findAttItemSetDetailBObyId(String id)
            throws SysException {
        return (AttItemSetDetailBO) attenceSetDAO.findBoById(
                AttItemSetDetailBO.class, id);
    }

    public void deleteAttItemSetDetailBO(String id) throws SysException {
        attenceSetDAO.deleteBo(AttItemSetDetailBO.class, id);
    }

    public List findAllAttItemSetDetailBO(String itemCode, String orgID)
            throws SysException {
        return attenceSetDAO.findAllAttItemSetDetailBO(itemCode, orgID);
    }

    public Hashtable findAllAttItemSetDetailB0ForHash(String orgId) {
        return attenceSetDAO.findAllAttItemSetDetailB0ForHash(orgId);
    }

    public List findAllInfoItemBO(String setId) throws SysException {
        return attenceSetDAO.findAllInfoItemBO(setId);
    }

    // 浏览加班
    public void saveorupdateAttOverTimeLogBO(AttOverTimeLogBO bo)
            throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public List getAllAttOverTimeLogBO(String name, String beginTime,
                                       String superId, PageVO mypage) throws SysException {
        return attenceSetDAO.getAllAttOverTimeLogBO(name, beginTime, superId,
                mypage);
    }

    public List findAllOrgBO(String orgID) throws SysException {
        return attenceSetDAO.findAllOrgBO(orgID);
    }

    public List getAttClassGroupVO(PageVO mypage, String orgId, String personType)
            throws SysException {
        return attCaclinfoDAO.getAttClassGroupVO(mypage, orgId, personType);
    }

    // 自动排班
    public List getAllAttenceStandBO(PageVO mypage) throws SysException {
        return fileImportDAO.getAllAttenceStandBO(mypage);
    }

    public List getAllAttenceStandBO(PageVO mypage, String orgId)
            throws SysException {
        return fileImportDAO.getAllAttenceStandBO(mypage, orgId);
    }

    public List getAllAttenceWaterBO(PageVO mypage, String date)
            throws SysException {
        return fileImportDAO.getAllAttenceWaterBO(mypage, date);
    }

    public List getAllAttenceWeekWaterBO(PageVO mypage, String date)
            throws SysException {
        return fileImportDAO.getAllAttenceWeekWaterBO(mypage, date);
    }

    public List getAllAttenceWaterBO(PageVO mypage, String date, String orgId)
            throws SysException {
        return fileImportDAO.getAllAttenceWaterBO(mypage, date, orgId);
    }

    public List getAllAttenceWeekWaterBO(PageVO mypage, String date, String orgId)
            throws SysException {
        return fileImportDAO.getAllAttenceWeekWaterBO(mypage, date, orgId);
    }

    public void saveorupdateAttenceStandBO(AttenceStandBO bo)
            throws SysException {
        attenceSetDAO.createBo(bo);
    }

    public void saveorupdateAttenceWaterBO(AttenceWaterBO bo)
            throws SysException {
        attenceSetDAO.createBo(bo);
    }

    public void saveorupdateAttenceWeekWaterBO(AttenceWeekWaterBO bo)
            throws SysException {
        attenceSetDAO.createBo(bo);
    }

    public List findAttenceStandBO(String subId, String orgId)
            throws SysException {
        return fileImportDAO.findAttenceStandBO(subId, orgId);
    }

    public List findAttenceWaterBO(String subId, String orgId)
            throws SysException {
        return fileImportDAO.findAttenceWaterBO(subId, orgId);
    }

    public List findAttenceWeekWaterBO(String subId, String orgId)
            throws SysException {
        return fileImportDAO.findAttenceWeekWaterBO(subId, orgId);
    }

    public List findAttenceStandBO2(String orgId) throws SysException {
        return fileImportDAO.findAttenceStandBO2(orgId);
    }

    public List findAttenceStandBO1(String orgId) throws SysException {
        return fileImportDAO.findAttenceStandBO1(orgId);
    }

    public List findAttenceWaterBO1(String orgId, String date)
            throws SysException {
        return fileImportDAO.findAttenceWaterBO1(orgId, date);
    }

    public List findAttenceWaterBO2(String orgId, String date)
            throws SysException {
        return fileImportDAO.findAttenceWaterBO2(orgId, date);
    }

    public List findAttenceWaterBO3(String orgId, String date)
            throws SysException {
        return fileImportDAO.findAttenceWaterBO3(orgId, date);
    }

    public List findAttenceWeekWaterBO1(String orgId, String date, String weekdate)
            throws SysException {
        return fileImportDAO.findAttenceWeekWaterBO1(orgId, date, weekdate);
    }

    public List getAllAttPersonArrangeBO(PageVO mypage, String superId)
            throws SysException {
        return fileImportDAO.getAllAttPersonArrangeBO(mypage, superId);
    }

    public List findAttPersonArrangeBO(String orgId) throws SysException {
        return fileImportDAO.findAttPersonArrangeBO(orgId);
    }

    public void saveorupdateAttPersonArrangeBO(AttPersonArrangeBO bo)
            throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public List findGroupValues(String orgId) throws SysException {
        return fileImportDAO.findGroupValues(orgId);
    }

    public AttPersonArrangeBO findAttPersonArrangeBObyId(String id)
            throws SysException {
        return (AttPersonArrangeBO) attenceSetDAO.findBoById(
                AttPersonArrangeBO.class, id);
    }

    public List findPersonsAttClassGroupVO(String groupId) throws SysException {
        return attenceSetDAO.findPersonsAttClassGroupVO(groupId);
    }

    public List findPersonsAttClassGroupVO(String groupId, String deptId) throws SysException {
        return attenceSetDAO.findPersonsAttClassGroupVO(groupId, deptId);
    }

    public void saveorupdateAttPersonArrangeItemBO(AttPersonArrangeItemBO bo)
            throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public List getAllAttPersonArrangeItemBO(String arrangeId, String createDay)
            throws SysException {
        return fileImportDAO.getAllAttPersonArrangeItemBO(arrangeId, createDay);
    }

    public List getAllAttPersonArrangeItemBO(String arrangeId, String createDay, String deptId) throws SysException {
        return fileImportDAO.getAllAttPersonArrangeItemBO(arrangeId, createDay, deptId);
    }

    public List getAllAttPersonArrangeItemBO1(String arrangeId, String createDay)
            throws SysException {
        return fileImportDAO
                .getAllAttPersonArrangeItemBO1(arrangeId, createDay);
    }

    public List getAllAttPersonArrangeItemBO1(String arrangeId, String createDay, String deptId) throws SysException {
        return fileImportDAO
                .getAllAttPersonArrangeItemBO1(arrangeId, createDay, deptId);
    }

    public AttPersonArrangeItemBO findAttPersonArrangeItemBObyId(String id)
            throws SysException {
        return (AttPersonArrangeItemBO) attenceSetDAO.findBoById(
                AttPersonArrangeItemBO.class, id);
    }

    // 存休
    public List findAttExistRestBO(String personId, String date)
            throws SysException {
        return fileImportDAO.findAttExistRestBO(personId, date);
    }

    public int caclFeast(List daylists, String orgId) throws SysException {
        int sum = 0;
        if (daylists != null && daylists.size() > 0) {
            for (int p = 0; p < daylists.size(); p++) {
                String dayvalue = (String) daylists.get(p);
                String[] dayvalues = dayvalue.split(",");
                String day = dayvalues[0];
                String aDates = day.substring(5, 10);

                List lists = getAllAttFeast(orgId);
                if (lists != null && lists.size() > 0) {
                    for (int i = 0; i < lists.size(); i++) {
                        AttFeastBO attfeastbo = (AttFeastBO) lists.get(i);
                        String[] args = attfeastbo.getFeastDate().split(",");
                        for (int j = 0; j < args.length; j++) {
                            if (day.equals(args[j])) {
                                sum += 1;
                            } else if (aDates.equals(args[j])) {
                                sum += 1;
                            }
                        }
                    }
                }
                List lists1 = getAllAttFeast("-1");
                if (lists1 != null && lists1.size() > 0) {
                    for (int i = 0; i < lists1.size(); i++) {
                        AttFeastBO attfeastbo1 = (AttFeastBO) lists1.get(i);
                        String[] argss = attfeastbo1.getFeastDate().split(",");
                        for (int j = 0; j < argss.length; j++) {
                            if (day.equals(argss[j])) {
                                sum += 1;
                            } else if (aDates.equals(argss[j])) {
                                sum += 1;
                            }
                        }
                    }
                }
            }
        }
        return sum;
    }

    public List getAllAttFeast(String orgid) throws SysException {
        return attFeastDAO.getAllAttFeast(orgid);
    }

    public void caclRest(List personGroupLists,
                         AttPersonArrangeBO attpersonarrangebo, int sum) throws SysException {
        String ymd = attpersonarrangebo.getDuraYear() + "-"
                + attpersonarrangebo.getDuraMonth();
        String m = attpersonarrangebo.getDuraMonth();
        int mInt = Integer.parseInt(m);
        String m1 = "";
        if (mInt > 10) {
            m1 = "" + (mInt - 1);
        } else {
            m1 = "0" + (mInt - 1);
        }
        String ymd1 = attpersonarrangebo.getDuraYear() + "-" + m1;
        String groupId = attpersonarrangebo.getGroupId();
        List lists = findPersonsAttClassGroupVO(groupId);// 在编人数
        if (lists != null && lists.size() > 0) {
            for (int i = 0; i < lists.size(); i++) {
                AttClassGroupVO attclassgroupvo = (AttClassGroupVO) lists
                        .get(i);
                String beginMonthValue = "";
                String beginMonthValuesss = selectA812(attclassgroupvo.getId(),
                        ymd);
                if (beginMonthValuesss != null
                        && !"".equals(beginMonthValuesss)) {
                    beginMonthValue = beginMonthValuesss;
                } else {
                    String endMonthValue = findEndMonthValue(attclassgroupvo
                            .getId(), ymd1);
                    if (endMonthValue != null && !"".equals(endMonthValue)) {
                        beginMonthValue = endMonthValue;
                    } else {
                        beginMonthValue = "0";
                    }
                }
                String personWorks = countWorks(attclassgroupvo.getId(), ymd);
                int monthAdd = 0;
                int monthRemove = 0;
                int personRealWorks = 0;
                personRealWorks = Integer.parseInt(personWorks.trim());
                int flag = 0;
                flag = personRealWorks - sum;
                if (flag > 0) {
                    monthAdd = flag;
                } else {
                    monthRemove = Math.abs(flag);
                }
                int beginMonthValueInt = Integer.parseInt(beginMonthValue);
                int s = beginMonthValueInt + monthAdd - monthRemove;// 计算结果
                updateA812(attclassgroupvo.getId(), ymd);
                String s1 = beginMonthValueInt + "";
                String s2 = monthAdd + "";
                String s3 = monthRemove + "";
                String s4 = s + "";
                AttExistRestBO attexistrestbo = new AttExistRestBO();
                attexistrestbo.setPersonId(attclassgroupvo.getId());
                attexistrestbo.setSubID(SequenceGenerator.getKeyId("A812"));
                attexistrestbo.setRecord(Constants.YES);
                attexistrestbo.setAttenceDay(ymd);
                attexistrestbo.setBeginMonthValue(s1.trim());
                attexistrestbo.setMonthAdd(s2.trim());
                attexistrestbo.setMonthRemove(s3.trim());
                attexistrestbo.setEndMonthValue(s4.trim());
                saveorupdateAttExistRestBO(attexistrestbo);
            }
        }

    }

    public String findEndMonthValue(String personId, String day)
            throws SysException {
        String sql = "select A812704 from A812 where ID='" + personId
                + "' and A812700='" + day + "' and A812000='00901'";
        return activeapi.queryForString(sql);
    }

    public String countWorks(String personId, String day) throws SysException {
        String sql = "select count(PERSON_ID) from ATT_PERSON_ARRANGE_ITEM  where PERSON_ID='"
                + personId
                + "' and CREATE_DAY like '"
                + day
                + "%' and LINK_CLASS<>'1'";
        return activeapi.queryForString(sql);
    }

    public void updateA812(String personId, String day) throws SysException {
        String sql = "update A812 set A812000='00900' where ID='" + personId
                + "' and A812700='" + day + "' and A812000='00901'";
        activeapi.executeSql(sql);
    }

    public String selectA812(String personId, String day) throws SysException {
        String sql = "select A812701 from A812 where ID='" + personId
                + "' and A812700='" + day + "' and A812000='00901'";
        return activeapi.queryForString(sql);
    }

    public void saveorupdateAttExistRestBO(AttExistRestBO bo)
            throws SysException {
        attenceSetDAO.createBo(bo);
    }

    public static Date getdate(String date) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.parse(date);
    }

    /*
      * 比较公休日
      */
    public boolean weekCalendar(String orguid, String day) throws Exception {
        boolean flag = false;
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(getdate(day));
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        String attrestofweekboName = dayNames[dayOfWeek - 1];
        AttRestOfWeekBO attrestofweekbo = getAttRestOfWeekBOByOrgid(orguid);
        if (attrestofweekbo != null) {
            String namevalues = "公休日:公休日:班次主键值";
            if ("sun".equals(attrestofweekboName)) {
                if ("0".equals(attrestofweekbo.getSun())) {
                    flag = true;
                    return flag;
                }
            }
            if ("mon".equals(attrestofweekboName)) {
                if ("0".equals(attrestofweekbo.getMon())) {
                    flag = true;
                    return flag;
                }
            }
            if ("tues".equals(attrestofweekboName)) {
                if ("0".equals(attrestofweekbo.getTues())) {
                    flag = true;
                    return flag;
                }
            }
            if ("wed".equals(attrestofweekboName)) {
                if ("0".equals(attrestofweekbo.getWed())) {
                    flag = true;
                    return flag;
                }
            }
            if ("thur".equals(attrestofweekboName)) {
                if ("0".equals(attrestofweekbo.getThur())) {
                    flag = true;
                    return flag;
                }
            }
            if ("fri".equals(attrestofweekboName)) {
                if ("0".equals(attrestofweekbo.getFri())) {
                    flag = true;
                    return flag;
                }
            }
            if ("sat".equals(attrestofweekboName)) {
                if ("0".equals(attrestofweekbo.getSat())) {
                    flag = true;
                    return flag;
                }
            }
        }
        return flag;
    }

    /*
      * 比较节假日
      */
    public boolean weekFeast(String orguid, String day) throws Exception {
        boolean flag = false;
        String ss = day;
        String aDates = ss.substring(5, 10);
        List lists = getAllAttFeast(orguid);
        if (lists != null && lists.size() > 0) {
            for (int i = 0; i < lists.size(); i++) {
                AttFeastBO attfeastbo = (AttFeastBO) lists.get(i);
                String[] args = attfeastbo.getFeastDate().split(",");
                for (int j = 0; j < args.length; j++) {
                    if (ss.equals(args[j])) {
                        flag = true;
                        return flag;
                    } else if (aDates.equals(args[j])) {
                        flag = true;
                        return flag;
                    }
                }
            }
        }

        List lists1 = getAllAttFeast("-1");
        if (lists1 != null && lists1.size() > 0) {
            for (int i = 0; i < lists1.size(); i++) {
                AttFeastBO attfeastbo1 = (AttFeastBO) lists1.get(i);
                String[] argss = attfeastbo1.getFeastDate().split(",");
                for (int j = 0; j < argss.length; j++) {
                    if (ss.equals(argss[j])) {
                        flag = true;
                        return flag;
                    } else if (aDates.equals(argss[j])) {
                        flag = true;
                        return flag;
                    }
                }
            }
        }
        return flag;
    }

    // 倒休
    public void saveorupdateAttTimeOffRecBO(AttTimeOffRecBO bo)
            throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public AttTimeOffRecBO findAttTimeOffRecBObyId(String id)
            throws SysException {
        return (AttTimeOffRecBO) attenceSetDAO.findBoById(
                AttTimeOffRecBO.class, id);
    }

    public List findAttTimeOffRecBO(String overTimeNO) throws SysException {
        return attenceSetDAO.findAttTimeOffRecBO(overTimeNO);
    }

    public List findAttTimeOffRecBO(String personId, String overTimeNO) throws SysException {
        return attenceSetDAO.findAttTimeOffRecBO(personId, overTimeNO);
    }

    public List findAttTimeOffRecBO1(String personId, String overTimeNO) throws SysException {
        return attenceSetDAO.findAttTimeOffRecBO1(personId, overTimeNO);
    }


    public List getEvcctionStateSearch(String orgId, PageVO mypage)
            throws SysException {
        return cardMessageDAO.getEvcctionStateSearch(orgId, mypage);
    }

    // 年假拟报
    public List getAttMimicReportRecBO(String personId, PageVO mypage,
                                       boolean isExist) throws SysException {
        return cardMessageDAO.getAttMimicReportRecBO(personId, mypage, isExist);
    }

    public List findAttAnnualRecordBO(String orgid) throws SysException {
        return attenceSetDAO.findAttAnnualRecordBO(orgid);
    }

    public List findAttAnnualItemBO(String recID, String personId)
            throws SysException {
        return attenceSetDAO.findAttAnnualItemBO(recID, personId);
    }

    public void saveAttMimicReportRecBO(AttMimicReportRecBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public AttMimicReportRecBO findAttMimicReportRecBObyId(String id) throws SysException {
        return (AttMimicReportRecBO) attFeastDAO.findBoById(AttMimicReportRecBO.class, id);
    }

    public void deleteAttMimicReportRecBO(String id) throws SysException {
        attFeastDAO.deleteBo(AttMimicReportRecBO.class, id);
    }

    public List findAttOverTimeRecBO(String personId, PageVO mypage, boolean isExist, String operID, String deptID, User user) throws SysException {
        UserAPI userApi = (UserAPI) SysContext.getBean("user_pmsAPI");
        String cancel = userApi.getScaleConditionByType(user, "A001738", "", "", "A", false, false);
        return cardMessageDAO.findAttOverTimeRecBO(personId, mypage, isExist, operID, deptID, cancel);
    }

    public List findAttOverTimeLogBO(String personId, String date)
            throws SysException {
        return cardMessageDAO.findAttOverTimeLogBO(personId, date);
    }

    public List getAllAttManagerArrangeBO(PageVO mypage, String superId) throws SysException {
        return fileImportDAO.getAllAttManagerArrangeBO(mypage, superId);
    }

    public List findAttManagerArrangeBO(String orgId) throws SysException {
        return fileImportDAO.findAttManagerArrangeBO(orgId);
    }

    public void saveorupdateAttManagerArrangeBO(AttManagerArrangeBO bo)
            throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public List getAllAttManagerArgumentBO(PageVO mypage, String superId) throws SysException {
        return fileImportDAO.getAllAttManagerArgumentBO(mypage, superId);
    }

    public void saveorupdateAttManagerArgumentBO(AttManagerArgumentBO bo)
            throws SysException {
        attenceSetDAO.saveOrUpdateBo(bo);
    }

    public List getAllAttManagerArgumentBO(String superId) throws SysException {
        return fileImportDAO.getAllAttManagerArgumentBO(superId);
    }

    public List getAllAttManagerArgumentBO1(String deptId) throws SysException {
        return fileImportDAO.getAllAttManagerArgumentBO1(deptId);
    }

    public List getAllAttPersonArrangeItemBO2(String arrangeId, String deptId) throws SysException {
        return fileImportDAO.getAllAttPersonArrangeItemBO2(arrangeId, deptId);
    }

    public AttManagerArrangeBO findAttManagerArrangeBObyId(String id) throws SysException {
        return (AttManagerArrangeBO) attFeastDAO.findBoById(AttManagerArrangeBO.class, id);
    }

    public List findAttManagerArgumentBO(String deptId) throws SysException {
        return fileImportDAO.findAttManagerArgumentBO(deptId);
    }

    public void deleteAttManagerArgumentBO(String id) throws SysException {
        attFeastDAO.deleteBo(AttManagerArgumentBO.class, id);
    }

    public AttManagerArgumentBO findAttManagerArgumentBObyId(String id) throws SysException {
        return (AttManagerArgumentBO) cardMessageDAO.findBoById(AttManagerArgumentBO.class, id);
    }

    public List findCountAttPersonArrangeItemBO1(String arrangeId, String day, String orgId) throws SysException {
        return fileImportDAO.findCountAttPersonArrangeItemBO1(arrangeId, day, orgId);
    }

    public List findCountAttPersonArrangeItemBO2(String arrangeId, String day, String orgId) throws SysException {
        return fileImportDAO.findCountAttPersonArrangeItemBO2(arrangeId, day, orgId);
    }

    public List getAllAttTimeOffRecBO(PageVO mypage, String overTimeNO) throws SysException {
        return fileImportDAO.getAllAttTimeOffRecBO(mypage, overTimeNO);
    }

    public List getAllAttTimeOffRecBO(String overTimeNO) throws SysException {
        return fileImportDAO.getAllAttTimeOffRecBO(overTimeNO);
    }

    public void deleteAttImportLogBO(String id) throws SysException {
        attFeastDAO.deleteBo(AttImportLogBO.class, id);
    }

    public void saveAttOutWorkCollectBO(AttOutWorkCollectBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public void saveAttEvcctionRecCollectBO(AttEvcctionRecCollectBO bo) throws SysException {
        cardMessageDAO.saveOrUpdateBo(bo);
    }

    public List getAllAttAnnualDetailAuditBO(PageVO mypage, String furloughNO) throws SysException {
        return fileImportDAO.getAllAttAnnualDetailAuditBO(mypage, furloughNO);
    }

    public List getAllAttAnnualDetailAuditBO(String furloughNO) throws SysException {
        return fileImportDAO.getAllAttAnnualDetailAuditBO(furloughNO);
    }

    public List findAttModifyTimeOffList(String name, String beginTime, String superId, PageVO mypage)
            throws SysException {
        return attenceSetDAO.findAttModifyTimeOffList(name, beginTime, superId,
                mypage);
    }
    public void deleteAllByList(List list){
    	attenceSetDAO.deleteAll(list);
    }
    
    public List getAllAttClassUserList(String classId,String userType) throws SysException {
    	return attenceSetDAO.getAllAttClassUserList(classId, userType);
    }
    
    public void deleteAttClassUserBO(AttClassUserBO user) throws SysException{
    	attenceSetDAO.deleteBo(AttClassUserBO.class, user.getID());
    }
   
    public void saveAttClassUserBO(AttClassUserBO user) throws SysException{
    	attenceSetDAO.saveOrUpdateBo(user);
    }

}
