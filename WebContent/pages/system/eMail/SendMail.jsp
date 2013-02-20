<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function checkPara(){
        if (document.all('form1:smtp').value==""){
            alert("SMTP没有设置!");
            return false;
        }
        if (document.all('form1:sendeMail').value==""){
            alert("发件信箱没有设置!");
            return false;
        }
        if (document.all('form1:receiveMail').value==""){
            alert("接收信箱没有设置!");
            return false;
        }

        if (document.all('form1:subject').value==""){
            alert("标题没有设置!");
            return false;
        }

        return true;
    }
</script>

<x:saveState value="#{sys_eMailEditBackingBean}"/>
<h:form id="form1">
    <h:inputHidden value="#{sys_eMailEditBackingBean.pageInit}"></h:inputHidden>
    <h:inputHidden value="#{sys_eMailEditBackingBean.attFileMode}"></h:inputHidden>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="SMTP"/>
            <h:inputText  readonly="true" id="smtp" value="#{sys_eMailEditBackingBean.smtp}" />
             <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1305","发送信箱")%> 
              </f:verbatim>
            <h:inputText id="sendeMail" value="#{sys_eMailEditBackingBean.sendeMail}" />
             <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1304","发送人")%> 
              </f:verbatim>
            <h:outputText id="sendName" value="#{sys_eMailEditBackingBean.sendName}" />
             <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1303","接收人")%> 
              </f:verbatim>
            <h:panelGroup>
                <h:inputHidden id="recID" value="#{sys_eMailEditBackingBean.receiveID}"></h:inputHidden>
                <h:inputText id="recName" readonly="true" value="#{sys_eMailEditBackingBean.receiveName}"/>
                <c:verbatim>
                    <input type="button" class="button_select" onclick="fPopUpPerEMailDlg( 'form1:recID','form1:recName','form1:receiveMail','form1:mobile')">
                </c:verbatim>
            </h:panelGroup>
              <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1302","接收信箱")%> 
              </f:verbatim>
            <h:panelGroup>
              <h:inputText id="receiveMail" value="#{sys_eMailEditBackingBean.receiveMail}"/>
              <h:inputHidden id="mobile"></h:inputHidden>
            </h:panelGroup>

            <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1105","标题")%> 
             </f:verbatim>
            <h:inputText id="subject" value="#{sys_eMailEditBackingBean.subject}"/>
             <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1111","内容")%> 
             </f:verbatim>
            <h:inputTextarea id="content" value="#{sys_eMailEditBackingBean.content}" cols="60" rows="10"/>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="发送" action="#{sys_eMailEditBackingBean.save}"
                             onclick="return checkPara();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>

        </h:panelGrid>
    </h:panelGrid>
</h:form>
