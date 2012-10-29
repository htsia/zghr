<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
     function keySet(id) {
            window.showModalDialog("/xys/eva/SetDeptObjKeyLib.jsf?objId="+id, null, "dialogWidth:"+screen.width*0.9+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
     }
</script>
<x:saveState value="#{xys_KpiPersonSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_KpiPersonSetBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{xys_KpiPersonSetBB.superId}"></h:inputHidden>
     <h:inputHidden id="planId" value="#{xys_KpiPersonSetBB.planId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="3">
		  <h:panelGrid align="center">
		  <h:panelGroup>
                  <h:outputText value="������Ա�����:"></h:outputText>
                  <h:inputText value="#{xys_KpiPersonSetBB.queryValue}" styleClass="input"></h:inputText>
                  <h:commandButton value="��ѯ" action="#{xys_KpiPersonSetBB.doQuery}" styleClass="button01"></h:commandButton>
              </h:panelGroup>
		  </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{xys_KpiPersonSetBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{xys_KpiPersonSetBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{xys_KpiPersonSetBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{xys_KpiPersonSetBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{xys_KpiPersonSetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_KpiPersonSetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_KpiPersonSetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{xys_KpiPersonSetBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_KpiPersonSetBB.objList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
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
            <c:facet name="header"><h:outputText value="ָ��״̬"/></c:facet>
            <h:selectOneMenu value="#{list.keyStatus}" disabled="true">
                 <c:selectItem itemLabel="����" itemValue="1"/>
                 <c:selectItem itemLabel="����" itemValue="2"/>
                 <c:selectItem itemLabel="��׼" itemValue="3"/>
                 <c:selectItem itemLabel="�˻�" itemValue="F"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
             <h:commandButton value="ָ������" onclick="return keySet('#{list.objId}')" styleClass="button01"></h:commandButton>
             <h:commandButton value="ɾ��" action="#{xys_KpiPersonSetBB.deleteObj}" onclick="return confirm('ȷʵҪɾ��ָ����������Ա��');"
                               styleClass="button01" rendered="#{list.keyStatus=='1'||list.keyStatus=='2'||list.keyStatus=='F'}">
                   <x:updateActionListener property="#{xys_KpiPersonSetBB.objId}" value="#{list.objId}"/>
            </h:commandButton>
            <h:commandButton value="�˻��޸�" action="#{xys_KpiPersonSetBB.refuseObj}" onclick="return confirm('ȷʵҪ�˻�ָ����������Ա��ָ����');"
                               styleClass="button01" rendered="#{list.keyStatus=='3'}">
                   <x:updateActionListener property="#{xys_KpiPersonSetBB.objId}" value="#{list.objId}"/>
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
