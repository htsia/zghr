package com.hr319wg.xys.eva.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonScoreBO;
import com.hr319wg.xys.eva.pojo.bo.XysScoreCtrBO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC;

public class PersonKpiAuditBackBean extends BaseBackingBean {
	private IXysKpiDeptUCC xysKpiDeptUCC;
	private IXysEvaPlanUCC xysEvaPlanUCC;
	private IXysKpiPersonUCC xysKpiPersonUCC;
	private String pageInit;
	private List objList;
	private String objId;
	
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

	public IXysKpiPersonUCC getXysKpiPersonUCC() {
		return xysKpiPersonUCC;
	}

	public void setXysKpiPersonUCC(IXysKpiPersonUCC xysKpiPersonUCC) {
		this.xysKpiPersonUCC = xysKpiPersonUCC;
	}

	public void doQuery() {
		try {
			objList = xysKpiPersonUCC.getAuditXysKpiPersonObjBOByPersonId(super
					.getUserInfo().getUserId());
			if (objList != null && objList.size() > 0) {
				for (int i = 0; i < objList.size(); i++) {
					XysKpiPersonObjBO obj = (XysKpiPersonObjBO) objList.get(i);
					XysKpiPersonSbjBO sbj = xysKpiPersonUCC
							.findEqualsXysKpiPersonSbjBO(obj.getObjId(), super
									.getUserInfo().getUserId());
					XysEvaPlanBO plan = xysEvaPlanUCC.findXysEvaPlanBOById(obj
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
					objList.set(i, obj);
				}
				Collections.sort(objList);
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
	private String sbjId;

	public String getSbjId() {
		return sbjId;
	}

	public void setSbjId(String sbjId) {
		this.sbjId = sbjId;
	}

	public String saveScore2() {
		try {
			List keyList = xysKpiDeptUCC.getXysKpiObjKeyBOByObjId(objId);
			XysKpiPersonObjBO obj = xysKpiPersonUCC.findXysKpiPersonObjBOById(objId);
			XysEvaPlanBO plan = xysEvaPlanUCC.findXysEvaPlanBOById(obj.getPlanId());
			XysKpiPersonSbjBO sbj = xysKpiPersonUCC
					.findXysKpiPersonSbjBOById(sbjId);
			if (keyList != null && keyList.size() > 0) {
				double allScore = 0;
				for (int i = 0; i < keyList.size(); i++) {
					XysKpiObjKeyBO key = (XysKpiObjKeyBO) keyList.get(i);
					String score = super.getRequestParameter(key.getObjKeyId());
					XysKpiPersonScoreBO bo = xysKpiPersonUCC
							.findEqualsXysKpiPersonScoreBO(sbj.getSbjId(),
									key.getObjKeyId());
					bo.setScore(score);
					double caclScore = Double.parseDouble(key.getWeight())
							* Double.parseDouble(score)
							/ Double.parseDouble(key.getHiValue());
					allScore += caclScore;
					xysKpiPersonUCC.saveXysKpiPersonScoreBO(bo);
				}
				NumberFormat nf = NumberFormat.getInstance();
				nf.setMaximumFractionDigits(Integer.parseInt(plan
						.getScorePers()));
				sbj.setScore(nf.format(allScore));

				double s = Double.parseDouble(nf.format(allScore));
				List gradeList = evaGradeUCC.getAllGradeItem(plan
						.getPlanGrade());
				String gradeItem = "";
				if (gradeList != null && gradeList.size() > 0) {
					for (int i = 0; i < gradeList.size(); i++) {
						EvaGradeItemBO bo = (EvaGradeItemBO) gradeList.get(i);
						double hiValue = Double.parseDouble(CommonFuns
								.filterNullToZero(bo.getHighValue()));
						double lowValue = Double.parseDouble(CommonFuns
								.filterNullToZero(bo.getLowValue()));
						if ((s >= lowValue && s < hiValue)
								|| (hiValue >= 100 && s >= 100)) {
							gradeItem = bo.getItemID();
							break;
						}
					}
				}

				sbj.setGradeItem(gradeItem);
				xysKpiPersonUCC.saveXysKpiPersonSbjBO(sbj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String saveScore() {
		try {
			List keyList = xysKpiDeptUCC.getXysKpiObjKeyBOByObjId(objId);
			XysKpiPersonObjBO obj = xysKpiPersonUCC
					.findXysKpiPersonObjBOById(objId);
			XysEvaPlanBO plan = xysEvaPlanUCC.findXysEvaPlanBOById(obj
					.getPlanId());
			XysKpiPersonSbjBO sbj = xysKpiPersonUCC
					.findEqualsXysKpiPersonSbjBO(objId, super.getUserInfo()
							.getUserId());
			if (keyList != null && keyList.size() > 0) {
				double allScore = 0;
				List scoreList = new ArrayList();
				for (int i = 0; i < keyList.size(); i++) {
					XysKpiObjKeyBO key = (XysKpiObjKeyBO) keyList.get(i);
					String score = super.getRequestParameter(key.getObjKeyId());
					XysKpiPersonScoreBO bo = xysKpiPersonUCC
							.findEqualsXysKpiPersonScoreBO(sbj.getSbjId(),
									key.getObjKeyId());
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

				// 打分控制
				double s = Double.parseDouble(nf.format(allScore));
				List gradeList = evaGradeUCC.getAllGradeItem(plan
						.getPlanGrade());
				String gradeItem = "";
				if (gradeList != null && gradeList.size() > 0) {
					for (int i = 0; i < gradeList.size(); i++) {
						EvaGradeItemBO bo = (EvaGradeItemBO) gradeList.get(i);
						double hiValue = Double.parseDouble(CommonFuns
								.filterNullToZero(bo.getHighValue()));
						double lowValue = Double.parseDouble(CommonFuns
								.filterNullToZero(bo.getLowValue()));
						if ((s >= lowValue && s < hiValue)
								|| (hiValue >= 100 && s >= 100)) {
							gradeItem = bo.getItemID();
							break;
						}
					}
				}
				XysScoreCtrBO ctr = xysEvaPlanUCC.findEqualsXysScoreCtrBO(
						plan.getPlanId(), "2", gradeItem);
				boolean flag = true;
				if (ctr != null && ctr.getCount() != null
						&& !ctr.getCount().equals("")) {
					int count = Integer.parseInt(ctr.getCount());
					List list = xysKpiPersonUCC.getXysKpiPersonSbjBOForGrade(
							plan.getPlanId(), super.getUserInfo().getUserId(),
							gradeItem, sbj.getSbjId());
					List allList = xysKpiPersonUCC
							.getAuditXysKpiPersonObjBOByPersonId(super
									.getUserInfo().getUserId());
					double size2 = Math
							.round(((double) count * allList.size()) / 100);
					if (list.size() + 1 > size2) {
						flag = false;
					}
				}

				if (flag) {// 控制范围内
					if (scoreList != null && scoreList.size() > 0) {
						for (int i = 0; i < scoreList.size(); i++) {
							XysKpiPersonScoreBO bo = (XysKpiPersonScoreBO) scoreList
									.get(i);
							xysKpiPersonUCC.saveXysKpiPersonScoreBO(bo);
						}
					}
					sbj.setGradeItem(gradeItem);
					xysKpiPersonUCC.saveXysKpiPersonSbjBO(sbj);
				} else {
					super.showMessageDetail("打分超过等级比例["
							+ evaGradeUCC.getGradeItem(gradeItem).getItemName()
							+ ":" + ctr.getCount() + "%]上限，无法保存分数！");
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
				XysKpiPersonSbjBO sbj = xysKpiPersonUCC
						.findEqualsXysKpiPersonSbjBO(objId, super.getUserInfo()
								.getUserId());
				XysKpiPersonObjBO obj = this.xysKpiPersonUCC
						.findXysKpiPersonObjBOById(objId);
				XysEvaPlanBO plan = this.xysEvaPlanUCC.findXysEvaPlanBOById(obj
						.getPlanId());
				if (plan.getPlanGrade() != null
						&& !plan.getPlanGrade().equals("")) {
					String showGrade = "";
					List gradeList = this.evaGradeUCC.getAllGradeItem(plan
							.getPlanGrade());
					if (gradeList != null && gradeList.size() > 0) {
						for (int i = 0; i < gradeList.size(); i++) {
							EvaGradeItemBO bo = (EvaGradeItemBO) gradeList
									.get(i);
							if (showGrade.equals("")) {
								showGrade += bo.getItemName()
										+ "("
										+ CommonFuns.filterNull(bo
												.getLowValue())
										+ "-"
										+ CommonFuns.filterNull(bo
												.getHighValue()) + ")";
							} else {
								showGrade += ","
										+ bo.getItemName()
										+ "("
										+ CommonFuns.filterNull(bo
												.getLowValue())
										+ "-"
										+ CommonFuns.filterNull(bo
												.getHighValue()) + ")";
							}
						}
					}
					super.getHttpSession().setAttribute("showGrade", showGrade);
				}
				super.getHttpSession().setAttribute("sbj", sbj);
				super.getHttpSession().setAttribute("objId", objId);
			} else if (super.getRequestParameter("sbjId") != null) {
				sbjId = super.getRequestParameter("sbjId");
				XysKpiPersonSbjBO sbj = this.xysKpiPersonUCC
						.findXysKpiPersonSbjBOById(sbjId);
				objId = sbj.getObjId();
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
