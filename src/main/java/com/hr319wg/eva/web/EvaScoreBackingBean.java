package com.hr319wg.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.eva.pojo.vo.EvaObjectsVO;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaPlanControlBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.pojo.bo.EvaScoreBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.teamManagerUcc;
import com.hr319wg.sys.cache.SysCacheTool;

import javax.faces.model.SelectItem;
import java.util.List;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;

public class EvaScoreBackingBean extends BaseBackingBean {
	private IEvaKeyItemUCC itemkeyUCC;
	private IEvaObjectsUCC objectUCC;
	private IEvaScoreUCC scoreucc;
	private IEvaPlanUCC evaplanucc;
	private teamManagerUcc teamucc;
	private String planID;
	private String orgId;
	private String orgName;
	private PageVO pagevo = new PageVO();
	private String templateID;
	private String objectID;
	private String masterID;
	private String initmaster; // 设置主体
	private EvaObjectsVO objectvo = new EvaObjectsVO();
	private EvaMasterBO masterbo = new EvaMasterBO();
	private List masterPersonList;
	private String initInput;
	private String objectName;
	private String masterName;
	private String taskDes;
	private String isEnd;
	private String type;
	private String isHaveReport;
	private String attachmentId;
	private String personId;

	public String getIsHaveReport() {
		return isHaveReport;
	}

	public void setIsHaveReport(String isHaveReport) {
		this.isHaveReport = isHaveReport;
	}

	public String getAttachmentId() {
		return attachmentId;
	}

	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public teamManagerUcc getTeamucc() {
		return teamucc;
	}

	public void setTeamucc(teamManagerUcc teamucc) {
		this.teamucc = teamucc;
	}

	public String getIsEnd() {
		return isEnd;
	}

	public void setIsEnd(String isEnd) {
		this.isEnd = isEnd;
	}

	public String getObjectName() {
		return objectName;
	}

	public void setObjectName(String objectName) {
		this.objectName = objectName;
	}

	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public String getTaskDes() {
		return taskDes;
	}

	public void setTaskDes(String taskDes) {
		this.taskDes = taskDes;
	}

	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}

	public String getTemplateID() {
		return templateID;
	}

	public void setTemplateID(String templateID) {
		this.templateID = templateID;
	}

	public String getInitInput() {
		try {
			if (super.getRequestParameter("objectID") != null) {
				objectID = super.getRequestParameter("objectID");
				super.getHttpSession().setAttribute("objectID", objectID);
			}
			if (super.getRequestParameter("templateID") != null) {
				templateID = super.getRequestParameter("templateID");
				super.getHttpSession().setAttribute("templateID", templateID);
			}
			if (super.getRequestParameter("masterID") != null) {
				masterID = super.getRequestParameter("masterID");
				super.getHttpSession().setAttribute("masterID", masterID);
				Hashtable ht = new Hashtable();
				List scoreList = scoreucc.getScoreInfo(masterID, objectID);
				for (int i = 0; i < scoreList.size(); i++) {
					EvaScoreBO scorebo = (EvaScoreBO) scoreList.get(i);
					ht.put(scorebo.getItemID(), scorebo);
				}
				super.getHttpSession().setAttribute("ScoreObject", ht);
			}else{
				masterID=(String)super.getHttpSession().getAttribute("masterID");
			}
			String nextMaster=(String)super.getHttpSession().getAttribute("nextMaster");
			if(nextMaster!=null){
				masterID=nextMaster;
				objectID=objectUCC.findEvaMasterBOById(masterID).getObjectID();
				super.getHttpSession().setAttribute("masterID", masterID);
				Hashtable ht = new Hashtable();
				List scoreList = scoreucc.getScoreInfo(masterID, objectID);
				for (int i = 0; i < scoreList.size(); i++) {
					EvaScoreBO scorebo = (EvaScoreBO) scoreList.get(i);
					ht.put(scorebo.getItemID(), scorebo);
				}
				super.getHttpSession().setAttribute("ScoreObject", ht);
				super.getHttpSession().removeAttribute("nextMaster");
				super.getHttpSession().setAttribute("objectID", objectID);
			}else{
				objectID=(String)super.getHttpSession().getAttribute("objectID");
			}
			if(objectID!=null&&!objectID.equals("")){
				EvaObjectsBO obo=objectUCC.findEvaObjectBOById(objectID);
				super.getHttpSession().setAttribute("templateID", obo.getTemplateID());
				planID=obo.getPlanID();
				personId=obo.getPersonID();
				super.getHttpSession().setAttribute("planId", planID);
				super.getHttpSession().setAttribute("personId", personId);
				if(obo.getSummaryFile()!=null&&!obo.getSummaryFile().equals("")){
					isHaveReport="1";
					attachmentId=obo.getSummaryFile();
				}else{
					isHaveReport="0";
				}
				String objectType=evaplanucc.findPlanById(obo.getPlanID()).getPlanObjectType();
				if(objectType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
					objectName=SysCacheTool.findPersonById(obo.getPersonID()).getName();
				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_DEPT)){
					objectName=SysCacheTool.findOrgById(obo.getPersonID()).getName();
				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_TEAM)){
					objectName=this.teamucc.findEmpTeamInfoBoById(obo.getPersonID()).getTeamName();
				}
				EvaMasterBO mbo=objectUCC.findEvaMasterBOById(masterID);
				masterName=SysCacheTool.findPersonById(mbo.getPersonID()).getName();
				int count=0;
				List maList=objectUCC.getMasterByMasterPlanId(obo.getPlanID(), mbo.getPersonID());
				if(maList!=null&&maList.size()>0){
					for(int i=0;i<maList.size();i++){
						EvaMasterBO mbo1=(EvaMasterBO)maList.get(i);
						if(mbo1.getGradeId()!=null&&!mbo1.getGradeId().equals("")&&mbo1.getScore()!=null&&!mbo1.getScore().equals("")){
							count++;
						}
					}
				}
				taskDes=String.valueOf(count)+"/"+String.valueOf(maList.size());
				if(count==maList.size()){
					isEnd="1";
				}else{
					isEnd="0";
				}
			}
			if(super.getRequestParameter("type")!=null){
				type=super.getRequestParameter("type");
				super.getHttpSession().setAttribute("type", type);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initInput;
	}

	public void setInitInput(String initInput) {
		this.initInput = initInput;
	}

	public String savescore() {
		try {
			String objectId = (String) super.getHttpSession().getAttribute(
					"objectID");
			String masterId = (String) super.getHttpSession().getAttribute(
					"masterID");
			String planId = objectUCC.findEvaObjectBOById(objectId).getPlanID();
			Hashtable ht = (Hashtable) super.getHttpSession().getAttribute(
					"ScoreObject");
			if (ht != null) {
				Iterator it = ht.keySet().iterator();
				while (it.hasNext()) {
					EvaScoreBO score = (EvaScoreBO) ht.get(it.next());
					if (score != null) {
						score.setScore(super.getRequestParameter(score
								.getScoreID()));
						this.scoreucc.saveScore(score);
					}
				}
				super.getHttpSession().setAttribute("ScoreObject", ht);
				scoreucc.caclTheMasterScoreForObject(objectId, masterId);
			}
			EvaMasterBO master = objectUCC.findEvaMasterBOById(masterId);
			master.setIsMark("1");
			objectUCC.saveEvaMasterBO(master);
			EvaObjectsBO objbo=objectUCC.findEvaObjectBOById(objectId);
			EvaPlanControlBO control =evaplanucc.findTheSuitEvaPlanControlBO(objbo.getPlanID(), objbo.getTemplateID(), master.getGradeId());
			if (control!=null&&master.getGradeId() != null && !master.getGradeId().equals("")) {
				String gradeId = master.getGradeId();
				double maxCount = 0;
				int count = 0;
				List masterList = objectUCC.getMasterByMasterPlanId(planId,
						master.getPersonID());
				if (masterList != null && masterList.size() > 0) {
					for (int i = 0; i < masterList.size(); i++) {
						EvaMasterBO mbo = (EvaMasterBO) masterList.get(i);
						if (mbo.getGradeId() != null
								&& mbo.getGradeId().equals(gradeId)) {
							count++;
						}
					}
				}
				maxCount=masterList.size()*Double.parseDouble(control.getGradeCount())/100;
				PersonBO operson=SysCacheTool.findPersonById(objbo.getPersonID());
				List deptList=objectUCC.getMasterBO(objbo.getPlanID(),objbo.getTemplateID(),master.getPersonID(),operson.getDeptId(),master.getGradeId());
				if(control.getDeptCount()!=null&&!control.getDeptCount().equals("")){
					int deptCount=Integer.parseInt(control.getDeptCount());
					if(deptList!=null&&deptList.size()>deptCount){
						if (ht != null) {
							Iterator it = ht.keySet().iterator();
							while (it.hasNext()) {
								EvaScoreBO score = (EvaScoreBO) ht.get(it.next());
								if (score != null) {
									score.setScore(null);
									this.scoreucc.saveScore(score);
								}
							}
							super.getHttpSession().setAttribute("ScoreObject", ht);
						}
						master.setIsMark("0");
						master.setScore(null);
						master.setGradeId("");
						objectUCC.saveEvaMasterBO(master);
						super.showMessageDetail("超过部门控制人数上限（"+control.getDeptCount()+"），请重新打分！");
						return "";
					}
				}
				if(maxCount<1){
					maxCount=1;
				}else{
					maxCount=Math.floor(maxCount);
				}
				if (count>maxCount) {
					if (ht != null) {
						Iterator it = ht.keySet().iterator();
						while (it.hasNext()) {
							EvaScoreBO score = (EvaScoreBO) ht.get(it.next());
							if (score != null) {
								score.setScore(null);
								this.scoreucc.saveScore(score);
							}
						}
						super.getHttpSession().setAttribute("ScoreObject", ht);
					}
					master.setIsMark("0");
					master.setScore(null);
					master.setGradeId("");
					objectUCC.saveEvaMasterBO(master);
					super.showMessageDetail("超过该等级比例上限(" + control.getGradeCount()
							+ "%)，请重新打分！");
					return "";
				}

			}
			if(objectId!=null&&!objectId.equals("")){
				EvaObjectsBO obo=objectUCC.findEvaObjectBOById(objectId);
				EvaMasterBO mbo=objectUCC.findEvaMasterBOById(masterId);
				List maList=objectUCC.getMasterByMasterPlanId(obo.getPlanID(), mbo.getPersonID());
				if(maList!=null&&maList.size()>0){
					for(int i=0;i<maList.size();i++){
						EvaMasterBO mbo1=(EvaMasterBO)maList.get(i);
						if(mbo1.getIsMark()==null||!mbo1.getIsMark().equals("1")){
							super.getHttpSession().setAttribute("nextMaster", mbo1.getMasterID());
							super.getHttpSession().setAttribute("nextscore", "NO");
							break;
						}
					}
				}
			}
		} catch (Exception e) {
			super.showMessageDetail("保存失败!");
			e.printStackTrace();
		}
		String tp=(String)super.getHttpSession().getAttribute("type");
		if(tp!=null&&tp.equals("modify")){
			super.getHttpSession().removeAttribute("type");
			return "success2";
		}
		if(isEnd!=null&&isEnd.equals("1")){
			return "success2";
		}else{
			return "success";
		}
	}
	public String savescore1() {
		try {
			String objectId = (String) super.getHttpSession().getAttribute(
					"objectID");
			String masterId = (String) super.getHttpSession().getAttribute(
					"masterID");
			String planId = objectUCC.findEvaObjectBOById(objectId).getPlanID();
			Hashtable ht = (Hashtable) super.getHttpSession().getAttribute(
					"ScoreObject");
			if (ht != null) {
				Iterator it = ht.keySet().iterator();
				while (it.hasNext()) {
					EvaScoreBO score = (EvaScoreBO) ht.get(it.next());
					if (score != null) {
						score.setScore(super.getRequestParameter(score
								.getScoreID()));
						this.scoreucc.saveScore(score);
					}
				}
				super.getHttpSession().setAttribute("ScoreObject", ht);
				scoreucc.caclTheMasterScoreForObject(objectId, masterId);
			}
			EvaMasterBO master = objectUCC.findEvaMasterBOById(masterId);
			master.setIsMark("1");
			objectUCC.saveEvaMasterBO(master);
			EvaObjectsBO objbo=objectUCC.findEvaObjectBOById(objectId);
			EvaPlanControlBO control =evaplanucc.findTheSuitEvaPlanControlBO(objbo.getPlanID(), objbo.getTemplateID(), master.getGradeId());
			if (control!=null&&master.getGradeId() != null && !master.getGradeId().equals("")) {
				String gradeId = master.getGradeId();
				double maxCount = 0;
				int count = 0;
				List masterList = objectUCC.getMasterByMasterPlanId(planId,
						master.getPersonID());
				if (masterList != null && masterList.size() > 0) {
					for (int i = 0; i < masterList.size(); i++) {
						EvaMasterBO mbo = (EvaMasterBO) masterList.get(i);
						if (mbo.getGradeId() != null
								&& mbo.getGradeId().equals(gradeId)) {
							count++;
						}
					}
				}
				maxCount=masterList.size()*Double.parseDouble(control.getGradeCount())/100;
				PersonBO operson=SysCacheTool.findPersonById(objbo.getPersonID());
				List deptList=objectUCC.getMasterBO(objbo.getPlanID(),objbo.getTemplateID(),master.getPersonID(),operson.getDeptId(),master.getGradeId());
				if(control.getDeptCount()!=null&&!control.getDeptCount().equals("")){
					int deptCount=Integer.parseInt(control.getDeptCount());
					if(deptList!=null&&deptList.size()>deptCount){
						if (ht != null) {
							Iterator it = ht.keySet().iterator();
							while (it.hasNext()) {
								EvaScoreBO score = (EvaScoreBO) ht.get(it.next());
								if (score != null) {
									score.setScore(null);
									this.scoreucc.saveScore(score);
								}
							}
							super.getHttpSession().setAttribute("ScoreObject", ht);
						}
						master.setIsMark("0");
						master.setScore(null);
						master.setGradeId("");
						objectUCC.saveEvaMasterBO(master);
						super.showMessageDetail("超过部门控制人数上限（"+control.getDeptCount()+"），请重新打分！");
						return "";
					}
				}
				if(maxCount<1){
					maxCount=1;
				}else{
					maxCount=Math.floor(maxCount);
				}
				if (count>maxCount) {
					if (ht != null) {
						Iterator it = ht.keySet().iterator();
						while (it.hasNext()) {
							EvaScoreBO score = (EvaScoreBO) ht.get(it.next());
							if (score != null) {
								score.setScore(null);
								this.scoreucc.saveScore(score);
							}
						}
						super.getHttpSession().setAttribute("ScoreObject", ht);
					}
					master.setScore(null);
					master.setGradeId("");
					master.setIsMark("0");
					objectUCC.saveEvaMasterBO(master);
					super.showMessageDetail("超过该等级比例上限(" + control.getGradeCount()
							+ "%)，请重新打分！");
					return "";
				}

			}
			super.showMessageDetail("打分成功!");
		} catch (Exception e) {
			super.showMessageDetail("保存失败!");
			e.printStackTrace();
		}
		return "";
	}

	public EvaMasterBO getMasterbo() {
		return masterbo;
	}

	public void setMasterbo(EvaMasterBO masterbo) {
		this.masterbo = masterbo;
	}

	public String getMasterID() {
		return masterID;
	}

	public void setMasterID(String masterID) {
		this.masterID = masterID;
	}

	public List getMasterPersonList() {
		return masterPersonList;
	}

	public void setMasterPersonList(List masterPersonList) {
		this.masterPersonList = masterPersonList;
	}

	public EvaObjectsVO getObjectvo() {
		return objectvo;
	}

	public void setObjectvo(EvaObjectsVO objectbo) {
		this.objectvo = objectbo;
	}

	public String getObjectID() {
		return objectID;
	}

	public void setObjectID(String objectID) {
		this.objectID = objectID;
	}

	public String getInitmaster() {
		try {
			if (super.getRequestParameter("objectID") != null) {
				objectID = super.getRequestParameter("objectID");
				objectvo = objectUCC.findEvaObject(objectID);
				if (objectvo != null) {
					objectvo.setPersonName(CodeUtil.interpertCode(
							CodeUtil.TYPE_PERSON, objectvo.getPersonID()));
					EvaTemplateBO tempbo = itemkeyUCC.findTemplateBO(objectvo
							.getTemplateID());
					if (tempbo != null) {
						objectvo.setTemplatename(tempbo.getTemplateName());
					}
				}
				masterPersonList = new ArrayList();
				SelectItem si0 = new SelectItem();
				si0.setLabel("--请选择主体--");
				si0.setValue("-1");
				masterPersonList.add(si0);

				List list = objectUCC.getMasters(objectID,null);
				for (int i = 0; i < list.size(); i++) {
					EvaMasterBO ebo = (EvaMasterBO) list.get(i);
					PersonBO pb = SysCacheTool
							.findPersonById(ebo.getPersonID());
					SelectItem si = new SelectItem();
					si.setLabel(pb.getName());
					si.setValue(ebo.getMasterID());
					masterPersonList.add(si);
				}
			}
		} catch (Exception e) {

		}
		return initmaster;
	}

	public void setInitmaster(String initmaster) {
		this.initmaster = initmaster;
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}

	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}

	public PageVO getPagevo() {
		return pagevo;
	}

	public void setPagevo(PageVO vo) {
		pagevo = vo;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getOrgName() {
		orgName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.orgId);
		return orgName;
	}

	public void setOrgName(String id) {
		this.orgName = id;
	}

	public IEvaKeyItemUCC getItemkeyUCC() {
		return itemkeyUCC;
	}

	public void setItemkeyUCC(IEvaKeyItemUCC ucc) {
		itemkeyUCC = ucc;
	}

	public IEvaScoreUCC getScoreucc() {
		return scoreucc;
	}

	public void setScoreucc(IEvaScoreUCC scoreucc) {
		this.scoreucc = scoreucc;
	}

}
