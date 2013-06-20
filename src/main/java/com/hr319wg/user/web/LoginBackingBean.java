package com.hr319wg.user.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hr319wg.common.Constants;
import com.hr319wg.common.Modules;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaTempMasterBO;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.recruit.ucc.IOutterRecruitUCC;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.bo.AgentBO;
import com.hr319wg.user.ucc.IUserManageUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.oa319wg.user.ucc.IOAUserManageUCC;

public class LoginBackingBean extends BaseBackingBean {
	private IEvaObjectsUCC objectUCC;
	private IUserManageUCC userucc;
	private IOAUserManageUCC oauserucc;
	private IOutterRecruitUCC outterucc;
	private String loginName;
	private String cardID;
	private String password;
	private String repassword;
	private String loginButton;
	private List roleList = null;
	private boolean haveMultiRole = false;
	private String curRole;
	private List evaTempMasterBOList;
	private EvaTempMasterBO evaTempMasterBO = null;
	private boolean isExist = false;
	private String initPage;
	private String newPassword;
	private String confirmPassword;
	private String loginMode = "0";
	private boolean showDownLoad;
	private boolean showSelf;
	private boolean showShortMessage;
	private boolean showForum;
	private boolean showAdvice;
	private boolean showAnswer;
	private boolean showHelp;

	public String getCardID() {
		return this.cardID;
	}

	public void setCardID(String cardID) {
		this.cardID = cardID;
	}

	public String getLoginMode() {
		return this.loginMode;
	}

	public void setLoginMode(String loginMode) {
		this.loginMode = loginMode;
	}

	public String getNewPassword() {
		return this.newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getConfirmPassword() {
		return this.confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public boolean isShowSelf() {
		this.showSelf = "1".equals(Constants.OFFICE_BUTTON_SELF);
		return this.showSelf;
	}

	public void setShowSelf(boolean showSelf) {
		this.showSelf = showSelf;
	}

	public boolean isShowShortMessage() {
		this.showShortMessage = "1".equals(Constants.OFFICE_BUTTON_SHORTMESSAGE);
		return this.showShortMessage;
	}

	public void setShowShortMessage(boolean showShortMessage) {
		this.showShortMessage = showShortMessage;
	}

	public boolean isShowForum() {
		this.showForum = "1".equals(Constants.OFFICE_BUTTON_FORUM);
		return this.showForum;
	}

	public void setShowForum(boolean showForum) {
		this.showForum = showForum;
	}

	public boolean isShowAdvice() {
		this.showAdvice = "1".equals(Constants.OFFICE_BUTTON_ADVICE);
		return this.showAdvice;
	}

	public void setShowAdvice(boolean showAdvice) {
		this.showAdvice = showAdvice;
	}

	public boolean isShowAnswer() {
		this.showAnswer = "1".equals(Constants.OFFICE_BUTTON_ANSWER);
		return this.showAnswer;
	}

	public void setShowAnswer(boolean showAnswer) {
		this.showAnswer = showAnswer;
	}

	public boolean isShowHelp() {
		this.showHelp = "1".equals(Constants.OFFICE_BUTTON_HELP);
		return this.showHelp;
	}

	public void setShowHelp(boolean showHelp) {
		this.showHelp = showHelp;
	}

	public boolean isShowDownLoad() {
		this.showDownLoad = "1".equals(Constants.OFFICE_BUTTON_DOWNLOAD);
		return this.showDownLoad;
	}

	public void setShowDownLoad(boolean showDownLoad) {
		this.showDownLoad = showDownLoad;
	}

	public boolean getIsExist() {
		return this.isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}

	public String getInitPage() {
		if (this.evaTempMasterBO == null) {
			this.isExist = false;
		}
		return this.initPage;
	}

	public void setInitPage(String initPage) {
		this.initPage = initPage;
	}

	public String getRepassword() {
		return this.repassword;
	}

	public void setRepassword(String repassword) {
		this.repassword = repassword;
	}

	public EvaTempMasterBO getEvaTempMasterBO() {
		return this.evaTempMasterBO;
	}

	public void setEvaTempMasterBO(EvaTempMasterBO evaTempMasterBO) {
		this.evaTempMasterBO = evaTempMasterBO;
	}

	public List getEvaTempMasterBOList() {
		return this.evaTempMasterBOList;
	}

	public void setEvaTempMasterBOList(List evaTempMasterBOList) {
		this.evaTempMasterBOList = evaTempMasterBOList;
	}

	public IEvaObjectsUCC getObjectUCC() {
		return this.objectUCC;
	}

	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}

	public String getCurRole() {
		return this.curRole;
	}

	public void setCurRole(String role) {
		this.curRole = role;
	}

	public boolean isHaveMultiRole() {
		try {
			if (this.roleList == null) {
				User u = super.getUserInfo();
				u.setAgentName(u.getName());
				getHttpSession().setAttribute("USER_INFO", u);

				List list = this.userucc.findAllInfo(u.getUserId());
				this.haveMultiRole = false;
				this.roleList = new ArrayList();
				if (list.size() >= 1) {
					for (int i = 0; i < list.size(); i++) {
						User user = (User) list.get(i);
						PersonBO pb = SysCacheTool.findPersonById(user.getUserId());
						SelectItem item = new SelectItem();
						item.setLabel("身份" + String.valueOf(i + 1) + ":" + CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getOrgId()) + CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId()));
						item.setValue(user.getUserId());
						this.roleList.add(item);
					}
				}

				list = this.userucc.getAgentInfo(super.getUserInfo().getUserId());
				if (list.size() > 0) {
					for (int i = 0; i < list.size(); i++) {
						AgentBO user = (AgentBO) list.get(i);
						PersonBO pb = SysCacheTool.findPersonById(user.getAgentID());
						if (pb != null) {
							SelectItem item = new SelectItem();
							item.setLabel("代理" + String.valueOf(i + 1) + ":" + CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getOrgId()) + CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId()) + "[" + pb.getName() + "]");
							item.setValue("~" + user.getAgentID());
							this.roleList.add(item);
						}
					}
				}
				if (this.roleList.size() > 1) {
					this.haveMultiRole = true;
				}
				getHttpSession().setAttribute("ROLE_INFO", this.roleList);
			}
		} catch (Exception e) {
			this.roleList = new ArrayList();
		}
		return this.haveMultiRole;
	}

	public void setHaveMultiRole(boolean b) {
		this.haveMultiRole = b;
	}

	public List getRoleList() {
		return this.roleList;
	}

	public void setRoleList(List list) {
		this.roleList = list;
	}

	public String getLoginButton() {
		this.loginButton = Constants.LOGBUTTON_CAPTION;
		return this.loginButton;
	}

	public void setLoginButton(String log) {
		this.loginButton = log;
	}

	public IOAUserManageUCC getOauserucc() {
		return this.oauserucc;
	}

	public void setOauserucc(IOAUserManageUCC oauserucc) {
		this.oauserucc = oauserucc;
	}

	public IUserManageUCC getUserucc() {
		return this.userucc;
	}

	public void setUserucc(IUserManageUCC userucc) {
		this.userucc = userucc;
	}

	public String getLoginName() {
		return this.loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String gotoSelf() {
		if (Modules.MODULE_SELF == 0) {
			super.showMessageDetail(Constants.NO_SELF_MODULE);
			return "";
		}
		if ("1".equals(Constants.USER_DEFINE_MAIN)) {
			return "usdMain";
		}

		String url = Constants.SELF_MAIN;
		try {
			User user = super.getUserInfo();
			UserAPI api = new UserAPI();
			if (user.isUnitLeader()) {
				if (api.checkIsHQUser(user))
					url = Constants.HQMAIN;
				else
					url = Constants.ORG_MAIN;
			} else if (user.isDeptLeader()) {
				url = Constants.DEPT_MAIN;
			}
		} catch (Exception e) {
		}
		return url;
	}

	public String gotoSys() {
		try {
			User user = super.getUserInfo();
			if ((user.getPmsMenus() != null) && (user.getPmsMenus().values().size() > 0) && ((user.isBusinessUser()) || (user.ischo()) || (user.isSysOper()))) {
				return Constants.BUSI_INTERFACE;
			}
			super.showMessageDetail("没有进入业务系统的权限！");
			return "";
		} catch (Exception e) {
		}

		return "";
	}

	public String login2() {
		try {
			HttpSession session = getHttpSession();

			if (!"1".equals(Constants.ENABLE_SINGLE_LOGIN)) {
				super.showMessageDetail("没有开通本功能！");
				return "";
			}
			if (session.getAttribute("loginName") == null) {
				super.showMessageDetail("没有用户信息！");
				return "";
			}
			this.loginName = ((String) session.getAttribute("loginName"));
			User user = this.userucc.verifyLogon(this.loginName, getHttpSession(), super.getServletRequest());

			session.setAttribute("USER_INFO", user);

			if ("1".equals(Constants.USER_DEFINE_MAIN)) {
				return "usdMain";
			}

			if ((!"1".equals(Constants.DIRECT_TO_SELF)) && ((user.isBusinessUser()) || (user.ischo()) || (user.isSysOper())) && (user.getPmsMenus() != null) && (user.getPmsMenus().values().size() > 0)) {
				if (!"".equals(Constants.DIRECT_TO_BUSI_URL)) {
					return Constants.DIRECT_TO_BUSI_URL;
				}

				return Constants.BUSI_INTERFACE;
			}

			UserAPI api = new UserAPI();
			if (user.isUnitLeader()) {
				if (api.checkIsHQUser(user)) {
					return Constants.HQMAIN;
				}
				return Constants.ORG_MAIN;
			}
			if (user.isDeptLeader()) {
				return Constants.DEPT_MAIN;
			}
			return Constants.SELF_MAIN;
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "error";
	}

	public String changeRole() {
		try {
			String oldname = super.getUserInfo().getAgentName();
			User u = this.userucc.findUserById(this.curRole.replaceAll("~", ""));
			this.loginName = u.getLoginName();
			this.password = null;
			String rtn = login();

			User user = super.getUserInfo();
			user.setAgentName(oldname);
			if (this.curRole.startsWith("~")) {
				user.setName(oldname);
			}
			getHttpSession().setAttribute("USER_INFO", user);

			return rtn;
		} catch (Exception e) {
		}
		return "";
	}

	public String resumeLogin() {
		try {
			User user = this.outterucc.verifyLogon(this.loginName, this.password);

			HttpSession session = getHttpSession();
			session.setAttribute("USER_INFO", user);
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return "resumeMain";
	}

	public String portalLogin() {
		HttpSession session = getHttpSession();
		session.setAttribute("portalLogin", "true");
		return login();
	}

	public String login() {
		if(this.password==null || "".equals(this.password) || "".equals(this.password.trim())){
			super.showMessageDetail("登录失败，请查询用户名和密码！");
			return null;
		}
		try {
			HttpSession session = getHttpSession();
			if (this.userucc.checkNextModiPass(this.loginName)) {
				session.setAttribute("USER_LOGINNAME", this.loginName);
				return "modipass";
			}
//			if ("1".equals(Constants.USE_OAMAIN)) {
//				OAUser user = this.oauserucc.verifyLogon(this.loginName, this.password, getHttpSession(), super.getServletRequest());
//
//				session.setAttribute("OA_USER_INFO", user);
//				Hashtable hashMenus = user.getOperMenus();
//				if ((hashMenus != null) && (hashMenus.get(OAOperateBO.OAMODULE_HR) != null)) {
//					User hruser = null;
//					if (("0".equals(this.loginMode)) || (this.loginMode == null)) {
//						hruser = this.userucc.verifyLogon(this.loginName, null, this.password, getHttpSession(), super.getServletRequest());
//					} else {
//						hruser = this.userucc.verifyLogon(null, this.cardID, this.password, getHttpSession(), super.getServletRequest());
//					}
//					session.setAttribute("USER_INFO", hruser);
//				}
//				return "oasys";
//			}

			User user = this.userucc.verifyLogon(this.loginName, null, this.password, getHttpSession(), super.getServletRequest());
//			if ("0".equals(this.loginMode)) {
//				user = this.userucc.verifyLogon(this.loginName, null, this.password, getHttpSession(), super.getServletRequest());
//			} else {
//				user = this.userucc.verifyLogon(null, this.cardID, this.password, getHttpSession(), super.getServletRequest());
//				session.setAttribute("cardLogin", "true");
//			}

			session.setAttribute("USER_INFO", user);

			if ("1".equals(Constants.USER_DEFINE_MAIN)) {
				return "usdMain";
			}

			if (((user.isBusinessUser()) || (user.ischo()) || (user.isSysOper())) && (user.getPmsMenus() != null) && (user.getPmsMenus().values().size() > 0)) {
				return Constants.BUSI_INTERFACE;
			}
			if (Modules.MODULE_SELF == 0) {
				super.showMessageDetail(Constants.NO_SELF_MODULE);
				return "";
			}
			UserAPI api = new UserAPI();
			if (user.isUnitLeader()) {
				if (api.checkIsHQUser(user)) {
					return Constants.HQMAIN;
				}
				return Constants.ORG_MAIN;
			}
			if (user.isDeptLeader()) {
				return Constants.DEPT_MAIN;
			}
			return Constants.SELF_MAIN;
		} catch (SysException e) {
			super.showMessageDetail("登录失败，请查询用户名和密码！");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String clearSession() {
		HttpSession session = super.getHttpSession();
		HttpServletResponse response = (HttpServletResponse) FacesContext.getCurrentInstance().getExternalContext().getResponse();
		session.invalidate();
		try {
			response.sendRedirect("/Login.jsf");
		} catch (Exception e) {
		}
		return "";
	}

	public String registe() {
		User user = new User();
		getHttpSession().setAttribute("USER_INFO", user);
		return "regist";
	}

	public IOutterRecruitUCC getOutterucc() {
		return this.outterucc;
	}

	public void setOutterucc(IOutterRecruitUCC outterucc) {
		this.outterucc = outterucc;
	}

	public String tempMasterLogin() {
		checkTest();
		String name = null;
		String psd = null;
		String us = null;
		if (this.evaTempMasterBO != null) {
			name = this.evaTempMasterBO.getMasterID();
			psd = this.evaTempMasterBO.getPassword();
			us = this.evaTempMasterBO.getIs_use();
		}
		if ((!this.loginName.equals(name)) || (!this.password.equals(psd))) {
			if ("0".equals(us))
				super.showMessageDetail("你输入的初始密码错误，请认真输入！");
			else {
				super.showMessageDetail("输入的用户名或密码错误，请认真输入！");
			}
			return "";
		}
		if ("1".equals(us)) {
			User evauser = evaUserLogin(this.loginName, this.password);

			HttpSession session = getHttpSession();
			session.setAttribute("USER_INFO", evauser);
			session.setAttribute("evaTempMasterBO", this.evaTempMasterBO);
			return "success";
		}
		this.isExist = true;
		return "";
	}

	public String tempMasterSave() {
		checkTest();
		if ((this.password != this.repassword) && (!this.password.equals(this.repassword))) {
			super.showMessageDetail("两次密码不一致！");
			return "";
		}
		if (this.evaTempMasterBO != null) {
			this.evaTempMasterBO.setMasterID(this.loginName);
			this.evaTempMasterBO.setPassword(this.password);
			this.evaTempMasterBO.setIs_use("1");
			try {
				this.objectUCC.updateEvaTempMasterBO(this.evaTempMasterBO);
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		super.showMessageDetail("设置密码成功！");
		this.evaTempMasterBO = null;
		return "registeSuccess";
	}

	public String checkTest() {
		try {
			this.evaTempMasterBOList = this.objectUCC.getfindEvaTempMasterBO(this.loginName);
			if (this.evaTempMasterBOList == null) {
				super.showMessageDetail("用户名错误，请认真输入！");
				return "";
			}
			for (int i = 0; i < this.evaTempMasterBOList.size(); i++)
				this.evaTempMasterBO = ((EvaTempMasterBO) this.evaTempMasterBOList.get(i));
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return " ";
	}

	public User evaUserLogin(String loginName, String password) {
		User user = null;
		try {
			user = this.objectUCC.verifyLogon(loginName, password);

			HttpSession session = getHttpSession();
			session.setAttribute("USER_INFO", user);
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	public String loginUpdatePassword() {
		HttpSession session = getHttpSession();
		String login = CommonFuns.filterNull((String) session.getAttribute("USER_LOGINNAME"));
		if ("".equals(login)) {
			return "login";
		}
		if (!this.newPassword.equals(this.confirmPassword)) {
			showMessageDetail("新密码和确认密码不同！请重新输入！");
			return "";
		}
		try {
			User user = this.userucc.findUserByUserName(login);
			if (user == null) {
				showMessageDetail("输入用户名无效！请重新输入！");
				return "";
			}
			user.setPassword(CommonFuns.md5(this.newPassword));
			user.setModipassFlag("0");
			this.userucc.updateUserInfo(user);
			session.removeAttribute("USER_LOGINNAME");
			this.loginName = login;
			this.password = this.newPassword;
			return login();
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "success";
	}
}