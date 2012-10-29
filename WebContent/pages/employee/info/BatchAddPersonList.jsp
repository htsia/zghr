<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String[] dealItem = (String[]) session.getAttribute("field");
    InfoItemBO[] itemBOs = new InfoItemBO[dealItem.length];
    for (int i = 0; i < itemBOs.length; i++) {
        itemBOs[i] = SysCacheTool.findInfoItem("",dealItem[i]);
    }
    HashMap hash = (HashMap) session.getAttribute("fileValue");
%>

<x:saveState value="#{emp_DataAddBB}"></x:saveState>
<h:form id="form1">
    <c:verbatim escape="false"><br></c:verbatim>
    <table width="98%">
       <tr>
           <td class="td_title" align="right">
                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" value="保存到数据库" action="#{emp_DataAddBB.saveFile}"/>

                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" value="返回" action="upload"/>
            </td>
       </tr>
    </table>

    <br>

    <h:panelGrid columns="1" align="center" width="95%" >
        <h:outputLink  target="_blank" rendered="#{emp_DataAddBB.showError}" style="color:red" value="#{emp_DataAddBB.errorFileUrl}">
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
                <td height="27" colspan="<%=col+2%>" class="td_top"><%=LanguageSupport.getResource("RYGL-2273","导入文件数据如下(共")%><%=hash.size()%><%=LanguageSupport.getResource("RYGL-2274","个")%>):</td>
            </tr>
            <tr >
                <%
                    for (int c = 0; c < col; c++) {
                %>
                <td class="td_top"><%=CodeUtil.interpertCode("INFOITEM", dealItem[c])%>
                </td>
                <%
                    }
                %>
            </tr>
            <%
                Iterator iterator = hash.values().iterator();
                Iterator key = hash.keySet().iterator();

                while (iterator.hasNext() && key.hasNext()) {
            %>
            <tr>
                <%
                    String[] data = (String[]) iterator.next();
                    for (int c = 0; c < col; c++) {
                %>
                <td class="td_middle">
                <%
                    if (InfoItemBO.DATA_TYPE_CODE.equals(itemBOs[c].getItemDataType())){
                        out.println(CodeUtil.interpertCode("", data[c]));
                    }
                    else if (InfoItemBO.DATA_TYPE_ORG.equals(itemBOs[c].getItemDataType())){
                         out.println(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, data[c]));
                    }
                    else out.println(data[c]);
                %>
                </td>
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