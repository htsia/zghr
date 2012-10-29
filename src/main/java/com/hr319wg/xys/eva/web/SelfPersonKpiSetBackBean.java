package com.hr319wg.xys.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC;

import javax.faces.event.ValueChangeEvent;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-14
 * Time: 上午12:41
 * To change this template use File | Settings | File Templates.
 */
public class SelfPersonKpiSetBackBean extends BaseBackingBean {
    private IXysEvaPlanUCC xysEvaPlanUCC;
    private IXysKpiPersonUCC xysKpiPersonUCC;
    private String pageInit;
    private List objList;
    private String objId;
    private boolean selectAll = false;

    public String submitObj() {
        try {
            XysKpiPersonObjBO obj = xysKpiPersonUCC.findXysKpiPersonObjBOById(objId);
            obj.setKeyStatus("2");//报批
            xysKpiPersonUCC.saveXysKpiPersonObjBO(obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public void queryAll(ValueChangeEvent event) {
        selectAll = "true".equals(event.getNewValue().toString());
        doQuery();
    }

    public IXysEvaPlanUCC getXysEvaPlanUCC() {
        return xysEvaPlanUCC;
    }

    public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
        this.xysEvaPlanUCC = xysEvaPlanUCC;
    }

    public IXysKpiPersonUCC getXysKpiPersonUCC() {
        return xysKpiPersonUCC;
    }

    public void setXysKpiPersonUCC(IXysKpiPersonUCC xysKpiPersonUCC) {
        this.xysKpiPersonUCC = xysKpiPersonUCC;
    }

    public void doQuery() {
        try {
            if (selectAll) {
                objList = xysKpiPersonUCC.getSelfXysKpiPersonObjBO(super.getUserInfo().getUserId(), null);
            } else {
                String where = " and bo.planId in(select vo.planId from XysEvaPlanBO vo " +
                        "where vo.status='" + XysEvaPlanBO.STATUS_ZBGJ + "' or vo.status='"+XysEvaPlanBO.STATUS_ZHIXING+"')";
                objList = xysKpiPersonUCC.getSelfXysKpiPersonObjBO(super.getUserInfo().getUserId(), where);
            }
            if (objList != null && objList.size() > 0) {
                for (int i = 0; i < objList.size(); i++) {
                    XysKpiPersonObjBO obj = (XysKpiPersonObjBO) objList.get(i);
                    XysEvaPlanBO plan = xysEvaPlanUCC.findXysEvaPlanBOById(obj.getPlanId());
                    PersonBO pbo = SysCacheTool.findPersonById(obj.getPersonId());
                    obj.setPlanName(CommonFuns.filterNull(plan.getPlanName()));
                    obj.setYear(CommonFuns.filterNull(plan.getYear()));
                    obj.setPersonName(pbo.getName());
                    obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId()).getName());
                    obj.setPostName(PostTool.getPostName(pbo.getPostId()));
                    objList.set(i, obj);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getPageInit() {
        doQuery();
        return pageInit;
    }

    public void setPageInit(String pageInit) {
        this.pageInit = pageInit;
    }

    public List getObjList() {
        return objList;
    }

    public void setObjList(List objList) {
        this.objList = objList;
    }

    public String getObjId() {
        return objId;
    }

    public void setObjId(String objId) {
        this.objId = objId;
    }

    public boolean isSelectAll() {
        return selectAll;
    }

    public void setSelectAll(boolean selectAll) {
        this.selectAll = selectAll;
    }

    //审批个人KPI
    private String initDeptAudit;
    private String initAudit;

   
    public void queryAudit() {
        try {
           
            String where = " and bo.planId in(select vo.planId from XysEvaPlanBO vo " +
                        "where vo.status='" + XysEvaPlanBO.STATUS_ZBGJ + "' or vo.status='"+XysEvaPlanBO.STATUS_ZHIXING+"')";
            objList = xysKpiPersonUCC.getXysKpiPersonObjBOForSelf(super.getUserInfo().getUserId(), where);
         
            if (objList != null && objList.size() > 0) {
                for (int i = 0; i < objList.size(); i++) {
                    XysKpiPersonObjBO obj = (XysKpiPersonObjBO) objList.get(i);
                    XysEvaPlanBO plan = xysEvaPlanUCC.findXysEvaPlanBOById(obj.getPlanId());
                    PersonBO pbo = SysCacheTool.findPersonById(obj.getPersonId());
                    obj.setPlanName(CommonFuns.filterNull(plan.getPlanName()));
                    obj.setYear(CommonFuns.filterNull(plan.getYear()));
                    obj.setPersonName(pbo.getName());
                    obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId()).getName());
                    obj.setPostName(PostTool.getPostName(pbo.getPostId()));
                    objList.set(i, obj);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getInitDeptAudit() {
        queryAudit();
        return initDeptAudit;
    }

    public void setInitDeptAudit(String initDeptAudit) {
        this.initDeptAudit = initDeptAudit;
    }

     //通过
    public String auditPass() {
        try {
            XysKpiPersonObjBO obj = xysKpiPersonUCC.findXysKpiPersonObjBOById(objId);
            obj.setKeyStatus("3");//通过
            xysKpiPersonUCC.saveXysKpiPersonObjBO(obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    //退回
    public String auditOut() {
        try {
           XysKpiPersonObjBO obj = xysKpiPersonUCC.findXysKpiPersonObjBOById(objId);
            obj.setKeyStatus("F");//退回
            xysKpiPersonUCC.saveXysKpiPersonObjBO(obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }
    public String getInitAudit() {
        if (super.getRequestParameter("objId") != null) {
            objId = super.getRequestParameter("objId");
            super.getHttpSession().setAttribute("objId", objId);
        }
        return initAudit;
    }

    public void setInitAudit(String initAudit) {
        this.initAudit = initAudit;
    }
}
