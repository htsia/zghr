package com.hr319wg.emp.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.college.ucc.ICollegeUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonAddAuditBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.pojo.vo.PersonChangeVO;
import com.hr319wg.emp.pojo.vo.PersonVO;
import com.hr319wg.emp.ucc.IEmpAuditAddUCC;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.pojo.bo.OrgEnterBO;
import com.hr319wg.org.pojo.bo.OrgProbationBO;
import com.hr319wg.org.ucc.IOrgProbationUcc;
import com.hr319wg.org.util.OrgTool;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.dao.CodeItemDAO;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.WFDefineExcludeBO;
import com.hr319wg.sys.pojo.bo.WFTypeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.WorkFlowService;
import com.hr319wg.sys.ucc.ISysInProcessUCC;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.user.ucc.IUserManageUCC;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;
import com.hr319wg.util.ListMap;
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.ucc.IWageAdjustUCC;
import com.hr319wg.wage.ucc.IWageSetPersonUCC;

public class PersonAddBackingBean extends BaseBackingBean
{
  private IUserManageUCC usermanageucc;
  private ICollegeUCC collegeucc;
  private PersonVO personvo = new PersonVO();
  private PersonChangeVO personchangevo = new PersonChangeVO();
  private IPersonUCC personucc;
  private ISysInProcessUCC linkucc;
  private IWageSetPersonUCC wagesetpersonucc;
  private WageAPI wageapi;
  private WorkFlowService wfservice;
  private IEmpAuditAddUCC auditucc;
  private String type = "";
  private String education = "";
  private String graduate = "";
  private String year = "";
  private String college = "";
  private String degree = "";
  private String degreeTime = "";
  private String returnType = "";
  private String returnTime = "";
  private String classId;
  private String enterTime = "";
  private String returnDep = "";
  private String returnDuty = "";
  private String returnDutyLevel = "";
  private String photoFile = null;
  private String idFile = null;
  private CodeItemDAO codeItemDAO;
  private List<SelectItem> currStatusList;
  private IWageAdjustUCC adjustucc;
  private IOrgProbationUcc orgprobationucc;
  
  public IWageAdjustUCC getAdjustucc() {
	return adjustucc;
}
public void setAdjustucc(IWageAdjustUCC adjustucc) {
	this.adjustucc = adjustucc;
}
public IOrgProbationUcc getOrgprobationucc() {
	return orgprobationucc;
}
public void setOrgprobationucc(IOrgProbationUcc orgprobationucc) {
	this.orgprobationucc = orgprobationucc;
}
public CodeItemDAO getCodeItemDAO() {
	return codeItemDAO;
}
public void setCodeItemDAO(CodeItemDAO codeItemDAO) {
	this.codeItemDAO = codeItemDAO;
}
public List<SelectItem> getCurrStatusList() {
	return currStatusList;
}
public void setCurrStatusList(List<SelectItem> currStatusList) {
	this.currStatusList = currStatusList;
}

public String getClassId()
  {
    return this.classId;
  }
  public void setClassId(String classId) {
    this.classId = classId;
  }

  public String getEnterTime()
  {
    return this.enterTime;
  }

  public void setEnterTime(String enterTime) {
    this.enterTime = enterTime;
  }

  public String getReturnDep()
  {
    return this.returnDep;
  }

  public void setReturnDep(String returnDep) {
    this.returnDep = returnDep;
  }

  public String getReturnDutyLevel() {
    return this.returnDutyLevel;
  }

  public void setReturnDutyLevel(String returnDutyLevel) {
    this.returnDutyLevel = returnDutyLevel;
  }

  public IUserManageUCC getUsermanageucc()
  {
    return this.usermanageucc;
  }
  public void setUsermanageucc(IUserManageUCC usermanageucc) {
    this.usermanageucc = usermanageucc;
  }

  public IWageSetPersonUCC getWagesetpersonucc() {
    return this.wagesetpersonucc;
  }
  public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
    this.wagesetpersonucc = wagesetpersonucc;
  }

  public WageAPI getWageapi()
  {
    return this.wageapi;
  }
  public void setWageapi(WageAPI api) {
    this.wageapi = api;
  }

  public void setType(String str) {
    this.type = str;
  }
  public String getType() {
	if(this.currStatusList==null){
		this.currStatusList = new ArrayList();
		List<CodeItemBO> itemList;
		try {
			itemList = this.codeItemDAO.queryAllCodeItemForTree("0145");
			if(itemList!=null){
				for(CodeItemBO bo: itemList){
					if("1".equals(bo.getItemStatus())){
						SelectItem item = new SelectItem(bo.getItemId(), bo.getItemName());
						this.currStatusList.add(item);
					}
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
    if (super.getRequestParameter("type") != null) {
      this.type = super.getRequestParameter("type");
      if ((this.personvo.getUnitTime() == null) || ("".equals(this.personvo.getUnitTime()))) {
        InfoItemBO unitTime = SysCacheTool.findInfoItem("A001", "A001044");
        if ("15".equals(unitTime.getItemDataType())) {
          this.personvo.setUnitTime(CommonFuns.getSysDate("yyyy-MM"));
        }
        else {
          this.personvo.setUnitTime(CommonFuns.getSysDate("yyyy-MM-dd"));
        }
      }
      if ((this.personvo.getSysTime() == null) || ("".equals(this.personvo.getSysTime()))) {
        InfoItemBO unitTime = SysCacheTool.findInfoItem("A001", "A001781");
        if ("15".equals(unitTime.getItemDataType())) {
          this.personvo.setSysTime(CommonFuns.getSysDate("yyyy-MM"));
        }
        else {
          this.personvo.setSysTime(CommonFuns.getSysDate("yyyy-MM-dd"));
        }
      }
      if ((this.personchangevo.getChangeDate() == null) || ("".equals(this.personchangevo.getChangeDate()))) {
        InfoItemBO unitTime = SysCacheTool.findInfoItem("A016", "A016020");
        if ("15".equals(unitTime.getItemDataType())) {
          this.personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM"));
        }
        else {
          this.personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
        }
      }
      if (super.getRequestParameter("A001031") != null) {
        this.personvo.setPersonIdentity(super.getRequestParameter("A001031"));
      }
    }
    return this.type;
  }

  public String getPageInit() {
    if (super.getRequestParameter("A016010") != null) {
      this.personchangevo.setChangeType(super.getRequestParameter("A016010"));
      InfoItemBO ib = SysCacheTool.findInfoItem("", "A016020");
      if ((ib != null) && ("5".equals(ib.getItemDataType()))) {
        this.personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      }
      else {
        this.personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM"));
      }
    }
    if (super.getRequestParameter("A001031") != null) {
      this.personvo.setPersonIdentity(super.getRequestParameter("A001031"));
    }
    return this.pageInit;
  }

  public String getEducation() {
    return this.education;
  }
  public void setEducation(String str) {
    this.education = str;
  }

  public String getGraduate() {
    return this.graduate;
  }
  public void setGraduate(String str) {
    this.graduate = str;
  }

  public String getDegree() {
    return this.degree;
  }
  public void setDegree(String str) {
    this.degree = str;
  }

  public String getCollege() {
    return this.college;
  }
  public void setCollege(String str) {
    this.college = str;
  }

  public String getYear() {
    return this.year;
  }
  public void setYear(String str) {
    this.year = str;
  }

  public String getDegreeTime() {
    return this.degreeTime;
  }
  public void setDegreeTime(String str) {
    this.degreeTime = str;
  }

  public String getReturnTime() {
    return this.returnTime;
  }
  public void setReturnTime(String str) {
    this.returnTime = str;
  }

  public String getReturnType() {
    return this.returnType;
  }
  public void setReturnType(String str) {
    this.returnType = str;
  }

  public String getReturnDuty() {
    return this.returnDuty;
  }
  public void setReturnDuty(String str) {
    this.returnDuty = str;
  }

  public PersonVO getPersonvo() {
    return this.personvo;
  }
  public void setPersonvo(PersonVO personvo) {
    this.personvo = personvo;
  }

  public PersonChangeVO getPersonchangevo() {
    return this.personchangevo;
  }
  public void setPersonchangevo(PersonChangeVO personchangevo) {
    this.personchangevo = personchangevo;
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC personucc) {
    this.personucc = personucc;
  }

  public ISysInProcessUCC getLinkucc() {
    return this.linkucc;
  }
  public void setLinkucc(ISysInProcessUCC ucc) {
    this.linkucc = ucc;
  }

  public WorkFlowService getWfservice() {
    return this.wfservice;
  }
  public void setWfservice(WorkFlowService wfservice) {
    this.wfservice = wfservice;
  }
  public String createPersonXS() {
    try {
      User user = getUserInfo();
      byte[] photo = (byte[])(byte[])getHttpSession().getAttribute("A001780");

      OrgBO classbo = SysCacheTool.findOrgById(this.classId);
      OrgBO deptbo = SysCacheTool.findOrgById(classbo.getSuperId());
      this.personvo.setDeptId(deptbo.getOrgId());
      OrgBO org = OrgTool.getOrgByDept(CommonFuns.filterNull(this.personvo.getDeptId()));
      if (org == null) {
        showMessageDetail("所增人员的所在机构无法找到，不能增加此人!");
        return null;
      }
      String personId = this.personucc.createPerson(this.personvo, null, user, photo);
      getServletRequest().setAttribute("P_PERSONID", personId);
      getServletRequest().setAttribute("P_FLAG", "show");
      getHttpSession().removeAttribute("images");

      String[] ColList = { "A080722", "A080721", "A080725", "A080720", "A080710" };
      String[] ValueList = { CommonFuns.filterNull(this.personvo.getHomeArea()), CommonFuns.filterNull(this.personvo.getHomeAddress()), CommonFuns.filterNull(this.personvo.getWorkCompany()), CommonFuns.filterNull(this.personvo.getHomeTel()), CommonFuns.filterNull(this.personvo.getMobile()) };

      this.personucc.updatePageInfo("A080", user, personId, "", false, "", "", ColList, ValueList);

      ColList = new String[] { "A001706" };
      ValueList = new String[] { CommonFuns.filterNull(this.classId) };

      this.personucc.updatePageInfo("A001", user, personId, "", false, "", "", ColList, ValueList);

      ColList = new String[] { "A090701" };
      ValueList = new String[] { CommonFuns.filterNull(this.personvo.getResidence()) };

      this.personucc.updatePageInfo("A090", user, personId, "", false, "", "", ColList, ValueList);
      this.collegeucc.countStudent(this.classId);
      return "edit";
    }
    catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute("images");
      showMessageDetail("增加失败:" + e.getMessage());
      super.getServletRequest().setAttribute("type", this.type);
    }
    return null;
  }
  public String createPersonJZ() {
    try {
      User user = getUserInfo();
      byte[] photo = (byte[])(byte[])getHttpSession().getAttribute("A001780");
      OrgBO org = OrgTool.getOrgByDept(CommonFuns.filterNull(this.personvo.getDeptId()));
      if (org == null) {
        showMessageDetail("所增人员的所在机构无法找到，不能增加此人!");
        return null;
      }
      String personId = this.personucc.createPerson(this.personvo, null, user, photo);
      getServletRequest().setAttribute("P_PERSONID", personId);
      getServletRequest().setAttribute("P_FLAG", "show");
      getHttpSession().removeAttribute("images");

      String[] ColList = { "A080722", "A080721", "A080740", "A080720", "A080710" };
      String[] ValueList = { CommonFuns.filterNull(this.personvo.getHomeArea()), CommonFuns.filterNull(this.personvo.getHomeAddress()), CommonFuns.filterNull(this.personvo.getWorkCompany()), CommonFuns.filterNull(this.personvo.getHomeTel()), CommonFuns.filterNull(this.personvo.getMobile()) };

      this.personucc.updatePageInfo("A080", user, personId, "", false, "", "", ColList, ValueList);

      ColList = new String[] { "A090701" };
      ValueList = new String[] { CommonFuns.filterNull(this.personvo.getResidence()) };

      this.personucc.updatePageInfo("A090", user, personId, "", false, "", "", ColList, ValueList);

      ColList = new String[] { "A076715", "A076720", "A076735", "A076705", "A076710" };
      ValueList = new String[] { CommonFuns.filterNull(getReturnDep()), CommonFuns.filterNull(getReturnDuty()), CommonFuns.filterNull(getReturnDutyLevel()), CommonFuns.filterNull(getEnterTime()), CommonFuns.filterNull(getReturnTime()) };

      this.personucc.updatePageInfo("A076", user, personId, "", false, "", "", ColList, ValueList);
      showMessageDetail("增加人员成功!");

      return "edit";
    }
    catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute("images");
      showMessageDetail("增加失败:" + e.getMessage());
      super.getServletRequest().setAttribute("type", this.type);
    }
    return null;
  }
  
    //增加教职工
	public String createPerson() {
		try {
			User user = getUserInfo();
			byte[] photo = (byte[]) (byte[]) getHttpSession().getAttribute(
					"A001780");
			if ((photo == null) && (this.photoFile != null)
					&& (!"".equals(this.photoFile))) {
				String base = super.getRealPath("/");
				photo = FileUtil.ReadInFile(base + this.photoFile);
			}

			if (this.personchangevo != null) {
				this.personchangevo.setTractPerson(user.getUserId());
			}
			OrgBO org = OrgTool.getOrgByDept(CommonFuns.filterNull(this.personvo.getDeptId()));
			if (org == null) {
				showMessageDetail("所增人员的所在机构无法找到，不能增加此人!");
				return null;
			}
			this.personvo.setPersonCode(this.personucc.getNextPersonCode(user.getOrgId()));
			String personId = this.personucc.createPerson(this.personvo, this.personchangevo, user, photo);
			getServletRequest().setAttribute("P_PERSONID", personId);
			getServletRequest().setAttribute("P_FLAG", "show");
			getHttpSession().removeAttribute("images");
			if ("1".equals(Constants.AUTO_OPEN_USER)) {
				String[] ids = new String[1];
				ids[0] = personId;
				this.usermanageucc.makeStatus(ids, true);
				List li = this.usermanageucc.queryUserRoleInfo(ids[0]);
				if ((li == null) || (li.size() == 0)) {
					this.usermanageucc.assignRole(ids[0],
							RoleInfoBO.EMPLOYEE_ROLE_ID);
				}
				this.usermanageucc.makeCurrentLevelUser(ids, querySysRoleId());
			}

			this.wageapi.addPersonRelation(org.getOrgId(), personId);

			if (("1".equals(Constants.WAGE_POST_LINK))
					&& ("0".equals(Constants.EMP_ADD_AFTER_APPROVE))) {
				String set = this.wageapi.querySetByPersonPost(personId);
				if ((set != null) && (!"".equals(set))) {
					String[] pids = new String[1];
					pids[0] = personId;
					this.wagesetpersonucc.batchAddPerson(set, pids);
					this.wagesetpersonucc.batchAdd(super.getUserInfo()
							.getUserId(), set, pids);
				}

			}

			if (this.type.equals("1")) {
				String[] ColList = { "A004005", "A004030", "A004035", "A004025" };
				String[] ValueList = { CommonFuns.filterNull(getEducation()),
						CommonFuns.filterNull(getGraduate()),
						CommonFuns.filterNull(getCollege()),
						CommonFuns.filterNull(getYear()) };

				this.personucc.addPageInfo("A004", user, "", personId, false,
						ColList, ValueList);

				ColList = new String[] { "A840701", "A840705" };
				ValueList = new String[] { CommonFuns.filterNull(getDegree()),
						CommonFuns.filterNull(getDegreeTime()) };

				this.personucc.addPageInfo("A840", user, "", personId, false,
						ColList, ValueList);
			} else if (this.type.equals("2")) {
				String[] ColList = { "A076701", "A076710", "A076715", "A076720" };
				String[] ValueList = { CommonFuns.filterNull(getReturnType()),
						CommonFuns.filterNull(getReturnTime()),
						CommonFuns.filterNull(getReturnDep()),
						CommonFuns.filterNull(getReturnDuty()) };

				this.personucc.updatePageInfo("A076", user, personId, "",
						false, "", "", ColList, ValueList);
			}

			if ("1".equals(Constants.EMP_ADD_AFTER_APPROVE)) {
				WFTransaction trans = new WFTransaction();
				trans.setUser(super.getUserInfo());
				if ((this.personvo.getPersonIdentity() != null)
						&& (Constants.EMP_CADRESCODE.indexOf(this.personvo
								.getPersonIdentity() + ",") >= 0)) {
					trans.setWfType(WFTypeBO.RYGL_CAR_ENTER);
				} else {
					trans.setWfType(WFTypeBO.RYGL_WORK_ENTER);
				}

				trans.setOperID("0361");
				trans.setLinkID(personId);
				trans.setStatusValue("报批");
				this.wfservice.processTrans(trans);
			} else if ("2".equals(Constants.EMP_ADD_AFTER_APPROVE)) {
				WFDefineExcludeBO excludebo = this.wfservice
						.findWFDefineExcludeBO(WFTypeBO.RYGL_COMMON_IN);
				if ((excludebo == null) || (excludebo.getOrguid() == null)
						|| ("".equals(excludebo.getOrguid()))
						|| (excludebo.getOrguid().indexOf(org.getOrgId()) < 0)) {
					PersonAddAuditBO abo = new PersonAddAuditBO();
					abo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
					abo.setApplyOper(super.getUserInfo().getUserId());
					abo.setPersonID(personId);
					this.auditucc.savePersonAddAuditBO(abo);

					WFTransaction trans = new WFTransaction();
					trans.setUser(super.getUserInfo());
					trans.setLinkID(abo.getItemID());
					trans.setWfType(WFTypeBO.RYGL_COMMON_IN);
					trans.setOperID("0310");
					trans.setStatusValue("0");
					trans.setWffunction("emp_addAuditservice");
					this.wfservice.processTrans(trans);
				}

			}

			OrgEnterBO oo = this.personucc.getOrgEnterBO(user.getOrgId());
			if ((oo != null) && (oo.getWageItems() != null)) {
				String[] pids = new String[1];
				pids[0] = personId;
				String[] items = oo.getWageItems().split(",");
				String itemString = "";
				ListMap listmap = new ListMap();
				for (int j = 0; j < items.length; j++) {
					if (super.getRequestParameter(items[j]) != null) {
						if ("".equals(itemString)) {
							itemString = items[j];
						} else {
							itemString = itemString + "," + items[j];
						}
						listmap.put(personId + "|" + items[j],
								super.getRequestParameter(items[j]));
					}
				}
				if (!"".equals(itemString)) {
					this.wagesetpersonucc.updateBaseInfo(pids,
							itemString.split(","), listmap);
				}
			}
			
			if ((this.idFile != null) && (!"".equals(this.idFile))) {
				String base = super.getRealPath("/");
				String photoFile = base + this.idFile;
				if (FileUtil.fileExists(photoFile)) {
					this.personucc.setPersonIDPhoto(personId, photoFile);
				}
			}

			//增加工资变动记录
			CommonUtil.addWageChange(personId, this.personvo.getStatus());
			importData(personId);
//			api.executeSql("insert into sys_role_user_r (role_person_id ,role_id,person_id) values ((select nvl(max(cast(r.role_id as int)),0)+1 from sys_role_user_r r where len(r.role_person_id)<4),'08','"+personId+"')");
			ActivePageAPI api = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
			String sql = "select A001725 from a001 where id='"+personId+"'";
			String curr=api.queryForString(sql);
			if(!"014511".equals(curr) && !"014512".equals(curr)){
				sql = "delete from emp_probation where person_id='"+personId+"'";
				api.executeSql(sql);
			}
			if("014512".equals(curr)){
				sql = "select normail_type from org_probation where orguid='"+super.getUserInfo().getOrgId()+"'";
				String jianxi = api.queryForString(sql);
				if(jianxi==null || "".equals(jianxi)){
					jianxi = Constants.DEFAULT_PROBATION;
				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	            Calendar cd = new GregorianCalendar();
	            cd.setTime(sdf.parse(this.personvo.getUnitTime()));
	            cd.add(2, Integer.parseInt(jianxi));
	            String planDate =sdf.format(cd.getTime());
				sql = "update emp_probation set status='5',plan_passdate='"+planDate+"' where person_id='"+personId+"'";
				api.executeSql(sql);
			}
			showMessageDetail("增加人员成功!");
			return "edit";
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute("images");
			showMessageDetail("增加失败:" + e.getMessage());
			super.getServletRequest().setAttribute("type", this.type);
		}
		return null;
	}
	
	public void importData(String personID) {
		try {
			WageAdjustBO adjust = this.adjustucc.getWageAdjustBOByLinkID(personID);
			if (adjust == null) {
				PersonBO pb = SysCacheTool.findPersonById(personID);
				adjust = new WageAdjustBO();
				adjust.setPersonID(personID);
				adjust.setOrgID(pb.getOrgId());
				adjust.setStatus(WageAdjustBO.STATUS_APPLY);
				adjust.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
				adjust.setLinkID(personID);
				adjust.setAdjustType("转正");
				this.adjustucc.saveWageAdjustBO(adjust);

				OrgProbationBO opo = this.orgprobationucc.findOrgProbationBOByOrgId(super.getUserInfo().getOrgId());
				if ((opo != null) && (opo.getWageItems() != null)
						&& (!opo.getWageItems().equals("")))
					this.adjustucc.createAdjustDetail(pb.getPersonId(),
							adjust.getItemID(), opo.getWageItems().split(","));
			}
			CommonUtil.setWageAdjust(adjust.getItemID(), personID, null, true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
  private String querySysRoleId() throws SysException {
    List list = this.usermanageucc.queryUserRoleInfo(super.getUserInfo().getUserId());
    RoleInfoBO role = (RoleInfoBO)list.get(0);
    return role.getRoleId();
  }

  public String createManger() {
    try {
      User user = getUserInfo();
      OrgBO org = OrgTool.getOrgByDept(CommonFuns.filterNull(this.personvo.getDeptId()));
      if (org == null) {
        showMessageDetail("所增人员的所在机构无法找到，不能增加此人!");
        return null;
      }
      InfoItemBO ib = SysCacheTool.findInfoItem("", "A001031");
      if (ib != null) this.personvo.setPersonIdentity(ib.getItemDefaultValue());
      String personId = this.personucc.createPerson(this.personvo, null, user, null);
      String[] ids = new String[1];
      ids[0] = personId;
      this.usermanageucc.makeStatus(ids, true);
      List li = this.usermanageucc.queryUserRoleInfo(ids[0]);
      if ((li == null) || (li.size() == 0)) {
        this.usermanageucc.assignRole(ids[0], RoleInfoBO.EMPLOYEE_ROLE_ID);
      }
      this.usermanageucc.makeCurrentLevelUser(ids, querySysRoleId());

      showMessageDetail("增加用户成功!");
      cancelPerson();
      return "success";
    }
    catch (Exception e) {
      e.printStackTrace();
      showMessageDetail("增加失败:" + e.getMessage());
    }
    return null;
  }

  public String getPhotoFile() {
    return this.photoFile;
  }
  public void setPhotoFile(String photoFile) {
    this.photoFile = photoFile;
  }

  public String getIdFile()
  {
    return this.idFile;
  }

  public void setIdFile(String idFile) {
    this.idFile = idFile;
  }

  public String createUser()
  {
    try
    {
      byte[] photo = (byte[])(byte[])getHttpSession().getAttribute("A001780");
      if ((photo == null) && (this.photoFile != null) && (!"".equals(this.photoFile))) {
        String base = super.getRealPath("/");
        photo = FileUtil.ReadInFile(base + this.photoFile);
      }
      User user = getUserInfo();
      if (this.personchangevo != null) {
        this.personchangevo.setTractPerson(user.getUserId());
      }
      OrgBO org = OrgTool.getOrgByDept(CommonFuns.filterNull(this.personvo.getDeptId()));
      if (org == null) {
        showMessageDetail("所增人员的所在机构无法找到，不能增加此人!");
        return null;
      }
      InfoItemBO ib = SysCacheTool.findInfoItem("", "A001031");
      if (ib != null) this.personvo.setPersonIdentity(ib.getItemDefaultValue());
      String personId = this.personucc.createPerson(this.personvo, this.personchangevo, user, photo);
      String[] ids = new String[1];
      ids[0] = personId;
      this.usermanageucc.makeStatus(ids, true);
      List li = this.usermanageucc.queryUserRoleInfo(ids[0]);
      if ((li == null) || (li.size() == 0)) {
        this.usermanageucc.assignRole(ids[0], RoleInfoBO.EMPLOYEE_ROLE_ID);
      }
      this.usermanageucc.makeCurrentLevelUser(ids, querySysRoleId());

      this.wageapi.addPersonRelation(org.getOrgId(), personId);

      if (("1".equals(Constants.WAGE_POST_LINK)) && ("0".equals(Constants.EMP_ADD_AFTER_APPROVE))) {
        String set = this.wageapi.querySetByPersonPost(personId);
        if ((set != null) && (!"".equals(set))) {
          String[] pids = new String[1];
          pids[0] = personId;
          this.wagesetpersonucc.batchAddPerson(set, pids);
          this.wagesetpersonucc.batchAdd(super.getUserInfo().getUserId(), set, pids);
        }
      }
      this.personucc.UpdateA001730(personId, "00900");

      if ((this.idFile != null) && (!"".equals(this.idFile))) {
        String base = super.getRealPath("/");
        String photoFile = base + this.idFile;
        if (FileUtil.fileExists(photoFile)) {
          this.personucc.setPersonIDPhoto(personId, photoFile);
        }
      }
      String[] id = new String[1];
      id[0] = personId;
      SysCache.setMap(id, 2, 6);

      this.photoFile = null;
      this.idFile = null;
      showMessageDetail("增加用户成功!");
      cancelPerson();
      return "success";
    }
    catch (Exception e) {
      e.printStackTrace();
      showMessageDetail("增加失败:" + e.getMessage());
    }
    return null;
  }

  public String cancelPerson() {
    try {
      this.personvo = new PersonVO();
      this.personchangevo = new PersonChangeVO();
      getHttpSession().removeAttribute("A001780");
    } catch (Exception e) {
      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }
    return "";
  }

  public ICollegeUCC getCollegeucc() {
    return this.collegeucc;
  }
  public void setCollegeucc(ICollegeUCC collegeucc) {
    this.collegeucc = collegeucc;
  }

  public IEmpAuditAddUCC getAuditucc() {
    return this.auditucc;
  }
  public void setAuditucc(IEmpAuditAddUCC auditucc) {
    this.auditucc = auditucc;
  }
}