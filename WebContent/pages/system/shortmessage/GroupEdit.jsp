<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <c:verbatim><base target="_self"></c:verbatim>
    <script type="text/javascript">
        function doCheck(){
            if (document.all("form1:name").value==""){
                alert("��¼������");
                return false;
            }

            if (document.all("form1:public").value==""){
                alert("��ѡ���Ƿ���");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{sys_smGroupBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{sys_smGroupBB.editInit}"/>
    <h:inputHidden id="groupID" value="#{sys_smGroupBB.groupbo.groupID}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <f:verbatim>
		        <%=LanguageSupport.getResource("JGGL-1058", "����")%>
			</f:verbatim>
            <h:inputText id="name" value="#{sys_smGroupBB.groupbo.groupName}" />

            <h:outputText value="�Ƿ���"/>
            <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1360", "�Ƿ���")%>
			</f:verbatim>
            <h:selectOneMenu id="public" value="#{sys_smGroupBB.groupbo.isPublic}">
                <c:selectItem itemValue="" itemLabel="--��ѡ��--"></c:selectItem>
                <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
            </h:selectOneMenu>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{sys_smGroupBB.save}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

