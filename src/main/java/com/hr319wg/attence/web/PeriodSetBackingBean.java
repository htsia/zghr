package com.hr319wg.attence.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttDurationBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.vo.UserQryVO;
import com.hr319wg.user.ucc.IUserQryUCC;
import com.hr319wg.util.CommonFuns;

public class PeriodSetBackingBean extends BaseBackingBean {
	private List lists;
	private String beginTime;
	private String endTime;
	private String personName = super.getUserInfo().getName();
	private static String status1 = "0";
	private static String status2 = "1";
	private static String status3 = "9";
	private static String eyear;
	private static String emonth;
	private static String eday;
	private static String month1;
	private static String edaytest;
	private IAttenceSetUCC attenceSetUCC;
	private String superId=super.getUserInfo().getOrgId();
	private String superName;
	private String PageInit;
	private PageVO mypage = new PageVO();
	private List attenceSetList;
	private String atttype;
	private AttDurationBO bo = new AttDurationBO();
	private String initEdit;
	private String count;
	private String duraID;
	private boolean isExist = true;
	private String nowyearvalue;
	private List nowyearlist = new ArrayList();
	private IAttBusiService attBusiService;
	private IUserQryUCC userqryucc;
	private List<SelectItem> qryList;

	public IUserQryUCC getUserqryucc() {
		return userqryucc;
	}

	public void setUserqryucc(IUserQryUCC userqryucc) {
		this.userqryucc = userqryucc;
	}

	public List getQryList() {
		return qryList;
	}

	public void setQryList(List qryList) {
		this.qryList = qryList;
	}

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}

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

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			attenceSetList = attenceSetUCC.getAllAttenceSet(mypage, super.getUserInfo());
			if (attenceSetList != null && attenceSetList.size() > 0) {
				for (int i = 0; i < attenceSetList.size(); i++) {
					AttDurationBO attDurationBO = (AttDurationBO) attenceSetList
							.get(i);
					attenceSetList.set(i, attDurationBO);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public String save() {
		try {
			String ymd1 = bo.getDuraBegin();
			String ymd2 = bo.getDuraEnd();
			if (CommonFuns.betweenMonths(ymd2, ymd1) > 1) {
				super.showMessageDetail("计算的最长期限不超过1个月！");
				return "";
			}
            boolean success=true;
			List list1s = attenceSetUCC.getAllAttDurationBO(super.getUserInfo());
			if (list1s != null && list1s.size() > 0) {
				for (int i = 0; i < list1s.size(); i++) {
					AttDurationBO attdurationbo = (AttDurationBO) list1s.get(i);
					if ("0".equals(attdurationbo.getStatus())
							|| "1".equals(attdurationbo.getStatus())) {
						success=false;
						break;
					}
				}
			}
			
			if(success || !success){
				bo.setOrgID(superId);
				bo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
				bo.setCreateOper(personName);
				bo.setCreateUserID(super.getUserInfo().getUserId());
				bo.setDuraYear(this.nowyearvalue);
				bo.setDuraMonth(this.atttype);
				bo.setStatus("0");
				try {
					List<UserQryVO> list = this.userqryucc.queryUserQry(super.getUserInfo().getUserId(), "0311");
					for (UserQryVO vo : list) {
						if(vo.getQryID().equals(bo.getQryID())){
							bo.setQryName(vo.getQryName());	
							break;
						}
					}
				} catch (SysException e1) {
					e1.printStackTrace();
				}
				attenceSetUCC.saveorupdateAttenceSet(bo);
			}else{
				super.showMessageDetail("上个月考勤汇总未结束，不能进行此步操作！");
				return "";
			}
			
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String saveEdit() {
		try {
			String ymd1 = bo.getDuraBegin();
			String ymd2 = bo.getDuraEnd();
			if (CommonFuns.betweenMonths(ymd2, ymd1) > 1) {
				super.showMessageDetail("计算的最长期限不能超过1个月！");
				return "";
			}
				bo.setOrgID(superId);
				bo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
				bo.setCreateOper(personName);
				bo.setDuraYear(this.nowyearvalue);
				bo.setDuraMonth(this.atttype);
				bo.setStatus("0");
				try {
					List<UserQryVO> list = this.userqryucc.queryUserQry(super.getUserInfo().getUserId(), "0311");
					for (UserQryVO vo : list) {
						if(vo.getQryID().equals(bo.getQryID())){
							bo.setQryName(vo.getQryName());	
							break;
						}
					}
				} catch (SysException e1) {
					e1.printStackTrace();
				}
				attenceSetUCC.saveorupdateAttenceSet(bo);			
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public void init() {
		if ("12".equals(emonth)) {
			eyear = (Integer.parseInt(eyear) + 1) + "";
			emonth = "01";
			return;
		} else if ("01".equals(emonth)) {
			emonth = "02";
			return;
		} else if ("02".equals(emonth)) {
			emonth = "03";
			return;
		} else if ("03".equals(emonth)) {
			emonth = "04";
			return;
		} else if ("04".equals(emonth)) {
			emonth = "05";
			return;
		} else if ("05".equals(emonth)) {
			emonth = "06";
			return;
		} else if ("06".equals(emonth)) {
			emonth = "07";
			return;
		} else if ("07".equals(emonth)) {
			emonth = "08";
			return;
		} else if ("08".equals(emonth)) {
			emonth = "09";
			return;
		} else if ("09".equals(emonth)) {
			emonth = "10";
			return;
		} else if ("10".equals(emonth)) {
			emonth = "11";
			return;
		} else if ("11".equals(emonth)) {
			emonth = "12";
			return;
		}
	}

	public void initmonth() {
		if ("12".equals(month1)) {
			month1 = "01";
			return;
		} else if ("01".equals(month1)) {
			month1 = "02";
			return;
		} else if ("02".equals(month1)) {
			month1 = "03";
			return;
		} else if ("03".equals(month1)) {
			month1 = "04";
			return;
		} else if ("04".equals(month1)) {
			month1 = "05";
			return;
		} else if ("05".equals(month1)) {
			month1 = "06";
			return;
		} else if ("06".equals(month1)) {
			month1 = "07";
			return;
		} else if ("07".equals(month1)) {
			month1 = "08";
			return;
		} else if ("08".equals(month1)) {
			month1 = "09";
			return;
		} else if ("09".equals(month1)) {
			month1 = "10";
			return;
		} else if ("10".equals(month1)) {
			month1 = "11";
			return;
		} else if ("11".equals(month1)) {
			month1 = "12";
			return;
		}
	}

	public void initmonthtime() {
		if (Integer.parseInt(eyear) % 400 == 0
				|| (Integer.parseInt(eyear) % 4 == 0 && Integer.parseInt(eyear) % 100 != 0)) {
			if ("12".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("01".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("02".equals(emonth)) {
				if (Integer.parseInt(eday) > 29) {
					edaytest = "29";
				} else {
					edaytest = eday;
				}
				return;
			} else if ("03".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("04".equals(emonth)) {
				if (Integer.parseInt(eday) > 30) {
					edaytest = "30";
				} else {
					edaytest = eday;
				}
				return;
			} else if ("05".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("06".equals(emonth)) {
				if (Integer.parseInt(eday) > 30) {
					edaytest = "30";
				} else {
					edaytest = eday;
				}
				return;
			} else if ("07".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("08".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("09".equals(emonth)) {
				if (Integer.parseInt(eday) > 30) {
					edaytest = "30";
				} else {
					edaytest = eday;
				}
				return;
			} else if ("10".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("11".equals(emonth)) {
				if (Integer.parseInt(eday) > 30) {
					edaytest = "30";
				} else {
					edaytest = eday;
				}
				return;
			}
		} else {
			if ("12".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("01".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("02".equals(emonth)) {
				if (Integer.parseInt(eday) > 28) {
					edaytest = "28";
				} else {
					edaytest = eday;
				}
				return;
			} else if ("03".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("04".equals(emonth)) {
				if (Integer.parseInt(eday) > 30) {
					edaytest = "30";
				} else {
					edaytest = eday;
				}
				return;
			} else if ("05".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("06".equals(emonth)) {
				if (Integer.parseInt(eday) > 30) {
					edaytest = "30";
				} else {
					edaytest = eday;
				}
				return;
			} else if ("07".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("08".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("09".equals(emonth)) {
				if (Integer.parseInt(eday) > 30) {
					edaytest = "30";
				} else {
					edaytest = eday;
				}
				return;
			} else if ("10".equals(emonth)) {
				edaytest = eday;
				return;
			} else if ("11".equals(emonth)) {
				if (Integer.parseInt(eday) > 30) {
					edaytest = "30";
				} else {
					edaytest = eday;
				}
				return;
			}
		}

	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(this.superId);
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public String getPageInit() {
		if (super.getUserInfo().getOrgId() != null
				&& !super.getUserInfo().getOrgId().equals("")) {
			superId = super.getUserInfo().getOrgId();
		}
		doQuery();
		
		return PageInit;
	}

	public void setPageInit(String pageInit) {
		PageInit = pageInit;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public List getAttenceSetList() {
		return attenceSetList;
	}

	public void setAttenceSetList(List attenceSetList) {
		this.attenceSetList = attenceSetList;
	}

	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}

	public AttDurationBO getBo() {
		return bo;
	}

	public void setBo(AttDurationBO bo) {
		this.bo = bo;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getInitEdit() {
		try {
			List<UserQryVO> list = this.userqryucc.queryUserQry(super.getUserInfo().getUserId(), "0311");
			qryList = new ArrayList();
			SelectItem item1 = new SelectItem("-1", "--选择查询方案--");
			qryList.add(item1);
			for (int i = 0; i < list.size(); i++) {
				UserQryVO role = (UserQryVO)list.get(i);
				SelectItem item = new SelectItem();
				item.setLabel(role.getQryName());
				item.setValue(role.getQryID());
				qryList.add(item);
			}
		} catch (SysException e1) {
			e1.printStackTrace();
		}
		
		try {
			if (lists != null) {
				lists = new ArrayList();
			}
			if (super.getRequestParameter("superId") != null) {
				superId = super.getRequestParameter("superId");
				bo.setDuraID(null);
				bo.setOrgID(superId);
				String superId1 = superId;
				initValues(superId1);
				isExist = true;
			} else if (super.getRequestParameter("duraID") != null
					&& !super.getRequestParameter("duraID").equals("")
					&& super.getRequestParameter("oid") != null
					&& !super.getRequestParameter("oid").equals("")) {
				String duraID = super.getRequestParameter("duraID");
				String oid = super.getRequestParameter("oid");
				bo = attenceSetUCC.findAttenceSetBObyId(duraID);
				this.atttype = bo.getDuraMonth();
				isExist = false;
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String delete() {
		try {
			if (duraID != null) {
				attenceSetUCC.deleteAttenceSetBO(duraID);
			}
		} catch (Exception e) {
			super.showMessageDetail("删除失败！");
		}
		return "";
	}

	public void changeStatus(ValueChangeEvent event) {
		this.atttype = event.getNewValue().toString();
	}

	public String getDuraID() {
		return duraID;
	}

	public void setDuraID(String duraID) {
		this.duraID = duraID;
	}

	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}

	public void doQueryYear() {

		String nowyear = new SimpleDateFormat("yyyy")
				.format(new java.util.Date());
		nowyearvalue = nowyear;
		String nowmonth = new SimpleDateFormat("MM")
				.format(new java.util.Date());
		atttype = nowmonth;
		int m = Integer.parseInt(nowyear);
		for (int i = 4; i > 0; i--) {
			String num = (m - i) + "";
			SelectItem si = new SelectItem();
			si.setLabel(num);
			si.setValue(num);
			nowyearlist.add(si);
		}

		SelectItem si1 = new SelectItem();
		si1.setLabel(nowyear);
		si1.setValue(nowyear);
		nowyearlist.add(si1);

		for (int i = 1; i <= 30; i++) {
			String num = (m + i) + "";
			SelectItem si = new SelectItem();
			si.setLabel(num);
			si.setValue(num);
			nowyearlist.add(si);
		}
	}

	public String getNowyearvalue() {
		return nowyearvalue;
	}

	public void setNowyearvalue(String nowyearvalue) {
		this.nowyearvalue = nowyearvalue;
	}

	public List getNowyearlist() {
		doQueryYear();
		return nowyearlist;
	}

	public void setNowyearlist(List nowyearlist) {
		this.nowyearlist = nowyearlist;
	}

	public void changeNowYearValue(ValueChangeEvent event) {
		this.nowyearvalue = event.getNewValue().toString();
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
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
	 * 下一个月计算的初始化
	 */
	public String initValues(String superId1) {
		try {
			lists = attenceSetUCC.getAllAttDurationBO(super.getUserInfo());
			if (lists != null && lists.size() > 0) {
				AttDurationBO attdurationbo = (AttDurationBO) lists.get(lists
						.size() - 1);
				String ymd1 = attdurationbo.getDuraBegin();
				String ymd2 = attdurationbo.getDuraEnd();
				String byear = ymd1.substring(0, 4);
				String bmonth = ymd1.substring(5, 7);
				String bday = ymd1.substring(8, 10);
				String eyear = ymd2.substring(0, 4);
				String emonth = ymd2.substring(5, 7);
				String eday = ymd2.substring(8, 10);
				if (byear.equals(eyear)) {
					if (bmonth.equals(emonth)) {
						if (!"12".equals(bmonth)) {
							int byearvalue = Integer.parseInt(byear);
							int bmonthvalue = Integer.parseInt(bmonth) + 1;
							int bdayvalue = Integer.parseInt(eday);
							int bdayvalues = MonthDays(bmonthvalue, byearvalue);
							if (bmonthvalue < 10) {
								if (bdayvalue >= bdayvalues) {
									bo.setDuraEnd(byear + "-0" + bmonthvalue
											+ "-" + bdayvalues);
								} else {
									bo.setDuraEnd(byear + "-0" + bmonthvalue
											+ "-" + eday);
								}
								bo.setDuraBegin(byear + "-0" + bmonthvalue
										+ "-" + bday);
								this.atttype = bmonthvalue + "";
							} else {
								if (bdayvalue > bdayvalues) {
									bo.setDuraEnd(byear + "-" + bmonthvalue
											+ "-" + bdayvalues);
								} else {
									bo.setDuraEnd(byear + "-" + bmonthvalue
											+ "-" + eday);
								}
								bo.setDuraBegin(byear + "-" + bmonthvalue + "-"
										+ bday);
								this.atttype = bmonthvalue + "";
							}
						} else {
							String bmonths = "01";
							int byearvalue = Integer.parseInt(byear) + 1;
							int bmonthvalue = Integer.parseInt(bmonths);
							int bdayvalue = Integer.parseInt(eday);
							int bdayvalues = MonthDays(bmonthvalue, byearvalue);
							if (bdayvalue >= bdayvalues) {
								bo.setDuraEnd(byearvalue + "-0" + bmonthvalue
										+ "-" + bdayvalues);
							} else {
								bo.setDuraEnd(byearvalue + "-0" + bmonthvalue
										+ "-" + eday);
							}
							bo.setDuraBegin(byearvalue + "-0" + bmonthvalue
									+ "-" + bday);
						}
					} else {
						if (!"12".equals(emonth)) {
							int byearvalue = Integer.parseInt(byear);
							int bmonthvalue = Integer.parseInt(bmonth) + 1;
							int emonthvalue = Integer.parseInt(emonth) + 1;
							int bdayvalue = Integer.parseInt(eday) + 1;
							int edayvalue = Integer.parseInt(eday);
							int bdayvalues = MonthDays(bmonthvalue, byearvalue);
							int edayvalues = MonthDays(emonthvalue, byearvalue);
							if (emonthvalue < 10) {
								if (edayvalue >= edayvalues) {
									bo.setDuraEnd(byear + "-0" + emonthvalue
											+ "-" + edayvalues);
								} else {
									bo.setDuraEnd(byear + "-0" + emonthvalue
											+ "-" + eday);
								}
							} else {
								if (bdayvalue > bdayvalues) {
									bo.setDuraEnd(byear + "-" + emonthvalue
											+ "-" + edayvalues);
								} else {
									bo.setDuraEnd(byear + "-" + emonthvalue
											+ "-" + eday);
								}
							}
							if (bmonthvalue < 10) {
								if (bdayvalue >= bdayvalues) {
									bo.setDuraBegin(byear + "-0" + bmonthvalue
											+ "-" + bdayvalues);
								} else {
									if (bdayvalue < 10) {
										bo
												.setDuraBegin(byear + "-0"
														+ bmonthvalue + "-0"
														+ bdayvalue);
									} else {
										bo
												.setDuraBegin(byear + "-0"
														+ bmonthvalue + "-"
														+ bdayvalue);
									}
								}
							} else {
								if (bdayvalue > bdayvalues) {
									bo.setDuraBegin(byear + "-" + bmonthvalue
											+ "-" + bdayvalues);
								} else {
									if (bdayvalue < 10) {
										bo
												.setDuraBegin(byear + "-"
														+ bmonthvalue + "-0"
														+ bdayvalue);
									} else {
										bo
												.setDuraBegin(byear + "-"
														+ bmonthvalue + "-"
														+ bdayvalue);
									}
								}
							}
						} else {
							int byearvalue = Integer.parseInt(byear);
							int eyearvalue = Integer.parseInt(byear) + 1;
							int bmonthvalue = Integer.parseInt(bmonth) + 1;
							String emonths = "01";
							int emonthvalue = Integer.parseInt(emonths);
							int bdayvalue = Integer.parseInt(eday) + 1;
							int edayvalue = Integer.parseInt(eday);
							int bdayvalues = MonthDays(bmonthvalue, byearvalue);
							int edayvalues = MonthDays(emonthvalue, eyearvalue);
							if (edayvalue >= edayvalues) {
								bo.setDuraEnd(eyearvalue + "-0" + emonthvalue
										+ "-" + edayvalues);
							} else {
								bo.setDuraEnd(eyearvalue + "-0" + emonthvalue
										+ "-" + eday);
							}
							if (bdayvalue > bdayvalues) {
								bo.setDuraBegin(byear + "-" + bmonthvalue + "-"
										+ bdayvalues);
							} else {
								if (bdayvalue < 10) {
									bo.setDuraBegin(byear + "-" + bmonthvalue
											+ "-0" + bdayvalue);
								} else {
									bo.setDuraBegin(byear + "-" + bmonthvalue
											+ "-" + bdayvalue);
								}
							}
						}

					}
				} else {
					int byearvalue = Integer.parseInt(byear);
					int eyearvalue = Integer.parseInt(eyear);
					int emonthvalue = Integer.parseInt(emonth) + 1;
					String bmonths = "01";
					int bmonthvalue = Integer.parseInt(bmonths);
					int bdayvalue = Integer.parseInt(eday) + 1;
					int edayvalue = Integer.parseInt(eday);
					int bdayvalues = MonthDays(bmonthvalue, eyearvalue);
					int edayvalues = MonthDays(emonthvalue, eyearvalue);
					if (edayvalue >= edayvalues) {
						bo.setDuraEnd(eyearvalue + "-0" + emonthvalue + "-"
								+ edayvalues);
					} else {
						bo.setDuraEnd(eyearvalue + "-0" + emonthvalue + "-"
								+ eday);
					}
					if (bdayvalue > bdayvalues) {
						bo.setDuraBegin(eyearvalue + "-" + bmonths + "-"
								+ bdayvalues);
					} else {
						if(bdayvalue<10){
							bo.setDuraBegin(eyearvalue + "-" + bmonths + "-0"+ bdayvalue);
						}else{
							bo.setDuraBegin(eyearvalue + "-" + bmonths + "-"+ bdayvalue);	
						}
					}
				}
			}else{
				String name=new SimpleDateFormat("yyyy").format(new java.util.Date());
				int nameInt=Integer.parseInt(name);
				String name1=new SimpleDateFormat("MM").format(new java.util.Date());
				int name1Int=Integer.parseInt(name1);
				int s= MonthDays(name1Int,nameInt);
				String ymd1=name+"-"+name1+"-01";
				String ymd2=name+"-"+name1+"-"+s;
				bo.setDuraID(null);
				bo.setOrgID(superId);
				bo.setDuraBegin(ymd1);
				bo.setDuraEnd(ymd2);
				bo.setDuraYear("");   
			}

		} catch (Exception e) {

		}
		return "";
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}
	
	public void issue(){
		try {
			this.bo = (AttDurationBO)this.attBusiService.findBOById(AttDurationBO.class, this.duraID);
			this.bo.setStatus("1");
			this.attBusiService.saveOrUpdateBO(bo);
			super.showMessageDetail("操作完成");
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void end(){
		try {
			this.bo = (AttDurationBO)this.attBusiService.findBOById(AttDurationBO.class, this.duraID);
			this.bo.setStatus("2");
			this.attBusiService.saveOrUpdateBO(bo);
			super.showMessageDetail("操作完成");
		} catch (SysException e) {
			e.printStackTrace();
		}		
	}
	
}
