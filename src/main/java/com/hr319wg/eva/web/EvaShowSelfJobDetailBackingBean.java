package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import oracle.sql.CHAR;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaJobContentBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.JobEstimateLogBO;
import com.hr319wg.eva.ucc.IjobEstimateUCC;
import com.hr319wg.eva.ucc.impl.jobEstimateUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

/**
 * 
 * @author qiaolei
 * 
 */
public class EvaShowSelfJobDetailBackingBean extends BaseBackingBean {
	private IjobEstimateUCC jobestimateucc;
	private String planID;
	private String personID;
	private String queryString;
	private EvaJobEstimateBO jobBo = new EvaJobEstimateBO();
	private List contentList;
	private String taskID;
	private PersonBO personBO = new PersonBO();
	private String postID;
	private String itemID;
	private String saveStr;
	private String pageLeadInit;
	private String initChange;
	private String doChange;
	private String doDelete;
	private int num;
	private String status;
	private String statusDes;
	private JobEstimateLogBO bo=new JobEstimateLogBO();
	
	public void doModifyContent(){
		try {
			jobBo = jobestimateucc.findJobEstimate("", itemID);
			jobBo.setStatus("5");
			jobestimateucc.updateEstimate(jobBo);
			super.getHttpSession().setAttribute("status", jobBo.getStatus());
			bo.setAction(jobBo.getStatus());
			bo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			bo.setItemID(itemID);
			bo.setOperateID(super.getUserInfo().getUserId());
			jobestimateucc.saveJobEstimateLogBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void doApproval(){//报批
		try {
			jobBo = jobestimateucc.findJobEstimate("", itemID);
			jobBo.setStatus(EvaJobEstimateBO.APPROVAL);
			jobestimateucc.updateEstimate(jobBo);
			super.getHttpSession().setAttribute("status", jobBo.getStatus());
			bo.setAction(jobBo.getStatus());
			bo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			bo.setItemID(itemID);
			bo.setOperateID(super.getUserInfo().getUserId());
			jobestimateucc.saveJobEstimateLogBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	public void doModify(){//申请修改
		try {
			jobBo = jobestimateucc.findJobEstimate("", itemID);
			jobBo.setStatus(EvaJobEstimateBO.APPLICATION_MODIFY);
			jobestimateucc.updateEstimate(jobBo);
			super.getHttpSession().setAttribute("status", jobBo.getStatus());
			bo.setAction(jobBo.getStatus());
			bo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			bo.setItemID(itemID);
			bo.setOperateID(super.getUserInfo().getUserId());
			jobestimateucc.saveJobEstimateLogBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String audit(){
		try {
			jobBo = jobestimateucc.findJobEstimate(planID, itemID);
			jobBo.setStatus("2");
			jobestimateucc.updateEstimate(jobBo);
			JobEstimateLogBO bo1=new JobEstimateLogBO();
            bo1.setAction("2");
            bo1.setItemID(jobBo.getItemID());
            bo1.setOperateID(jobBo.getPersonID());
            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            jobestimateucc.saveJobEstimateLogBO(bo1);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	public String audit2(){
		try {
			jobBo = jobestimateucc.findJobEstimate(planID, itemID);
			jobBo.setStatus("0");
			jobestimateucc.updateEstimate(jobBo);
			JobEstimateLogBO bo1=new JobEstimateLogBO();
            bo1.setAction("0");
            bo1.setItemID(jobBo.getItemID());
            bo1.setOperateID(jobBo.getPersonID());
            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            jobestimateucc.saveJobEstimateLogBO(bo1);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	public String dosubmitContent(){
		try {
			jobBo = jobestimateucc.findJobEstimate(planID, itemID);
			jobBo.setStatus("7");
			jobestimateucc.updateEstimate(jobBo);
			JobEstimateLogBO bo1=new JobEstimateLogBO();
            bo1.setAction("7");
            bo1.setItemID(jobBo.getItemID());
            bo1.setOperateID(jobBo.getPersonID());
            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            jobestimateucc.saveJobEstimateLogBO(bo1);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	public String modifyContentOK(){
		try {
			jobBo = jobestimateucc.findJobEstimate(planID, itemID);
			jobBo.setStatus("6");
			jobestimateucc.updateEstimate(jobBo);
			JobEstimateLogBO bo1=new JobEstimateLogBO();
            bo1.setAction("6");
            bo1.setItemID(jobBo.getItemID());
            bo1.setOperateID(jobBo.getPersonID());
            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            jobestimateucc.saveJobEstimateLogBO(bo1);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	public String modifyContentNo(){
		try {
			jobBo = jobestimateucc.findJobEstimate(planID, itemID);
			jobBo.setStatus("2");
			jobestimateucc.updateEstimate(jobBo);
			JobEstimateLogBO bo1=new JobEstimateLogBO();
            bo1.setAction("2");
            bo1.setItemID(jobBo.getItemID());
            bo1.setOperateID(jobBo.getPersonID());
            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            jobestimateucc.saveJobEstimateLogBO(bo1);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	public String modify(){
		try {
			jobBo = jobestimateucc.findJobEstimate(planID, itemID);
			jobBo.setStatus("4");
			jobestimateucc.updateEstimate(jobBo);
			JobEstimateLogBO bo1=new JobEstimateLogBO();
            bo1.setAction("4");
            bo1.setItemID(jobBo.getItemID());
            bo1.setOperateID(jobBo.getPersonID());
            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            jobestimateucc.saveJobEstimateLogBO(bo1);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	public String modifyNO(){
		try {
			jobBo = jobestimateucc.findJobEstimate(planID, itemID);
			jobBo.setStatus("2");
			jobestimateucc.updateEstimate(jobBo);
			JobEstimateLogBO bo1=new JobEstimateLogBO();
            bo1.setAction("2");
            bo1.setItemID(jobBo.getItemID());
            bo1.setOperateID(jobBo.getPersonID());
            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            jobestimateucc.saveJobEstimateLogBO(bo1);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	public String getStatusDes() {
		return statusDes;
	}

	public void setStatusDes(String statusDes) {
		this.statusDes = statusDes;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getDoDelete() {
		return doDelete;
	}

	public void setDoDelete(String doDelete) {
		this.doDelete = doDelete;
	}

	public String getDoChange() {
		return doChange;
	}

	public void setDoChange(String doChange) {
		this.doChange = doChange;
	}

	public String getInitChange() {
		if (super.getRequestParameter("itemId") != null
				&& super.getRequestParameter("num") != null) {// 修改
			itemID = super.getRequestParameter("itemId");
			num = Integer.parseInt(super.getRequestParameter("num"));
			try {
				jobBo = jobestimateucc.findJobEstimate("", itemID);
				jobBo.setStatus("0");
				JobEstimateLogBO bo1=new JobEstimateLogBO();
                bo1.setAction("0");
                bo1.setItemID(jobBo.getItemID());
                bo1.setOperateID(jobBo.getPersonID());
                bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                jobestimateucc.saveJobEstimateLogBO(bo1);
			} catch (SysException e) {
				e.printStackTrace();
			}
		} else {// 增加
			if (super.getRequestParameter("itemId") != null) {
				itemID = super.getRequestParameter("itemId");
			}
			try {
				jobBo = jobestimateucc.findJobEstimate("", itemID);
				jobBo.setStatus("0");
				JobEstimateLogBO bo1=new JobEstimateLogBO();
                bo1.setAction("0");
                bo1.setItemID(jobBo.getItemID());
                bo1.setOperateID(jobBo.getPersonID());
                bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
                jobestimateucc.saveJobEstimateLogBO(bo1);
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		return initChange;
	}

	public void setInitChange(String initChange) {
		this.initChange = initChange;
	}

	public void setPageLeadInit(String pageLeadInit) {
		this.pageLeadInit = pageLeadInit;
	}

	public String getSaveStr() {
		return saveStr;
	}

	public void setSaveStr(String saveStr) {
		this.saveStr = saveStr;
	}

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public IjobEstimateUCC getJobestimateucc() {
		return jobestimateucc;
	}

	public void setJobestimateucc(IjobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
	}

	public String getTaskID() {
		return taskID;
	}

	public void setTaskID(String taskID) {
		this.taskID = taskID;
	}

	public List getContentList() {
		return contentList;
	}

	public void setContentList(List contentList) {
		this.contentList = contentList;
	}

	public void setJobestimateucc(jobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
	}

	public EvaJobEstimateBO getJobBo() {
		return jobBo;
	}

	public void setJobBo(EvaJobEstimateBO jobBo) {
		this.jobBo = jobBo;
	}

	public String getPersonID() {
		return personID;
	}

	public void setPersonID(String personID) {
		this.personID = personID;
	}

	public String getPostID() {
		return postID;
	}

	public void setPostID(String postID) {
		this.postID = postID;
	}

	public String getQueryString() {
		return queryString;
	}

	public void setQueryString(String queryString) {
		this.queryString = queryString;
	}

	public String getPageInit() {// 自助打分
		if (super.getRequestParameter("planID") != null) {// 点考核按钮时进入这个条件判断
			planID = super.getRequestParameter("planID");
			super.getHttpSession().setAttribute("planID", planID);
			queryPlanList();
		} else if (super.getHttpSession().getAttribute("planID") != null) {// 当在页面上进行删除操作后由于还需要当前planid所以就放到了session中
			planID = (String) super.getHttpSession().getAttribute("planID");
			queryPlanList();
		}
		return pageInit;
	}

	public String getPageLeadInit() {// 领导打分
		if (super.getRequestParameter("planID") != null) {
			planID = super.getRequestParameter("planID");
		}
		if (super.getRequestParameter("itemID") != null) {
			itemID = super.getRequestParameter("itemID");
		}
		if (itemID != null && !"".equals(itemID) && planID != null
				&& !"".equals(planID) && !"-1".equals(planID)) {
			queryLeadPlanList();
		}
		return "";
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public String add() {// 增加岗位职责
		pageDatas();
		return "success";
	}

	public String delete() {// 将指定的岗位职责删除
		try {
			if (doDelete != null) {// 删除指定itemID中的某些岗位职责
				String[] deleteContent = doDelete.split(":");
				itemID = deleteContent[1];
				jobBo = jobestimateucc.findJobEstimate(planID, itemID);
				num = Integer.parseInt(deleteContent[2]);
				if (num == 1) {
					jobBo.setC008001("");
					jobBo.setC008005("");
					jobBo.setC008010("");
					jobBo.setC008015("");
				} else if (num == 2) {
					jobBo.setC008701("");
					jobBo.setC008702("");
					jobBo.setC008703("");
					jobBo.setC008704("");
				} else if (num == 3) {
					jobBo.setC008705("");
					jobBo.setC008706("");
					jobBo.setC008707("");
					jobBo.setC008708("");
				} else if (num == 4) {
					jobBo.setC008709("");
					jobBo.setC008710("");
					jobBo.setC008711("");
					jobBo.setC008712("");
				} else if (num == 5) {
					jobBo.setC008713("");
					jobBo.setC008714("");
					jobBo.setC008715("");
					jobBo.setC008716("");
				} else if (num == 6) {
					jobBo.setC008717("");
					jobBo.setC008718("");
					jobBo.setC008719("");
					jobBo.setC008720("");
				} else if (num == 7) {
					jobBo.setC008721("");
					jobBo.setC008722("");
					jobBo.setC008723("");
					jobBo.setC008724("");
				} else if (num == 8) {
					jobBo.setC008725("");
					jobBo.setC008726("");
					jobBo.setC008727("");
					jobBo.setC008728("");
				} else if (num == 9) {
					jobBo.setC008729("");
					jobBo.setC008730("");
					jobBo.setC008731("");
					jobBo.setC008732("");
				} else if (num == 10) {
					jobBo.setC008733("");
					jobBo.setC008734("");
					jobBo.setC008735("");
					jobBo.setC008736("");
				}
				jobestimateucc.updateEstimate(jobBo);
				jobestimateucc.deleteJobContent(itemID, deleteContent[2]);
				super.getServletRequest().removeAttribute("tasklist" + num);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String change() {// 将修改后的内容提交，包括：履行责任、工作任务、时间比重、考核要点
		try {
			checkDatas(jobBo, num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public void checkDatas(EvaJobEstimateBO jobBo, int num) {
		String[] splitContent = doChange.split(":");
		if (num == 1) {
			jobBo.setC008001(splitContent[2]);
			jobBo.setC008005(splitContent[0]);
			jobBo.setC008010(splitContent[3] + "%");
			jobBo.setC008015(splitContent[1]);
		} else if (num == 2) {
			jobBo.setC008701(splitContent[2]);
			jobBo.setC008702(splitContent[0]);
			jobBo.setC008703(splitContent[3] + "%");
			jobBo.setC008704(splitContent[1]);
		} else if (num == 3) {
			jobBo.setC008705(splitContent[2]);
			jobBo.setC008706(splitContent[0]);
			jobBo.setC008707(splitContent[3] + "%");
			jobBo.setC008708(splitContent[1]);
		} else if (num == 4) {
			jobBo.setC008709(splitContent[2]);
			jobBo.setC008710(splitContent[0]);
			jobBo.setC008711(splitContent[3] + "%");
			jobBo.setC008712(splitContent[1]);
		} else if (num == 5) {
			jobBo.setC008713(splitContent[2]);
			jobBo.setC008714(splitContent[0]);
			jobBo.setC008715(splitContent[3] + "%");
			jobBo.setC008716(splitContent[1]);
		} else if (num == 6) {
			jobBo.setC008717(splitContent[2]);
			jobBo.setC008718(splitContent[0]);
			jobBo.setC008719(splitContent[3] + "%");
			jobBo.setC008720(splitContent[1]);
		} else if (num == 7) {
			jobBo.setC008721(splitContent[2]);
			jobBo.setC008722(splitContent[0]);
			jobBo.setC008723(splitContent[3] + "%");
			jobBo.setC008724(splitContent[1]);
		} else if (num == 8) {
			jobBo.setC008725(splitContent[2]);
			jobBo.setC008726(splitContent[0]);
			jobBo.setC008727(splitContent[3] + "%");
			jobBo.setC008728(splitContent[1]);
		} else if (num == 9) {
			jobBo.setC008729(splitContent[2]);
			jobBo.setC008730(splitContent[0]);
			jobBo.setC008731(splitContent[3] + "%");
			jobBo.setC008732(splitContent[1]);
		} else if (num == 10) {
			jobBo.setC008733(splitContent[2]);
			jobBo.setC008734(splitContent[0]);
			jobBo.setC008735(splitContent[3] + "%");
			jobBo.setC008736(splitContent[1]);
		}
		try {
			jobestimateucc.updateEstimate(jobBo);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public String saveScore() {
		try {
			for (int i = 1; i <= 10; i++) {
				List list = (List) super.getServletRequest().getAttribute(
						"content" + i);
				if (list != null) {
					for (int k = 0; k < list.size(); k++) {
						EvaJobContentBO jb = (EvaJobContentBO) list.get(k);
						if (this.saveStr != null) {
							String[] splitStr = saveStr.split(",");
							for (int j = 0; j < splitStr.length; j++) {// 第一次分割提交上来的所有的数据
								String[] change = splitStr[j].split(":");
								for (int m = 0; m < change.length; m++) {// 将分割后的单组数据再次进行分割
									if (change[0].equals(jb.getTaskID())) {
										jb.setLeadScore(change[1]);
										jobestimateucc.updateJobContent(jb);
									}
								}
							}
						}
					}
				}
			}
			jobBo = jobestimateucc.findJobEstimate(planID, itemID);
			jobBo.setStatus("8");
			jobestimateucc.updateEstimate(jobBo);
			JobEstimateLogBO bo1=new JobEstimateLogBO();
            bo1.setAction("8");
            bo1.setItemID(jobBo.getItemID());
            bo1.setOperateID(jobBo.getPersonID());
            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            jobestimateucc.saveJobEstimateLogBO(bo1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public void pageDatas() {// 页面数据显示
		for (int m = 1; m <= 10; m++) {
			List taskListm = new ArrayList();
			if (m == 10) {
				taskListm.add("10");
				taskListm.add(jobBo.getC008733());
				taskListm.add(jobBo.getC008734());
				taskListm.add(jobBo.getC008735());
				taskListm.add(jobBo.getC008736());
			} else if (m == 1) {
				taskListm.add("1");
				taskListm.add(jobBo.getC008001());
				taskListm.add(jobBo.getC008005());
				taskListm.add(jobBo.getC008010());
				taskListm.add(jobBo.getC008015());
			} else if (m == 2) {
				taskListm.add("2");
				taskListm.add(jobBo.getC008701());
				taskListm.add(jobBo.getC008702());
				taskListm.add(jobBo.getC008703());
				taskListm.add(jobBo.getC008704());
			} else if (m == 3) {
				taskListm.add("3");
				taskListm.add(jobBo.getC008705());
				taskListm.add(jobBo.getC008706());
				taskListm.add(jobBo.getC008707());
				taskListm.add(jobBo.getC008708());
			} else if (m == 4) {
				taskListm.add("4");
				taskListm.add(jobBo.getC008709());
				taskListm.add(jobBo.getC008710());
				taskListm.add(jobBo.getC008711());
				taskListm.add(jobBo.getC008712());
			} else if (m == 5) {
				taskListm.add("5");
				taskListm.add(jobBo.getC008713());
				taskListm.add(jobBo.getC008714());
				taskListm.add(jobBo.getC008715());
				taskListm.add(jobBo.getC008716());
			} else if (m == 6) {
				taskListm.add("6");
				taskListm.add(jobBo.getC008717());
				taskListm.add(jobBo.getC008718());
				taskListm.add(jobBo.getC008719());
				taskListm.add(jobBo.getC008720());
			} else if (m == 7) {
				taskListm.add("7");
				taskListm.add(jobBo.getC008721());
				taskListm.add(jobBo.getC008722());
				taskListm.add(jobBo.getC008723());
				taskListm.add(jobBo.getC008724());
			} else if (m == 8) {
				taskListm.add("8");
				taskListm.add(jobBo.getC008725());
				taskListm.add(jobBo.getC008726());
				taskListm.add(jobBo.getC008727());
				taskListm.add(jobBo.getC008728());
			} else if (m == 9) {
				taskListm.add("9");
				taskListm.add(jobBo.getC008729());
				taskListm.add(jobBo.getC008730());
				taskListm.add(jobBo.getC008731());
				taskListm.add(jobBo.getC008732());
			}
			if (taskListm.get(1) == null ||"".equals(taskListm.get(1))
					&& taskListm.get(2) == null ||"".equals(taskListm.get(2))
					&& taskListm.get(3) == null ||"".equals(taskListm.get(3))
					&& taskListm.get(4) == null ||"".equals(taskListm.get(4))) {// 增加岗位职责
				if (planID == null) {
					checkDatas(jobBo, m);
					break;
				}
			} else {
				final int size = taskListm.size();
				if (taskListm.get(1) != null&& !"".equals(taskListm.get(1)) 
						|| taskListm.get(2) != null&& !"".equals(taskListm.get(2))
						|| taskListm.get(3) != null&& !"".equals(taskListm.get(3)) 
						|| taskListm.get(4) != null&& !"".equals(taskListm.get(4))) {// 将所有的List转换成数组，然后存放到request中，供页面中使用
					try {
						contentList = jobestimateucc.findJobContent(
								(String) super.getHttpSession().getAttribute(
										"itemId"), (String) taskListm.get(0));
					} catch (SysException e) {
						e.printStackTrace();
					}

					// 根据seq的值查出content的内容
					final int contentSize = contentList.size();
					if (contentList.size() != 0) {
						List contentDetail = new ArrayList();
						for (int j = 0; j < contentList.size(); j++) {
							EvaJobContentBO jcb = (EvaJobContentBO) contentList
									.get(j);
							if (jcb.getLeadScore() == null) {
								jcb.setLeadScore("");
							}
							contentDetail.add(jcb);
						}
						this.getServletRequest().setAttribute("content" + m,
								contentDetail);
					}
					String[] array = (String[]) taskListm
							.toArray(new String[size]);
					this.getServletRequest()
							.setAttribute("tasklist" + m, array);// 把数组放到request中
				}
			}
		}
	}

	public void queryLeadPlanList() {// 领导打分
		try {
			jobBo = jobestimateucc.findJobEstimate(planID, itemID);
			this.statusDes=jobBo.getStatusDes();
			this.status=jobBo.getStatus();
			super.getHttpSession().setAttribute("status", status);
			this.getHttpSession().setAttribute("itemId", itemID);
			pageDatas();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void queryPlanList() {// 自助打分
		try {
			if (super.getRequestParameter("PersonID") != null) {
				personID = super.getRequestParameter("PersonID");
				super.getHttpSession().setAttribute("personID", personID);
			} else {
				personID = (String) super.getHttpSession().getAttribute("personID");
			}
			if (planID != null) {
				EvaJobEstimateBO bo = jobestimateucc.findSelfJobEstimateBO(
						planID, personID);
				if (bo == null) {
					EvaJobEstimateBO evaJobEstimateBO = new EvaJobEstimateBO();
					personBO = SysCacheTool.findPersonById(personID);
					// 根据postID的值查询出c008中所对应的记录
					postID = personBO.getPostId();
					evaJobEstimateBO.setPersonID(personID);
					evaJobEstimateBO.setPlanID(planID);
					jobestimateucc.saveDuty(evaJobEstimateBO);// 往evajobestimate表中插入三列
					jobestimateucc.insertDuty(postID, personID, planID);// 根据条件将c008中表的内容添加到evajobestimate表中
				}
				jobBo = jobestimateucc.findSelfJobEstimateBO(planID, personID);
				if(jobBo.getStatus()==null){
					jobBo.setStatus(EvaJobEstimateBO.DRAFT);
					super.getHttpSession().setAttribute("status", jobBo.getStatus());
				}else{
					super.getHttpSession().setAttribute("status", jobBo.getStatus());
				}
				status=jobBo.getStatus();
				statusDes=jobBo.getStatusDes();
				if (!jobBo.equals(null)) {// 获取计划名为非空的itemID
					itemID = jobBo.getItemID();
					this.getHttpSession().setAttribute("itemId", itemID);
					pageDatas();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}