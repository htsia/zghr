<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function add() {
        window.showModalDialog("/xys/eva/StudentGradeEdit.jsf?planId=" + document.all("form1:planId").value, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
   
    function modify(id) {
        window.showModalDialog("/xys/eva/StudentGradeEdit.jsf?scoreId="+id, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
   
    
</script>
<x:saveState value="#{regStrudentGradeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{regStrudentGradeBB.initInput}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{regStrudentGradeBB.superId}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{regStrudentGradeBB.planId}"></h:inputHidden>
    <c:verbatim>
        <table height=98% width=98% align="center">
        <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
        <h:panelGrid align="left">
            <h:panelGroup>
                <h:outputText value="������Ա�����:"></h:outputText>
                <h:inputText value="#{regStrudentGradeBB.queryValue}"/>
                <h:commandButton value="��ѯ" action="#{regStrudentGradeBB.queryScoere}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="��¼��:#{regStrudentGradeBB.mypage.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="ҳ��:#{regStrudentGradeBB.mypage.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="ÿҳ��#{regStrudentGradeBB.mypage.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="��ǰΪ��#{regStrudentGradeBB.mypage.currentPage}ҳ"></h:outputText>
                <h:commandButton value="��ҳ" action="#{regStrudentGradeBB.first1}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{regStrudentGradeBB.pre1}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{regStrudentGradeBB.next1}" styleClass="button01"></h:commandButton>
                <h:commandButton value="βҳ" action="#{regStrudentGradeBB.last1}" styleClass="button01"></h:commandButton>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="����"  styleClass="button01" onclick="add()"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
        </td></tr>
        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
    <h:dataTable value="#{regStrudentGradeBB.personList}" var="list" align="center" id="dateList"
                 headerClass="td_top"
                 columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%">
        
        
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����һ�÷�"/></c:facet>
            <h:outputText value="#{list.score}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���۶��÷�"/></c:facet>
            <h:outputText value="#{list.score2}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ƽ����"/></c:facet>
            <h:outputText value="#{list.avgScore}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�޸�" onclick="return modify('#{list.scoreId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="ɾ��" action="#{regStrudentGradeBB.delete}" onclick="return confirm('ȷ��Ҫɾ��ѡ�мƻ���');"
                            styleClass="button01">
                  <x:updateActionListener property="#{regStrudentGradeBB.scoreId}" value="#{list.scoreId}"/>
            </h:commandButton>
        </h:column>
    </h:dataTable>
    <c:verbatim>
        </div>
        </td></tr>
        </table>
       
    </c:verbatim>

</h:form>
<script type="text/javascript">
    setDataTableOver("form1:dateList");
</script>
