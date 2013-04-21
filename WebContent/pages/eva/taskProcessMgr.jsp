<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function add(){
	    window.showModalDialog("/eva/addTaskProcess.jsf?itemId="+document.all("form1:itemId").value, "", "dialogWidth:400px; dialogHeight:250px; status:0;resizable:yes");
	    return true;
	}
	function modify(id){
	   window.showModalDialog("/eva/addTaskProcess.jsf?processId="+id, "", "dialogWidth:400px; dialogHeight:250px; status:0;resizable:yes");
	   return true;
	}
	function show(id){
		   window.open("/attence/showCalenda.jsf?PersonID="+id, "", "height="+screen.height*0.6+", width="+screen.width*0.6+", top=100,left=200, toolbar=no, menubar=no, location=no, status=no,resizable=yes,scrollbars=yes");
		   return true;
	}
</script>

<x:saveState value="#{taskprocessBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{taskprocessBB.pageInit}"/>
    <h:inputHidden id="itemId" value="#{taskprocessBB.itemId}"/>
 <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 绩效管理 ->任务考核过程管理"/>
          </h:panelGroup>
     </h:panelGrid>
   <c:verbatim>
   		</td>
   		<%
   		String personId=(String)session.getAttribute("personId");
   		%>
   		</tr><tr><td align="right" height=8>
   		<a href="#" onclick="show('<%=personId%>')">日程管理</a>&nbsp;&nbsp;
   </c:verbatim>
   			  <h:inputText value="#{taskprocessBB.selfscore}" size="10"></h:inputText>
   			  <h:commandButton value="自评分" styleClass="button01" action="#{taskprocessBB.saveSelfScore}"></h:commandButton>  
              <h:commandButton value="增加" onclick="return add();" styleClass="button01"></h:commandButton>
    <c:verbatim>
    &nbsp; &nbsp;
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:panelGrid columns="1" align="center" width="98%">
     
        <h:dataTable value="#{taskprocessBB.processList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03">
        <h:column>
            <c:facet name="header"><h:outputText value="报告日期"/></c:facet>
            <h:outputText value="#{list.reportDate}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="完成情况"/></c:facet>
            <h:outputText value="#{list.process}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="描述"/></c:facet>
            <h:outputText value="#{list.description}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="编辑" onclick="return modify('#{list.processId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{taskprocessBB.delete}" styleClass="button01">
                  <x:updateActionListener property="#{taskprocessBB.processId}" value="#{list.processId}"/>
            </h:commandButton>
        </h:column>

    </h:dataTable>
    </h:panelGrid>
 <c:verbatim>
	</div>
	</td></tr>
	</table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>