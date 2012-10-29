<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String []dealItem = (String[]) session.getAttribute("field");
    HashMap hash = (HashMap) session.getAttribute("fileValue");
%>
<html>
<head>
    <base target="_self">
    <title></title>
</head>

<body>

<h:form id="form1">
    <h:inputHidden id="perSelSet" value="#{emp_DataUploadBB.perSelSet}"/>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="1" width="98%" align="center" styleClass="td_title">
       <h:panelGrid columns="1" width="100%" align="right">
            <h:panelGroup>
                <h:outputText value="���ݴ���ʽ"/>
                <h:selectOneMenu value="#{emp_DataUploadBB.mode}">
                    <c:selectItem itemValue="0" itemLabel="����"></c:selectItem>
                    <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
                </h:selectOneMenu>
                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" value="���浽���ݿ�" action="#{emp_DataUploadBB.saveFile}"/>
                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" value="����" action="upload"/>
            </h:panelGroup>
       </h:panelGrid>
    </h:panelGrid>

    <br>

    <h:panelGrid columns="1" align="center" width="95%" >
        <h:outputLink  target="_blank" rendered="#{emp_DataUploadBB.showError}" style="color:red" value="#{emp_DataUploadBB.errorFileUrl}">
            <h:outputText value="�ϴ��ļ������д��󣬵�����ش��������ļ�"/>
        </h:outputLink>
    </h:panelGrid>

    <c:verbatim>
        <%
            if (hash != null && hash.size() > 0) {
                int col = dealItem.length;
        %>
        <table width="95%" border="0" align="center" class="table03">
            <tr align="left" class="td_top">
                <td height="27" colspan="<%=col+2%>" class="td_top">�����ļ���������:</td>
            </tr>
            <tr >
                <td class="td_top">Ա�����</td>
                <td class="td_top">Ա������</td>
                <%
                    for (int c = 0; c < col; c++) {
                %>
                <td class="td_top"><%=CodeUtil.interpertCode("INFOITEM", dealItem[c])%></td>
                <%
                    }
                %>
            </tr>
            <%
                Iterator iterator = hash.values().iterator();
                Iterator key = hash.keySet().iterator();

                while (iterator.hasNext() && key.hasNext()) {
                    PersonBO p = SysCacheTool.findPersonById((String) key.next());
            %>
            <tr>
                <td class="td_middle"><%=p.getPersonCode()%></td>
                <td class="td_middle"><%=p.getName()%></td>
                <%
                    String[] data = (String[]) iterator.next();
                    for (int c = 0; c < col; c++) {
                %>
                <td class="td_middle"><%=CodeUtil.interpertCode("", data[c])%></td>
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
</body>
</html>