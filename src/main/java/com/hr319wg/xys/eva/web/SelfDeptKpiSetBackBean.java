package com.hr319wg.xys.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjBO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;

import javax.faces.event.ValueChangeEvent;
import java.util.List;


public class SelfDeptKpiSetBackBean extends BaseBackingBean {
    private IXysKpiDeptUCC xysKpiDeptUCC;
    private IXysEvaPlanUCC xysEvaPlanUCC;
    private String pageInit;
    private List objList;
    private String objId;
    private boolean selectAll = false;

    public String submitObj() {
        try {
            XysKpiDeptObjBO obj = xysKpiDeptUCC.findXysKpiDeptObjBOById(objId);
            obj.setKeyStatus("2");//报批
            xysKpiDeptUCC.saveXysKpiDeptObjBO(obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public boolean isSelectAll() {
        return selectAll;
    }

    public void setSelectAll(boolean selectAll) {
        this.selectAll = selectAll;
    }

    public void queryAll(ValueChangeEvent event) {
        selectAll = "true".equals(event.getNewValue().toString());
        doQuery();
    }

    public IXysKpiDeptUCC getXysKpiDeptUCC() {
        return xysKpiDeptUCC;
    }

    public void setXysKpiDeptUCC(IXysKpiDeptUCC xysKpiDeptUCC) {
        this.xysKpiDeptUCC = xysKpiDeptUCC;
    }

    public IXysEvaPlanUCC getXysEvaPlanUCC() {
        return xysEvaPlanUCC;
    }

    public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
        this.xysEvaPlanUCC = xysEvaPlanUCC;
    }

    public void doQuery() {
        try {
            if (selectAll) {
                objList = xysKpiDeptUCC.getXysKpiDeptObjBOInSelf(super.getUserInfo().getUserId(), null);
            } else {
                String where = " and bo.planId in(select vo.planId from XysEvaPlanBO vo " +
                        "where vo.status='" + XysEvaPlanBO.STATUS_ZBGJ + "'or vo.status='"+XysEvaPlanBO.STATUS_ZHIXING+"')";
                objList = xysKpiDeptUCC.getXysKpiDeptObjBOInSelf(super.getUserInfo().getUserId(), where);
            }
            if (objList != null && objList.size() > 0) {
                for (int i = 0; i < objList.size(); i++) {
                    XysKpiDeptObjBO obj = (XysKpiDeptObjBO) objList.get(i);
                    XysEvaPlanBO plan = xysEvaPlanUCC.findXysEvaPlanBOById(obj.getPlanId());
                    PersonBO pbo = SysCacheTool.findPersonById(obj.getPersonId());
                    obj.setPlanName(CommonFuns.filterNull(plan.getPlanName()));
                    obj.setYear(CommonFuns.filterNull(plan.getYear()));
                    obj.setPersonName(pbo.getName());
                    obj.setDeptName(SysCacheTool.findOrgById(obj.getDeptId()).getName());
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

    //部门指标审批
    private String initDeptAudit;
    private String initAudit;
   

    //通过
    public String auditPass() {
        try {
            XysKpiDeptObjBO obj = xysKpiDeptUCC.findXysKpiDeptObjBOById(objId);
            obj.setKeyStatus("3");//通过
            xysKpiDeptUCC.saveXysKpiDeptObjBO(obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    //退回
    public String auditOut() {
        try {
            XysKpiDeptObjBO obj = xysKpiDeptUCC.findXysKpiDeptObjBOById(objId);
            obj.setKeyStatus("F");//退回
            xysKpiDeptUCC.saveXysKpiDeptObjBO(obj);
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

    public void queryAudit() {
        try {
        	PersonBO pbo1=SysCacheTool.findPersonById(super.getUserInfo().getUserId());
        	String where=" and bo.personId in(select po.personId from " +
        			"PersonBO po where po.postId in(select wo.postId " +
        			"from XysWeightSetBO wo where wo.evaType='1' and wo.evaPostId='"+pbo1.getPostId()+"' and bo.planId=wo.planId))";
          
            where += " and bo.planId in(select vo.planId from XysEvaPlanBO vo " +
                        "where vo.status='" + XysEvaPlanBO.STATUS_ZBGJ + "' or vo.status='"+XysEvaPlanBO.STATUS_ZHIXING+"')";
            objList = xysKpiDeptUCC.getXysKpiDeptObjBOInSelf(null, where);
            if (objList != null && objList.size() > 0) {
                for (int i = 0; i < objList.size(); i++) {
                    XysKpiDeptObjBO obj = (XysKpiDeptObjBO) objList.get(i);
                    XysEvaPlanBO plan = xysEvaPlanUCC.findXysEvaPlanBOById(obj.getPlanId());
                    PersonBO pbo = SysCacheTool.findPersonById(obj.getPersonId());
                    obj.setPlanName(CommonFuns.filterNull(plan.getPlanName()));
                    obj.setYear(CommonFuns.filterNull(plan.getYear()));
                    obj.setPersonName(pbo.getName());
                    obj.setDeptName(SysCacheTool.findOrgById(obj.getDeptId()).getName());
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

}
