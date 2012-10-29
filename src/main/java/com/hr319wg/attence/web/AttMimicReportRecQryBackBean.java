package com.hr319wg.attence.web;

import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRecordBO;
import com.hr319wg.attence.pojo.bo.AttMimicReportRecBO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.util.CommonFuns;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-12-13
 * Time: 下午3:13
 * To change this template use File | Settings | File Templates.
 */
public class AttMimicReportRecQryBackBean extends BaseBackingBean {
    private IAttAnnualUCC attAnnualUCC;
    private String pageInit;
    private String personValue;
    private String timeValue;
    private String superId = super.getUserInfo().getDeptId();
    private PageVO mypage = new PageVO();
    private List personList;
    private String statusValue;

    public String getStatusValue() {
        return statusValue;
    }

    public void setStatusValue(String statusValue) {
        this.statusValue = statusValue;
    }

    public List getPersonList() {
        return personList;
    }

    public void setPersonList(List personList) {
        this.personList = personList;
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
            personList = this.attAnnualUCC.getAllAttMimicReportRecBO(mypage, superId, personValue, timeValue, statusValue);
            if (personList != null && personList.size() > 0) {
                for (int i = 0; i < personList.size(); i++) {
                    AttMimicReportRecBO bo = (AttMimicReportRecBO) personList.get(i);
                    bo.setPersonID(SysCacheTool.findPersonById(bo.getPersonID()).getName());
                    personList.set(i, bo);
                }
            }
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

    public PageVO getMypage() {
        return mypage;
    }

    public void setMypage(PageVO mypage) {
        this.mypage = mypage;
    }

    public String getSuperId() {
        return superId;
    }

    public void setSuperId(String superId) {
        this.superId = superId;
    }

    public String getTimeValue() {
        return timeValue;
    }

    public void setTimeValue(String timeValue) {
        this.timeValue = timeValue;
    }

    public String getPersonValue() {
        return personValue;
    }

    public void setPersonValue(String personValue) {
        this.personValue = personValue;
    }

    // 年假拟报增加和修改
    private String initEdit;
    private String personId;
    private String personName;
    private String personNames;
    private String personIds;
    private String operType;
    private String mimicReportNO;
    private String mrYear;
    private String mrMonth;
    private String dest;
    private String lastDate;

    public String delete() {
        try {
            this.attAnnualUCC.deleteAttMimicReportRecBO(mimicReportNO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String apprive() {
        try {
            AttMimicReportRecBO bo=this.attAnnualUCC.findAttMimicReportRecBOById(mimicReportNO);
            WFTransaction wt = new WFTransaction();
			wt.setLinkID(mimicReportNO);
			wt.setOperID("0525");
			wt.setUser(super.getUserInfo());
			wt.setWfType("KQGL_007");
			wt.setStatusValue(AttMimicReportRecBO.APPROVING); // 审批状态
			wt.setWffunction("att_WorkFlowMrNetWorkHolidayService");
			attAnnualUCC.processTrans(wt);
            bo.setStatusValue("0");
			attAnnualUCC.saveAttMimicReportRecBO(bo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }


    public String getMrYear() {
        return mrYear;
    }

    public void setMrYear(String mrYear) {
        this.mrYear = mrYear;
    }

    public String getMrMonth() {
        return mrMonth;
    }

    public void setMrMonth(String mrMonth) {
        this.mrMonth = mrMonth;
    }

    public String getDest() {
        return dest;
    }

    public void setDest(String dest) {
        this.dest = dest;
    }

    public String getLastDate() {
        return lastDate;
    }

    public void setLastDate(String lastDate) {
        this.lastDate = lastDate;
    }

    public String getMimicReportNO() {
        return mimicReportNO;
    }

    public void setMimicReportNO(String mimicReportNO) {
        this.mimicReportNO = mimicReportNO;
    }

    public String save() {
        try {
            if (operType.equals("edit")) {
                AttMimicReportRecBO bo = attAnnualUCC.findAttMimicReportRecBOById(mimicReportNO);
                bo.setLastDate(lastDate);
                bo.setMrYear(mrYear);
                bo.setMrMonth(mrMonth);
                bo.setDest(dest);
                attAnnualUCC.saveAttMimicReportRecBO(bo);
            } else if (operType.equals("add")) {
                if (personIds != null && !personIds.equals("")) {
                    String ids[] = personIds.split(",");
                    for (int i = 0; i < ids.length; i++) {
                        AttMimicReportRecBO bo = new AttMimicReportRecBO();
                        bo.setMrYear(mrYear);
                        bo.setPersonID(ids[i]);
                        bo.setMrMonth(mrMonth);
                        bo.setLastDate(lastDate);
                        bo.setDest(dest);
                        bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                        bo.setStatusValue("-1");
                        attAnnualUCC.saveAttMimicReportRecBO(bo);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    public String selPerson() {
        PersonBO[] pbos = (PersonBO[]) super.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
        String names = "";
        String ids = "";
        if (pbos != null && pbos.length > 0) {
            for (int i = 0; i < pbos.length; i++) {
                names += pbos[i].getName() + ",";
                ids += pbos[i].getPersonId() + ",";
            }
        }
        personNames = names;
        personIds = ids;
        return "";
    }

    public String getInitEdit() {
        try {
            AttAnnualRecordBO attannualrecordbo = attAnnualUCC.findExcuteAttAnnualRecordBO(super.getUserInfo().getOrgId());
            if (super.getRequestParameter("operType") != null) {
                operType = super.getRequestParameter("operType");
                if (operType.equals("edit")) {
                    if (super.getRequestParameter("mimicReportNO") != null) {
                        mimicReportNO = super.getRequestParameter("mimicReportNO");
                        AttMimicReportRecBO bo = attAnnualUCC.findAttMimicReportRecBOById(mimicReportNO);
                        personId = bo.getPersonID();
                        personName = SysCacheTool.findPersonById(personId).getName();
                        mrYear=bo.getMrYear();
                        mrMonth = bo.getMrMonth();
                        dest = bo.getDest();
                        lastDate = bo.getLastDate();
                    }
                } else if (operType.equals("add")) {
                    personIds = "";
                    personNames = "";
                    mrMonth = "";
                    dest = "";
                    lastDate = "";
                    if (attannualrecordbo != null) {
                        mrYear = attannualrecordbo.getRecodeYear();
                    }
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return initEdit;
    }

    public void setInitEdit(String initEdit) {
        this.initEdit = initEdit;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getPersonNames() {
        return personNames;
    }

    public void setPersonNames(String personNames) {
        this.personNames = personNames;
    }

    public String getOperType() {
        return operType;
    }

    public void setOperType(String operType) {
        this.operType = operType;
    }

    public String getPersonIds() {
        return personIds;
    }

    public void setPersonIds(String personIds) {
        this.personIds = personIds;
    }

    public IAttAnnualUCC getAttAnnualUCC() {
        return attAnnualUCC;
    }

    public void setAttAnnualUCC(IAttAnnualUCC attAnnualUCC) {
        this.attAnnualUCC = attAnnualUCC;
    }
}
