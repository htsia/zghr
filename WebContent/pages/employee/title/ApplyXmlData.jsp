<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="javax.servlet.jsp.JspWriter"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="java.util.zip.DeflaterOutputStream"%>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.title.pojo.vo.ApplyReportXMLVO" %>
<%@ page import="com.hr319wg.title.ucc.impl.EmpTitleApplyUcc" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.lang.*, java.io.*, java.sql.*, java.util.*"%>

<%
	EmpTitleApplyUcc applyUcc=(EmpTitleApplyUcc)SysContext.getBean("empTitleApplayUcc");
	String itemId=request.getParameter("itemId");
	String applyId=request.getParameter("applyId");
    StringBuffer xml = new StringBuffer("<xml>\n");
    System.out.println(itemId+"-------"+applyId);
    List list=null;
    if(itemId!=null&&!itemId.equals("")&&!itemId.equals("null")){
    	list=applyUcc.getAllApplyReportXMLVOByItemIds(itemId,null);
    }else if(applyId!=null&&!applyId.equals("")){
    	list=applyUcc.getAllApplyReportXMLVOByItemIds(null,applyId);
    }
    if(list!=null&&list.size()>0){
    	for(int i=0;i<list.size();i++){
    		xml.append("<row");
    		ApplyReportXMLVO vo=(ApplyReportXMLVO)list.get(i);
    		xml.append(" orgName=\""+CommonFuns.filterNull(vo.getOrgName())+"\"");
    		xml.append(" personName=\""+CommonFuns.filterNull(vo.getPersonName())+"\"");
    		xml.append(" sex=\""+CommonFuns.filterNull(vo.getSex())+"\"");
    		xml.append(" nation=\""+CommonFuns.filterNull(vo.getNation())+"\"");
    		xml.append(" birthday=\""+CommonFuns.filterNull(vo.getBirthday())+"\"");
    		xml.append(" workTime=\""+CommonFuns.filterNull(vo.getWorkTime())+"\"");
    		xml.append(" nowWork=\""+CommonFuns.filterNull(vo.getNowWork())+"\"");
    		xml.append(" nowTitle=\""+CommonFuns.filterNull(vo.getNowTitle())+"\"");
    		xml.append(" healthCondition=\""+CommonFuns.filterNull(vo.getHealthConditon())+"\"");
    		xml.append(" nowTime=\""+CommonFuns.filterNull(vo.getNowTime())+"\"");
    		xml.append(" fetchTime=\""+CommonFuns.filterNull(vo.getFetchTime())+"\"");
    		xml.append(" photo=\""+CommonFuns.filterNull(vo.getPhoto())+"\"");
    		xml.append(" applyTitle=\""+CommonFuns.filterNull(vo.getApplyTitle())+"\"");
    		xml.append(" evaCondition=\""+CommonFuns.filterNull(vo.getEvaCondition())+"\"");
    		xml.append(" gradute=\""+CommonFuns.filterNull(vo.getGradute())+"\"");
    		xml.append(" major=\""+CommonFuns.filterNull(vo.getMajor())+"\"");
    		xml.append(" educateRecord=\""+CommonFuns.filterNull(vo.getEducateRecord())+"\"");
    		xml.append(" educateRule=\""+CommonFuns.filterNull(vo.getEducateRule())+"\"");
    		xml.append(" degree=\""+CommonFuns.filterNull(vo.getDegree())+"\"");
    		xml.append(" titleYear=\""+CommonFuns.filterNull(vo.getTitleYear())+"\"");
    		xml.append(" language=\""+CommonFuns.filterNull(vo.getLanguage())+"\"");
    		xml.append(" computer=\""+CommonFuns.filterNull(vo.getComputer())+"\"");
    		xml.append(" titleLive=\""+CommonFuns.filterNull(vo.getTitleLive())+"\"");
    		xml.append(" achievement=\""+CommonFuns.filterNull(vo.getAchievement())+"\"");
    		xml.append(" discourse=\""+CommonFuns.filterNull(vo.getDiscourse())+"\"");
    		xml.append(" />\n");
    	}
    }
    xml.append("</xml>\n");
    PrintWriter pw = response.getWriter();
    pw.print(xml.toString());
%>