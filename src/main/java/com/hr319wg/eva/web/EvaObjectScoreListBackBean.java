package com.hr319wg.eva.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.EmpTeamInfoBo;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.teamManagerUcc;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.vo.EvaObjectMasterScoreVO;
import com.hr319wg.eva.pojo.vo.EvaObjectsVO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class EvaObjectScoreListBackBean extends BaseBackingBean {
	private IEvaObjectsUCC objectUCC;
	private IEvaGradeUCC gradeUCC;
	private IEvaPlanUCC evaplanucc;
	private teamManagerUcc teamucc;
	private String pageInit;
	private List objectList;
	private PageVO pagevo=new PageVO();
	private String planId;
	private String allowMark;
	private String gradeDes;
	private String condiValue;
	private String mode;
	private Hashtable hashGrade;
	
	public teamManagerUcc getTeamucc() {
		return teamucc;
	}
	public void setTeamucc(teamManagerUcc teamucc) {
		this.teamucc = teamucc;
	}
	public Hashtable getHashGrade() {
		return hashGrade;
	}
	public void setHashGrade(Hashtable hashGrade) {
		this.hashGrade = hashGrade;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getCondiValue() {
		return condiValue;
	}
	public void setCondiValue(String condiValue) {
		this.condiValue = condiValue;
	}
	public String getGradeDes() {
		return gradeDes;
	}
	public void setGradeDes(String gradeDes) {
		this.gradeDes = gradeDes;
	}
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}
	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
	public String getAllowMark() {
		return allowMark;
	}
	public void setAllowMark(String allowMark) {
		this.allowMark = allowMark;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
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
	public String first() {
		pagevo.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String pre() {
		if (pagevo.getCurrentPage() > 1) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() - 1);
		}
		doQuery();
		return "";
	}

	public String next() {
		if (pagevo.getCurrentPage() < pagevo.getTotalPage()) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() + 1);
		}
		doQuery();
		return "";
	}

	public String last() {
		pagevo.setCurrentPage(pagevo.getTotalPage());
		doQuery();
		return "";
	}

	public void doQuery(){
		try{
			if (pagevo.getCurrentPage() == 0)
				pagevo.setCurrentPage(1);
			objectList=new ArrayList();
			pagevo.setPageSize(20);
			if(null==condiValue){
				condiValue="";
			}
			List objList=null;
			EvaPlanBO planbo=(EvaPlanBO)evaplanucc.findPlanById(planId);
			if(planbo.getNotShowHr()!=null&&planbo.getNotShowHr().equals("1")){
				super.getHttpSession().setAttribute("notShowHr", "1");
			}else{
				super.getHttpSession().setAttribute("notShowHr", "0");
			}
			NumberFormat   nf   =   NumberFormat.getInstance(); 
			if(planbo.getScorePers()!=null&&!planbo.getScorePers().equals("")){
				int intPers=Integer.parseInt(planbo.getScorePers());
				nf.setMaximumFractionDigits(intPers);
			}else{
				nf.setMaximumFractionDigits(2);
			}
			if(planbo.getPlanObjectType().equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
				objList=this.objectUCC.getEvaObjectsVOByPlanIdAndQuery(pagevo,planId,condiValue);
			}else{
				objList=this.objectUCC.getEvaObjectsVOByPlanIdAndQuery(pagevo,planId,null);
			}
			
			if(objList!=null&&objList.size()>0){
				for(int i=0;i<objList.size();i++){
					EvaObjectsVO objbo=(EvaObjectsVO)objList.get(i);
					
					EvaObjectMasterScoreVO vo=new EvaObjectMasterScoreVO();
					vo.setObjectId(objbo.getObjectID());
					if(objbo.getScore()!=null&&!objbo.getScore().equals("")){
						vo.setScore(nf.format(new Double(objbo.getScore())));
					}
					vo.setTemplateId(objbo.getTemplateID());
					if(planbo.getPlanObjectType()!=null){
						if(planbo.getPlanObjectType().equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
							PersonBO pb=SysCacheTool.findPersonById(objbo.getPersonID());
							vo.setObjectName(pb.getName());
							vo.setOrgName(SysCacheTool.findOrgById(pb.getOrgId()).getName());
							vo.setDeptName(SysCacheTool.findOrgById(pb.getDeptId()).getName());
						}else if(planbo.getPlanObjectType().equals(EvaPlanBO.OBJCT_TYPE_DEPT)){
							OrgBO org=SysCacheTool.findOrgById(objbo.getPersonID());
							OrgBO superorg=SysCacheTool.findOrgById(org.getSuperId());
							vo.setOrgName(superorg.getName());
							vo.setObjectName(org.getName());
							vo.setDeptName(org.getName());
						}else if(planbo.getPlanObjectType().equals(EvaPlanBO.OBJCT_TYPE_TEAM)){
							EmpTeamInfoBo team=(EmpTeamInfoBo)this.teamucc.findEmpTeamInfoBoById(objbo.getPersonID());
							vo.setObjectName(team.getTeamName());
							vo.setOrgName(SysCacheTool.findOrgById(team.getCreateOrg()).getName());
						}
					}
					if(objbo.getGradeItemId()!=null&&!objbo.getGradeItemId().equals("")){
						vo.setGradeName(((EvaGradeItemBO)hashGrade.get(objbo.getGradeItemId())).getFlagChar());
					}else{
						vo.setGradeName("未打分定级");
					}
					
					int hasScoreCount=0;
					List list=objectUCC.getMasters(objbo.getObjectID(),null);
					if(list!=null&&list.size()>0){
						for(int j=0;j<list.size();j++){
							EvaMasterBO bo=(EvaMasterBO)list.get(j);
							bo.setMasterType(CodeUtil.interpertCode(bo.getMasterType()));
							bo.setPersonName(SysCacheTool.findPersonById(bo.getPersonID()).getName());
							if(bo.getIsMark()!=null&&bo.getIsMark().equals("1")){
								hasScoreCount++;
							}
							if(mode.equals("0")){
								if(bo.getGradeId()!=null&&!bo.getGradeId().equals("")){
									bo.setGradeId(((EvaGradeItemBO)hashGrade.get(bo.getGradeId())).getFlagChar());
								}
								if(bo.getIsMark()==null||(bo.getIsMark()!=null&&bo.getIsMark().equals("0"))){
									bo.setGradeId("无");
									bo.setScore("未打分");
								}
							}else if(mode.equals("3")){
								if(bo.getGradeId()!=null&&!bo.getGradeId().equals("")){
									bo.setGradeId(((EvaGradeItemBO)hashGrade.get(bo.getGradeId())).getFlagChar());
								}else{
									bo.setGradeId("未投票");
								}
							}
							list.set(j, bo);
						}
					}else{
						list=new ArrayList();
					}
					vo.setHasScoreCount(String.valueOf(hasScoreCount));
					vo.setNotScoreCount(String.valueOf(list.size()-hasScoreCount));
					vo.setTotalRecord(String.valueOf(list.size()));
					vo.setMasterList(list);
					objectList.add(vo);
				}
			}
			super.getHttpSession().setAttribute("objectList", objectList);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	private void initGradeDes(){
		try{
			EvaPlanBO planbo=this.evaplanucc.findPlanById(planId);
			allowMark="0";
			if(planbo.getAllowMark()!=null&&planbo.getAllowMark().equals("1")){
				allowMark="1";
				if(planbo.getNotShowHr()!=null&&planbo.getNotShowHr().equals("1")){
					allowMark="0";
				}
			}
			super.getHttpSession().setAttribute("allowMark", allowMark);
			mode=planbo.getEvaModel();
			gradeDes="";
			hashGrade=new Hashtable();
			if(planbo.getPlanGrade()!=null&&!planbo.getPlanGrade().equals("")){
				List gradeList=gradeUCC.getAllGradeItem(planbo.getPlanGrade());
				if(gradeList!=null&&gradeList.size()>0){
					for(int i=0;i<gradeList.size();i++){
						EvaGradeItemBO ibo=(EvaGradeItemBO)gradeList.get(i);
						if(gradeDes.equals("")){
							gradeDes+=ibo.getItemName()+":"+ibo.getFlagChar();
						}else{
							gradeDes+="  "+ibo.getItemName()+":"+ibo.getFlagChar();
						}
						hashGrade.put(ibo.getItemID(), ibo);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getPageInit() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
				super.getHttpSession().setAttribute("planId", planId);
				initGradeDes();
			}
			doQuery();
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public List getObjectList() {
		return objectList;
	}
	public void setObjectList(List objectList) {
		this.objectList = objectList;
	}
	public PageVO getPagevo() {
		return pagevo;
	}
	public void setPagevo(PageVO pagevo) {
		this.pagevo = pagevo;
	}
	//详细信息 
	private String initmaster;
	private String queryValue;
	private List masterPersonList;
	private String objectId;

	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public void queryMaster(){
		try {
			masterPersonList = objectUCC.getMasters(objectId,queryValue);
			for (int i = 0; i < masterPersonList.size(); i++) {
				EvaMasterBO ebo = (EvaMasterBO) masterPersonList.get(i);
				PersonBO pb = SysCacheTool.findPersonById(ebo.getPersonID());
				if (pb != null) {
					ebo.setPersonName(pb.getName());
					ebo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
							pb.getDeptId()));
				}
				if(ebo.getIsMark()!=null&&ebo.getIsMark().equals("1")){
					ebo.setIsMark("打分");
				}else{
					ebo.setIsMark("未打分");
				}
				ebo.setMasterType(CodeUtil.interpertCode(ebo.getMasterType()));
				masterPersonList.set(i, ebo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getInitmaster() {
		if(super.getRequestParameter("objectID")!=null){
			objectId=super.getRequestParameter("objectID");
		}
		queryMaster();
		return initmaster;
	}
	public void setInitmaster(String initmaster) {
		this.initmaster = initmaster;
	}
	public String getQueryValue() {
		return queryValue;
	}
	public void setQueryValue(String queryValue) {
		this.queryValue = queryValue;
	}
	public List getMasterPersonList() {
		return masterPersonList;
	}
	public void setMasterPersonList(List masterPersonList) {
		this.masterPersonList = masterPersonList;
	}
	
}
