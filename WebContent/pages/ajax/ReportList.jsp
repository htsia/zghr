<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.user.ucc.IUserReportUCC"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.faces.model.SelectItem"%>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
    User user = (User) (session.getAttribute(Constants.USER_INFO));
    // 0 当前表  1 归档表
    String Mode = CommonFuns.filterNull(request.getParameter("Mode"));
    String OperID = CommonFuns.filterNull(request.getParameter("OperID"));
    String UserID = user.getUserId();
    String RptArchiveType = CommonFuns.filterNull(request.getParameter("RptArchiveType"));
    IUserReportUCC rc=(IUserReportUCC) SysContext.getBean("user_userReportUccImpl");
    List li=null;
    if (Mode=="0"){
        li=rc.queryUserRptToWebByArchives(UserID,OperID,RptArchiveType);
    }
    else {

    }
    // 返回统计结果
    String  ResultInfo="";
    String  ResultValue="";
    for(int i=0;i<li.size();i++){
        SelectItem item = (SelectItem)li.get(i);
        ResultValue+=item.getValue()+",";
        ResultInfo+=item.getLabel()+"\r";
    }
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<ReportResult>");
    out.println("<info>");
    out.println(ResultInfo);
    out.println("</info>");
    out.println("<value>");
    out.println(ResultValue);
    out.println("</value>");
    out.println("</ReportResult>");
%>