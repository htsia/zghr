<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.rpt.service.RptClient"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
    String RptCode = CommonFuns.filterNull(request.getParameter("RptCode"));
    String OrgID= CommonFuns.filterNull(request.getParameter("UnitID"));
    String Command= CommonFuns.filterNull(request.getParameter("Command"));
    String oids= CommonFuns.filterNull(request.getParameter("Oids"));

    if (!"".equals(oids)){
        oids=oids.replaceAll("\\^","'^'");
        oids="'"+oids+"'";
    }
    // 向报表生成服务请求服务
    //--------------产生报表---------------------
     String ID="";
     String Parameter=CommonFuns.filterNull(request.getParameter("Parameter"));
     String strPath=application.getRealPath("/");
     User user = (User) session.getAttribute(Constants.USER_INFO);
     RptClient rc=(RptClient) SysContext.getBean("rpt_infoClient");
     rc.setID(ID);
     rc.setParameter(Parameter);
     rc.setUserInfo(user);
     rc.setPath(strPath);
     rc.setRptCode(RptCode);
     rc.setOrguid(OrgID);
     rc.setCommand(Command);
     rc.setOids(oids);
     String Result=rc.GenerateReport();

    // 返回统计结果
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<ReportResult>");
    out.println("<info>");
    out.println(Result);
    out.println("</info>");
    out.println("</ReportResult>");
%>