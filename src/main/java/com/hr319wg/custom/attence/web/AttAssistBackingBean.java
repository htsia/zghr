package com.hr319wg.custom.attence.web;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.user.ucc.IUserManageUCC;
import com.oa319wg.user.pojo.vo.OAUser;
import com.oa319wg.user.ucc.IOAUserManageUCC;
import javax.servlet.http.HttpSession;

public class AttAssistBackingBean  extends BaseBackingBean{
	  private IUserManageUCC userucc;
	  private IOAUserManageUCC oauserucc;
	  private String loginName;
	  private String cardID;
	  private String password;
	  private String loginMode = "0";	  
	
	public IUserManageUCC getUserucc() {
		return userucc;
	}



	public void setUserucc(IUserManageUCC userucc) {
		this.userucc = userucc;
	}



	public IOAUserManageUCC getOauserucc() {
		return oauserucc;
	}



	public void setOauserucc(IOAUserManageUCC oauserucc) {
		this.oauserucc = oauserucc;
	}



	public String getLoginName() {
		return loginName;
	}



	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}



	public String getCardID() {
		return cardID;
	}



	public void setCardID(String cardID) {
		this.cardID = cardID;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getLoginMode() {
		return loginMode;
	}



	public void setLoginMode(String loginMode) {
		this.loginMode = loginMode;
	}



	public String login() {
	    try {
	      HttpSession session = getHttpSession();
	        OAUser user = this.oauserucc.verifyLogon(this.loginName, this.password, getHttpSession(), super.getServletRequest());

	        session.setAttribute("OA_USER_INFO", user);
	        
	        return "attassist";	      

	    } catch (SysException e) {
	      super.showMessageDetail("登录失败，请查询用户名和密码！");
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    return "";
	  }

	
}
