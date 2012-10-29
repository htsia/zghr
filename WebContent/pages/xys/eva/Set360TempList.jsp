<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">

       function add() {
            window.showModalDialog("/xys/eva/Set360TempEdit.jsf?libId="+document.all('form1:libId').value, null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function modify(id) {
            window.showModalDialog("/xys/eva/Set360TempEdit.jsf?tempId="+id, null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
         function tempSet(id) {
            window.showModalDialog("/xys/eva/Set360TempSet.jsf?tempId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.7+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
    </script>

<x:saveState value="#{xys_360TempBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_360TempBB.initTempList}"></h:inputHidden>
    <h:inputHidden id="libId" value="#{xys_360TempBB.libId}"></h:inputHidden>
     <c:verbatim>
       <table height=90% width=98% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
	            <h:commandButton value="增加"  styleClass="button01"  onclick="add()"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
        &nbsp;&nbsp;&nbsp;
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_360TempBB.tempList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="模版名称"/></c:facet>
            <h:outputText value="#{list.tempName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="总分"/></c:facet>
            <h:outputText value="#{list.tatalScore}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.tempId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" action="#{xys_360TempBB.deleteTemp}" onclick="return confirm('确实要删除该指标吗？');" styleClass="button01">
                   <x:updateActionListener property="#{xys_360TempBB.tempId}" value="#{list.tempId}"/>
            </h:commandButton>
            <h:commandButton value="指标设置" onclick="tempSet('#{list.tempId}')" styleClass="button01"></h:commandButton>
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
