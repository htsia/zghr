package com.hr319wg.xys.eva.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjScoreBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360SbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysScoreCtrBO;
import com.hr319wg.xys.eva.ucc.IXys360UCC;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;

public class Person360AuditBackBean extends BaseBackingBean {
	private IXys360UCC xys360UCC;
	private IXysEvaPlanUCC xysEvaPlanUCC;
	private String pageInit;
	private List objList;
	private String objId;
	private List objList2;
	
	
	public List getObjList2() {
		return objList2;
	}
	public void setObjList2(List objList2) {
		this.objList2 = objList2;
	}
	public IXys360UCC getXys360UCC() {
		return xys360UCC;
	}
	public void setXys360UCC(IXys360UCC xys360ucc) {
		xys360UCC = xys360ucc;
	}
	public IXysEvaPlanUCC getXysEvaPlanUCC() {
		return xysEvaPlanUCC;
	}
	public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
		this.xysEvaPlanUCC = xysEvaPlanUCC;
	}
	public void doQuery() {
		try {
			List list = xys360UCC.getAuditXys360ObjBOByPersonId(super.getUserInfo().getUserId());
			objList=new ArrayList();
			objList2=new ArrayList();
			List pList=xysEvaPlanUCC.getAllXysEvaPlanBO();
			Hashtable planMap=new Hashtable();
			if(pList!=null&&pList.size()>0){
				for(int i=0;i<pList.size();i++){
					XysEvaPlanBO plan=(XysEvaPlanBO)pList.get(i);
					planMap.put(plan.getPlanId(), plan);
				}
			}
			Hashtable sbjMap=this.xys360UCC.getXys360SbjBOByPersonId(super.getUserInfo().getUserId());
			String deptTreeId=SysCacheTool.findOrgById(super.getUserInfo().getDeptId()).getTreeId();
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					Xys360ObjBO obj = (Xys360ObjBO) list.get(i);
					Xys360SbjBO sbj = (Xys360SbjBO)sbjMap.get(obj.getObjId());
					XysEvaPlanBO plan =(XysEvaPlanBO)planMap.get(obj
							.getPlanId());
					PersonBO pbo = SysCacheTool.findPersonById(obj
							.getPersonId());
					obj.setPlanName(CommonFuns.filterNull(plan.getPlanName()));
					obj.setYear(CommonFuns.filterNull(plan.getYear()));
					obj.setPersonName(pbo.getName());
					obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
							.getName());
					obj.setPostName(PostTool.getPostName(pbo.getPostId()));
					obj.setScore(CommonFuns.filterNull(sbj.getScore()));
					if(pbo.getDeptTreeId().indexOf(deptTreeId)!=-1){
						objList.add(obj);
					}else{
						objList2.add(obj);
					}
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
	
	// 打分
	private String initInput;
	private IEvaGradeUCC evaGradeUCC;
	
	public String saveScore() {
		try {
			String personId=super.getUserInfo().getUserId();
			List keyList = xys360UCC.getXys360ObjKeyBOByObjId(objId);
			Xys360ObjBO obj = xys360UCC.findXys360ObjBOById(objId);
			String deptId=SysCacheTool.findPersonById(obj.getPersonId()).getDeptTreeId();
			String deptTreeId=SysCacheTool.findPersonById(personId).getDeptTreeId();
			boolean showSelf=false;
			if(deptId.equals(deptTreeId)){
				showSelf=true;
			}
			XysEvaPlanBO plan = xysEvaPlanUCC.findXysEvaPlanBOById(obj
					.getPlanId());
			Xys360SbjBO sbj = xys360UCC.findEqualsXys360SbjBO(
					objId,personId);
			if (keyList != null && keyList.size() > 0) {
				double allScore = 0;
				List scoreList=new ArrayList();
				for (int i = 0; i < keyList.size(); i++) {
					Xys360ObjKeyBO key = (Xys360ObjKeyBO) keyList.get(i);
					String score = super.getRequestParameter(key.getKeyId());
					Xys360ObjScoreBO bo = xys360UCC.findEqualsXys360ObjScoreBO(sbj.getSbjId(),
									key.getKeyId());
					bo.setScore(score);
					double caclScore = Double.parseDouble(key.getWeight())
							* Double.parseDouble(score)
							/ Double.parseDouble(key.getHiValue());
					allScore += caclScore;
					scoreList.add(bo);
				}
				NumberFormat nf = NumberFormat.getInstance();
				nf.setMaximumFractionDigits(Integer.parseInt(plan
						.getScorePers()));
				sbj.setScore(nf.format(allScore));
				
				//打分控制
				double s=Double.parseDouble(nf.format(allScore));
				List gradeList=evaGradeUCC.getAllGradeItem(plan.getPlanGrade());
				String gradeItem="";
				if(gradeList!=null&&gradeList.size()>0){
					for(int i=0;i<gradeList.size();i++){
						EvaGradeItemBO bo=(EvaGradeItemBO)gradeList.get(i);
						double hiValue=Double.parseDouble(CommonFuns.filterNullToZero(bo.getHighValue()));
						double lowValue=Double.parseDouble(CommonFuns.filterNullToZero(bo.getLowValue()));
						if((s>=lowValue&&s<hiValue)||(hiValue>=100&&s>=100)){
							gradeItem=bo.getItemID();
							break;
						}
					}
				}
				XysScoreCtrBO ctr=xysEvaPlanUCC.findEqualsXysScoreCtrBO(plan.getPlanId(),"3",gradeItem);
				boolean flag=true;
				if(ctr!=null&&ctr.getCount()!=null&&!ctr.getCount().equals("")){
					int count=Integer.parseInt(ctr.getCount());
					if(showSelf){
						List list=xys360UCC.getXys360SbjBOForGrade(plan.getPlanId(),personId, gradeItem,sbj.getSbjId(),deptTreeId,showSelf);
						List allList=this.xys360UCC.getAuditXys360ObjBOByPersonId(personId,plan.getPlanId(),deptTreeId,showSelf);
						double size2=Math.round(((double)count*allList.size())/100);
						if(list.size()+1>size2){
							flag=false;
						}
					}else{
						List list=xys360UCC.getXys360SbjBOForGrade(plan.getPlanId(),personId, gradeItem,sbj.getSbjId(),deptTreeId,showSelf);
						List allList=this.xys360UCC.getAuditXys360ObjBOByPersonId(personId,plan.getPlanId(),deptTreeId,showSelf);
						double size2=Math.round(((double)count*allList.size())/100);
						if(list.size()+1>size2){
							flag=false;
						}
					}
				}
				
				if(flag){//控制范围内
					if(scoreList!=null&&scoreList.size()>0){
						for(int i=0;i<scoreList.size();i++){
							Xys360ObjScoreBO bo=(Xys360ObjScoreBO)scoreList.get(i);
							xys360UCC.saveXys360ObjScoreBO(bo);
						}
					}
					sbj.setGradeItem(gradeItem);
					xys360UCC.saveXys360SbjBO(sbj);
				}else{
					super.getHttpSession().setAttribute("scoreList", scoreList);
					super.showMessageDetail("打分超过等级比例["+evaGradeUCC.getGradeItem(gradeItem).getItemName()+":"+ctr.getCount()+"%]上限，无法保存分数！");
					return "";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	public String getInitInput() {
		try {
			if (super.getRequestParameter("objId") != null) {
				objId = super.getRequestParameter("objId");
				Xys360ObjBO obj=xys360UCC.findXys360ObjBOById(objId);
				XysEvaPlanBO plan=this.xysEvaPlanUCC.findXysEvaPlanBOById(obj.getPlanId());
				if(plan.getPlanGrade()!=null&&!plan.getPlanGrade().equals("")){
					String showGrade="";
					List gradeList=this.evaGradeUCC.getAllGradeItem(plan.getPlanGrade());
					if(gradeList!=null&&gradeList.size()>0){
						for(int i=0;i<gradeList.size();i++){
							EvaGradeItemBO bo=(EvaGradeItemBO)gradeList.get(i);
							if(showGrade.equals("")){
								showGrade+=bo.getItemName()+"("+CommonFuns.filterNull(bo.getLowValue())+"-"+CommonFuns.filterNull(bo.getHighValue())+")";
							}else{
								showGrade+=","+bo.getItemName()+"("+CommonFuns.filterNull(bo.getLowValue())+"-"+CommonFuns.filterNull(bo.getHighValue())+")";
							}
						}
					}
					super.getHttpSession().setAttribute("showGrade", showGrade);
				}
				Xys360SbjBO sbj = xys360UCC.findEqualsXys360SbjBO(
						objId, super.getUserInfo().getUserId());
				super.getHttpSession().setAttribute("sbj", sbj);
				super.getHttpSession().setAttribute("objId", objId);
			}else if(super.getRequestParameter("sbjId")!=null){
				String  sbjId=super.getRequestParameter("sbjId");
				Xys360SbjBO sbj=this.xys360UCC.findXys360SbjBOById(sbjId);
				super.getHttpSession().setAttribute("sbj", sbj);
				super.getHttpSession().setAttribute("objId", sbj.getObjId());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initInput;
	}
	public void setInitInput(String initInput) {
		this.initInput = initInput;
	}
	public IEvaGradeUCC getEvaGradeUCC() {
		return evaGradeUCC;
	}
	public void setEvaGradeUCC(IEvaGradeUCC evaGradeUCC) {
		this.evaGradeUCC = evaGradeUCC;
	}
	
}
