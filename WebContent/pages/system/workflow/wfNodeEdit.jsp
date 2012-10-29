<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forSelSource() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:sourceField").value,'');
            return false;
        }

        function doCheck() {
            if (document.all("form1:operID").value==""){
                alert("��ѡ�����������");
                return false;
            }
            if (document.all("form1:name").value==""){
                alert("��¼������!");
                return false;
            }
            if (document.all("form1:seq").value==""){
                alert("��¼��˳��!");
                return false;
            }

            return true;
        }
    </script>

<x:saveState value="#{sys_workflownodeBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{sys_workflownodeBB.initEditNode}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{sys_workflownodeBB.saveNode}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
              <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1058","����")%>  
             </f:verbatim>
            <h:inputText id="name" value="#{sys_workflownodeBB.nodebo.nodeName}" />

             <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1155","�ڵ�����")%>  
             </f:verbatim>
            <h:selectOneMenu id="nodeType" value="#{sys_workflownodeBB.nodebo.nodeType}" disabled="true">
                <c:selectItem itemValue="S" itemLabel="��ʼ�ڵ�"></c:selectItem>
                <c:selectItem itemValue="E" itemLabel="�����ڵ�"></c:selectItem>
                <c:selectItem itemValue="M" itemLabel="�м�ڵ�"></c:selectItem>
            </h:selectOneMenu>

             <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1156","��������")%>  
             </f:verbatim>
            <h:selectOneMenu id="operID" value="#{sys_workflownodeBB.nodebo.operID}" disabled="#{sys_workflownodeBB.nodebo.nodeID!=null && sys_workflownodeBB.nodebo.nodeID!=''}">
                <c:selectItems value="#{sys_workflownodeBB.operList}"></c:selectItems>
            </h:selectOneMenu>


             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1157","˳��")%>  
             </f:verbatim>
            <h:inputText id="seq" value="#{sys_workflownodeBB.nodebo.seq}" />

             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1158","����")%>  
             </f:verbatim>
            <h:inputText id="toSEQ" readonly="true" value="#{sys_workflownodeBB.nodebo.toSEQ}" />
            <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1159","������Ϣ")%>  
             </f:verbatim>
            <h:inputTextarea id="message" value="#{sys_workflownodeBB.nodebo.message}" rows="10" cols="60"/>
        </h:panelGrid>

    </h:panelGrid>
</h:form>
