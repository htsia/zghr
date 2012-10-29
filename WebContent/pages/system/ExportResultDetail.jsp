<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.ucc.IRemindSetUCC" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.util.RunExcelExport" %>
<%@ page import="javax.faces.context.FacesContext" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<link rel="stylesheet" type="text/css" 	href="<%=request.getContextPath()%>/css/style.css" />
<style>
	.td_middle_y1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #333333;
	background-color: #F3F3F3;
	padding: 2px;
	border-right: 1px #DDDDDD solid;
	border-bottom: 1px #DDDDDD solid;
	height: 29px;
}
.td_middle_y2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #333333;
	background-color: #FFFFFF;
	padding: 2px;
	border-right: 1px #DDDDDD solid;
	border-bottom: 1px #DDDDDD solid;
	height: 30px;
}
</style>
<script language="javascript"	src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript"	src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script language="javascript"	src="<%=request.getContextPath()%>/js/AppClient.js"></script>
<script type="text/javascript">
	 function clearws() {
		    document.getElementById("checkSubmitFlg").value="0";
     }
     function clearStatew() {
            setInterval("clearws()",2000);
     }
</script>

<%
    User userbo = (User) session.getAttribute(Constants.USER_INFO);
    String remindid = CommonFuns.filterNull((String) session.getAttribute("sys_remindid_id"));
    String reminmsg = CommonFuns.filterNull((String) session.getAttribute("sys_remindid_msg"));

    IRemindSetUCC remindsetucc = (IRemindSetUCC) SysContext.getBean("sys_RemindSetUCC");
    if (remindid != null && !"".equalsIgnoreCase(remindid)) {
        try {
            List list1 = remindsetucc.queryRemindResultByUser(userbo, remindid, null);
            if (list1 != null && list1.size() > 0) {
                String path = ((ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext()).getRealPath("/");
                String file = RunExcelExport.ListExport("remind," + reminmsg, list1, "ÌáÐÑ½á¹û.xls", path);
                RunExcelExport.showExportWindow(file);
            }
        } catch (Exception e) {
        }
    }
%>






























































































