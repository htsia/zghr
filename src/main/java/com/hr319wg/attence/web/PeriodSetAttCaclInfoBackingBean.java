package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;
import com.hr319wg.attence.pojo.bo.AttCaclInfoBO;
import com.hr319wg.attence.pojo.bo.AttDurationBO;
import com.hr319wg.attence.pojo.bo.AttItemSetDetailBO;
import com.hr319wg.attence.ucc.IAttDataCaclUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class PeriodSetAttCaclInfoBackingBean extends BaseBackingBean {
	private String perIdsValue ="";
	private String perIdsValueName = "";
	private String cacltime=CommonFuns.getSysDate("yyyy-MM-dd");
	private boolean isExist = false;
	private String personName = super.getUserInfo().getName();
	private String beginTime1;
	private String endTime1;
	private String beginTime;
	private String endTime;
	private boolean isMon = false;
	private String orgID=super.getUserInfo().getOrgId();
	private List persBos1;
	private String monthPageInit;
	private List persBos;
	private String superName;
	private String attenceDate;
	private String personId;
	private String dayPageInit;
	private List itemList;
	private String duraID;
	private String duraIDS;
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;
	private static String dayvalues = "168";
    private String backFlag="1";
    private String flag="1";
    private String personType;
    private String personTypeValue;
    private String name;
    private String personList;
    private String personList1;
    private IPersonUCC personucc;

    private IAttDataCaclUCC attDataCaclUcc;

    public IAttDataCaclUCC getAttDataCaclUcc() {
        return attDataCaclUcc;
    }

    public void setAttDataCaclUcc(IAttDataCaclUCC attDataCaclUcc) {
        this.attDataCaclUcc = attDataCaclUcc;
    }

    public String getPerIdsValue() {
		return perIdsValue;
	}

	public void setPerIdsValue(String perIdsValue) {
		this.perIdsValue = perIdsValue;
	}

	public String getPerIdsValueName() {
		return perIdsValueName;
	}

	public void setPerIdsValueName(String perIdsValueName) {
		this.perIdsValueName = perIdsValueName;
	}

	public String getCacltime() {
		return cacltime;
	}

	public void setCacltime(String cacltime) {
		this.cacltime = cacltime;
	}

	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}
    
	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getBeginTime1() {
		return beginTime1;
	}

	public void setBeginTime1(String beginTime1) {
		this.beginTime1 = beginTime1;
	}

	public String getEndTime1() {
		return endTime1;
	}

	public void setEndTime1(String endTime1) {
		this.endTime1 = endTime1;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public boolean getIsMon() {
		return isMon;
	}

	public void setIsMon(boolean isMon) {
		this.isMon = isMon;
	}
	public List getItemList() {
		return itemList;
	}

	public void setItemList(List itemList) {
		this.itemList = itemList;
	}

	public String getDuraID() {
		return duraID;
	}

	public void setDuraID(String duraID) {
		this.duraID = duraID;
	}

	public String getDuraIDS() {
		return duraIDS;
	}

	public void setDuraIDS(String duraIDS) {
		this.duraIDS = duraIDS;
	}

	public String getPageInit() {
		try{
		if(super.getRequestParameter("duraID") != null && !super.getRequestParameter("duraID").equals("") && super.getRequestParameter("beginTime") != null && !super.getRequestParameter("beginTime").equals("") && super.getRequestParameter("endTime") != null && !super.getRequestParameter("endTime").equals("")){
			duraID = super.getRequestParameter("duraID");
			beginTime1 = super.getRequestParameter("beginTime");
			endTime1 = super.getRequestParameter("endTime");
            perIdsValue="";
		}
		if(super.getRequestParameter("perIdsValue") != null && !super.getRequestParameter("perIdsValue").equals("")){
			perIdsValue = super.getRequestParameter("perIdsValue");

		}
        if(perIdsValue!=null&&!perIdsValue.equals("")){
            PersonBO person=SysCacheTool.findPersonById(perIdsValue);
			perIdsValueName=person.getName();
        }else{
            perIdsValueName="全部";
        }
		cacl1();
		doQuery();
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}
	public void doQuery() {
		try {
			itemList=attenceSetUCC.getAttCaclInfoBO(duraID);
			if(itemList!=null && itemList.size()>0){
				for(int i=0;i<itemList.size();i++){
					AttCaclInfoBO bo=(AttCaclInfoBO)itemList.get(i);
					itemList.set(i, bo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	/*
	 * 计算
	 */
	public String cacl(){
		try {
			String ids[] = getServletRequest().getParameterValues("selected_ids");
			if (ids != null) {
				List flagcharlists=attenceSetUCC.getAllAttItemSetDetailBO(orgID);
				List daylists=new ArrayList();
				 for(int i=0;i<ids.length;i++){
						daylists.add(ids[i]);
				 }
					AttDurationBO attdurationbo=attenceSetUCC.findAttenceSetBObyId(duraID);
					String yearValueCale=attdurationbo.getDuraYear();
					String monthValueCale=attdurationbo.getDuraMonth();
					String beginTime=attdurationbo.getDuraBegin();
					String endTime=attdurationbo.getDuraEnd();
				    //attenceSetUCC.calcpersongroup(orgID,daylists,flagcharlists,yearValueCale,monthValueCale,beginTime,endTime,isMon,isExist,perIdsValue);
					
                    super.showMessageDetail("汇总计算成功！");
			}else{
				 super.showMessageDetail("计算之前请选择日期！");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}


	/*
	 * 查看日汇总
	 */
	public String getDayPageInit() {
		if(super.getRequestParameter("personId") != null && !super.getRequestParameter("personId").equals("") && super.getRequestParameter("attenceDate") != null && !super.getRequestParameter("attenceDate").equals("") && super.getRequestParameter("duraID") != null && !super.getRequestParameter("duraID").equals("")){
			personId = super.getRequestParameter("personId");
			attenceDate = super.getRequestParameter("attenceDate");
			duraIDS=super.getRequestParameter("duraID");
		}
		dayQuery();
		return dayPageInit;
	}

	public void setDayPageInit(String dayPageInit) {
		this.dayPageInit = dayPageInit;
	}

	public String getAttenceDate() {
		return attenceDate;
	}

	public void setAttenceDate(String attenceDate) {
		this.attenceDate = attenceDate;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}
	
	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(super.getUserInfo().getOrgId());
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public List getPersBos() {
		return persBos;
	}

	public void setPersBos(List persBos) {
		this.persBos = persBos;
	}
	
	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String dayQuery(){
		getHttpSession().removeAttribute("OBJECT");
		getHttpSession().removeAttribute("activeSql");
		getHttpSession().removeAttribute("pageNum");
		getHttpSession().removeAttribute("rowNum");
		try {
			AttDurationBO attdurationbo=attenceSetUCC.findAttenceSetBObyId(duraIDS);
			beginTime=attdurationbo.getDuraBegin();
			endTime=attdurationbo.getDuraEnd();
			TableVO table = new TableVO();
			String rowNums = (String) getHttpSession().getAttribute("rowNum");
			int rowNum = Constants.ACTIVE_PAGE_SIZE;
			if (rowNums != null)
				rowNum = Integer.parseInt(rowNums);
			User user = getUserInfo();
			String sql = "";
			if ("1".equals(backFlag))
				sql = attenceSetUCC.queryPersonListandday(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
						Constants.NO, user,dayvalues,"",beginTime,endTime,personId);
			else
				sql = attenceSetUCC.queryPersonListandday(table, name,personType, orgID, 1, rowNum,
						"00900", user,dayvalues,"",beginTime,endTime,personId);
			
			getHttpSession().setAttribute("activeSql", sql);
			getHttpSession().setAttribute("pageNum", String.valueOf("1"));
			getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
			getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute("OBJECT");
			getHttpSession().removeAttribute("activeSql");
			getHttpSession().removeAttribute("pageNum");
			getHttpSession().removeAttribute("rowNum");
			msg.setMainMsg(e, getClass());
		}
		return "";
	}
	/*
	 * 查看打卡信息
	 */

	public List getPersBos1() {
		return persBos1;
	}

	public void setPersBos1(List persBos1) {
		this.persBos1 = persBos1;
	}

	public String getMonthPageInit() {
		if(super.getRequestParameter("personId") != null && !super.getRequestParameter("personId").equals("") && super.getRequestParameter("attenceDate") != null && !super.getRequestParameter("attenceDate").equals("") && super.getRequestParameter("duraID") != null && !super.getRequestParameter("duraID").equals("")){
			personId = super.getRequestParameter("personId");
			attenceDate = super.getRequestParameter("attenceDate");
			duraIDS=super.getRequestParameter("duraID");
		}  
		monthQuery();
		return monthPageInit;
	}

	public void setMonthPageInit(String monthPageInit) {
		this.monthPageInit = monthPageInit;
	}
	
	public String monthQuery(){
		getHttpSession().removeAttribute("OBJECT");
		getHttpSession().removeAttribute("activeSql");
		getHttpSession().removeAttribute("pageNum");
		getHttpSession().removeAttribute("rowNum");
		try {
			AttDurationBO attdurationbo=attenceSetUCC.findAttenceSetBObyId(duraIDS);
			beginTime=attdurationbo.getDuraBegin();
			endTime=attdurationbo.getDuraEnd();
			TableVO table = new TableVO();
			String rowNums = (String) getHttpSession().getAttribute("rowNum");
			int rowNum = Constants.ACTIVE_PAGE_SIZE;
			if (rowNums != null)
				rowNum = Integer.parseInt(rowNums);
			User user = getUserInfo();
			String sql = "";
			if ("1".equals(backFlag))
				sql = attenceSetUCC.queryPersonList(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
						Constants.NO, user,Constants.DEFAULT_QUERY_ATTENCE_LOG,"",beginTime,endTime,personId);
			else
				sql = attenceSetUCC.queryPersonList(table, name,personType, orgID, 1, rowNum,
						"00900", user,Constants.DEFAULT_QUERY_ATTENCE_LOG,"",beginTime,endTime,personId);
			
			getHttpSession().setAttribute("activeSql", sql);
			getHttpSession().setAttribute("pageNum", String.valueOf("1"));
			getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
			getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute("OBJECT");
			getHttpSession().removeAttribute("activeSql");
			getHttpSession().removeAttribute("pageNum");
			getHttpSession().removeAttribute("rowNum");
			msg.setMainMsg(e, getClass());
		}
		return "";
	}
	
	/*
	 * 考勤区间计算
	 */
	public String cacl1() {
		String beginyear = beginTime1.substring(0, 4);
		String beginmonth = beginTime1.substring(5, 7);
		String beginday = beginTime1.substring(8, 10);
		String beginday1 = beginTime1.substring(8, 9);
		String beginday2 = beginTime1.substring(9, 10);
		String endTimeyear = endTime1.substring(0, 4);
		String endTimemonth = endTime1.substring(5, 7);
		String endTimeday = endTime1.substring(8, 10);
		String endTimeday1 = endTime1.substring(8, 9);
		String endTimeday2 = endTime1.substring(9, 10);
		List lists = new ArrayList();
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
				AttCaclInfoBO bo = new AttCaclInfoBO();
				bo.setDuraId(duraID);
				bo.setAttDate(datevalue);
				bo.setCaclPerson(personName);
				bo.setCaclTime(cacltime);
				lists.add(bo);
			}
			List lists1 = new ArrayList();
			for (int i = 1; i <= n; i++) {
				String datevalue = new String();
				if (i >= 10) {
					datevalue = endTimeyear + "-" + endTimemonth + "-" + i;
				} else {
					datevalue = endTimeyear + "-" + endTimemonth + "-0" + i;
				}
				AttCaclInfoBO bo = new AttCaclInfoBO();
				bo.setDuraId(duraID);
				bo.setAttDate(datevalue);
				bo.setCaclPerson(personName);
				bo.setCaclTime(cacltime);
				lists1.add(bo);
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
				AttCaclInfoBO bo = new AttCaclInfoBO();
				bo.setDuraId(duraID);
				bo.setAttDate(datevalue);
				bo.setCaclPerson(personName);
				bo.setCaclTime(cacltime);
				lists.add(bo);
			}
		}

		try {
			List listss=attenceSetUCC.getAttCaclInfoBO(duraID);
			if(listss!=null && listss.size()>0){
				attenceSetUCC.deleteAttCaclInfoBO(duraID);
			}
			if (lists != null && lists.size() > 0) {
				for (int j = 0; j < lists.size(); j++) {
					AttCaclInfoBO bo = (AttCaclInfoBO) lists.get(j);
					attenceSetUCC.saveAttCaclInfoBO(bo);
				}
			}
			AttDurationBO attdurationbo = attenceSetUCC
					.findAttDurationBObyId(duraID);
			attdurationbo.setStatus("1");
			attenceSetUCC.saveorupdateAttDurationBO(attdurationbo);
		} catch (Exception e) {

		}
		return "";
	}
	
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

	public String getBackFlag() {
		return backFlag;
	}

	public void setBackFlag(String backFlag) {
		this.backFlag = backFlag;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getPersonType() {
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getPersonTypeValue() {
		return personTypeValue;
	}

	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPersonList() {
		getHttpSession().removeAttribute("ok");
		getHttpSession().setAttribute("ok", orgID);
		String pageFlag = getServletRequest().getParameter("pageFlag");
		String sessionFlag = getServletRequest().getParameter("sessionFlag");
		if (sessionFlag == null)
			getHttpSession().removeAttribute("OBJECT");

		if ("1".equals(flag))
			try {
				TableVO table = new TableVO();
				String rowNums = (String) getHttpSession().getAttribute(
						"rowNum");
				int rowNum = Constants.ACTIVE_PAGE_SIZE;
				if (rowNums != null) {
					rowNum = Integer.parseInt(rowNums);
				}
				User user = this.getUserInfo();
				String sql = "";
                
				if ("1".equals(backFlag))
					sql = attenceSetUCC.queryPersonListandday(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,dayvalues,"",beginTime,endTime,personId);
				else
					sql = attenceSetUCC.queryPersonListandday(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,dayvalues,"",beginTime,endTime,personId);

				getHttpSession().setAttribute("activeSql", sql);
				getHttpSession().setAttribute("pageNum", String.valueOf("1"));
				getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
				getHttpSession().setAttribute(Constants.OBJECT, table);
                System.out.println("sql="+sql);
			} catch (Exception e) {
                e.printStackTrace();
			}

			if ("1".equals(pageFlag)) // 翻页
				try {
					String rowNums = getServletRequest().getParameter("rowNum");// Constants.PAGE;
					int pageNum = getServletRequest().getParameter("pageNum") == null
							|| "".equals(getServletRequest()
									.getParameter("pageNum")) ? 1 : Integer
							.parseInt(getServletRequest().getParameter("pageNum"));

					String sql = (String) getHttpSession()
							.getAttribute("activeSql");

					TableVO table = (TableVO) getHttpSession().getAttribute(
							Constants.OBJECT);
					if (table == null)
						table = new TableVO();
					int rowNum = Constants.ACTIVE_PAGE_SIZE;
					if (rowNums != null) {
						rowNum = Integer.parseInt(rowNums);
					}
					User user = this.getUserInfo();

					personucc.querySql(table, sql, user, pageNum, rowNum);
					getHttpSession().setAttribute(Constants.OBJECT, table);
					getHttpSession().setAttribute("activeSql", sql);
					getHttpSession().setAttribute("pageNum",
							String.valueOf(pageNum));
					getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
                     System.out.println("sql="+sql);
				} catch (SysException e) {
                    e.printStackTrace();
				}
		return personList;
	}

	public void setPersonList(String personList) {
		this.personList = personList;
	}

	public IPersonUCC getPersonucc() {
		return personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}

	public String getPersonList1() {
		getHttpSession().removeAttribute("ok");
		getHttpSession().setAttribute("ok", orgID);
		String pageFlag = getServletRequest().getParameter("pageFlag");
		String sessionFlag = getServletRequest().getParameter("sessionFlag");
		if (sessionFlag == null)
			getHttpSession().removeAttribute("OBJECT");

		if ("1".equals(flag))
			try {
				TableVO table = new TableVO();
				String rowNums = (String) getHttpSession().getAttribute(
						"rowNum");
				int rowNum = Constants.ACTIVE_PAGE_SIZE;
				if (rowNums != null) {
					rowNum = Integer.parseInt(rowNums);
				}
				User user = this.getUserInfo();
				String sql = "";
                
				if ("1".equals(backFlag))
					sql = attenceSetUCC.queryPersonList(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,Constants.DEFAULT_QUERY_ATTENCE_LOG,"",beginTime,endTime,personId);
				else
					sql = attenceSetUCC.queryPersonList(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,Constants.DEFAULT_QUERY_ATTENCE_LOG,"",beginTime,endTime,personId);

				getHttpSession().setAttribute("activeSql", sql);
				getHttpSession().setAttribute("pageNum", String.valueOf("1"));
				getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
				getHttpSession().setAttribute(Constants.OBJECT, table);
			} catch (Exception e) {
			}

			if ("1".equals(pageFlag)) // 翻页
				try {
					String rowNums = getServletRequest().getParameter("rowNum");// Constants.PAGE;
					int pageNum = getServletRequest().getParameter("pageNum") == null
							|| "".equals(getServletRequest()
									.getParameter("pageNum")) ? 1 : Integer
							.parseInt(getServletRequest().getParameter("pageNum"));

					String sql = (String) getHttpSession()
							.getAttribute("activeSql");

					TableVO table = (TableVO) getHttpSession().getAttribute(
							Constants.OBJECT);
					if (table == null)
						table = new TableVO();
					int rowNum = Constants.ACTIVE_PAGE_SIZE;
					if (rowNums != null) {
						rowNum = Integer.parseInt(rowNums);
					}
					User user = this.getUserInfo();

					personucc.querySql(table, sql, user, pageNum, rowNum);
					getHttpSession().setAttribute(Constants.OBJECT, table);
					getHttpSession().setAttribute("activeSql", sql);
					getHttpSession().setAttribute("pageNum",
							String.valueOf(pageNum));
					getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
				} catch (SysException e) {
				}
		return personList1;
	}

	public void setPersonList1(String personList1) {
		this.personList1 = personList1;
	}
	
}
