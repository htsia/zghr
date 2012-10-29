<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">

       function add() {
            window.showModalDialog("/xys/eva/SetKpiKeyEdit.jsf?libId="+document.all('form1:libId').value, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function modify(id) {
            window.showModalDialog("/xys/eva/SetKpiKeyEdit.jsf?keyId="+id, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }

    </script>

<x:saveState value="#{xys_kpiLibSetMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_kpiLibSetMgrBB.initKeyList}"></h:inputHidden>
    <h:inputHidden id="libId" value="#{xys_kpiLibSetMgrBB.libId}"></h:inputHidden>
     <c:verbatim>
       <table height=90% width=98% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
	            <h:commandButton value="����"  styleClass="button01"  onclick="add()"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
        &nbsp;&nbsp;&nbsp;
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_kpiLibSetMgrBB.keyList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="ָ������"/></c:facet>
            <h:outputText value="#{list.keyName}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="���ֱ�׼"/></c:facet>
            <h:outputText value="#{list.gradeStd}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="Ŀ��ֵ"/></c:facet>
            <h:outputText value="#{list.aimValue}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="������Դ"/></c:facet>
            <h:outputText value="#{list.dataSource}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="Ȩ�أ�%��"/></c:facet>
            <h:outputText value="#{list.weight}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="��ָ���"/></c:facet>
            <h:outputText value="#{list.hiValue}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="��ֵ���"/></c:facet>
            <h:outputText value="#{list.lowValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�޸�" onclick="return modify('#{list.keyId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="ɾ��" action="#{xys_kpiLibSetMgrBB.deleteKey}" onclick="return confirm('ȷʵҪɾ����ָ����');" styleClass="button01">
                   <x:updateActionListener property="#{xys_kpiLibSetMgrBB.keyId}" value="#{list.keyId}"/>
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
