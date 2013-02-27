<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="java.util.Map"%>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    List<Map> list = (List) session.getAttribute("inputValue");
%>
   
<x:saveState value="#{attOvertimeApplyBB}"/>
<h:form id="form1">
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="2" width="95%" align="center">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" onclick="return confirm('确认保存？');" action="#{attOvertimeApplyBB.saveFile}"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="1" align="center" width="95%" >
        <h:outputLink  target="_blank" rendered="#{attOvertimeApplyBB.showError}" style="color:red" value="#{attOvertimeApplyBB.errorFileUrl}">
            <h:outputText value="导入文件中发现有数据错误，请查看后再保存！"/>
        </h:outputLink>
    </h:panelGrid>

    <c:verbatim>
        <%
            if (list != null && list.size() > 0) {
                out.println("<table align=\"center\" width=\"90%\"><tr><td>共有"+list.size()+"条记录</td></tr></table>");
        %>
        <table width="95%" border="0" align="center" class="table03" id="dataList">
            <tr align="center" class="td_top">
                <td height="27" colspan="5" class="td_top">查看导入文件数据</td>
            </tr>
            <tr >
                <td class="td_top">员工编号</td>
                <td class="td_top">员工姓名</td>
                <td class="td_top">所在机构</td>
                <td class="td_top">开始日期</td>
                <td class="td_top">加班时间/时</td>
            </tr>
            <%
                for(Map m : list){
                	PersonBO p = SysCacheTool.findPersonById(String.valueOf(m.get("id")));
            %>
            <tr>
                <td class="td_middle"><%=p.getPersonCode()%></td>
                <td class="td_middle"><%=p.getName()%></td>
                <td class="td_middle"><%=CommonFuns.filterNull(CodeUtil.interpertCode("OU",p.getOrgId()))%></td>
                <td class="td_middle"><%=m.get("beginDate")%></td>
                <td class="td_middle"><%=m.get("appDays")%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            }
        %>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("dataList");
</script>
