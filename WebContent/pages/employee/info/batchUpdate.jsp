<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<c:verbatim><base target="_self"></c:verbatim>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<h:form>
    <x:saveState value="#{emp_busiprocessBB}"></x:saveState>
    <h:inputHidden value="#{emp_busiprocessBB.initUpdate}"></h:inputHidden>
    <h:inputHidden id="setId" value="#{emp_busiprocessBB.setId}"/>
    <h:outputText escape="false" value="#{emp_busiprocessBB.title}"></h:outputText>
    
    <h:panelGrid columns="2" width="98%" columnClasses="td_form01,td_form02" align="center">
      <f:verbatim>
        	<%=LanguageSupport.getResource("RYGL-2277"," �������")%>
        </f:verbatim>      
        <h:panelGroup>
             <h:selectOneMenu id="resultField" value="#{emp_busiprocessBB.sortField}">
                 <c:selectItems value="#{emp_busiprocessBB.sortList}"></c:selectItems>
             </h:selectOneMenu>

            <h:selectOneMenu value="#{emp_busiprocessBB.oper}">
                <c:selectItem itemValue="=" itemLabel="����"></c:selectItem>
                <c:selectItem itemValue="+" itemLabel="����"></c:selectItem>
                <c:selectItem itemValue="*" itemLabel="����"></c:selectItem>
            </h:selectOneMenu>

             <h:inputText id="resultValue" value="#{emp_busiprocessBB.resultValue}" ></h:inputText>
        </h:panelGroup>


          <f:verbatim>
        	<%=LanguageSupport.getResource("YXGL-1026"," ����")%>
        </f:verbatim>      
         <h:panelGrid columns="2" align="right">
             <h:commandButton value="����" styleClass="button01" onclick="return confirm('ȷ��Ҫ�޸�������')" action="#{emp_busiprocessBB.update}"></h:commandButton>
             <h:commandButton value="����" styleClass="button01" onclick="window.close()" type="button"></h:commandButton>
         </h:panelGrid>
    </h:panelGrid>
</h:form>