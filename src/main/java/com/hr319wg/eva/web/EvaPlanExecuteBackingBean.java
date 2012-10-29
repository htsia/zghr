package com.hr319wg.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaCaclControlBO;
import com.hr319wg.eva.pojo.vo.EvaMastersVO;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaPlanMixBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import java.util.ArrayList;
import java.util.List;

/**
 * 绩效管理BackingBean
 * 负责绩效管理模块后台和展现之间的数据中转处理
 */
public class EvaPlanExecuteBackingBean extends BaseBackingBean {
    private IEvaPlanUCC evaplanucc;
    private IEvaScoreUCC scoreucc;
    private List planList;
    private String status;
    private String initPlanAudit;
    private String planID;
    private String pageInitDept;
    private String deptId;

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public void queryPlanList2() {
        try {
            String[] status = {EvaPlanBO.EVA_PLANSTATUS_EXECUTE, EvaPlanBO.EVA_PLANSTATUS_AppovResult, EvaPlanBO.EVA_PLANSTATUS_AppovResultED, EvaPlanBO.EVA_PLANSTATUS_FINISH};
            planList = new ArrayList();
            List list = evaplanucc.findByOrgAndStatus(status, super.getUserInfo().getOrgId());
            for (int i = 0; i < list.size(); i++) {
                EvaPlanBO ebo = (EvaPlanBO) list.get(i);
                PersonBO pbo = SysCacheTool.findPersonById(ebo.getCreatePersonId());
                ebo.setCreatePersonName(pbo.getName());
                if (ebo.getEvaModel() != null && ebo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)) {
                    planList.add(ebo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getPageInitDept() {
        queryPlanList2();
        return pageInitDept;
    }

    public void setPageInitDept(String pageInitDept) {
        this.pageInitDept = pageInitDept;
    }

    public String getPlanID() {
        return planID;
    }

    public void setPlanID(String planID) {
        this.planID = planID;
    }

    public String getInitPlanAudit() {
        queryPlanList();
        return initPlanAudit;
    }

    public void setInitPlanAudit(String initPlanAudit) {
        this.initPlanAudit = initPlanAudit;
    }

    public String getPageInit() {
        queryPlanList();
        return "";
    }

    public void queryPlanList() {
        try {
            String[] status = {EvaPlanBO.EVA_PLANSTATUS_EXECUTE, EvaPlanBO.EVA_PLANSTATUS_AppovResult, EvaPlanBO.EVA_PLANSTATUS_AppovResultED, EvaPlanBO.EVA_PLANSTATUS_FINISH};
            planList = evaplanucc.findByOrgAndStatus(status, super.getUserInfo().getOrgId());
            for (int i = 0; i < planList.size(); i++) {
                EvaPlanBO ebo = (EvaPlanBO) planList.get(i);
                PersonBO pbo = SysCacheTool.findPersonById(ebo.getCreatePersonId());
                ebo.setCreatePersonName(pbo.getName());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void changeStatus(ValueChangeEvent event) {
        this.status = event.getNewValue().toString();
    }

    public List getPlanList() {
        return planList;
    }

    public void setPlanList(List list) {
        planList = list;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String s) {
        status = s;
    }

    public String calc() {
        try {
            EvaPlanBO bo = this.evaplanucc.findPlanById(planID);
            if (bo.getIsVirtual().equals("1")) {
                this.scoreucc.caclVirtualPlan(planID);
            } else {
                this.scoreucc.calc(this.planID);
            }
            super.showMessageDetail("计算成功！");
        } catch (Exception e) {
            e.printStackTrace();
            super.showMessageDetail("计算失败！");
        }
        return "";
    }

    public String forAuduitResult() {
        try {
            EvaPlanBO bo = this.evaplanucc.findPlanById(planID);
            bo.setStatus(EvaPlanBO.EVA_PLANSTATUS_AppovResult);
            evaplanucc.updatePlan(bo);
            List mixlist = evaplanucc.getAllEvaPlanMixBOByPlanId(planID);
            if (mixlist != null && mixlist.size() > 0) {
                for (int i = 0; i < mixlist.size(); i++) {
                    EvaPlanMixBO mix = (EvaPlanMixBO) mixlist.get(i);
                    EvaPlanBO po = this.evaplanucc.findPlanById(mix.getMixPlan());
                    po.setStatus(EvaPlanBO.EVA_PLANSTATUS_AppovResult);
                    evaplanucc.updatePlan(po);
                }
            }
            super.showMessageDetail("报批成功！");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String beginMark() {
        try {
            EvaPlanBO ebo = this.evaplanucc.findPlanById(this.planID);
            ebo.setAllowMark("1");
            evaplanucc.updatePlan(ebo);
            super.showMessageDetail("开始打分！");
        } catch (Exception e) {
            e.printStackTrace();
            super.showMessageDetail("开始打分失败！");
        }
        return "";
    }

    public String endMark() {
        try {
            EvaPlanBO ebo = this.evaplanucc.findPlanById(this.planID);
            ebo.setAllowMark("0");
            evaplanucc.updatePlan(ebo);
            super.showMessageDetail("结束打分！");
        } catch (Exception e) {
            e.printStackTrace();
            super.showMessageDetail("结束打分失败！");
        }
        return "";
    }

    public String changeSetMode() {
        try {
            EvaPlanBO ebo = this.evaplanucc.findPlanById(this.planID);
            ebo.setCaclMode("1");
            this.evaplanucc.updatePlan(ebo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String changeCommonMode() {
        try {
            EvaPlanBO ebo = this.evaplanucc.findPlanById(this.planID);
            ebo.setCaclMode("0");
            this.evaplanucc.updatePlan(ebo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public IEvaPlanUCC getEvaplanucc() {
        return evaplanucc;
    }

    public void setEvaplanucc(IEvaPlanUCC ucc) {
        evaplanucc = ucc;
    }

    public IEvaScoreUCC getScoreucc() {
        return scoreucc;
    }

    public void setScoreucc(IEvaScoreUCC scoreucc) {
        this.scoreucc = scoreucc;
    }

    //虚拟计划编辑
    private String planName;
    private String isVirtual = "1";

    private String initMixPlan;
    private List mixPlanList;
    private String mixId;

    private String initEdit;
    private EvaPlanMixBO mixBo;
    private List exePlanList;

    public String saveMixBo() {
        try {
            mixBo.setPlanId(planID);
            evaplanucc.saveEvaPlanMixBO(mixBo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitEdit() {
        if (super.getRequestParameter("planID") != null) {
            planID = super.getRequestParameter("planID");
            mixBo = new EvaPlanMixBO();
        }
        return initEdit;
    }

    public void setInitEdit(String initEdit) {
        this.initEdit = initEdit;
    }

    public EvaPlanMixBO getMixBo() {
        return mixBo;
    }

    public void setMixBo(EvaPlanMixBO mixBo) {
        this.mixBo = mixBo;
    }

    public List getExePlanList() {
        try {
            exePlanList = new ArrayList();
            List list = this.evaplanucc.findPublishPlan(EvaPlanBO.EVA_PLANSTATUS_EXECUTE, super.getUserInfo().getOrgId());
            if (list != null && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    EvaPlanBO bo = (EvaPlanBO) list.get(i);
                    SelectItem si = new SelectItem();
                    si.setLabel(bo.getPlanName());
                    si.setValue(bo.getPlanId());
                    exePlanList.add(si);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exePlanList;
    }

    public void setExePlanList(List exePlanList) {
        this.exePlanList = exePlanList;
    }

    public String deleteMix() {
        try {
            this.evaplanucc.deleteEvaPlanMixBO(mixId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public void doQueryMix() {
        try {
            mixPlanList = evaplanucc.getAllEvaPlanMixBOByPlanId(planID);
            if (mixPlanList != null && mixPlanList.size() > 0) {
                for (int i = 0; i < mixPlanList.size(); i++) {
                    EvaPlanMixBO bo = (EvaPlanMixBO) mixPlanList.get(i);
                    EvaPlanBO ebo = evaplanucc.findPlanById(bo.getMixPlan());
                    bo.setPlanName(ebo.getPlanName());
                    bo.setBeginDate(ebo.getBeginDate());
                    bo.setCreatePersonName(SysCacheTool.findPersonById(ebo.getCreatePersonId()).getName());
                    bo.setEndDate(ebo.getEndDate());
                    bo.setEvaModelDes(ebo.getEvaModelDes());
                    mixPlanList.set(i, bo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getInitMixPlan() {
        if (super.getRequestParameter("planID") != null) {
            planID = super.getRequestParameter("planID");
        }
        doQueryMix();
        return initMixPlan;
    }

    public void setInitMixPlan(String initMixPlan) {
        this.initMixPlan = initMixPlan;
    }

    public List getMixPlanList() {
        return mixPlanList;
    }

    public void setMixPlanList(List mixPlanList) {
        this.mixPlanList = mixPlanList;
    }

    public String getMixId() {
        return mixId;
    }

    public void setMixId(String mixId) {
        this.mixId = mixId;
    }

    public String save() {
        try {
            EvaPlanBO bo = new EvaPlanBO();
            bo.setPlanName(planName);
            bo.setIsVirtual(isVirtual);
            bo.setStatus(EvaPlanBO.EVA_PLANSTATUS_EXECUTE);
            bo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            bo.setCreatePersonId(super.getUserInfo().getUserId());
            bo.setOrgId(super.getUserInfo().getOrgId());
            bo.setEvaModel("4");
            evaplanucc.createPlan(bo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getIsVirtual() {
        return isVirtual;
    }

    public void setIsVirtual(String isVirtual) {
        this.isVirtual = isVirtual;
    }

    //配置计算模式
    private String initCtr;
    private List ctrList;
    private IEvaKeyItemUCC evaKeyItemUCC;
    private String itemId;

    public String setCommonMode(){
        try{
              EvaCaclControlBO bo=this.evaplanucc.findEvaCaclControlBOByItemId(itemId);
              bo.setCaclMode("0");
              evaplanucc.saveEvaCaclControlBO(bo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public String setOtherMode(){
        try{
             EvaCaclControlBO bo=this.evaplanucc.findEvaCaclControlBOByItemId(itemId);
              bo.setCaclMode("1");
              evaplanucc.saveEvaCaclControlBO(bo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

     public String setOtherMode1(){
        try{
             EvaCaclControlBO bo=this.evaplanucc.findEvaCaclControlBOByItemId(itemId);
             bo.setSelScoreMode("0");
              evaplanucc.saveEvaCaclControlBO(bo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

     public String setOtherMode2(){
        try{
             EvaCaclControlBO bo=this.evaplanucc.findEvaCaclControlBOByItemId(itemId);
              bo.setSelScoreMode("1");
              evaplanucc.saveEvaCaclControlBO(bo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

     public String setOtherMode3(){
        try{
             EvaCaclControlBO bo=this.evaplanucc.findEvaCaclControlBOByItemId(itemId);
             bo.setSelScoreMode("2");
              evaplanucc.saveEvaCaclControlBO(bo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }


    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public IEvaKeyItemUCC getEvaKeyItemUCC() {
        return evaKeyItemUCC;
    }

    public void setEvaKeyItemUCC(IEvaKeyItemUCC evaKeyItemUCC) {
        this.evaKeyItemUCC = evaKeyItemUCC;
    }

    public void queryCtr() {
        try {
            ctrList = this.evaplanucc.getAllEvaCaclControlBOByPlanId(planID);
            if (ctrList != null && ctrList.size() > 0) {
                for (int i = 0; i < ctrList.size(); i++) {
                    EvaCaclControlBO bo = (EvaCaclControlBO) ctrList.get(i);
                    bo.setTemplateId(evaKeyItemUCC.findTemplateBO(bo.getTemplateId()).getTemplateName());
                    bo.setMasterType(CodeUtil.interpertCode(bo.getMasterType()));
                    ctrList.set(i, bo);
                }
            } else {
                List voList = this.scoreucc.getAllEvaMastersVOByPlanId(planID);
                if (voList != null && voList.size() > 0) {
                    for (int i = 0; i < voList.size(); i++) {
                        EvaMastersVO vo = (EvaMastersVO) voList.get(i);
                        EvaCaclControlBO bo = new EvaCaclControlBO();
                        bo.setPlanId(planID);
                        bo.setMasterType(vo.getMasterType());
                        bo.setTemplateId(vo.getTemplateId());
                        bo.setCaclMode("0");
                        bo.setSelScoreMode("0");
                        evaplanucc.saveEvaCaclControlBO(bo);
                    }
                }
                ctrList = this.evaplanucc.getAllEvaCaclControlBOByPlanId(planID);
                if (ctrList != null && ctrList.size() > 0) {
                    for (int i = 0; i < ctrList.size(); i++) {
                        EvaCaclControlBO bo = (EvaCaclControlBO) ctrList.get(i);
                        bo.setTemplateId(evaKeyItemUCC.findTemplateBO(bo.getTemplateId()).getTemplateName());
                        bo.setMasterType(CodeUtil.interpertCode(bo.getMasterType()));
                        ctrList.set(i, bo);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getInitCtr() {
        if (super.getRequestParameter("planId") != null) {
            planID = super.getRequestParameter("planId");
        }
        queryCtr();
        return initCtr;
    }

    public void setInitCtr(String initCtr) {
        this.initCtr = initCtr;
    }

    public List getCtrList() {
        return ctrList;
    }

    public void setCtrList(List ctrList) {
        this.ctrList = ctrList;
    }
}
