<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">

       function add() {
            window.showModalDialog("/xys/eva/Set360KeyEdit.jsf?libId="+document.all('form1:libId').value, null, "dialogWidth:"+screen.width*0.7+"px;dialogHeight:"+screen.height*0.7+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function modify(id) {
            window.showModalDialog("/xys/eva/Set360KeyEdit.jsf?keyId="+id, null, "dialogWidth:"+screen.width*0.7+"px;dialogHeight:"+screen.height*0.7+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }

    </script>

<x:saveState value="#{xys_360KeyBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_360KeyBB.initKeyList}"></h:inputHidden>
    <h:inputHidden id="libId" value="#{xys_360KeyBB.libId}"></h:inputHidden>
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
    <h:dataTable value="#{xys_360KeyBB.keyList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="指标名称"/></c:facet>
            <h:outputText value="#{list.keyName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="指标说明"/></c:facet>
            <h:inputTextarea value="#{list.keyDesc}" rows="8" cols="80" readonly="true"></h:inputTextarea>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="指标类型"/></c:facet>
            <h:outputText value="#{list.keyTypeDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.keyId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" action="#{xys_360KeyBB.deleteKey}" onclick="return confirm('确实要删除该指标吗？');" styleClass="button01">
                   <x:updateActionListener property="#{xys_360KeyBB.keyId}" value="#{list.keyId}"/>
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
