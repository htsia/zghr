<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.ccp.pojo.bo.PartyBO" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String []dealItem = (String[]) session.getAttribute("field");
    HashMap hash = (HashMap) session.getAttribute("fileValue");
%>

<x:saveState value="#{ccp_DataUploadBB}"/>
<h:form id="form1">
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="1" width="95%" align="right">
        <h:panelGroup>
                <h:outputText value="数据记录数:"></h:outputText>
                <c:verbatim><%=hash.size()%></c:verbatim>
                <h:outputText value="     "/>
                <h:outputText value="数据处理方式"/>
                <h:selectOneMenu value="#{ccp_DataUploadBB.mode}">
                    <c:selectItems value="#{ccp_DataUploadBB.modelist}"></c:selectItems>
                </h:selectOneMenu>
            <h:commandButton styleClass="button01" value="确认上传" action="#{ccp_DataUploadBB.saveFile}"/>
            <h:outputText value=" "/>
            <h:commandButton styleClass="button01" value="取消上传" action="upload"/>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim>
    <br><br>
    </c:verbatim>
    <h:panelGrid columns="1" align="center" width="95%" >
        <h:outputLink target="_blank" rendered="#{ccp_DataUploadBB.showError}" style="color:red"
                      value="#{ccp_DataUploadBB.errorFileUrl}">
            <h:outputText value="上传文件数据有错误，点击下载错误数据文件"/>
        </h:outputLink>
    </h:panelGrid>

    <c:verbatim>
        <%
            if (hash != null && hash.size() > 0) {
                int col = dealItem.length;
        %>
        <table width="95%" border="0" align="center" class="table03">
            <tr align="center" class="td_top">
                <td height="27" colspan="<%=col+2%>" class="td_top">查看导入文件数据</td>
            </tr>
            <tr>
                <td class="td_top">党组织编号</td>
                <td class="td_top">党组织名称</td>
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
                    String []keyValue=((String) key.next()).split("\\|");
                    PartyBO p = SysCacheTool.findParty(keyValue[0]);
            %>
            <tr>
                <td class="td_middle"><%=p.getPartyCode()%></td>
                <td class="td_middle"><%=p.getPartyName()%></td>
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
