package com.hr319wg.attence.web;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttDurationBO;
import com.hr319wg.attence.pojo.bo.AttenceCurrLogBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class PeriodSetOpenBackingBean extends BaseBackingBean {
	private String personName = super.getUserInfo().getName();
	private String status;
	private String endTime;
	private String beginTime;
	private List itemList = new ArrayList();
	private String orgID=super.getUserInfo().getOrgId();
	private String duraYear;
	private String duraMonth;
	private String duraYearMonth;
	private String superName;
	private String pageInit;
	private String selfSignInfo;
	private IAttenceSetUCC attenceSetUCC;
	private PageVO mypage = new PageVO();
    private String backFlag="1";
    private String flag="1";
    private String personType;
    private String personTypeValue;
    private String name;
    private String personList;
    private String superId=super.getUserInfo().getOrgId();
    private IPersonUCC personucc;
    private AttDurationBO attDurationBO;
	private static String monthvalues = "167";
	

	public String first() {
		mypage.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuery();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuery();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuery();
		return "";
	}

	public String getPageInit() {
		try {
			String duraID=super.getRequestParameter("duraID");
			if(duraID!=null && !"".equals(duraID)){
				this.attDurationBO=attenceSetUCC.findAttDurationBObyId(duraID);
				this.duraYearMonth=this.attDurationBO.getDuraYear()+"-"+this.attDurationBO.getDuraMonth();
			}
		} catch (Exception e) {
		}
		doQuery();
		return pageInit;
	}

	public AttDurationBO getAttDurationBO() {
		return attDurationBO;
	}

	public void setAttDurationBO(AttDurationBO attDurationBO) {
		this.attDurationBO = attDurationBO;
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

	public String doQuery() {
		getHttpSession().removeAttribute("OBJECT");
	getHttpSession().removeAttribute("activeSql");
	getHttpSession().removeAttribute("pageNum");
	getHttpSession().removeAttribute("rowNum");
	try {
		TableVO table = new TableVO();
		String rowNums = (String) getHttpSession().getAttribute("rowNum");
		int rowNum = Constants.ACTIVE_PAGE_SIZE;
		if (rowNums != null)
			rowNum = Integer.parseInt(rowNums);
		User user = getUserInfo();
		String sql = "";
		if ("1".equals(backFlag))
			sql = attenceSetUCC.queryPersonListandmonth(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
					Constants.NO, user,monthvalues,"",duraYearMonth,duraYearMonth,"");
		else
			sql = attenceSetUCC.queryPersonListandmonth(table, name,personType, orgID, 1, rowNum,
					"00900", user,monthvalues,"",duraYearMonth,duraYearMonth,"");
		
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
	
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(this.orgID);
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getDuraYear() {
		return duraYear;
	}

	public void setDuraYear(String duraYear) {
		this.duraYear = duraYear;
	}

	public String getDuraMonth() {
		return duraMonth;
	}

	public void setDuraMonth(String duraMonth) {
		this.duraMonth = duraMonth;
	}

	public String getDuraYearMonth() {
		return duraYearMonth;
	}

	public void setDuraYearMonth(String duraYearMonth) {
		this.duraYearMonth = duraYearMonth;
	}

	public List getItemList() {
		return itemList;
	}

	public void setItemList(List itemList) {
		this.itemList = itemList;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String cacl1() {
		try {
			this.attDurationBO.setStatus("2");
			attenceSetUCC.saveorupdateAttDurationBO(this.attDurationBO);
			String ym=this.attDurationBO.getDuraYear()+"-"+this.attDurationBO.getDuraMonth();
		} catch (Exception e) {

		}
		return "success";
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
		if (personType == null || "".equals(personType)) {
			personType = Constants.IN_SERVICE_TYPE;
			personTypeValue = Constants.IN_SERVICE_DES;
		}
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
		getHttpSession().setAttribute("ok", superId);
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
					sql = attenceSetUCC.queryPersonListandmonth(table, name, "", superId, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,monthvalues,"",duraYearMonth,duraYearMonth,"");
				else
					sql = attenceSetUCC.queryPersonListandmonth(table, name, "", superId, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,monthvalues,"",duraYearMonth,duraYearMonth,"");

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
		return personList;
	}

	public void setPersonList(String personList) {
		this.personList = personList;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public IPersonUCC getPersonucc() {
		return personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}
	
	/*
	 * 日期区间计算
	 */
	public List cacl(String beginTime1,String endTime1) {
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
		
		/**
		 *计算考勤结果 
		 * @throws SysException 
		 * @throws ParseException 
		 */
		public void calc() throws SysException, ParseException{
			String result = this.attenceSetUCC.calcAttData(superId, this.attDurationBO.getDuraBegin(), this.attDurationBO.getDuraEnd(), this.attDurationBO.getDuraYear(), this.attDurationBO.getDuraMonth());
			if(result!=null){
				super.showMessageDetail(result);
			}else{
				super.showMessageDetail("计算完成");
			}
		}
		
		
		public String getSelfSignInfo() {
			String signinfo = "";
			try {
				List<AttenceCurrLogBO> list = this.attenceSetUCC.getSelfSignInfo(super.getUserInfo().getUserId(), CommonFuns.getSysDate("yyyy-MM"));
				for(AttenceCurrLogBO curr : list){
					if(!"0".equals(curr.getLateTime())){
						signinfo+="迟到"+curr.getLateTime()+"次,";
					}
					if(!"0".equals(curr.getAwayTime())){
						signinfo+="旷工"+curr.getAwayTime()+"次,";
					}
					if(!"0".equals(curr.getLeaveReasons())){
						signinfo+="事假"+curr.getLeaveReasons()+"天,";
					}
					if(!"0".equals(curr.getLeaveSick())){
						signinfo+="病假"+curr.getLeaveSick()+"天,";
					}
					if(!"0".equals(curr.getLeaveMaternity())){
						signinfo+="产假"+curr.getLeaveMaternity()+"天,";
					}
					if(!"0".equals(curr.getLeaveWedding())){
						signinfo+="婚假"+curr.getLeaveWedding()+"天,";
					}
					if(!"0".equals(curr.getLeaveHome())){
						signinfo+="探亲假"+curr.getLeaveHome()+"天,";
					}
					if(!"0".equals(curr.getLeaveIndustrialInjury())){
						signinfo+="工伤假"+curr.getLeaveIndustrialInjury()+"天,";
					}
					if(!"0".equals(curr.getLeaveArrangingFuneral())){
						signinfo+="丧假"+curr.getLeaveArrangingFuneral()+"天,";
					}
					if(!"0".equals(curr.getEvcctionValue())){
						signinfo+="出差"+curr.getEvcctionValue()+"天,";
					}
					if(!"0".equals(curr.getOutWorkValue())){
						signinfo+="公出"+curr.getOutWorkValue()+"天,";
					}
					if(!"0".equals(curr.getWorkAddValue())){
						signinfo+="加班"+curr.getWorkAddValue()+"天,";
					}
					
				}
			} catch (SysException e) {
				e.printStackTrace();
			}
			return signinfo;
		}		
		
}
