<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function add(){
        	 window.showModalDialog("/wage/adjust/colEdit.jsf?setID="+document.all("form1:setID").value, "", "dialogWidth:350px; dialogHeight:270px;center:center;resizable:no;status:no;scroll:no;");
             return true;
         }
        function modify(id){
        	window.showModalDialog("/wage/adjust/colEdit.jsf?colId="+id, "", "dialogWidth:350px; dialogHeight:270px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{wageReformMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wageReformMgrBB.initColList}"></h:inputHidden>
	<h:inputHidden id="setID" value="#{wageReformMgrBB.setID}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
	            <h:commandButton value="增加" onclick="return add();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>
          
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{wageReformMgrBB.colList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="顺序"/></c:facet>
            <h:outputText value="#{list.seq}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="任职显示标题"/></c:facet>
            <h:outputText value="#{list.title}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="低限(年)"/></c:facet>
            <h:outputText value="#{list.lowValue}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="高限(年)"/></c:facet>
            <h:outputText value="#{list.highValue}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="编辑" onclick="return modify('#{list.colId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{wageReformMgrBB.delete}" styleClass="button01">
                  <x:updateActionListener property="#{wageReformMgrBB.colId}" value="#{list.colId}"/>
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
