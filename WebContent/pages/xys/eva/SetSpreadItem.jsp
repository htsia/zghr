<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
     function modify(id) {
            window.showModalDialog("/xys/eva/SetSpreadItemEdit.jsf?itemId="+id, null, "dialogWidth:"+screen.width*0.4+"px;dialogHeight:"+screen.height*0.3+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
     }
</script>
<x:saveState value="#{xys_SpreadMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_SpreadMgrBB.initItem}"></h:inputHidden>
     <h:inputHidden id="setId" value="#{xys_SpreadMgrBB.setId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{xys_SpreadMgrBB.itemList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="等级类型"/></c:facet>
            <h:outputText value="#{list.gradeName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="控制类型"/></c:facet>
            <h:selectOneMenu value="#{list.ctrType}" disabled="true">
            	<c:selectItem itemLabel="数目" itemValue="1"/>
            	<c:selectItem itemLabel="比例" itemValue="2"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="控制数/比例"/></c:facet>
            <h:outputText value="#{list.ctrCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="切换等级"/></c:facet>
            <h:outputText value="#{list.chgGradeItem}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改属性" onclick="return modify('#{list.itemId}');" styleClass="button01" rendered="#{xys_SpreadMgrBB.deptDesabled=='0'}"></h:commandButton>
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
