<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
          function inputScore(id){
        	 window.showModalDialog("/eva/InputDeptScore.jsf?objectID="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.8+"px;resizable:yes;status:yes;scroll:yes;");
        	 return false;
          }
    </script>

<x:saveState value="#{evaDeptSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaDeptSetBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{evaDeptSetBB.planId}"></h:inputHidden>
    <h:inputHidden id="orgId" value="#{evaDeptSetBB.orgId}"></h:inputHidden>
    <h:inputText id="deptIds" value="#{evaDeptSetBB.deptIds}" style="display:none;" code="" dict="yes" dict_num="OU"></h:inputText>
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> ��Ч����-> ���ſ��˴��</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
         
          <h:panelGrid align="right" columns="2">
          		
             	<h:panelGroup>
                <h:outputText value="��¼��:#{evaDeptSetBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{evaDeptSetBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{evaDeptSetBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{evaDeptSetBB.pagevo.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{evaDeptSetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaDeptSetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaDeptSetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{evaDeptSetBB.last}" styleClass="button01"></h:commandButton>
         </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{evaDeptSetBB.objectList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.orgName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ģ������"/></c:facet>
            <h:outputText value="#{list.templateName}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="���" onclick="inputScore('#{list.objectID}');" styleClass="button01" type="button"></h:commandButton>
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
