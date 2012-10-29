package com.hr319wg.attence.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import com.hr319wg.attence.pojo.bo.AttenceLogBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.EmpReduceBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.pojo.vo.PersonChangeVO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.qry.pojo.vo.QueryVO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.ShortMessageBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.ucc.IShortMessageUCC;
import com.hr319wg.user.pojo.bo.UserQryBO;
import com.hr319wg.user.pojo.vo.UserQryVO;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserQryUCC;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;
import com.hr319wg.util.SequenceGenerator;

public class QueryCardLogBackingBean extends BaseBackingBean {
	private String popuppostname;
	private String popuppostid;
	private String superId1;
	private List itemList=new ArrayList();
	private String findSeeValue;
	private String pageInits;
	private String begindatevalue;
	private String begintimevalue;
	private List lists=new ArrayList();
	private String initEdit;
	private String beginTime=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	private String endTime=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	private String flag="1";
	private String backFlag="1";
	private String OPER_ID;
	private List regTableList;
	private List listTableList;
	private String personList;
	private String name;
	private String nameStrs;
	private String mode;
	private String title;
	private String personType;
	private String personTypeValue;
	private String personTypeDesc;
	private String superId=super.getUserInfo().getOrgId();
	private String superName;
	private String type;
	private String defaultQry;
	private List displaySetList;
	private List pids;
	private String personID;
	private String code;
	private String dept;
	private IPersonUCC personucc;
	private IUserQryUCC userqryucc;
	private IQueryUCC queryucc;
	private IOrgUCC orgucc;
	private IUserReportUCC userreportucc;
	private IShortMessageUCC shortmessageucc;
	private String checkingPerson;
	private String checkingPerson_audit;
	private String processDate;
	private PageVO pagevo;
	private List reducebos;
	private boolean onlyAuditing;
	private String initReduceAudit;
	private String doReduceAudit;
	private String doBatchReduceAudit;
	private EmpReduceBO reducebo;
	private PersonBO personbo;
	private List reduceList;
	private String auditResult;
	private String auditOpition;
	private String auditMessage;
	private boolean autoMessage;
	private String attCard;
	private IAttenceSetUCC attenceSetUCC;
	private String pageInit;
	private String perIds;
	private static String perIdLists;
	private String namelist;
	private boolean isExist;
	private PageVO mypage = new PageVO();
	private String  cardtype="NO";

    public String getCardtype() {
        return cardtype;
    }

    public void setCardtype(String cardtype) {
        this.cardtype = cardtype;
    }

    public String first1() {
		mypage.setCurrentPage(1);
		doQuerys();
		return "";
	}

	public String pre1() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuerys();
		return "";
	}

	public String next1() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuerys();
		return "";
	}

	public String last1() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuerys();
		return "";
	}
	
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
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

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getBackFlag() {
		return backFlag;
	}

	public void setBackFlag(String backFlag) {
		this.backFlag = backFlag;
	}

	public boolean getIsExist() {
		return isExist;
	}

	public void setExist(boolean isExist) {
		this.isExist = isExist;
	}

	public String getPerIds() {
		return perIds;
	}

	public void setPerIds(String perIds) {
		this.perIds = perIds;
	}

	public String getNamelist() {
		return namelist;
	}

	public void setNamelist(String namelist) {
		this.namelist = namelist;
	}

	public String getPageInit() {
		if (super.getRequestParameter("superId") != null && !"".equals(super.getRequestParameter("superId"))) {
			superId = super.getRequestParameter("superId");
		}
        if(superId!=null&&!superId.equals("")){
		    queryPerson();
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

	public String getAttCard() {
		return attCard;
	}

	public void setAttCard(String attCard) {
		this.attCard = attCard;
	}

	public String getPersonList() {
		return personList;
	}

	public void setPersonList(String personList) {
		this.personList = personList;
	}

	public List getReduceList() {
		return reduceList;
	}

	public void setReduceList(List list) {
		reduceList = list;
	}

	public PersonBO getPersonbo() {
		return personbo;
	}

	public void setPersonbo(PersonBO bo) {
		personbo = bo;
	}

	public EmpReduceBO getReducebo() {
		return reducebo;
	}

	public void setReducebo(EmpReduceBO bo) {
		reducebo = bo;
	}

	public String getDoBatchReduceAudit() {
		try {
			if (super.getRequestParameter("pIDs") != null) {
				code = super.getRequestParameter("pIDs");
				String pids[] = code.split(",");
				reduceList = new ArrayList();
				for (int i = 0; i < pids.length; i++) {
					EmpReduceBO rb = personucc.findReduceBO(pids[i]);
					PersonBO pb = SysCacheTool.findPersonById(rb.getPersID());
					rb.setA001054cur(CodeUtil.interpertCode("0135", pb
							.getPersonType()));
					rb.setPersName(pb.getName());
					rb.setPersCode(pb.getPersonCode());
					rb.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb
							.getOrgId()));
					if (pb.getDegree() != null)
						rb.setDegreeName(CodeUtil.interpertCode("0140", pb
								.getDegree()));
					if (rb.getA001054() != null)
						rb.setA001054des(CodeUtil.interpertCode("0135", rb
								.getA001054()));
					if (rb.getA001725() != null)
						rb.setA001725des(CodeUtil.interpertCode("0145", rb
								.getA001725()));
					if (rb.getA016010() != null)
						rb.setA016010des(CodeUtil.interpertCode("0200", rb
								.getA016010()));
					reduceList.add(rb);
				}

			}
		} catch (Exception e) {
		}
		return doBatchReduceAudit;
	}

	public void setDoBatchReduceAudit(String audit) {
		doBatchReduceAudit = audit;
	}

	public String getDoReduceAudit() {
		try {
			if (super.getRequestParameter("pID") != null) {
				code = super.getRequestParameter("pID");
				reducebo = personucc.findReduceBO(code);
				personbo = SysCacheTool.findPersonById(reducebo.getPersID());
				personbo.setPersonType(CodeUtil.interpertCode("0135", personbo
						.getPersonType()));
				personbo.setSex(CodeUtil.interpertCode("0100", personbo
						.getSex()));
				personbo.setState(CodeUtil.interpertCode("0145", personbo
						.getState()));
				personbo.setFolk(CodeUtil.interpertCode("0115", personbo
						.getFolk()));
				reducebo.setPersName(personbo.getName());
				reducebo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
						personbo.getOrgId()));
				if (personbo.getDegree() != null)
					reducebo.setDegreeName(CodeUtil.interpertCode("0140",
							personbo.getDegree()));
				if (reducebo.getA001054() != null)
					reducebo.setA001054des(CodeUtil.interpertCode("0135",
							reducebo.getA001054()));
				if (reducebo.getA001725() != null)
					reducebo.setA001725des(CodeUtil.interpertCode("0145",
							reducebo.getA001725()));
				if (reducebo.getA016010() != null)
					reducebo.setA016010des(CodeUtil.interpertCode("0200",
							reducebo.getA016010()));
			}
		} catch (Exception e) {
		}
		return doReduceAudit;
	}

	public void setDoReduceAudit(String audit) {
		doReduceAudit = audit;
	}

	public boolean isOnlyAuditing() {
		return onlyAuditing;
	}

	public void setOnlyAuditing(boolean b) {
		onlyAuditing = b;
	}

	public String getType() {
		return type;
	}

	public void setType(String st) {
		type = st;
	}

	public String getInitReduceAudit() {
		if (super.getRequestParameter("type") != null) {
			superId = super.getRequestParameter("superId");
			type = super.getRequestParameter("type");
			doauditQuery();
		}
		return initReduceAudit;
	}

	public void setInitReduceAudit(String init) {
		initReduceAudit = init;
	}

	public PageVO getPagevo() {
		return pagevo;
	}

	public void setPagevo(PageVO vo) {
		pagevo = vo;
	}

	public String batchauditReduceNO() {
		try {
			if (code != null && !"".equals(code)) {
				String pids[] = code.split(",");
				for (int i = 0; i < pids.length; i++) {
					EmpReduceBO rb = personucc.findReduceBO(pids[i]);
					rb.setAuditID(super.getUserInfo().getUserId());
					rb.setAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
					rb.setAuditResult("0");
					personucc.saveReduceBO(rb);
				}

			}
		} catch (Exception e) {
		}
		return "success";
	}

	public String batchauditReduceOK() {
		try {
			if (code != null && !"".equals(code)) {
				String pids[] = code.split(",");
				for (int i = 0; i < pids.length; i++) {
					EmpReduceBO rb = personucc.findReduceBO(pids[i]);
					rb.setAuditID(super.getUserInfo().getUserId());
					rb.setAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
					rb.setAuditResult("1");
					personucc.saveReduceBO(rb);
					PersonChangeVO personchangevo = new PersonChangeVO();
					personchangevo.setTractDate(CommonFuns
							.getSysDate("yyyy-MM-dd"));
					personchangevo.setTractPerson(super.getUserInfo()
							.getUserId());
					personchangevo.setChangeDate(rb.getApplyDate());
					personchangevo.setChangeType(rb.getA016010());
					personucc.updateRetirePerson(null, personchangevo, rb.getPersID()
							.split(","));
					personucc.ModifyPersonType(rb.getPersID().split(","), rb
							.getA001054());
					personucc.ModifyPersonStatus(rb.getPersID().split(","), rb
							.getA001725());
					SysCache.setMap(rb.getPersID().split(","), 3, 6);
				}

			}
		} catch (Exception e) {
		}
		return "success";
	}

	public String auditReduceNO() {
		try {
			reducebo.setAuditID(super.getUserInfo().getUserId());
			reducebo.setAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			reducebo.setAuditResult("0");
			personucc.saveReduceBO(reducebo);
		} catch (Exception e) {
		}
		return "success";
	}

	public String resumeAudit() {
		try {
			reducebo.setAuditID(super.getUserInfo().getUserId());
			reducebo.setAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			reducebo.setAuditResult("");
			personucc.saveReduceBO(reducebo);
		} catch (Exception e) {
		}
		return "success";
	}

	public String auditReduceOK() {
		try {
			reducebo.setAuditID(super.getUserInfo().getUserId());
			reducebo.setAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			reducebo.setAuditResult("1");
			personucc.saveReduceBO(reducebo);
			PersonChangeVO personchangevo = new PersonChangeVO();
			personchangevo.setTractDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			personchangevo.setTractPerson(super.getUserInfo().getUserId());
			personchangevo.setChangeDate(reducebo.getApplyDate());
			personchangevo.setChangeType(reducebo.getA016010());
			personucc.updateRetirePerson(null, personchangevo, reducebo.getPersID()
					.split(","));
			personucc.ModifyPersonType(reducebo.getPersID().split(","),
					reducebo.getA001054());
			personucc.ModifyPersonStatus(reducebo.getPersID().split(","),
					reducebo.getA001725());
			SysCache.setMap(reducebo.getPersID().split(","), 3, 6);
			doauditQuery();
		} catch (Exception e) {
		}
		return "success";
	}

	public String auditfirst() {
		pagevo.setCurrentPage(1);
		doauditQuery();
		return "";
	}

	public String auditlast() {
		pagevo.setCurrentPage(pagevo.getTotalPage());
		doauditQuery();
		return "";
	}

	public String auditpre() {
		if (pagevo.getCurrentPage() >= 2) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() - 1);
			doauditQuery();
		}
		return "";
	}

	public String auditnext() {
		if (pagevo.getCurrentPage() < pagevo.getTotalPage()) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() + 1);
			doauditQuery();
		}
		return "";
	}

	public String downloadFile() {
		ServletContext context = BaseBackingBean.getServletContext();
		String path = context.getRealPath("/") + File.separator + "file"
				+ File.separator + "tmp";
		List list = new ArrayList();
		String header[] = new String[8];
		header[0] = "???????";
		header[1] = "????¦Ë";
		header[2] = "????";
		header[3] = "???";
		header[4] = "???????";
		header[5] = "???????";
		header[6] = "??????";
		header[7] = "??????";
		try {
			for (int i = 0; i < reducebos.size(); i++) {
				EmpReduceBO vo = (EmpReduceBO) reducebos.get(i);
				String content[] = new String[16];
				content[0] = CommonFuns.filterNull(vo.getApplyDate());
				content[1] = CommonFuns.filterNull(vo.getOrgName());
				content[2] = CommonFuns.filterNull(vo.getPersName());
				content[3] = CommonFuns.filterNull(vo.getDegreeName());
				content[4] = CommonFuns.filterNull(vo.getA016010des());
				content[5] = CommonFuns.filterNull(vo.getA001054des());
				content[6] = CommonFuns.filterNull(vo.getA001725des());
                if("1".equals(vo.getAuditResult())){
				    content[7] ="???";
                }else if("0".equals(vo.getAuditResult())){
                    content[7] ="?????";
                }else{
                    content[7] ="??????";
                }
				list.add(i, content);
			}

			String fileName = FileUtil.exportFile(path, header, null, list,
                    false);
			String url = super.getServletRequest().getContextPath()
					+ "/file/tmp/" + fileName;
			FacesContext ctx = FacesContext.getCurrentInstance();
			HttpServletResponse response = (HttpServletResponse) ctx
					.getExternalContext().getResponse();
			ServletOutputStream out = response.getOutputStream();
			StringBuffer buf = new StringBuffer();
			buf.append("<script type=text/javascript>");
			buf.append("window.open('").append(url).append("')");
			buf.append("</script >");
			out.print(buf.toString());
			out.flush();
		} catch (Exception e) {
		}
		return "";
	}

	public void doauditQuery() {
		try {
			if (pagevo.getCurrentPage() == 0)
				pagevo.setCurrentPage(1);
			String addwhere = "  bo.applyDate like '"
					+ CommonFuns.filterNull(processDate) + "%'";
			if ("1".equals(type))
				addwhere = addwhere + " and (pb.degree in ("
						+ Constants.EMP_CADRESCODE
						+ ") or isnull(pb.degree,' ')=' ')";
			else
				addwhere = addwhere + " and (pb.degree in ("
						+ Constants.EMP_WORKCODE
						+ ") or isnull(pb.degree,' ')=' ')";
			if (onlyAuditing)
				addwhere = addwhere + " and isnull(bo.auditResult,' ')=' '";
			reducebos = personucc.queryReducingPersonList(superId, pagevo,
					addwhere);
		} catch (Exception ex) {
			msg.setMainMsg(ex, getClass());
		}
	}

	public String first() {
		pagevo.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String last() {
		pagevo.setCurrentPage(pagevo.getTotalPage());
		doQuery();
		return "";
	}

	public String pre() {
		if (pagevo.getCurrentPage() >= 2) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() - 1);
			doQuery();
		}
		return "";
	}

	public String next() {
		if (pagevo.getCurrentPage() < pagevo.getTotalPage()) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() + 1);
			doQuery();
		}
		return "";
	}

	public List getReducebos() {
		if (reducebos == null)
			doQuery();
		return reducebos;
	}

	public void setReducebos(List list) {
		reducebos = list;
	}

	public void doQuery() {
		try {
			if (pagevo.getCurrentPage() == 0)
				pagevo.setCurrentPage(1);
			String addwhere = " 1=1 ";
			if (processDate != null && !"".equals(processDate))
				addwhere = addwhere + " and bo.applyDate like '" + processDate
						+ "%'";
			reducebos = personucc.queryReducingPersonList(super.getUserInfo()
					.getOrgId(), pagevo, addwhere);
		} catch (Exception ex) {
			msg.setMainMsg(ex, getClass());
		}
	}

	public String getProcessDate() {
		if (processDate == null)
			processDate = CommonFuns.getSysDate("yyyy-MM");
		return processDate;
	}

	public void setProcessDate(String date) {
		processDate = date;
	}

	public String getCheckingPerson_audit() {
		try {
			if (super.getRequestParameter("superId") != null)
				superId = super.getRequestParameter("superId");
			if (super.getRequestParameter("type") != null)
				type = super.getRequestParameter("type");
			TableVO table = new TableVO();
			String rowNums = (String) getHttpSession().getAttribute("rowNum");
			int rowNum = Constants.ACTIVE_PAGE_SIZE;
			if (rowNums != null)
				rowNum = Integer.parseInt(rowNums);
			User user = getUserInfo();
			String sql = "";
			int pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super
					.getRequestParameter("pageNum")));
			if (pageNum == 0)
				pageNum = Integer.parseInt(CommonFuns
						.filterNullToZero((String) super.getHttpSession()
								.getAttribute("pageNum")));
			if (pageNum == 0)
				pageNum = 1;
			String typeWhere = "";
			if ("1".equals(type))
				typeWhere = " A001031 in (" + Constants.EMP_CADRESCODE + ")";
			else if ("2".equals(type))
				typeWhere = " A001031 in (" + Constants.EMP_WORKCODE + ")";
			else
				typeWhere = " A001031 in (" + Constants.EMP_OTHER + ")";
			if (onlyAuditing)
				sql = personucc.queryAuditingPersonList(table, superId,
						pageNum, rowNum, user,
						Constants.DEFAULT_NEWPERSON_AUDIT,
						"  auditResult is null and " + typeWhere);
			else
				sql = personucc.queryAuditingPersonList(table, superId,
						pageNum, rowNum, user,
						Constants.DEFAULT_NEWPERSON_AUDIT, typeWhere);
			getHttpSession().setAttribute("activeSql", sql);
			getHttpSession().setAttribute("pageNum", String.valueOf("1"));
			getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
			getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
		}
		return checkingPerson_audit;
	}

	public void setCheckingPerson_audit(String check) {
		checkingPerson_audit = check;
	}

	public String doQueryCheckingPerson() {
		return getCheckingPerson();
	}

	public String getCheckingPerson() {
		try {
			TableVO table = new TableVO();
			String rowNums = (String) getHttpSession().getAttribute("rowNum");
			int rowNum = Constants.ACTIVE_PAGE_SIZE;
			if (rowNums != null)
				rowNum = Integer.parseInt(rowNums);
			int pageNum = 1;
			if (super.getRequestParameter("pageNum") != null
					&& !"".equals(super.getRequestParameter("pageNum")))
				pageNum = Integer
						.parseInt(super.getRequestParameter("pageNum"));
			User user = getUserInfo();
			String sql = "";
			String dateWhere = " 1=1 ";
			if (!"-1".equals(getProcessDate()) && !"".equals(getProcessDate()))
				dateWhere = dateWhere + " and A016020 like '"
						+ getProcessDate() + "%'";
			if (onlyAuditing)
				sql = personucc.queryAuditingPersonList(table, user.getOrgId(),
						pageNum, rowNum, user,
						Constants.DEFAULT_NEWPERSON_AUDIT,
						"  auditResult is null and " + dateWhere);
			else
				sql = personucc.queryAuditingPersonList(table, user.getOrgId(),
						pageNum, rowNum, user,
						Constants.DEFAULT_NEWPERSON_AUDIT, dateWhere);
			getHttpSession().setAttribute("activeSql", sql);
			getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
			getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
			getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
		}
		return checkingPerson;
	}

	public void setCheckingPerson(String person) {
		checkingPerson = person;
	}

	public List getListTableList() {
		try {
			listTableList = userreportucc.queryUserRptToWeb(super.getUserInfo()
					.getUserId(), OPER_ID, UserRptVO.TYPE_ROSTER);
			if (listTableList == null)
				listTableList = new ArrayList();
		} catch (Exception e) {
			listTableList = new ArrayList();
		}
		return listTableList;
	}

	public void setListTableList(List li) {
		listTableList = li;
	}

	public List getRegTableList() {
		try {
			regTableList = userreportucc.queryUserRptToWeb(super.getUserInfo()
					.getUserId(), OPER_ID, UserRptVO.TYPE_REG);
			if (regTableList == null)
				regTableList = new ArrayList();
		} catch (Exception e) {
			regTableList = new ArrayList();
		}
		return regTableList;
	}

	public void setRegTableList(List li) {
		regTableList = li;
	}

	public IOrgUCC getOrgucc() {
		return orgucc;
	}

	public void setOrgucc(IOrgUCC orgucc) {
		this.orgucc = orgucc;
	}

	public void setPids(List li) {
		pids = li;
	}

	public List getPids() {
		return pids;
	}

	public String getNameStrs() {
		return nameStrs;
	}

	public void setNameStrs(String c) {
		nameStrs = c;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String c) {
		code = c;
	}

	public String getPersonID() {
		return personID;
	}

	public void setPersonID(String setId) {
		personID = setId;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String setId) {
		dept = setId;
	}

	public String getDefaultQry() {
		return defaultQry;
	}

	public void setDefaultQry(String id) {
		defaultQry = id;
	}

	public IUserQryUCC getUserqryucc() {
		return userqryucc;
	}

	public void setUserqryucc(IUserQryUCC iu) {
		userqryucc = iu;
	}

	public IShortMessageUCC getShortmessageucc() {
		return shortmessageucc;
	}

	public void setShortmessageucc(IShortMessageUCC ucc) {
		shortmessageucc = ucc;
	}

	public IQueryUCC getQueryucc() {
		return queryucc;
	}

	public void setQueryucc(IQueryUCC iu) {
		queryucc = iu;
	}

	public void setUserreportucc(IUserReportUCC iur) {
		userreportucc = iur;
	}

	public IUserReportUCC getUserreportucc() {
		return userreportucc;
	}

	public List getDisplaySetList() {
		if (displaySetList == null)
			InitDisplay();
		return displaySetList;
	}

	public void setDisplaySetList(List list) {
		displaySetList = list;
	}

	public String getPersonTypeDesc() {
		if (personTypeValue == null || "".equals(personTypeValue))
			personTypeDesc = "?????????:??????";
		else
			personTypeDesc = "?????????:" + personTypeValue;
		return personTypeDesc;
	}

	public void setPersonTypeDesc(String desc) {
		personTypeDesc = desc;
	}

	public String getMode() {
		if (super.getRequestParameter("mode") != null)
			mode = super.getRequestParameter("mode");
		return mode;
	}

	public void setMode(String mo) {
		mode = mo;
	}

	public String getTitle() {
		if (super.getRequestParameter("title") != null)
			title = super.getRequestParameter("title");
		return title;
	}

	public void setTitle(String mo) {
		title = mo;
	}

	public IPersonUCC getPersonucc() {
		return personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}

	private void InitDisplay() {
		ArrayList setList = new ArrayList();
		SelectItem itemSpace = new SelectItem();
		itemSpace.setLabel("---????????????---");
		itemSpace.setValue("-1");
		setList.add(itemSpace);
		try {
			QueryVO qv = queryucc
					.findQueryVO(Constants.DEFAULT_QUERY_ATTENCE_LOG);
			SelectItem itemDefault = new SelectItem();
			itemDefault.setLabel(qv.getName());
			itemDefault.setValue(qv.getQryId());
			setList.add(itemDefault);
			defaultQry = Constants.DEFAULT_QUERY_ATTENCE_LOG;
			List list = userqryucc.queryUserQry(
					super.getUserInfo().getUserId(), OPER_ID);
			for (int i = 0; i < list.size(); i++) {
				UserQryVO role = (UserQryVO) list.get(i);
				SelectItem item = new SelectItem();
				item.setLabel(role.getQryName());
				item.setValue(role.getQryID());
				if (role.getIsCurrent() != null
						&& role.getIsCurrent().equals("1"))
					defaultQry = role.getQryID();
				setList.add(item);
			}

		} catch (Exception e) {
		}
		displaySetList = setList;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPersonType() {
		if (personType == null || "".equals(personType)) {
			personType = Constants.IN_SERVICE_TYPE;
			personTypeValue = Constants.IN_SERVICE_DES;
		}
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getPersonTypeValue() {
		if (personType != null) {
			String valist[] = personType.split(",");
			personTypeValue = "";
			for (int i = 0; i < valist.length; i++)
				if ("".equals(personTypeValue))
					personTypeValue = CodeUtil.interpertCode(
							CodeUtil.TYPE_CODE, valist[i])
							+ "(" + valist[i] + ")";
				else
					personTypeValue += ","
							+ CodeUtil.interpertCode(CodeUtil.TYPE_CODE,
									valist[i]) + "(" + valist[i] + ")";

		}
		return personTypeValue;
	}

	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}

	public String getSuperName() {
		if (superId != null && !"".equals(superId))
			superName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, superId);
		else
			superName = "";
		return superName;
	}

	public void setSuperName(String superId) {
		superName = superId;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public void changeQuery(ValueChangeEvent event) {
		try {
			defaultQry = event.getNewValue().toString();
			userqryucc.CancelSelect(super.getUserInfo().getUserId(), OPER_ID);
			if (!defaultQry.equals(Constants.DEFAULT_QUERY_PERSON)) {
				UserQryBO ub = userqryucc.getQueryByID(super.getUserInfo()
						.getUserId(), defaultQry, OPER_ID);
				ub.setIsCurrent("1");
				userqryucc.save(ub);
			}
			queryPerson();
		} catch (Exception e) {
		}
	}

	public String queryMultPerson() {
		String backFlag = getServletRequest().getParameter("backFlag");
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
			User user = getUserInfo();
			String sql = personucc.queryPersonList(table, nameStrs, personType,
					superId, 1, rowNum, "00900", user, defaultQry);
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
		return null;
	}

	public String queryPerson() {
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
			User user = getUserInfo();
			String sql = "";
            if(cardtype.equals("NO")){
                cardtype="";
            }
			if ("1".equals(backFlag))
				sql = attenceSetUCC.queryPersonList(table, name,personType, superId, 1, Constants.ACTIVE_PAGE_SIZE,
						Constants.NO, user,Constants.DEFAULT_QUERY_ATTENCE_LOG,"",beginTime,endTime,popuppostid,"",cardtype);
			else
				sql = attenceSetUCC.queryPersonList(table, name,personType, superId, 1, rowNum,
						"00900", user,Constants.DEFAULT_QUERY_ATTENCE_LOG,"",beginTime,endTime,popuppostid,"",cardtype);
			
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

	private void BeginEdit() {
		String tableId = "A067";
		PersonBO bo = SysCacheTool.findPersonById(personID);
		if (bo != null) {
			personID = bo.getPersonId();
			code = bo.getPersonCode();
			name = bo.getName();
			dept = SysCacheTool.findOrgById(bo.getDeptId()).getName();
			User user = getUserInfo();
			getHttpSession().setAttribute(tableId + "fk", personID);
			try {
				TableVO table = orgucc.findNewPage(tableId, user);
				getHttpSession().setAttribute(tableId, table);
			} catch (Exception e) {
			}
		} else {
			code = "¦Ä???";
			personID = "";
			name = "¦Ä???";
			dept = "¦Ä???";
			getHttpSession().removeAttribute(tableId);
		}
	}

	public String addMany() {
		String tableId = "A067";
		try {
			String perList[] = personucc.getPIDsbyNameORCode(name, super
					.getUserInfo().getOrgId());
			pids.clear();
			if (perList != null && perList.length > 0) {
				for (int i = 0; i < perList.length; i++) {
					PersonBO bo = SysCacheTool.findPersonById(perList[i]);
					OrgBO dept = SysCacheTool.findOrgById(bo.getDeptId());
					SelectItem si = new SelectItem();
					si.setLabel(bo.getName() + "|" + dept.getName());
					si.setValue(bo.getPersonId());
					pids.add(si);
				}

				personID = perList[0];
				BeginEdit();
			} else {
				code = "¦Ä???";
				name = "¦Ä???";
				getHttpSession().removeAttribute(tableId);
			}
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute(tableId + "fk");
			getHttpSession().removeAttribute(tableId);
			msg.setMainMsg(e, getClass());
		}
		return "";
	}

	public String saveManyAdd() {
		String tableId = "A067";
		try {
			User user = getUserInfo();
			TableVO table = (TableVO) getHttpSession().getAttribute(tableId);
			Map dataMap = getServletRequest().getParameterMap();
			Map ee = new HashMap();
			ee.putAll(dataMap);
			Iterator it = ee.keySet().iterator();
			Map imageMap = new HashMap();
			do {
				if (!it.hasNext())
					break;
				String itemId = (String) it.next();
				InfoItemBO item = SysCacheTool.findInfoItem(null, itemId);
				if (item != null && "14".equals(item.getItemDataType())) {
					byte b[] = (byte[]) (byte[]) getHttpSession().getAttribute(
							itemId);
					imageMap.put(itemId, b);
					getHttpSession().removeAttribute(itemId);
				}
			} while (true);
			if (imageMap.isEmpty())
				orgucc.updatePageInfo(table, ee, user);
			else
				orgucc.updatePageInfo(table, ee, user, imageMap);
			CellVO cv[] = table.getRowData()[0].getCell();
			for (int i = 0; i < cv.length; i++)
				if (!cv[i].getItemId().equals("ID"))
					cv[i].setValue("");

			getHttpSession().setAttribute(tableId, table);
			super.showMessageDetail("????????");
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute(tableId + "fk");
			getHttpSession().removeAttribute(tableId);
			super.showMessageDetail("??????:" + e.getMessage());
		}
		return "list";
	}

	public void changePerson(ValueChangeEvent event) {
		if (event.getNewValue() != null) {
			personID = event.getNewValue().toString();
			BeginEdit();
		}
	}

	public boolean isAutoMessage() {
		return autoMessage;
	}

	public void setAutoMessage(boolean b) {
		autoMessage = b;
	}

	public String getAuditMessage() {
		return auditMessage;
	}

	public void setAuditMessage(String ad) {
		auditMessage = ad;
	}

	public String getAuditOpition() {
		return auditOpition;
	}

	public void setAuditOpition(String ad) {
		auditOpition = ad;
	}

	public String getAuditResult() {
		return auditResult;
	}

	public void setAuditResult(String ad) {
		auditResult = ad;
	}

	public String deleteInvalid() {
		try {
			String ids = super.getRequestParameter("pids");
			if (ids != null) {
				String idList[] = ids.split(",");
				for (int i = 0; i < idList.length; i++) {
					String oper = personucc.queryAddPersonOperater(idList[i]);
					ShortMessageBO sbo = new ShortMessageBO();
					sbo.setReceiveID(oper);
					sbo.setSendID(super.getUserInfo().getUserId());
					sbo.setSendTime(CommonFuns
							.getSysDate("yyyy-MM-dd HH:mm:ss"));
					sbo.setIsPopup("0");
					sbo.setContent(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON,
							idList[i])
							+ "???????????????");
					shortmessageucc.SaveMessage(sbo);
					personucc.DeleteHiddenPerson(idList[i]);
				}

			}
		} catch (Exception e) {
		}
		return "success";
	}

	public String saveAudit() {
		try {
			String ids[] = getServletRequest().getParameter("pids").split(",");
			for (int i = 0; i < ids.length; i++) {
				personucc.UpdateAuditState(ids[i], auditOpition, auditResult,
						CommonFuns.getSysDate("yyyy-MM-dd"), super
								.getUserInfo().getUserId());
				if ("00901".equals(auditResult))
					personucc.UpdateA001730(ids[i], "00900");
			}

			String oper[] = personucc.queryAddPersonOperater(ids);
			for (int i = 0; i < oper.length; i++) {
				ShortMessageBO sbo = new ShortMessageBO();
				sbo.setReceiveID(oper[i]);
				sbo.setSendID(super.getUserInfo().getUserId());
				sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
				sbo.setIsPopup("0");
				sbo.setContent(auditMessage);
				shortmessageucc.SaveMessage(sbo);
			}

		} catch (Exception e) {
		}
		return "success";
	}
	
	public String getBegindatevalue() {
		return begindatevalue;
	}

	public void setBegindatevalue(String begindatevalue) {
		this.begindatevalue = begindatevalue;
	}

	public String getBegintimevalue() {
		return begintimevalue;
	}

	public void setBegintimevalue(String begintimevalue) {
		this.begintimevalue = begintimevalue;
	}

	public String getPopuppostname() {
		return popuppostname;
	}

	public void setPopuppostname(String popuppostname) {
		this.popuppostname = popuppostname;
	}

	public String getPopuppostid() {
		return popuppostid;
	}

	public void setPopuppostid(String popuppostid) {
		this.popuppostid = popuppostid;
	}

	public String delete(){
		try{
			attenceSetUCC.deleteAttenceLogBO(superId,beginTime,endTime,name);
			super.showMessageDetail("????["+beginTime+"~"+endTime+"]????????????????????");
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public String getInitEdit() {
		try{
		if (super.getRequestParameter("perIds") != null
				&& !super.getRequestParameter("perIds").equals("")) {
			perIds = super.getRequestParameter("perIds");
			String[] personIds=perIds.split(",");
			super.getHttpSession().removeAttribute("perIdLists");
			ArrayList list=new ArrayList(); 
			for(int i=0;i<personIds.length;i++){
	             if(!list.contains(personIds[i])){
	            	 list.add(personIds[i]);  
	             } 
			}
			super.getHttpSession().setAttribute("perIdLists",list);
		}
		find();
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	
	public String find(){
		try{
			if(lists!=null && lists.size()>0){
				lists=new ArrayList();
			}

            List list1=(List)super.getHttpSession().getAttribute("perIdLists");
            if(list1!=null && list1.size()>0){
            	for(int i=0;i<list1.size();i++){
            		String id=(String)list1.get(i);
					AttClassGroupVO attclassgroupvo=attenceSetUCC.findAttClassGroupVObyId(id);
					OrgBO a=SysCacheTool.findOrgById(attclassgroupvo.getDeptId());
					attclassgroupvo.setDeptName(a.getName());
					OrgBO b1 = SysCacheTool.findOrgById(attclassgroupvo.getOrgId());
					attclassgroupvo.setOrgName(b1.getName());
					lists.add(attclassgroupvo);
            	}
            }

		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String remove(){
		String ids[] = getServletRequest().getParameterValues("selected_ids");
        List list=(List)super.getHttpSession().getAttribute("perIdLists");
        if(list!=null && list.size()>0){
            int i=0;
            while(i<list.size()){
            	String id=(String)list.get(i);
            	if(id!=null && !"".equals(id)){
                  if(ids!=null){
                	  String name="";
                	for(int j=0;j<ids.length;j++){
                		String id1=(String)ids[j];
                		if(id.equals(id1)){
                			name="name";
                		}
                	}
                	if(!"".equals(name)){
                		list.remove(i);
                	}else{
                		i++;
                	}
                }
            	}
            }
        }
        super.getHttpSession().removeAttribute("perIdLists");
        super.getHttpSession().setAttribute("perIdLists",list);
		return "";
	}
	
	public String save_add(){
		try{
		List list=(List)super.getHttpSession().getAttribute("perIdLists");
		if(list!=null && list.size()>0){
        	for(int i=0;i<list.size();i++){
        		String id=(String)list.get(i);
        		AttenceLogBO attencelogbo=new AttenceLogBO();
        		attencelogbo.setPersonId(id);
    			attencelogbo.setSubID(SequenceGenerator.getKeyId("A808"));
    			attencelogbo.setRecord(Constants.NO);
    			attencelogbo.setCardDate(begindatevalue);
    			String hms=begintimevalue+":00";
    			attencelogbo.setCardTime(hms);
    			attencelogbo.setRegisterCard(Constants.YES);
    			attenceSetUCC.saveAttenceLogBO(attencelogbo);
        	}
//        	super.getHttpSession().removeAttribute("perIdLists");
        	super.showMessageDetail("????????");
		}else{
			super.showMessageDetail("??????????");
			return "";
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public String getPageInits() {
		if (super.getRequestParameter("superId") != null
				&& !super.getRequestParameter("superId").equals("")) {
			superId1 = super.getRequestParameter("superId");
			findSeeValue="";
		}
		if(findSeeValue==null || "".equals(findSeeValue)){
			doQuerys();
		}
		return pageInits;
	}

	public void setPageInits(String pageInits) {
		this.pageInits = pageInits;
	}

	public String getSuperId1() {
		return superId1;
	}

	public void setSuperId1(String superId1) {
		this.superId1 = superId1;
	}

	public String getFindSeeValue() {
		return findSeeValue;
	}

	public void setFindSeeValue(String findSeeValue) {
		this.findSeeValue = findSeeValue;
	}
	
	public List getItemList() {
		return itemList;
	}

	public void setItemList(List itemList) {
		this.itemList = itemList;
	}

	public String findSee(){
		try{
			if(itemList!=null){
				itemList=new ArrayList();
			}
		  List lists = attenceSetUCC.getAllPersonTable(superId,findSeeValue,personType);
			if(lists!=null && lists.size()>0){
				for(int i=0;i<lists.size();i++){
					AttClassGroupVO vo=(AttClassGroupVO)lists.get(i);
					OrgBO a=SysCacheTool.findOrgById(vo.getDeptId());
					vo.setDeptName(a.getName());
					OrgBO b1 = SysCacheTool.findOrgById(vo.getOrgId());
					vo.setOrgName(b1.getName());
					itemList.add(vo);
				}
			}
		}catch(Exception e){
			
		}
		return "";
	}
	
	public String doQuerys(){
		if (itemList != null) {
			itemList = new ArrayList();
		}
		try{
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			List lists=attenceSetUCC.getAttClassGroupVO(mypage,superId1,personType);
			if(lists!=null && lists.size()>0){
				for(int i=0;i<lists.size();i++){
					AttClassGroupVO vo=(AttClassGroupVO)lists.get(i);
					OrgBO a=SysCacheTool.findOrgById(vo.getDeptId());
					vo.setDeptName(a.getName());
					OrgBO b1 = SysCacheTool.findOrgById(vo.getOrgId());
					vo.setOrgName(b1.getName());
					itemList.add(vo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String confirmMethod(){
		try{
		String ids[] = getServletRequest().getParameterValues("selected_ids");
		if(ids!=null){
			super.getHttpSession().removeAttribute("perIdLists");
			List list=new ArrayList();
			for(int i=0;i<ids.length;i++){
				String id=(String)ids[i];
				AttenceLogBO attencelogbo=new AttenceLogBO();
        		attencelogbo.setPersonId(id);
    			attencelogbo.setSubID(SequenceGenerator.getKeyId("A808"));
    			attencelogbo.setRecord(Constants.NO);
    			attencelogbo.setCardDate(begindatevalue);
    			String hms=begintimevalue+":00";
    			attencelogbo.setCardTime(hms);
    			attencelogbo.setRegisterCard(Constants.YES);
    			attenceSetUCC.saveAttenceLogBO(attencelogbo);
			}

		}
        super.showMessageDetail("?????????");
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
}
