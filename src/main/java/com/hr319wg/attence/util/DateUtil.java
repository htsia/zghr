package com.hr319wg.attence.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.hr319wg.attence.dao.AttFeastDAO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttFeastBO;
import com.hr319wg.attence.pojo.bo.AttRestOfWeekBO;
import com.hr319wg.attence.pojo.bo.AttWorkDateBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

/**
 * Created by IntelliJ IDEA. User: 郝威 Date: 11-12-29 Time: 上午8:27 To change this
 * template use File | Settings | File Templates.
 */
public class DateUtil {

	/**
	 * 只返回单位
	 * 
	 * @return
	 */
	public static List<OrgBO> getUnitList() {
		List<OrgBO> list = SysCacheTool.querySubObject(SysCache.OBJ_UNIT, null,
				"-1");
		return SysCacheTool.querySubObject(SysCache.OBJ_UNIT, null, list.get(0)
				.getOrgId());
	}

	/**
	 * 返回下一天(yyyy-MM-dd)
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String getNextDate(String date) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date d;
		try {
			d = df.parse(date);
			Calendar c = Calendar.getInstance();
			c.setTime(d);
			c.add(Calendar.DAY_OF_MONTH, 1);
			int month = c.get(Calendar.MONTH)+1;
			return c.get(Calendar.YEAR)+"-"+(month<10?"0"+month:month)+"-"+c.get(Calendar.DAY_OF_MONTH);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	/**
	 * 根据星期返回对应天的list
	 * 
	 * @param week
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public static List getDayByWeek(String week, String duraBeginDate,
			String duraEndDate, String applyBeginDate, String applyEndDate) {
		String[] weeks = week.split(",");
		List list = new ArrayList();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat df2 = new SimpleDateFormat("MM-dd");
		try {
			Date duraBegin = df.parse(duraBeginDate);
			Date duraEnd = df.parse(duraEndDate);
			int year = Integer.valueOf(duraBeginDate.substring(0, 4));

			Date applyBegin = df2.parse(applyBeginDate);
			Date applyEnd = df2.parse(applyEndDate);
			if (applyEnd.before(applyEnd)) {
				applyEnd = df.parse((year + 1) + "-" + applyEndDate);
			} else {
				applyEnd = df.parse(year + "-" + applyEndDate);
			}
			applyBegin = df.parse(year + "-" + applyBeginDate);

			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();
			c1.setTime(duraBegin);
			c2.setTime(duraEnd);
			do {
				Calendar c3 = (Calendar) c1.clone();
				for (int i = 0; i < weeks.length; i++) {
					int day = c3.get(Calendar.DAY_OF_WEEK);
					if (day == 1) {
						day = 7;
					} else {
						day--;
					}
					if ((day + "").equals(weeks[i])
							&& c3.getTimeInMillis() >= applyBegin.getTime()
							&& c3.getTimeInMillis() <= applyEnd.getTime()) {
						list.add(df.format(c3.getTime()));
					}
				}
				c1.add(Calendar.DAY_OF_MONTH, 1);
			} while (!c1.after(c2));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 两个日期间的天集合
	 * 
	 * @param dayTxt
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws ParseException
	 */
	public static List getDayByDayTxt(String dayTxt, String beginDate,
			String endDate) throws ParseException {
		if(dayTxt==null||"".equals(dayTxt)){
			return new ArrayList();
		}
		String[] freTxt = dayTxt.split(",");
		List list = new ArrayList();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date begin = df.parse(beginDate);
		Date end = df.parse(endDate);
		for (int i = 0; i < freTxt.length; i++) {
			Date curr = df.parse(freTxt[i]);
			if (curr.getTime() >= begin.getTime()
					&& curr.getTime() <= end.getTime()) {
				list.add(freTxt[i]);
			}
		}
		return list;
	}

	/**
	 * 获得指定日期的前一天
	 * 
	 * @param specifiedDay
	 * @return
	 */
	public static String getSpecifiedDayBefore(String specifiedDay) {
		Calendar c = Calendar.getInstance();
		Date date = null;
		try {
			date = new SimpleDateFormat("yy-MM-dd").parse(specifiedDay);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		c.setTime(date);
		int day = c.get(Calendar.DATE);
		c.set(Calendar.DATE, day - 1);

		String dayBefore = new SimpleDateFormat("yyyy-MM-dd").format(c
				.getTime());
		return dayBefore;
	}

	/**
	 * 获得指定日期的后一天
	 * 
	 * @param specifiedDay
	 * @return
	 */
	public static String getSpecifiedDayAfter(String specifiedDay) {
		Calendar c = Calendar.getInstance();
		Date date = null;
		try {
			date = new SimpleDateFormat("yy-MM-dd").parse(specifiedDay);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		c.setTime(date);
		int day = c.get(Calendar.DATE);
		c.set(Calendar.DATE, day + 1);

		String dayAfter = new SimpleDateFormat("yyyy-MM-dd")
				.format(c.getTime());
		return dayAfter;
	}
//统计当月最后一共几天
	public static String getEndDayByMonth(String datevalue) {
		int year = Integer.parseInt(datevalue.substring(0, 4));
		String month = datevalue.substring(5, 7);
		boolean isLeap = false;// 是平年
		if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
			isLeap = true;
		}
		if (month.equals("01") || month.equals("03") || month.equals("05")
				|| month.equals("07") || month.equals("08")
				|| month.equals("10") || month.equals("12")) {
			return "31";
		} else if (month.equals("02")) {
			if (isLeap) {
				return "29";
			} else {
				return "28";
			}
		} else {
			return "30";
		}
	}

	public static String getDayByDate(String specifiedDay) {
		Calendar c = Calendar.getInstance();
		Date date = null;
		try {
			date = new SimpleDateFormat("yy-MM-dd").parse(specifiedDay);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		c.setTime(date);
		int day = c.get(Calendar.DAY_OF_WEEK);
		if (day == 0) {
			return "7";
		} else {
			return String.valueOf(day - 1);
		}

	}

	/**
	 * 得到两个日期间的天数
	 * 
	 * @param begin
	 * @param end
	 * @return
	 */
	public static long getBetweenDays(String begin, String end) {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date beginDate = df.parse(begin);
			Date endDate = df.parse(end);
			return (endDate.getTime() - beginDate.getTime()) / 1000 / 60 / 60
					/ 24;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * 返回两个日期间的所有日期的list
	 * 
	 * @param begin
	 * @param end
	 * @return
	 */
	public static List getAllBetweenDates(String begin, String end) {
		List result = new ArrayList();
		if(begin.compareTo(end)==0){
			result.add(begin);
			return result;
		}
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date beginDate = df.parse(begin);
			Date endDate = df.parse(end);
			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();
			c1.setTime(beginDate);
			c2.setTime(endDate);
			do {
				Calendar c3 = (Calendar) c1.clone();
				result.add(df.format(c3.getTime()));
				c1.add(Calendar.DAY_OF_MONTH, 1);
			} while (!c1.after(c2));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 是否节假日
	 * 
	 * @param day
	 *            当天
	 * @param feastList
	 * @param restOfWeekBo
	 * @param workDateList
	 * @return
	 * @throws SysException
	 */
	public static boolean isFeast(String day, List feastList, String userID,
			ActivePageAPI api) throws SysException {
		boolean checkIs = false;
		if (feastList != null && feastList.size() > 0) {// 判断是否节假日
			for (int i = 0; i < feastList.size(); i++) {
				AttFeastBO bo = (AttFeastBO) feastList.get(i);

				String begin = bo.getBeginDate();
				String end = bo.getEndDate();
				DateFormat df = new SimpleDateFormat("MM-dd");
				if (bo.getYear().equals("0")) {// 每年
					df = new SimpleDateFormat("yyyy-MM-dd");
				}
				try {
					Date beginDate = df.parse(begin);
					Date endDate = df.parse(end);
					Date currDate = df.parse(day);
					Calendar c1 = Calendar.getInstance();
					Calendar c2 = Calendar.getInstance();
					Calendar c3 = Calendar.getInstance();
					c1.setTime(beginDate);
					c2.setTime(endDate);
					c3.setTime(currDate);
					if (c3.after(c1) && c3.before(c2)) {
						String[] postLeiXings = bo.getPostLeiXing().split(",");
						String sql = "select count(*) from a001 where id='"
								+ userID
								+ "' and "
								+ CommonFuns
										.splitInSql(postLeiXings, "A001218");
						int count = api.queryForInt(sql);
						if (count == 1) {
							checkIs = true;
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return checkIs;
	}

	/**
	 * 是否公休日调休日
	 * 
	 * @param day
	 *            当天
	 * @param feastList
	 * @param restOfWeekBo
	 * @param workDateList
	 * @return
	 * @throws SysException
	 */
	public static boolean isCommonLeave(String day,
			AttRestOfWeekBO restOfWeekBo, List workDateList)
			throws SysException {
		boolean checkIs = false;

		if (workDateList != null && workDateList.size() > 0) {
			for (int i = 0; i < workDateList.size(); i++) {
				AttWorkDateBO bo = (AttWorkDateBO) workDateList.get(i);
				if (bo.getWorkDate() != null && bo.getWorkDate().equals(day)) {
					checkIs = true;
				}
			}
		}

		String days = DateUtil.getDayByDate(day);
		if (restOfWeekBo != null) {
			if (days.equals("1")) {
				if (restOfWeekBo.getMon().equals("0")) {
					checkIs = true;
				}
			}

			if (days.equals("2")) {
				if (restOfWeekBo.getTues().equals("0")) {
					checkIs = true;
				}
			}

			if (days.equals("3")) {
				if (restOfWeekBo.getWed().equals("0")) {
					checkIs = true;
				}
			}

			if (days.equals("4")) {
				if (restOfWeekBo.getThur().equals("0")) {
					checkIs = true;
				}
			}

			if (days.equals("5")) {
				if (restOfWeekBo.getFri().equals("0")) {
					checkIs = true;
				}
			}

			if (days.equals("6")) {
				if (restOfWeekBo.getSat().equals("0")) {
					checkIs = true;
				}
			}

			if (days.equals("0")) {
				if (restOfWeekBo.getSun().equals("0")) {
					checkIs = true;
				}
			}
		}
		return checkIs;
	}

	/**
	 * 计算两个日期之间的公休日
	 * 
	 * @param commonRestDaySet
	 *            公休日设置，为一个字符串:"1,1,1,1,1,0,0"表示周六周日公休
	 * @param beginDate
	 *            格式yyyy-MM-dd
	 * @param endDate
	 * @return
	 */
	public static List getAllCommonRestDay(String commonRestDaySet,
			String beginDate, String endDate) {
		String[] weeks = commonRestDaySet.split(",");
		List list = new ArrayList();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date begin = df.parse(beginDate);
			Date end = df.parse(endDate);

			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();
			c1.setTime(begin);
			c2.setTime(end);
			do {
				Calendar c3 = (Calendar) c1.clone();
				int day = c3.get(Calendar.DAY_OF_WEEK);
				if (day == 1) {
					day = 7;
				} else {
					day--;
				}
				if ("0".equals(weeks[day - 1])) {
					list.add(df.format(c3.getTime()));
				}

				c1.add(Calendar.DAY_OF_MONTH, 1);
			} while (!c1.after(c2));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * @param thisMonth 格式是XXXX-XX
	 * @return
	 */
	public static String getNextMonth(String thisMonth){
		String nextYear="";
		String nextMonth="";
		int year=Integer.parseInt(thisMonth.substring(0,4));
		int month=Integer.parseInt(thisMonth.substring(5,7));
	    if(month==12){
	    	nextYear=String.valueOf(year+1);
	    	nextMonth="01";
	    }else{
	    	nextYear=String.valueOf(year);
	    	month++;
	    	if(month<10){
	    		nextMonth="0"+month;
	    	}else{
	    		nextMonth=""+month;
	    	}
	    }
		return nextYear+"-"+nextMonth;
	}
}
