package com.hr319wg.attence.web;

import java.text.SimpleDateFormat;
import java.util.List;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.sys.pojo.vo.TableVO;

public class PunchCardDayCollectBackingBean extends BaseBackingBean {
	private String orgID=super.getUserInfo().getOrgId();
	private IAttenceSetUCC attenceSetUCC;
	private String beginTime=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	private String endTime=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	private String pageInit;
	private String userid = super.getUserInfo().getUserId();
	private String personName = super.getUserInfo().getName();
	private List persBos;
	private static String dayvalues = "168";
    private String backFlag="1";
    private String flag="1";
    private String personType;
    private String personTypeValue;
    private String name;
    private String personList;
    private IPersonUCC personucc;
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

	public String getPageInit() {
		checkPersonCardMessage();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public List getPersBos() {
		return persBos;
	}

	public void setPersBos(List persBos) {
		this.persBos = persBos;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String checkPersonCardMessage() {
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
			User user = null;
			String sql = "";
			if ("1".equals(backFlag))
				sql = attenceSetUCC.queryPersonListandday(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
						Constants.NO, user,dayvalues,"",beginTime,endTime,userid);
			else
				sql = attenceSetUCC.queryPersonListandday(table, name,personType, orgID, 1, rowNum,
						"00900", user,dayvalues,"",beginTime,endTime,userid);
			
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

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
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
//		String superId = getServletRequest().getParameter("superId");
		getHttpSession().setAttribute("ok", orgID);
		String pageFlag = getServletRequest().getParameter("pageFlag");
//		String flag = getServletRequest().getParameter("flag");
		String sessionFlag = getServletRequest().getParameter("sessionFlag");
//		String backFlag = getServletRequest().getParameter("backFlag");
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
				User user = null;
				String sql = "";
                
				if ("1".equals(backFlag))
					sql = attenceSetUCC.queryPersonListandday(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,dayvalues,"",beginTime,endTime,userid);
				else
					sql = attenceSetUCC.queryPersonListandday(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,dayvalues,"",beginTime,endTime,userid);

				getHttpSession().setAttribute("activeSql", sql);
				getHttpSession().setAttribute("pageNum", String.valueOf("1"));
				getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
				getHttpSession().setAttribute(Constants.OBJECT, table);
			} catch (Exception e) {
			}

			if ("1".equals(pageFlag)) // ·­Ò³
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
					User user = null;

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

	public IPersonUCC getPersonucc() {
		return personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}
	
}
