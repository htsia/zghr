<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.web.PageVO" %>
<%@ page import="com.hr319wg.common.exception.SysException" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.ucc.IRemindSetUCC" %>
<%@ page import="com.hr319wg.sys.pojo.bo.RemResultBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
     function openWin(){
        window.open('/pages/system/ExportResultDetail.jsf','newwindow','top=0,left=0,toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,location=no,status=yes');
     }
     function refresh(id,msg,page){
         document.all("remresultdetail:currentPage").value=page;
         document.all("remresultdetail").submit();
     }
</script>
<x:saveState value="#{sys_RemDetailBackingBean}" />
<h:form id="remresultdetail">
    <h:inputHidden id="currentPage" value=""></h:inputHidden>
    <h:panelGrid styleClass="td_title" align="center" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1359", "提醒项目内容列表")%>
			</f:verbatim>
        </h:panelGroup>

        <h:panelGrid align="right">
            <h:commandButton value="关闭" type="button" styleClass="button01" onclick="window.close();"></h:commandButton>
        </h:panelGrid>
    </h:panelGrid>

		<%
            User userbo = (User) session.getAttribute(Constants.USER_INFO);
            if (userbo != null) {
                String remindid = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("remindid"));
                if (remindid == null || remindid == "") {     // 回发
                    remindid = (String) session.getAttribute("sys_remindid_id");
                }
                String reminmsg = "";
                if ("TOMCAT".equals(CommonFuns.getAppType())){
                    reminmsg=CommonFuns.getParaFromURL(request.getQueryString(),"remindmsg");
                }
                else{
                    reminmsg=CommonFuns.filterNull(request.getParameter("remindmsg"));
                }
                if (reminmsg == null || reminmsg == "") {     // 回发
                    reminmsg = (String) session.getAttribute("sys_remindid_msg");
                }
                IRemindSetUCC remindsetucc = (IRemindSetUCC) SysContext.getBean("sys_RemindSetUCC");

                if (remindid != null && !"".equalsIgnoreCase(remindid)) {
                    PageVO vo = new PageVO();
                    String cPage = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("remresultdetail:currentPage"));
                    String pre = "1";
                    String next = "";
                    if (cPage == null || "".equals(cPage))
                        cPage = "1";
                    if (Integer.parseInt(cPage) > 1) {
                        int ipre = Integer.parseInt(cPage) - 1;
                        pre = String.valueOf(ipre);
                    }

                    vo.setCurrentPage(Integer.parseInt(cPage));
                    if (vo.getCurrentPage() < 1)
                        vo.setCurrentPage(1);
                    try {
                        List list = remindsetucc.queryRemindResultByUser(userbo, remindid, vo);
                        if (Integer.parseInt(cPage) < vo.getTotalPage()) {
                            int inext = Integer.parseInt(cPage) + 1;
                            next = String.valueOf(inext);
                        } else {
                            next = cPage;
                        }

                        session.setAttribute("sys_remindid_id", remindid);
                        session.setAttribute("sys_remindid_msg", reminmsg);
                        if (list != null && list.size() > 0) {
                            int len = list.size();
                            out.println("<table border='0'  width='95%' class='table' align='center'>");
                            out.println("<tr>");
                            out.println("<td class='td_sec2' align='left'>");
                            out.println(reminmsg);
                            out.println("</td>");
                            out.println("</tr>");

                            out.println("<tr>");
                            out.println("<td class='td_sec2' align='left'>");
                            out.println(LanguageSupport.getResource("COMM-1049", "总页数:") + vo.getTotalPage());
                            out.println("&nbsp;&nbsp;");
                            out.println(LanguageSupport.getResource("COMM-1043", "记录数:")  + vo.getTotalRecord());
                            out.println("&nbsp;&nbsp;");
                            out.println(LanguageSupport.getResource("COMM-1046", "当前页:")+ vo.getCurrentPage());
                            out.println("&nbsp;&nbsp;");
                            String shouye = LanguageSupport.getResource("BUTTON-006", "首页");
                            String shangye = LanguageSupport.getResource("BUTTON-007", "上页");
                            String xiaye = LanguageSupport.getResource("BUTTON-008", "下页");
                            String weiye = LanguageSupport.getResource("BUTTON-009", "尾页");
                            String daochu = LanguageSupport.getResource("YXGL-1054", "导出Excel");
                            out.println("<input name=first type=button class=button01 value='"+shouye+ "'  onclick=\"refresh('" + remindid + "','" + reminmsg + "','1')\">");
                            out.println("<input name=pre type=button class=button01   value='"+shangye+"'  onclick=\"refresh('" + remindid + "','" + reminmsg + "','" + pre + "')\">");
                            out.println("<input name=next type=button class=button01  value='"+xiaye+"'    onclick=\"refresh('" + remindid + "','" + reminmsg + "','" + next + "')\">");
                            out.println("<input name=last type=button class=button01  value='"+weiye+"'    onclick=\"refresh('" + remindid + "','" + reminmsg + "','" + vo.getTotalPage() + "')\">");
                            out.println("<input name=del type=button class=button01   value='"+daochu+"'   onclick='openWin()'>");
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("</table>");

                            out.println("<table border='1'  width='95%' class='table' align='center'>");
                            for (int i = 0; i < len; i++) {
                                RemResultBO tempbo = (RemResultBO) list.get(i);
                                tempbo.setRemRslt(tempbo.getRemRslt().replace('|', ','));
                                String[] strRslt = tempbo.getRemRslt().split(",");
                                if (i % 2 == 0)
                                    out.println("<tr>");
                                else
                                    out.println("<tr>");

                                for (int j = 0; j < strRslt.length; j++) {
                                    out.println("<td class='td_sec2'>");
                                    out.println(strRslt[j]);
                                    out.println("</td >");
                                }
                                out.println("</tr>");
                            }
                            out.println("</table>");
                        }
                    } catch (SysException e) {
                    }
                }
            }
        %>
</h:form>































































































