<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function addMonth() {
            window.showModalDialog("/insurace/addMonth.jsf", null, "dialogWidth:320px; dialogHeight:250px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doDetailPopup(month){
            window.showModalDialog("/insurace/PersonCountDetail.jsf?month="+month, null, "dialogWidth:"+0.8*screen.width+"px; dialogHeight:"+0.8*screen.height+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>

<x:saveState value="#{ins_PersonCountBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{ins_PersonCountBB.pageInit}"/>

    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" ���չ��� ->  ������Ա��������"/>
        </h:panelGroup>
    </h:panelGrid>


    <h:panelGrid columns="2"  width="90%"  >
        <h:panelGrid columns="1" align="right" cellspacing="2">
            <h:panelGroup>
                <h:commandButton value="����" action="" styleClass="button01" onclick="return addMonth();"/>
            </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>

    <h:dataTable value="#{ins_PersonCountBB.infoList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >

        <h:column>
            <c:facet name="header"><h:outputText value="�·�"/></c:facet>
            <h:outputText value="#{list.b735701}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="���»���"/></c:facet>
            <h:outputText value="#{list.b735702}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.b735703}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="���¼���"/></c:facet>
            <h:outputText value="#{list.b735704}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="������ĩ��"/></c:facet>
            <h:outputText value="#{list.b735705}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="���º���" styleClass="button01" onclick="return confirm('ȷ��Ҫ���º�����?');" action='#{ins_PersonCountBB.reCacl}'>
                       <x:updateActionListener property="#{ins_PersonCountBB.subID}" value="#{list.subID}"/>
                </h:commandButton>
                <h:commandButton value="�鿴�䶯��ϸ" styleClass="button01"  type="button" onclick="doDetailPopup('#{list.b735701}')"/>
            </h:panelGrid>
        </h:column>
    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>