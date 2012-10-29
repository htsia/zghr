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
               	 <%=LanguageSupport.getResource("JGGL-1058", "名称 ")%>:
	          </f:verbatim>
              <h:inputText id="name" value="#{sys_surveyBB.paperbo.name}" style="width:300px"/>

              <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1015", "描述 ")%>:
	          </f:verbatim>
            <h:inputTextarea id="des" value="#{sys_surveyBB.paperbo.description}" cols="50" rows="7"/>

             <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1372", "调查单位范围 ")%>:
	          </f:verbatim>
            <h:panelGroup>
                <h:selectOneMenu id="orgID" value="#{sys_surveyBB.paperbo.orgID}" style="width:250px">
                    <c:selectItems value="#{sys_surveyBB.orgList}"></c:selectItems>
                </h:selectOneMenu>
            </h:panelGroup>

            <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1373", "选照片最大值")%>:
	          </f:verbatim>
            <h:inputText id="voteCount" value="#{sys_surveyBB.paperbo.voteCount}" style="width:300px"/>

            <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1374", "是否记名")%>:
	         </f:verbatim>
            <h:selectOneRadio value="#{sys_surveyBB.paperbo.isRegName}" disabled="#{sys_surveyBB.paperbo.paperID!=null}">
                <c:selectItem itemValue="0" itemLabel="不记名"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="记名"></c:selectItem>
            </h:selectOneRadio>

             <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1375", "是否公开结果")%>:
	         </f:verbatim>
            <h:selectOneRadio value="#{sys_surveyBB.paperbo.isHide}">
                <c:selectItem itemValue="0" itemLabel="公开"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="隐藏"></c:selectItem>
            </h:selectOneRadio>
            
            <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1376", "调查方式")%>:
	         </f:verbatim>
            <h:selectOneRadio value="#{sys_surveyBB.paperbo.method}">
            	<c:selectItem itemValue="1" itemLabel="网上调查"/>
            	<c:selectItem itemValue="2" itemLabel="回收纸制"/>
            </h:selectOneRadio>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{sys_surveyBB.Save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

