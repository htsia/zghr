<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="java.util.Iterator" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String []dealItem = (String[]) session.getAttribute("field");
    HashMap hash = (HashMap) session.getAttribute("fileValue");
%>

<x:saveState value="#{emp_DataUploadBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="perSelSet" value="#{emp_DataUploadBB.perSelSet}"/>
    <c:verbatim escape="false"><br>
    <table width="98%">
       <tr>
           <td class="td_title">
</c:verbatim>    
                <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1095","���ݼ�¼��")%>:
                </f:verbatim>
                <c:verbatim><%=hash.size()%></c:verbatim>
                <h:outputText value="     "/>
                <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1096","���ݴ���ʽ")%>:
                </f:verbatim>
                <h:selectOneMenu value="#{emp_DataUploadBB.mode}">
                    <c:selectItems value="#{emp_DataUploadBB.modelist}"></c:selectItems>
                </h:selectOneMenu>

                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" value="���浽���ݿ�" action="#{emp_DataUploadBB.saveFile}"/>

                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" value="����" action="upload"/>
<c:verbatim>
            </td>
       </tr>
    </table>

    <br>
 </c:verbatim>
    <h:panelGrid columns="1" align="center" width="95%" >
        <h:outputLink  target="_blank" rendered="#{emp_DataUploadBB.showError}" style="color:red" value="#{emp_DataUploadBB.errorFileUrl}">
              <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1097","�ϴ��ļ������д��󣬵�����ش��������ļ�")%>:
                </f:verbatim>
        </h:outputLink>
    </h:panelGrid>

    <c:verbatim>
        <%
            if (hash != null && hash.size() > 0) {
                int col = dealItem.length;
        %>
        <table width="95%" border="0" align="center" id="dataList" class="table03">
            <tr align="left" class="td_top">
                <td height="27" colspan="<%=col+2%>" class="td_top"><%=LanguageSupport.getResource("RYGL-2249","�����ļ���������")%>:</td>
            </tr>
            <tr >
                <td class="td_top"><%=LanguageSupport.getResource("XTGL-1042","Ա�����")%></td>
                <td class="td_top"><%=LanguageSupport.getResource("RYGL-2136","Ա������")%></td>
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
                    // ������¼�Ӽ������ж��е����
                    String []keyValue=((String) key.next()).split("\\|");
                    PersonBO p = SysCacheTool.findPersonById(keyValue[0]);
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
<script type="text/javascript">
   setDataTableOver("dataList");
</script>