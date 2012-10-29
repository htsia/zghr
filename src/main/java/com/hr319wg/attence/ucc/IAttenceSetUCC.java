package com.hr319wg.attence.ucc;

import java.text.ParseException;
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
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.bo.WFProcessBO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.pojo.vo.WFTransaction;

public interface IAttenceSetUCC {

	public List getAllAttenceSet(PageVO pagevo, User user)
			throws SysException;

	public List getAllAttDurationBOS() throws SysException;

	public void saveorupdateAttenceSet(AttDurationBO bo) throws SysException;

	public AttDurationBO findAttenceSetBObyId(String id) throws SysException;

	public void deleteAttenceSetBO(String id) throws SysException;

	public List getAllAttDurationBO(User user) throws SysException;

	// 公休日管理
	public AttRestOfWeekBO findAttRestOfWeekBObyId(String id)
			throws SysException;

	public void saveorupdateAttRestOfWeek(AttRestOfWeekBO bo)
			throws SysException;

	public void saveAttRestOfWeek(AttRestOfWeekBO bo) throws SysException;

	// 节假日管理
	public List getAllAttFeast(PageVO pagevo, String orgid) throws SysException;

	public List getAllAttWorkDate(String feastID,String orgid) throws SysException;
	
	public void saveorupdateAttFeast(AttFeastBO bo) throws SysException;

	public AttFeastBO findAttFeastBObyId(String id) throws SysException;

	public void deleteAttFeastBO(String id) throws SysException;

	public void deleteAttWorkDateIsFeastId(String id) throws SysException;
	
	public void deleteAttWorkDateBO(String id) throws SysException;
	
	public AttWorkDateBO findAttWorkDateBObyId(String id) throws SysException;
	
	public void saveorupdateAttWorkDate(AttWorkDateBO bo) throws SysException;
	
	// 考勤机管理
	public List findAllAttMachine() throws SysException;

	public List getAllAttMachine(PageVO pagevo, String orgid)
			throws SysException;

	public void saveorupdateAttMachine(attMachineBO bo) throws SysException;

	public attMachineBO findBobyId(String id) throws SysException;

	public void deleteAttMachine(String id) throws SysException;

	// 考勤卡管理
	public void UpdateA001736(String personid, String A001736)
			throws SysException;

	public String insertDataA001736(String A001736) throws SysException;

	public void saveAttCard(AttCardBO bo) throws SysException;

	public void deleteAttCardBO(String id) throws SysException;

	public String findInfoItemBObyId(String id) throws SysException;

	public List getAllAttCardBO(PageVO pagevo, String status, String superId)
			throws SysException;

	// 班次设置
	public List getAllAttClassBO(PageVO pagevo, String orgid)
			throws SysException;

	public List getAttClassBO(String className) throws SysException;

	public void saveAttClassBO(AttClassBO bo) throws SysException;

	public AttClassBO findAttClassBObyId(String id) throws SysException;

    public boolean checkAttClassIsUse(String id)throws SysException;

	public void deleteAttClassBO(AttClassBO bo) throws SysException;

    public Hashtable getAllAttClassGroupBOForHash()throws SysException;

    public Hashtable getAllAttClassBOForHash()throws SysException;

	public void deleteAttClassDetailBO(AttClassDetailBO bo) throws SysException;
	
	public void deleteAllByList(List list) throws SysException;

	public AttClassDetailBO findAttClassDetailBObyId(String id)
			throws SysException;

	public List getAllAttClassDetailBOS(String classID) throws SysException;

	public List getAllAttClassDetailBO(PageVO pagevo, String classID)
			throws SysException;

	public List getAllAttClassDetailBO1(String classID) throws SysException;

	public List getAllAttClassDetailBO2(String classID) throws SysException;

	public List getAllAttClassDetailBO3(String classID) throws SysException;

	public List getAllAttClassDetailBO4(String classID) throws SysException;

	public void saveAttClassDetailBO(AttClassDetailBO bo) throws SysException;

	public String findCountAttClassGroupVO(String groupNo) throws SysException;

	// 查看企业日历
	public List getAttFeastBO(String orgid, String date) throws SysException;

	public List getAttFeastBOByOrgId(String orgid, String date)
			throws SysException;

	public AttRestOfWeekBO getAttRestOfWeekBOByOrgid(String orgid)
			throws SysException;

	// 排班设置
	public List getAllAttClassGroupBOType(String orgid) throws SysException;

	public List getAllAttClassGroupBOType1(String orgid) throws SysException;
	
	public List getAllAttClassBOType(String orgid) throws SysException;

	public void saveorupdateAttClassGroupBO(AttClassGroupBO bo)
			throws SysException;

	public void saveorupdateAttClassGroupBO1(AttClassGroupBO bo)
			throws SysException;

	public AttClassGroupBO findAttClassGroupBObyId(String id)
			throws SysException;

	public void deleteAttClassGroupBO(String id) throws SysException;

	public List getAllAttClassGroupVO(PageVO pagevo, String orgid,
			String groupNo,String queryValue) throws SysException;

	public List getAllAttClassGroupVO1(PageVO pagevo, String orgid)
			throws SysException;

	public List getAllAttClassGroupVO2(PageVO pagevo, String orgid)
			throws SysException;

	public List getAllAttClassGroupVO3(PageVO pagevo,String orgid,String findSeeValue)
	throws SysException;
	
	public String findDeptmentVObyId(String id) throws SysException;

	public AttClassGroupVO findAttClassGroupVObyId(String id)
			throws SysException;

	public void saveAttClassGroupVO(AttClassGroupVO bo) throws SysException;

	public void UpdateAttClassGroupVO(String personid, String A001737)
			throws SysException;

	public List getAllAttClassGroupVOSS(String personSeq) throws SysException;

	public void saveATTRearrangeBO(ATTRearrangeBO bo) throws SysException;

	public List getATTRearrangeBO(String orgid) throws SysException;

	public List getAllATTRearrangeBO(PageVO pagevo, String orgid)
			throws SysException;

	public void UpdateATTRearrangeBO(String rearrangeNo) throws SysException;

	public ATTRearrangeBO findATTRearrangeBObyId(String id) throws SysException;

	public List findATTRearrangeBO1(String orgid, String dayseq)
			throws SysException;

	public void deleteATTRearrangeBO1(String id) throws SysException;

	public void saveATTRearrangeDateBO(ATTRearrangeDateBO bo)
			throws SysException;

	public Hashtable getPeriodInfo(String groupID, String aDate, int num);

	public Hashtable getPeriodInfoDate(String groupID, String aDate1);

	// 考勤数据文件接收规则
	public List getAttFileImportBO(PageVO pagevo, String orgid)
			throws SysException;

	public void saveorupdateAttFileImportBO(AttFileImportBO bo)
			throws SysException;

	public AttFileImportBO findAttFileImportBObyId(String id)
			throws SysException;

	public void deleteAttFileImportBO(String id) throws SysException;

	public List getAttFileImportItemBO(String itemID) throws SysException;

	public void saveorupdateAttFileImportItemBO(AttFileImportItemBO bo)
			throws SysException;

	public AttFileImportItemBO findAttFileImportItemBObyId(String id)
			throws SysException;

	public void deleteAttFileImportItemBO(String id) throws SysException;

	// 年假管理
	
	public void saveAttenceSecondDayLogBO(AttenceSecondDayLogBO bo) throws SysException;

    public void deleteAttenceSecondDayLogBO(String id, String day) throws SysException;
	
	public List getInfoItemBO(String setId) throws SysException;

	public List getAllAttAnnualItemBO(PageVO pagevo, String recID)
	throws SysException;
	
	public List getAttAnnualItemBO1(String personId,String year,String orgId) throws SysException;
	
	public void deleteAttAnnualItemBO(String id) throws SysException;

	
	public void saveorupdateAttAnnualDetailBO(AttAnnualDetailBO bo) throws SysException;
	
	// 个人考勤服务
    public String getA001737(String personid) throws SysException;

    public String insertDatapersonid(String personid) throws SysException;

	public void deleteWFProcessBO(String id) throws SysException;
	
	public void deleteSysInProcessBO(String processId) throws SysException;
	
	public void deleteWFLogBO(String processId) throws SysException;
	
	public WFProcessBO findWFProcessBO(String linkID) throws SysException;
	
	public String findAttAnnualDetailAuditBOStatusValue(String personid) throws SysException;
	
	public void deleteAttAnnualDetailAuditBO1(String FurloughNo) throws SysException;
	
	public List getAttAnnualDetailAuditBO(String personId,String furloughno) throws SysException;

	public List getAttenceLogBO(PageVO pagevo,String userid, String beginDate, String endDate,String findseevalue)
			throws SysException;

	public List getAttenceLogBO1(String userid, String beginDate, String endDate)
			throws SysException;

	public void saveAttenceLogBO(AttenceLogBO bo) throws SysException;

	public List getAttenceDayLogBO(String userid, String beginDate,
			String endDate) throws SysException;

	public List getAttenceDayMonthBO(String userid, String beginDate,
			String endDate) throws SysException;
	
	public List getAttFurloughRecBO(String personId, PageVO mypage,
			boolean isExist) throws SysException;

	public List findAttFurloughRecBO(String personId, PageVO mypage,
			String argment) throws SysException;
	
	public List findAttEvcctionRecBO(String personId, PageVO mypage,
			String argment) throws SysException;
	
	public List findAttOutWorkBO(String personId, PageVO mypage,
			String argment) throws SysException;
	
	public AttFurloughRecCollectBO findAttFurloughRecCollectBObyId(String id)
	throws SysException;
	
	public AttEvcctionRecCollectBO findAttEvcctionRecCollectBObyId(String id)
	throws SysException;
	
	public AttOutWorkCollectBO findAttOutWorkCollectBObyId(String id)
	throws SysException;
	
	public List getAttFurloughRecCollectBO(String personId, PageVO mypage) throws SysException;
	
	public void saveAttFurloughRecCollectBO(AttFurloughRecCollectBO bo) throws SysException;
	
	public List findAttFurloughRecCollectBO(String id) throws SysException;
	
	public List getAttEvcctionRecCollectBO(String personId, PageVO mypage) throws SysException;
	
	public List getAttOutWorkCollectBO(String personId, PageVO mypage) throws SysException;
	
	public List getAttFurloughRecBO1(String personId, PageVO mypage,
			boolean isExist,String operID,String deptID,User user) throws SysException;

	public List findAttFurloughRecBO(String id) throws SysException;
	
	public List findAttEvcctionRecBO(String id)
	throws SysException;
	
	public List findAttOutWorkBO(String id)
	throws SysException;
	
	public void saveAttFurloughRecBO(AttFurloughRecBO bo) throws SysException;

	public void deleteAttFurloughRecBO(String id) throws SysException;
	
	public void deleteAttEvcctionRecBO(String id) throws SysException;
	
	public void deleteAttOutWorkBO(String id) throws SysException;
	
	public List getAllAttClassGroupVO(String orgid) throws SysException;

	public AttFurloughRecBO findAttFurloughRecBObyId(String id)
			throws SysException;

	public List getAllAttfurloughBO() throws SysException;

	public AttfurloughBO findAttfurloughBObyId(String id) throws SysException;

	public List getAttEvcctionRecBO(String personId, PageVO mypage,
			boolean isExist) throws SysException;

	public List getAttEvcctionRecBO1(String personId, PageVO mypage,
			boolean isExist,String operID,String deptID,User user) throws SysException;

	public List getAttOutWorkBO1(String personId, PageVO mypage,boolean isExist,String operID,String deptID,User user) throws SysException;
	
	public List getAttOverTimeRecBO(String personId, PageVO mypage,
			boolean isExist,String operID,String deptID,User user) throws SysException;
	
	public void saveAttEvcctionRecBO(AttEvcctionRecBO bo) throws SysException;

	public void saveAttOutWorkBO(AttOutWorkBO bo) throws SysException;
	
	public AttEvcctionRecBO findAttEvcctionRecBObyId(String id)
			throws SysException;

	public AttOutWorkBO findAttOutWorkBObyId(String id)
	throws SysException;
	
	public List getAttChangeWorkBO(String personId, PageVO mypage,
			boolean isExist) throws SysException;

	public List getAttChangeWorkBO1(String personId, PageVO mypage,
			boolean isExist) throws SysException;

	public List getAttChangeWorkBO2(String personId) throws SysException;

	public List getAttChangeWorkBO3(String personId, String aDate)
			throws SysException;

	public void saveorupdateAttChangeWorkBO(AttChangeWorkBO bo)
			throws SysException;

	public AttChangeWorkBO findAttChangeWorkBObyId(String id)
			throws SysException;
	
	public List getAttAddWorkRecBO(String personId, PageVO mypage,boolean isExist) throws SysException;
	
	public void saveAttOverTimeRecBO(AttOverTimeRecBO bo) throws SysException;
	
	public AttOverTimeRecBO findAttOverTimeRecBObyId(String id) throws SysException;
	
	// 考勤计算
	public void saveAttCaclInfoBO(AttCaclInfoBO bo) throws SysException;

	public AttDurationBO findAttDurationBObyId(String id) throws SysException;

	public void saveorupdateAttDurationBO(AttDurationBO bo) throws SysException;

	public List getAttClassGroupVO(String orgID) throws SysException;

	public List getAttenceMonthBO(String userid,String duraYearMonth)
			throws SysException;
	
	public List getAttCaclInfoBO(String duraId) throws SysException;

	public void deleteAttCaclInfoBO(String duraID) throws SysException;
	
	public List getAttenceDayMonthBO(String userid, String beginDate)
			throws SysException;

	public List getAttenceDayMonthBOS(String userid, String beginDate,String endDate)
	throws SysException;
	
	public List getAttenceLogBO(String personId, String cardDate)
			throws SysException;

	public List getAttenceLogBO3(String userid,String day) throws SysException;
	
	public void processTrans(WFTransaction wt) throws SysException;

	public WFNodeBO getCurrentNode(String furloughNO) throws SysException;

	public List getAllPersonTable(String orgid, String name,String personType)
			throws SysException;
	
	public void insertInfoByCode(List lists, String itemId[])
			throws SysException;

	// 换班
	public AttClassBO changeWork(String orguid, String bo, String day)
			throws SysException;

	// 换班
	public AttClassBO changeWork1(String id,String orguid,String bo,String day)
			throws SysException;
	
	public void deleteAttChangeWorkBO(String id,String day) throws SysException;
	
	public Hashtable getRightDate(String orguid, String groupID, String aDate);

	//查看导入日志
	public List getAttImportAll(PageVO mypage) throws SysException;
	
    //设置考勤计算规则
	public List getAttCaclRuleBO(String orgID) throws SysException;
	
	public void saveorupdateAttCaclRuleBO(AttCaclRuleBO bo) throws SysException;
	
	public String findPersonID(String groupNo) throws SysException;
	
	public String findPersonNoToID(String personNo) throws SysException;
	
	public String findPersonNoToIDS(String oldPersonNo) throws SysException;
	
	//刷卡数据查询
	public String queryPersonList(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel, User user, String qryID,
                                  String addConditon,String beginDate,String endDate,String popuppostid,String argments,String cardtype) throws Exception;
	
	//汇总刷卡数据查询
	public String queryPersonList(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel, 
			User user, String qryID, String addConditon,String beginDate,String endDate,String perIds)
		throws Exception;
	
	//考勤月汇总查询
	public String queryPersonListandmonth(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel, 
			User user, String qryID, String addConditon,String beginDate,String endDate,String perIds)
		throws Exception;
	
	//考勤日汇总查询
	public String queryPersonListandday(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel, 
			User user, String qryID, String addConditon,String beginDate,String endDate,String perIds)
		throws Exception;
	
	//考勤项目规则
	public List getAllAttItemSetDetailBO(String orgID) throws SysException;
	
	public void saveorupdateAttItemSetDetailBO(AttItemSetDetailBO bo) throws SysException;
	
	public AttItemSetDetailBO findAttItemSetDetailBObyId(String id) throws SysException;
	
	public void deleteAttItemSetDetailBO(String id) throws SysException;
	
	public List findAllAttItemSetDetailBO(String itemCode,String orgID) throws SysException;
	
	public List getAllAttenceSet1(String orgid,String y,String m) throws SysException;
	
	public List findAllInfoItemBO(String setId) throws SysException;
	
	//浏览加班
	public void saveorupdateAttOverTimeLogBO(AttOverTimeLogBO bo) throws SysException;
	
	public List getAllAttOverTimeLogBO(String name,String beginTime,String superId,PageVO mypage) throws SysException;
	
	public List getCaclDay(String beginTime,String endTime) throws SysException;
	
	//网上申请天数的自动计算	
	public String cacldays(String id,String day,AttClassBO b) throws Exception;
	
	public String cacldays1(String id,String day,AttClassBO b) throws Exception;
	
	public void deleteAttenceLogBO(String orgId, String beginDate, String endDate,String name) throws SysException;

	public List getAttClassGroupVO(PageVO mypage,String orgId,String personType) throws SysException;
	
	public void saveorupdateAttAnnualDetailAuditBO(AttAnnualDetailAuditBO bo) throws SysException;
	
	public List getAttAnnualDetailAuditBO(String orgId, PageVO mypage,boolean isExist,String operID,String deptID,User user,String queryValue) throws SysException;
	
	//自动排班
	public List getAllAttenceStandBO(PageVO mypage) throws SysException;
	
	public List getAllAttenceStandBO(PageVO mypage,String orgId) throws SysException;
	
	public List getAllAttenceWaterBO(PageVO mypage,String date) throws SysException;
	
	public List getAllAttenceWeekWaterBO(PageVO mypage,String date) throws SysException;
	
	public List getAllAttenceWaterBO(PageVO mypage,String date,String orgId) throws SysException;
	
	public List getAllAttenceWeekWaterBO(PageVO mypage,String date,String orgId) throws SysException;
	
	public void saveorupdateAttenceStandBO(AttenceStandBO bo) throws SysException;
	
	public void saveorupdateAttenceWaterBO(AttenceWaterBO bo) throws SysException;
	
	public void saveorupdateAttenceWeekWaterBO(AttenceWeekWaterBO bo) throws SysException;
	
	public List findAttenceStandBO(String subId,String orgId) throws SysException;
	
	public List findAttenceWaterBO(String subId,String orgId) throws SysException;
	
	public List findAttenceWeekWaterBO(String subId,String orgId) throws SysException;
	
	public void UpdateB737(String orgId) throws SysException;
	
	public void UpdateB738(String orgId,String day) throws SysException;
	
	public void UpdateB739(String orgId,String day,String weekday) throws SysException;
	
	public String selectB737(String orgId) throws SysException;
	
	public List findAttenceStandBO2(String orgId) throws SysException;
	
	public List findAttenceStandBO1(String orgId) throws SysException;
	
	public List findAttenceWaterBO1(String orgId,String date) throws SysException;
	
	public List findAttenceWaterBO2(String orgId,String date) throws SysException;
	
	public List findAttenceWaterBO3(String orgId,String date) throws SysException;
	
	public List findAttenceWeekWaterBO1(String orgId,String date,String weekdate) throws SysException;
	
	public List getAllAttPersonArrangeBO(PageVO mypage,String superId) throws SysException;
	
	public List findAttPersonArrangeBO(String orgId) throws SysException;
	
	public void saveorupdateAttPersonArrangeBO(AttPersonArrangeBO bo) throws SysException;
	
	public List findGroupValues(String orgId) throws SysException;
	
	public AttPersonArrangeBO findAttPersonArrangeBObyId(String id) throws SysException;
	
	public List findPersonsAttClassGroupVO(String groupId) throws SysException;
	
	public List findPersonsAttClassGroupVO(String groupId,String deptId) throws SysException;
	
	public String selectB738(String orgId,String day) throws SysException;
	
	public String selectB739(String orgId,String day,String weekday) throws SysException;
	
	public void saveorupdateAttPersonArrangeItemBO(AttPersonArrangeItemBO bo) throws SysException;
	
	public String countAttPersonArrangeItemBO(String arrangeId,String day) throws SysException;
	
	public String countAttPersonArrangeItemBO1(String arrangeId,String day) throws SysException;
	
	public String countAttPersonArrangeItemBO3(String arrangeId,String day,String orgId) throws SysException;
	
	public String countAttPersonArrangeItemBO4(String arrangeId,String day,String orgId) throws SysException;
	
	public List getAllAttPersonArrangeItemBO(String arrangeId,String createDay) throws SysException;
	
	public List getAllAttPersonArrangeItemBO(String arrangeId,String createDay,String deptId) throws SysException;
	
	public List getAllAttPersonArrangeItemBO1(String arrangeId,String createDay) throws SysException;
	
	public List getAllAttPersonArrangeItemBO1(String arrangeId,String createDay,String deptId) throws SysException;
	
	public AttPersonArrangeItemBO findAttPersonArrangeItemBObyId(String id) throws SysException;
	
	public String getWeek(String day) throws Exception;
	
	public String countAttPersonArrangeItemBOEfficiency(String arrangeId) throws SysException;
	
	public String countAttPersonArrangeItemBOEfficiency1(String arrangeId) throws SysException;
	
	//存休
	public List findAttExistRestBO(String personId,String date) throws SysException;
	
	public int caclFeast(List daylists,String orgId) throws SysException;
	
	public void caclRest(List personGroupLists,AttPersonArrangeBO attpersonarrangebo,int sum) throws SysException;
	
	public String workflow(String linkId) throws SysException;
	
	public boolean weekCalendar(String orguid,String day) throws Exception;
	
	public boolean weekFeast(String orguid,String day) throws Exception;
	
	//倒休
	public void saveorupdateAttTimeOffRecBO(AttTimeOffRecBO bo) throws SysException;
	
	public AttTimeOffRecBO findAttTimeOffRecBObyId(String id) throws SysException;
	
	public List findAttTimeOffRecBO(String overTimeNO) throws SysException;
	
	public List findAttTimeOffRecBO(String personId,String overTimeNO) throws SysException;
	
	public List findAttTimeOffRecBO1(String personId,String overTimeNO) throws SysException;
	
	public void deleteAttTimeOffRecBO(String overTimeNO) throws SysException;
	
	public void deleteAttTimeOffRecBO1(String personId,String overTimeNO) throws SysException;
	
	public void deleteAttTimeOffRecBO2(String personId,String overTimeNO) throws SysException;
	
	public String calcpersongroup(String orgId,List daylists,List flagcharlists,String yearValueCale,String monthValueCale,String beginTime,String endTime,boolean isMon,boolean isExist,String perIdsValue)throws Exception;
	
	public List getEvcctionStateSearch(String orgId, PageVO mypage) throws SysException;
	
    //年假拟报
	public List getAttMimicReportRecBO(String personId, PageVO mypage,boolean isExist) throws SysException;
	
	public List findAttAnnualRecordBO(String orgid) throws SysException;
	
	public List findAttAnnualItemBO(String recID,String personId) throws SysException;
	
	public void saveAttMimicReportRecBO(AttMimicReportRecBO bo) throws SysException;
	
	public AttMimicReportRecBO findAttMimicReportRecBObyId(String id) throws SysException;
	
	public void deleteAttMimicReportRecBO(String id) throws SysException;
	
	public List findAttOverTimeRecBO(String personId, PageVO mypage,boolean isExist,String operID,String deptID,User user) throws SysException;

	public void UpdateAttenceDayMonthBO1(String orgId, String ym) throws SysException;
	
	public void UpdateAttenceDayMonthBO2(String orgId, String ym) throws SysException;
	
	public List findAttOverTimeLogBO(String personId, String date) throws SysException;
	
	public List getAllAttManagerArrangeBO(PageVO mypage,String superId) throws SysException;
	
	public List findAttManagerArrangeBO(String orgId) throws SysException;
	
	public void saveorupdateAttManagerArrangeBO(AttManagerArrangeBO bo) throws SysException;
	
	public List getAllAttManagerArgumentBO(PageVO mypage,String superId) throws SysException;
	
	public void saveorupdateAttManagerArgumentBO(AttManagerArgumentBO bo) throws SysException;
	
	public List getAllAttManagerArgumentBO(String superId) throws SysException;
	
	public List getAllAttManagerArgumentBO1(String deptId) throws SysException;
	
	public List getAllAttPersonArrangeItemBO2(String arrangeId,String deptId) throws SysException;
	
	public void deleteAttPersonArrangeItemBO(String amaId,String deptId) throws SysException;
	
	public AttManagerArrangeBO findAttManagerArrangeBObyId(String id) throws SysException;
	
	public List findAttManagerArgumentBO(String deptId) throws SysException;
	
	public void deleteAttManagerArgumentBO(String id) throws SysException;
	
	public AttManagerArgumentBO findAttManagerArgumentBObyId(String id) throws SysException;
	
	public List findCountAttPersonArrangeItemBO1(String arrangeId,String day,String orgId) throws SysException;
	
	public List findCountAttPersonArrangeItemBO2(String arrangeId,String day,String orgId) throws SysException;
	
	public List getAllAttTimeOffRecBO(PageVO mypage,String overTimeNO) throws SysException;
	
	public List getAllAttTimeOffRecBO(String overTimeNO) throws SysException;
	
	public void deleteAttImportLogBO(String id) throws SysException;
	
	public void saveAttOutWorkCollectBO(AttOutWorkCollectBO bo) throws SysException;
	
	public void saveAttEvcctionRecCollectBO(AttEvcctionRecCollectBO bo) throws SysException;
	
	public List getAllAttAnnualDetailAuditBO(PageVO mypage,String furloughNO) throws SysException;
	
	public List getAllAttAnnualDetailAuditBO(String furloughNO) throws SysException;
	
	public String getFlowProcess(String pid, String judgeFun, String type) throws SysException;
	
	public List findAttModifyTimeOffList(String name,String beginTime,String superId,PageVO mypage) throws SysException;
	
    public List getAllAttClassUserList(String classId,String userType) throws SysException;
    
    public void deleteAttClassUserBO(AttClassUserBO user) throws SysException;

    public void saveAttClassUserBO(AttClassUserBO user) throws SysException;
    
    public String readSign(String orgID) throws SysException;
    
    public List getSelfSignInfo(String userID, String date) throws SysException;
    
}
