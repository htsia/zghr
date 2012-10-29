<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doCheck() {
            if (document.all('form1:mode').value==""){
                alert('��ѡ���������ģʽ');
                return false;
            }


            if (document.all('form1:toNode').value==""){
                alert('��ѡ������');
                return false;
            }

            return true;
        }
    </script>

<x:saveState value="#{sys_workflownodeBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{sys_workflownodeBB.initTransEdit}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{sys_workflownodeBB.saveWFTransBO}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
             <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1160","ѡ������")%>  
             </f:verbatim>
            <h:panelGroup>
                <h:selectOneMenu id="toNode" value="#{sys_workflownodeBB.transbo.toNode}">
                    <c:selectItems value="#{sys_workflownodeBB.selecttransList}"></c:selectItems>
                </h:selectOneMenu>
                <h:outputText value="�������̽�����Ϣ"></h:outputText>
                <h:selectBooleanCheckbox value="#{sys_workflownodeBB.transbo.bendMsg}"></h:selectBooleanCheckbox>
            </h:panelGroup>

        <f:verbatim>
              <%=LanguageSupport.getResource("JGGL-1161","�������ģʽ")%>  
         </f:verbatim>
        <h:selectOneRadio id="mode" value="#{sys_workflownodeBB.transbo.mode}">
            <c:selectItem itemValue="1" itemLabel="����ģʽ" ></c:selectItem>
            <c:selectItem itemValue="2" itemLabel="״̬ģʽ" ></c:selectItem>
            <c:selectItem itemValue="3" itemLabel="���ģʽ" ></c:selectItem>
            <c:selectItem itemValue="4" itemLabel="������ת��" ></c:selectItem>
        </h:selectOneRadio>
        
         <h:panelGroup>
             <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1163","��")%>
             </f:verbatim>
                    <h:outputText value="#{sys_workflownodeBB.statusField}"/>
             <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1162","���ڸ�ֵʱת��")%>
             </f:verbatim>
         </h:panelGroup>
         <h:panelGroup>
            <h:selectOneMenu value="#{sys_workflownodeBB.transbo.statusValue}">
                <c:selectItems value="#{sys_workflownodeBB.statusList}"/>
            </h:selectOneMenu>
         </h:panelGroup>

         <h:panelGroup>
          <f:verbatim>
              <%=LanguageSupport.getResource("JGGL-1163","��")%>  
         </f:verbatim>
        <h:outputText value="#{sys_workflownodeBB.conditionField}"/>
        <f:verbatim>
              <%=LanguageSupport.getResource("XTGL-1164","��������ʱת��")%>  
         </f:verbatim>
        </h:panelGroup>    
        <h:panelGrid columns="1" width="100%">
            <h:panelGroup>
                <h:selectOneMenu id="conOper" value="#{sys_workflownodeBB.transbo.conOper}">
                    <c:selectItem itemValue="" itemLabel="==����ѡ��==" ></c:selectItem>
                    <c:selectItem itemValue="<"  itemLabel="<" ></c:selectItem>
                    <c:selectItem itemValue="<=" itemLabel="<=" ></c:selectItem>
                    <c:selectItem itemValue=">" itemLabel=">" ></c:selectItem>
                    <c:selectItem itemValue=">=" itemLabel=">=" ></c:selectItem>
                    <c:selectItem itemValue="=" itemLabel="=" ></c:selectItem>
                    <c:selectItem itemValue="<>" itemLabel="<>" ></c:selectItem>
                </h:selectOneMenu>
                <h:inputText value="#{sys_workflownodeBB.transbo.conValue}"></h:inputText>
             </h:panelGroup>

             <h:panelGroup>
                 <h:selectOneMenu id="conRelation" value="#{sys_workflownodeBB.transbo.conRelation}">
                     <c:selectItem itemValue="" itemLabel="==��ϵѡ��==" ></c:selectItem>
                     <c:selectItem itemValue="OR"  itemLabel="����" ></c:selectItem>
                     <c:selectItem itemValue="AND"  itemLabel="����" ></c:selectItem>
                 </h:selectOneMenu>
                 <h:selectOneMenu id="conOper2" value="#{sys_workflownodeBB.transbo.conOper2}">
                     <c:selectItem itemValue="" itemLabel="==����ѡ��==" ></c:selectItem>
                     <c:selectItem itemValue="<"  itemLabel="<" ></c:selectItem>
                     <c:selectItem itemValue="<=" itemLabel="<=" ></c:selectItem>
                     <c:selectItem itemValue=">" itemLabel=">" ></c:selectItem>
                     <c:selectItem itemValue=">=" itemLabel=">=" ></c:selectItem>
                     <c:selectItem itemValue="=" itemLabel="=" ></c:selectItem>
                     <c:selectItem itemValue="<>" itemLabel="<>" ></c:selectItem>
                 </h:selectOneMenu>
                 <h:inputText value="#{sys_workflownodeBB.transbo.conValue2}"></h:inputText>

             </h:panelGroup>
         </h:panelGrid>

         
           <f:verbatim>
              <%=LanguageSupport.getResource("XTGL-1166","������Ϣ")%>  
         </f:verbatim>
        <h:inputTextarea value="#{sys_workflownodeBB.transbo.toMessage}" rows="5" cols="40"></h:inputTextarea>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
