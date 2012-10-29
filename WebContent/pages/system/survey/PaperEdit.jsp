<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{sys_surveyBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{sys_surveyBB.pageInit}"/>
    <h:inputHidden id="ModuleID" value="sys_surveyBB.moduleID"></h:inputHidden>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
              <f:verbatim>
               	 <%=LanguageSupport.getResource("JGGL-1058", "���� ")%>:
	          </f:verbatim>
              <h:inputText id="name" value="#{sys_surveyBB.paperbo.name}" style="width:300px"/>

              <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1015", "���� ")%>:
	          </f:verbatim>
            <h:inputTextarea id="des" value="#{sys_surveyBB.paperbo.description}" cols="50" rows="7"/>

             <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1372", "���鵥λ��Χ ")%>:
	          </f:verbatim>
            <h:panelGroup>
                <h:selectOneMenu id="orgID" value="#{sys_surveyBB.paperbo.orgID}" style="width:250px">
                    <c:selectItems value="#{sys_surveyBB.orgList}"></c:selectItems>
                </h:selectOneMenu>
            </h:panelGroup>

            <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1373", "ѡ��Ƭ���ֵ")%>:
	          </f:verbatim>
            <h:inputText id="voteCount" value="#{sys_surveyBB.paperbo.voteCount}" style="width:300px"/>

            <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1374", "�Ƿ����")%>:
	         </f:verbatim>
            <h:selectOneRadio value="#{sys_surveyBB.paperbo.isRegName}" disabled="#{sys_surveyBB.paperbo.paperID!=null}">
                <c:selectItem itemValue="0" itemLabel="������"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
            </h:selectOneRadio>

             <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1375", "�Ƿ񹫿����")%>:
	         </f:verbatim>
            <h:selectOneRadio value="#{sys_surveyBB.paperbo.isHide}">
                <c:selectItem itemValue="0" itemLabel="����"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
            </h:selectOneRadio>
            
            <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1376", "���鷽ʽ")%>:
	         </f:verbatim>
            <h:selectOneRadio value="#{sys_surveyBB.paperbo.method}">
            	<c:selectItem itemValue="1" itemLabel="���ϵ���"/>
            	<c:selectItem itemValue="2" itemLabel="����ֽ��"/>
            </h:selectOneRadio>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{sys_surveyBB.Save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

