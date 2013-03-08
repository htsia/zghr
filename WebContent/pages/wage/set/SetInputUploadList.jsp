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
    String []dealItem = (String[]) session.getAttribute("field");
    List<Map> list = (List) session.getAttribute("fileValue");
%>

<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1">
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="2" width="95%" align="center">
        <h:outputText value="��н��λ:#{wage_setInputBB.unitName}"/>
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="���浽���ݿ�" onclick="return confirm('ȷ�ϱ��棿');" action="#{wage_setInputBB.saveFile}"/>
            <h:commandButton styleClass="button01" value="��������" type="button" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="1" align="center" width="95%" >
        <h:outputLink target="_blank" rendered="#{wage_setInputBB.showError}" style="color:red" value="#{wage_setInputBB.errorFileUrl}">
            <h:outputText value="�����ļ��з��������ݴ�����鿴���ٱ��棡"/>
        </h:outputLink>
    </h:panelGrid>

    <c:verbatim>
        <%
            if (list != null && list.size() > 0) {
                int col = dealItem.length;
                out.println("<table align=\"center\" width=\"90%\"><tr><td>����"+list.size()+"����¼</td></tr></table>");
        %>
        <table width="95%" border="0" align="center" class="table03" id="dataList">
            <tr align="center" class="td_top">
                <td height="27" colspan="<%=col+3%>" class="td_top">�鿴�����ļ�����</td>
            </tr>
            <tr >
                <td class="td_top">Ա�����</td>
                <td class="td_top">Ա������</td>
                <td class="td_top">���ڲ���</td>
                <%
                    for (int c = 0; c < col; c++) {
                %>
                <td class="td_top"><%=CodeUtil.interpertCode("INFOITEM", dealItem[c])%></td>
                <%
                    }
                %>
            </tr>
            <%
                for(Map m : list) {
                    PersonBO p = SysCacheTool.findPersonById(m.get("id").toString());
            %>
            <tr>
                <td class="td_middle"><%=p.getPersonCode()%></td>
                <td class="td_middle"><%=p.getName()%></td>
                <td class="td_middle"><%=CommonFuns.filterNull(CodeUtil.interpertCode("OU",p.getDeptId()))%></td>
                <%
                    for (int c = 0; c < col; c++) {
                %>
                <td class="td_middle"><%=m.get(dealItem[c])%></td>
                <%
                    }
                %>
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
