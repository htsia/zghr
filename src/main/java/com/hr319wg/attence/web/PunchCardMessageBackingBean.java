package com.hr319wg.attence.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttenceLogBO;
import com.hr319wg.attence.pojo.bo.attMachineBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class PunchCardMessageBackingBean extends BaseBackingBean {
	private static String enterflag = "1"; // 进标记可扩展接口
	private static String outflag = "2"; // 出标记可扩展接口
	private IAttenceSetUCC attenceSetUCC;
	private String beginTime=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	private String endTime=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	private String pageInit;
	private String userid = super.getUserInfo().getUserId();
	private List persBos;
    private String showButtonDK ;
	private String machinevalue;
	private List machinevaluelist = new ArrayList();
	private String initEdit;
	private String flagvalue;
	private List flagvaluelist = new ArrayList();
	private String personName = super.getUserInfo().getName();
    private String backFlag="1";
    private String flag="1";
    private String personType;
    private String personTypeValue;
    private String name;
    private String personList;
    private IPersonUCC personucc;
    private String orgID=super.getUserInfo().getOrgId();
    private String personseq="";
    private String personcard="";
    private String orgnamevalue="";
    private String deptnamevalue="";
	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

     public String getShowButtonDK() {
        return showButtonDK;
    }

    public void setShowButtonDK(String showButtonDK) {
        this.showButtonDK = showButtonDK;
    }

	public List getPersBos() {
		return persBos;
	}

	public void setPersBos(List persBos) {
		this.persBos = persBos;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getPageInit() {
		try{
		/*
		 * Constants类中配置后属性ATTENCE_ONLINE，在执行 String
		 * name=Constants.ATTENCE_ONLINE;
		 */
        showButtonDK=Constants.ATTENCE_ONLINE;
         System.out.println("showButtonDK="+Constants.ATTENCE_ONLINE);
		AttClassGroupVO attclassgroupvo=(AttClassGroupVO)attenceSetUCC.findAttClassGroupVObyId(userid);
		if(attclassgroupvo!=null){
		    personseq=attclassgroupvo.getPersonSeq();
		    personcard=attclassgroupvo.getCard();
		    OrgBO a = SysCacheTool.findOrgById(attclassgroupvo.getOrgId());
		    orgnamevalue=a.getName();
		    OrgBO b=SysCacheTool.findOrgById(attclassgroupvo.getDeptId());
		    deptnamevalue=b.getName();
		}
		checkPersonCardMessage();
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String checkPersonCardMessage() {
		getHttpSession().removeAttribute("OBJECT");
		getHttpSession().removeAttribute("activeSql");
		getHttpSession().removeAttribute("pageNum");
		getHttpSession().removeAttribute("rowNum");
		try {
			TableVO table = new TableVO();
			String rowNums = (String) getHttpSession().getAttribute("rowNum");
			int rowNum = Constants.ACTIVE_PAGE_SIZE;
			if (rowNums != null)
				rowNum = Integer.parseInt(rowNums);
			User user = null;
			String sql = "";
			if ("1".equals(backFlag))
				sql = attenceSetUCC.queryPersonList(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
						Constants.NO, user,Constants.DEFAULT_QUERY_ATTENCE_PERSON,"",beginTime,endTime,userid);
			else
				sql = attenceSetUCC.queryPersonList(table, name,personType, orgID, 1, rowNum,
						"00900", user,Constants.DEFAULT_QUERY_ATTENCE_PERSON,"",beginTime,endTime,userid);
			
			getHttpSession().setAttribute("activeSql", sql);
			getHttpSession().setAttribute("pageNum", String.valueOf("1"));
			getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
			getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute("OBJECT");
			getHttpSession().removeAttribute("activeSql");
			getHttpSession().removeAttribute("pageNum");
			getHttpSession().removeAttribute("rowNum");
			msg.setMainMsg(e, getClass());
		}
		return "";
	}

	public String getInitEdit() {
		if (machinevaluelist != null) {
			machinevaluelist = new ArrayList();
		}
		if (flagvaluelist != null) {
			flagvaluelist = new ArrayList();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	/*
	 * 打卡功能实现方法
	 */
	public String punchCard() {
		AttenceLogBO attencelogbo = new AttenceLogBO();
		try {
			attencelogbo.setPersonId(userid);
			attencelogbo.setSubID(SequenceGenerator.getKeyId("A808"));
			attencelogbo.setRecord(Constants.NO);
			attencelogbo.setCardDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			attencelogbo.setCardTime(CommonFuns.getSysDate("HH:mm:ss"));
			attencelogbo.setMachineName(machinevalue);
			attenceSetUCC.saveAttenceLogBO(attencelogbo);
		} catch (SysException e) {

		}
		return "success";
	}

	public void doQueryMachineValue() {
		try {
			List attmachinebos = attenceSetUCC.findAllAttMachine();
			if (attmachinebos != null && attmachinebos.size() > 0) {
				for (int i = 0; i < attmachinebos.size(); i++) {
					attMachineBO attmachinebo = (attMachineBO) attmachinebos
							.get(i);
					SelectItem si = new SelectItem();
					si.setLabel(attmachinebo.getMachineName());
					si.setValue(attmachinebo.getMachineName());
					machinevaluelist.add(si);
				}
			}
		} catch (Exception e) {

		}
	}

	public String getMachinevalue() {
		return machinevalue;
	}

	public void setMachinevalue(String machinevalue) {
		this.machinevalue = machinevalue;
	}

	public List getMachinevaluelist() {
		doQueryMachineValue();
		return machinevaluelist;
	}

	public void setMachinevaluelist(List machinevaluelist) {
		this.machinevaluelist = machinevaluelist;
	}

	public void changeMachineValue(ValueChangeEvent event) {
		this.machinevalue = event.getNewValue().toString();
	}

	/*
	 * 进/出标志
	 */

	public void changeFlagValue(ValueChangeEvent event) {
		this.flagvalue = event.getNewValue().toString();
	}

	public String getFlagvalue() {
		return flagvalue;
	}

	public void setFlagvalue(String flagvalue) {
		this.flagvalue = flagvalue;
	}

	public List getFlagvaluelist() {
		doQueryFlagValue();
		return flagvaluelist;
	}

	public void setFlagvaluelist(List flagvaluelist) {
		this.flagvaluelist = flagvaluelist;
	}

	public void doQueryFlagValue() {
		SelectItem si = new SelectItem();
		si.setLabel("进标志");
		si.setValue(enterflag);
		flagvaluelist.add(si);
		SelectItem si1 = new SelectItem();
		si1.setLabel("出标志");
		si1.setValue(outflag);
		flagvaluelist.add(si1);
	}

	public String getBackFlag() {
		return backFlag;
	}

	public void setBackFlag(String backFlag) {
		this.backFlag = backFlag;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getPersonType() {
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getPersonTypeValue() {
		return personTypeValue;
	}

	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPersonList() {
		getHttpSession().removeAttribute("ok");
//		String superId = getServletRequest().getParameter("superId");
		getHttpSession().setAttribute("ok", orgID);
		String pageFlag = getServletRequest().getParameter("pageFlag");
//		String flag = getServletRequest().getParameter("flag");
		String sessionFlag = getServletRequest().getParameter("sessionFlag");
//		String backFlag = getServletRequest().getParameter("backFlag");
		if (sessionFlag == null)
			getHttpSession().removeAttribute("OBJECT");

		if ("1".equals(flag))
			try {
				TableVO table = new TableVO();
				String rowNums = (String) getHttpSession().getAttribute(
						"rowNum");
				int rowNum = Constants.ACTIVE_PAGE_SIZE;
				if (rowNums != null) {
					rowNum = Integer.parseInt(rowNums);
				}
				User user = null;
				String sql = "";
                
				if ("1".equals(backFlag))
					sql = attenceSetUCC.queryPersonList(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,Constants.DEFAULT_QUERY_ATTENCE_PERSON,"",beginTime,endTime,userid);
				else
					sql = attenceSetUCC.queryPersonList(table, name, "", orgID, 1, Constants.ACTIVE_PAGE_SIZE,
							Constants.NO, user,Constants.DEFAULT_QUERY_ATTENCE_PERSON,"",beginTime,endTime,userid);

				getHttpSession().setAttribute("activeSql", sql);
				getHttpSession().setAttribute("pageNum", String.valueOf("1"));
				getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
				getHttpSession().setAttribute(Constants.OBJECT, table);
			} catch (Exception e) {
			}

			if ("1".equals(pageFlag)) // 翻页
				try {
					String rowNums = getServletRequest().getParameter("rowNum");// Constants.PAGE;
					int pageNum = getServletRequest().getParameter("pageNum") == null
							|| "".equals(getServletRequest()
									.getParameter("pageNum")) ? 1 : Integer
							.parseInt(getServletRequest().getParameter("pageNum"));

					String sql = (String) getHttpSession()
							.getAttribute("activeSql");

					TableVO table = (TableVO) getHttpSession().getAttribute(
							Constants.OBJECT);
					if (table == null)
						table = new TableVO();
					int rowNum = Constants.ACTIVE_PAGE_SIZE;
					if (rowNums != null) {
						rowNum = Integer.parseInt(rowNums);
					}
					User user = this.getUserInfo();

					personucc.querySql(table, sql, user, pageNum, rowNum);
					getHttpSession().setAttribute(Constants.OBJECT, table);
					getHttpSession().setAttribute("activeSql", sql);
					getHttpSession().setAttribute("pageNum",
							String.valueOf(pageNum));
					getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
				} catch (SysException e) {
				}
		return personList;
	}

	public void setPersonList(String personList) {
		this.personList = personList;
	}

	public IPersonUCC getPersonucc() {
		return personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getPersonseq() {
		return personseq;
	}

	public void setPersonseq(String personseq) {
		this.personseq = personseq;
	}

	public String getPersoncard() {
		return personcard;
	}

	public void setPersoncard(String personcard) {
		this.personcard = personcard;
	}

	public String getOrgnamevalue() {
		return orgnamevalue;
	}

	public void setOrgnamevalue(String orgnamevalue) {
		this.orgnamevalue = orgnamevalue;
	}

	public String getDeptnamevalue() {
		return deptnamevalue;
	}

	public void setDeptnamevalue(String deptnamevalue) {
		this.deptnamevalue = deptnamevalue;
	}
	
}
