<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function showQryInfo(id) {
        window.showModalDialog("/xys/eva/Person360ScoreShow.jsf?sbjId="+id, null, "dialogWidth:"+screen.width+"px;dialogHeight:"+screen.height+"px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
    </script>

<x:saveState value="#{person_360AuditCtrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{person_360AuditCtrBB.initQryInfo}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title" height="10px"><img src="/images/tips.gif">
                      ��Ч���� ->����̬���������
           </td>
        </tr>
    </table>
    <br>
       <table height=90% width=100% align="center">
       <tr><td height=8>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{person_360AuditCtrBB.sbjList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
         <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.score}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�Ƿ���"/></c:facet>
            <h:outputText value="#{list.isSign}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�鿴��ϸ" onclick="showQryInfo('#{list.sbjId}')" styleClass="button01" type="button"></h:commandButton>
            <h:commandButton value="������" action="#{person_360AuditCtrBB.deleteSbj}" onclick="return confirm('ȷʵҪ������˵Ĵ�ּ�¼��\n�������Ҫ�ڿ��˼����ִ�н�������ʼ��֣����˲����ٴδ��');"
                               styleClass="button01" >
                   <x:updateActionListener property="#{person_360AuditCtrBB.sbjId}" value="#{list.sbjId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
