<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function confirmDel() {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm('ȷ��Ҫɾ����'))
                    return true;
            }
            return false;
        }
    </script>
<x:saveState value="#{wage_noteBB}"/>
<h:form id="form1">
     <h:inputHidden value="#{wage_noteBB.pageInit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="н����� -> Ա��н�ʱ䶯"/>
       </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" align="center">
        <h:outputText value=" ��н��λ��#{wage_noteBB.unitName}"/>
        <h:panelGrid columns="2" width="100%" >
            <h:panelGrid columns="5" align="left">
                <h:outputText value="��ʼʱ��"/>
                <h:panelGroup>
                    <h:inputText id="startDate" value="#{wage_noteBB.startdate}"/>
                    <h:commandButton type="button" styleClass="button_date"
                                     onclick="PopUpCalendarDialog(form1.all('form1:startdate'))"/>
                </h:panelGroup>

                <h:outputText value="����ʱ��"/>
                <h:panelGroup>
                    <h:inputText id="endDate" value="#{wage_noteBB.enddate}"/>
                    <h:commandButton type="button" styleClass="button_date"
                                     onclick="PopUpCalendarDialog(form1.all('form1:enddate'))"/>
                </h:panelGroup>

                <h:commandButton value="��ѯ" styleClass="button01" action="#{wage_noteBB.list}" id="doQuery"/>
            </h:panelGrid>

            <h:panelGrid columns="3" align="right">
                <h:commandButton value="������Excel" styleClass="button01" action="#{wage_noteBB.exportFile}"/>
                <h:commandButton value="����" styleClass="button01" action="#{wage_noteBB.create}"/>
                <h:commandButton value="ɾ��" styleClass="button01" action="#{wage_noteBB.delete}"
                                 onclick="return confirmDel();"/>
            </h:panelGrid>
        </h:panelGrid>

        <h:dataTable value="#{wage_noteBB.noteList}" var="list"
                     headerClass="td_top"  id="dateList"
                     columnClasses="td_middle_center,td_middle_center, td_middle_center,td_middle,td_middle,td_middle_center, td_middle_center, td_middle_center"
                     styleClass="table03" width="100%">
            <h:column>
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll"
                               onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <div align="center"> <input type="checkbox" name="selectItem"
                    value="</c:verbatim><h:outputText value="#{list.noteId}"/><c:verbatim>"></div></c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�䶯����"/></c:facet>
                <h:outputText value="#{list.date}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��Ա"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
                <h:outputText value="#{list.personDept}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="�䶯����"/></c:facet>
                <h:outputText value="#{list.cause}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="�䶯����"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.linkSet}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��������"/></c:facet>
                <h:outputText value="#{list.operType}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton styleClass="button01" action="#{wage_noteBB.find}" value="�޸�">
                    <x:updateActionListener property="#{wage_noteBB.note.noteId}" value="#{list.noteId}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
