<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
     function keySet(id) {
            window.showModalDialog("/xys/eva/ScoreCtrEdit.jsf?ctrId="+id, null, "dialogWidth:"+screen.width*0.4+"px;dialogHeight:"+screen.height*0.3+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
     }
</script>
<x:saveState value="#{xys_scoreCtrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_scoreCtrBB.pageInit}"></h:inputHidden>
     <h:inputHidden id="planId" value="#{xys_scoreCtrBB.planId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8>
    
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{xys_scoreCtrBB.ctrList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="等级类型"/></c:facet>
            <h:outputText value="#{list.gradeItem}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="控制比例（%）"/></c:facet>
            <h:outputText value="#{list.count}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
             <h:commandButton value="控制比例" onclick="return keySet('#{list.ctrId}')" styleClass="button01"></h:commandButton>
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
