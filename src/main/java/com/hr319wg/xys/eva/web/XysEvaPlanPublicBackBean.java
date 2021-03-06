package com.hr319wg.xys.eva.web;

import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.ucc.IXysEvaObjUCC;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;

public class XysEvaPlanPublicBackBean extends BaseBackingBean {
	 //查看计划
    private IXysEvaPlanUCC xysEvaPlanUCC;
    private String pageInit;
    private PageVO mypage = new PageVO();
    private List planList;
    private IEvaGradeUCC evaGradeUCC;
    private String planId;
    private boolean selectAll = false;
    private String publicType="2";//1自然分布2强制分布
    private IXysEvaObjUCC xysEvaObjUcc;
    
    
    public IXysEvaObjUCC getXysEvaObjUcc() {
		return xysEvaObjUcc;
	}
	public void setXysEvaObjUcc(IXysEvaObjUCC xysEvaObjUcc) {
		this.xysEvaObjUcc = xysEvaObjUcc;
	}
	public String getPublicType() {
		return publicType;
	}
	public void setPublicType(String publicType) {
		this.publicType = publicType;
	}
	//发布结果
    public void publicResult(){
    	try{
    		this.xysEvaObjUcc.publicEvaPlanResult(super.getUserInfo(),planId, publicType);
    		super.showMessageDetail("发布成功！");
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }
    public void finishPlan(){
    	try{
    		XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
    		bo.setStatus(XysEvaPlanBO.STATUS_JIESHU);
    		xysEvaPlanUCC.saveXysEvaPlanBO(bo);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
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
	            if(selectAll){
	                planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage,super.getUserInfo().getOrgId(),null);
	            }else{
	                planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage,super.getUserInfo().getOrgId(),new String[]{XysEvaPlanBO.STATUS_JGSP,XysEvaPlanBO.STATUS_JGFB,XysEvaPlanBO.STATUS_JIESHU});
	            }
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
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public boolean isSelectAll() {
		return selectAll;
	}
	public void setSelectAll(boolean selectAll) {
		this.selectAll = selectAll;
	}
}
