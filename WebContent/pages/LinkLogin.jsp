<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.hr319wg.sys.ucc.IPortalFunUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.pojo.bo.UserPortalBO" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.user.service.UserManageService" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>

<%
    try{
        String UserID = request.getParameter("USERID");
        String PortalID = request.getParameter("PORTALID");
        IPortalFunUCC portucc = (IPortalFunUCC) SysContext.getBean("sys_portalUCC");
        UserPortalBO up = portucc.getUserPortalBOByLink(PortalID, UserID);
        if (up == null) {
            out.println(UserID+"û�ж�Ӧ�û�������Ȩ��ʹ��" + Constants.SYSTEM_NAME);
        } else {
            UserManageService usservice = (UserManageService) SysContext.getBean("user_userManageService");
            User user = usservice.findUserById(up.getUserID());
            if (user == null) {
                out.println("����Ȩ��ʹ��" + Constants.SYSTEM_NAME);
            }
            else{
                session.setAttribute("loginName", user.getLoginName());
                response.sendRedirect("/Logininterface.jsf");
            }
        }
    }
    catch(Exception e){
       out.println("�л�HRʧ��,"+e.getMessage());        
    }
%>