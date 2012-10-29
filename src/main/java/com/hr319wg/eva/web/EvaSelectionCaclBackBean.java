package com.hr319wg.eva.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaSelectionResultItemBO;
import com.hr319wg.eva.pojo.bo.EvaSelectionResultSetBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.sys.cache.SysCacheTool;

public class EvaSelectionCaclBackBean extends BaseBackingBean {
	private IEvaObjectsUCC objectUCC;
	private IEvaGradeUCC gradeUCC;
	private IEvaPlanUCC evaplanucc;
	private IEvaScoreUCC scoreucc;
	private String pageInit;
	private String planId;
	private String setId;
	private List setItemList;
	
	public String delete(){
		try{
			EvaSelectionResultSetBO bo=objectUCC.findEvaSelectionResultSetBO(setId);
			if(bo.getIsSel()!=null&&bo.getIsSel().equals("1")){
				super.showMessageDetail("该结果是统计结果不能删除！");
			}else{
				List itemList=objectUCC.getEvaSelectionResultItemBOBySetId(setId);
				if(itemList!=null&&itemList.size()>0){
					for(int i=0;i<itemList.size();i++){
						EvaSelectionResultItemBO bo1=(EvaSelectionResultItemBO)itemList.get(i);
						objectUCC.deleteEvaSelectionResultItemBO(bo1.getItemId());
					}
				}
				objectUCC.deleteEvaSelectionResultSetBO(setId);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public void doQuery(){
		try{
			setItemList=objectUCC.getEvaSelectionResultSetBOByPlanId(planId);
			if(setItemList!=null&&setItemList.size()>0){
				for(int i=0;i<setItemList.size();i++){
					EvaSelectionResultSetBO setbo=(EvaSelectionResultSetBO)setItemList.get(i);
					String items="";
					if(setbo.getGradeItems()!=null&&!setbo.getGradeItems().equals("")){
						String[] ids=setbo.getGradeItems().split(",");
						for(int j=0;j<ids.length;j++){
							if(ids[j]!=null&&!ids[j].equals("")){
								EvaGradeItemBO bo=gradeUCC.getGradeItem(ids[j]);
								if(items.equals("")){
									items+=bo.getItemName();
								}else{
									items+=","+bo.getItemName();
								}
							}
						}
						setbo.setGradeItemsDes(items);
					}
					setItemList.set(i, setbo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getPageInit() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		doQuery();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getSetId() {
		return setId;
	}
	public void setSetId(String setId) {
		this.setId = setId;
	}
	public List getSetItemList() {
		return setItemList;
	}
	public void setSetItemList(List setItemList) {
		this.setItemList = setItemList;
	}
	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}
	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}
	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}
	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
	}
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}
	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
	public IEvaScoreUCC getScoreucc() {
		return scoreucc;
	}
	public void setScoreucc(IEvaScoreUCC scoreucc) {
		this.scoreucc = scoreucc;
	}
	//增加设置
	private String initEdit;
	private EvaSelectionResultSetBO setbo=new EvaSelectionResultSetBO();
	private List gradeItemList;
	private String[] gradeItems;
	
	public EvaSelectionResultSetBO getSetbo() {
		return setbo;
	}

	public void setSetbo(EvaSelectionResultSetBO setbo) {
		this.setbo = setbo;
	}

	public String saveSet(){
		try{
			String id="";
			if(gradeItems!=null&&gradeItems.length>0){
				for(int i=0;i<gradeItems.length;i++){
					if(gradeItems[i]!=null&&!gradeItems[i].equals("")){
						if(id.equals("")){
							id+=gradeItems[i];
						}else{
							id+=","+gradeItems[i];
						}
					}
				}
			}
			setbo.setIsCacl("0");
			setbo.setIsSel("0");
			setbo.setGradeItems(id);
			setbo.setPlanId(planId);
			objectUCC.saveEvaSelectionResultSetBO(setbo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}

	public String[] getGradeItems() {
		return gradeItems;
	}

	public void setGradeItems(String[] gradeItems) {
		this.gradeItems = gradeItems;
	}

	public List getGradeItemList() {
		return gradeItemList;
	}

	public void setGradeItemList(List gradeItemList) {
		this.gradeItemList = gradeItemList;
	}

	public String getInitEdit() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
			}else if(super.getRequestParameter("setId")!=null){
				setId=super.getRequestParameter("setId");
				setbo=objectUCC.findEvaSelectionResultSetBO(setId);
				planId=setbo.getPlanId();
				if(setbo.getGradeItems()!=null&&!setbo.getGradeItems().equals("")){
					gradeItems=setbo.getGradeItems().split(",");
				}
			}
			EvaPlanBO bo=evaplanucc.findPlanById(planId);
			gradeItemList=new ArrayList();
			if(bo.getPlanGrade()!=null&&!bo.getPlanGrade().equals("")){
				List gradeList=gradeUCC.getAllGradeItem(bo.getPlanGrade());
				if(gradeList!=null&&gradeList.size()>0){
					for(int i=0;i<gradeList.size();i++){
						EvaGradeItemBO itembo=(EvaGradeItemBO)gradeList.get(i);
						SelectItem si=new SelectItem();
						si.setLabel(itembo.getItemName());
						si.setValue(itembo.getItemID());
						gradeItemList.add(si);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	//计算
	public String calc(){
		try{
			EvaSelectionResultSetBO bo=objectUCC.findEvaSelectionResultSetBO(setId);
			List itemList=objectUCC.getEvaSelectionResultItemBOBySetId(setId);
			if(itemList!=null&&itemList.size()>0){
				for(int i=0;i<itemList.size();i++){
					EvaSelectionResultItemBO bo1=(EvaSelectionResultItemBO)itemList.get(i);
					objectUCC.deleteEvaSelectionResultItemBO(bo1.getItemId());
				}
			}
			caclElectionScoreByPlanIdAndGradeItem(bo.getPlanId(),bo.getGradeItems());
			bo.setIsCacl("1");
			objectUCC.saveEvaSelectionResultSetBO(bo);
			super.showMessageDetail("计算成功");
		}catch(Exception e){
			super.showMessageDetail("计算失败");
			e.printStackTrace();
		}
		return "";
	}
	
	public void caclElectionScoreByPlanIdAndGradeItem(String planId,String gradeItem){
		try{
			EvaPlanBO planbo =evaplanucc.findPlanById(planId);
			NumberFormat nf = NumberFormat.getInstance();
			if (planbo.getScorePers() != null && !planbo.getScorePers().equals("")) {
				int intPers = Integer.parseInt(planbo.getScorePers());
				nf.setMaximumFractionDigits(intPers);
			} else {
				nf.setMaximumFractionDigits(2);
			}
			List gradeList = gradeUCC.getAllGradeItem(planbo.getPlanGrade());
			List objectList=objectUCC.getObjectsByPlanId(null, planId);
			if(objectList!=null&&objectList.size()>0){
				for(int i=0;i<objectList.size();i++){
					EvaObjectsBO obj=(EvaObjectsBO)objectList.get(i);
					List masterList=objectUCC.getMasters(obj.getObjectID(),null);
					List masterType=new ArrayList();
					if(masterList!=null&&masterList.size()>0){
						for(int j=0;j<masterList.size();j++){
							EvaMasterBO masterbo=(EvaMasterBO)masterList.get(j);
							if(!masterType.contains(masterbo.getMasterType())){
								masterType.add(masterbo.getMasterType());
							}
						}
					}
					if(masterType!=null&&masterType.size()>0){
						for(int j=0;j<masterType.size();j++){
							String type=(String)masterType.get(j);
							List mList=objectUCC.getMastersByMasterType(obj.getObjectID(), type);
							double count=0;
							double purview=0;
							if(mList!=null&&mList.size()>0){
								for(int m=0;m<mList.size();m++){
									EvaMasterBO masterbo=(EvaMasterBO)mList.get(m);
									if(masterbo.getGradeId()!=null&&gradeItem.indexOf(masterbo.getGradeId())!=-1){
										count++;
									}
									purview+=Double.parseDouble(masterbo.getPurview());
								}
							}
							double calatesocre=count*100*purview/(100*mList.size());
							EvaSelectionResultItemBO vo=new EvaSelectionResultItemBO();
							vo.setSetId(setId);
							vo.setObjectId(obj.getObjectID());
							vo.setMasterType(type);
							vo.setCaclScore(nf.format(calatesocre));
							vo.setCaclPers(nf.format(count/mList.size()*100));
							objectUCC.saveEvaSelectionResultItemBO(vo);
						}
						
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String setResult(){
		try{
			List setList=objectUCC.getEvaSelectionResultSetBOByPlanId(planId);
			if(setList!=null&&setList.size()>0){
				for(int i=0;i<setList.size();i++){
					EvaSelectionResultSetBO setbo=(EvaSelectionResultSetBO)setList.get(i);
					setbo.setIsSel("0");
					objectUCC.saveEvaSelectionResultSetBO(setbo);
				}
			}
			EvaSelectionResultSetBO bo=objectUCC.findEvaSelectionResultSetBO(setId);
			EvaPlanBO planbo =evaplanucc.findPlanById(planId);
			NumberFormat nf = NumberFormat.getInstance();
			if (planbo.getScorePers() != null && !planbo.getScorePers().equals("")) {
				int intPers = Integer.parseInt(planbo.getScorePers());
				nf.setMaximumFractionDigits(intPers);
			} else {
				nf.setMaximumFractionDigits(2);
			}
			List gradeList = gradeUCC.getAllGradeItem(planbo.getPlanGrade());
			List objectList=objectUCC.getObjectsByPlanId(null, planId);
			if(objectList!=null&&objectList.size()>0){
				for(int i=0;i<objectList.size();i++){
					EvaObjectsBO obj=(EvaObjectsBO)objectList.get(i);
					List scoreList=objectUCC.getEvaSelectionResultItemBOBySetIdAndObjId(setId, obj.getObjectID());
					double score=0;
					if(scoreList!=null&&scoreList.size()>0){
						for(int m=0;m<scoreList.size();m++){
							EvaSelectionResultItemBO itembo=(EvaSelectionResultItemBO)scoreList.get(m);
							score+=Double.parseDouble(itembo.getCaclScore());
						}
						for(int m=0;m<gradeList.size();m++){
							EvaGradeItemBO grade=(EvaGradeItemBO)gradeList.get(m);
							double hi=Double.parseDouble(grade.getHighValue());
							double low=Double.parseDouble(grade.getLowValue());
							if(score>=low&&score<hi){
								obj.setGradeItem(grade.getItemID());
								break;
							}
						}
						obj.setScore(nf.format(score));
						objectUCC.savaEvaObject(obj);
					}
				}
			}
			bo.setIsSel("1");
			objectUCC.saveEvaSelectionResultSetBO(bo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	//投票结果分析
	private String initResult;
	private String initResultList;
	private String superId;
	private String superName;
	private PageVO mypage=new PageVO();
	private String planOrgId;
	
	public String getPlanOrgId() {
		return super.getUserInfo().getOrgId();
	}

	public void setPlanOrgId(String planOrgId) {
		this.planOrgId = planOrgId;
	}

	public String getInitResultList() {
		try{
			if(super.getRequestParameter("superId")!=null){
				superId=super.getRequestParameter("superId");
				superName=SysCacheTool.findOrgById(superId).getName();
			}
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
				EvaPlanBO bo=evaplanucc.findPlanById(planId);
				if(bo.getPlanGrade()!=null&&!bo.getPlanGrade().equals("")){
					List gradeList=gradeUCC.getAllGradeItem(bo.getPlanGrade());
					super.getHttpSession().setAttribute("gradeList", gradeList);
				}
			}
			if(super.getRequestParameter("setId")!=null){
				setId=super.getRequestParameter("setId");
			}
		doParameter();
		}catch(Exception e){
			e.printStackTrace();
		}
		return initResultList;
	}

	public void setInitResultList(String initResultList) {
		this.initResultList = initResultList;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getSuperName() {
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String first() {
		mypage.setCurrentPage(1);
		doParameter();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doParameter();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doParameter();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doParameter();
		return "";
	}
	public String doParameter() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if(planId!=null&&!planId.equals("")&&superId!=null&&!superId.equals("")){
				EvaPlanBO planbo=evaplanucc.findPlanById(planId);
				List objectList=new ArrayList();
				if(planbo.getPlanObjectType().equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
					objectList=objectUCC.getObjectsByPlanIdAndOrgId(mypage,planId,superId);
				}else{
					objectList=objectUCC.getObjectsByPlanIdAndOrgId(mypage,planId,null);
				}
				super.getHttpSession().setAttribute("objectType", planbo.getPlanObjectType());
				super.getHttpSession().setAttribute("objectList", objectList);
				super.getHttpSession().setAttribute("planId", planId);
				super.getHttpSession().setAttribute("setId", setId);
				super.getHttpSession().setAttribute("superId", superId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public String getClear(){
		super.getHttpSession().setAttribute("objectList",null);
		return "";
	}

	public String getInitResult() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		if(super.getRequestParameter("setId")!=null){
			setId=super.getRequestParameter("setId");
		}
		return initResult;
	}

	public void setInitResult(String initResult) {
		this.initResult = initResult;
	}

}
