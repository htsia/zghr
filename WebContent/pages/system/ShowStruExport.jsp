<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{sys_infoSetListBB}"/>
<h:form id="form1">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1268","生成结果文件")%> 
             </f:verbatim>
       </h:panelGroup>
    </h:panelGrid>
<c:verbatim>
    <table width=98%>
        <tr>
            <td align="right">
</c:verbatim>
               <h:commandButton value="关闭" onclick="window.close()" type="button" styleClass="button01"></h:commandButton>
<c:verbatim>
            </td>
        </tr>
        <tr><td>
</c:verbatim>
              <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1269","结果已经生成，单击下述按钮可以打开=〉")%> 
             </f:verbatim>
<c:verbatim>
        </td></tr>
        <tr>
            <td align="center">
</c:verbatim>
                <h:outputText escape="false" value="<a target='_blank' href='#{sys_infoSetListBB.fileUrl}'><img src='/images/btn_look.gif'></a>"  />
<c:verbatim>
            </td>
        </tr>
    </table>
 </c:verbatim>
</h:form>

