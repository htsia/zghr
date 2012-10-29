<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forAddCess() {
            window.showModalDialog("/wage/set/CessEdit.jsf", null, "dialogWidth:330px; dialogHeight:250px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModifyCess(cess) {
            window.showModalDialog("/wage/set/CessEdit.jsf?cessID="+cess, null, "dialogWidth:330px; dialogHeight:250px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModifyCessItem(cess) {
            window.showModalDialog("/wage/set/CessItemEdit.jsf?cessID="+cess, null, "dialogWidth:430px; dialogHeight:350px;center:center;resizable:no;status:no;");
            return true;
        }
        function forViewCess(cess){
            window.showModalDialog("/wage/set/ViewCess.jsf?cessID="+cess, null, "dialogWidth:430px; dialogHeight:400px;center:center;resizable:no;status:no;");
            return false;
        }
    </script>

<x:saveState value="#{wage_cesslistBB}"/>
<h:form id="form1">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" н����� ->  ˰�ʱ�����"/>
        </h:panelGroup>
    </h:panelGrid>


    <h:panelGrid  width="95%" border="0" cellpadding="0" cellspacing="6">
        <h:panelGrid columns="1" cellspacing="2" align="right">
            <h:commandButton value="����"  rendered="#{wage_cesslistBB.canAdd}" styleClass="button01" onclick="return forAddCess()"/>
        </h:panelGrid>

    <h:dataTable value="#{wage_cesslistBB.cessList}" var="list" align="center"   id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.description}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:selectOneRadio value="#{list.taxType}" disabled="true">
                <c:selectItem itemLabel="��˰����" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="����˰����" itemValue="1"></c:selectItem>
            </h:selectOneRadio>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.rank}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.taxBegin}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="ɾ��" styleClass="button01" rendered="#{wage_cesslistBB.canDelete}"
                                 action="#{wage_cesslistBB.delete}" onclick="return confirm('ȷ��ɾ����')">
                    <x:updateActionListener property="#{wage_cesslistBB.wcbo.cessID}" value="#{list.cessID}"/>
                </h:commandButton>
                <h:commandButton value="�޸�" onclick="forModifyCess('#{list.cessID}')"  rendered="#{wage_cesslistBB.canModify}"
                                 styleClass="button01" >
                </h:commandButton>
                <h:commandButton value="�鿴" onclick="forViewCess('#{list.cessID}')"  rendered="#{!wage_cesslistBB.canModify}"
                                 styleClass="button01" >
                </h:commandButton>
                <h:commandButton value="����˰�ʱ�����" onclick="forModifyCessItem('#{list.cessID}')" rendered="#{wage_cesslistBB.canModifyDate}"
                                 styleClass="button01" >
                </h:commandButton>
            </h:panelGrid>
        </h:column>
    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
    setDataTableOver("form1:dateList");
</script>