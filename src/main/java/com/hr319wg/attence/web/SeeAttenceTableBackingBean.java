package com.hr319wg.attence.web;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttItemSetDetailBO;
import com.hr319wg.attence.pojo.bo.AttenceDayLogBO;
import com.hr319wg.attence.pojo.bo.AttenceDayMonthBO;
import com.hr319wg.attence.ucc.IAttSumDataMgrUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class SeeAttenceTableBackingBean extends BaseBackingBean {
    public final static String dayNames[] = {"日", "一", "二", "三", "四", "五", "六"};
    private String superId = super.getUserInfo().getOrgId();
    private List nowyearlist = new ArrayList();
    private String atttype = new SimpleDateFormat("yyyy").format(new java.util.Date());
    private String atttype1 = new SimpleDateFormat("MM").format(new java.util.Date());
    private String pageInit;
    private IAttSumDataMgrUCC attSumDataMgrUcc;
    private List dayValueList;
    private List flarcharList;
    private IAttenceSetUCC attenceSetUCC;
    private String queryValue;
    private String orgId = super.getUserInfo().getOrgId();
    private String beginDate = "-";
    private String endDate = "-";

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getQueryValue() {
        return queryValue;
    }

    public void setQueryValue(String queryValue) {
        this.queryValue = queryValue;
    }

    public IAttenceSetUCC getAttenceSetUCC() {
        return attenceSetUCC;
    }

    public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
        this.attenceSetUCC = attenceSetUCC;
    }

    public List getFlarcharList() {
        return flarcharList;
    }

    public void setFlarcharList(List flarcharList) {
        this.flarcharList = flarcharList;
    }

    public List getDayValueList() {
        return dayValueList;
    }

    public void setDayValueList(List dayValueList) {
        this.dayValueList = dayValueList;
    }

    public IAttSumDataMgrUCC getAttSumDataMgrUcc() {
        return attSumDataMgrUcc;
    }

    public void setAttSumDataMgrUcc(IAttSumDataMgrUCC attSumDataMgrUcc) {
        this.attSumDataMgrUcc = attSumDataMgrUcc;
    }

    private List getDayList(String years, String months) {
        List hash = new ArrayList();
        dayValueList = new ArrayList();
        SelectItem si0 = new SelectItem();
        si0.setLabel("选择");
        si0.setValue("-");
        dayValueList.add(si0);
        try {
            int year = Integer.parseInt(atttype);
            boolean isLeap = false;
            int days = 0;
            if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
                isLeap = true;
            }
            int month = Integer.parseInt(atttype1);
            if (month == 2) {
                if (isLeap) {
                    days = 29;
                } else {
                    days = 28;
                }
            } else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
                days = 31;
            } else {
                days = 30;
            }
            int begin = 1;
            int end = days;
            if (!beginDate.equals("-")) {
                begin = Integer.parseInt(beginDate);
            }

            if (!endDate.equals("-")) {
                end = Integer.parseInt(endDate);
                if (end <= begin) {
                    end = days;
                }
            }
            for (int i = 1; i <= days; i++) {
                SelectItem si = new SelectItem();
                si.setLabel(String.valueOf(i));
                si.setValue(String.valueOf(i));
                dayValueList.add(si);
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            for (int i = begin; i <= end; i++) {
                String day = "";
                if (i < 10) {
                    day = atttype + "-" + atttype1 + "-0" + i;
                } else {
                    day = atttype + "-" + atttype1 + "-" + i;
                }
                Calendar calendar = Calendar.getInstance();
                Date date = sdf.parse(day);
                calendar.setTime(date);
                int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
                String weekname = dayNames[dayOfWeek - 1];
                hash.add(day + ":" + weekname);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return hash;
    }

    public void doQuery() {
        try {
            List hash = getDayList(atttype, atttype1);
            super.getHttpSession().setAttribute("dayList", hash);
            flarcharList = new ArrayList();
            flarcharList = attenceSetUCC.getAllAttItemSetDetailBO(orgId);
            Hashtable flarcharHash = new Hashtable();
            if (flarcharList != null && flarcharList.size() > 0) {
                for (int i = 0; i < flarcharList.size(); i++) {
                    AttItemSetDetailBO bo = (AttItemSetDetailBO) flarcharList.get(i);
                    flarcharHash.put(bo.getItemCode(), bo.getFlagChar());
                }
            }
            super.getHttpSession().setAttribute("flarcharList", flarcharList);
            Hashtable personHash = new Hashtable();
            List personsList = new ArrayList();
            //2012-12-01
            List personList = attSumDataMgrUcc.getAllAttenceDayLogBO(null,((String) hash.get(0)).substring(0,10), ((String) hash.get(hash.size() - 1)).substring(0,10), superId, queryValue);
            if (personList != null && personList.size() > 0) {
                for (int i = 0; i < personList.size(); i++) {
                    AttenceDayLogBO bo = (AttenceDayLogBO) personList.get(i);
                    personHash.put(bo.getPersonId() + ":" + bo.getAttenceDate(), CommonFuns.filterNull((String) flarcharHash.get(bo.returnCodeByInstance())));
                    if (!personsList.contains(bo.getPersonId())) {
                        personsList.add(bo.getPersonId());
                    }
                }
            }
            String isAll = "1";
            Hashtable monthHash = new Hashtable();
            if (dayValueList.size()-1 == hash.size()) {//如果是全月
                List monthList = attSumDataMgrUcc.getAllAttenceDayMonthBO(null, atttype + "-" + atttype1, superId, null);
                if (monthList != null && monthList.size() > 0) {
                    for (int i = 0; i < monthList.size(); i++) {
                        AttenceDayMonthBO bo = (AttenceDayMonthBO) monthList.get(i);
                        monthHash.put(bo.getPersonId(), bo);
                    }
                }
                isAll = "1";
            } else {//如果是区间段
                NumberFormat nf = NumberFormat.getInstance();
                nf.setMaximumFractionDigits(2);
                for (int i = 0; i < personsList.size(); i++) {
                    String pid = (String) personsList.get(i);
                    if (flarcharList != null && flarcharList.size() > 0) {
                        for (int j = 0; j < flarcharList.size(); j++) {
                            double value = 0;
                            AttItemSetDetailBO bo = (AttItemSetDetailBO) flarcharList.get(j);
                            if (!bo.getItemCode().equals("00") && !bo.getItemCode().equals("01")) {
                                for (int m = 0; m < personList.size(); m++) {
                                    AttenceDayLogBO log = (AttenceDayLogBO) personList.get(m);
                                    if (log.getPersonId().equals(pid) && log.getValueByCode(bo.getItemCode()) != null && !log.getValueByCode(bo.getItemCode()).equals("")) {
                                        value += Double.parseDouble(log.getValueByCode(bo.getItemCode()));
                                    }
                                }
                                monthHash.put(pid + bo.getItemCode(), nf.format(value).replaceAll(",",""));
                            }
                        }
                    }
                }
                isAll = "0";
            }
            super.getHttpSession().setAttribute("isAll", isAll);
            super.getHttpSession().setAttribute("personsList", personsList);
            super.getHttpSession().setAttribute("personHash", personHash);
            super.getHttpSession().setAttribute("orgName", SysCacheTool.findOrgById(superId).getName());
            super.getHttpSession().setAttribute("monthValue", atttype + "年" + atttype1 + "月");
            super.getHttpSession().setAttribute("monthHash", monthHash);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getPageInit() {
        if (super.getRequestParameter("superId") != null) {
            superId = super.getRequestParameter("superId");
        }
        doQuery();
        return pageInit;
    }

    public void setPageInit(String pageInit) {
        this.pageInit = pageInit;
    }

    public void doQueryYear() {
        if (nowyearlist != null && nowyearlist.size() > 0) {
            nowyearlist = new ArrayList();
        }
        String nowyear = new SimpleDateFormat("yyyy").format(new java.util.Date());
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

    public List getNowyearlist() {
        doQueryYear();
        return nowyearlist;
    }

    public void setNowyearlist(List nowyearlist) {
        this.nowyearlist = nowyearlist;
    }

    public String getAtttype() {
        return atttype;
    }

    public void setAtttype(String atttype) {
        this.atttype = atttype;
    }

    public String getAtttype1() {
        return atttype1;
    }

    public void setAtttype1(String atttype1) {
        this.atttype1 = atttype1;
    }

    public void changeStatus(ValueChangeEvent event) {
        this.atttype = event.getNewValue().toString();
    }

    public String getSuperId() {
        return superId;
    }

    public void setSuperId(String superId) {
        this.superId = superId;
    }

}
