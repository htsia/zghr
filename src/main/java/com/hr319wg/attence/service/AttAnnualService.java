package com.hr319wg.attence.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import com.hr319wg.attence.dao.AttAnnualMgrDAO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailAuditBO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailBO;
import com.hr319wg.attence.pojo.bo.AttAnnualExcludeBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRecordBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRuleBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRuleItemBO;
import com.hr319wg.attence.pojo.bo.AttExecludeRuleBO;
import com.hr319wg.attence.pojo.bo.AttExecludeRuleItemBO;
import com.hr319wg.attence.pojo.bo.AttMimicReportRecBO;
import com.hr319wg.attence.pojo.bo.AttenceSecondDayLogBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CommonFuns;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-2
 * Time: 上午11:12
 * To change this template use File | Settings | File Templates.
 */
public class AttAnnualService {
    private AttAnnualMgrDAO attAnnualMgrDao;
    private ActivePageAPI activeapi;


    public List getAllAttAnnualRecordBO(PageVO pagevo, String orgid)throws SysException{
        return this.attAnnualMgrDao.getAllAttAnnualRecordBO(pagevo,orgid);
    }

    public AttAnnualRecordBO findEquealsAttAnnualRecordBO(String orgId,String year)throws SysException{
        return  this.attAnnualMgrDao.findEquealsAttAnnualRecordBO(orgId,year);
    }

    public AttAnnualRecordBO findExcuteAttAnnualRecordBO(String orgId)throws SysException{
        return this.attAnnualMgrDao.findExcuteAttAnnualRecordBO(orgId);
    }

    public AttAnnualRecordBO findAttAnnualRecordBOById(String recID)throws SysException{
        return (AttAnnualRecordBO)this.attAnnualMgrDao.findBoById(AttAnnualRecordBO.class,recID);
    }

    public void saveAttAnnualRecordBO(AttAnnualRecordBO bo)throws SysException{
        this.attAnnualMgrDao.saveOrUpdateBo(bo);
    }

    public void deleteAttAnnualRecordBO(String id) throws SysException {
		this.attAnnualMgrDao.deleteBo(AttAnnualRecordBO.class, id);
	}


    public List getAllAttAnnualItemBO(PageVO pagevo, String recID,String personValue) throws SysException{
        return this.attAnnualMgrDao.getAllAttAnnualItemBO(pagevo,recID,personValue);
    }

    public List getAttAnnualItemBOByPid(PageVO pagevo, String personId)throws SysException{
        return this.attAnnualMgrDao.getAttAnnualItemBOByPid(pagevo,personId);
    }

    public List getAttAnnualItemBO(String recID) throws SysException{
        return this.attAnnualMgrDao.getAttAnnualItemBO(recID);
    }

    public void deleteAttAnnualItemBOByRecID(String recId) throws SysException{
		String sql = "delete from ATT_ANNUAL_ITEM  where REC_ID='" + recId + "'";
		activeapi.executeSql(sql);
	}

    public void deleteEqualsAttAnnualItemBO(String recId,String personId)throws SysException {
		String sql="delete from ATT_ANNUAL_ITEM where REC_ID='"+recId+"' and PERSON_ID='"+personId+"'";
		activeapi.executeSql(sql);
	}

    public void saveAttAnnualItemBO(AttAnnualItemBO bo)throws SysException{
        this.attAnnualMgrDao.saveOrUpdateBo(bo);
    }

    public AttAnnualItemBO findAttAnnualItemBObyId(String id)throws SysException {
		return (AttAnnualItemBO) attAnnualMgrDao.findBoById(AttAnnualItemBO.class, id);
	}

    public  AttAnnualItemBO findEqualsAttAnnualItemBO(String personId,String recId)throws SysException{
        return this.attAnnualMgrDao.findEqualsAttAnnualItemBO(personId,recId);
    }



    public void deleteAttAnnualDetailBOByRecID(String recId) throws SysException{
		String sql = "delete from  ATT_ANNUAL_DETAIL  where ITEM_ID in (select  ITEM_ID  from  ATT_ANNUAL_ITEM  where REC_ID='" + recId + "')";
		activeapi.executeSql(sql);
	}

    public void saveAttAnnualDetailBO(AttAnnualDetailBO bo) throws SysException{
           this.attAnnualMgrDao.saveOrUpdateBo(bo);
    }

    public AttAnnualDetailBO findAttAnnualDetailBObyId(String id) throws SysException{
        return (AttAnnualDetailBO)this.attAnnualMgrDao.findBoById(AttAnnualDetailBO.class,id);
    }

    public List getAllAttAnnualDetailBOByItemId(String itemID) throws SysException{
        return this.attAnnualMgrDao.getAllAttAnnualDetailBOByItemId(itemID);
    }

    public void deleteAttAnnualDetailBO(String id) throws SysException {
		this.attAnnualMgrDao.deleteBo(AttAnnualDetailBO.class, id);
	}



    public void deleteAttAnnualExcludeBO() throws SysException {
		String sql="delete from ATT_ANNUAL_EXCLUDE where MODE_VALUE<>'1'";
		activeapi.executeSql(sql);
	}

    public List getAllAttAnnualExcludeBO(PageVO pagevo, String recId)throws SysException{
        return this.attAnnualMgrDao.getAllAttAnnualExcludeBO(pagevo,recId);
    }


    public void saveAttAnnualExcludeBO(AttAnnualExcludeBO bo)throws SysException {
		this.attAnnualMgrDao.saveOrUpdateBo(bo);
	}


    public List getAttAnnualRuleItemBO(String ruleID) throws SysException{
        return this.attAnnualMgrDao.getAttAnnualRuleItemBO(ruleID);
    }

    public List getAttExecludeRuleBO(String orgid) throws SysException{
        return this.attAnnualMgrDao.getAttExecludeRuleBO(orgid);
    }

    public AttExecludeRuleBO findAttExecludeRuleBObyId(String id)throws SysException {
        return (AttExecludeRuleBO) this.attAnnualMgrDao.findBoById(AttExecludeRuleBO.class, id);
    }

    public void deleteAttExecludeRuleBO(String id) throws SysException {
        this.attAnnualMgrDao.deleteBo(AttExecludeRuleBO.class, id);
    }

    public void saveAttExecludeRuleBO(AttExecludeRuleBO bo)throws SysException {
        this.attAnnualMgrDao.saveOrUpdateBo(bo);
    }

    public List getAllAttAnnualRuleBOByOrgId(String orgid) throws SysException {
		return this.attAnnualMgrDao.getAllAttAnnualRuleBOByOrgId(orgid);
	}

	public List getAllCommonAttAnnualRuleBO(String orgid) throws SysException {
		return this.attAnnualMgrDao.getAllCommonAttAnnualRuleBO(orgid);
	}

    public List getAttExecludeRuleItemBO(String ruleId) throws SysException{
        return this.attAnnualMgrDao.getAttExecludeRuleItemBO(ruleId);
    }

    public AttExecludeRuleItemBO findAttExecludeRuleItemBObyId(String id)throws SysException {
        return (AttExecludeRuleItemBO) attAnnualMgrDao.findBoById( AttExecludeRuleItemBO.class, id);
    }

    public void deleteAttExecludeRuleItemBO(String id) throws SysException {
        this.attAnnualMgrDao.deleteBo(AttExecludeRuleItemBO.class, id);
    }

    public void saveAttExecludeRuleItemBO(AttExecludeRuleItemBO bo)throws SysException {
        this.attAnnualMgrDao.saveOrUpdateBo(bo);
    }
    public void deleteAttenceSecondDayLogBO(String id, String day) throws SysException {
        String sql = "delete from A807 where ID='" + id + "' and A807700='" + day + "'";
        this.activeapi.executeSql(sql);
    }

    public void saveAttenceSecondDayLogBO(AttenceSecondDayLogBO bo)throws SysException {
		this.attAnnualMgrDao.createBo(bo);
	}


    public AttAnnualRuleBO findAttAnnualRuleBObyId(String id)throws SysException{
		return (AttAnnualRuleBO) attAnnualMgrDao.findBoById(AttAnnualRuleBO.class, id);
	}

    public void deleteAttAnnualRuleBO(String id) throws SysException{
		this.attAnnualMgrDao.deleteBo(AttAnnualRuleBO.class, id);
	}

    public void saveAttAnnualRuleBO(AttAnnualRuleBO bo)throws SysException {
		this.attAnnualMgrDao.saveOrUpdateBo(bo);
	}

    public AttAnnualRuleItemBO findAttAnnualRuleItemBObyId(String id)throws SysException {
        return (AttAnnualRuleItemBO)this.attAnnualMgrDao.findBoById(AttAnnualRuleItemBO.class, id);
    }

    public void deleteAttAnnualRuleItemBO(String id) throws SysException {
        this.attAnnualMgrDao.deleteBo(AttAnnualRuleItemBO.class, id);
    }

    public void saveAttAnnualRuleItemBO(AttAnnualRuleItemBO bo)throws SysException {
        this.attAnnualMgrDao.saveOrUpdateBo(bo);
    }

    public AttClassGroupVO findAttClassGroupVObyId(String id)throws SysException {
        return (AttClassGroupVO) attAnnualMgrDao.findBoById(AttClassGroupVO.class,id);
    }

    public AttAnnualItemBO findEqualsAttAnnualItemBO(String personId, String orgId, String datevalue)throws SysException{
        return this.attAnnualMgrDao.findEqualsAttAnnualItemBO(personId,orgId,datevalue);
    }

    public AttAnnualDetailAuditBO findAttAnnualDetailAuditBObyId(String id)throws SysException {
        return (AttAnnualDetailAuditBO) attAnnualMgrDao.findBoById( AttAnnualDetailAuditBO.class, id);
    }

    public List getAttAnnualDetailAuditBO(String itemID) throws SysException{
        return this.attAnnualMgrDao.getAttAnnualDetailAuditBO(itemID);
    }

    public String getA001737(String personid) throws SysException {
        String sql = "select A001737 from a001 where id='" + personid + "'";
        return activeapi.queryForString(sql);
    }

    public void deleteAttAnnualDetailAuditBO(String id) throws SysException {
        this.attAnnualMgrDao.deleteBo(AttAnnualDetailAuditBO.class, id);
    }

    /*
	 * 日期区间计算
	 */
	public List cacl(String startYear, String endYear) {
		List list = new ArrayList();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			if (startYear != null && !"".equals(startYear) && endYear != null
					&& !"".equals(endYear)) {
				Date bedates = df.parse(startYear);
				Date endates = df.parse(endYear);
				long days = (endates.getTime() - bedates.getTime())
						/ (1000 * 60 * 60 * 24);
				Calendar becalendar = Calendar.getInstance();
				becalendar.setTime(bedates);
				for (int i = 0; i <= days; i++) {
					becalendar.setTime(bedates);
					becalendar.add(Calendar.DATE, i);
					list.add((df.format(becalendar.getTime())));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

    /**
     *  年假计算
      * @param superId
     * @param recID
     * @return
     */
    public String caleAttAnnualItemBO(String superId, String recID) throws SysException{
		String name = "";
		try {
			AttAnnualRecordBO attannualrecordbo = this.findAttAnnualRecordBOById(recID);
			List daylists = cacl(attannualrecordbo.getYearBegin(),
					attannualrecordbo.getYearEnd());
			List lists = getAttAnnualRuleItemBO(attannualrecordbo.getRuleID());
			if (lists != null && lists.size() > 0) {
				String names = Constants.IN_SERVICE_TYPE;
				String sql = "";
				if ("ORACLE".equals(Constants.DB_TYPE)) {
					sql = "select a.id,a.A001044,a.A001041 from a001 a where a.id not like '#%' and (a.A001044<>'' or a.A001044 is not null) and (a.A001041<>'' or a.A001041 is not null) and a.A001701='"
							+ superId + "' and a.A001054 in (" + names + ")";
				} else {
					sql = "select a.id,a.A001044,a.A001041 from a001 a where a.id not like '#%' and a.A001044<>'' and a.A001044 is not null and a.A001041<>'' and a.A001041 is not null and a.A001701='"
							+ superId + "' and a.A001054 in (" + names + ")";
				}

				CellVO[] head = new CellVO[3];
				head[0] = new CellVO();
				head[0].setItemId("id");
				head[1] = new CellVO();
				head[1].setItemId("A001044");
				head[2] = new CellVO();
				head[2].setItemId("A001041");
				Vector rs = activeapi.getDataListBySql(head, sql); // api
				// 是ActivePageAPI
				for (int i = 0; i < rs.size(); i++) {
					CellVO[] row = (CellVO[]) rs.get(i);
					String id = row[0].getValue(); // 人员ID
					String orgEnterDates = row[1].getValue();// 进入本单位时间
					String systemEnterDates = row[2].getValue();// 参加工作时间
					HashMap personClass = new HashMap();
					String[] argmentvalues = new String[4];
					for (int q = 0; q < daylists.size(); q++) {
						String caledatevalue = (String) daylists.get(q);
						SimpleDateFormat dfvalue = new SimpleDateFormat(
								"yyyy-MM-dd");
						Date datevalue1 = dfvalue.parse(caledatevalue);
						Date datevalue2 = dfvalue.parse(orgEnterDates);
						Date datevalue3 = dfvalue.parse(systemEnterDates);
						double orgYearsNumber = (double) ((datevalue1.getTime() - datevalue2
								.getTime()) / (1000 * 60 * 60 * 24)) / 365;// 本单位工龄
						double yearsNumber = (double) ((datevalue1.getTime() - datevalue3
								.getTime()) / (1000 * 60 * 60 * 24)) / 365;// 系统工龄
						for (int j = 0; j < lists.size(); j++) {
							AttAnnualRuleItemBO attannualruleitembo = (AttAnnualRuleItemBO) lists
									.get(j);
							int lowNumber = Integer
									.parseInt(attannualruleitembo.getLowValue());
							int highNumber = Integer
									.parseInt(attannualruleitembo
											.getHighValue());
							if (orgYearsNumber >= 1 && orgYearsNumber < 2) {
								String day = orgEnterDates;
								SimpleDateFormat df = new SimpleDateFormat(
										"yyyy-MM-dd");
								Date dates = df.parse(day);
								Calendar calendar = Calendar.getInstance();
								calendar.setTime(dates);
								calendar.add(Calendar.YEAR, 1);
								calendar.add(Calendar.DATE, 1);
								String day1 = new SimpleDateFormat("yyyy-MM-dd")
										.format(calendar.getTime());
								String day2 = new SimpleDateFormat("yyyy")
										.format(calendar.getTime());
								if (day2.equals(attannualrecordbo
										.getRecodeYear())) {
									String day3 = attannualrecordbo
											.getRecodeYear().trim()
											+ "-12-31";
									DateFormat df1 = new SimpleDateFormat(
											"yyyy-MM-dd");
									Date date4 = df1.parse(day1);
									Date date5 = df1.parse(day3);
									double date6 = (double) (date5.getTime() - date4
											.getTime())
											/ (1000 * 60 * 60 * 24);
									// 新入职员工符合本办法第二条规定的，当年度年休假天数，按照在本企业剩余日历天数折算确定，折算后不足1整天的部分不享受年休假。
									// 折算方法为：（当年度在本企业剩余日历天数÷365天）×员工本人全年应当享受的年休假天数。
									if (yearsNumber >= lowNumber
											&& yearsNumber < highNumber) {
										String[] vip = (String[]) personClass
												.get(attannualruleitembo
														.getItemID());
										if (vip == null) {
											double date7 = Double
													.parseDouble(attannualruleitembo
															.getAnnDay().trim());
											double sum = (date6 / 365) * date7;
											double sum1 = Math.floor(sum);
											if (sum1 > 0) {
												String sum2 = sum1 + "";
												argmentvalues[0] = recID;
												argmentvalues[1] = id;
												argmentvalues[2] = sum2.trim();
												argmentvalues[3] = caledatevalue;
												personClass.put(
														attannualruleitembo
																.getItemID(),
														argmentvalues);
												argmentvalues = new String[4];
											}
										}
										break;
									}
								} else {
									if (yearsNumber >= lowNumber
											&& yearsNumber < highNumber) {
										String[] vip = (String[]) personClass
												.get(attannualruleitembo
														.getItemID());
										if (vip == null) {
											argmentvalues[0] = recID;
											argmentvalues[1] = id;
											argmentvalues[2] = attannualruleitembo
													.getAnnDay();
											argmentvalues[3] = caledatevalue;

											personClass
													.put(attannualruleitembo
															.getItemID(),
															argmentvalues);
											argmentvalues = new String[4];
										}
										break;
									}
								}
							} else if (orgYearsNumber >= 2) {
								if (yearsNumber >= lowNumber
										&& yearsNumber < highNumber) {
									String[] vip = (String[]) personClass
											.get(attannualruleitembo
													.getItemID());
									if (vip == null) {
										argmentvalues[0] = recID;
										argmentvalues[1] = id;
										argmentvalues[2] = attannualruleitembo
												.getAnnDay();
										argmentvalues[3] = caledatevalue;
										personClass.put(attannualruleitembo
												.getItemID(), argmentvalues);
										argmentvalues = new String[4];
									}
									break;
								}
							}
						}

					}
					if (personClass != null && personClass.size() > 0) {
						if (personClass.size() == 1) {
							AttAnnualItemBO attannualitembo = new AttAnnualItemBO();
							Iterator it = personClass.keySet().iterator();
							while (it.hasNext()) {
								String keyvalue = (String) it.next();
								String[] valuevalue = (String[]) personClass
										.get(keyvalue);
								attannualitembo.setRecID(valuevalue[0]);
								attannualitembo.setPersonID(valuevalue[1]);
								if (!valuevalue[3].equals(attannualrecordbo
										.getYearBegin())) {
									attannualitembo.setAnnDay("");
									attannualitembo.setUseDay("");
									attannualitembo.setAvaDay("");
									attannualitembo
											.setCriticalDate(valuevalue[3]);
									attannualitembo
											.setCriticalAnnDay(valuevalue[2]);
									attannualitembo.setCalcAnnDay("0");
									attannualitembo
											.setCriticalAvaDay(valuevalue[2]);
								} else {
									attannualitembo.setAnnDay(valuevalue[2]);
									attannualitembo.setUseDay("0");
									attannualitembo.setAvaDay(valuevalue[2]);
									attannualitembo.setCriticalDate("");
									attannualitembo.setCriticalAnnDay("");
									attannualitembo.setCalcAnnDay("");
									attannualitembo.setCriticalAvaDay("");
								}
								attannualitembo.setCalcDate(CommonFuns
										.getSysDate("yyyy-MM-dd HH:mm:ss"));
								if (orgEnterDates != null
										&& !"".equals(orgEnterDates)) {
									attannualitembo.setEnterDate(orgEnterDates);
								}
								if (systemEnterDates != null
										&& !"".equals(systemEnterDates)) {
									attannualitembo
											.setWorkDate(systemEnterDates);
								}
							}
							saveAttAnnualItemBO(attannualitembo);
						} else if (personClass.size() == 2) {
							List listvaluevalue = new ArrayList();
							AttAnnualItemBO attannualitembo = new AttAnnualItemBO();
							Iterator it = personClass.keySet().iterator();
							while (it.hasNext()) {
								String keyvalue = (String) it.next();
								String[] valuevalue = (String[]) personClass
										.get(keyvalue);
								listvaluevalue.add(valuevalue);
							}
							String[] valuevaluelist1 = (String[]) listvaluevalue
									.get(0);
							String[] valuevaluelist2 = (String[]) listvaluevalue
									.get(1);
							attannualitembo.setRecID(valuevaluelist1[0]);
							attannualitembo.setPersonID(valuevaluelist1[1]);
							double doublevalue1 = Double
									.parseDouble(valuevaluelist1[2]);
							double doublevalue2 = Double
									.parseDouble(valuevaluelist2[2]);
							if (doublevalue1 > doublevalue2) {
								attannualitembo.setAnnDay(valuevaluelist2[2]);
								attannualitembo.setUseDay("0");
								attannualitembo.setAvaDay(valuevaluelist2[2]);
								attannualitembo
										.setCriticalDate(valuevaluelist1[3]);
								attannualitembo
										.setCriticalAnnDay(valuevaluelist1[2]);
								attannualitembo.setCalcAnnDay("0");
								attannualitembo
										.setCriticalAvaDay(valuevaluelist1[2]);
							} else {
								attannualitembo.setAnnDay(valuevaluelist1[2]);
								attannualitembo.setUseDay("0");
								attannualitembo.setAvaDay(valuevaluelist1[2]);
								attannualitembo
										.setCriticalDate(valuevaluelist2[3]);
								attannualitembo
										.setCriticalAnnDay(valuevaluelist2[2]);
								attannualitembo.setCalcAnnDay("0");
								attannualitembo
										.setCriticalAvaDay(valuevaluelist2[2]);
							}
							attannualitembo.setCalcDate(CommonFuns
									.getSysDate("yyyy-MM-dd HH:mm:ss"));
							if (orgEnterDates != null
									&& !"".equals(orgEnterDates)) {
								attannualitembo.setEnterDate(orgEnterDates);
							}
							if (systemEnterDates != null
									&& !"".equals(systemEnterDates)) {
								attannualitembo.setWorkDate(systemEnterDates);
							}
							saveAttAnnualItemBO(attannualitembo);
						}
					}
					personClass = new HashMap();
				}

				String sqlView3 = "delete from ATT_ANNUAL_ITEM where PERSON_ID in (select PERSON_ID from ATT_ANNUAL_EXCLUDE where MODE_VALUE='1')";
				activeapi.executeSql(sqlView3);
				String sqlView2 = "select PERSON_ID from ATT_ANNUAL_ITEM where PERSON_ID in (select id from a001 where A001701='"
						+ superId + "')";
				CellVO[] head1 = new CellVO[1];
				head1[0] = new CellVO();
				head1[0].setItemId("PERSON_ID");
				Vector rs1 = activeapi.getDataListBySql(head1, sqlView2);
				if (rs1 != null && rs1.size() > 0) {
					String ymd1 = CommonFuns.getSysDate("yyyyMMdd");
					String ymd2 = CommonFuns.getSysDate("HHmmss");
					int roundNumber = 1 + (int) (Math.random() * 100);
					String roundNumbers = roundNumber + "";
					String viestables = "VIEW" + ymd1 + "" + ymd2 + ""
							+ roundNumbers + "NAME";
					String sqlView = "";
					if ("ORACLE".equals(Constants.DB_TYPE)) {
						sqlView += "create VIEW "
								+ viestables
								+ " AS select S.ID,S.A811704,S.A811705,S.A811706,S.A811707,S.A811708,S.A811709,S.A811710,S.A811711,S.A811712,S.A811713,S.A811714,S.A811715,";
						sqlView += "S.A811700,S.ANN_DAY,M.A811704 as Last_A811704,M.A811705 as Last_A811705,M.A811706 as Last_A811706,M.A811707 as Last_A811707,";
						sqlView += "M.A811708 as Last_A811708,M.A811709 as Last_A811709,M.A811710 as Last_A811710,M.A811711 as Last_A811711,M.A811712 as Last_A811712,M.A811713 as Last_A811713,M.A811714 as Last_A811714,M.A811715 as Last_A811715 ";
						sqlView += "from (SELECT a.ID as ID,a.A811704 as A811704,a.A811705 as A811705,a.A811706 as A811706,a.A811707 as A811707,a.A811708 as A811708,a.A811709 as A811709,a.A811710 as A811710,a.A811711 as A811711,a.A811712 as A811712,a.A811713 as ";
						sqlView += "A811713,a.A811714 as A811714,a.A811715 as A811715,a.A811700 as A811700,b.ANN_DAY as ANN_DAY FROM  A811 a left join ATT_ANNUAL_ITEM b on a.ID=b.PERSON_ID)  S left join A811 M on 0+isnull(M.A811700,'0')=0+isnull(S.A811700,'0')-1";
					} else {
						sqlView += "create VIEW "
								+ viestables
								+ " AS select S.ID,S.A811704,S.A811705,S.A811706,S.A811707,S.A811708,S.A811709,S.A811710,S.A811711,S.A811712,S.A811713,S.A811714,S.A811715,";
						sqlView += "S.A811700,S.ANN_DAY,M.A811704 as Last_A811704,M.A811705 as Last_A811705,M.A811706 as Last_A811706,M.A811707 as Last_A811707,";
						sqlView += "M.A811708 as Last_A811708,M.A811709 as Last_A811709,M.A811710 as Last_A811710,M.A811711 as Last_A811711,M.A811712 as Last_A811712,M.A811713 as Last_A811713,M.A811714 as Last_A811714,M.A811715 as Last_A811715 ";
						sqlView += "from (SELECT a.ID as ID,a.A811704 as A811704,a.A811705 as A811705,a.A811706 as A811706,a.A811707 as A811707,a.A811708 as A811708,a.A811709 as A811709,a.A811710 as A811710,a.A811711 as A811711,a.A811712 as A811712,a.A811713 as ";
						sqlView += "A811713,a.A811714 as A811714,a.A811715 as A811715,a.A811700 as A811700,b.ANN_DAY as ANN_DAY FROM  A811 a left join ATT_ANNUAL_ITEM b on a.ID=b.PERSON_ID)  S left join A811 M on cast(M.A811700 as int)=cast(S.A811700 as int)-1";
					}
					activeapi.executeSql(sqlView);
					for (int w = 0; w < rs1.size(); w++) {
						CellVO[] row1 = (CellVO[]) rs1.get(w);
						String personids1 = row1[0].getValue(); // 人员ID
						List list = getAttExecludeRuleBO(superId);
						if (list != null && list.size() > 0) {
							for (int i = 0; i < list.size(); i++) {
								AttExecludeRuleBO attexecluderulebo = (AttExecludeRuleBO) list
										.get(i);
								List list1 = getAttExecludeRuleItemBO(attexecluderulebo
										.getRuleId());
								if (list1 != null && list1.size() > 0) {
									for (int j = 0; j < list1.size(); j++) {
										String sqlView1 = "select a.ID from "
												+ viestables
												+ " a,"
												+ viestables
												+ " b,a796 c where a.ID=b.ID and b.ID=c.ID and a.A811700=b.A811700 and a.A811700='"
												+ attannualrecordbo
														.getRecodeYear() + "' ";
										AttExecludeRuleItemBO attexecluderuleitembo = (AttExecludeRuleItemBO) list1
												.get(j);
										sqlView1 += " and ("
												+ attexecluderuleitembo
														.getContentSql() + ") ";
										sqlView1 += " and a.ID='" + personids1
												+ "'";
										String personids2 = activeapi
												.queryForString(sqlView1);
										if (personids2 != null
												&& !"".equals(personids2)) {
											String deletes1 = "delete from ATT_ANNUAL_ITEM where PERSON_ID='"
													+ personids1 + "'";
											activeapi.executeSql(deletes1);
											AttAnnualExcludeBO attannualexcludebo = new AttAnnualExcludeBO();
											attannualexcludebo.setRecId(recID);
											attannualexcludebo
													.setPersonId(personids1);
											attannualexcludebo.setMode("0");
											attannualexcludebo
													.setCause(attexecluderuleitembo
															.getContentDes());
											saveAttAnnualExcludeBO(attannualexcludebo);
											continue;
										}
									}
								}
							}
						}
					}
					String droptables = "drop view " + viestables;
					activeapi.executeSql(droptables);
				}
				attannualrecordbo.setLastCaclDate(CommonFuns
						.getSysDate("yyyy-MM-dd"));
				saveAttAnnualRecordBO(attannualrecordbo);
			} else {
				name = "年假规则项目列表为空，无法进行初始化。";
			}
		} catch (Exception e) {

		}
		return name;
	}


    public List getAllAttMimicReportRecBO(PageVO pagevo, String orgId,String personValue,String timeValue,String status)throws SysException{
        return this.attAnnualMgrDao.getAllAttMimicReportRecBO(pagevo,orgId,personValue,timeValue,status);
    }

    public AttMimicReportRecBO findAttMimicReportRecBOById(String mimicReportNO)throws SysException{
        return (AttMimicReportRecBO)this.attAnnualMgrDao.findBoById(AttMimicReportRecBO.class,mimicReportNO);
    }

    public void saveAttMimicReportRecBO(AttMimicReportRecBO bo)throws SysException{
        this.attAnnualMgrDao.saveOrUpdateBo(bo);
    }

    public void deleteAttMimicReportRecBO(String mimicReportNO)throws SysException{
        this.attAnnualMgrDao.deleteBo(AttMimicReportRecBO.class,mimicReportNO);
    }

    public AttAnnualMgrDAO getAttAnnualMgrDao() {
        return attAnnualMgrDao;
    }

    public void setAttAnnualMgrDao(AttAnnualMgrDAO attAnnualMgrDao) {
        this.attAnnualMgrDao = attAnnualMgrDao;
    }

     public ActivePageAPI getActiveapi() {
        return activeapi;
    }

    public void setActiveapi(ActivePageAPI activeapi) {
        this.activeapi = activeapi;
    }

}
