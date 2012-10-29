package com.hr319wg.xys.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-27
 * Time: 上午10:29
 * To change this template use File | Settings | File Templates.
 */
public class XysEvaPlanBackBean extends BaseBackingBean {
    private IXysEvaPlanUCC xysEvaPlanUCC;
    private String pageInit;
    private PageVO mypage = new PageVO();
    private List planList;
    private IEvaGradeUCC evaGradeUCC;
    private String planId;

    public String deletePlan(){
        try{
            xysEvaPlanUCC.deleteXysEvaPlanBO(planId);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public String setContent(){
        try{
            XysEvaPlanBO bo=xysEvaPlanUCC.findXysEvaPlanBOById(planId);
            bo.setStatus(XysEvaPlanBO.STATUS_ZBGJ);
            xysEvaPlanUCC.saveXysEvaPlanBO(bo);
            super.showMessageDetail("操作成功！");
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public String exePlan(){
        try{
            XysEvaPlanBO bo=xysEvaPlanUCC.findXysEvaPlanBOById(planId);
            bo.setStatus(XysEvaPlanBO.STATUS_ZHIXING);
            xysEvaPlanUCC.saveXysEvaPlanBO(bo);
            super.showMessageDetail("操作成功！");
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
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
            if(mypage.getCurrentPage()==0){
               mypage.setCurrentPage(1);
            }
            planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage,super.getUserInfo().getOrgId(),null);
            if(planList!=null&&planList.size()>0){
                for(int i=0;i<planList.size();i++){
                    XysEvaPlanBO bo=(XysEvaPlanBO)planList.get(i);
                    EvaGradeBO grade=evaGradeUCC.getGradeByID(bo.getPlanGrade());
                    bo.setPlanGrade(grade.getGradeName());
                    bo.setPlanType(CodeUtil.interpertCode(bo.getPlanType()));
                    planList.set(i,bo);
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

    public PageVO getMypage() {
        return mypage;
    }

    public void setMypage(PageVO mypage) {
        this.mypage = mypage;
    }

    public List getPlanList() {
        return planList;
    }

    public void setPlanList(List planList) {
        this.planList = planList;
    }

    public IEvaGradeUCC getEvaGradeUCC() {
        return evaGradeUCC;
    }

    public void setEvaGradeUCC(IEvaGradeUCC evaGradeUCC) {
        this.evaGradeUCC = evaGradeUCC;
    }

    public IXysEvaPlanUCC getXysEvaPlanUCC() {
        return xysEvaPlanUCC;
    }

    public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
        this.xysEvaPlanUCC = xysEvaPlanUCC;
    }
    //考核计划编辑
    private String initEdit;
    private XysEvaPlanBO planBO=new XysEvaPlanBO();

    public String savePlan(){
        try{
            planBO.setStatus(XysEvaPlanBO.STATUS_QICAO);
            planBO.setCreateOrg(super.getUserInfo().getOrgId());
            xysEvaPlanUCC.saveXysEvaPlanBO(planBO);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "success";
    }
    public String getInitEdit() {
        try{
            if(super.getRequestParameter("planId")!=null){
                planId=super.getRequestParameter("planId");
                planBO=xysEvaPlanUCC.findXysEvaPlanBOById(planId);
            }else if(super.getRequestParameter("new")!=null){
                planBO.initRow();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return initEdit;
    }

    public void setInitEdit(String initEdit) {
        this.initEdit = initEdit;
    }

    public XysEvaPlanBO getPlanBO() {
        return planBO;
    }

    public void setPlanBO(XysEvaPlanBO planBO) {
        this.planBO = planBO;
    }
}
