<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<f:verbatim>
    <script type="text/javascript">
       
        function add(){
        	window.showModalDialog("/eva/addElectionSet.jsf?planId="+document.all("form1:planId").value, "", "dialogWidth:400px; dialogHeight:300px; status:0;resizable:yes");
   	     	return true;
        }

        function modify(id){
        	window.showModalDialog("/eva/addElectionSet.jsf?setId="+id, "", "dialogWidth:400px; dialogHeight:300px; status:0;resizable:yes");
   	     	return true;
        }
        
    </script>
</f:verbatim>
<x:saveState value="#{eva_selectioncaclBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_selectioncaclBB.pageInit}"/>
	<h:inputHidden id="planId" value="#{eva_selectioncaclBB.planId}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 ->投票计算设置"/>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="1" align="center" width="98%">
    	 <h:panelGrid columns="1" align="right" >
		<h:commandButton value="增加"  styleClass="button01" onclick="add()"></h:commandButton>
		</h:panelGrid>
        <h:dataTable value="#{eva_selectioncaclBB.setItemList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03"  >
        <h:column>
            <c:facet name="header"><h:outputText value="结果名称"/></c:facet>
            <h:outputText value="#{list.setName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="统计项"/></c:facet>
            <h:outputText value="#{list.gradeItemsDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="是否计算"/></c:facet>
            <h:outputText value="#{list.caclDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="是否当前结果"/></c:facet>
            <h:outputText value="#{list.selDes}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="计算"  styleClass="button01" action="#{eva_selectioncaclBB.calc}" >
               <x:updateActionListener property="#{eva_selectioncaclBB.setId}" value="#{list.setId}"/>
            </h:commandButton>
            <h:commandButton value="设为当前结果"  styleClass="button01" action="#{eva_selectioncaclBB.setResult}" rendered="#{list.isCacl=='1'}">
               <x:updateActionListener property="#{eva_selectioncaclBB.setId}" value="#{list.setId}"/>
            </h:commandButton>
            <h:commandButton value="修改"  styleClass="button01" onclick="modify('#{list.setId}')"></h:commandButton>
 			<h:commandButton value="删除"  styleClass="button01" action="#{eva_selectioncaclBB.delete}">
               <x:updateActionListener property="#{eva_selectioncaclBB.setId}" value="#{list.setId}"/>
            </h:commandButton>
 
        </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>