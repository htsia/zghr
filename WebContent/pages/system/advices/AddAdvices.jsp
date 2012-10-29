<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{self_advicesEditBB}"/>
	<h:form id="BulletinEditForm">
      <h:inputHidden  value="#{self_advicesEditBB.initSend }"/>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                  <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1291","提出建议")%> 
                 </f:verbatim>
           </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>

        <h:panelGrid border="1" columns="2" align="center" cellspacing="2"    cellpadding="10"	columnClasses="td_form01,td_form02" styleClass="table03">
			<f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1110","欲发机构")%> 
            </f:verbatim>
            <h:selectOneMenu value="#{self_advicesEditBB.advbo.advOrg}" >
                   <c:selectItems value="#{self_advicesEditBB.orgList}"></c:selectItems>
            </h:selectOneMenu>

            <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1105","标题")%> 
            </f:verbatim>
			<h:panelGroup>
				<h:inputText id="text1" styleClass="input" value="#{self_advicesEditBB.advbo.advSubject}" size="80" maxlength="50">
				</h:inputText>
			</h:panelGroup>

			<f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1111","内容")%> 
            </f:verbatim>
			<h:panelGroup>
				<h:inputTextarea id="textarea" rows="15" cols="80"
					value="#{self_advicesEditBB.advbo.advContent}">
				</h:inputTextarea>
			</h:panelGroup>

		</h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>

        <h:panelGrid border="0" columns="2" cellpadding="8" align="right">
			<h:commandButton value="发送" action="#{self_advicesEditBB.saveAdvices}" styleClass="button01" />
			<h:commandButton value="返回" onclick="window.close();" styleClass="button01" />
		</h:panelGrid>
	</h:form>


