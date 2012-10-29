package com.hr319wg.attence.service;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import com.hr319wg.attence.dao.AttDurationDAO;
import com.hr319wg.attence.dao.AttFeastDAO;
import com.hr319wg.attence.dao.AttRestWeekDAO;
import com.hr319wg.attence.dao.CardMessageDAO;
import com.hr319wg.attence.dao.GroupMgrDAO;
import com.hr319wg.attence.pojo.bo.ATTRearrangeBO;
import com.hr319wg.attence.pojo.bo.ATTRearrangeDateBO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailAuditBO;
import com.hr319wg.attence.pojo.bo.AttCaclRuleBO;
import com.hr319wg.attence.pojo.bo.AttChangeWorkBO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassDetailBO;
import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttExistRestBO;
import com.hr319wg.attence.pojo.bo.AttFeastBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttItemSetDetailBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkCollectBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeLogBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeItemBO;
import com.hr319wg.attence.pojo.bo.AttRestOfWeekBO;
import com.hr319wg.attence.pojo.bo.AttTimeOffRecBO;
import com.hr319wg.attence.pojo.bo.AttWorkDateBO;
import com.hr319wg.attence.pojo.bo.AttYearCollectBO;
import com.hr319wg.attence.pojo.bo.AttenceDayLogBO;
import com.hr319wg.attence.pojo.bo.AttenceDayMonthBO;
import com.hr319wg.attence.pojo.bo.AttenceLogBO;
import com.hr319wg.attence.pojo.bo.AttenceSecondDayLogBO;
import com.hr319wg.attence.pojo.bo.AttfurloughBO;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.dao.WorkFlowDAO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.bo.WFProcessBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class AttDataProcessService {
	private WorkFlowDAO wfdao;
	private AttDurationDAO attenceSetDAO;
	private CardMessageDAO cardMessageDAO;
	private AttRestWeekDAO attrestweekDAO;
	public final static String dayNames[] = { "sun", "mon", "tues", "wed",
			"thur", "fri", "sat" };
	private AttFeastDAO attfeastDAO;
	private ActivePageAPI activeapi;
	private GroupMgrDAO groupMgrDAO;

    public static final String CACL_PERS = "2"; //精度控制接口

	public WorkFlowDAO getWfdao() {
		return wfdao;
	}

	public void setWfdao(WorkFlowDAO wfdao) {
		this.wfdao = wfdao;
	}

	public AttDurationDAO getAttenceSetDAO() {
		return attenceSetDAO;
	}

	public void setAttenceSetDAO(AttDurationDAO attenceSetDAO) {
		this.attenceSetDAO = attenceSetDAO;
	}

	public CardMessageDAO getCardMessageDAO() {
		return cardMessageDAO;
	}

	public void setCardMessageDAO(CardMessageDAO cardMessageDAO) {
		this.cardMessageDAO = cardMessageDAO;
	}

	public AttRestWeekDAO getAttrestweekDAO() {
		return attrestweekDAO;
	}

	public void setAttrestweekDAO(AttRestWeekDAO attrestweekDAO) {
		this.attrestweekDAO = attrestweekDAO;
	}

	public AttFeastDAO getAttfeastDAO() {
		return attfeastDAO;
	}

	public void setAttfeastDAO(AttFeastDAO attfeastDAO) {
		this.attfeastDAO = attfeastDAO;
	}

	public ActivePageAPI getActiveapi() {
		return activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}

	public GroupMgrDAO getGroupMgrDAO() {
		return groupMgrDAO;
	}

	public void setGroupMgrDAO(GroupMgrDAO groupMgrDAO) {
		this.groupMgrDAO = groupMgrDAO;
	}

	public AttClassGroupBO findAttClassGroupBObyId(String id)
			throws SysException {
		return (AttClassGroupBO) groupMgrDAO.findBoById(AttClassGroupBO.class,
				id);
	}

	public List getATTRearrangeBO(String orgid) throws SysException {
		return groupMgrDAO.getATTRearrangeBO(orgid);
	}

	public AttClassBO findAttClassBObyId(String id) throws SysException {
		return (AttClassBO) groupMgrDAO.findBoById(AttClassBO.class, id);
	}

   public Hashtable getAllAttClassGroupBOForHash()throws SysException{
       return this.groupMgrDAO.getAllAttClassGroupBOForHash();
   }
   public Hashtable getAllAttClassBOForHash()throws SysException{
       return this.groupMgrDAO.getAllAttClassBOForHash() ;
   }

	/*
	 * 正常班日历计算
	 */
	public Hashtable getRightDate(String orguid, String groupID, String aDate) {
		Hashtable hashTable = new Hashtable();
		/*
		 * 日期列表
		 */
		String yearvalue = aDate.substring(0, 4); // 年份
		String monthvalue = aDate.substring(5, 7);// 月份
		int days = MonthDays(Integer.parseInt(monthvalue), Integer
				.parseInt(yearvalue));// 月份的天数
		String[] monthseq = new String[days];
		for (int j = 1; j <= days; j++) {
			String date1 = "";
			if (j < 10) {
				date1 = aDate + "-0" + j;
			} else {
				date1 = aDate + "-" + j;
			}
			monthseq[j - 1] = date1;
		}
		try {
            AttRestOfWeekBO attrestofweekbo = getAttRestOfWeekBOByOrgid(orguid);
            List lists = getAllAttFeast(orguid);
			List lists1 = getAllAttFeast("-1");
            Hashtable grouphash=this.groupMgrDAO.getAllAttClassGroupBOForHash();
            Hashtable classhash=this.groupMgrDAO.getAllAttClassBOForHash();
			for (int s = 0; s < monthseq.length; s++) {
				String ss = monthseq[s];

				/*
				 * 查询班次信息
				 */
				if (groupID != null && !"".equals(groupID)) {
					AttClassGroupBO attclassgroupbo =(AttClassGroupBO)grouphash.get(groupID);
					AttClassBO attclassbo = (AttClassBO)classhash.get(attclassgroupbo
							.getLinkClass());
					if (attclassbo != null) {
						String namesss = attclassbo.getClassName() + ":班次:"
								+ attclassbo.getClassID();
						hashTable.put(ss, namesss);
					} else {
						String namesss = "休息:休息:班次主键值";
						hashTable.put(ss, namesss);
					}
				} else {
					String namesss = "工作日:工作日:班次主键值";
					hashTable.put(ss, namesss);
				}

				/*
				 * 比较公休日
				 */
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(getdate(ss));
				int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
				String attrestofweekboName = dayNames[dayOfWeek - 1];
				if (attrestofweekbo != null) {
					String namevalues = "公休日:公休日:班次主键值";
					if ("sun".equals(attrestofweekboName)) {
						if ("0".equals(attrestofweekbo.getSun())) {
							hashTable.put(ss, namevalues);
							continue;
						}
					}
					if ("mon".equals(attrestofweekboName)) {
						if ("0".equals(attrestofweekbo.getMon())) {
							hashTable.put(ss, namevalues);
							continue;
						}
					}
					if ("tues".equals(attrestofweekboName)) {
						if ("0".equals(attrestofweekbo.getTues())) {
							hashTable.put(ss, namevalues);
							continue;
						}
					}
					if ("wed".equals(attrestofweekboName)) {
						if ("0".equals(attrestofweekbo.getWed())) {
							hashTable.put(ss, namevalues);
							continue;
						}
					}
					if ("thur".equals(attrestofweekboName)) {
						if ("0".equals(attrestofweekbo.getThur())) {
							hashTable.put(ss, namevalues);
							continue;
						}
					}
					if ("fri".equals(attrestofweekboName)) {
						if ("0".equals(attrestofweekbo.getFri())) {
							hashTable.put(ss, namevalues);
							continue;
						}
					}
					if ("sat".equals(attrestofweekboName)) {
						if ("0".equals(attrestofweekbo.getSat())) {
							hashTable.put(ss, namevalues);
							continue;
						}
					}
				}
			}

			for (int s = 0; s < monthseq.length; s++) {
				String ss = monthseq[s];
				/*
				 * 比较节假日
				 */
				String aDates = ss.substring(5, 10);

				if (lists != null && lists.size() > 0) {
					for (int i = 0; i < lists.size(); i++) {
						AttFeastBO attfeastbo = (AttFeastBO) lists.get(i);
						String[] args = attfeastbo.getFeastDate().split(",");
						for (int j = 0; j < args.length; j++) {
							if (ss.equals(args[j])) {
								String namevalues = attfeastbo.getFeastName()
										+ ":节假日:班次主键值";
								hashTable.put(ss, namevalues);
								break;
							} else if (aDates.equals(args[j])) {
								String namevalues = attfeastbo.getFeastName()
										+ ":节假日:班次主键值";
								hashTable.put(ss, namevalues);
								break;
							}
						}
					}
				}

				if (lists1 != null && lists1.size() > 0) {
					for (int i = 0; i < lists1.size(); i++) {
						AttFeastBO attfeastbo1 = (AttFeastBO) lists1.get(i);
						String[] argss = attfeastbo1.getFeastDate().split(",");
						for (int j = 0; j < argss.length; j++) {
							if (ss.equals(argss[j])) {
								String namevalues = attfeastbo1.getFeastName()
										+ ":节假日:班次主键值";
								hashTable.put(ss, namevalues);
								break;
							} else if (aDates.equals(argss[j])) {
								String namevalues = attfeastbo1.getFeastName()
										+ ":节假日:班次主键值";
								hashTable.put(ss, namevalues);
								break;
							}
						}
					}
				}
			}

            List attworkdatelists = attfeastDAO.getAllAttWorkDate(orguid);
			for (int s = 0; s < monthseq.length; s++) {
				String ss = monthseq[s];
				/*
				 * 比较调休日
				 */

				if (attworkdatelists != null && attworkdatelists.size() > 0) {
					for (int p = 0; p < attworkdatelists.size(); p++) {
						AttWorkDateBO attworkdatebo = (AttWorkDateBO) attworkdatelists
								.get(p);
						if (ss.equals(attworkdatebo.getWorkDate().trim())) {
							if (groupID != null && !"".equals(groupID)) {
								AttClassGroupBO attclassgroupbo =(AttClassGroupBO)grouphash.get(groupID);
								AttClassBO attclassbo = (AttClassBO)classhash.get(attclassgroupbo
										.getLinkClass());
								if (attclassbo != null) {
									String namesss = attclassbo.getClassName()
											+ ":班次:" + attclassbo.getClassID();
									hashTable.put(ss, namesss);
								} else {
									String namesss = "休息:休息:班次主键值";
									hashTable.put(ss, namesss);
								}
							} else {
								String namesss = "工作日:工作日:班次主键值";
								hashTable.put(ss, namesss);
							}
							break;
						}
					}
				}
			}
		} catch (Exception e) {
		}

		return hashTable;
	}

	/*
	 * 倒班日历计算
	 */
	public Hashtable getPeriodInfoDate(String groupID, String aDate1) {
		Hashtable hashTable = new Hashtable();
		String groupID1 = groupID;
		String aDate = aDate1;
		AttClassGroupBO bo;
		int num = 0;
		try {
			bo = findAttClassGroupBObyId(groupID);
			if (bo != null) {
				num = Integer.parseInt(bo.getGroupPeriod());// 取得倒班周期数
				hashTable = getPeriodInfo(groupID1, aDate, num);
			}
		} catch (SysException e) {
		}
		return hashTable;
	}

	public Hashtable getPeriodInfo(String groupID, String aDate, int num) {
		Hashtable hashTable = new Hashtable();
		String[] begindateseq = null;
		/*
		 * 日期列表
		 */
		String yearvalue = aDate.substring(0, 4); // 年份
		String monthvalue = aDate.substring(5, 7);// 月份
		int days = MonthDays(Integer.parseInt(monthvalue), Integer
				.parseInt(yearvalue));// 月份的天数
		String[] monthseq = new String[days];
		for (int j = 1; j <= days; j++) {
			String date1 = "";
			if (j < 10) {
				date1 = aDate + "-0" + j;
			} else {
				date1 = aDate + "-" + j;
			}
			monthseq[j - 1] = date1;
		}

		String[] seqdays = new String[num];
		try {
			/*
			 * 班次列表
			 */
			List lists = getATTRearrangeBO(groupID);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					ATTRearrangeBO attRearrangeBO = (ATTRearrangeBO) lists
							.get(i);
					if (attRearrangeBO.getLinkClass() != null
							&& !"".equals(attRearrangeBO.getLinkClass())) {
						if (!"1".equals(attRearrangeBO.getLinkClass())) {
							AttClassBO attClassBO = findAttClassBObyId(attRearrangeBO
									.getLinkClass());
							if (attClassBO != null) {
								seqdays[i] = attClassBO.getClassName() + ":"
										+ attClassBO.getClassID();
							} else {
								seqdays[i] = "未设:班次主键值";
							}
						} else {
							seqdays[i] = "休息:班次主键值";
						}
					} else {
						seqdays[i] = "未设:班次主键值";
					}

				}
			}

			/*
			 * 倒班起点列表
			 */
			List lists1 = getAllATTRearrangeDateBO(groupID);
			if (lists1 != null && lists1.size() > 0) {
				begindateseq = new String[lists1.size()];
				for (int i = 0; i < lists1.size(); i++) {
					ATTRearrangeDateBO attrearrangedatebo = (ATTRearrangeDateBO) lists1
							.get(i);
					begindateseq[i] = attrearrangedatebo.getBeginDate();
				}
			}

			/*
			 * 倒班日历计算
			 */
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			for (int j = 0; j < monthseq.length; j++) {
				Date date1 = df.parse(monthseq[j]);
				if (begindateseq != null && begindateseq.length > 0) { // 判断倒班起点列表是否为空
					for (int m = 0; m < begindateseq.length; m++) {
						Date date2 = df.parse(begindateseq[m]);
						if (date1.getTime() >= date2.getTime()) {
							if ((date1.getTime() - date2.getTime())
									/ (1000 * 60 * 60 * 24) < seqdays.length) {
								int n = (int) ((date1.getTime() - date2
										.getTime()) / (1000 * 60 * 60 * 24));
								hashTable.put(monthseq[j], seqdays[n]);
								break;
							} else {
								int n = (int) ((date1.getTime() - date2
										.getTime()) / (1000 * 60 * 60 * 24));
								int ns = seqdays.length;
								int nss = Math.abs(n % ns);
								hashTable.put(monthseq[j], seqdays[nss]);
								break;
							}
						}
					}
				}
			}
		} catch (Exception e) {
		}

		return hashTable;
	}

	/**
	 * 判断你输入的年份是否数闰年还是平年；
	 * 
	 * @param year
	 * @return
	 */
	public static boolean LeapYear(int year) {
		if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 判断你输入月份的天数；
	 * 
	 * @param args
	 */
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
	 * 正常班班组，取得某人某天所上的班次信息 gaohaixing (update:20110929) attworkdatelists 调休日
	 * feastList 节假日 attrestofweekbo 公休日
	 */
	public AttClassBO getPeriodInfo(String orguid, String groupID,
			String aDate, List attworkdatelists, List feastList,
			AttRestOfWeekBO attrestofweekbo, Hashtable groupHash,
			Hashtable classHash) {
		AttClassBO attclassbo = null;
		try {
			/*
			 * 比较调休日
			 */
			// List attworkdatelists = attfeastDAO.getAllAttWorkDate(orguid);
			if (attworkdatelists != null && attworkdatelists.size() > 0) {
				for (int p = 0; p < attworkdatelists.size(); p++) {
					AttWorkDateBO attworkdatebo = (AttWorkDateBO) attworkdatelists
							.get(p);
					if (aDate.equals(attworkdatebo.getWorkDate().trim())) {
						if (groupID != null && !"".equals(groupID)) {
							AttClassGroupBO attclassgroupbo = (AttClassGroupBO)groupHash.get(groupID);
							AttClassBO attclassbo1 = (AttClassBO)classHash.get(attclassgroupbo
									.getLinkClass());
							if (attclassbo1 != null) {
								attclassbo = attclassbo1;
								return attclassbo;
							}
						}
					}
				}
			}

			/*
			 * 比较节假日
			 */
			String aDates = aDate.substring(5, 10);

			// List feastList = getAllAttFeast(orguid);

			if (feastList != null && feastList.size() > 0) {
				for (int i = 0; i < feastList.size(); i++) {
					AttFeastBO attfeastbo = (AttFeastBO) feastList.get(i);
					String[] args = attfeastbo.getFeastDate().split(",");
					for (int j = 0; j < args.length; j++) {
						if (aDate.equals(args[j])) {
							return null;
						} else if (aDates.equals(args[j])) {
							return null;
						}
					}
				}
			}

			/*
			 * 比较公休日
			 */
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(getdate(aDate));
			int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
			String attrestofweekboName = dayNames[dayOfWeek - 1];
			// AttRestOfWeekBO attrestofweekbo =
			// getAttRestOfWeekBOByOrgid(orguid);
			if (attrestofweekbo != null) {
				if ("sun".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getSun())) {
						return null;
					}
				}
				if ("mon".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getMon())) {
						return null;
					}
				}
				if ("tues".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getTues())) {
						return null;
					}
				}
				if ("wed".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getWed())) {
						return null;
					}
				}
				if ("thur".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getThur())) {
						return null;
					}
				}
				if ("fri".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getFri())) {
						return null;
					}
				}
				if ("sat".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getSat())) {
						return null;
					}
				}
			}
			/*
			 * 查询班次信息
			 */
			AttClassGroupBO attclassgroupbo = (AttClassGroupBO) groupHash
					.get(groupID);
			attclassbo = (AttClassBO) classHash.get(attclassgroupbo
					.getLinkClass());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return attclassbo;
	}

	public List getAllAttFeast(String orgid) throws SysException {
		return attfeastDAO.getAllAttFeast(orgid);
	}

	public List getAllEqualsAttFeast(String orgid) throws SysException {
		return this.attfeastDAO.getAllEqualsAttFeast(orgid);
	}

	public static Date getdate(String date) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(date);
	}

	public AttRestOfWeekBO getAttRestOfWeekBOByOrgid(String orgid)
			throws SysException {
		return attrestweekDAO.getAttRestOfWeekBOByOrgid(orgid);
	}

	/*
	 * 倒班班组，取得某人某天所上的班次信息
	 */
	public AttClassBO getPeriodInfo(String groupID, String aDate,Hashtable classhash) {
		AttClassBO attclassbo = null;
		try {
			AttClassGroupBO attclassgroupbo = findAttClassGroupBObyId(groupID);
			AttClassBO[] attclassbos = new AttClassBO[Integer
					.parseInt(attclassgroupbo.getGroupPeriod())];
			List lists = getATTRearrangeBO(groupID);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					ATTRearrangeBO attRearrangeBO = (ATTRearrangeBO) lists
							.get(i);
					if (attRearrangeBO.getLinkClass() != null
							&& !"".equals(attRearrangeBO.getLinkClass())) {
						if (!"1".equals(attRearrangeBO.getLinkClass())) {
							AttClassBO attClassBO = (AttClassBO)classhash.get((attRearrangeBO
									.getLinkClass()));
							if (attClassBO != null) {
								attclassbos[i] = attClassBO;
							} else {
								attclassbos[i] = null;
							}
						} else {
							attclassbos[i] = null;
						}
					} else {
						attclassbos[i] = null;
					}

				}
			}
			List lists1 = getAllATTRearrangeDateBO(groupID);
			if (lists1 != null && lists1.size() > 0) {
				for (int i = 0; i < lists1.size(); i++) {
					ATTRearrangeDateBO attrearrangedatebo = (ATTRearrangeDateBO) lists1
							.get(i);
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					Date date1 = df.parse(aDate);
					Date date2 = df.parse(attrearrangedatebo.getBeginDate());
					if (date1.getTime() >= date2.getTime()) {
						// d1,d2：(date1.getTime() - date2.getTime())/ (1000 * 60
						// * 60 * 24)
						if ((date1.getTime() - date2.getTime())
								/ (1000 * 60 * 60 * 24) < attclassbos.length) {
							attclassbo = attclassbos[(int) (date1.getTime() - date2
									.getTime())
									/ (1000 * 60 * 60 * 24)];
						} else {
							int n = (int) ((date1.getTime() - date2.getTime()) / (1000 * 60 * 60 * 24));
							int ns = attclassbos.length;
							int nss = Math.abs(n % ns);
							attclassbo = attclassbos[nss];
						}
						return attclassbo;
					}
				}
			}
		} catch (Exception e) {
		}
		return attclassbo;
	}

	/*
	 * 自动排班班组，取得某人某天所上的班次信息
	 */
	public AttClassBO getPeriodInfo2(String personId, String aDate,Hashtable hash) {
		AttClassBO attclassbo = null;
		try {
			List list = getAllAttPersonArrangeItemBO(personId, aDate);
			if (list != null && list.size() > 0) {
				AttPersonArrangeItemBO attpersonarrangeitembo = (AttPersonArrangeItemBO) list
						.get(0);
				if (!"1".equals(attpersonarrangeitembo.getLinkClass().trim())) {
					attclassbo = (AttClassBO)hash.get(attpersonarrangeitembo
							.getLinkClass().trim());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return attclassbo;
	}

	public List getAllAttPersonArrangeItemBO(String personId, String aDate)
			throws SysException {
		return groupMgrDAO.getAllAttPersonArrangeItemBO(personId, aDate);
	}

	public List getAllATTRearrangeDateBO(String orgid) throws SysException {
		return groupMgrDAO.getAllATTRearrangeDateBO(orgid);
	}

	public String selectA807701(String seconddaykey, String id, String day,
			String secondDay) throws SysException {
		String sql = "select " + seconddaykey + "  from  A807  where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		return activeapi.queryForString(sql);
	}

	public void UpdateA807(String id, String day, String A807701,
			String A807702, String A807703, String A807704, String A807705,
			String A807706, String secondDay) throws SysException {
		String updateSQL = "update a807 set A807701='" + A807701
				+ "',A807702='" + A807702 + "',A807703='" + A807703
				+ "',A807704='" + A807704 + "',A807705='" + A807705
				+ "',A807706='" + A807706 + "' where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		activeapi.executeSql(updateSQL);
	}

	public void UpdateA807(String id, String day, String A807701,
			String A807702, String A807703, String A807706, String secondDay)
			throws SysException {
		String updateSQL = "update a807 set A807701='" + A807701
				+ "',A807702='" + A807702 + "',A807703='" + A807703
				+ "',A807706='" + A807706 + "' where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		activeapi.executeSql(updateSQL);
	}

	public void saveAttenceSecondDayLogBO(AttenceSecondDayLogBO bo)
			throws SysException {
		cardMessageDAO.createBo(bo);
	}

	public String logitem(String personID, String day) throws SysException {
		String sql = "select A809703  from a809 where ID='" + personID
				+ "' and A809700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	public List findA807(String personID, String day) throws SysException {
		return cardMessageDAO.findA807(personID, day);
	}

	public List findA809(String personID, String day) throws SysException {
		return cardMessageDAO.findA809(personID, day);
	}

	public void UpdateA809(String id, String day, String A809701,
			String A809702, String A809703, String A809704, String A809705,
			String A809706) throws SysException {
		String updateSQL = "update a809 set A809701='" + A809701
				+ "',A809702='" + A809702 + "',A809703='" + A809703
				+ "',A809704='" + A809704 + "',A809705='" + A809705
				+ "',A809706='" + A809706 + "' where id='" + id
				+ "' and A809700='" + day + "'";
		activeapi.executeSql(updateSQL);
	}

	public void saveAttenceDayLogBO(AttenceDayLogBO bo) throws SysException {
		cardMessageDAO.createBo(bo);
	}

	public String yearfield(String id, String day, String yearfield)
			throws SysException {
		String sql = "select " + yearfield + "  from a811 where ID='" + id
				+ "' and A811700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	public void updatea811field(String id, String day, String fieldA811704,
			String yearfield) throws SysException {
		String sql = "update a811 set " + fieldA811704 + "='" + yearfield
				+ "' where ID='" + id + "' and A811700='" + day + "'";
		activeapi.executeSql(sql);
	}

	public String yearfieldA810(String yearField, String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(" + yearField
				+ " as float)),"+CACL_PERS+")  from a810 where ID='" + personID
				+ "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	public String monthfield(String id, String day, String monthfield)
			throws SysException {
		String sql = "select " + monthfield + "  from a810 where ID='" + id
				+ "' and A810700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	public void updatea810field(String id, String day, String fieldA810704,
			String monthfield) throws SysException {
		String sql = "update a810 set " + fieldA810704 + "='" + monthfield
				+ "' where ID='" + id + "' and A810700='" + day + "'";
		activeapi.executeSql(sql);
	}

	public String monthfieldA809(String monthField, String personID,
			String beginTime, String endTime) throws SysException {
		String sql = "select round(sum(cast(" + monthField
				+ " as float)),"+CACL_PERS+"）  from a809 where ID='" + personID
				+ "' and A809700>='" + beginTime + "' and A809700<='" + endTime
				+ "'";
		return activeapi.queryForString(sql);
	}

	public String dayfield(String id, String day, String dayfield)
			throws SysException {
		String sql = "select " + dayfield + "  from a809 where ID='" + id
				+ "' and A809700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	public void updatea809field(String id, String day, String fieldA809704,
			String dayfield) throws SysException {
		String sql = "update a809 set " + fieldA809704 + "='" + dayfield
				+ "' where ID='" + id + "' and A809700='" + day + "'";
		activeapi.executeSql(sql);
	}

	public String monthLogitem(String personID, String day) throws SysException {
		String sql = "select count(A809703)  from a809 where ID='" + personID
				+ "' and A809700 like '" + day + "%'";
		return activeapi.queryForString(sql);
	}

	public String yearLogitem(String personID, String year) throws SysException {
		String sql = "select count(A810703)  from a810 where ID='" + personID
				+ "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 判断日分汇总中某天是否有值存在
	public String dayChecklogitem(String personID, String day)
			throws SysException {
		String sql = "select count(A807701)  from a807 where ID='" + personID
				+ "' and A807700 like '" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 判断月汇总中某月是否有值存在
	public String monthChecklogitem(String personID, String day)
			throws SysException {
		String sql = "select A810703  from a810 where ID='" + personID
				+ "' and A810700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 日实际出勤
	public String dayRealityTime(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807702 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月实际出勤
	public String monthRealityTime(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809702 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年实际出勤
	public String yearRealityTime(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810702 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日应出勤
	public String dayshouldTime(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807701 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月应出勤
	public String monthshouldTime(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809701 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年应出勤
	public String yearshouldTime(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810701 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日迟到时间
	public String daylateTime(String personID, String day) throws SysException {
		String sql = "select round(sum(cast(A807704 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day
				+ "' and  A807704 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 日迟到次数
	public String daylateTime1(String personID, String day) throws SysException {
		String sql = "select count(A807704)  from a807 where ID='" + personID
				+ "' and A807700='" + day + "' and  A807704 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 月迟到时间
	public String monthlateTime(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809704 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime
				+ "' and  A809704 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 年迟到时间
	public String yearlateTime(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810704 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year
				+ "%' and  A810704 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 日早退时间
	public String dayearlyTime(String personID, String day) throws SysException {
		String sql = "select round(sum(cast(A807705 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day
				+ "' and A807705 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 日早退次数
	public String dayearlyTime1(String personID, String day)
			throws SysException {
		String sql = "select count(A807705)  from a807 where ID='" + personID
				+ "' and A807700='" + day + "' and A807705 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 月早退时间
	public String monthearlyTime(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809705 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime
				+ "' and A809705 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 年早退时间
	public String yearearlyTime(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810705 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year
				+ "%' and A810705 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 日旷工时间
	public String dayawayTime(String personID, String day) throws SysException {
		String sql = "select round(sum(cast(A807706 as float)),"+CACL_PERS+") from a807 where ID='"
				+ personID + "' and A807700='" + day
				+ "' and A807706 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 日旷工次数
	public String dayawayTime1(String personID, String day) throws SysException {
		String sql = "select count(A807706) from a807 where ID='" + personID
				+ "' and A807700='" + day + "' and A807706 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 月旷工时间
	public String monthawayTime(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809706 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime
				+ "' and A809706 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 年旷工时间
	public String yearawayTime(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810706 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year
				+ "%' and A810706 not in('0','0.0')";
		return activeapi.queryForString(sql);
	}

	// 日事假
	public String dayleaveReasons(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807707 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月事假
	public String monthleaveReasons(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809707 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年事假
	public String yearleaveReasons(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810707 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日病假
	public String dayleaveSick(String personID, String day) throws SysException {
		String sql = "select round(sum(cast(A807708 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月病假
	public String monthleaveSick(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809708 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年病假
	public String yearleaveSick(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810708 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日产假
	public String dayleaveMaternity(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807709 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月产假
	public String monthleaveMaternity(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809709 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年产假
	public String yearleaveMaternity(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810709 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日婚假
	public String dayleaveWedding(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807710 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月婚假
	public String monthleaveWedding(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809710 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年婚假
	public String yearleaveWedding(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810710 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日探亲假
	public String dayleaveHome(String personID, String day) throws SysException {
		String sql = "select round(sum(cast(A807711 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月探亲假
	public String monthleaveHome(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809711 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年探亲假
	public String yearleaveHome(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810711 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日年假
	public String dayleaveYear(String personID, String day) throws SysException {
		String sql = "select round(sum(cast(A807712 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月年假
	public String monthleaveYear(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809712 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年假
	public String yearleaveYear(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810712 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日工伤假
	public String dayleaveIndustrialInjury(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807713 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月工伤假
	public String monthleaveIndustrialInjury(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809713 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年工伤假
	public String yearleaveIndustrialInjury(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810713 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日丧假
	public String dayleaveArrangingFuneral(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807714 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月丧假
	public String monthleaveArrangingFuneral(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809714 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年丧假
	public String yearleaveArrangingFuneral(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810714 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "%'";
		return activeapi.queryForString(sql);
	}

	// 日出差
	public String dayevcctionValue(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807715 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 日公出
	public String dayoutworkValue(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807716 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 日公假
	public String daypublicholidayValue(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807717 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 日调休
	public String daytimeOffValue(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807718 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 日工作日延时加班
	public String dayworkAddValue(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807719 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 日双休日加班
	public String dayweekAddValue(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807720 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 日节假日加班
	public String dayfeastAddValue(String personID, String day)
			throws SysException {
		String sql = "select round(sum(cast(A807721 as float)),"+CACL_PERS+")  from a807 where ID='"
				+ personID + "' and A807700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	// 月出差
	public String monthevcctionValue(String personID, String beginTime,
			String endTime) throws SysException {
		String sql = "select round(sum(cast(A809715 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + endTime + "'";
		return activeapi.queryForString(sql);
	}

	// 年出差
	public String yearevcctionValue(String personID, String year)
			throws SysException {
		String sql = "select round(sum(cast(A810715 as float)),"+CACL_PERS+")  from a810 where ID='"
				+ personID + "' and A810700 like '" + year + "'";
		return activeapi.queryForString(sql);
	}

	// 月变动前应出勤
	public String monthbeginShouldTime(String personID, String beginTime,
			String beginShouldTimes) throws SysException {
		String sql = "select round(sum(cast(A809701 as float)),"+CACL_PERS+")  from a809 where ID='"
				+ personID + "' and A809700>='" + beginTime
				+ "' and A809700<='" + beginShouldTimes + "'";
		return activeapi.queryForString(sql);
	}

	public void saveAttenceDayMonthBO(AttenceDayMonthBO bo) throws SysException {
		cardMessageDAO.createBo(bo);
	}

	public void saveAttYearCollectBO(AttYearCollectBO bo) throws SysException {
		cardMessageDAO.createBo(bo);
	}

	/*
	 * 请假计算
	 */
	public String calcAttFurloughRec(String id, String day, AttClassBO b,List bs)
			throws SysException {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = df.parse(day);
			String[] yearmonthvalue = day.split("-");
			String yearmonthvalue1 = yearmonthvalue[0] + "-"
					+ yearmonthvalue[1];
			// List lists = getAttFurloughRecBO(id, yearmonthvalue1 , b);
			
			List attseconddaybos = findA807(id, day);
			if (attseconddaybos != null
					&& attseconddaybos.size() > 0) {
				deleteAttenceSecondDayLogBO(id, day);
			}
			
			List lists = getAttFurloughRecCollectBO(id, yearmonthvalue1);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttFurloughRecCollectBO attfurloughrecbo = (AttFurloughRecCollectBO) lists
							.get(i);
					if (statusValue(attfurloughrecbo)) {
						String[] begintimes = attfurloughrecbo.getBeginTime()
								.split(" ");
						String[] endtimes = attfurloughrecbo.getEndTime()
								.split(" ");
						Date date2 = df.parse(begintimes[0]);
						Date date3 = df.parse(endtimes[0]);
						AttfurloughBO attfurloughbo = findAttfurloughBObyId(attfurloughrecbo
								.getFlID());// 判断假别类型
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (!begintimes[0].equals(endtimes[0])) {
							if (date1.getTime() > date2.getTime()
									&& date1.getTime() < date3.getTime()) {
								if (bs != null && bs.size() > 0) {
									String[] attclassdetailbos = new String[bs
											.size()];
									for (int j = 0; j < bs.size(); j++) {
										AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
												.get(j);
										attclassdetailbos[j] = attclassdetailbo
												.getItemTime();
									}
									int nss = attclassdetailbos.length;
									int n = nss / 12;
									if (n > 0) {
										int m = 0;
										while (m < n) {
											int p = 12 * m;
											String attclassTime1 = attclassdetailbos[p + 1]
													+ ":00";// 上班时刻
											String attclassTime5 = attclassdetailbos[p + 5]
													+ ":00";// 休息开始
											String attclassTime6 = attclassdetailbos[p + 6]
													+ ":00";// 休息结束
											String attclassTime10 = attclassdetailbos[p + 10]
													+ ":00";// 下班时刻
											DateFormat dfs = new SimpleDateFormat(
													"HH:mm:ss");
											Date dates1 = dfs
													.parse(attclassTime1);
											Date dates5 = dfs
													.parse(attclassTime5);
											Date dates6 = dfs
													.parse(attclassTime6);
											Date dates10 = dfs
													.parse(attclassTime10);
											float shouldTime = ((float) (dates5
													.getTime() - dates1
													.getTime())
													/ (1000 * 60 * 60 * 8) + (float) (dates10
													.getTime() - dates6
													.getTime())
													/ (1000 * 60 * 60 * 8));// 应出勤
											shouldTime = (float) (Math
													.round(shouldTime * 100)) / 100;
											String A807701 = shouldTime + "";
											String A807001 = "" + (m + 1);
											subID = SequenceGenerator
													.getKeyId("A807");
											addA807(
													id,
													subID,
													A807000,
													A807001,
													day,
													A807701,
													"0",
													"0",
													attfurloughbo
															.getFlSecondDayfield(),
													A807701);
											m++;
										}
									}
								}
							} else if (date1.getTime() == date2.getTime()) {
								makeLeaveDayCollection1(id, day, begintimes[1],
										b, attfurloughbo);
							} else if (date1.getTime() == date3.getTime()) {
								makeLeaveDayCollection2(id, day, endtimes[1],
										b, attfurloughbo);
							}
						} else if (begintimes[0].equals(endtimes[0])
								&& begintimes[0].equals(day)) {
							String flvalues = makeLeaveDayCollection3(id, day,
									begintimes[1], b, attfurloughbo);
							if (flvalues != null && !"".equals(flvalues)) {
								String[] flvaluess = flvalues.split(":");
								String flvalue = flvaluess[0];
								float flvalue1 = Float.parseFloat(flvalue);
								String m = flvaluess[1];
								String showTimeValues = flvaluess[2];
								float showTime = Float
										.parseFloat(showTimeValues);
								String A807001 = "" + m;
								String flnamevalues = selectFlname(
										attfurloughbo.getFlSecondDayfield(),
										id, day, A807001);
								String realtimevalues = selectRealTimes(id,
										day, A807001);
								if (realtimevalues != null
										&& !"".equals(realtimevalues)) {
									if (flnamevalues != null
											&& !"".equals(flnamevalues)) {
										if (!"0".equals(flnamevalues)
												&& !"0.0".equals(flnamevalues)) {
											float realTime = Float
													.parseFloat(realtimevalues);
											float flnameandvalue = Float
													.parseFloat(flnamevalues);
											flnameandvalue = flnameandvalue
													+ flvalue1;
											realTime = realTime
													- flnameandvalue;
											flnameandvalue = (float) (Math
													.round(flnameandvalue * 100)) / 100;
											realTime = (float) (Math
													.round(realTime * 100)) / 100;
											String A807702 = realTime + "";
											String A807707 = flnameandvalue
													+ "";
											if (flnameandvalue > 0.0) {
												if (flnameandvalue > showTime) {
													A807707 = "" + showTime;
												}
												updateAttenceSecondDayLogBO(
														id,
														day,
														A807702,
														A807001,
														attfurloughbo
																.getFlSecondDayfield(),
														A807707);
											}
										} else {

										}
									} else {
										float realTimes = Float
												.parseFloat(realtimevalues);
										realTimes = realTimes - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807702 = realTimes + "";
										String A807707 = flvalue1 + "";
										if (flvalue1 > 0.0) {
											if (flvalue1 > showTime) {
												A807707 = "" + showTime;
											}
											updateAttenceSecondDayLogBO(
													id,
													day,
													A807702,
													A807001,
													attfurloughbo
															.getFlSecondDayfield(),
													A807707);
										}
									}
								} else {
									float realTimes = showTime - flvalue1;
									showTime = (float) (Math
											.round(showTime * 100)) / 100;
									realTimes = (float) (Math
											.round(realTimes * 100)) / 100;
									flvalue1 = (float) (Math
											.round(flvalue1 * 100)) / 100;
									String A807701 = showTime + "";
									String A807702 = realTimes + "";
									String A807707 = flvalue1 + "";
									if (flvalue1 > 0.0) {
										addA807(id, subID, A807000, A807001,
												day, A807701, A807702, "0",
												attfurloughbo
														.getFlSecondDayfield(),
												A807707);
									}
								}
							}

							String flvalue1s = makeLeaveDayCollection4(id, day,
									endtimes[1], b, attfurloughbo);
							if (flvalue1s != null && !"".equals(flvalue1s)) {
								String[] flvaluess = flvalue1s.split(":");
								String flvalue = flvaluess[0];
								float flvalue1 = Float.parseFloat(flvalue);
								String m = flvaluess[1];
								String showTimeValues = flvaluess[2];
								float showTime = Float
										.parseFloat(showTimeValues);
								String A807001 = "" + m;
								String flnamevalues = selectFlname(
										attfurloughbo.getFlSecondDayfield(),
										id, day, A807001);
								String realtimevalues = selectRealTimes(id,
										day, A807001);
								if (realtimevalues != null
										&& !"".equals(realtimevalues)) {
									if (flnamevalues != null
											&& !"".equals(flnamevalues)) {
										if (!"0".equals(flnamevalues)
												&& !"0.0".equals(flnamevalues)) {
											float realTime = Float
													.parseFloat(realtimevalues);
											float flnameandvalue = Float
													.parseFloat(flnamevalues);
											flnameandvalue = flnameandvalue
													- (showTime - flvalue1);
											float f = Math.abs(flnameandvalue);
											realTime = showTime - f;
											flnameandvalue = (float) (Math
													.round(flnameandvalue * 100)) / 100;
											realTime = (float) (Math
													.round(realTime * 100)) / 100;
											String A807702 = realTime + "";
											String A807707 = flnameandvalue
													+ "";
											if (flnameandvalue > 0.0) {
												if (flnameandvalue > showTime) {
													A807707 = "" + showTime;
												}
												updateAttenceSecondDayLogBO(
														id,
														day,
														A807702,
														A807001,
														attfurloughbo
																.getFlSecondDayfield(),
														A807707);
											}
										} else {

										}
									} else {
										float realTimes = Float
												.parseFloat(realtimevalues);
										realTimes = realTimes - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807702 = realTimes + "";
										String A807707 = flvalue1 + "";
										if (flvalue1 > 0.0) {
											if (flvalue1 > showTime) {
												A807707 = "" + showTime;
											}
											updateAttenceSecondDayLogBO(
													id,
													day,
													A807702,
													A807001,
													attfurloughbo
															.getFlSecondDayfield(),
													A807707);
										}
									}
								} else {
									float realTimes = showTime - flvalue1;
									showTime = (float) (Math
											.round(showTime * 100)) / 100;
									realTimes = (float) (Math
											.round(realTimes * 100)) / 100;
									flvalue1 = (float) (Math
											.round(flvalue1 * 100)) / 100;
									String A807701 = showTime + "";
									String A807702 = realTimes + "";
									String A807707 = flvalue1 + "";
									if (flvalue1 > 0.0) {
										addA807(id, subID, A807000, A807001,
												day, A807701, A807702, "0",
												attfurloughbo
														.getFlSecondDayfield(),
												A807707);
									}
								}
							}

						}

						if (attfurloughrecbo.getFurloughNO() != null
								&& !"".equals(attfurloughrecbo.getFurloughNO())) {
							calcAttFurloughRecAndNetWorkHoliday(id, day, b,
									attfurloughbo, attfurloughrecbo
											.getFurloughNO());
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/*
	 * 对请假进行日汇总操作(开始时间)
	 */
	public String makeLeaveDayCollection1(String id, String day, String day1,
			AttClassBO b, AttfurloughBO attfurloughbo) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						A807702 = realTimes + "";
						String A807707 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO(id, day, A807701,
									A807702, A807001, attfurloughbo
											.getFlSecondDayfield(), A807707);
						}
					} else {
						realTime = realTime - flvalues;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807707 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807(id, subID, A807000, A807001, day, A807701,
									A807702, "0", attfurloughbo
											.getFlSecondDayfield(), A807707);
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对请假进行日汇总操作(结束时间)
	 */
	public String makeLeaveDayCollection2(String id, String day, String day1,
			AttClassBO b, AttfurloughBO attfurloughbo) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						A807702 = realTimes + "";
						String A807707 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO(id, day, A807701,
									A807702, A807001, attfurloughbo
											.getFlSecondDayfield(), A807707);
						}
					} else {
						realTime = realTime - flvalues;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807707 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807(id, subID, A807000, A807001, day, A807701,
									A807702, "0", attfurloughbo
											.getFlSecondDayfield(), A807707);
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对请假进行日汇总操作(同一天的开始时间)
	 */
	public String makeLeaveDayCollection3(String id, String day, String day1,
			AttClassBO b, AttfurloughBO attfurloughbo) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				String totalValues = "";
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);

					if (totalValues != null && !"".equals(totalValues)) {
						Date dateTotalValues = df.parse(totalValues);
						if (dates.getTime() > dateTotalValues.getTime()
								&& dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					} else {
						if (dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					}

					if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					totalValues = attclassTime11;
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对请假进行日汇总操作(同一天的结束时间)
	 */
	public String makeLeaveDayCollection4(String id, String day, String day1,
			AttClassBO b, AttfurloughBO attfurloughbo) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	public List getAttFurloughRecBO(String id, String day, AttClassBO b)
			throws SysException {
		return cardMessageDAO.getAttFurloughRecBO(id, day, b);
	}

	public List getAttFurloughRecBO1(String id, String day) throws SysException {
		return cardMessageDAO.getAttFurloughRecBO1(id, day);
	}

	public List getAttFurloughRecCollectBO(String id, String day)
			throws SysException {
		return cardMessageDAO.getAttFurloughRecCollectBO(id, day);
	}

	public String dayLogitem(String personID, String day) throws SysException {
		String sql = "select A809700  from a809 where ID='" + personID
				+ "' and A809700='" + day + "'";
		return activeapi.queryForString(sql);
	}

	/*
	 * 判断假别类型
	 */
	public AttfurloughBO findAttfurloughBObyId(String id) throws SysException {
		return (AttfurloughBO) cardMessageDAO.findBoById(AttfurloughBO.class,
				id);
	}

	public void addA807(String id, String subID, String A807000,
			String A807001, String day, String A807701, String A807702,
			String A807703, String flname, String flvalue) throws SysException {
		String sql = "insert into a807(ID,SUBID,A807000,A807001,A807700,A807701,A807702,A807703,"
				+ flname
				+ ") values('"
				+ id
				+ "','"
				+ subID
				+ "','"
				+ A807000
				+ "','"
				+ A807001
				+ "','"
				+ day
				+ "','"
				+ A807701
				+ "','"
				+ A807702 + "','" + A807703 + "','" + flvalue + "')";
		activeapi.executeSql(sql);
	}

	public void addA807IsAttFurloughRecAndNetWorkHoliday(String id,
			String subID, String A807000, String A807001, String day,
			String A807701, String A807702, String A807703, String A807712,
			String flname, String flvalue) throws SysException {
		String sql = "insert into a807(ID,SUBID,A807000,A807001,A807700,A807701,A807702,A807703,A807712,"
				+ flname
				+ ") values('"
				+ id
				+ "','"
				+ subID
				+ "','"
				+ A807000
				+ "','"
				+ A807001
				+ "','"
				+ day
				+ "','"
				+ A807701
				+ "','"
				+ A807702
				+ "','"
				+ A807703
				+ "','"
				+ A807712
				+ "','"
				+ flvalue
				+ "')";
		activeapi.executeSql(sql);
	}

	public void UpdateA809Furlought(String flname, String flvalue, String id,
			String day) throws SysException {
		String updateSQL = "update a809 set " + flname + "='" + flvalue
				+ "' where id='" + id + "' and A809700='" + day + "'";
		activeapi.executeSql(updateSQL);
	}

	public void UpdateA809Furlought1(String attenceRate, String realityTime,
			String flname, String flvalue, String id, String day)
			throws SysException {
		String updateSQL = "update a809 set A809703='" + attenceRate
				+ "',A809702='" + realityTime + "'," + flname + "='" + flvalue
				+ "' where id='" + id + "' and A809700='" + day + "'";
		activeapi.executeSql(updateSQL);
	}

	/*
	 * 请假审批状态值
	 */
	public WFNodeBO getCurrentNode(String linkId) throws SysException {
		WFProcessBO processbo = wfdao.findWFProcessBO(linkId, null);
		if (processbo == null || processbo.getCurNode() == null)
			return null;
		else
			return getWFNodeBO(processbo.getCurNode());
	}

	public WFNodeBO getWFNodeBO(String nodeID) throws SysException {
		return (WFNodeBO) wfdao.findBoById(
				com.hr319wg.sys.pojo.bo.WFNodeBO.class, nodeID);
	}

	public boolean statusValue(AttFurloughRecCollectBO attfurloughrecbo) {
		boolean success = true;
		return success;
	}

	public List findAttenceDayLogBO(String id, String day) throws SysException {
		return cardMessageDAO.findAttenceDayLogBO(id, day);
	}

	/*
	 * 出差计算
	 */
	public String calcAttEvcctionRecBO(String id, String day, AttClassBO b,List bs)
			throws SysException {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = df.parse(day);
			String[] yearmonthvalue = day.split("-");
			String yearmonthvalue1 = yearmonthvalue[0] + "-"
					+ yearmonthvalue[1];
			// String yearmonthvalue1=day + " 00:00";
			// List lists = getAllAttEvcctionRecBO(id, yearmonthvalue1, b);
			
			List attseconddaybos = findA807(id, day);
			if (attseconddaybos != null
					&& attseconddaybos.size() > 0) {
				deleteAttenceSecondDayLogBO(id, day);
			}
			
			List lists = getAllAttEvcctionRecCollectBO(id, yearmonthvalue1);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttEvcctionRecCollectBO attevcctionrecbo = (AttEvcctionRecCollectBO) lists
							.get(i);
					if (statusValue1(attevcctionrecbo)) {
						String[] begintimes = attevcctionrecbo.getBeginTime()
								.split(" ");
						String[] endtimes = attevcctionrecbo.getEndTime()
								.split(" ");
						Date date2 = df.parse(begintimes[0]);
						Date date3 = df.parse(endtimes[0]);
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (!begintimes[0].equals(endtimes[0])) {
							if (date1.getTime() > date2.getTime()
									&& date1.getTime() < date3.getTime()) {
								//List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
								if (bs != null && bs.size() > 0) {
									String[] attclassdetailbos = new String[bs
											.size()];
									for (int j = 0; j < bs.size(); j++) {
										AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
												.get(j);
										attclassdetailbos[j] = attclassdetailbo
												.getItemTime();
									}
									int nss = attclassdetailbos.length;
									int n = nss / 12;
									if (n > 0) {
										int m = 0;
										while (m < n) {
											int p = 12 * m;
											String attclassTime1 = attclassdetailbos[p + 1]
													+ ":00";// 上班时刻
											String attclassTime5 = attclassdetailbos[p + 5]
													+ ":00";// 休息开始
											String attclassTime6 = attclassdetailbos[p + 6]
													+ ":00";// 休息结束
											String attclassTime10 = attclassdetailbos[p + 10]
													+ ":00";// 下班时刻
											DateFormat dfs = new SimpleDateFormat(
													"HH:mm:ss");
											Date dates1 = dfs
													.parse(attclassTime1);
											Date dates5 = dfs
													.parse(attclassTime5);
											Date dates6 = dfs
													.parse(attclassTime6);
											Date dates10 = dfs
													.parse(attclassTime10);
											float shouldTime = ((float) (dates5
													.getTime() - dates1
													.getTime())
													/ (1000 * 60 * 60 * 8) + (float) (dates10
													.getTime() - dates6
													.getTime())
													/ (1000 * 60 * 60 * 8));// 应出勤
											shouldTime = (float) (Math
													.round(shouldTime * 100)) / 100;
											String A807701 = shouldTime + "";
											String A807001 = "" + (m + 1);
											subID = SequenceGenerator
													.getKeyId("A807");
											addA807(id, subID, A807000,
													A807001, day, A807701, "0",
													"0", A807701);
											m++;
										}
									}
								}
							} else if (date1.getTime() == date2.getTime()) {
								makeEvcctionDayCollection1(id, day,
										begintimes[1], b);
							} else if (date1.getTime() == date3.getTime()) {
								makeEvcctionDayCollection2(id, day,
										endtimes[1], b);
							}
						} else if (begintimes[0].equals(endtimes[0])
								&& begintimes[0].equals(day)) {
							String flvalues = makeEvcctionDayCollection3(id,
									day, begintimes[1], b);
							if (flvalues != null && !"".equals(flvalues)) {
								String[] flvaluess = flvalues.split(":");
								String flvalue = flvaluess[0];
								float flvalue1 = Float.parseFloat(flvalue);
								String m = flvaluess[1];
								String showTimeValues = flvaluess[2];
								float showTime = Float
										.parseFloat(showTimeValues);
								String A807001 = "" + m;
								String flnamevalues = selectA807(id, day,
										A807001);
								String realtimevalues = selectRealTimes(id,
										day, A807001);
								if (realtimevalues != null
										&& !"".equals(realtimevalues)) {
									if (flnamevalues != null
											&& !"".equals(flnamevalues)) {
										if (!"0".equals(flnamevalues)
												&& !"0.0".equals(flnamevalues)) {
											float realTime = Float
													.parseFloat(realtimevalues);
											float flnameandvalue = Float
													.parseFloat(flnamevalues);
											flnameandvalue = flnameandvalue
													+ flvalue1;
											realTime = realTime
													- flnameandvalue;
											flnameandvalue = (float) (Math
													.round(flnameandvalue * 100)) / 100;
											realTime = (float) (Math
													.round(realTime * 100)) / 100;
											String A807702 = realTime + "";
											String A807715 = flnameandvalue
													+ "";
											if (flnameandvalue > showTime) {
												A807715 = "" + showTime;
											}
											updateAttenceSecondDayLogBO2(id,
													day, A807702, A807001,
													A807715);
										} else {

										}
									} else {
										float realTimes = Float
												.parseFloat(realtimevalues);
										realTimes = realTimes - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807702 = realTimes + "";
										String A807715 = flvalue1 + "";
										if (flvalue1 > showTime) {
											A807715 = "" + showTime;
										}
										updateAttenceSecondDayLogBO2(id, day,
												A807702, A807001, A807715);
									}
								} else {
									float realTimes = showTime - flvalue1;
									showTime = (float) (Math
											.round(showTime * 100)) / 100;
									realTimes = (float) (Math
											.round(realTimes * 100)) / 100;
									flvalue1 = (float) (Math
											.round(flvalue1 * 100)) / 100;
									String A807701 = showTime + "";
									String A807702 = realTimes + "";
									String A807715 = flvalue1 + "";
									addA807(id, subID, A807000, A807001, day,
											A807701, A807702, "0", A807715);
								}
							}

							String flvalue1s = makeEvcctionDayCollection4(id,
									day, endtimes[1], b);
							if (flvalue1s != null && !"".equals(flvalue1s)) {
								String[] flvaluess = flvalue1s.split(":");
								String flvalue = flvaluess[0];
								float flvalue1 = Float.parseFloat(flvalue);
								String m = flvaluess[1];
								String showTimeValues = flvaluess[2];
								float showTime = Float
										.parseFloat(showTimeValues);
								String A807001 = "" + m;
								String flnamevalues = selectA807(id, day,
										A807001);
								String realtimevalues = selectRealTimes(id,
										day, A807001);
								if (realtimevalues != null
										&& !"".equals(realtimevalues)) {
									if (flnamevalues != null
											&& !"".equals(flnamevalues)) {
										if (!"0".equals(flnamevalues)
												&& !"0.0".equals(flnamevalues)) {
											float realTime = Float
													.parseFloat(realtimevalues);
											float flnameandvalue = Float
													.parseFloat(flnamevalues);
											flnameandvalue = flnameandvalue
													- (showTime - flvalue1);
											float f = Math.abs(flnameandvalue);
											realTime = showTime - f;
											flnameandvalue = (float) (Math
													.round(flnameandvalue * 100)) / 100;
											realTime = (float) (Math
													.round(realTime * 100)) / 100;
											String A807702 = realTime + "";
											String A807715 = flnameandvalue
													+ "";
											if (flnameandvalue > showTime) {
												A807715 = "" + showTime;
											}
											updateAttenceSecondDayLogBO2(id,
													day, A807702, A807001,
													A807715);
										} else {

										}
									} else {
										float realTimes = Float
												.parseFloat(realtimevalues);
										realTimes = realTimes - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807702 = realTimes + "";
										String A807715 = flvalue1 + "";
										if (flvalue1 > showTime) {
											A807715 = "" + showTime;
										}
										updateAttenceSecondDayLogBO2(id, day,
												A807702, A807001, A807715);
									}
								} else {
									float realTimes = showTime - flvalue1;
									showTime = (float) (Math
											.round(showTime * 100)) / 100;
									realTimes = (float) (Math
											.round(realTimes * 100)) / 100;
									flvalue1 = (float) (Math
											.round(flvalue1 * 100)) / 100;
									String A807701 = showTime + "";
									String A807702 = realTimes + "";
									String A807715 = flvalue1 + "";
									addA807(id, subID, A807000, A807001, day,
											A807701, A807702, "0", A807715);
								}
							}

						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/*
	 * 对出差进行日汇总操作(开始时间)
	 */
	public String makeEvcctionDayCollection1(String id, String day,
			String day1, AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						A807702 = realTimes + "";
						String A807715 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO1(id, day, A807701,
									A807702, A807001, A807715);
						}
					} else {
						realTime = realTime - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807715 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807(id, subID, A807000, A807001, day, A807701,
									A807702, "0", A807715);
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对出差进行日汇总操作(结束时间)
	 */
	public String makeEvcctionDayCollection2(String id, String day,
			String day1, AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						A807702 = realTimes + "";
						String A807715 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO1(id, day, A807701,
									A807702, A807001, A807715);
						}
					} else {
						realTime = realTime - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807715 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807(id, subID, A807000, A807001, day, A807701,
									A807702, "0", A807715);
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对出差进行日汇总操作(同一天的开始时间)
	 */
	public String makeEvcctionDayCollection3(String id, String day,
			String day1, AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				String totalValues = "";
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);

					if (totalValues != null && !"".equals(totalValues)) {
						Date dateTotalValues = df.parse(totalValues);
						if (dates.getTime() > dateTotalValues.getTime()
								&& dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					} else {
						if (dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					}

					if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					totalValues = attclassTime11;
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对出差进行日汇总操作(同一天的结束时间)
	 */
	public String makeEvcctionDayCollection4(String id, String day,
			String day1, AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 公出计算
	 */
	public String calcAttOutWorkRecBO(String id, String day, AttClassBO b,List bs)
			throws SysException {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = df.parse(day);
            String yearmonthvalue=day.substring(0,7);
			List lists = getAllAttOutWorkCollectBO(id, yearmonthvalue);
			List attseconddaybos = findA807(id, day);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttOutWorkCollectBO attoutworkcollectbo = (AttOutWorkCollectBO) lists
							.get(i);
					if (statusValue2(attoutworkcollectbo)) {
						String[] begintimes = attoutworkcollectbo
								.getBeginTime().split(" ");
						String[] endtimes = attoutworkcollectbo.getEndTime()
								.split(" ");
						Date date2 = df.parse(begintimes[0]);
						Date date3 = df.parse(endtimes[0]);
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (!begintimes[0].equals(endtimes[0])) {
							if (date1.getTime() > date2.getTime()
									&& date1.getTime() < date3.getTime()) {
								if (attseconddaybos != null
										&& attseconddaybos.size() > 0) {
									deleteAttenceSecondDayLogBO(id, day);
								}
								if (bs != null && bs.size() > 0) {
									String[] attclassdetailbos = new String[bs
											.size()];
									for (int j = 0; j < bs.size(); j++) {
										AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
												.get(j);
										attclassdetailbos[j] = attclassdetailbo
												.getItemTime();
									}
									int nss = attclassdetailbos.length;
									int n = nss / 12;
									if (n > 0) {
										int m = 0;
										while (m < n) {
											int p = 12 * m;
											String attclassTime1 = attclassdetailbos[p + 1]
													+ ":00";// 上班时刻
											String attclassTime5 = attclassdetailbos[p + 5]
													+ ":00";// 休息开始
											String attclassTime6 = attclassdetailbos[p + 6]
													+ ":00";// 休息结束
											String attclassTime10 = attclassdetailbos[p + 10]
													+ ":00";// 下班时刻
											DateFormat dfs = new SimpleDateFormat(
													"HH:mm:ss");
											Date dates1 = dfs
													.parse(attclassTime1);
											Date dates5 = dfs
													.parse(attclassTime5);
											Date dates6 = dfs
													.parse(attclassTime6);
											Date dates10 = dfs
													.parse(attclassTime10);
											float shouldTime = ((float) (dates5
													.getTime() - dates1
													.getTime())
													/ (1000 * 60 * 60 * 8) + (float) (dates10
													.getTime() - dates6
													.getTime())
													/ (1000 * 60 * 60 * 8));// 应出勤
											shouldTime = (float) (Math
													.round(shouldTime * 100)) / 100;
											String A807701 = shouldTime + "";
											String A807001 = "" + (m + 1);
											subID = SequenceGenerator
													.getKeyId("A807");
											addA807Lists(id, subID, A807000,
													A807001, day, A807701, "0",
													"0", "0", A807701);
											m++;
										}
									}
								}
							} else if (date1.getTime() == date2.getTime()) {
								makeOutWorkDayCollection1(id, day,
										begintimes[1], b);
							} else if (date1.getTime() == date3.getTime()) {
								makeOutWorkDayCollection2(id, day, endtimes[1],
										b);
							}
						} else if (begintimes[0].equals(endtimes[0])
								&& begintimes[0].equals(day)) {
							String flvalues = makeOutWorkDayCollection3(id,
									day, begintimes[1], b);
							if (flvalues != null && !"".equals(flvalues)) {
								String[] flvaluess = flvalues.split(":");
								String flvalue = flvaluess[0];
								float flvalue1 = Float.parseFloat(flvalue);
								String m = flvaluess[1];
								String showTimeValues = flvaluess[2];
								float showTime = Float
										.parseFloat(showTimeValues);
								String A807001 = "" + m;
								String flnamevalues = selectA807s(id, day,
										A807001);
								String realtimevalues = selectRealTimes(id,
										day, A807001);
								if (realtimevalues != null
										&& !"".equals(realtimevalues)) {
									if (flnamevalues != null
											&& !"".equals(flnamevalues)) {
										if (!"0".equals(flnamevalues)
												&& !"0.0".equals(flnamevalues)) {
											float realTime = Float
													.parseFloat(realtimevalues);
											float flnameandvalue = Float
													.parseFloat(flnamevalues);
											flnameandvalue = flnameandvalue
													+ flvalue1;
											realTime = realTime
													- flnameandvalue;
											flnameandvalue = (float) (Math
													.round(flnameandvalue * 100)) / 100;
											realTime = (float) (Math
													.round(realTime * 100)) / 100;
											String A807702 = realTime + "";
											String A807716 = flnameandvalue
													+ "";
											if (flnameandvalue > showTime) {
												A807716 = "" + showTime;
											}
											updateAttenceSecondDayLogBO3(id,
													day, A807702, A807001,
													A807716);
										} else {

										}
									} else {
										float realTimes = Float
												.parseFloat(realtimevalues);
										realTimes = realTimes - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807702 = realTimes + "";
										String A807716 = flvalue1 + "";
										if (flvalue1 > showTime) {
											A807716 = "" + showTime;
										}
										updateAttenceSecondDayLogBO3(id, day,
												A807702, A807001, A807716);
									}
								} else {
									float realTimes = showTime - flvalue1;
									showTime = (float) (Math
											.round(showTime * 100)) / 100;
									realTimes = (float) (Math
											.round(realTimes * 100)) / 100;
									flvalue1 = (float) (Math
											.round(flvalue1 * 100)) / 100;
									String A807701 = showTime + "";
									String A807702 = realTimes + "";
									String A807716 = flvalue1 + "";
									addA807Lists(id, subID, A807000, A807001,
											day, A807701, A807702, "0", "0",
											A807716);
								}
							}

							String flvalue1s = makeOutWorkDayCollection4(id,
									day, endtimes[1], b);
							if (flvalue1s != null && !"".equals(flvalue1s)) {
								String[] flvaluess = flvalue1s.split(":");
								String flvalue = flvaluess[0];
								float flvalue1 = Float.parseFloat(flvalue);
								String m = flvaluess[1];
								String showTimeValues = flvaluess[2];
								float showTime = Float
										.parseFloat(showTimeValues);
								String A807001 = "" + m;
								String flnamevalues = selectA807s(id, day,
										A807001);
								String realtimevalues = selectRealTimes(id,
										day, A807001);
								if (realtimevalues != null
										&& !"".equals(realtimevalues)) {
									if (flnamevalues != null
											&& !"".equals(flnamevalues)) {
										if (!"0".equals(flnamevalues)
												&& !"0.0".equals(flnamevalues)) {
											float realTime = Float
													.parseFloat(realtimevalues);
											float flnameandvalue = Float
													.parseFloat(flnamevalues);
											flnameandvalue = flnameandvalue
													- (showTime - flvalue1);
											float f = Math.abs(flnameandvalue);
											realTime = showTime - f;
											flnameandvalue = (float) (Math
													.round(flnameandvalue * 100)) / 100;
											realTime = (float) (Math
													.round(realTime * 100)) / 100;
											String A807702 = realTime + "";
											String A807716 = flnameandvalue
													+ "";
											if (flnameandvalue > showTime) {
												A807716 = "" + showTime;
											}
											updateAttenceSecondDayLogBO3(id,
													day, A807702, A807001,
													A807716);
										} else {

										}
									} else {
										float realTimes = Float
												.parseFloat(realtimevalues);
										realTimes = realTimes - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807702 = realTimes + "";
										String A807716 = flvalue1 + "";
										if (flvalue1 > showTime) {
											A807716 = "" + showTime;
										}
										updateAttenceSecondDayLogBO3(id, day,
												A807702, A807001, A807716);
									}
								} else {
									float realTimes = showTime - flvalue1;
									showTime = (float) (Math
											.round(showTime * 100)) / 100;
									realTimes = (float) (Math
											.round(realTimes * 100)) / 100;
									flvalue1 = (float) (Math
											.round(flvalue1 * 100)) / 100;
									String A807701 = showTime + "";
									String A807702 = realTimes + "";
									String A807716 = flvalue1 + "";
									addA807Lists(id, subID, A807000, A807001,
											day, A807701, A807702, "0", "0",
											A807716);
								}
							}

						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/*
	 * 对公出进行日汇总操作(开始时间)
	 */
	public String makeOutWorkDayCollection1(String id, String day, String day1,
			AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						A807702 = realTimes + "";
						String A807716 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO2(id, day, A807701,
									A807702, A807001, A807716);
						}
					} else {
						realTime = realTime - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807716 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807Lists(id, subID, A807000, A807001, day,
									A807701, A807702, "0", "0", A807716);
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对公出进行日汇总操作(结束时间)
	 */
	public String makeOutWorkDayCollection2(String id, String day, String day1,
			AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						A807702 = realTimes + "";
						String A807716 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO2(id, day, A807701,
									A807702, A807001, A807716);
						}
					} else {
						realTime = realTime - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807716 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807Lists(id, subID, A807000, A807001, day,
									A807701, A807702, "0", "0", A807716);
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对公出进行日汇总操作(同一天的开始时间)
	 */
	public String makeOutWorkDayCollection3(String id, String day, String day1,
			AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				String totalValues = "";
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);

					if (totalValues != null && !"".equals(totalValues)) {
						Date dateTotalValues = df.parse(totalValues);
						if (dates.getTime() > dateTotalValues.getTime()
								&& dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					} else {
						if (dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					}

					if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					totalValues = attclassTime11;
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对公出进行日汇总操作(同一天的结束时间)
	 */
	public String makeOutWorkDayCollection4(String id, String day, String day1,
			AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 倒休计算
	 */
	public String calcAttTimeOffRecBO(String id, String day, AttClassBO b,List bs)
			throws SysException {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = df.parse(day);
			String[] yearmonthvalue = day.split("-");
			String yearmonthvalue1 = yearmonthvalue[0] + "-"
					+ yearmonthvalue[1];
			List lists = getAllAttTimeOffCollectBO(id, yearmonthvalue1);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttTimeOffRecBO atttimeoffrecbo = (AttTimeOffRecBO) lists
							.get(i);
					if (statusValue3(atttimeoffrecbo)) {
						String[] begintimes = atttimeoffrecbo.getBeginTime()
								.split(" ");
						String[] endtimes = atttimeoffrecbo.getEndTime().split(
								" ");
						Date date2 = df.parse(begintimes[0]);
						Date date3 = df.parse(endtimes[0]);
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (!begintimes[0].equals(endtimes[0])) {
							if (date1.getTime() > date2.getTime()
									&& date1.getTime() < date3.getTime()) {
								List attseconddaybos = findA807(id, day);
								if (attseconddaybos != null
										&& attseconddaybos.size() > 0) {
									deleteAttenceSecondDayLogBO(id, day);
								}
//								List bs = attenceSetDAO
//										.getAllAttClassDetailBO1(b.getClassID());
								if (bs != null && bs.size() > 0) {
									String[] attclassdetailbos = new String[bs
											.size()];
									for (int j = 0; j < bs.size(); j++) {
										AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
												.get(j);
										attclassdetailbos[j] = attclassdetailbo
												.getItemTime();
									}
									int nss = attclassdetailbos.length;
									int n = nss / 12;
									if (n > 0) {
										int m = 0;
										while (m < n) {
											int p = 12 * m;
											String attclassTime1 = attclassdetailbos[p + 1]
													+ ":00";// 上班时刻
											String attclassTime5 = attclassdetailbos[p + 5]
													+ ":00";// 休息开始
											String attclassTime6 = attclassdetailbos[p + 6]
													+ ":00";// 休息结束
											String attclassTime10 = attclassdetailbos[p + 10]
													+ ":00";// 下班时刻
											DateFormat dfs = new SimpleDateFormat(
													"HH:mm:ss");
											Date dates1 = dfs
													.parse(attclassTime1);
											Date dates5 = dfs
													.parse(attclassTime5);
											Date dates6 = dfs
													.parse(attclassTime6);
											Date dates10 = dfs
													.parse(attclassTime10);
											float shouldTime = ((float) (dates5
													.getTime() - dates1
													.getTime())
													/ (1000 * 60 * 60 * 8) + (float) (dates10
													.getTime() - dates6
													.getTime())
													/ (1000 * 60 * 60 * 8));// 应出勤
											shouldTime = (float) (Math
													.round(shouldTime * 100)) / 100;
											String A807701 = shouldTime + "";
											String A807001 = "" + (m + 1);
											subID = SequenceGenerator
													.getKeyId("A807");
											addA807Lists1(id, subID, A807000,
													A807001, day, A807701, "0",
													"0", "0", "0", A807701,
													"0", "0", "0");
											m++;
										}
									}
								}
							} else if (date1.getTime() == date2.getTime()) {
								makeTimeOffDayCollection1(id, day,
										begintimes[1], b);
							} else if (date1.getTime() == date3.getTime()) {
								makeTimeOffDayCollection2(id, day, endtimes[1],
										b);
							}
						} else if (begintimes[0].equals(endtimes[0])
								&& begintimes[0].equals(day)) {
							String flvalues = makeTimeOffDayCollection3(id,
									day, begintimes[1], b);
							if (flvalues != null && !"".equals(flvalues)) {
								String[] flvaluess = flvalues.split(":");
								String flvalue = flvaluess[0];
								float flvalue1 = Float.parseFloat(flvalue);
								String m = flvaluess[1];
								String showTimeValues = flvaluess[2];
								float showTime = Float
										.parseFloat(showTimeValues);
								String A807001 = "" + m;
								String flnamevalues = selectA807s(id, day,
										A807001);
								String realtimevalues = selectRealTimes(id,
										day, A807001);
								if (realtimevalues != null
										&& !"".equals(realtimevalues)) {
									if (flnamevalues != null
											&& !"".equals(flnamevalues)) {
										if (!"0".equals(flnamevalues)
												&& !"0.0".equals(flnamevalues)) {
											float realTime = Float
													.parseFloat(realtimevalues);
											float flnameandvalue = Float
													.parseFloat(flnamevalues);
											flnameandvalue = flnameandvalue
													+ flvalue1;
											realTime = realTime
													- flnameandvalue;
											flnameandvalue = (float) (Math
													.round(flnameandvalue * 100)) / 100;
											realTime = (float) (Math
													.round(realTime * 100)) / 100;
											String A807702 = realTime + "";
											String A807718 = flnameandvalue
													+ "";
											updateAttenceSecondDayLogBO4(id,
													day, A807702, A807001,
													A807718);
										} else {

										}
									} else {
										float realTimes = Float
												.parseFloat(realtimevalues);
										realTimes = realTimes - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807702 = realTimes + "";
										String A807718 = flvalue1 + "";
										updateAttenceSecondDayLogBO4(id, day,
												A807702, A807001, A807718);
									}
								} else {
									float realTimes = showTime - flvalue1;
									showTime = (float) (Math
											.round(showTime * 100)) / 100;
									realTimes = (float) (Math
											.round(realTimes * 100)) / 100;
									flvalue1 = (float) (Math
											.round(flvalue1 * 100)) / 100;
									String A807701 = showTime + "";
									String A807702 = realTimes + "";
									String A807718 = flvalue1 + "";
									addA807Lists1(id, subID, A807000, A807001,
											day, A807701, A807702, "0", "0",
											"0", A807718, "0", "0", "0");
								}
							}

							String flvalue1s = makeTimeOffDayCollection4(id,
									day, endtimes[1], b);
							if (flvalue1s != null && !"".equals(flvalue1s)) {
								String[] flvaluess = flvalue1s.split(":");
								String flvalue = flvaluess[0];
								float flvalue1 = Float.parseFloat(flvalue);
								String m = flvaluess[1];
								String showTimeValues = flvaluess[2];
								float showTime = Float
										.parseFloat(showTimeValues);
								String A807001 = "" + m;
								String flnamevalues = selectA807(id, day,
										A807001);
								String realtimevalues = selectRealTimes(id,
										day, A807001);
								if (realtimevalues != null
										&& !"".equals(realtimevalues)) {
									if (flnamevalues != null
											&& !"".equals(flnamevalues)) {
										if (!"0".equals(flnamevalues)
												&& !"0.0".equals(flnamevalues)) {
											float realTime = Float
													.parseFloat(realtimevalues);
											float flnameandvalue = Float
													.parseFloat(flnamevalues);
											flnameandvalue = flnameandvalue
													- (showTime - flvalue1);
											float f = Math.abs(flnameandvalue);
											realTime = showTime - f;
											flnameandvalue = (float) (Math
													.round(flnameandvalue * 100)) / 100;
											realTime = (float) (Math
													.round(realTime * 100)) / 100;
											String A807702 = realTime + "";
											String A807718 = flnameandvalue
													+ "";
											updateAttenceSecondDayLogBO4(id,
													day, A807702, A807001,
													A807718);
										} else {

										}
									} else {
										float realTimes = Float
												.parseFloat(realtimevalues);
										realTimes = realTimes - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807702 = realTimes + "";
										String A807718 = flvalue1 + "";
										updateAttenceSecondDayLogBO4(id, day,
												A807702, A807001, A807718);
									}
								} else {
									float realTimes = showTime - flvalue1;
									showTime = (float) (Math
											.round(showTime * 100)) / 100;
									realTimes = (float) (Math
											.round(realTimes * 100)) / 100;
									flvalue1 = (float) (Math
											.round(flvalue1 * 100)) / 100;
									String A807701 = showTime + "";
									String A807702 = realTimes + "";
									String A807718 = flvalue1 + "";
									addA807Lists1(id, subID, A807000, A807001,
											day, A807701, A807702, "0", "0",
											"0", A807718, "0", "0", "0");
								}
							}

						}
					}
				}
			}
		} catch (Exception e) {

		}
		return "";
	}

	/*
	 * 对倒休进行日汇总操作(开始时间)
	 */
	public String makeTimeOffDayCollection1(String id, String day, String day1,
			AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						A807702 = realTimes + "";
						String A807718 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO3(id, day, A807701,
									A807702, A807001, A807718);
						}
					} else {
						realTime = realTime - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807718 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807Lists1(id, subID, A807000, A807001, day,
									A807701, A807702, "0", "0", "0", A807718,
									"0", "0", "0");
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对倒休进行日汇总操作(结束时间)
	 */
	public String makeTimeOffDayCollection2(String id, String day, String day1,
			AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						A807702 = realTimes + "";
						String A807718 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO3(id, day, A807701,
									A807702, A807001, A807718);
						}
					} else {
						realTime = realTime - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807718 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807Lists1(id, subID, A807000, A807001, day,
									A807701, A807702, "0", "0", "0", A807718,
									"0", "0", "0");
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对倒休进行日汇总操作(同一天的开始时间)
	 */
	public String makeTimeOffDayCollection3(String id, String day, String day1,
			AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				String totalValues = "";
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);

					if (totalValues != null && !"".equals(totalValues)) {
						Date dateTotalValues = df.parse(totalValues);
						if (dates.getTime() > dateTotalValues.getTime()
								&& dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					} else {
						if (dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					}

					if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					totalValues = attclassTime11;
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对倒休进行日汇总操作(同一天的结束时间)
	 */
	public String makeTimeOffDayCollection4(String id, String day, String day1,
			AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 工作日延时加班、双休日加班、节假日加班计算
	 */
	public String calcAttOverTimeLogBO(String id, String day)
			throws SysException {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = df.parse(day);
			List lists = getAllAttOverTimeLogCollectBO(id, day);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttOverTimeLogBO attovertimelogbo = (AttOverTimeLogBO) lists
							.get(i);
					String[] begintimes = attovertimelogbo.getBeginTime()
							.split(" ");
					String[] endtimes = attovertimelogbo.getEndTime()
							.split(" ");
					Date date2 = df.parse(begintimes[0]);
					Date date3 = df.parse(endtimes[0]);
					String subID = SequenceGenerator.getKeyId("A807");
					String A807000 = Constants.NO;
					if (!begintimes[0].equals(endtimes[0])) {
						float flvalues = 0;
						if (date1.getTime() > date2.getTime()
								&& date1.getTime() < date3.getTime()) {
							flvalues = 1;
						} else if (date1.getTime() == date2.getTime()) {
							DateFormat df1 = new SimpleDateFormat(
									"yyyy-MM-dd HH:mm:ss");
							Date dateDay = df1.parse(day + " 23:59:59");
							Date dateBegin = df1.parse(attovertimelogbo
									.getBeginTime().trim()
									+ ":00");
							if ("1".equals(attovertimelogbo.getTypeStatus())) {
								flvalues = ((float) (dateDay.getTime() - dateBegin
										.getTime()))
										/ (1000 * 60 * 60 * 8);
							} else {
								flvalues = ((float) (dateDay.getTime() - dateBegin
										.getTime()))
										/ (1000 * 60 * 60 * 24);
							}
						} else if (date1.getTime() == date3.getTime()) {
							DateFormat df1 = new SimpleDateFormat(
									"yyyy-MM-dd HH:mm:ss");
							Date dateDay = df1.parse(day + " 00:00:00");
							Date dateEnd = df1.parse(attovertimelogbo
									.getEndTime().trim()
									+ ":00");
							if ("1".equals(attovertimelogbo.getTypeStatus())) {
								flvalues = ((float) (dateEnd.getTime() - dateDay
										.getTime()))
										/ (1000 * 60 * 60 * 8);
							} else {
								flvalues = ((float) (dateEnd.getTime() - dateDay
										.getTime()))
										/ (1000 * 60 * 60 * 24);
							}
						}
						List attseconddaybos = findA807(id, day);
						if (attseconddaybos != null
								&& attseconddaybos.size() > 0) {
							AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attseconddaybos
									.get(0);
							String A807001 = attenceseconddaylogbo
									.getSecondDay().trim();
							if ("1".equals(attovertimelogbo.getTypeStatus())) {
								if (attenceseconddaylogbo.getWorkAddValue() != null
										&& !"".equals(attenceseconddaylogbo
												.getWorkAddValue())) {
									flvalues += Float
											.parseFloat(attenceseconddaylogbo
													.getWorkAddValue().trim());
								}
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807719 = flvalues + "";
								updateWorkA807(id, day, "A807719", A807719,
										A807001);
							} else if ("2".equals(attovertimelogbo
									.getTypeStatus())) {
								if (attenceseconddaylogbo.getWeekAddValue() != null
										&& !"".equals(attenceseconddaylogbo
												.getWeekAddValue())) {
									flvalues += Float
											.parseFloat(attenceseconddaylogbo
													.getWeekAddValue().trim());
								}
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807720 = flvalues + "";
								updateWorkA807(id, day, "A807720", A807720,
										A807001);
							} else if ("3".equals(attovertimelogbo
									.getTypeStatus())) {
								if (attenceseconddaylogbo.getFeastAddValue() != null
										&& !"".equals(attenceseconddaylogbo
												.getFeastAddValue())) {
									flvalues += Float
											.parseFloat(attenceseconddaylogbo
													.getFeastAddValue().trim());
								}
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807721 = flvalues + "";
								updateWorkA807(id, day, "A807721", A807721,
										A807001);
							}
						} else {
							String A807001 = "1";
							if ("1".equals(attovertimelogbo.getTypeStatus())) {
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807719 = flvalues + "";
								addWorkA807(id, subID, A807000, A807001, day,
										"1", "0", "0", "A807719", A807719);
							} else if ("2".equals(attovertimelogbo
									.getTypeStatus())) {
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807720 = flvalues + "";
								addWorkA807(id, subID, A807000, A807001, day,
										"1", "0", "0", "A807720", A807720);
							} else if ("3".equals(attovertimelogbo
									.getTypeStatus())) {
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807721 = flvalues + "";
								addWorkA807(id, subID, A807000, A807001, day,
										"1", "0", "0", "A807721", A807721);
							}
						}
					} else if (begintimes[0].equals(endtimes[0])
							&& begintimes[0].equals(day)) {
						float flvalues = 0;
						DateFormat df1 = new SimpleDateFormat(
								"yyyy-MM-dd HH:mm:ss");
						Date dateBegin = df1.parse(attovertimelogbo
								.getBeginTime().trim()
								+ ":00");
						Date dateEnd = df1.parse(attovertimelogbo.getEndTime()
								.trim()
								+ ":00");
						if ("1".equals(attovertimelogbo.getTypeStatus())) {
							flvalues = ((float) (dateEnd.getTime() - dateBegin
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else {
							flvalues = ((float) (dateEnd.getTime() - dateBegin
									.getTime()))
									/ (1000 * 60 * 60 * 24);
						}
						List attseconddaybos = findA807(id, day);
						if (attseconddaybos != null
								&& attseconddaybos.size() > 0) {
							AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attseconddaybos
									.get(0);
							String A807001 = attenceseconddaylogbo
									.getSecondDay().trim();
							if ("1".equals(attovertimelogbo.getTypeStatus())) {
								if (attenceseconddaylogbo.getWorkAddValue() != null
										&& !"".equals(attenceseconddaylogbo
												.getWorkAddValue())) {
									flvalues += Float
											.parseFloat(attenceseconddaylogbo
													.getWorkAddValue().trim());
								}
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807719 = flvalues + "";
								updateWorkA807(id, day, "A807719", A807719,
										A807001);
							} else if ("2".equals(attovertimelogbo
									.getTypeStatus())) {
								if (attenceseconddaylogbo.getWeekAddValue() != null
										&& !"".equals(attenceseconddaylogbo
												.getWeekAddValue())) {
									flvalues += Float
											.parseFloat(attenceseconddaylogbo
													.getWeekAddValue().trim());
								}
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807720 = flvalues + "";
								updateWorkA807(id, day, "A807720", A807720,
										A807001);
							} else if ("3".equals(attovertimelogbo
									.getTypeStatus())) {
								if (attenceseconddaylogbo.getFeastAddValue() != null
										&& !"".equals(attenceseconddaylogbo
												.getFeastAddValue())) {
									flvalues += Float
											.parseFloat(attenceseconddaylogbo
													.getFeastAddValue().trim());
								}
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807721 = flvalues + "";
								updateWorkA807(id, day, "A807721", A807721,
										A807001);
							}
						} else {
							String A807001 = "1";
							if ("1".equals(attovertimelogbo.getTypeStatus())) {
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807719 = flvalues + "";
								addWorkA807(id, subID, A807000, A807001, day,
										"1", "0", "0", "A807719", A807719);
							} else if ("2".equals(attovertimelogbo
									.getTypeStatus())) {
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807720 = flvalues + "";
								addWorkA807(id, subID, A807000, A807001, day,
										"1", "0", "0", "A807720", A807720);
							} else if ("3".equals(attovertimelogbo
									.getTypeStatus())) {
								flvalues = (float) (Math.round(flvalues * 100)) / 100;
								String A807721 = flvalues + "";
								addWorkA807(id, subID, A807000, A807001, day,
										"1", "0", "0", "A807721", A807721);
							}
						}
					}
				}
			}
		} catch (Exception e) {

		}
		return "";
	}

	/*
	 * 年假计算
	 */
	public String calcNetWorkHoliday(String id, String day, AttClassBO b,List bs)
			throws SysException {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = df.parse(day);
			String[] yearmonthvalue = day.split("-");
			String yearmonthvalue1 = yearmonthvalue[0] + "-"
					+ yearmonthvalue[1];
			// String yearmonthvalue1=day + " 00:00";
			List lists = getAllAttAnnualDetailAuditBO(id, yearmonthvalue1);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttAnnualDetailAuditBO attannualdetailauditbo = (AttAnnualDetailAuditBO) lists
							.get(i);
					if (statusValue4(attannualdetailauditbo)) {
						if (attannualdetailauditbo.getFurloughno() != null
								&& !"".equals(attannualdetailauditbo
										.getFurloughno())) {

						} else {
							String[] begintimes = attannualdetailauditbo
									.getHolidayBegin().split(" ");
							String[] endtimes = attannualdetailauditbo
									.getHolidayEnd().split(" ");
							Date date2 = df.parse(begintimes[0]);
							Date date3 = df.parse(endtimes[0]);
							String subID = SequenceGenerator.getKeyId("A807");
							String A807000 = Constants.NO;
							if (!begintimes[0].equals(endtimes[0])) {
								if (date1.getTime() > date2.getTime()
										&& date1.getTime() < date3.getTime()) {
									List attseconddaybos = findA807(id, day);
									if (attseconddaybos != null
											&& attseconddaybos.size() > 0) {
										deleteAttenceSecondDayLogBO(id, day);
									}
//									List bs = attenceSetDAO
//											.getAllAttClassDetailBO1(b
//													.getClassID());
									if (bs != null && bs.size() > 0) {
										String[] attclassdetailbos = new String[bs
												.size()];
										for (int j = 0; j < bs.size(); j++) {
											AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
													.get(j);
											attclassdetailbos[j] = attclassdetailbo
													.getItemTime();
										}
										int nss = attclassdetailbos.length;
										int n = nss / 12;
										if (n > 0) {
											int m = 0;
											while (m < n) {
												int p = 12 * m;
												String attclassTime1 = attclassdetailbos[p + 1]
														+ ":00";// 上班时刻
												String attclassTime5 = attclassdetailbos[p + 5]
														+ ":00";// 休息开始
												String attclassTime6 = attclassdetailbos[p + 6]
														+ ":00";// 休息结束
												String attclassTime10 = attclassdetailbos[p + 10]
														+ ":00";// 下班时刻
												DateFormat dfs = new SimpleDateFormat(
														"HH:mm:ss");
												Date dates1 = dfs
														.parse(attclassTime1);
												Date dates5 = dfs
														.parse(attclassTime5);
												Date dates6 = dfs
														.parse(attclassTime6);
												Date dates10 = dfs
														.parse(attclassTime10);
												float shouldTime = ((float) (dates5
														.getTime() - dates1
														.getTime())
														/ (1000 * 60 * 60 * 8) + (float) (dates10
														.getTime() - dates6
														.getTime())
														/ (1000 * 60 * 60 * 8));// 应出勤
												shouldTime = (float) (Math
														.round(shouldTime * 100)) / 100;
												String A807712 = shouldTime
														+ "";
												String A807001 = "" + (m + 1);
												subID = SequenceGenerator
														.getKeyId("A807");
												addWorkA807(id, subID, A807000,
														A807001, day, A807712,
														"0", "0", "A807712",
														A807712);
												m++;
											}
										}
									}
								} else if (date1.getTime() == date2.getTime()) {
									makeNetWorkHolidayCollection1(id, day,
											begintimes[1], b);
								} else if (date1.getTime() == date3.getTime()) {
									makeNetWorkHolidayCollection2(id, day,
											endtimes[1], b);
								}
							} else if (begintimes[0].equals(endtimes[0])
									&& begintimes[0].equals(day)) {
								String flvalues = makeNetWorkHolidayDayCollection3(
										id, day, begintimes[1], b);
								if (flvalues != null && !"".equals(flvalues)) {
									String[] flvaluess = flvalues.split(":");
									String flvalue = flvaluess[0];
									float flvalue1 = Float.parseFloat(flvalue);
									String m = flvaluess[1];
									String showTimeValues = flvaluess[2];
									float showTime = Float
											.parseFloat(showTimeValues);
									String A807001 = "" + m;
									String flnamevalues = selectA807s(id, day,
											A807001);
									String realtimevalues = selectRealTimes(id,
											day, A807001);
									if (realtimevalues != null
											&& !"".equals(realtimevalues)) {
										if (flnamevalues != null
												&& !"".equals(flnamevalues)) {
											if (!"0".equals(flnamevalues)
													&& !"0.0"
															.equals(flnamevalues)) {
												float realTime = Float
														.parseFloat(realtimevalues);
												float flnameandvalue = Float
														.parseFloat(flnamevalues);
												flnameandvalue = flnameandvalue
														+ flvalue1;
												realTime = realTime
														- flnameandvalue;
												flnameandvalue = (float) (Math
														.round(flnameandvalue * 100)) / 100;
												realTime = (float) (Math
														.round(realTime * 100)) / 100;
												String A807702 = realTime + "";
												String A807712 = flnameandvalue
														+ "";
												updateAttenceSecondDayLogBO5(
														id, day, A807702,
														A807001, A807712);
											} else {

											}
										} else {
											float realTimes = Float
													.parseFloat(realtimevalues);
											realTimes = realTimes - flvalue1;
											showTime = (float) (Math
													.round(showTime * 100)) / 100;
											realTimes = (float) (Math
													.round(realTimes * 100)) / 100;
											flvalue1 = (float) (Math
													.round(flvalue1 * 100)) / 100;
											String A807702 = realTimes + "";
											String A807712 = flvalue1 + "";
											updateAttenceSecondDayLogBO5(id,
													day, A807702, A807001,
													A807712);
										}
									} else {
										float realTimes = showTime - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807701 = showTime + "";
										String A807702 = realTimes + "";
										String A807712 = flvalue1 + "";
										addA807Lists2(id, subID, A807000,
												A807001, day, A807701, A807702,
												"0", "0", A807712);
									}
								}

								String flvalue1s = makeONetWorkHolidayDayCollection4(
										id, day, endtimes[1], b);
								if (flvalue1s != null && !"".equals(flvalue1s)) {
									String[] flvaluess = flvalue1s.split(":");
									String flvalue = flvaluess[0];
									float flvalue1 = Float.parseFloat(flvalue);
									String m = flvaluess[1];
									String showTimeValues = flvaluess[2];
									float showTime = Float
											.parseFloat(showTimeValues);
									String A807001 = "" + m;
									String flnamevalues = selectA807(id, day,
											A807001);
									String realtimevalues = selectRealTimes(id,
											day, A807001);
									if (realtimevalues != null
											&& !"".equals(realtimevalues)) {
										if (flnamevalues != null
												&& !"".equals(flnamevalues)) {
											if (!"0".equals(flnamevalues)
													&& !"0.0"
															.equals(flnamevalues)) {
												float realTime = Float
														.parseFloat(realtimevalues);
												float flnameandvalue = Float
														.parseFloat(flnamevalues);
												flnameandvalue = flnameandvalue
														- (showTime - flvalue1);
												float f = Math
														.abs(flnameandvalue);
												realTime = showTime - f;
												flnameandvalue = (float) (Math
														.round(flnameandvalue * 100)) / 100;
												realTime = (float) (Math
														.round(realTime * 100)) / 100;
												String A807702 = realTime + "";
												String A807712 = flnameandvalue
														+ "";
												updateAttenceSecondDayLogBO5(
														id, day, A807702,
														A807001, A807712);
											} else {

											}
										} else {
											float realTimes = Float
													.parseFloat(realtimevalues);
											realTimes = realTimes - flvalue1;
											showTime = (float) (Math
													.round(showTime * 100)) / 100;
											realTimes = (float) (Math
													.round(realTimes * 100)) / 100;
											flvalue1 = (float) (Math
													.round(flvalue1 * 100)) / 100;
											String A807702 = realTimes + "";
											String A807712 = flvalue1 + "";
											updateAttenceSecondDayLogBO5(id,
													day, A807702, A807001,
													A807712);
										}
									} else {
										float realTimes = showTime - flvalue1;
										showTime = (float) (Math
												.round(showTime * 100)) / 100;
										realTimes = (float) (Math
												.round(realTimes * 100)) / 100;
										flvalue1 = (float) (Math
												.round(flvalue1 * 100)) / 100;
										String A807701 = showTime + "";
										String A807702 = realTimes + "";
										String A807712 = flvalue1 + "";
										addA807Lists2(id, subID, A807000,
												A807001, day, A807701, A807702,
												"0", "0", A807712);
									}
								}

							}
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/*
	 * 对年假进行日汇总操作(开始时间)
	 */
	public String makeNetWorkHolidayCollection1(String id, String day,
			String day1, AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						A807702 = realTimes + "";
						String A807712 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO4(id, day, A807701,
									A807702, A807001, A807712);
						}
					} else {
						realTime = realTime - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807712 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807Lists2(id, subID, A807000, A807001, day,
									A807701, A807702, "0", "0", A807712);
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对年假进行日汇总操作(结束时间)
	 */
	public String makeNetWorkHolidayCollection2(String id, String day,
			String day1, AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						realTimes = realTimes - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						A807702 = realTimes + "";
						String A807712 = flvalues + "";
						if (flvalues > 0.0) {
							updateAttenceSecondDayLogBO4(id, day, A807701,
									A807702, A807001, A807712);
						}
					} else {
						realTime = realTime - flvalues;
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807701 = showTime + "";
						String A807702 = realTime + "";
						String A807712 = flvalues + "";
						String subID = SequenceGenerator.getKeyId("A807");
						String A807000 = Constants.NO;
						if (flvalues > 0.0) {
							addA807Lists2(id, subID, A807000, A807001, day,
									A807701, A807702, "0", "0", A807712);
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对年假进行日汇总操作(同一天的开始时间)
	 */
	public String makeNetWorkHolidayDayCollection3(String id, String day,
			String day1, AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				String totalValues = "";
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);

					if (totalValues != null && !"".equals(totalValues)) {
						Date dateTotalValues = df.parse(totalValues);
						if (dates.getTime() > dateTotalValues.getTime()
								&& dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					} else {
						if (dates.getTime() < date1.getTime()) {
							flvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
							flvalue = flvalues + ":" + (m + 1) + ":"
									+ showTimeValues;
						}
					}

					if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					totalValues = attclassTime11;
					m++;
				}
			}
		}
		return flvalue;
	}

	/*
	 * 对年假进行日汇总操作(同一天的结束时间)
	 */
	public String makeONetWorkHolidayDayCollection4(String id, String day,
			String day1, AttClassBO b) throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					float showTimeValues = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalue = flvalues + ":" + (m + 1) + ":"
								+ showTimeValues;
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/**
	 * 年假抵扣事假计算
	 * 
	 * @return
	 * @throws SysException
	 */
	public String calcAttFurloughRecAndNetWorkHoliday(String id, String day,
			AttClassBO b, AttfurloughBO attfurloughbo, String furloughNO)
			throws SysException {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = df.parse(day);
			List lists = findAttFurloughRecAndAttAnnualDetailAuditBO(id,
					furloughNO);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttAnnualDetailAuditBO attannualdetailauditbo = (AttAnnualDetailAuditBO) lists
							.get(i);
					String[] begintimes = attannualdetailauditbo
							.getHolidayBegin().split(" ");
					String[] endtimes = attannualdetailauditbo.getHolidayEnd()
							.split(" ");
					Date date2 = df.parse(begintimes[0]);
					Date date3 = df.parse(endtimes[0]);
					String subID = SequenceGenerator.getKeyId("A807");
					String A807000 = Constants.NO;
					if (!begintimes[0].equals(endtimes[0])) {
						if (date1.getTime() > date2.getTime()
								&& date1.getTime() < date3.getTime()) {
							List attseconddaybos = findA807(id, day);
							if (attseconddaybos != null
									&& attseconddaybos.size() > 0) {
								deleteAttenceSecondDayLogBO(id, day);
							}
							List bs = attenceSetDAO.getAllAttClassDetailBO1(b
									.getClassID());
							if (bs != null && bs.size() > 0) {
								String[] attclassdetailbos = new String[bs
										.size()];
								for (int j = 0; j < bs.size(); j++) {
									AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
											.get(j);
									attclassdetailbos[j] = attclassdetailbo
											.getItemTime();
								}
								int nss = attclassdetailbos.length;
								int n = nss / 12;
								if (n > 0) {
									int m = 0;
									while (m < n) {
										int p = 12 * m;
										String attclassTime1 = attclassdetailbos[p + 1]
												+ ":00";// 上班时刻
										String attclassTime5 = attclassdetailbos[p + 5]
												+ ":00";// 休息开始
										String attclassTime6 = attclassdetailbos[p + 6]
												+ ":00";// 休息结束
										String attclassTime10 = attclassdetailbos[p + 10]
												+ ":00";// 下班时刻
										DateFormat dfs = new SimpleDateFormat(
												"HH:mm:ss");
										Date dates1 = dfs.parse(attclassTime1);
										Date dates5 = dfs.parse(attclassTime5);
										Date dates6 = dfs.parse(attclassTime6);
										Date dates10 = dfs
												.parse(attclassTime10);
										float shouldTime = ((float) (dates5
												.getTime() - dates1.getTime())
												/ (1000 * 60 * 60 * 8) + (float) (dates10
												.getTime() - dates6.getTime())
												/ (1000 * 60 * 60 * 8));// 应出勤
										shouldTime = (float) (Math
												.round(shouldTime * 100)) / 100;
										String A807701 = shouldTime + "";
										String A807001 = "" + (m + 1);
										subID = SequenceGenerator
												.getKeyId("A807");
										addA807IsAttFurloughRecAndNetWorkHoliday(
												id, subID, A807000, A807001,
												day, A807701, "0", "0",
												A807701, attfurloughbo
														.getFlSecondDayfield(),
												"0");
										m++;
									}
								}
							}
						} else if (date1.getTime() == date2.getTime()) {
							calcAttFurloughRecAndNetWorkHoliday1(id, day,
									begintimes[1], b, attfurloughbo
											.getFlSecondDayfield());
						} else if (date1.getTime() == date3.getTime()) {
							calcAttFurloughRecAndNetWorkHoliday2(id, day,
									endtimes[1], b, attfurloughbo
											.getFlSecondDayfield());
						}
					} else if (begintimes[0].equals(endtimes[0])
							&& begintimes[0].equals(day)) {
						calcAttFurloughRecAndNetWorkHoliday3(id, day,
								begintimes[1], endtimes[1], b, attfurloughbo
										.getFlSecondDayfield());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * 对年假抵扣事假进行日汇总操作(开始时间)
	 * 
	 * @param id
	 * @param day
	 * @param day1
	 * @param b
	 * @return
	 * @throws Exception
	 */
	public String calcAttFurloughRecAndNetWorkHoliday1(String id, String day,
			String day1, AttClassBO b, String flSecondDayfield)
			throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date10.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() <= date9.getTime()) {
						flvalues = ((float) (date10.getTime() - dates.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = 0;
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						if (flvalues > 0.0) {
							float flSecondDayfieldValueFloat = 0;
							String flSecondDayfieldValue = selectAttFurloughRecAndNetWorkHoliday(
									flSecondDayfield, id, day, A807001);
							if (flSecondDayfieldValue != null
									&& !"".equals(flSecondDayfieldValue)) {
								float flSecondDayfieldValueFloat1 = Float
										.parseFloat(flSecondDayfieldValue);
								if (flvalues >= flSecondDayfieldValueFloat1) {
									flSecondDayfieldValueFloat = 0;
								} else {
									flSecondDayfieldValueFloat = flSecondDayfieldValueFloat1
											- flvalues;
								}
							}
							realTimes = realTimes
									- (flvalues + flSecondDayfieldValueFloat);
							realTime = (float) (Math.round(realTime * 100)) / 100;
							A807702 = realTimes + "";
							String A807712 = flvalues + "";
							String flname = flSecondDayfield;
							String flvalue1 = "" + flSecondDayfieldValueFloat;
							UpdateAttFurloughRecAndNetWorkHoliday(A807701,
									A807702, A807712, flname, flvalue1, id,
									day, A807001);
						}
					} else {
						// realTime = realTime - flvalues;
						// realTime = (float) (Math.round(realTime * 100)) /
						// 100;
						// String A807701 = showTime + "";
						// String A807702 = realTime + "";
						// String A807712 = flvalues + "";
						// String subID = SequenceGenerator.getKeyId("A807");
						// String A807000 = Constants.NO;
						// if (flvalues > 0.0) {
						// addA807Lists2(id, subID, A807000, A807001, day,
						// A807701, A807702, "0", "0", A807712);
						// }
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/**
	 * 对年假抵扣事假进行日汇总操作(结束时间)
	 * 
	 * @param id
	 * @param day
	 * @param day1
	 * @param b
	 * @return
	 * @throws Exception
	 */
	public String calcAttFurloughRecAndNetWorkHoliday2(String id, String day,
			String day1, AttClassBO b, String flSecondDayfield)
			throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day1 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (dates.getTime() < date1.getTime()) {
						flvalues = 0;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues = ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues = ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					}
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					float showTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					showTime = (float) (Math.round(showTime * 100)) / 100;
					float realTime = ((float) (date5.getTime() - date1
							.getTime()) + (float) (date10.getTime() - date6
							.getTime()))
							/ (1000 * 60 * 60 * 8);
					realTime = (float) (Math.round(realTime * 100)) / 100;

					String A807001 = "" + (m + 1);
					List attenceseconddaylogbos = findAttenceSecondDayLogBO(id,
							day, A807001);
					if (attenceseconddaylogbos != null
							&& attenceseconddaylogbos.size() > 0) {
						AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
								.get(0);
						String A807701 = attenceseconddaylogbo.getShouldTime();
						String A807702 = attenceseconddaylogbo.getRealityTime();
						float realTimes = Float.parseFloat(A807702);
						if (flvalues > 0.0) {
							float flSecondDayfieldValueFloat = 0;
							String flSecondDayfieldValue = selectAttFurloughRecAndNetWorkHoliday(
									flSecondDayfield, id, day, A807001);
							if (flSecondDayfieldValue != null
									&& !"".equals(flSecondDayfieldValue)) {
								float flSecondDayfieldValueFloat1 = Float
										.parseFloat(flSecondDayfieldValue);
								if (flvalues >= flSecondDayfieldValueFloat1) {
									flSecondDayfieldValueFloat = 0;
								} else {
									flSecondDayfieldValueFloat = flSecondDayfieldValueFloat1
											- flvalues;
								}
							}
							realTimes = realTimes
									- (flvalues + flSecondDayfieldValueFloat);
							realTime = (float) (Math.round(realTime * 100)) / 100;
							A807702 = realTimes + "";
							String A807712 = flvalues + "";
							String flname = flSecondDayfield;
							String flvalue1 = "" + flSecondDayfieldValueFloat;
							UpdateAttFurloughRecAndNetWorkHoliday(A807701,
									A807702, A807712, flname, flvalue1, id,
									day, A807001);
						}
					} else {
						// realTime = realTime - flvalues;
						// realTime = (float) (Math.round(realTime * 100)) /
						// 100;
						// String A807701 = showTime + "";
						// String A807702 = realTime + "";
						// String A807712 = flvalues + "";
						// String subID = SequenceGenerator.getKeyId("A807");
						// String A807000 = Constants.NO;
						// if (flvalues > 0.0) {
						// addA807Lists2(id, subID, A807000, A807001, day,
						// A807701, A807702, "0", "0", A807712);
						// }
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	/**
	 * 对年假抵扣事假进行日汇总操作(同一天的开始时间、同一天的结束时间)
	 * 
	 * @param id
	 * @param day
	 * @param day1
	 * @param b
	 * @return
	 * @throws Exception
	 */
	public String calcAttFurloughRecAndNetWorkHoliday3(String id, String day,
			String day1, String day2, AttClassBO b, String flSecondDayfield)
			throws Exception {
		String flvalue = "";
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date begindates = df.parse(day1 + ":00");
		Date enddates = df.parse(day2 + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					float flvalues = 0;
					if (begindates.getTime() >= date0.getTime()
							&& begindates.getTime() <= date11.getTime()
							&& enddates.getTime() > date11.getTime()) {
						float beginflvalues = 0;
						if (begindates.getTime() < date1.getTime()) {
							beginflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() >= date1.getTime()
								&& begindates.getTime() <= date3.getTime()) {
							beginflvalues = ((float) (date5.getTime() - begindates
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() > date3.getTime()
								&& begindates.getTime() <= date4.getTime()) {
							beginflvalues = ((float) (date5.getTime() - begindates
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() > date4.getTime()
								&& begindates.getTime() < date6.getTime()) {
							beginflvalues = ((float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() >= date6.getTime()
								&& begindates.getTime() < date7.getTime()) {
							beginflvalues = ((float) (date10.getTime() - begindates
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() >= date7.getTime()
								&& begindates.getTime() <= date8.getTime()) {
							beginflvalues = ((float) (date10.getTime() - begindates
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() > date8.getTime()
								&& begindates.getTime() <= date9.getTime()) {
							beginflvalues = ((float) (date10.getTime() - begindates
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() >= date10.getTime()) {
							beginflvalues = 0;
						}
						flvalues = beginflvalues;
						flvalues = (float) (Math.round(flvalues * 100)) / 100;
						float showTime = ((float) (date5.getTime() - date1
								.getTime()) + (float) (date10.getTime() - date6
								.getTime()))
								/ (1000 * 60 * 60 * 8);
						showTime = (float) (Math.round(showTime * 100)) / 100;
						float realTime = ((float) (date5.getTime() - date1
								.getTime()) + (float) (date10.getTime() - date6
								.getTime()))
								/ (1000 * 60 * 60 * 8);
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807001 = "" + (m + 1);
						List attenceseconddaylogbos = findAttenceSecondDayLogBO(
								id, day, A807001);
						if (attenceseconddaylogbos != null
								&& attenceseconddaylogbos.size() > 0) {
							AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
									.get(0);
							String A807701 = attenceseconddaylogbo
									.getShouldTime();
							String A807702 = attenceseconddaylogbo
									.getRealityTime();
							float realTimes = Float.parseFloat(A807702);
							if (flvalues > 0.0) {
								float flSecondDayfieldValueFloat = 0;
								String flSecondDayfieldValue = selectAttFurloughRecAndNetWorkHoliday(
										flSecondDayfield, id, day, A807001);
								if (flSecondDayfieldValue != null
										&& !"".equals(flSecondDayfieldValue)) {
									float flSecondDayfieldValueFloat1 = Float
											.parseFloat(flSecondDayfieldValue);
									if (flvalues >= flSecondDayfieldValueFloat1) {
										flSecondDayfieldValueFloat = 0;
									} else {
										flSecondDayfieldValueFloat = flSecondDayfieldValueFloat1
												- flvalues;
									}
								}
								realTimes = realTimes
										- (flvalues + flSecondDayfieldValueFloat);
								realTime = (float) (Math.round(realTime * 100)) / 100;
								A807702 = realTimes + "";
								String A807712 = flvalues + "";
								String flname = flSecondDayfield;
								String flvalue1 = ""
										+ flSecondDayfieldValueFloat;
								UpdateAttFurloughRecAndNetWorkHoliday(A807701,
										A807702, A807712, flname, flvalue1, id,
										day, A807001);
							}
						} else {
							// realTime = realTime - flvalues;
							// realTime = (float) (Math.round(realTime * 100)) /
							// 100;
							// String A807701 = showTime + "";
							// String A807702 = realTime + "";
							// String A807712 = flvalues + "";
							// String subID =
							// SequenceGenerator.getKeyId("A807");
							// String A807000 = Constants.NO;
							// if (flvalues > 0.0) {
							// addA807Lists2(id, subID, A807000, A807001, day,
							// A807701, A807702, "0", "0", A807712);
							// }
						}
					} else if (begindates.getTime() < date0.getTime()
							&& enddates.getTime() >= date0.getTime()
							&& enddates.getTime() <= date11.getTime()) {
						float endflvalues = 0;
						if (enddates.getTime() < date1.getTime()) {
							endflvalues = 0;
						} else if (enddates.getTime() >= date1.getTime()
								&& enddates.getTime() <= date3.getTime()) {
							endflvalues = ((float) (enddates.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() > date3.getTime()
								&& enddates.getTime() <= date4.getTime()) {
							endflvalues = ((float) (enddates.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() > date4.getTime()
								&& enddates.getTime() < date6.getTime()) {
							endflvalues = ((float) (date5.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() >= date6.getTime()
								&& enddates.getTime() < date7.getTime()) {
							endflvalues = ((float) (enddates.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() >= date7.getTime()
								&& enddates.getTime() <= date8.getTime()) {
							endflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (enddates.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() > date8.getTime()
								&& enddates.getTime() < date10.getTime()) {
							endflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (enddates.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() >= date10.getTime()) {
							endflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						}
						flvalues = endflvalues;
						flvalues = (float) (Math.round(flvalues * 100)) / 100;
						float showTime = ((float) (date5.getTime() - date1
								.getTime()) + (float) (date10.getTime() - date6
								.getTime()))
								/ (1000 * 60 * 60 * 8);
						showTime = (float) (Math.round(showTime * 100)) / 100;
						float realTime = ((float) (date5.getTime() - date1
								.getTime()) + (float) (date10.getTime() - date6
								.getTime()))
								/ (1000 * 60 * 60 * 8);
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807001 = "" + (m + 1);
						List attenceseconddaylogbos = findAttenceSecondDayLogBO(
								id, day, A807001);
						if (attenceseconddaylogbos != null
								&& attenceseconddaylogbos.size() > 0) {
							AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
									.get(0);
							String A807701 = attenceseconddaylogbo
									.getShouldTime();
							String A807702 = attenceseconddaylogbo
									.getRealityTime();
							float realTimes = Float.parseFloat(A807702);
							if (flvalues > 0.0) {
								float flSecondDayfieldValueFloat = 0;
								String flSecondDayfieldValue = selectAttFurloughRecAndNetWorkHoliday(
										flSecondDayfield, id, day, A807001);
								if (flSecondDayfieldValue != null
										&& !"".equals(flSecondDayfieldValue)) {
									float flSecondDayfieldValueFloat1 = Float
											.parseFloat(flSecondDayfieldValue);
									if (flvalues >= flSecondDayfieldValueFloat1) {
										flSecondDayfieldValueFloat = 0;
									} else {
										flSecondDayfieldValueFloat = flSecondDayfieldValueFloat1
												- flvalues;
									}
								}
								realTimes = realTimes
										- (flvalues + flSecondDayfieldValueFloat);
								realTime = (float) (Math.round(realTime * 100)) / 100;
								A807702 = realTimes + "";
								String A807712 = flvalues + "";
								String flname = flSecondDayfield;
								String flvalue1 = ""
										+ flSecondDayfieldValueFloat;
								UpdateAttFurloughRecAndNetWorkHoliday(A807701,
										A807702, A807712, flname, flvalue1, id,
										day, A807001);
							}
						} else {
							// realTime = realTime - flvalues;
							// realTime = (float) (Math.round(realTime * 100)) /
							// 100;
							// String A807701 = showTime + "";
							// String A807702 = realTime + "";
							// String A807712 = flvalues + "";
							// String subID =
							// SequenceGenerator.getKeyId("A807");
							// String A807000 = Constants.NO;
							// if (flvalues > 0.0) {
							// addA807Lists2(id, subID, A807000, A807001, day,
							// A807701, A807702, "0", "0", A807712);
							// }
						}
					} else if (begindates.getTime() >= date0.getTime()
							&& begindates.getTime() <= date11.getTime()
							&& enddates.getTime() >= date0.getTime()
							&& enddates.getTime() <= date11.getTime()) {
						float beginflvalues = 0;
						float endflvalues = 0;
						if (begindates.getTime() < date1.getTime()) {
							beginflvalues = 0;
						} else if (begindates.getTime() >= date1.getTime()
								&& begindates.getTime() <= date3.getTime()) {
							beginflvalues = ((float) (begindates.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() > date3.getTime()
								&& begindates.getTime() <= date4.getTime()) {
							beginflvalues = ((float) (begindates.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() > date4.getTime()
								&& begindates.getTime() < date6.getTime()) {
							beginflvalues = ((float) (date5.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() >= date6.getTime()
								&& begindates.getTime() < date7.getTime()) {
							beginflvalues = ((float) (begindates.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() >= date7.getTime()
								&& begindates.getTime() <= date8.getTime()) {
							beginflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (begindates.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() > date8.getTime()
								&& begindates.getTime() < date10.getTime()) {
							beginflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (begindates.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (begindates.getTime() >= date10.getTime()) {
							beginflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						}

						if (enddates.getTime() < date1.getTime()) {
							endflvalues = 0;
						} else if (enddates.getTime() >= date1.getTime()
								&& enddates.getTime() <= date3.getTime()) {
							endflvalues = ((float) (enddates.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() > date3.getTime()
								&& enddates.getTime() <= date4.getTime()) {
							endflvalues = ((float) (enddates.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() > date4.getTime()
								&& enddates.getTime() < date6.getTime()) {
							endflvalues = ((float) (date5.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() >= date6.getTime()
								&& enddates.getTime() < date7.getTime()) {
							endflvalues = ((float) (enddates.getTime() - date1
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() >= date7.getTime()
								&& enddates.getTime() <= date8.getTime()) {
							endflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (enddates.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() > date8.getTime()
								&& enddates.getTime() < date10.getTime()) {
							endflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (enddates.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						} else if (enddates.getTime() >= date10.getTime()) {
							endflvalues = ((float) (date5.getTime() - date1
									.getTime()) + (float) (date10.getTime() - date6
									.getTime()))
									/ (1000 * 60 * 60 * 8);
						}
						flvalues = endflvalues - beginflvalues;
						flvalues = (float) (Math.round(flvalues * 100)) / 100;
						float showTime = ((float) (date5.getTime() - date1
								.getTime()) + (float) (date10.getTime() - date6
								.getTime()))
								/ (1000 * 60 * 60 * 8);
						showTime = (float) (Math.round(showTime * 100)) / 100;
						float realTime = ((float) (date5.getTime() - date1
								.getTime()) + (float) (date10.getTime() - date6
								.getTime()))
								/ (1000 * 60 * 60 * 8);
						realTime = (float) (Math.round(realTime * 100)) / 100;
						String A807001 = "" + (m + 1);
						List attenceseconddaylogbos = findAttenceSecondDayLogBO(
								id, day, A807001);
						if (attenceseconddaylogbos != null
								&& attenceseconddaylogbos.size() > 0) {
							AttenceSecondDayLogBO attenceseconddaylogbo = (AttenceSecondDayLogBO) attenceseconddaylogbos
									.get(0);
							String A807701 = attenceseconddaylogbo
									.getShouldTime();
							String A807702 = attenceseconddaylogbo
									.getRealityTime();
							float realTimes = Float.parseFloat(A807702);
							if (flvalues > 0.0) {
								float flSecondDayfieldValueFloat = 0;
								String flSecondDayfieldValue = selectAttFurloughRecAndNetWorkHoliday(
										flSecondDayfield, id, day, A807001);
								if (flSecondDayfieldValue != null
										&& !"".equals(flSecondDayfieldValue)) {
									float flSecondDayfieldValueFloat1 = Float
											.parseFloat(flSecondDayfieldValue);
									if (flvalues >= flSecondDayfieldValueFloat1) {
										flSecondDayfieldValueFloat = 0;
									} else {
										flSecondDayfieldValueFloat = flSecondDayfieldValueFloat1
												- flvalues;
									}
								}
								realTimes = realTimes
										- (flvalues + flSecondDayfieldValueFloat);
								realTime = (float) (Math.round(realTime * 100)) / 100;
								A807702 = realTimes + "";
								String A807712 = flvalues + "";
								String flname = flSecondDayfield;
								String flvalue1 = ""
										+ flSecondDayfieldValueFloat;
								UpdateAttFurloughRecAndNetWorkHoliday(A807701,
										A807702, A807712, flname, flvalue1, id,
										day, A807001);
							}
						} else {
							// realTime = realTime - flvalues;
							// realTime = (float) (Math.round(realTime * 100)) /
							// 100;
							// String A807701 = showTime + "";
							// String A807702 = realTime + "";
							// String A807712 = flvalues + "";
							// String subID =
							// SequenceGenerator.getKeyId("A807");
							// String A807000 = Constants.NO;
							// if (flvalues > 0.0) {
							// addA807Lists2(id, subID, A807000, A807001, day,
							// A807701, A807702, "0", "0", A807712);
							// }
						}
					}
					m++;
				}
			}
		}
		return flvalue;
	}

	public String selectAttFurloughRecAndNetWorkHoliday(String seconddaykey,
			String id, String day, String secondDay) throws SysException {
		String sql = "select " + seconddaykey + " from  A807  where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		return activeapi.queryForString(sql);
	}

	public void UpdateAttFurloughRecAndNetWorkHoliday(String A807701,
			String A807702, String A807712, String flname, String flvalue,
			String id, String day, String A807001) throws SysException {
		String updateSQL = "update A807 set  A807701='" + A807701
				+ "',A807702='" + A807702 + "',A807712='" + A807712 + "',"
				+ flname + "='" + flvalue + "' where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + A807001
				+ "'";
		activeapi.executeSql(updateSQL);
	}

	public void addWorkA807(String id, String subID, String A807000,
			String A807001, String day, String A807701, String A807702,
			String A807703, String addworkkey, String addworkvalue)
			throws SysException {
		String sql = "insert into a807(ID,SUBID,A807000,A807001,A807700,A807701,A807702,A807703,"
				+ addworkkey
				+ ") values('"
				+ id
				+ "','"
				+ subID
				+ "','"
				+ A807000
				+ "','"
				+ A807001
				+ "','"
				+ day
				+ "','"
				+ A807701
				+ "','"
				+ A807702
				+ "','"
				+ A807703
				+ "','"
				+ addworkvalue
				+ "')";
		activeapi.executeSql(sql);
	}

	public void updateWorkA807(String id, String day, String addworkkey,
			String addworkvalue, String A807001) throws SysException {
		String sql = "update a807 set " + addworkkey + "='" + addworkvalue
				+ "' where ID='" + id + "' and a807700='" + day
				+ "' and A807001='" + A807001 + "'";
		activeapi.executeSql(sql);
	}

	public List getAllAttEvcctionRecBO(String id, String day, AttClassBO b)
			throws SysException {
		return cardMessageDAO.getAllAttEvcctionRecBO(id, day, b);
	}

	public List getAllAttEvcctionRecBO1(String id, String day)
			throws SysException {
		return cardMessageDAO.getAllAttEvcctionRecBO1(id, day);
	}

	public List getAllAttEvcctionRecCollectBO(String id, String day)
			throws SysException {
		return cardMessageDAO.getAllAttEvcctionRecCollectBO(id, day);
	}

	public List getAllAttOutWorkCollectBO(String id, String day)
			throws SysException {
		return cardMessageDAO.getAllAttOutWorkCollectBO(id, day);
	}

	public List getAllAttOverTimeLogCollectBO(String id, String day)
			throws SysException {
		return cardMessageDAO.getAllAttOverTimeLogCollectBO(id, day);
	}

	public List getAllAttTimeOffCollectBO(String id, String day)
			throws SysException {
		return cardMessageDAO.getAllAttTimeOffCollectBO(id, day);
	}

	public List getAllAttAnnualDetailAuditBO(String id, String day)
			throws SysException {
		return cardMessageDAO.getAllAttAnnualDetailAuditBO(id, day);
	}

	public List findAttFurloughRecAndAttAnnualDetailAuditBO(String id,
			String furloughNo) throws SysException {
		return cardMessageDAO.findAttFurloughRecAndAttAnnualDetailAuditBO(id,
				furloughNo);
	}

	public boolean statusValue1(AttEvcctionRecCollectBO attevcctionrecbo) {
		boolean success = true;
		return success;
	}

	public boolean statusValue2(AttOutWorkCollectBO attoutworkcollectbo) {
		boolean success = true;
		return success;
	}

	public boolean statusValue3(AttTimeOffRecBO atttimeoffrecbo) {
		boolean success = true;
		return success;
	}

	public boolean statusValue4(AttAnnualDetailAuditBO attannualdetailauditbo) {
		boolean success = true;
		return success;
	}

	public void addA807(String id, String subID, String A807000,
			String A807001, String day, String A807701, String A807702,
			String A807703, String A807715) throws SysException {
		String sql = "insert into a807(ID,SUBID,A807000,A807001,A807700,A807701,A807702,A807703,A807715) values('"
				+ id
				+ "','"
				+ subID
				+ "','"
				+ A807000
				+ "','"
				+ A807001
				+ "','"
				+ day
				+ "','"
				+ A807701
				+ "','"
				+ A807702
				+ "','"
				+ A807703 + "','" + A807715 + "')";
		activeapi.executeSql(sql);
	}

	public void addA807Lists(String id, String subID, String A807000,
			String A807001, String day, String A807701, String A807702,
			String A807703, String A807715, String A807716) throws SysException {
		String sql = "insert into a807(ID,SUBID,A807000,A807001,A807700,A807701,A807702,A807703,A807715,A807716) values('"
				+ id
				+ "','"
				+ subID
				+ "','"
				+ A807000
				+ "','"
				+ A807001
				+ "','"
				+ day
				+ "','"
				+ A807701
				+ "','"
				+ A807702
				+ "','"
				+ A807703 + "','" + A807715 + "','" + A807716 + "')";
		activeapi.executeSql(sql);
	}

	public void addA807Lists1(String id, String subID, String A807000,
			String A807001, String day, String A807701, String A807702,
			String A807703, String A807715, String A807716, String A807718,
			String A807719, String A807720, String A807721) throws SysException {
		String sql = "insert into a807(ID,SUBID,A807000,A807001,A807700,A807701,A807702,A807703,A807715,A807716,A807718,A807719,A807720,A807721) values('"
				+ id
				+ "','"
				+ subID
				+ "','"
				+ A807000
				+ "','"
				+ A807001
				+ "','"
				+ day
				+ "','"
				+ A807701
				+ "','"
				+ A807702
				+ "','"
				+ A807703
				+ "','"
				+ A807715
				+ "','"
				+ A807716
				+ "','"
				+ A807718
				+ "','" + A807719 + "','" + A807720 + "','" + A807721 + "')";
		activeapi.executeSql(sql);
	}

	public void addA807Lists2(String id, String subID, String A807000,
			String A807001, String day, String A807701, String A807702,
			String A807703, String A807715, String A807712) throws SysException {
		String sql = "insert into a807(ID,SUBID,A807000,A807001,A807700,A807701,A807702,A807703,A807715,A807712) values('"
				+ id
				+ "','"
				+ subID
				+ "','"
				+ A807000
				+ "','"
				+ A807001
				+ "','"
				+ day
				+ "','"
				+ A807701
				+ "','"
				+ A807702
				+ "','"
				+ A807703 + "','" + A807715 + "','" + A807712 + "')";
		activeapi.executeSql(sql);
	}

	public void updateAttenceSecondDayLogBO1(String id, String day,
			String A807701, String A807702, String secondDay, String A807715)
			throws SysException {
		String updateSQL = "update A807 set  A807701='" + A807701
				+ "',A807702='" + A807702 + "',A807715='" + A807715
				+ "' where id='" + id + "' and A807700='" + day
				+ "' and  A807001 like '" + secondDay + "'";
		activeapi.executeSql(updateSQL);
	}

	public void updateAttenceSecondDayLogBO2(String id, String day,
			String A807702, String secondDay, String A807715)
			throws SysException {
		String updateSQL = "update A807 set  A807702='" + A807702
				+ "',A807715='" + A807715 + "' where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		activeapi.executeSql(updateSQL);
	}

	public void updateAttenceSecondDayLogBO3(String id, String day,
			String A807702, String secondDay, String A807716)
			throws SysException {
		String updateSQL = "update A807 set  A807702='" + A807702
				+ "',A807716='" + A807716 + "' where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		activeapi.executeSql(updateSQL);
	}

	public void updateAttenceSecondDayLogBO4(String id, String day,
			String A807702, String secondDay, String A807718)
			throws SysException {
		String updateSQL = "update A807 set  A807702='" + A807702
				+ "',A807718='" + A807718 + "' where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		activeapi.executeSql(updateSQL);
	}

	public void updateAttenceSecondDayLogBO5(String id, String day,
			String A807702, String secondDay, String A807712)
			throws SysException {
		String updateSQL = "update A807 set  A807702='" + A807702
				+ "',A807712='" + A807712 + "' where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		activeapi.executeSql(updateSQL);
	}

	public void updateAttenceSecondDayLogBO2(String id, String day,
			String A807701, String A807702, String secondDay, String A807716)
			throws SysException {
		String updateSQL = "update A807 set  A807701='" + A807701
				+ "',A807702='" + A807702 + "',A807716='" + A807716
				+ "' where id='" + id + "' and A807700='" + day
				+ "' and  A807001 like '" + secondDay + "'";
		activeapi.executeSql(updateSQL);
	}

	public void updateAttenceSecondDayLogBO3(String id, String day,
			String A807701, String A807702, String secondDay, String A807718)
			throws SysException {
		String updateSQL = "update A807 set  A807701='" + A807701
				+ "',A807702='" + A807702 + "',A807718='" + A807718
				+ "' where id='" + id + "' and A807700='" + day
				+ "' and  A807001 like '" + secondDay + "'";
		activeapi.executeSql(updateSQL);
	}

	public void updateAttenceSecondDayLogBO4(String id, String day,
			String A807701, String A807702, String secondDay, String A807712)
			throws SysException {
		String updateSQL = "update A807 set  A807701='" + A807701
				+ "',A807702='" + A807702 + "',A807712='" + A807712
				+ "' where id='" + id + "' and A807700='" + day
				+ "' and  A807001 like '" + secondDay + "'";
		activeapi.executeSql(updateSQL);
	}

	public String selectA807(String id, String day, String secondDay)
			throws SysException {
		String sql = "select A807715 from  A807  where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		return activeapi.queryForString(sql);
	}

	public String selectA807s(String id, String day, String secondDay)
			throws SysException {
		String sql = "select A807716 from  A807  where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		return activeapi.queryForString(sql);
	}

	public void addA809s(String id, String subID, String A809000, String day,
			String A809701, String A809702, String A809703, String flvalue)
			throws SysException {
		String sql = "insert into a809(ID,SUBID,A809000,A809700,A809701,A809702,A809703,A809715) values('"
				+ id
				+ "','"
				+ subID
				+ "','"
				+ A809000
				+ "','"
				+ day
				+ "','"
				+ A809701
				+ "','"
				+ A809702
				+ "','"
				+ A809703
				+ "','"
				+ flvalue
				+ "')";
		activeapi.executeSql(sql);
	}

	public void UpdateA809AttEvcctionRecBO(String flvalue, String id, String day)
			throws SysException {
		String updateSQL = "update a809 set A809715='" + flvalue
				+ "' where id='" + id + "' and A809700='" + day + "'";
		activeapi.executeSql(updateSQL);
	}

	public void UpdateA809AttEvcctionRecBO1(String attenceRate,
			String realityTime, String flvalue, String id, String day)
			throws SysException {
		String updateSQL = "update a809 set A809703='" + attenceRate
				+ "',A809702='" + realityTime + "',A809715='" + flvalue
				+ "' where id='" + id + "' and A809700='" + day + "'";
		activeapi.executeSql(updateSQL);
	}

	/*
	 * 换班
	 */
	public AttClassBO changeWork(String orguid, String bo, String day)
			throws SysException {
		AttClassBO attclassbo = null;
		AttClassGroupBO attclassgroupbo = findAttClassGroupBObyId(bo);
		/*
		 * 某天的班次分为正常班组和倒班班组
		 */
		if (attclassgroupbo.getLinkClass() != null
				&& !"".equals(attclassgroupbo.getLinkClass())) {
			attclassbo = getPeriodInfo2(orguid, bo, day);
		} else {
			attclassbo = getPeriodInfo1(bo, day);
		}
		return attclassbo;
	}

	/*
	 * 换班1
	 */
	public AttClassBO changeWork1(String id, String orguid, String bo,
			String day) throws SysException {
		AttClassBO attclassbo = null;
		List attclasslists = cardMessageDAO.findAttChangeWorkBO(id, day);
		if (attclasslists != null && attclasslists.size() > 0) {
			AttChangeWorkBO attchangeworkbo = (AttChangeWorkBO) attclasslists
					.get(0);
			if (!"1".equals(attchangeworkbo.getNewClass())) {
				attclassbo = findAttClassBObyId(attchangeworkbo.getNewClass());
			} else {
				attclassbo = new AttClassBO();
				attclassbo.setClassID("1");
				attclassbo.setClassName("休息");
				attclassbo.setShortName("休息");
			}
			return attclassbo;
		}
		AttClassGroupBO attclassgroupbo = findAttClassGroupBObyId(bo);
		/*
		 * 某天的班次分为正常班组和倒班班组
		 */
		if (attclassgroupbo.getLinkClass() != null
				&& !"".equals(attclassgroupbo.getLinkClass())) {
			attclassbo = getPeriodInfo2(orguid, bo, day);
		} else {
			attclassbo = getPeriodInfo1(bo, day);
		}
		return attclassbo;
	}

	/*
	 * 换班2
	 */
	public String changeWork2(String id, String day) throws SysException {
		String str = "";
		List attclasslists = cardMessageDAO.findAttChangeWorkBO(id, day);
		if (attclasslists != null && attclasslists.size() > 0) {
			AttChangeWorkBO attchangeworkbo = (AttChangeWorkBO) attclasslists
					.get(0);
			if (!"1".equals(attchangeworkbo.getNewClass())) {
				str = "str";
			} else {
				str = "1";
			}
		}
		return str;
	}

	/*
	 * 换班中取得某人某天所上的班次信息
	 */
	public AttClassBO getPeriodInfo1(String groupID, String aDate) {
		AttClassBO attclassbo = null;
		try {
			AttClassGroupBO attclassgroupbo = findAttClassGroupBObyId(groupID);
			AttClassBO[] attclassbos = new AttClassBO[Integer
					.parseInt(attclassgroupbo.getGroupPeriod())];
			List lists = getATTRearrangeBO(groupID);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					ATTRearrangeBO attRearrangeBO = (ATTRearrangeBO) lists
							.get(i);
					if (attRearrangeBO.getLinkClass() != null
							&& !"".equals(attRearrangeBO.getLinkClass())) {
						if (!"1".equals(attRearrangeBO.getLinkClass())) {
							AttClassBO attClassBO = findAttClassBObyId(attRearrangeBO
									.getLinkClass());
							if (attClassBO != null) {
								attclassbos[i] = attClassBO;
							} else {
								attclassbos[i] = null;
							}
						} else {
							AttClassBO attClassBOS = new AttClassBO();
							attClassBOS.setClassID("1");
							attClassBOS.setClassName("休息");
							attClassBOS.setShortName("休息");
							attclassbos[i] = attClassBOS;
						}
					} else {
						attclassbos[i] = null;
					}

				}
			}
			List lists1 = getAllATTRearrangeDateBO(groupID);
			if (lists1 != null && lists1.size() > 0) {
				for (int i = 0; i < lists1.size(); i++) {
					ATTRearrangeDateBO attrearrangedatebo = (ATTRearrangeDateBO) lists1
							.get(i);
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					Date date1 = df.parse(aDate);
					Date date2 = df.parse(attrearrangedatebo.getBeginDate());
					if (date1.getTime() >= date2.getTime()) {
						// d1,d2：(date1.getTime() - date2.getTime())/ (1000 * 60
						// * 60 * 24)
						if ((date1.getTime() - date2.getTime())
								/ (1000 * 60 * 60 * 24) < attclassbos.length) {
							attclassbo = attclassbos[(int) (date1.getTime() - date2
									.getTime())
									/ (1000 * 60 * 60 * 24)];
						} else {
							int n = (int) ((date1.getTime() - date2.getTime()) / (1000 * 60 * 60 * 24));
							int ns = attclassbos.length;
							int nss = Math.abs(n % ns);
							attclassbo = attclassbos[nss];
						}
						return attclassbo;
					}
				}
			}
		} catch (Exception e) {
		}
		return attclassbo;
	}

	/*
	 * 正常班中取得某人某天所上的班次信息
	 */
	public AttClassBO getPeriodInfo2(String orguid, String groupID, String aDate) {
		AttClassBO attclassbo = null;
		try {
			String ss = aDate;
			/*
			 * 比较调休日
			 */
			List attworkdatelists = attfeastDAO.getAllAttWorkDate(orguid);
			if (attworkdatelists != null && attworkdatelists.size() > 0) {
				for (int i = 0; i < attworkdatelists.size(); i++) {
					AttWorkDateBO attworkdatebo = (AttWorkDateBO) attworkdatelists
							.get(i);
					if (ss.equals(attworkdatebo.getWorkDate().trim())) {
						if (groupID != null && !"".equals(groupID)) {
							AttClassGroupBO attclassgroupbo = findAttClassGroupBObyId(groupID);
							if (!"1".equals(attclassgroupbo.getLinkClass())) {
								attclassbo = findAttClassBObyId(attclassgroupbo
										.getLinkClass());
								if (attclassbo != null) {
									return attclassbo;
								}
							} else {
								attclassbo = new AttClassBO();
								attclassbo.setClassID("1");
								attclassbo.setClassName("休息");
								attclassbo.setShortName("休息");
								return attclassbo;
							}
						}
					}
				}
			}
			/*
			 * 比较节假日
			 */
			String aDates = ss.substring(5, 10);

			List lists = getAllAttFeast(orguid);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttFeastBO attfeastbo = (AttFeastBO) lists.get(i);
					String[] args = attfeastbo.getFeastDate().split(",");
					for (int j = 0; j < args.length; j++) {
						if (ss.equals(args[j])) {
							attclassbo = new AttClassBO();
							attclassbo.setClassID("2");
							attclassbo.setClassName(attfeastbo.getFeastName());
							attclassbo.setShortName(attfeastbo.getFeastName());
							return attclassbo;
						} else if (aDates.equals(args[j])) {
							attclassbo = new AttClassBO();
							attclassbo.setClassID("2");
							attclassbo.setClassName(attfeastbo.getFeastName());
							attclassbo.setShortName(attfeastbo.getFeastName());
							return attclassbo;
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
							attclassbo = new AttClassBO();
							attclassbo.setClassID("2");
							attclassbo.setClassName(attfeastbo1.getFeastName());
							attclassbo.setShortName(attfeastbo1.getFeastName());
							return attclassbo;
						} else if (aDates.equals(argss[j])) {
							attclassbo = new AttClassBO();
							attclassbo.setClassID("2");
							attclassbo.setClassName(attfeastbo1.getFeastName());
							attclassbo.setShortName(attfeastbo1.getFeastName());
							return attclassbo;
						}
					}
				}
			}

			/*
			 * 比较公休日
			 */
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(getdate(ss));
			int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
			String attrestofweekboName = dayNames[dayOfWeek - 1];
			AttRestOfWeekBO attrestofweekbo = getAttRestOfWeekBOByOrgid(orguid);
			if (attrestofweekbo != null) {
				String namevalues = "公休日";
				if ("sun".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getSun())) {
						attclassbo = new AttClassBO();
						attclassbo.setClassID("3");
						attclassbo.setClassName(namevalues);
						attclassbo.setShortName(namevalues);
						return attclassbo;
					}
				}
				if ("mon".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getMon())) {
						attclassbo = new AttClassBO();
						attclassbo.setClassID("3");
						attclassbo.setClassName(namevalues);
						attclassbo.setShortName(namevalues);
						return attclassbo;
					}
				}
				if ("tues".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getTues())) {
						attclassbo = new AttClassBO();
						attclassbo.setClassID("3");
						attclassbo.setClassName(namevalues);
						attclassbo.setShortName(namevalues);
						return attclassbo;
					}
				}
				if ("wed".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getWed())) {
						attclassbo = new AttClassBO();
						attclassbo.setClassID("3");
						attclassbo.setClassName(namevalues);
						attclassbo.setShortName(namevalues);
						return attclassbo;
					}
				}
				if ("thur".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getThur())) {
						attclassbo = new AttClassBO();
						attclassbo.setClassID("3");
						attclassbo.setClassName(namevalues);
						attclassbo.setShortName(namevalues);
						return attclassbo;
					}
				}
				if ("fri".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getFri())) {
						attclassbo = new AttClassBO();
						attclassbo.setClassID("3");
						attclassbo.setClassName(namevalues);
						attclassbo.setShortName(namevalues);
						return attclassbo;
					}
				}
				if ("sat".equals(attrestofweekboName)) {
					if ("0".equals(attrestofweekbo.getSat())) {
						attclassbo = new AttClassBO();
						attclassbo.setClassID("3");
						attclassbo.setClassName(namevalues);
						attclassbo.setShortName(namevalues);
						return attclassbo;
					}
				}
			}

			/*
			 * 查询班次信息
			 */
			AttClassGroupBO attclassgroupbo = findAttClassGroupBObyId(groupID);
			attclassbo = findAttClassBObyId(attclassgroupbo.getLinkClass());
			attclassbo.setClassID(attclassbo.getClassID());
			attclassbo.setClassName(attclassbo.getClassName());
			attclassbo.setShortName(attclassbo.getShortName());
		} catch (Exception e) {
		}
		return attclassbo;
	}

	/*
	 * 过零点班计算方法
	 */
	public String kqglCale(String id, String day, String units, int unit,
			int unit1, int price1, String[] attclassdetailbos, AttClassBO b,
			String caclLaterName, String caclEarlyName) {
		try {
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				// 时段时间和刷卡时间做比较
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String beginTime1 = attclassdetailbos[p] + ":00";
					String endTime1 = attclassdetailbos[q - 1] + ":00";
					String[] beginTime1s = beginTime1.split(" ");
					String[] endTime1s = endTime1.split(" ");
					String beginDate1 = beginTime1s[0];
					String beginTime2 = beginTime1s[beginTime1s.length - 1];
					String endDate1 = endTime1s[0];
					String endTime2 = endTime1s[endTime1s.length - 1];
					String d1 = beginDate1 + " " + beginTime2;
					String d2 = endDate1 + " " + endTime2;
					String dayendtime = "23:59:59";
					String zero = "00:00:00";
					String d3 = endDate1 + " " + zero;
					Date dateBeginDate = df.parse(d1);
					Date dateEndDate = df.parse(d2);
					Date dateZeroDate = df.parse(d3);
					List list1 = null;
					if (((dateBeginDate.getTime() - dateZeroDate.getTime()) / (1000 * 60 * 60)) < 0) {
						if (((dateEndDate.getTime() - dateZeroDate.getTime()) / (1000 * 60 * 60)) < 0) {
							list1 = cardMessageDAO.getAttenceLogBOLogs(id,
									beginDate1, beginTime2, endTime2);
						} else {
							list1 = cardMessageDAO.getAttenceLogBOLogs(id,
									beginDate1, beginTime2, dayendtime);
							List list2 = cardMessageDAO.getAttenceLogBOLogs(id,
									endDate1, zero, endTime2);
							list1.addAll(list2);
						}

					} else {
						list1 = cardMessageDAO.getAttenceLogBOLogs(id,
								endDate1, beginTime2, endTime2);
					}

					if (list1 != null && list1.size() > 0) {
						AttenceLogBO attencelogbos1 = (AttenceLogBO) list1
								.get(0);
						AttenceLogBO attencelogbos2 = (AttenceLogBO) list1
								.get(list1.size() - 1);
						String beginDate2 = attencelogbos1.getCardDate();
						String beginTime3 = attencelogbos1.getCardTime();
						String endDate2 = attencelogbos2.getCardDate();
						String endTime3 = attencelogbos2.getCardTime();
						String beginCardTime = beginDate2 + " " + beginTime3;
						String endCardTime = endDate2 + " " + endTime3;
						Date dateCard1 = df.parse(beginCardTime); // 上限刷卡时刻
						Date dateCard2 = df.parse(endCardTime); // 下限刷卡时刻
						String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
						String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
						String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
						String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
						String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
						String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
						String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
						String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
						String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
						String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
						String attclassTime10 = attclassdetailbos[p + 10]
								+ ":00";// 下班时刻
						String attclassTime11 = attclassdetailbos[p + 11]
								+ ":00";// 下限刷卡结束时刻
						Date date0 = df.parse(attclassTime);
						Date date1 = df.parse(attclassTime1);
						Date date2 = df.parse(attclassTime2);
						Date date3 = df.parse(attclassTime3);
						Date date4 = df.parse(attclassTime4);
						Date date5 = df.parse(attclassTime5);
						Date date6 = df.parse(attclassTime6);
						Date date7 = df.parse(attclassTime7);
						Date date8 = df.parse(attclassTime8);
						Date date9 = df.parse(attclassTime9);
						Date date10 = df.parse(attclassTime10);
						Date date11 = df.parse(attclassTime11);
						float attenceRate = 0; // 日出勤率
						float realitytime = 0; // 实际出勤
						float shouldTime = 0; // 应出勤
						float amlatetime = 0; // 迟到时间
						float amawaytime = 0; // 旷工时间
						float pmearlyamawaytime = 0; // 早退旷工时间
						float pmearlytime = 0; // 早退时间

						String am_flagValues = "0"; // 考勤规则 上限刷卡
						String pm_flagValues = "0"; // 考勤规则 下限刷卡

						if (!"0".equals(caclLaterName)) {
							am_flagValues = "1";
							if (dateCard1.getTime() < date0.getTime()) {
								// 上限刷卡开始时刻之前，为无效刷卡
							} else if (dateCard1.getTime() > date2.getTime()
									&& dateCard1.getTime() <= date3.getTime()) {// 迟到时刻
								amlatetime += ((float) (dateCard1.getTime() - date2
										.getTime()) / (1000 * 60));
							} else if (dateCard1.getTime() > date3.getTime()
									&& dateCard1.getTime() <= date4.getTime()) {// 迟到旷工时刻
								amawaytime += (float) (dateCard1.getTime() - date3
										.getTime())
										/ (1000 * 60);
							} else if (dateCard1.getTime() > date4.getTime()
									&& dateCard1.getTime() < date6.getTime()) {
								// 休息时刻，为无效刷卡
							}
						}

						if (!"0".equals(caclEarlyName)) {
							am_flagValues = "1";
							if (dateCard2.getTime() < date7.getTime()) {
								// 上限刷卡开始时刻之前，为无效刷卡
							} else if (dateCard2.getTime() >= date7.getTime()
									&& dateCard2.getTime() <= date8.getTime()) {// 早退旷工时刻
								pmearlyamawaytime += ((float) (dateCard2
										.getTime() - date7.getTime()) / (1000 * 60));
							} else if (dateCard2.getTime() > date8.getTime()
									&& dateCard2.getTime() <= date9.getTime()) {// 早退时刻
								pmearlytime += (float) (dateCard2.getTime() - date8
										.getTime())
										/ (1000 * 60);
							} else if (dateCard2.getTime() > date10.getTime()) {
								// 下限刷卡结束时刻，为无效刷卡
							}
						}

						// 计算日分汇总出勤率
						if (!"0".equals(caclLaterName)
								|| !"0".equals(caclEarlyName)) {// 判断上下限规则是否为计算状态
							shouldTime = ((float) (date5.getTime() - date1
									.getTime())
									/ (unit) + (float) (date10.getTime() - date6
									.getTime())
									/ (unit));// 应出勤
							shouldTime = (float) (Math.round(shouldTime * 100)) / 100;
							amawaytime += amawaytime + amawaytime;// 旷工时间
							pmearlyamawaytime += pmearlyamawaytime
									+ pmearlyamawaytime;// 早退旷工时间
							pmearlytime += pmearlytime + pmearlytime;// 早退时间

							if (!"2".equals(units)) {
								realitytime = shouldTime
										- (amlatetime + amawaytime
												+ pmearlyamawaytime + pmearlytime)
										/ (unit1);
								realitytime = (float) (Math
										.round(realitytime * 1000)) / 1000;
							} else {
								realitytime = shouldTime
										- (amlatetime + amawaytime
												+ pmearlyamawaytime + pmearlytime);
								realitytime = (float) (Math
										.round(realitytime * 1000)) / 1000;
							}
							attenceRate = new BigDecimal(realitytime * 100)
									.divide(new BigDecimal(shouldTime), price1,
											BigDecimal.ROUND_HALF_UP)
									.floatValue();
							amlatetime = (float) (Math.round(amlatetime * 100)) / 100;
							amawaytime = (float) (Math.round(amawaytime * 100)) / 100;
							pmearlytime = (float) (Math
									.round(pmearlytime * 100)) / 100;
							pmearlyamawaytime = (float) (Math
									.round(pmearlyamawaytime * 100)) / 100;
							String A807701 = shouldTime + "";
							String A807702 = realitytime + "";
							String A807703 = attenceRate + "";
							String A807704 = amlatetime + "";
							String A807705 = pmearlytime + "";
							String A807706 = (amawaytime + pmearlyamawaytime)
									+ "";
							String A807001 = "" + (m + 1);
							AttenceSecondDayLogBO attenceseconddaylogbo = new AttenceSecondDayLogBO();
							attenceseconddaylogbo.setPersonId(id);
							attenceseconddaylogbo.setSubID(SequenceGenerator
									.getKeyId("A807"));
							attenceseconddaylogbo.setRecord(Constants.NO);
							attenceseconddaylogbo.setSecondDay(A807001);
							attenceseconddaylogbo.setAttenceDate(day);
							attenceseconddaylogbo.setRealityTime(A807702);
							attenceseconddaylogbo.setShouldTime(A807701);
							attenceseconddaylogbo.setAttenceRate(A807703);
							attenceseconddaylogbo.setLateTime(A807704);
							attenceseconddaylogbo.setEarlyTime(A807705);
							attenceseconddaylogbo.setAwayTime(A807706);
							saveAttenceSecondDayLogBO(attenceseconddaylogbo);
						} else {
							// 上下限规则为不计算状态
						}
					}
					m++;
				}
			}

			// 进行加班处理
			if (!"0".equals(b.getOverTimeFlag())) {
				String[] ymdhms = attclassdetailbos[attclassdetailbos.length - 1]
						.split(" ");
				String addWorkValues = ymdhms[0];
				String beginTimes1 = ymdhms[ymdhms.length - 1];
				String beginTimes2 = beginTimes1 + ":00";
				List list3 = cardMessageDAO.getAttenceLogBOLog2(id,
						addWorkValues, beginTimes2);
				if (list3 != null && list3.size() > 0) {
					AttenceLogBO attencelogbos3 = (AttenceLogBO) list3.get(0);
					AttenceLogBO attencelogbos4 = (AttenceLogBO) list3
							.get(list3.size() - 1);
					AttOverTimeLogBO attovertimelogbo = new AttOverTimeLogBO();
					attovertimelogbo.setPersonID(id);
					attovertimelogbo.setApplyDate(day);
					attovertimelogbo.setBeginTime(attencelogbos3.getCardTime());
					attovertimelogbo.setEndTime(attencelogbos4.getCardTime());
					attovertimelogbo.setProcess("0");
					deleteAttOverTimeLogBO(id, day);
					saveorupdateAttOverTimeLogBO(attovertimelogbo);
				}
			}
		} catch (Exception e) {

		}
		return "";
	}

	public List getAttCaclRuleBO(String orgID) throws SysException {
		return attenceSetDAO.getAttCaclRuleBO(orgID);
	}

	public String monthbeginShouldTime020(String personID) throws SysException {
		String sql = "select A020700  from A020 where id='" + personID + "'";
		return activeapi.queryForString(sql);
	}

	/*
	 * 查询月汇总中的当前记录值
	 */
	public List getAttenceDayMonthBO(String personId) throws SysException {
		return cardMessageDAO.getAttenceDayMonthBO(personId);
	}

	/*
	 * 把月汇总中历史的当前记录值，置为00900
	 */
	public void recordValues(String personId) {
		try {

			List lists = getAttenceDayMonthBO(personId);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttenceDayMonthBO attencedaymonthbo = (AttenceDayMonthBO) lists
							.get(i);
					saveorupdateAttenceDayMonthBO(personId, attencedaymonthbo
							.getAttenceDate());
				}
			}
		} catch (Exception e) {

		}
	}

	public void saveorupdateAttenceDayMonthBO(String id, String month)
			throws SysException {
		String sql = "update a810 set ";
		sql += " A810000='00900' ";
		sql += " where ID='" + id + "' and A810700='" + month
				+ "' and  A810000='00901'";
		activeapi.executeSql(sql);
	}

	/*
	 * 把年汇总中历史的当前记录值，置为00900
	 */
	public void recordValues1(String personId) {
		try {

			List lists = getAttenceDayMonthBO(personId);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttenceDayMonthBO attencedaymonthbo = (AttenceDayMonthBO) lists
							.get(i);
					saveorupdateAttYearCollectBO(personId);
				}
			}
		} catch (Exception e) {

		}
	}

	public void saveorupdateAttYearCollectBO(String id) throws SysException {
		String sql = "update a811 set ";
		sql += " A811000='00900' ";
		sql += " where ID='" + id + "' and  A811000='00901'";
		activeapi.executeSql(sql);
	}

	public void deleteAttenceSecondDayLogBO(String id, String day)
			throws SysException {
		String sql = "delete from a807 where ID='" + id + "' and A807700='"
				+ day + "'";
		activeapi.executeSql(sql);
	}

	// 删除日分汇总某一天的数据值，条件是年假字段值为空
	public void deleteAttenceSecondDayLogBONotleaveYear(String id, String day)
			throws SysException {
		String sql = "delete from a807 where ID='" + id + "' and A807700='"
				+ day + "' and  (A807712 is null or A807712='')";
		activeapi.executeSql(sql);
	}

	public void deleteAttenceDayLogBO(String id, String day)
			throws SysException {
		String sql = "delete from a809 where ID='" + id + "' and A809700='"
				+ day + "'";
		activeapi.executeSql(sql);
	}

	public void deleteAttenceDayLogBO1(String day) throws SysException {
		String sql = "delete from a809 where A809700='" + day + "'";
		activeapi.executeSql(sql);
	}

	public void deleteAttenceDayMonthBO(String id, String day)
			throws SysException {
		String sql = "delete from a810 where ID='" + id + "' and A810700='"
				+ day + "'";
		activeapi.executeSql(sql);
	}

	public void deleteAttYearCollectBO(String id, String year)
			throws SysException {
		String sql = "delete from a811 where ID='" + id + "' and A811700='"
				+ year + "'";
		activeapi.executeSql(sql);
	}

	public void deleteAttenceDayMonthBO1(String day) throws SysException {
		String sql = "delete from a810 where A810700='" + day + "'";
		activeapi.executeSql(sql);
	}

	public void deleteAttYearCollectBO(String year) throws SysException {
		String sql = "delete from a811 where A811700='" + year + "'";
		activeapi.executeSql(sql);
	}

	public List findAttenceSecondDayLogBO(String id, String day,
			String secondDay) throws SysException {
		return cardMessageDAO.findAttenceSecondDayLogBO(id, day, secondDay);
	}

	public void updateAttenceSecondDayLogBO(String id, String day,
			String A807702, String secondDay, String flname, String flvalue)
			throws SysException {
		String updateSQL = "update A807 set " + flname + "='" + flvalue
				+ "',A807702='" + A807702 + "' where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		activeapi.executeSql(updateSQL);
	}

	public void updateAttenceSecondDayLogBO(String id, String day,
			String A807701, String A807702, String secondDay, String flname,
			String flvalue) throws SysException {
		String updateSQL = "update A807 set " + flname + "='" + flvalue
				+ "',A807701='" + A807701 + "',A807702='" + A807702
				+ "' where id='" + id + "' and A807700='" + day
				+ "' and  A807001 like '" + secondDay + "'";
		activeapi.executeSql(updateSQL);
	}

	public String selectFlname(String flname, String id, String day,
			String secondDay) throws SysException {
		String sql = "select " + flname + " from  A807  where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		return activeapi.queryForString(sql);
	}

	public String selectRealTimes(String id, String day, String secondDay)
			throws SysException {
		String sql = "select A807702 from  A807  where id='" + id
				+ "' and A807700='" + day + "' and  A807001 like '" + secondDay
				+ "'";
		return activeapi.queryForString(sql);
	}

	// 浏览加班
	public void saveorupdateAttOverTimeLogBO(AttOverTimeLogBO bo)
			throws SysException {
		cardMessageDAO.saveOrUpdateBo(bo);
	}

	public void deleteAttOverTimeLogBO(String id, String day)
			throws SysException {
		String sql = "delete from ATT_OVERTIME_LOG where PERSON_ID='" + id
				+ "' and APPLY_DATE='" + day + "'";
		activeapi.executeSql(sql);
	}

	public List getAttOverTimeRecBO(String id, String day) throws SysException {
		return cardMessageDAO.getAttOverTimeRecBO(id, day);
	}

	public String calcAttAttOverTimeRecBO(String id, String day)
			throws SysException {
		String days = day.substring(0, 7);
		String days1 = day.substring(8, 10);
		int dayint = Integer.parseInt(days1);
		List lists = getAttOverTimeRecBO(id, days);
		if (lists != null && lists.size() > 0) {
			for (int i = 0; i < lists.size(); i++) {
				AttOverTimeRecBO attovertimerecbo = (AttOverTimeRecBO) lists
						.get(i);
				String[] begintimes = attovertimerecbo.getBeginTime()
						.split(" ");
				String[] endtimes = attovertimerecbo.getEndTime().split(" ");
				String begintimes1 = begintimes[0].substring(8, 10);
				String endtimes1 = endtimes[0].substring(8, 10);
				int bint = Integer.parseInt(begintimes1);
				int eint = Integer.parseInt(endtimes1);
				if (dayint == bint) {
					String beginTimes2 = begintimes[begintimes.length - 1]
							+ ":00";
					List list3 = cardMessageDAO.getAttenceLogBOLog2(id, day,
							beginTimes2);
					if (list3 != null && list3.size() > 0) {
						AttenceLogBO attencelogbos3 = (AttenceLogBO) list3
								.get(0);
						AttenceLogBO attencelogbos4 = (AttenceLogBO) list3
								.get(list3.size() - 1);
						AttOverTimeLogBO attovertimelogbo = new AttOverTimeLogBO();
						attovertimelogbo.setPersonID(id);
						attovertimelogbo.setApplyDate(day);
						attovertimelogbo.setBeginTime(attencelogbos3
								.getCardTime());
						attovertimelogbo.setEndTime(attencelogbos4
								.getCardTime());
						attovertimelogbo.setProcess("0");
						deleteAttOverTimeLogBO(id, day);
						saveorupdateAttOverTimeLogBO(attovertimelogbo);
					}
					return "";
				}
				if (dayint == eint) {
					String endtimes2 = endtimes[endtimes.length - 1] + ":00";
					List list3 = cardMessageDAO.getAttenceLogBOLog3(id, day,
							endtimes2);
					if (list3 != null && list3.size() > 0) {
						AttenceLogBO attencelogbos3 = (AttenceLogBO) list3
								.get(0);
						AttenceLogBO attencelogbos4 = (AttenceLogBO) list3
								.get(list3.size() - 1);
						AttOverTimeLogBO attovertimelogbo = new AttOverTimeLogBO();
						attovertimelogbo.setPersonID(id);
						attovertimelogbo.setApplyDate(day);
						attovertimelogbo.setBeginTime(attencelogbos3
								.getCardTime());
						attovertimelogbo.setEndTime(attencelogbos4
								.getCardTime());
						attovertimelogbo.setProcess("0");
						deleteAttOverTimeLogBO(id, day);
						saveorupdateAttOverTimeLogBO(attovertimelogbo);
					}
					return "";
				}

				if (dayint >= bint && dayint <= eint) {
					List list3 = cardMessageDAO.getAttenceLogBO(id, day);
					if (list3 != null && list3.size() > 0) {
						AttenceLogBO attencelogbos3 = (AttenceLogBO) list3
								.get(0);
						AttenceLogBO attencelogbos4 = (AttenceLogBO) list3
								.get(list3.size() - 1);
						AttOverTimeLogBO attovertimelogbo = new AttOverTimeLogBO();
						attovertimelogbo.setPersonID(id);
						attovertimelogbo.setApplyDate(day);
						attovertimelogbo.setBeginTime(attencelogbos3
								.getCardTime());
						attovertimelogbo.setEndTime(attencelogbos4
								.getCardTime());
						attovertimelogbo.setProcess("0");
						deleteAttOverTimeLogBO(id, day);
						saveorupdateAttOverTimeLogBO(attovertimelogbo);
					}
					return "";
				}

			}
		}
		return "";
	}

	/*
	 * 网上申请天数的自动计算
	 */
	public String cacldays(String id, String day, AttClassBO b)
			throws Exception {
		String flvalue = "";
		float flvalues = 0;
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					if (dates.getTime() < date1.getTime()) {
						flvalues += ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues += ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues += ((float) (date5.getTime() - dates.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues += ((float) (date10.getTime() - date6
								.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues += ((float) (date10.getTime() - dates
								.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues += ((float) (date10.getTime() - dates
								.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date9.getTime()) {
						flvalues += ((float) (date10.getTime() - dates
								.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date9.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues += ((float) (date10.getTime() - dates
								.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues += 0;
					}
					m++;
				}
			}
		}
		flvalue = flvalues + "";
		return flvalue;
	}

	public String cacldays1(String id, String day, AttClassBO b)
			throws Exception {
		String flvalue = "";
		float flvalues = 0;
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		Date dates = df.parse(day + ":00");
		List bs = attenceSetDAO.getAllAttClassDetailBO1(b.getClassID());
		if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
			// 时段时间数组
			String[] attclassdetailbos = new String[bs.size()];
			// 为时段时间数组赋值
			for (int j = 0; j < bs.size(); j++) {
				AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
						.get(j);
				attclassdetailbos[j] = attclassdetailbo.getItemTime();
			}
			int nss = attclassdetailbos.length;
			int n = nss / 12;
			if (n > 0) {
				int m = 0;
				while (m < n) {
					int p = 12 * m;
					int q = 12 * m + 12;
					String attclassTime = attclassdetailbos[p] + ":00";// 上限刷卡开始时刻
					String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
					String attclassTime2 = attclassdetailbos[p + 2] + ":00";// 迟到时刻
					String attclassTime3 = attclassdetailbos[p + 3] + ":00";// 迟到旷工时刻
					String attclassTime4 = attclassdetailbos[p + 4] + ":00";// 上限刷卡结束时刻
					String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
					String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
					String attclassTime7 = attclassdetailbos[p + 7] + ":00";// 下限刷卡开始时刻
					String attclassTime8 = attclassdetailbos[p + 8] + ":00";// 早退旷工时刻
					String attclassTime9 = attclassdetailbos[p + 9] + ":00";// 早退时刻
					String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
					String attclassTime11 = attclassdetailbos[p + 11] + ":00";// 下限刷卡结束时刻
					Date date0 = df.parse(attclassTime);
					Date date1 = df.parse(attclassTime1);
					Date date2 = df.parse(attclassTime2);
					Date date3 = df.parse(attclassTime3);
					Date date4 = df.parse(attclassTime4);
					Date date5 = df.parse(attclassTime5);
					Date date6 = df.parse(attclassTime6);
					Date date7 = df.parse(attclassTime7);
					Date date8 = df.parse(attclassTime8);
					Date date9 = df.parse(attclassTime9);
					Date date10 = df.parse(attclassTime10);
					Date date11 = df.parse(attclassTime11);
					if (dates.getTime() < date1.getTime()) {
						flvalues += 0;
					} else if (dates.getTime() >= date1.getTime()
							&& dates.getTime() <= date3.getTime()) {
						flvalues += ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date3.getTime()
							&& dates.getTime() <= date4.getTime()) {
						flvalues += ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date4.getTime()
							&& dates.getTime() < date6.getTime()) {
						flvalues += ((float) (date5.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date6.getTime()
							&& dates.getTime() < date7.getTime()) {
						flvalues += ((float) (dates.getTime() - date1.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date7.getTime()
							&& dates.getTime() <= date8.getTime()) {
						flvalues += ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() > date8.getTime()
							&& dates.getTime() < date10.getTime()) {
						flvalues += ((float) (date5.getTime() - date1.getTime()) + (float) (dates
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					} else if (dates.getTime() >= date10.getTime()) {
						flvalues += ((float) (date5.getTime() - date1.getTime()) + (float) (date10
								.getTime() - date6.getTime()))
								/ (1000 * 60 * 60 * 8);
					}
					m++;
				}
			}
		}
		flvalue = flvalues + "";
		return flvalue;
	}

	/**
	 * 本方法是计算出机构中符合人员的班次信息 如：personClass.put(人员ID,班次信息);
	 * 
	 * @param orgId
	 *            机构ID
	 * @param daylists
	 *            考勤区间天数集合 如：daylists.get(0)=2010-12-01
	 *            daylists.get(1)=2010-12-02 ...
	 *            daylists.get(daylists.size())=2010-12-31
	 * @param flagcharlists
	 *            考勤项目规则集合（包括汇总单位，汇总字段）
	 * @param yearValueCale
	 *            计算的年度 如：2010
	 * @param monthValueCale
	 *            计算的月度 如：12
	 * @param beginTime
	 *            计算的开始日期 如：2010-12-01
	 * @param endTime
	 *            计算的结束日期 如：2010-12-31
	 * @param isMon
	 *            是否进行月汇总标示 isMon=true 是 isMon=false 否
	 * @return
	 * @throws Exception
	 */
	public String calcpersongroup(String orgId, List daylists,
			List flagcharlists, String yearValueCale, String monthValueCale,
			String beginTime, String endTime, boolean isMon, boolean isExist,
			String perIdsValue) throws Exception {
        long begin=System.currentTimeMillis();
		HashMap personClass = new HashMap(); // 人员ID 班次BO的对照表
		HashMap groupClass = new HashMap(); // 班组 班次BO的对照表
		String sql = "";
		if ("ORACLE".equals(Constants.DB_TYPE)) {
			sql = "select id,A001737 from a001 where a001701='" + orgId
					+ "' and (a001737 is not null or a001737<>'')";
			if (perIdsValue != null && !"".equals(perIdsValue)) {
				sql += " and id='" + perIdsValue.trim() + "'";
			}
		} else {
			sql = "select id,A001737 from a001 where a001701='" + orgId
					+ "' and a001737 is not null and  a001737<>''";
			if (perIdsValue != null && !"".equals(perIdsValue)) {
				sql += " and id='" + perIdsValue.trim() + "'";
			}
		}
		CellVO[] head = new CellVO[2];
		head[0] = new CellVO();
		head[0].setItemId("id");
		head[1] = new CellVO();
		head[1].setItemId("A001737");
		Vector rs = activeapi.getDataListBySql(head, sql); // api 是ActivePageAPI

        long end1=System.currentTimeMillis();
        System.out.println("查询人员耗时:"+(begin-end1)/1000);

		Hashtable grouphash = new Hashtable();// 班组hash
		List list = this.groupMgrDAO.getAllAttClassGroupBO();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				AttClassGroupBO bo = (AttClassGroupBO) list.get(i);
				grouphash.put(bo.getGroupNo(), bo);
			}
		}

         long end2=System.currentTimeMillis();
        System.out.println("查询班组耗时:"+(end2-end1)/1000);

		Hashtable classHash = new Hashtable();
		Hashtable classDeailHash=new Hashtable(); 
		List classlist = this.groupMgrDAO.getAllAttClassBOType(orgId);
		if (classlist != null && classlist.size() > 0) {
			for (int i = 0; i < classlist.size(); i++) {
				AttClassBO bo = (AttClassBO) classlist.get(i);
				classHash.put(bo.getClassID(), bo);
				List dlist=attenceSetDAO.getAllAttClassDetailBO1(bo.getClassID());
				if(dlist!=null&&dlist.size()>0){
					classDeailHash.put(bo.getClassID(), dlist);
				}
			}
		}

        long end3=System.currentTimeMillis();
        System.out.println("查询班次信息耗时:"+(end3-end2)/1000);

		List attworkdatelists = attfeastDAO.getAllAttWorkDate(orgId);
		List feastList = this.getAllEqualsAttFeast(orgId);
		AttRestOfWeekBO attrestofweekbo = this.getAttRestOfWeekBOByOrgid(orgId);
		
		String month=yearValueCale+"-"+monthValueCale;
		Hashtable attChangeWorkBOHash=cardMessageDAO.findALLMonthAttChangeWorkBO(month);

        long end4=System.currentTimeMillis();
        System.out.println("查询机构假期公出等耗时:"+(end4-end3)/1000);

		for (int i = 0; i < rs.size(); i++) {
			CellVO[] row = (CellVO[]) rs.get(i);
			String id = row[0].getValue(); // 人员ID
			String group = row[1].getValue();// 班组
			if (daylists != null && daylists.size() > 0) {
				AttClassGroupBO attclassgroupbo = (AttClassGroupBO) grouphash
						.get(group);
				for (int j = 0; j < daylists.size(); j++) {
					String day = (String) daylists.get(j);
					AttClassBO b = null;
					// 根据班组group和day，查询函数getPeriodInfo得到班次b，并put入groupClass
					// 新增函数 public班次BO getPeriodInfo(String groupID,String
					// aDate)
					/*
					 * 某天的班次分为正常班组和倒班班组
					 */
                    if(attclassgroupbo!=null){
                        if (attclassgroupbo.getLinkClass() != null
                                && !"".equals(attclassgroupbo.getLinkClass())) {
                            b = getPeriodInfo(orgId, group, day, attworkdatelists,
                                    feastList, attrestofweekbo, grouphash,
                                    classHash);
                            if ("3".equals(attclassgroupbo.getGroupType())) {
                                // 免考勤班计算
                                if (b != null) {
                                    deleteAttenceSecondDayLogBO(id, day);
                                    caledayleaderdata(id, day, b,(List)classDeailHash.get(b.getClassID()));
                                    calcAttOutWorkRecBO(id, day, b,(List)classDeailHash.get(b.getClassID()));
                                    calcAttEvcctionRecBO(id, day, b,(List)classDeailHash.get(b.getClassID()));
                                    calcAttFurloughRec(id, day, b,(List)classDeailHash.get(b.getClassID()));
                                    continue;
                                }
                            } else {
                                groupClass.put(day, b);
                            }
                        } else {
                            if ("4".equals(attclassgroupbo.getGroupType())) {
                                b = getPeriodInfo2(id, day,classHash);
                                groupClass.put(day, b);
                            } else {
                                b = getPeriodInfo(group, day,classHash);
                                groupClass.put(day, b);
                            }
                        }
                    }

					AttChangeWorkBO attchangeworkbo=(AttChangeWorkBO)attChangeWorkBOHash.get(id+day);
					if (attchangeworkbo != null) {
						if (!"1".equals(attchangeworkbo.getNewClass())) {
							AttClassBO attclassbo =(AttClassBO) classHash.get(attchangeworkbo
									.getNewClass());
							groupClass.put(day, attclassbo);
						} else {
							AttClassBO attclassbo = null;
							groupClass.put(day, attclassbo);
						}
					}
				}
				personClass.put(id, groupClass);
				groupClass = new HashMap();
			}
		}
        long end5=System.currentTimeMillis();
        System.out.println("业务操作耗时:"+(end5-end4)/1000);
		String caclLaterName = "1"; // 上限刷卡规则
		String caclEarlyName = "1"; // 下限刷卡规则
		List lists = getAttCaclRuleBO(orgId);
		if (lists != null && lists.size() > 0) {
			AttCaclRuleBO attcaclrulebo = (AttCaclRuleBO) lists.get(0);
			caclLaterName = attcaclrulebo.getCaclLater();
			caclEarlyName = attcaclrulebo.getCaclEarly();
		}

		caledaydata(personClass, caclLaterName, caclEarlyName, flagcharlists,
				orgId, yearValueCale, monthValueCale, beginTime, endTime,
				isMon, isExist,classHash,classDeailHash);
        long end6=System.currentTimeMillis();
        System.out.println("计算耗时:"+(end6-end5)/1000);
		return "";
	}

	/**
	 * 本方法应用于免考勤班组
	 * 
	 * @param id
	 * @param day
	 * @param attclassbo
	 * @return
	 * @throws Exception
	 */
	public String caledayleaderdata(String id, String day, AttClassBO attclassbo,List bs)
			throws Exception {
		String[] attclassdetailbos = new String[bs.size()];
		for (int j = 0; j < bs.size(); j++) {
			AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs.get(j);
			attclassdetailbos[j] = attclassdetailbo.getItemTime();
		}
		int nss = attclassdetailbos.length;
		int n = nss / 12;
		if (n > 0) {
			int m = 0;
			while (m < n) {
				int p = 12 * m;
				String attclassTime1 = attclassdetailbos[p + 1] + ":00";// 上班时刻
				String attclassTime5 = attclassdetailbos[p + 5] + ":00";// 休息开始
				String attclassTime6 = attclassdetailbos[p + 6] + ":00";// 休息结束
				String attclassTime10 = attclassdetailbos[p + 10] + ":00";// 下班时刻
				DateFormat dfs = new SimpleDateFormat("HH:mm:ss");
				Date dates1 = dfs.parse(attclassTime1);
				Date dates5 = dfs.parse(attclassTime5);
				Date dates6 = dfs.parse(attclassTime6);
				Date dates10 = dfs.parse(attclassTime10);
				float shouldTime = ((float) (dates5.getTime() - dates1
						.getTime())
						/ (1000 * 60 * 60 * 8) + (float) (dates10.getTime() - dates6
						.getTime())
						/ (1000 * 60 * 60 * 8));// 应出勤
				shouldTime = (float) (Math.round(shouldTime * 100)) / 100;
				String A807701 = shouldTime + "";
				String A807001 = "" + (m + 1);
				String A807702 = shouldTime + "";
				String A807703 = "0";
				AttenceSecondDayLogBO attenceseconddaylogbo = new AttenceSecondDayLogBO();
				attenceseconddaylogbo.setPersonId(id);
				attenceseconddaylogbo.setSubID(SequenceGenerator
						.getKeyId("A807"));
				attenceseconddaylogbo.setRecord(Constants.NO);
				attenceseconddaylogbo.setSecondDay(A807001);
				attenceseconddaylogbo.setAttenceDate(day);
				attenceseconddaylogbo.setRealityTime(A807702);
				attenceseconddaylogbo.setShouldTime(A807701);
				attenceseconddaylogbo.setAttenceRate(A807703);
				saveAttenceSecondDayLogBO(attenceseconddaylogbo);
				m++;
			}
		}
		return "";
	}

	/**
	 * 进行日分汇总操作
	 * 
	 * @param personClass
	 * @param caclLaterName
	 *            上限刷卡规则 0 不计算 1 计算
	 * @param caclEarlyName
	 *            下限刷卡规则 0 不计算 1 计算
	 * @param flagcharlists
	 * @param orgId
	 * @param yearValueCale
	 * @param monthValueCale
	 * @param calebeginTime
	 * @param caleendTime
	 * @param isMon
	 * @return
	 * @throws Exception
	 */
	public String caledaydata(HashMap personClass, String caclLaterName,
			String caclEarlyName, List flagcharlists, String orgId,
			String yearValueCale, String monthValueCale, String calebeginTime,
			String caleendTime, boolean isMon, boolean isExist,Hashtable classHash,Hashtable classDeailHash)
			throws Exception {
		/*
		 * 计算单位可扩展接口 1.units="0" 则：计算单位按"天"计算 2.units="1" 则：计算单位按"小时"计算
		 * 3.units="2" 则：计算单位按"分钟"计算
		 */
		String units = "0";
		int unit = 0; // 毫秒转化为天
		int unit1 = 0; // 分钟转化为天
		if ("0".equals(units)) {
			unit = 1000 * 60 * 60 * 8;
			unit1 = 60 * 8;
		} else if ("1".equals(units)) {
			unit = 1000 * 60 * 60;
			unit1 = 60;
		} else if ("2".equals(units)) {
			unit = 1000 * 60;
		}
		/*
		 * 精度可扩展接口
		 */
		String price = "2";
		int price1 = Integer.parseInt(price);

		Iterator it = personClass.keySet().iterator();
        long begintime=System.currentTimeMillis();
		while (it.hasNext()) {
			String id = (String) it.next();
			HashMap hashmap = (HashMap) personClass.get(id);
			Iterator its = hashmap.keySet().iterator();
			while (its.hasNext()) {
				String day = (String) its.next();
				AttClassBO b = (AttClassBO) hashmap.get(day);
				deleteAttenceSecondDayLogBO(id, day);
				if (b != null) {

					calcAttOutWorkRecBO(id, day, b,(List)classDeailHash.get(b.getClassID()));

					calcAttEvcctionRecBO(id, day, b,(List)classDeailHash.get(b.getClassID()));
					calcAttFurloughRec(id, day, b,(List)classDeailHash.get(b.getClassID()));
					calcNetWorkHoliday(id, day, b,(List)classDeailHash.get(b.getClassID()));
					calcAttTimeOffRecBO(id, day, b,(List)classDeailHash.get(b.getClassID()));
					calcAttOverTimeLogBO(id, day);
					if ("1".equals(b.getDaySpan())) {// 判断班次是否为零点班次

						List bs = (List)classDeailHash.get(b.getClassID());
						if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
							// 时段时间数组
							String[] attclassdetailbos = new String[bs.size()];
							// 为时段时间数组赋值
							for (int j = 0; j < bs.size(); j++) {
								AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
										.get(j);
								attclassdetailbos[j] = attclassdetailbo
										.getItemTime();
							}
							int nss = attclassdetailbos.length;
							int n = nss / 12;
							if (n > 0) {
								// 时段时间和刷卡时间做比较
								int m = 0;
								while (m < n) {
									int p = 12 * m;
									int q = 12 * m + 12;
									DateFormat df = new SimpleDateFormat(
											"HH:mm:ss");
									String beginTimes = attclassdetailbos[p]
											+ ":00";
									String endTimes = attclassdetailbos[q - 1]
											+ ":00";
									List list1 = cardMessageDAO
											.getAttenceLogBOLogs(id, day,
													beginTimes, endTimes);
									if (list1 != null && list1.size() > 0) {
										AttenceLogBO attencelogbos1 = (AttenceLogBO) list1
												.get(0);
										AttenceLogBO attencelogbos2 = (AttenceLogBO) list1
												.get(list1.size() - 1);
										String beginTime = attencelogbos1
												.getCardTime();
										String endTime = attencelogbos2
												.getCardTime();
										Date dateCard1 = df.parse(beginTime); // 上限刷卡时间
										Date dateCard2 = df.parse(endTime); // 下限刷卡时间
										String attclassTime = attclassdetailbos[p]
												+ ":00";// 上限刷卡开始时刻
										String attclassTime1 = attclassdetailbos[p + 1]
												+ ":00";// 上班时刻
										String attclassTime2 = attclassdetailbos[p + 2]
												+ ":00";// 迟到时刻
										String attclassTime3 = attclassdetailbos[p + 3]
												+ ":00";// 迟到旷工时刻
										String attclassTime4 = attclassdetailbos[p + 4]
												+ ":00";// 上限刷卡结束时刻
										String attclassTime5 = attclassdetailbos[p + 5]
												+ ":00";// 休息开始
										String attclassTime6 = attclassdetailbos[p + 6]
												+ ":00";// 休息结束
										String attclassTime7 = attclassdetailbos[p + 7]
												+ ":00";// 下限刷卡开始时刻
										String attclassTime8 = attclassdetailbos[p + 8]
												+ ":00";// 早退旷工时刻
										String attclassTime9 = attclassdetailbos[p + 9]
												+ ":00";// 早退时刻
										String attclassTime10 = attclassdetailbos[p + 10]
												+ ":00";// 下班时刻
										String attclassTime11 = attclassdetailbos[p + 11]
												+ ":00";// 下限刷卡结束时刻
										Date date0 = df.parse(attclassTime);
										Date date1 = df.parse(attclassTime1);
										Date date2 = df.parse(attclassTime2);
										Date date3 = df.parse(attclassTime3);
										Date date4 = df.parse(attclassTime4);
										Date date5 = df.parse(attclassTime5);
										Date date6 = df.parse(attclassTime6);
										Date date7 = df.parse(attclassTime7);
										Date date8 = df.parse(attclassTime8);
										Date date9 = df.parse(attclassTime9);
										Date date10 = df.parse(attclassTime10);
										Date date11 = df.parse(attclassTime11);
										float attenceRate = 0; // 日出勤率
										float realitytime = 0; // 实际出勤
										float shouldTime = 0; // 应出勤
										float amlatetime = 0; // 迟到时间
										float amawaytime = 0; // 旷工时间
										float pmearlyamawaytime = 0; // 早退旷工时间
										float pmearlytime = 0; // 早退时间

										String am_flagValues = "0"; // 考勤规则 上限刷卡
										String pm_flagValues = "0"; // 考勤规则 下限刷卡

										boolean amBoolean = false;
										boolean amBoolean1 = false;
										if (!"0".equals(caclLaterName)) {
											am_flagValues = "1";
											if (dateCard1.getTime() < date0
													.getTime()) {
												// 上限刷卡开始时刻之前，为无效刷卡
												amawaytime += ((float) (date5
														.getTime() - date1
														.getTime()) / (1000 * 60));
												amBoolean = true;
												amBoolean1 = true;
											} else if (dateCard1.getTime() >= date0
													.getTime()
													&& dateCard1.getTime() <= date2
															.getTime()) {// 正点上班
												amBoolean = true;
											} else if (dateCard1.getTime() > date2
													.getTime()
													&& dateCard1.getTime() <= date3
															.getTime()) {// 迟到时刻
												amlatetime += ((float) (dateCard1
														.getTime() - date1
														.getTime()) / (1000 * 60));
												amBoolean = true;
											} else if (dateCard1.getTime() > date3
													.getTime()
													&& dateCard1.getTime() <= date4
															.getTime()) {// 迟到旷工时刻
												amawaytime += (float) (dateCard1
														.getTime() - date1
														.getTime())
														/ (1000 * 60);
												amBoolean = true;
											} else if (dateCard1.getTime() > date4
													.getTime()
													&& dateCard1.getTime() <= date6
															.getTime()) {
												// 休息时刻，为无效刷卡
												amawaytime += ((float) (date5
														.getTime() - date1
														.getTime()) / (1000 * 60));
												amBoolean = true;
												amBoolean1 = true;
											}
										}

										boolean pmBoolean = false;
										boolean pmBoolean1 = false;
										if (isExist) {
											// pmearlyamawaytime=0;
											pmBoolean = true;
										} else {
											if (!"0".equals(caclEarlyName)) {
												am_flagValues = "1";
												if (dateCard2.getTime() >= date6
														.getTime()
														&& dateCard2.getTime() < date7
																.getTime()) {
													// 上限刷卡开始时刻之前，为无效刷卡
													pmearlyamawaytime += ((float) (date10
															.getTime() - date6
															.getTime()) / (1000 * 60));
													pmBoolean = true;
													pmBoolean1 = true;
												} else if (dateCard2.getTime() >= date7
														.getTime()
														&& dateCard2.getTime() < date8
																.getTime()) {// 早退旷工时刻
													pmearlyamawaytime += ((float) (date10
															.getTime() - dateCard2
															.getTime()) / (1000 * 60));
													pmBoolean = true;
												} else if (dateCard2.getTime() >= date8
														.getTime()
														&& dateCard2.getTime() < date9
																.getTime()) {// 早退时刻
													pmearlytime += (float) (date10
															.getTime() - dateCard2
															.getTime())
															/ (1000 * 60);
													pmBoolean = true;
												} else if (dateCard2.getTime() >= date9
														.getTime()
														&& dateCard2.getTime() <= date11
																.getTime()) {// 正点下班
													pmBoolean = true;
												} else if (dateCard2.getTime() > date11
														.getTime()) {
													// 下限刷卡结束时刻，为无效刷卡
													pmearlyamawaytime += ((float) (date10
															.getTime() - date6
															.getTime()) / (1000 * 60));
													pmBoolean = true;
													pmBoolean1 = true;
												}
											}
										}

										// 计算日分汇总出勤率
										if (!"0".equals(caclLaterName)
												|| !"0".equals(caclEarlyName)) {// 判断上下限规则是否为计算状态
											shouldTime = ((float) (date5
													.getTime() - date1
													.getTime())
													/ (unit) + (float) (date10
													.getTime() - date6
													.getTime())
													/ (unit));// 应出勤
											shouldTime = (float) (Math
													.round(shouldTime * 100)) / 100;

											if ("1".equals(caclLaterName)
													&& "0"
															.equals(caclEarlyName)) {
												if (!amBoolean) {
													amawaytime += ((float) (date5
															.getTime() - date1
															.getTime())
															/ (1000 * 60) + (float) (date10
															.getTime() - date6
															.getTime())
															/ (1000 * 60));
												}
												if (amBoolean1) {
													pmearlyamawaytime += ((float) (date10
															.getTime() - date6
															.getTime()) / (1000 * 60));
												}
											} else if ("0"
													.equals(caclLaterName)
													&& "1"
															.equals(caclEarlyName)) {
												if (!pmBoolean) {
													pmearlyamawaytime += ((float) (date5
															.getTime() - date1
															.getTime())
															/ (1000 * 60) + (float) (date10
															.getTime() - date6
															.getTime())
															/ (1000 * 60));
												}
												if (pmBoolean1) {
													amawaytime += ((float) (date5
															.getTime() - date1
															.getTime()) / (1000 * 60));
												}
											} else if ("1"
													.equals(caclLaterName)
													&& "1"
															.equals(caclEarlyName)) {
												if (!amBoolean) {
													amawaytime += ((float) (date5
															.getTime() - date1
															.getTime()) / (1000 * 60));
												}
												if (!pmBoolean) {
													pmearlyamawaytime += ((float) (date10
															.getTime() - date6
															.getTime()) / (1000 * 60));
												}
											}
											amlatetime = (float) (Math
													.round(amlatetime * 100)) / 100;
											amawaytime = (float) (Math
													.round(amawaytime * 100)) / 100;
											pmearlytime = (float) (Math
													.round(pmearlytime * 100)) / 100;
											pmearlyamawaytime = (float) (Math
													.round(pmearlyamawaytime * 100)) / 100;
											String A807001 = "" + (m + 1);
											String selecta807701value = selectA807701(
													"A807701", id, day, A807001);
											if (selecta807701value != null
													&& !""
															.equals(selecta807701value)) {
												String selecta807707value = selectA807701(
														"A807707", id, day,
														A807001); // 事假
												String selecta807708value = selectA807701(
														"A807708", id, day,
														A807001); // 病假
												String selecta807709value = selectA807701(
														"A807709", id, day,
														A807001);// 产假
												String selecta807710value = selectA807701(
														"A807710", id, day,
														A807001);// 婚假
												String selecta807711value = selectA807701(
														"A807711", id, day,
														A807001);// 探亲假
												String selecta807712value = selectA807701(
														"A807712", id, day,
														A807001);// 年假
												String selecta807713value = selectA807701(
														"A807713", id, day,
														A807001);// 工伤假
												String selecta807714value = selectA807701(
														"A807714", id, day,
														A807001);// 丧假
												String selecta807715value = selectA807701(
														"A807715", id, day,
														A807001);// 出差
												String selecta807716value = selectA807701(
														"A807716", id, day,
														A807001);// 公出
												String selecta807717value = selectA807701(
														"A807717", id, day,
														A807001);// 公假
												String selecta807718value = selectA807701(
														"A807718", id, day,
														A807001);// 调休
												float s7 = 0;
												float s8 = 0;
												float s9 = 0;
												float s10 = 0;
												float s11 = 0;
												float s12 = 0;
												float s13 = 0;
												float s14 = 0;
												float s15 = 0;
												float s16 = 0;
												float s17 = 0;
												float s18 = 0;
												if (selecta807707value != null
														&& !""
																.equals(selecta807707value)) {
													s7 = Float
															.parseFloat(selecta807707value);
												}
												if (selecta807708value != null
														&& !""
																.equals(selecta807708value)) {
													s8 = Float
															.parseFloat(selecta807708value);
												}
												if (selecta807709value != null
														&& !""
																.equals(selecta807709value)) {
													s9 = Float
															.parseFloat(selecta807709value);
												}
												if (selecta807710value != null
														&& !""
																.equals(selecta807710value)) {
													s10 = Float
															.parseFloat(selecta807710value);
												}
												if (selecta807711value != null
														&& !""
																.equals(selecta807711value)) {
													s11 = Float
															.parseFloat(selecta807711value);
												}
												if (selecta807712value != null
														&& !""
																.equals(selecta807712value)) {
													s12 = Float
															.parseFloat(selecta807712value);
												}
												if (selecta807713value != null
														&& !""
																.equals(selecta807713value)) {
													s13 = Float
															.parseFloat(selecta807713value);
												}
												if (selecta807714value != null
														&& !""
																.equals(selecta807714value)) {
													s14 = Float
															.parseFloat(selecta807714value);
												}
												if (selecta807715value != null
														&& !""
																.equals(selecta807715value)) {
													s15 = Float
															.parseFloat(selecta807715value);
												}
												if (selecta807716value != null
														&& !""
																.equals(selecta807716value)) {
													s16 = Float
															.parseFloat(selecta807716value);
												}
												if (selecta807717value != null
														&& !""
																.equals(selecta807717value)) {
													s17 = Float
															.parseFloat(selecta807717value);
												}
												if (selecta807718value != null
														&& !""
																.equals(selecta807718value)) {
													s18 = Float
															.parseFloat(selecta807718value);
												}
												float s19 = (s7 + s8 + s9 + s10
														+ s11 + s12 + s13 + s14
														+ s15 + s16 + s17 + s18)
														* (1 * 8 * 60);
												float s20 = (s7 + s8 + s9 + s10
														+ s11 + s12 + s13 + s14
														+ s17 + s18)
														* (1 * 8 * 60);
												float amawaytimevalue = amawaytime
														+ pmearlyamawaytime;
												if (!"2".equals(units)) {
													float sum1 = (amlatetime
															+ amawaytimevalue
															+ pmearlytime + s20)
															/ (unit1);
													sum1 = (float) (Math
															.round(sum1 * 100)) / 100;
													realitytime = shouldTime
															- sum1;
													realitytime = (float) (Math
															.round(realitytime * 1000)) / 1000;
													if (realitytime < 0) {
														realitytime = 0;
													}
													amawaytimevalue = shouldTime
															- (realitytime + s19);
													amawaytimevalue = (float) (Math
															.round(amawaytimevalue * 1000)) / 1000;
													if (amawaytimevalue < 0) {
														amawaytimevalue = 0;
													}
												} else {
													float sum1 = (amlatetime
															+ amawaytimevalue
															+ pmearlytime + s20);
													sum1 = (float) (Math
															.round(sum1 * 100)) / 100;
													realitytime = shouldTime
															- sum1;
													realitytime = (float) (Math
															.round(realitytime * 1000)) / 1000;
													if (realitytime < 0) {
														realitytime = 0;
													}
													amawaytimevalue = shouldTime
															- (realitytime + s19);
													amawaytimevalue = (float) (Math
															.round(amawaytimevalue * 1000)) / 1000;
													if (amawaytimevalue < 0) {
														amawaytimevalue = 0;
													}
												}
												attenceRate = new BigDecimal(
														realitytime * 100)
														.divide(
																new BigDecimal(
																		shouldTime),
																price1,
																BigDecimal.ROUND_HALF_UP)
														.floatValue();
												String A807701 = shouldTime
														+ "";
												String A807702 = realitytime
														+ "";
												String A807703 = attenceRate
														+ "";
												String A807704 = amlatetime
														+ "";
												String A807705 = pmearlytime
														+ "";
												String A807706 = (amawaytimevalue)
														+ "";

												UpdateA807(id, day, A807701,
														A807702, A807703,
														A807704, A807705,
														A807706, A807001);

											} else {
												float amawaytimevalue = amawaytime
														+ pmearlyamawaytime;
												if (!"2".equals(units)) {
													float sum1 = (amlatetime
															+ amawaytimevalue + pmearlytime)
															/ (unit1);
													sum1 = (float) (Math
															.round(sum1 * 100)) / 100;
													realitytime = shouldTime
															- sum1;
													realitytime = (float) (Math
															.round(realitytime * 1000)) / 1000;
												} else {
													float sum1 = (amlatetime
															+ amawaytimevalue + pmearlytime);
													sum1 = (float) (Math
															.round(sum1 * 100)) / 100;
													realitytime = shouldTime
															- sum1;
													realitytime = (float) (Math
															.round(realitytime * 1000)) / 1000;
												}
												attenceRate = new BigDecimal(
														realitytime * 100)
														.divide(
																new BigDecimal(
																		shouldTime),
																price1,
																BigDecimal.ROUND_HALF_UP)
														.floatValue();
												String A807701 = shouldTime
														+ "";
												String A807702 = realitytime
														+ "";
												String A807703 = attenceRate
														+ "";
												String A807704 = amlatetime
														+ "";
												String A807705 = pmearlytime
														+ "";
												String A807706 = (amawaytimevalue)
														+ "";
												AttenceSecondDayLogBO attenceseconddaylogbo = new AttenceSecondDayLogBO();
												attenceseconddaylogbo
														.setPersonId(id);
												attenceseconddaylogbo
														.setSubID(SequenceGenerator
																.getKeyId("A807"));
												attenceseconddaylogbo
														.setRecord(Constants.NO);
												attenceseconddaylogbo
														.setSecondDay(A807001);
												attenceseconddaylogbo
														.setAttenceDate(day);
												attenceseconddaylogbo
														.setRealityTime(A807702);
												attenceseconddaylogbo
														.setShouldTime(A807701);
												attenceseconddaylogbo
														.setAttenceRate(A807703);
												attenceseconddaylogbo
														.setLateTime(A807704);
												attenceseconddaylogbo
														.setEarlyTime(A807705);
												attenceseconddaylogbo
														.setAwayTime(A807706);
												saveAttenceSecondDayLogBO(attenceseconddaylogbo);
											}
										} else {
											// 上下限规则为不计算状态
										}
									} else {
										String A807001 = "" + (m + 1);
										String selecta807701value = selectA807701(
												"A807701", id, day, A807001);
										if (selecta807701value != null
												&& !""
														.equals(selecta807701value)) {
											String selecta807707value = selectA807701(
													"A807707", id, day, A807001); // 事假
											String selecta807708value = selectA807701(
													"A807708", id, day, A807001); // 病假
											String selecta807709value = selectA807701(
													"A807709", id, day, A807001);// 产假
											String selecta807710value = selectA807701(
													"A807710", id, day, A807001);// 婚假
											String selecta807711value = selectA807701(
													"A807711", id, day, A807001);// 探亲假
											String selecta807712value = selectA807701(
													"A807712", id, day, A807001);// 年假
											String selecta807713value = selectA807701(
													"A807713", id, day, A807001);// 工伤假
											String selecta807714value = selectA807701(
													"A807714", id, day, A807001);// 丧假
											String selecta807715value = selectA807701(
													"A807715", id, day, A807001);// 出差
											String selecta807716value = selectA807701(
													"A807716", id, day, A807001);// 公出
											String selecta807717value = selectA807701(
													"A807717", id, day, A807001);// 公假
											String selecta807718value = selectA807701(
													"A807718", id, day, A807001);// 调休
											float s7 = 0;
											float s8 = 0;
											float s9 = 0;
											float s10 = 0;
											float s11 = 0;
											float s12 = 0;
											float s13 = 0;
											float s14 = 0;
											float s15 = 0;
											float s16 = 0;
											float s17 = 0;
											float s18 = 0;
											if (selecta807707value != null
													&& !""
															.equals(selecta807707value)) {
												s7 = Float
														.parseFloat(selecta807707value);
											}
											if (selecta807708value != null
													&& !""
															.equals(selecta807708value)) {
												s8 = Float
														.parseFloat(selecta807708value);
											}
											if (selecta807709value != null
													&& !""
															.equals(selecta807709value)) {
												s9 = Float
														.parseFloat(selecta807709value);
											}
											if (selecta807710value != null
													&& !""
															.equals(selecta807710value)) {
												s10 = Float
														.parseFloat(selecta807710value);
											}
											if (selecta807711value != null
													&& !""
															.equals(selecta807711value)) {
												s11 = Float
														.parseFloat(selecta807711value);
											}
											if (selecta807712value != null
													&& !""
															.equals(selecta807712value)) {
												s12 = Float
														.parseFloat(selecta807712value);
											}
											if (selecta807713value != null
													&& !""
															.equals(selecta807713value)) {
												s13 = Float
														.parseFloat(selecta807713value);
											}
											if (selecta807714value != null
													&& !""
															.equals(selecta807714value)) {
												s14 = Float
														.parseFloat(selecta807714value);
											}
											if (selecta807715value != null
													&& !""
															.equals(selecta807715value)) {
												s15 = Float
														.parseFloat(selecta807715value);
											}
											if (selecta807716value != null
													&& !""
															.equals(selecta807716value)) {
												s16 = Float
														.parseFloat(selecta807716value);
											}
											if (selecta807717value != null
													&& !""
															.equals(selecta807717value)) {
												s17 = Float
														.parseFloat(selecta807717value);
											}
											if (selecta807718value != null
													&& !""
															.equals(selecta807718value)) {
												s18 = Float
														.parseFloat(selecta807718value);
											}
											float s19 = (s7 + s8 + s9 + s10
													+ s11 + s12 + s13 + s14
													+ s15 + s16 + s17 + s18);
											float s20 = (s7 + s8 + s9 + s10
													+ s11 + s12 + s13 + s14
													+ s17 + s18);
											String attclassTime1 = attclassdetailbos[p + 1]
													+ ":00";// 上班时刻
											String attclassTime5 = attclassdetailbos[p + 5]
													+ ":00";// 休息开始
											String attclassTime6 = attclassdetailbos[p + 6]
													+ ":00";// 休息结束
											String attclassTime10 = attclassdetailbos[p + 10]
													+ ":00";// 下班时刻
											Date date1 = df
													.parse(attclassTime1);
											Date date5 = df
													.parse(attclassTime5);
											Date date6 = df
													.parse(attclassTime6);
											Date date10 = df
													.parse(attclassTime10);
											float shouldTime = ((float) (date5
													.getTime() - date1
													.getTime())
													/ (unit) + (float) (date10
													.getTime() - date6
													.getTime())
													/ (unit));// 应出勤
											shouldTime = (float) (Math
													.round(shouldTime * 100)) / 100;
											String A807701 = shouldTime + "";

											float amawaytime = shouldTime - s19;
											amawaytime = (float) (Math
													.round(amawaytime * 100)) / 100;
											if (amawaytime < 0) {
												amawaytime = 0;
											}

											float realitytime = shouldTime
													- (amawaytime + s20);
											realitytime = (float) (Math
													.round(realitytime * 100)) / 100;
											float attenceRate = new BigDecimal(
													realitytime * 100).divide(
													new BigDecimal(shouldTime),
													price1,
													BigDecimal.ROUND_HALF_UP)
													.floatValue();
											String A807702 = realitytime + "";
											String A807703 = attenceRate + "";

											amawaytime = amawaytime
													* (1 * 8 * 60);
											String A807706 = amawaytime + "";

											UpdateA807(id, day, A807701,
													A807702, A807703, A807706,
													A807001);
										} else {
											String attclassTime1 = attclassdetailbos[p + 1]
													+ ":00";// 上班时刻
											String attclassTime5 = attclassdetailbos[p + 5]
													+ ":00";// 休息开始
											String attclassTime6 = attclassdetailbos[p + 6]
													+ ":00";// 休息结束
											String attclassTime10 = attclassdetailbos[p + 10]
													+ ":00";// 下班时刻
											Date date1 = df
													.parse(attclassTime1);
											Date date5 = df
													.parse(attclassTime5);
											Date date6 = df
													.parse(attclassTime6);
											Date date10 = df
													.parse(attclassTime10);
											float shouldTime = ((float) (date5
													.getTime() - date1
													.getTime())
													/ (unit) + (float) (date10
													.getTime() - date6
													.getTime())
													/ (unit));// 应出勤
											shouldTime = (float) (Math
													.round(shouldTime * 100)) / 100;
											String A807701 = shouldTime + "";
											String A807702 = "0";
											String A807703 = "0";
											float amawaytime = shouldTime
													* (1 * 8 * 60);
											amawaytime = (float) (Math
													.round(amawaytime * 100)) / 100;
											String A807706 = amawaytime + "";
											AttenceSecondDayLogBO attenceseconddaylogbo = new AttenceSecondDayLogBO();
											attenceseconddaylogbo
													.setPersonId(id);
											attenceseconddaylogbo
													.setSubID(SequenceGenerator
															.getKeyId("A807"));
											attenceseconddaylogbo
													.setRecord(Constants.NO);
											attenceseconddaylogbo
													.setSecondDay(A807001);
											attenceseconddaylogbo
													.setAttenceDate(day);
											attenceseconddaylogbo
													.setRealityTime(A807702);
											attenceseconddaylogbo
													.setShouldTime(A807701);
											attenceseconddaylogbo
													.setAttenceRate(A807703);
											attenceseconddaylogbo
													.setAwayTime(A807706);
											saveAttenceSecondDayLogBO(attenceseconddaylogbo);
										}
									}
									m++;
								}
							} else {
								// 余数n<=0
							}

							// 进行加班处理
							if (!"0".equals(b.getOverTimeFlag())) {
								AttClassDetailBO attclassdetailbo1 = (AttClassDetailBO) bs
										.get(bs.size() - 1);
								String beginTimes1 = attclassdetailbo1
										.getItemTime()
										+ ":00";
								List list2 = cardMessageDAO
										.getAttenceLogBOLog2(id, day,
												beginTimes1);
								if (list2 != null && list2.size() > 0) {
									AttenceLogBO attencelogbos3 = (AttenceLogBO) list2
											.get(0);
									AttenceLogBO attencelogbos4 = (AttenceLogBO) list2
											.get(list2.size() - 1);
									AttOverTimeLogBO attovertimelogbo = new AttOverTimeLogBO();
									attovertimelogbo.setPersonID(id);
									attovertimelogbo.setApplyDate(day);
									attovertimelogbo
											.setBeginTime(attencelogbos3
													.getCardTime());
									attovertimelogbo.setEndTime(attencelogbos4
											.getCardTime());
									attovertimelogbo.setProcess("0");
									deleteAttOverTimeLogBO(id, day);
									saveorupdateAttOverTimeLogBO(attovertimelogbo);
								}
							}
						} else {
							// 所对应班次时段列表为空
						}

					} else {
						List bs = attenceSetDAO.getAllAttClassDetailBO3(b
								.getClassID());
						List bss = attenceSetDAO.getAllAttClassDetailBO4(b
								.getClassID());
						bs.addAll(bss);
						if (bs != null && bs.size() > 0) { // 判断某人所属班次的时段时间是否为空
							String[] attclassdetailbos = new String[bs.size()];// 时段时间数组
							if ("1".equals(b.getDayTake())) { // 看是否以第一天记班
								String yearvalues = day.substring(0, 4);
								String monthvalues = day.substring(5, 7);
								String dayvalues = day.substring(8, 10);
								int days = MonthDays(Integer
										.parseInt(monthvalues), Integer
										.parseInt(yearvalues));// 月份的天数
								int dayss = Integer.parseInt(dayvalues);
								int yearvaluess = Integer.parseInt(yearvalues);
								int monthvaluess = Integer
										.parseInt(monthvalues);
								String daysss = "";
								if ("12".equals(monthvalues)) {
									if (days == dayss) {
										daysss = (yearvaluess + 1) + "-01-01";
									} else {
										if ((dayss + 1) >= 10) {
											daysss = yearvaluess + "-"
													+ monthvalues + "-"
													+ (dayss + 1);
										} else {
											daysss = yearvaluess + "-"
													+ monthvalues + "-0"
													+ (dayss + 1);
										}
									}
								} else {
									if (days == dayss) {
										if ((monthvaluess + 1) >= 10) {
											daysss = (yearvaluess + 1) + "-"
													+ (monthvaluess + 1)
													+ "-01";
										} else {
											daysss = (yearvaluess + 1) + "-0"
													+ (monthvaluess + 1)
													+ "-01";
										}
									} else {
										if ((dayss + 1) >= 10) {
											daysss = yearvaluess + "-"
													+ monthvalues + "-"
													+ (dayss + 1);
										} else {
											daysss = yearvaluess + "-"
													+ monthvalues + "-0"
													+ (dayss + 1);
										}
									}
								}
								/*
								 * 为时段时间数组赋值
								 */
								for (int j = 0; j < bs.size(); j++) {
									AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
											.get(j);
									if ("1".equals(attclassdetailbo
											.getDayFlag())) {
										attclassdetailbos[j] = day
												+ " "
												+ attclassdetailbo
														.getItemTime();
									} else {
										attclassdetailbos[j] = daysss
												+ " "
												+ attclassdetailbo
														.getItemTime();
									}
								}
								kqglCale(id, day, units, unit, unit1, price1,
										attclassdetailbos, b, caclLaterName,
										caclEarlyName);
							} else { // 看是否以第二天记班
								String yearvalues = day.substring(0, 4);
								String monthvalues = day.substring(5, 7);
								String dayvalues = day.substring(8, 10);
								int days = MonthDays(Integer
										.parseInt(monthvalues), Integer
										.parseInt(yearvalues));// 月份的天数
								int dayss = Integer.parseInt(dayvalues);
								int yearvaluess = Integer.parseInt(yearvalues);
								int monthvaluess = Integer
										.parseInt(monthvalues);
								String daysss = "";
								if ("01".equals(monthvalues)) {
									if ("01".equals(dayvalues)) {
										int days1 = MonthDays(12,
												(yearvaluess - 1));// 月份的天数
										daysss = (yearvaluess - 1) + "-12-"
												+ days1;
									} else {
										if ((dayss - 1) >= 10) {
											daysss = yearvaluess + "-"
													+ monthvalues + "-"
													+ (dayss - 1);
										} else {
											daysss = yearvaluess + "-"
													+ monthvalues + "-0"
													+ (dayss - 1);
										}
									}
								} else {
									if ("01".equals(dayvalues)) {
										int days1 = MonthDays(
												(monthvaluess - 1),
												(yearvaluess - 0));// 月份的天数
										if ((monthvaluess - 1) >= 10) {
											daysss = yearvaluess + "-"
													+ (monthvaluess - 1) + "-"
													+ days1;
										} else {
											daysss = yearvaluess + "-0"
													+ (monthvaluess - 1) + "-"
													+ days1;
										}
									} else {
										if ((dayss - 1) >= 10) {
											daysss = yearvaluess + "-"
													+ monthvalues + "-"
													+ (dayss - 1);
										} else {
											daysss = yearvaluess + "-"
													+ monthvalues + "-0"
													+ (dayss - 1);
										}
									}
								}
								/*
								 * 为时段时间数组赋值
								 */
								for (int j = 0; j < bs.size(); j++) {
									AttClassDetailBO attclassdetailbo = (AttClassDetailBO) bs
											.get(j);
									if ("1".equals(attclassdetailbo
											.getDayFlag())) {
										attclassdetailbos[j] = daysss
												+ " "
												+ attclassdetailbo
														.getItemTime();
									} else {
										attclassdetailbos[j] = day
												+ " "
												+ attclassdetailbo
														.getItemTime();
									}
								}
								kqglCale(id, day, units, unit, unit1, price1,
										attclassdetailbos, b, caclLaterName,
										caclEarlyName);
							}// 看是否以第一天记班

						} // 判断某人所属班次的时段时间是否为空
					}// 判断班次是否为零点班次
				} else {
					calcAttAttOverTimeRecBO(id, day);
					calcAttOverTimeLogBO(id, day);
				}
			}
		}
        long endtime=System.currentTimeMillis();
                    System.out.println("计算时间："+(endtime-begintime)/1000);
		String flaCountTable = "hr319#_A809_"
				+ CommonFuns.getSysDate("yyyyMMddHHss");
		caletablesql(orgId, flaCountTable);
		caledeleteA809(orgId, calebeginTime, caleendTime);
        long endtime1=System.currentTimeMillis();
         System.out.println("计算时间："+(endtime-endtime1)/1000);
		caledaydatamethod(personClass, flagcharlists, orgId, flaCountTable,
				yearValueCale, monthValueCale, calebeginTime, caleendTime,
				isMon);
        long endtime2=System.currentTimeMillis();
         System.out.println("计算时间："+(endtime1-endtime2)/1000);
		return "";
	}

	/**
	 * 清空A809表中的数据
	 * 
	 * @param orgId
	 * @param calebeginTime
	 * @param caleendTime
	 * @throws Exception
	 */
	public void caledeleteA809(String orgId, String calebeginTime,
			String caleendTime) throws Exception {
		String sql = "delete from A809 where ID in (select ID from A001 where A001701='"
				+ orgId + "' or A001705='" + orgId + "')";
		sql += " and A809700>='" + calebeginTime + "' and A809700<='"
				+ caleendTime + "'";
		activeapi.executeSql(sql);
	}

	/**
	 * 创建日汇总临时表 功能：就是把A807表中的数汇总到日汇总的临时表中
	 * 
	 * @param orgId
	 * @param flaCountTable
	 * @throws Exception
	 */
	public void caletablesql(String orgId, String flaCountTable)
			throws Exception {
		if ("ORACLE".equals(Constants.DB_TYPE)) {
			String sql = "create table "
					+ flaCountTable
					+ "(ID,SUBID,A807000,A807700,A807701,A807702,A807703,A807704,A807705,A807706,A807707,A807708,";
			sql += "A807709,A807710,A807711,A807712,A807713,A807714,A807715,A807716,A807717,A807718,A807719,A807720,A807721) ";
			sql += "as select ID,cast(sum(cast(SUBID as float)) as varchar2(100)),A807000,A807700,cast(sum(cast(isnull(A807701,'0') as float)) as varchar2(100)),";
			sql += "cast(sum(cast(isnull(A807702,'0') as float)) as varchar2(100)),cast(sum(cast(isnull(A807703,'0') as float)) as varchar2(100)),";
			sql += "cast(sum(cast(isnull(A807704,'0') as float)) as varchar2(100)),cast(sum(cast(isnull(A807705,'0') as float)) as varchar2(100)),";
			sql += "cast(sum(cast(isnull(A807706,'0') as float)) as varchar2(100)),cast(sum(cast(isnull(A807707,'0') as float)) as varchar2(32)),";
			sql += "cast(sum(cast(isnull(A807708,'0') as float)) as varchar2(32)),cast(sum(cast(isnull(A807709,'0') as float)) as varchar2(32)),";
			sql += "cast(sum(cast(isnull(A807710,'0') as float)) as varchar2(32)),cast(sum(cast(isnull(A807711,'0') as float)) as varchar2(32)),";
			sql += "cast(sum(cast(isnull(A807712,'0') as float)) as varchar2(32)),cast(sum(cast(isnull(A807713,'0') as float)) as varchar2(32)),";
			sql += "cast(sum(cast(isnull(A807714,'0') as float)) as varchar2(32)),cast(sum(cast(isnull(A807715,'0') as float)) as varchar2(32)),";
			sql += "cast(sum(cast(isnull(A807716,'0') as float)) as varchar2(32)),cast(sum(cast(isnull(A807717,'0') as float)) as varchar2(32)),";
			sql += "cast(sum(cast(isnull(A807718,'0') as float)) as varchar2(32)),cast(sum(cast(isnull(A807719,'0') as float)) as varchar2(32)),";
			sql += "cast(sum(cast(isnull(A807720,'0') as float)) as varchar2(32)),cast(sum(cast(isnull(A807721,'0') as float)) as varchar2(32)) ";
			sql += " from A807 where ID in (select ID from A001 where A001701='"
					+ orgId
					+ "' or A001705='"
					+ orgId
					+ "') group by ID,A807000,A807700";
			activeapi.executeSql(sql);
		} else {
			String sql = "select  ID,cast(sum(cast(SUBID as float)) as nvarchar(100)) as  SUBID,A807000,A807700,cast(sum(cast(A807701 as float)) as nvarchar(100)) as  A807701,";
			sql += "cast(sum(cast(A807702 as float)) as nvarchar(100)) as  A807702,cast(sum(cast(A807703 as float)) as nvarchar(100)) as  A807703,";
			sql += "cast(sum(cast(A807704 as float)) as nvarchar(100)) as  A807704,cast(sum(cast(A807705 as float)) as nvarchar(100)) as  A807705,";
			sql += "cast(sum(cast(A807706 as float)) as nvarchar(100)) as  A807706,cast(sum(cast(A807707 as float)) as nvarchar(32)) as  A807707,";
			sql += "cast(sum(cast(A807708 as float)) as nvarchar(32)) as  A807708,cast(sum(cast(A807709 as float)) as nvarchar(32)) as  A807709,";
			sql += "cast(sum(cast(A807710 as float)) as nvarchar(32)) as  A807710 ,cast(sum(cast(A807711 as float)) as nvarchar(32)) as  A807711,";
			sql += "cast(sum(cast(A807712 as float)) as nvarchar(32)) as  A807712,cast(sum(cast(A807713 as float)) as nvarchar(32)) as  A807713,";
			sql += "cast(sum(cast(A807714 as float)) as nvarchar(32)) as  A807714,cast(sum(cast(A807715 as float)) as nvarchar(32)) as  A807715,";
			sql += "cast(sum(cast(A807716 as float)) as nvarchar(32)) as  A807716,cast(sum(cast(A807717 as float)) as nvarchar(32)) as  A807717,";
			sql += "cast(sum(cast(A807718 as float)) as nvarchar(32)) as  A807718,cast(sum(cast(A807719 as float)) as nvarchar(32)) as  A807719,";
			sql += "cast(sum(cast(A807720 as float)) as nvarchar(32)) as  A807720,cast(sum(cast(A807721 as float)) as nvarchar(32)) as  A807721 ";
			sql += " into  " + flaCountTable + " ";
			sql += " from  A807 where ID in (select ID from A001 where A001701='"
					+ orgId + "' or A001705='" + orgId + "') ";
			sql += " group by ID,A807000,A807700";
			activeapi.executeSql(sql);
		}
	}

	/**
	 * 功能：是把日汇总临时表中的数据，按照汇总计算规则，批量导入日汇总表A809中。
	 * 
	 * @param personClass
	 * @param flagcharlists
	 * @param orgId
	 * @param flaCountTable
	 * @param yearValueCale
	 * @param monthValueCale
	 * @param calebeginTime
	 * @param caleendTime
	 * @param isMon
	 * @return
	 * @throws Exception
	 */
	public String caledaydatamethod(HashMap personClass, List flagcharlists,
			String orgId, String flaCountTable, String yearValueCale,
			String monthValueCale, String calebeginTime, String caleendTime,
			boolean isMon) throws Exception {
		/*
		 * 精度可扩展接口
		 */
        long begintime=System.currentTimeMillis();
		HashMap flagCharMaps = new HashMap();
		HashMap fieldMaps = new HashMap();
        AttItemSetDetailBO attitemsetdetailbo=null;
		if (flagcharlists != null && flagcharlists.size() > 0) {
			for (int w = 0; w < flagcharlists.size(); w++) {
				attitemsetdetailbo = (AttItemSetDetailBO) flagcharlists
						.get(w);
				flagCharMaps.put(attitemsetdetailbo.getItemCode(),
						attitemsetdetailbo.getUnit());
				fieldMaps.put(attitemsetdetailbo.getItemCode(),
						attitemsetdetailbo.getDayField());
			}
		}
		String price = "2";
		int price1 = Integer.parseInt(price);
		int dayunit = 1;
		int hourunit = 1 * 8;
		int minuteunit = 1 * 8 * 60;
		StringBuffer sql =new StringBuffer( "select id,A807000,A807700,A807701,A807702,A807703,A807704,A807705,A807706,A807707,A807708,A807709,A807710,");
		sql.append( "A807711,A807712,A807713,A807714,A807715,A807716,A807717,A807718,A807719,A807720,A807721,SUBID ");
		sql .append( " from " + flaCountTable + " ");
        sql.append(" where ID in (select ID from A001 where A001701='"+orgId+"' or A001705='"+orgId + "')");
        sql.append(" and A807700>='"+calebeginTime+"' and A807700<='"+caleendTime+"'");

		CellVO[] head = new CellVO[25];
		head[0] = new CellVO();
		head[0].setItemId("id");
		head[1] = new CellVO();
		head[1].setItemId("A807000");
		head[2] = new CellVO();
		head[2].setItemId("A807700");
		head[3] = new CellVO();
		head[3].setItemId("A807701");
		head[4] = new CellVO();
		head[4].setItemId("A807702");
		head[5] = new CellVO();
		head[5].setItemId("A807703");
		head[6] = new CellVO();
		head[6].setItemId("A807704");
		head[7] = new CellVO();
		head[7].setItemId("A807705");
		head[8] = new CellVO();
		head[8].setItemId("A807706");
		head[9] = new CellVO();
		head[9].setItemId("A807707");
		head[10] = new CellVO();
		head[10].setItemId("A807708");
		head[11] = new CellVO();
		head[11].setItemId("A807709");
		head[12] = new CellVO();
		head[12].setItemId("A807710");
		head[13] = new CellVO();
		head[13].setItemId("A807711");
		head[14] = new CellVO();
		head[14].setItemId("A807712");
		head[15] = new CellVO();
		head[15].setItemId("A807713");
		head[16] = new CellVO();
		head[16].setItemId("A807714");
		head[17] = new CellVO();
		head[17].setItemId("A807715");
		head[18] = new CellVO();
		head[18].setItemId("A807716");
		head[19] = new CellVO();
		head[19].setItemId("A807717");
		head[20] = new CellVO();
		head[20].setItemId("A807718");
		head[21] = new CellVO();
		head[21].setItemId("A807719");
		head[22] = new CellVO();
		head[22].setItemId("A807720");
		head[23] = new CellVO();
		head[23].setItemId("A807721");
		head[24] = new CellVO();
		head[24].setItemId("SUBID");
		Vector rs = activeapi.getDataListBySql(head, sql.toString());
        long begintime1=System.currentTimeMillis();
        System.out.println("计算时间0："+(begintime1-begintime)/1000);
        System.out.println("rs.size()="+rs.size());
        HashMap fieldvalues=null;
        String id=null;
        String SUBID=null;
        String A809000=null;
        String day=null;
        CellVO[] row=null;
		String[] sqls = new String[rs.size()];
		for (int i = 0; i < rs.size(); i++) {
			row = (CellVO[]) rs.get(i);
			fieldvalues = new HashMap();
			id = row[0].getValue(); // 人员ID
			SUBID = row[24].getValue(); // SUBID
			A809000 = row[1].getValue(); // 00900,00901
			day = row[2].getValue(); // A807700

			float s1 = 0;
			float s2 = 0;
			float s3 = 0;
			float s4 = 0;
			float s5 = 0;
			float s6 = 0;
			float s7 = 0;
			float s8 = 0;
			float s9 = 0;
			float s10 = 0;
			float s11 = 0;
			float s12 = 0;
			float s13 = 0;
			float s14 = 0;
			float s15 = 0;
			float s16 = 0;
			float s17 = 0;
			float s18 = 0;
			float s19 = 0;
			float s20 = 0;
			float s21 = 0;
			if (row[3].getValue() != null && !"".equals(row[3].getValue())) {
				s1 = Float.parseFloat(row[3].getValue());
				String A809701 = s1 + "";
				fieldvalues.put("A809701", A809701.trim());
			}
			if (row[4].getValue() != null && !"".equals(row[4].getValue())) {
				s2 = Float.parseFloat(row[4].getValue());
				String A809702 = s2 + "";
				fieldvalues.put("A809702", A809702.trim());
			}
			float attenceRate = new BigDecimal(s2 * 100).divide(
					new BigDecimal(s1), price1, BigDecimal.ROUND_HALF_UP)
					.floatValue();
			String A809703 = attenceRate + "";
			fieldvalues.put("A809703", A809703.trim());

			if (row[6].getValue() != null && !"".equals(row[6].getValue())) {
				s4 = Float.parseFloat(row[6].getValue());
				String flagcharA809704 = (String) flagCharMaps.get("704");
				if (flagcharA809704 != null && !"".equals(flagcharA809704)) {
					if ("0".equals(flagcharA809704)) {
						String A807704 = daylateTime1(id, day);
						s4 = Float.parseFloat(A807704);
						if (s4 > 1) {
							s4 = 1;
						}
					} else if ("1".equals(flagcharA809704)) {
						s4 = s4 / (minuteunit);
					} else if ("2".equals(flagcharA809704)) {
						s4 = s4 / (60);
					} else if ("3".equals(flagcharA809704)) {
						s4 = s4 / (dayunit);
					}
				}
				String fieldA809704 = (String) fieldMaps.get("704");
				if (fieldA809704 != null && !"".equals(fieldA809704)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809704);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s4 += Float.parseFloat(dayfieldvalue);
					}
					String A809704 = s4 + "";
					fieldvalues.put(fieldA809704, A809704.trim());
				}
			}

			if (row[7].getValue() != null && !"".equals(row[7].getValue())) {
				s5 = Float.parseFloat(row[7].getValue());
				String flagcharA809705 = (String) flagCharMaps.get("705");
				if (flagcharA809705 != null && !"".equals(flagcharA809705)) {
					if ("0".equals(flagcharA809705)) {
						String A807705 = dayearlyTime1(id, day);
						s5 = Float.parseFloat(A807705);
						if (s5 > 1) {
							s5 = 1;
						}
					} else if ("1".equals(flagcharA809705)) {
						s5 = s5 / (minuteunit);
					} else if ("2".equals(flagcharA809705)) {
						s5 = s5 / (60);
					} else if ("3".equals(flagcharA809705)) {
						s5 = s5 / (dayunit);
					}
				}
				String fieldA809705 = (String) fieldMaps.get("705");
				if (fieldA809705 != null && !"".equals(fieldA809705)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809705);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s5 += Float.parseFloat(dayfieldvalue);
					}
					String A809705 = s5 + "";
					fieldvalues.put(fieldA809705, A809705.trim());
				}
			}

			if (row[8].getValue() != null && !"".equals(row[8].getValue())) {
				s6 = Float.parseFloat(row[8].getValue());
				String flagcharA809706 = (String) flagCharMaps.get("706");
				if (flagcharA809706 != null && !"".equals(flagcharA809706)) {
					if ("0".equals(flagcharA809706)) {
						String A807706 = dayawayTime1(id, day);
						s6 = Float.parseFloat(A807706);
						if (s6 > 1) {
							s6 = 1;
						}
					} else if ("1".equals(flagcharA809706)) {
						s6 = s6 / (minuteunit);
					} else if ("2".equals(flagcharA809706)) {
						s6 = s6 / (60);
					} else if ("3".equals(flagcharA809706)) {
						s6 = s6 / (dayunit);
					}
				}
				String fieldA809706 = (String) fieldMaps.get("706");
				if (fieldA809706 != null && !"".equals(fieldA809706)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809706);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s6 += Float.parseFloat(dayfieldvalue);
					}
					String A809706 = s6 + "";
					fieldvalues.put(fieldA809706, A809706.trim());
				}
			}

			if (row[9].getValue() != null && !"".equals(row[9].getValue())) {
				s7 = Float.parseFloat(row[9].getValue());
				String flagcharA809707 = (String) flagCharMaps.get("707");
				if (flagcharA809707 != null && !"".equals(flagcharA809707)) {
					if ("1".equals(flagcharA809707)) {
						s7 = s7 * (dayunit);
					} else if ("2".equals(flagcharA809707)) {
						s7 = s7 * (hourunit);
					} else if ("3".equals(flagcharA809707)) {
						s7 = s7 * (minuteunit);
					}
				}
				String fieldA809707 = (String) fieldMaps.get("707");
				if (fieldA809707 != null && !"".equals(fieldA809707)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809707);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s7 += Float.parseFloat(dayfieldvalue);
					}
					String A809707 = s7 + "";
					fieldvalues.put(fieldA809707, A809707.trim());
				}
			}

			if (row[10].getValue() != null && !"".equals(row[10].getValue())) {
				s8 = Float.parseFloat(row[10].getValue());
				String flagcharA809708 = (String) flagCharMaps.get("708");
				if (flagcharA809708 != null && !"".equals(flagcharA809708)) {
					if ("1".equals(flagcharA809708)) {
						s8 = s8 * (dayunit);
					} else if ("2".equals(flagcharA809708)) {
						s8 = s8 * (hourunit);
					} else if ("3".equals(flagcharA809708)) {
						s8 = s8 * (minuteunit);
					}
				}
				String fieldA809708 = (String) fieldMaps.get("708");
				if (fieldA809708 != null && !"".equals(fieldA809708)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809708);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s8 += Float.parseFloat(dayfieldvalue);
					}
					String A809708 = s8 + "";
					fieldvalues.put(fieldA809708, A809708.trim());
				}
			}

			if (row[11].getValue() != null && !"".equals(row[11].getValue())) {
				s9 = Float.parseFloat(row[11].getValue());
				String flagcharA809709 = (String) flagCharMaps.get("709");
				if (flagcharA809709 != null && !"".equals(flagcharA809709)) {
					if ("1".equals(flagcharA809709)) {
						s9 = s9 * (dayunit);
					} else if ("2".equals(flagcharA809709)) {
						s9 = s9 * (hourunit);
					} else if ("3".equals(flagcharA809709)) {
						s9 = s9 * (minuteunit);
					}
				}
				String fieldA809709 = (String) fieldMaps.get("709");
				if (fieldA809709 != null && !"".equals(fieldA809709)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809709);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s9 += Float.parseFloat(dayfieldvalue);
					}
					String A809709 = s9 + "";
					fieldvalues.put(fieldA809709, A809709.trim());
				}
			}

			if (row[12].getValue() != null && !"".equals(row[12].getValue())) {
				s10 = Float.parseFloat(row[12].getValue());
				String flagcharA809710 = (String) flagCharMaps.get("710");
				if (flagcharA809710 != null && !"".equals(flagcharA809710)) {
					if ("1".equals(flagcharA809710)) {
						s10 = s10 * (dayunit);
					} else if ("2".equals(flagcharA809710)) {
						s10 = s10 * (hourunit);
					} else if ("3".equals(flagcharA809710)) {
						s10 = s10 * (minuteunit);
					}
				}
				String fieldA809710 = (String) fieldMaps.get("710");
				if (fieldA809710 != null && !"".equals(fieldA809710)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809710);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s10 += Float.parseFloat(dayfieldvalue);
					}
					String A809710 = s10 + "";
					fieldvalues.put(fieldA809710, A809710.trim());
				}
			}

			if (row[13].getValue() != null && !"".equals(row[13].getValue())) {
				s11 = Float.parseFloat(row[13].getValue());
				String flagcharA809711 = (String) flagCharMaps.get("711");
				if (flagcharA809711 != null && !"".equals(flagcharA809711)) {
					if ("1".equals(flagcharA809711)) {
						s11 = s11 * (dayunit);
					} else if ("2".equals(flagcharA809711)) {
						s11 = s11 * (hourunit);
					} else if ("3".equals(flagcharA809711)) {
						s11 = s11 * (minuteunit);
					}
				}
				String fieldA809711 = (String) fieldMaps.get("711");
				if (fieldA809711 != null && !"".equals(fieldA809711)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809711);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s11 += Float.parseFloat(dayfieldvalue);
					}
					String A809711 = s11 + "";
					fieldvalues.put(fieldA809711, A809711.trim());
				}
			}

			if (row[14].getValue() != null && !"".equals(row[14].getValue())) {
				s12 = Float.parseFloat(row[14].getValue());
				String flagcharA809712 = (String) flagCharMaps.get("712");
				if (flagcharA809712 != null && !"".equals(flagcharA809712)) {
					if ("1".equals(flagcharA809712)) {
						s12 = s12 * (dayunit);
					} else if ("2".equals(flagcharA809712)) {
						s12 = s12 * (hourunit);
					} else if ("3".equals(flagcharA809712)) {
						s12 = s12 * (minuteunit);
					}
				}
				String fieldA809712 = (String) fieldMaps.get("712");
				if (fieldA809712 != null && !"".equals(fieldA809712)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809712);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s12 += Float.parseFloat(dayfieldvalue);
					}
					String A809712 = s12 + "";
					fieldvalues.put(fieldA809712, A809712.trim());
				}
			}

			if (row[15].getValue() != null && !"".equals(row[15].getValue())) {
				s13 = Float.parseFloat(row[15].getValue());
				String flagcharA809713 = (String) flagCharMaps.get("713");
				if (flagcharA809713 != null && !"".equals(flagcharA809713)) {
					if ("1".equals(flagcharA809713)) {
						s13 = s13 * (dayunit);
					} else if ("2".equals(flagcharA809713)) {
						s13 = s13 * (hourunit);
					} else if ("3".equals(flagcharA809713)) {
						s13 = s13 * (minuteunit);
					}
				}
				String fieldA809713 = (String) fieldMaps.get("713");
				if (fieldA809713 != null && !"".equals(fieldA809713)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809713);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s13 += Float.parseFloat(dayfieldvalue);
					}
					String A809713 = s13 + "";
					fieldvalues.put(fieldA809713, A809713.trim());
				}
			}

			if (row[16].getValue() != null && !"".equals(row[16].getValue())) {
				s14 = Float.parseFloat(row[16].getValue());
				String flagcharA809714 = (String) flagCharMaps.get("714");
				if (flagcharA809714 != null && !"".equals(flagcharA809714)) {
					if ("1".equals(flagcharA809714)) {
						s14 = s14 * (dayunit);
					} else if ("2".equals(flagcharA809714)) {
						s14 = s14 * (hourunit);
					} else if ("3".equals(flagcharA809714)) {
						s14 = s14 * (minuteunit);
					}
				}
				String fieldA809714 = (String) fieldMaps.get("714");
				if (fieldA809714 != null && !"".equals(fieldA809714)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809714);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s14 += Float.parseFloat(dayfieldvalue);
					}
					String A809714 = s14 + "";
					fieldvalues.put(fieldA809714, A809714.trim());
				}
			}

			if (row[17].getValue() != null && !"".equals(row[17].getValue())) {
				s15 = Float.parseFloat(row[17].getValue());
				String flagcharA809715 = (String) flagCharMaps.get("715");
				if (flagcharA809715 != null && !"".equals(flagcharA809715)) {
					if ("1".equals(flagcharA809715)) {
						s15 = s15 * (dayunit);
					} else if ("2".equals(flagcharA809715)) {
						s15 = s15 * (hourunit);
					} else if ("3".equals(flagcharA809715)) {
						s15 = s15 * (minuteunit);
					}
				}
				String fieldA809715 = (String) fieldMaps.get("715");
				if (fieldA809715 != null && !"".equals(fieldA809715)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809715);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s15 += Float.parseFloat(dayfieldvalue);
					}
					String A809715 = s15 + "";
					fieldvalues.put(fieldA809715, A809715.trim());
				}
			}

			if (row[18].getValue() != null && !"".equals(row[18].getValue())) {
				s16 = Float.parseFloat(row[18].getValue());
				String flagcharA809716 = (String) flagCharMaps.get("716");
				if (flagcharA809716 != null && !"".equals(flagcharA809716)) {
					if ("1".equals(flagcharA809716)) {
						s16 = s16 * (dayunit);
					} else if ("2".equals(flagcharA809716)) {
						s16 = s16 * (hourunit);
					} else if ("3".equals(flagcharA809716)) {
						s16 = s16 * (minuteunit);
					}
				}
				String fieldA809716 = (String) fieldMaps.get("716");
				if (fieldA809716 != null && !"".equals(fieldA809716)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809716);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s16 += Float.parseFloat(dayfieldvalue);
					}
					String A809716 = s16 + "";
					fieldvalues.put(fieldA809716, A809716.trim());
				}
			}

			if (row[19].getValue() != null && !"".equals(row[19].getValue())) {
				s17 = Float.parseFloat(row[19].getValue());
				String flagcharA809717 = (String) flagCharMaps.get("717");
				if (flagcharA809717 != null && !"".equals(flagcharA809717)) {
					if ("1".equals(flagcharA809717)) {
						s17 = s17 * (dayunit);
					} else if ("2".equals(flagcharA809717)) {
						s17 = s17 * (hourunit);
					} else if ("3".equals(flagcharA809717)) {
						s17 = s17 * (minuteunit);
					}
				}
				String fieldA809717 = (String) fieldMaps.get("717");
				if (fieldA809717 != null && !"".equals(fieldA809717)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809717);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s17 += Float.parseFloat(dayfieldvalue);
					}
					String A809717 = s17 + "";
					fieldvalues.put(fieldA809717, A809717.trim());
				}
			}

			if (row[20].getValue() != null && !"".equals(row[20].getValue())) {
				s18 = Float.parseFloat(row[20].getValue());
				String flagcharA809718 = (String) flagCharMaps.get("718");
				if (flagcharA809718 != null && !"".equals(flagcharA809718)) {
					if ("1".equals(flagcharA809718)) {
						s18 = s18 * (dayunit);
					} else if ("2".equals(flagcharA809718)) {
						s18 = s18 * (hourunit);
					} else if ("3".equals(flagcharA809718)) {
						s18 = s18 * (minuteunit);
					}
				}
				String fieldA809718 = (String) fieldMaps.get("718");
				if (fieldA809718 != null && !"".equals(fieldA809718)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809718);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s18 += Float.parseFloat(dayfieldvalue);
					}
					String A809718 = s18 + "";
					fieldvalues.put(fieldA809718, A809718.trim());
				}
			}

			if (row[21].getValue() != null && !"".equals(row[21].getValue())) {
				s19 = Float.parseFloat(row[21].getValue());
				String flagcharA809719 = (String) flagCharMaps.get("719");
				if (flagcharA809719 != null && !"".equals(flagcharA809719)) {
					if ("1".equals(flagcharA809719)) {
						s19 = s19 * (dayunit);
					} else if ("2".equals(flagcharA809719)) {
						s19 = s19 * (hourunit);
					} else if ("3".equals(flagcharA809719)) {
						s19 = s19 * (minuteunit);
					}
				}
				String fieldA809719 = (String) fieldMaps.get("719");
				if (fieldA809719 != null && !"".equals(fieldA809719)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809719);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s19 += Float.parseFloat(dayfieldvalue);
					}
					String A809719 = s19 + "";
					fieldvalues.put(fieldA809719, A809719.trim());
				}
			}

			if (row[22].getValue() != null && !"".equals(row[22].getValue())) {
				s20 = Float.parseFloat(row[22].getValue());
				String flagcharA809720 = (String) flagCharMaps.get("720");
				if (flagcharA809720 != null && !"".equals(flagcharA809720)) {
					if ("1".equals(flagcharA809720)) {
						s20 = s20 * (dayunit);
					} else if ("2".equals(flagcharA809720)) {
						s20 = s20 * (hourunit);
					} else if ("3".equals(flagcharA809720)) {
						s20 = s20 * (minuteunit);
					}
				}
				String fieldA809720 = (String) fieldMaps.get("720");
				if (fieldA809720 != null && !"".equals(fieldA809720)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809720);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s20 += Float.parseFloat(dayfieldvalue);
					}
					String A809720 = s20 + "";
					fieldvalues.put(fieldA809720, A809720.trim());
				}
			}

			if (row[23].getValue() != null && !"".equals(row[23].getValue())) {
				s21 = Float.parseFloat(row[23].getValue());
				String flagcharA809721 = (String) flagCharMaps.get("721");
				if (flagcharA809721 != null && !"".equals(flagcharA809721)) {
					if ("1".equals(flagcharA809721)) {
						s21 = s21 * (dayunit);
					} else if ("2".equals(flagcharA809721)) {
						s21 = s21 * (hourunit);
					} else if ("3".equals(flagcharA809721)) {
						s21 = s21 * (minuteunit);
					}
				}
				String fieldA809721 = (String) fieldMaps.get("721");
				if (fieldA809721 != null && !"".equals(fieldA809721)) {
					String dayfieldvalue = (String) fieldvalues
							.get(fieldA809721);
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						s21 += Float.parseFloat(dayfieldvalue);
					}
					String A809721 = s21 + "";
					fieldvalues.put(fieldA809721, A809721.trim());
				}
			}

			StringBuffer fieldkeynames =new StringBuffer( "id,SUBID,A809000,A809700");
			StringBuffer fieldvaluenames =new StringBuffer( "'" + id + "','"
					+ SequenceGenerator.getKeyId("A809") + "','" + A809000
					+ "','" + day + "'");
			Iterator it = fieldvalues.keySet().iterator();
            String keyname=null;
            String valuename=null;
			while (it.hasNext()) {
				keyname = (String) it.next();
				valuename = (String) fieldvalues.get(keyname);
				fieldkeynames.append( "," + keyname);
				fieldvaluenames.append( ",'" + valuename + "'");
			}
			sqls[i] = "insert into a809(" + fieldkeynames + ") values("
					+ fieldvaluenames + ")";

		}
        long endtime1=System.currentTimeMillis();
         System.out.println("计算时间1："+(endtime1-begintime1)/1000);
		if (sqls != null && sqls.length > 0) {
			activeapi.batchExecuteSql(sqls);
		}
		String caledroptableflaCountTable = "drop table " + flaCountTable;
		activeapi.executeSql(caledroptableflaCountTable);
         long endtime=System.currentTimeMillis();
         System.out.println("计算时间2："+(endtime-endtime1)/1000);
		if (isMon) {
			calemonthdata(flagcharlists, orgId, yearValueCale, monthValueCale,
					calebeginTime, caleendTime);
			caleyeardata(flagcharlists, orgId, yearValueCale, monthValueCale);
		}
         long endtime2=System.currentTimeMillis();
         System.out.println("计算时间3："+(endtime2-endtime)/1000);
		return "";
	}

	/**
	 *功能：是拼写月汇总临时表中的字段
	 * 
	 * @param flagcharlists
	 * @param orgId
	 * @param yearValueCale
	 * @param monthValueCale
	 * @param calebeginTime
	 * @param caleendTime
	 * @return
	 * @throws Exception
	 */
	public String calemonthdata(List flagcharlists, String orgId,
			String yearValueCale, String monthValueCale, String calebeginTime,
			String caleendTime) throws Exception {
		HashMap fieldMaps = new HashMap();
        AttItemSetDetailBO  attitemsetdetailbo=null;
        String dayfieldvalue=null;
        String monthfieldvalues=null;
		if (flagcharlists != null && flagcharlists.size() > 0) {
			for (int w = 0; w < flagcharlists.size(); w++) {
				 attitemsetdetailbo = (AttItemSetDetailBO) flagcharlists
						.get(w);
				if (!"-1".equals(attitemsetdetailbo.getDayField())
						&& !"-1".equals(attitemsetdetailbo.getMonthField())) {
					dayfieldvalue = (String) fieldMaps
							.get(attitemsetdetailbo.getMonthField());
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						if (!dayfieldvalue.equals(attitemsetdetailbo
								.getDayField())) {
						    monthfieldvalues = dayfieldvalue;
							monthfieldvalues += "+sum(cast("
									+ attitemsetdetailbo.getDayField()
									+ " as float))";
							fieldMaps.put(attitemsetdetailbo.getMonthField(),
									monthfieldvalues);
						} else {
							monthfieldvalues = "sum(cast("
									+ dayfieldvalue + " as float))";
							fieldMaps.put(attitemsetdetailbo.getMonthField(),
									monthfieldvalues);
						}
					} else {
						 monthfieldvalues = "sum(cast("
								+ attitemsetdetailbo.getDayField()
								+ " as float))";
						fieldMaps.put(attitemsetdetailbo.getMonthField(),
								monthfieldvalues);
					}
				}
			}
		}

		String flaCountTable = "hr319#_A810_"
				+ CommonFuns.getSysDate("yyyyMMddHHss");
		if ("ORACLE".equals(Constants.DB_TYPE)) {
			StringBuffer fieldkeynames =new StringBuffer("id,A810000,A810701,A810702");
			StringBuffer fieldvaluenames = new StringBuffer("id,A809000,cast(sum(cast(A809701 as float)) as varchar2(100)),cast(sum(cast(A809702 as float)) as varchar2(100))");
			Iterator it = fieldMaps.keySet().iterator();
            String keynamemonth=null;
            String valuenamemonth=null;
			while (it.hasNext()) {
				keynamemonth = (String) it.next();
				valuenamemonth = (String) fieldMaps.get(keynamemonth);
				fieldkeynames .append( "," + keynamemonth);
				fieldvaluenames.append( ",cast((" + valuenamemonth
						+ ") as varchar2(100))");
			}
			caleoracletable(fieldkeynames.toString(), fieldvaluenames.toString(), flaCountTable,
					orgId, calebeginTime, caleendTime);
		} else {
			StringBuffer fieldkeynames =new StringBuffer("id,A809000 as A810000,cast(sum(cast(A809701 as float)) as nvarchar(100)) as  A810701,cast(sum(cast(A809702 as float)) as nvarchar(100)) as  A810702");
			Iterator it = fieldMaps.keySet().iterator();
            String keynamemonth=null;
            String valuenamemonth=null;
			while (it.hasNext()) {
				keynamemonth = (String) it.next();
				valuenamemonth = (String) fieldMaps.get(keynamemonth);
				fieldkeynames .append( ",cast((" + valuenamemonth
						+ ")  as nvarchar(100)) as " + keynamemonth);
			}
			caleoracletablesql(fieldkeynames.toString(), flaCountTable, orgId,
					calebeginTime, caleendTime);
		}

		String month = yearValueCale + "-" + monthValueCale;
		caledeleteA810(flaCountTable, month);
		calemonthdatamethod(flaCountTable, fieldMaps, month, calebeginTime,
				caleendTime, orgId);
		return "";
	}

	public void caleoracletablesql(String fieldkeynames, String flaCountTable,
			String orgId, String calebeginTime, String caleendTime)
			throws Exception {
		StringBuffer sql =new StringBuffer( "select " + fieldkeynames + " into  " + flaCountTable);
		sql.append( "  from   A809 where ID in (select ID from A001 where A001701='"
				+ orgId + "' or A001705='" + orgId + "') and A809700>='"
				+ calebeginTime + "' and A809700<='" + caleendTime + "' ");
		sql.append( " group by ID,A809000");
		activeapi.executeSql(sql.toString());
	}

	public void caleoracletable(String fieldkeynames, String fieldvaluenames,
			String flaCountTable, String orgId, String calebeginTime,
			String caleendTime) throws Exception {
		StringBuffer sql =new StringBuffer( "create table " + flaCountTable + "(" + fieldkeynames
				+ ") ");
		sql.append( "as select " + fieldvaluenames);
		sql.append( "  from   A809 where ID in (select ID from A001 where A001701='"
				+ orgId + "' or A001705='" + orgId + "') and A809700>='"
				+ calebeginTime + "' and A809700<='" + caleendTime + "' ");
		sql.append( " group by ID,A809000");
		activeapi.executeSql(sql.toString());
	}

	public void caledeleteA810(String flaCountTable, String month)
			throws Exception {
		String sql = "delete from A810 where ID in (select ID from "
				+ flaCountTable + ")";
		sql += " and A810700='" + month + "'";
		activeapi.executeSql(sql);
	}

	/**
	 * 功能：进行月汇总计算 关键：是处理动态汇总字段的方法
	 * 
	 * @param flaCountTable
	 * @param fieldMaps
	 * @param month
	 * @return
	 * @throws Exception
	 */
	public String calemonthdatamethod(String flaCountTable, HashMap fieldMaps,
			String month, String calebeginTime, String caleendTime, String orgId)
			throws Exception {
		String price = "2";
		int price1 = Integer.parseInt(price);
		String[] keyvalues = new String[fieldMaps.size()];
		Iterator it = fieldMaps.keySet().iterator();
		int i = 0;
        String keynamemonth=null;
		while (it.hasNext()) {
			 keynamemonth = (String) it.next();
			keyvalues[i] = keynamemonth;
			i++;
		}
		StringBuffer sql = new StringBuffer("select id,A810701,A810702");
		for (int j = 0; j < keyvalues.length; j++) {
			sql .append( "," + keyvalues[j]);
		}
		sql .append( " from " + flaCountTable);
		CellVO[] head = new CellVO[keyvalues.length + 3];
		head[0] = new CellVO();
		head[0].setItemId("id");
		head[1] = new CellVO();
		head[1].setItemId("A810701");
		head[2] = new CellVO();
		head[2].setItemId("A810702");

		for (int j = 0; j < keyvalues.length; j++) {
			head[j + 3] = new CellVO();
			head[j + 3].setItemId(keyvalues[j]);
		}

		Vector rs = activeapi.getDataListBySql(head, sql.toString());
		String[] sqls = new String[rs.size()];
        HashMap fieldvalues=null;
        String id=null;
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		for (int x = 0; x < rs.size(); x++) {
			CellVO[] row = (CellVO[]) rs.get(x);
			fieldvalues = new HashMap();
			id = row[0].getValue(); // 人员ID
			float s1 = 0;
			float s2 = 0;
			float s3 = 0;
			float s16 = 0;
			float s17 = 0;
			if (row[1].getValue() != null && !"".equals(row[1].getValue())) {
				s1 = Float.parseFloat(row[1].getValue());
				String A810701 = s1 + "";
				fieldvalues.put("A810701", A810701.trim());
			}
			if (row[2].getValue() != null && !"".equals(row[2].getValue())) {
				s2 = Float.parseFloat(row[2].getValue());
				String A810702 = s2 + "";
				fieldvalues.put("A810702", A810702.trim());
			}

			float attenceRate = new BigDecimal(s2 * 100).divide(
					new BigDecimal(s1), price1, BigDecimal.ROUND_HALF_UP)
					.floatValue();
			String A810703 = attenceRate + "";
			fieldvalues.put("A810703", A810703.trim());

			for (int j = 0; j < keyvalues.length; j++) {
				if (row[j + 3].getValue() != null
						&& !"".equals(row[j + 3].getValue())) {
					s3 = Float.parseFloat(row[j + 3].getValue());
				}
				String A810704 = s3 + "";
				fieldvalues.put(keyvalues[j], A810704.trim());
				s3 = 0;
			}

			String A810791 = ""; // 变动前应出勤
			String beginShouldTimes = monthbeginShouldTime020(id);
			if (beginShouldTimes != null && !"".equals(beginShouldTimes)) {
				try {
					Date date1 = df.parse(calebeginTime);
					Date date2 = df.parse(caleendTime);
					Date date3 = df.parse(beginShouldTimes);
					if (date3.getTime() <= date1.getTime()) {
						s17 = s1;
						s16 = 0;
						// s16转正后值
					}
					if (date3.getTime() >= date1.getTime()
							&& date3.getTime() <= date2.getTime()) {
						A810791 = monthbeginShouldTime(id, calebeginTime,
								beginShouldTimes);
						if (A810791 != null && !"".equals(A810791)) {
							s16 = Float.parseFloat(A810791);
							s17 = s1 - s16;
						}
					}
					if (date3.getTime() >= date2.getTime()) {
						s17 = 0;
						s16 = s1;
						// s17转正前值
					}

				} catch (Exception e) {

				}
			} else {
				s16 = 0;
				s17 = 0;
			}
			String A810792 = s17 + "";
			StringBuffer fieldkeynames =new StringBuffer( "id,SUBID,A810000,A810700,A810791,A810792");
			StringBuffer fieldvaluenames =new StringBuffer( "'" + id + "','"
					+ SequenceGenerator.getKeyId("A810") + "','" + Constants.NO
					+ "','" + month + "','" + A810791 + "','" + A810792 + "'");
			Iterator its = fieldvalues.keySet().iterator();
            String keyname=null;
            String valuename=null;
			while (its.hasNext()) {
				keyname = (String) its.next();
				valuename = (String) fieldvalues.get(keyname);
				fieldkeynames .append( "," + keyname);
				fieldvaluenames .append( ",'" + valuename + "'");
			}
			sqls[x] = "insert into a810(" + fieldkeynames + ") values("
					+ fieldvaluenames + ")";
			// 计算存休
			String argmentvlaue = caclFeast(month, orgId);
			String[] argmentvalues = argmentvlaue.split(",");
			int sum1 = Integer.parseInt(argmentvalues[0].trim());// 当月节假日天数
			int sum2 = 6; // 当月休息天数
			int sum3 = Integer.parseInt(argmentvalues[1].trim()); // 当月天数
			int sum = sum3 - sum2 - sum1;
			caclRest(id, month, s2, sum);
		}

		if (sqls != null && sqls.length > 0) {
			activeapi.batchExecuteSql(sqls);
		}

		String caledroptableflaCountTable = "drop table " + flaCountTable;
		activeapi.executeSql(caledroptableflaCountTable);

		return "";
	}

	public String caclFeast(String durayearmonth, String orgId)
			throws SysException {
		String argmentvalue = "";
		int sum = 0;
		String duraYearMonth = durayearmonth.trim();
		Calendar c = Calendar.getInstance();
		String[] duraYearMonthStr = duraYearMonth.split("-");
		int yearvalue = Integer.parseInt(duraYearMonthStr[0]);
		int monthvalue = Integer.parseInt(duraYearMonthStr[1]);
		c.set(yearvalue, monthvalue - 1, 1);
		int maxdayvalue = c.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		List lists = getAllAttFeast(orgId);
		List lists1 = getAllAttFeast("-1");
		for (int p = 1; p <= maxdayvalue; p++) {
			String day = durayearmonth.trim();
			if (p < 10) {
				day = day + "-0" + p;
			} else {
				day = day + "-" + p;
			}
			String aDates = day.substring(5, 10);
			
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
		argmentvalue = sum + "," + maxdayvalue;
		return argmentvalue;
	}

	public void caclRest(String id, String durayearmonth, float f, int sum)
			throws SysException {
		String beginMonthValue = "";
		String endMonthValue = findEndMonthValue(id, durayearmonth);
		if (endMonthValue != null && !"".equals(endMonthValue)) {
			beginMonthValue = endMonthValue;
		} else {
			beginMonthValue = "0";
		}
		float monthAdd = 0;
		float monthRemove = 0;
		float personRealWorks = f;
		float sumfloat = (float) sum;
		float flag = 0;
		flag = personRealWorks - sumfloat;
		if (flag > 0) {
			monthAdd = flag;
		} else {
			monthRemove = Math.abs(flag);
		}
		float beginMonthValueInt = Float.parseFloat(beginMonthValue);
		float s = beginMonthValueInt + monthAdd - monthRemove;// 计算结果
		updateA812(id, durayearmonth);
		deleteEndMonthValue(id, durayearmonth);
		String s1 = beginMonthValueInt + "";
		String s2 = monthAdd + "";
		String s3 = monthRemove + "";
		String s4 = s + "";
		AttExistRestBO attexistrestbo = new AttExistRestBO();
		attexistrestbo.setPersonId(id);
		attexistrestbo.setSubID(SequenceGenerator.getKeyId("A812"));
		attexistrestbo.setRecord(Constants.YES);
		attexistrestbo.setAttenceDay(durayearmonth);
		attexistrestbo.setBeginMonthValue(s1.trim());
		attexistrestbo.setMonthAdd(s2.trim());
		attexistrestbo.setMonthRemove(s3.trim());
		attexistrestbo.setEndMonthValue(s4.trim());
		saveorupdateAttExistRestBO(attexistrestbo);
	}

	public String findEndMonthValue(String personId, String day)
			throws SysException {
		String sql = "select A812704 from A812 where ID='" + personId
				+ "' and A812700='" + day + "' and A812000='00901'";
		return activeapi.queryForString(sql);
	}

	public void updateA812(String personId, String day) throws SysException {
		String sql = "update A812 set A812000='00900' where ID='" + personId
				+ "' and A812700='" + day + "' and A812000='00901'";
		activeapi.executeSql(sql);
	}

	public void deleteEndMonthValue(String id, String day) throws SysException {
		String sql = "delete from A812 where ID='" + id + "' and A812700='"
				+ day + "' and A812000='00901'";
		activeapi.executeSql(sql);
	}

	public void saveorupdateAttExistRestBO(AttExistRestBO bo)
			throws SysException {
		attenceSetDAO.createBo(bo);
	}

	/**
	 * 功能：是拼写年汇总临时表中的字段
	 * 
	 * @param flagcharlists
	 * @param orgId
	 * @param yearValueCale
	 * @param monthValueCale
	 * @return
	 * @throws Exception
	 */
	public String caleyeardata(List flagcharlists, String orgId,
			String yearValueCale, String monthValueCale) throws Exception {
		HashMap fieldMaps = new HashMap();
		if (flagcharlists != null && flagcharlists.size() > 0) {
			for (int w = 0; w < flagcharlists.size(); w++) {
				AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) flagcharlists
						.get(w);
				if (!"-1".equals(attitemsetdetailbo.getMonthField())
						&& !"-1".equals(attitemsetdetailbo.getYearField())) {
					String dayfieldvalue = (String) fieldMaps
							.get(attitemsetdetailbo.getYearField());
					if (dayfieldvalue != null && !"".equals(dayfieldvalue)) {
						if (!dayfieldvalue.equals(attitemsetdetailbo
								.getMonthField())) {
							String yearfieldvalues = dayfieldvalue;
							yearfieldvalues += "+sum(cast("
									+ attitemsetdetailbo.getMonthField()
									+ " as float))";
							fieldMaps.put(attitemsetdetailbo.getYearField(),
									yearfieldvalues);
						} else {
							String yearfieldvalues = "sum(cast("
									+ dayfieldvalue + " as float))";
							fieldMaps.put(attitemsetdetailbo.getYearField(),
									yearfieldvalues);
						}
					} else {
						String yearfieldvalues = "sum(cast("
								+ attitemsetdetailbo.getMonthField()
								+ " as float))";
						fieldMaps.put(attitemsetdetailbo.getYearField(),
								yearfieldvalues);
					}
				}
			}
		}

		String flaCountTable = "hr319#_A811_"
				+ CommonFuns.getSysDate("yyyyMMddHHss");
		if ("ORACLE".equals(Constants.DB_TYPE)) {
			String fieldkeynames = "id,A811000,A811701,A811702";
			String fieldvaluenames = "id,A810000,cast(sum(cast(A810701 as float)) as varchar2(100)),cast(sum(cast(A810702 as float)) as varchar2(100))";
			Iterator it = fieldMaps.keySet().iterator();
			while (it.hasNext()) {
				String keynamemonth = (String) it.next();
				String valuenamemonth = (String) fieldMaps.get(keynamemonth);
				fieldkeynames += "," + keynamemonth;
				fieldvaluenames += ",cast((" + valuenamemonth
						+ ") as varchar2(100))";
			}
			calesqlservertable(fieldkeynames, fieldvaluenames, flaCountTable,
					orgId, yearValueCale);
		} else {
			String fieldkeynames = "id,A810000 as A811000,cast(sum(cast(A810701 as float)) as nvarchar(100)) as  A811701,cast(sum(cast(A810702 as float)) as nvarchar(100)) as  A811702";
			Iterator it = fieldMaps.keySet().iterator();
			while (it.hasNext()) {
				String keynamemonth = (String) it.next();
				String valuenamemonth = (String) fieldMaps.get(keynamemonth);
				fieldkeynames += ",cast((" + valuenamemonth
						+ ")  as nvarchar(100)) as " + keynamemonth;
			}
			calesqlservertablesql(fieldkeynames, flaCountTable, orgId,
					yearValueCale);
		}

		caledeleteA811(flaCountTable, yearValueCale);
		caleyeardatamethod(flaCountTable, fieldMaps, yearValueCale);
		return "";
	}

	public void calesqlservertablesql(String fieldkeynames,
			String flaCountTable, String orgId, String yearValueCale)
			throws Exception {
		String sql = "select " + fieldkeynames + " into  " + flaCountTable;
		sql += "  from   A810 where ID in (select ID from A001 where A001701='"
				+ orgId + "' or A001705='" + orgId + "') and A810700 like '"
				+ yearValueCale + "%'";
		sql += " group by ID,A810000";
		activeapi.executeSql(sql);
	}

	public void calesqlservertable(String fieldkeynames,
			String fieldvaluenames, String flaCountTable, String orgId,
			String yearValueCale) throws Exception {
		String sql = "create table " + flaCountTable + "(" + fieldkeynames
				+ ") ";
		sql += "as select " + fieldvaluenames;
		sql += "  from   A810 where ID in (select ID from A001 where A001701='"
				+ orgId + "' or A001705='" + orgId + "') and A810700 like '"
				+ yearValueCale + "%'";
		sql += " group by ID,A810000,A810700";
		activeapi.executeSql(sql);
	}

	public void caledeleteA811(String flaCountTable, String yearValueCale)
			throws Exception {
		String sql = "delete from A811 where ID in (select ID from "
				+ flaCountTable + ")";
		sql += " and A811700='" + yearValueCale + "'";
		activeapi.executeSql(sql);
	}

	/**
	 * 功能：进行年汇总计算 关键：是处理动态汇总字段的方法
	 * 
	 * @param flaCountTable
	 * @param fieldMaps
	 * @param year
	 * @return
	 * @throws Exception
	 */
	public String caleyeardatamethod(String flaCountTable, HashMap fieldMaps,
			String year) throws Exception {
		String price = "2";
		int price1 = Integer.parseInt(price);
		String[] keyvalues = new String[fieldMaps.size()];
		Iterator it = fieldMaps.keySet().iterator();
		int i = 0;
		while (it.hasNext()) {
			String keynamemonth = (String) it.next();
			keyvalues[i] = keynamemonth;
			i++;
		}
		String sql = "select id,A811701,A811702";
		for (int j = 0; j < keyvalues.length; j++) {
			sql += "," + keyvalues[j];
		}
		sql += " from " + flaCountTable;
		CellVO[] head = new CellVO[keyvalues.length + 3];
		head[0] = new CellVO();
		head[0].setItemId("id");
		head[1] = new CellVO();
		head[1].setItemId("A811701");
		head[2] = new CellVO();
		head[2].setItemId("A811702");
		for (int j = 0; j < keyvalues.length; j++) {
			head[j + 3] = new CellVO();
			head[j + 3].setItemId(keyvalues[j]);
		}

		Vector rs = activeapi.getDataListBySql(head, sql);
		String[] sqls = new String[rs.size()];
		for (int x = 0; x < rs.size(); x++) {
			CellVO[] row = (CellVO[]) rs.get(x);
			HashMap fieldvalues = new HashMap();
			String id = row[0].getValue(); // 人员ID
			float s1 = 0;
			float s2 = 0;
			float s3 = 0;
			if (row[1].getValue() != null && !"".equals(row[1].getValue())) {
				s1 = Float.parseFloat(row[1].getValue());
				String A811701 = s1 + "";
				fieldvalues.put("A811701", A811701.trim());
			}
			if (row[2].getValue() != null && !"".equals(row[2].getValue())) {
				s2 = Float.parseFloat(row[2].getValue());
				String A811702 = s2 + "";
				fieldvalues.put("A811702", A811702.trim());
			}
			float attenceRate=0;
			if(s1!=0){
				attenceRate= new BigDecimal(s2 * 100).divide(
						new BigDecimal(s1), price1, BigDecimal.ROUND_HALF_UP)
						.floatValue();
			}
			String A811703 = attenceRate + "";
			fieldvalues.put("A811703", A811703.trim());
			for (int j = 0; j < keyvalues.length; j++) {
				if (row[j + 3].getValue() != null
						&& !"".equals(row[j + 3].getValue())) {
					s3 = Float.parseFloat(row[j + 3].getValue());
				}
				String A811704 = s3 + "";
				fieldvalues.put(keyvalues[j], A811704.trim());
				s3 = 0;
			}

			String fieldkeynames = "id,SUBID,A811000,A811700";
			String fieldvaluenames = "'" + id + "','"
					+ SequenceGenerator.getKeyId("A811") + "','"
					+ Constants.YES + "','" + year + "'";
			Iterator its = fieldvalues.keySet().iterator();
			while (its.hasNext()) {
				String keyname = (String) its.next();
				String valuename = (String) fieldvalues.get(keyname);
				fieldkeynames += "," + keyname;
				fieldvaluenames += ",'" + valuename + "'";
			}
			sqls[x] = "insert into a811(" + fieldkeynames + ") values("
					+ fieldvaluenames + ")";

		}

		if (sqls != null && sqls.length > 0) {
			activeapi.batchExecuteSql(sqls);
		}

		String caledroptableflaCountTable = "drop table " + flaCountTable;
		activeapi.executeSql(caledroptableflaCountTable);
		return "";
	}
	
	public List getAllAttClassDetailBO1(String classId)throws SysException{
		return this.attenceSetDAO.getAllAttClassDetailBO1(classId);
	}
}
