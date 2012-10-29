<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
        function sel(code){
             window.returnValue = code ;
             window.close();
        }
</script>

<x:saveState value="#{doc_QueryBackingBean}" />
<h:form id="form1">
	<h:inputHidden value="#{doc_QueryBackingBean.postName}" />
    <f:verbatim>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF" >
            <tr>
                <td class=td_title>
    </f:verbatim>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="查询岗位结果列表" />
    <f:verbatim>
                </td>
            </tr>

            <tr><td height=10></td></tr>

            <tr>
                <td>
                <div style='width:100%;height:100%;overflow:auto' id=datatable>
   </f:verbatim>
        <x:dataTable value="#{doc_QueryBackingBean.postResultList}" styleClass="table03"
			rowIndexVar="index" var="resultList" width="98%" border="0"  headerClass="td_top tr_fixrow"
			align="center"  id="dateList"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">

			<h:column>
				<f:facet name="header">
					<h:outputText value="" style="height:21" />
				</f:facet>
				<h:outputText value="#{index+1}"  style="height:1" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="岗位名" style="	background-color: #F3F3F3;" />
				</f:facet>
				<h:outputText escape="false" value="#{resultList.name}" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="岗位分类" style="	background-color: #F3F3F3;"/>
				</f:facet>
				<h:outputText escape="false" value="#{resultList.postClass}" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="所属部门" style="	background-color: #F3F3F3;"/>
				</f:facet>
				<h:outputText escape="false" value="#{resultList.orgId}" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" style="background-color: #F3F3F3;" />
				</f:facet>

				<c:verbatim>
					<a class="aa"	onclick="sel('</c:verbatim><h:outputText value="#{resultList.postId}"/><c:verbatim>')">选择</a>
				</c:verbatim>
			</h:column>

		</x:dataTable>
   <f:verbatim>
                </div>
                </td>
            </tr>
    </table>
    </f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>