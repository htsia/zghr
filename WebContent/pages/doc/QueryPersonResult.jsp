<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
        function sel(code){
            window.returnValue = code ;
            window.close();
        }
</script>
<x:saveState value="#{doc_QueryPersonBackingBean}" />

<h:form id="form1">
	<h:inputHidden value="#{doc_QueryPersonBackingBean.pageInit}" />
        <c:verbatim>
        <table height=98% width=98% align="center">
        <tr><td height=8>
        </c:verbatim>
            <h:outputText value="��ѯ��Ա����б�:" 	style="width:100%" />
        <c:verbatim>
         </td></tr>

        <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
        </c:verbatim>
          <x:dataTable value="#{doc_QueryPersonBackingBean.resultList}"
			rowIndexVar="index" var="resultList" width="95%" border="0"   id="dateList"
			align="center"  styleClass="table03"   headerClass="td_top"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">

			<h:column>
				<f:facet name="header">
					<h:outputText value="" style="height:21" />
				</f:facet>
				<h:outputText value="#{index+1}"  style="height:1" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="����" style="	background-color: #F3F3F3;" />
				</f:facet>
				<h:outputText escape="false" value="#{resultList.name}" />
			</h:column>
            <h:column>
				<f:facet name="header">
					<h:outputText value="�Ա�" style="	background-color: #F3F3F3;" />
				</f:facet>
				<h:outputText escape="false" value="#{resultList.sex}" />
			</h:column>
             <h:column>
				<f:facet name="header">
					<h:outputText value="��������" style="	background-color: #F3F3F3;" />
				</f:facet>
				<h:outputText escape="false" value="#{resultList.birth}" />
			</h:column>
            <h:column>
				<f:facet name="header">
					<h:outputText value="��������" style="	background-color: #F3F3F3;"/>
				</f:facet>
				<h:outputText escape="false" value="#{resultList.orgId}" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="��������" style="	background-color: #F3F3F3;"/>
				</f:facet>
				<h:outputText escape="false" value="#{resultList.deptId}" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="����" style="background-color: #F3F3F3;" />
				</f:facet>

				<c:verbatim>
					<a class="aa"
						onclick="sel('</c:verbatim><h:outputText value="#{resultList.personId}"/><c:verbatim>')">ѡ��</a>
				</c:verbatim>
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
