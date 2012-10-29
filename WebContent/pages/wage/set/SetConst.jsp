<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forAdd() {
            window.showModalDialog("/wage/set/ConstEdit.jsf?setId="+form1.all("form1:setId").value+"&setName="+form1.all("form1:setName").value,
                    null,
                    "dialogWidth:500px; dialogHeight:280px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModify(constID) {
            window.showModalDialog("/wage/set/ConstEdit.jsf?dateId="+form1.all("form1:dateId").value+"&constID="+constID+"&setId="+form1.all("form1:setId").value+"&setName="+form1.all("form1:setName").value,
                    null,
                    "dialogWidth:500px; dialogHeight:280px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }

    </script>

<x:saveState value="#{wage_ConstBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_ConstBB.pageInit}"/>
    <h:inputHidden id="setID" value="#{wage_ConstBB.setId}"/>
    <h:inputHidden id="dateId" value="#{wage_ConstBB.dateId}"/>
    <h:inputHidden id="setName" value="#{wage_ConstBB.setName}"/>
    
    <h:panelGrid columns="2" cellspacing="2" width="75%"  align="center" >
          <h:outputText value="#{wage_ConstBB.setName}"></h:outputText>
          <h:panelGrid columns="2" cellspacing="2" align="right">
             <h:commandButton value="����"  styleClass="button01" onclick="return forAdd()">
             </h:commandButton>
             <h:commandButton value="����" styleClass="button01" onclick="window.close();return false;"/>
          </h:panelGrid>
    </h:panelGrid>

    <h:dataTable value="#{wage_ConstBB.constList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.constName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.desc}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��ǰֵ"/></c:facet>
            <h:outputText value="#{list.constValue}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.setName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="ɾ��" styleClass="button01"
                                 action="#{wage_ConstBB.delete}" onclick="return confirm('ȷ��ɾ����')">
                    <x:updateActionListener property="#{wage_ConstBB.wcbo.constID}" value="#{list.constID}"/>
                </h:commandButton>
                <h:commandButton value="�޸�" onclick="forModify('#{list.constID}')"   styleClass="button01">
                </h:commandButton>
            </h:panelGrid>
        </h:column>
    </h:dataTable>
</h:form>
