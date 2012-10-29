<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">

       function add() {
            window.showModalDialog("/xys/eva/Set360TempItemEdit.jsf?setId="+document.all('form1:setId').value, null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function modify(id) {
            window.showModalDialog("/xys/eva/Set360TempItemEdit.jsf?itemId="+id, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }

    </script>

<x:saveState value="#{xys_360TempBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_360TempBB.initItemList}"></h:inputHidden>
    <h:inputHidden id="setId" value="#{xys_360TempBB.setId}"></h:inputHidden>
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
    <h:dataTable value="#{xys_360TempBB.itemList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="指标名称"/></c:facet>
            <h:outputText value="#{list.itemName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="权重（%）"/></c:facet>
            <h:outputText value="#{list.weight}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="打分高限"/></c:facet>
            <h:outputText value="#{list.hiValue}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="打分低限"/></c:facet>
            <h:outputText value="#{list.lowValue}"/>
        </h:column>
       
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.itemId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" action="#{xys_360TempBB.deleteItem}" onclick="return confirm('确实要删除该指标吗？');" styleClass="button01">
                   <x:updateActionListener property="#{xys_360TempBB.itemId}" value="#{list.itemId}"/>
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
