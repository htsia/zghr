<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.ccp.pojo.bo.PartyBO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String []dealItem = (String[]) session.getAttribute("field");
    HashMap hash = (HashMap) session.getAttribute("fileValue");
%>

<x:saveState value="#{org_DataUploadBB}"/>
<h:form id="form1">
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="1" width="95%" align="right">
        <h:panelGroup>
                <f:verbatim>
                  <strong><%=LanguageSupport.getResource("JGGL-1095","数据记录数")%> ：</strong>
                </f:verbatim>
                <c:verbatim><%=hash.size()%></c:verbatim>
                <h:outputText value="     "/>
                 <f:verbatim>
                  <strong> 
                  <%=LanguageSupport.getResource("JGGL-1096","数据处理方式")%> ：
                  </strong>
                </f:verbatim>
                <h:selectOneMenu value="#{org_DataUploadBB.mode}">
                    <c:selectItems value="#{org_DataUploadBB.modelist}"></c:selectItems>
                </h:selectOneMenu>
            <h:commandButton styleClass="button01" value="确认上传" action="#{org_DataUploadBB.saveFile}"/>
            <h:outputText value=" "/>
            <h:commandButton styleClass="button01" value="取消上传" action="upload"/>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim escape="false"><br><br><br></c:verbatim>
    <h:panelGrid columns="1" align="center" width="95%" >
        <h:outputLink target="_blank" rendered="#{org_DataUploadBB.showError}" style="color:red"
                      value="#{org_DataUploadBB.errorFileUrl}">
         <f:verbatim>
              <%=LanguageSupport.getResource("JGGL-1097","上传文件数据有错误，点击下载错误数据文件")%> 
         </f:verbatim>
        </h:outputLink>
    </h:panelGrid>

    <c:verbatim>
        <%
            if (hash != null && hash.size() > 0) {
                int col = dealItem.length;
        %>
        <table width="95%" border="0" align="center" class="table03">
            <tr align="left" class="td_top">
                <td height="27" colspan="<%=col+2%>" class="td_top">查看导入文件数据</td>
            </tr>
            <tr>
                <td class="td_top">机构代码</td>
                <td class="td_top">机构名称</td>
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
                    String[] keyValue = ((String) key.next()).split("\\|");
                    OrgBO p = SysCacheTool.findOrgById(keyValue[0]);
            %>
            <tr>
                <td class="td_middle"><%=p.getOrgCode()%></td>
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
