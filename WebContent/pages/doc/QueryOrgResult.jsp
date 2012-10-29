<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<f:verbatim>
	<link rel="stylesheet" type="text/css" 		href="<%=request.getContextPath()%>/css/style.css" />
	<style>
	a.aa{COLOR:BLUE; TEXT-DECORATION: none; Cursor:hand} 
	a.bb{COLOR:#FF0000; TEXT-DECORATION: underline; Cursor:hand} 
	.td_middle_y1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #333333;
	background-color: #FFFFFF;
	padding: 2px;
	border-right: 1px #DDDDDD solid;
	border-bottom: 1px #DDDDDD solid;
	height: 33px;
}
.td_middle_y2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #333333;
	background-color: #FFFFFF;
	padding: 2px;
	border-right: 1px #DDDDDD solid;
	border-bottom: 1px #DDDDDD solid;
	height: 33px;
}
</style>

	<script language="javascript"
		src="<%=request.getContextPath()%>/js/check.js"></script>
	<script language="javascript"
		src="<%=request.getContextPath()%>/js/checkAll.js"></script>
	<script language="javascript"
		src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</f:verbatim>
<script type="text/javascript">

        function sel(code){
         window.returnValue = code ;
            window.close();
        }
    </script>
<x:saveState value="#{doc_QueryBackingBean}" />

<h:form id="form1">
	<h:panelGrid width="90%" columns="1" align="center">
		<f:verbatim>
			<br>
		</f:verbatim>
		<h:outputText value="030101 | 查询人员结果列表" 	style="width:100%" />

		<f:verbatim>
			<HR color="#6392C6" noShade width="99%" align="center">
		</f:verbatim>
		<h:outputText escape="false"
			value="模糊查询:*#{doc_QueryBackingBean.postName}*>>>>>>列表如下："
			 style="width:100%" />
		<f:verbatim>
			<br>
		</f:verbatim>
		<x:dataTable value="#{doc_QueryBackingBean.postResultList}"
			rowIndexVar="index" var="resultList" width="95%" border="1"
			align="center" rowClasses="td_middle_y1,td_middle_y2"
			columnClasses="center,left,left,left,left">

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
				<h:outputText escape="false" value="#{resultList.orgId}" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="所属部门" style="	background-color: #F3F3F3;"/>
				</f:facet>
				<h:outputText escape="false" value="#{resultList.postClass}" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" style="background-color: #F3F3F3;" />
				</f:facet>

				<c:verbatim>
					<a class="aa"
						onclick="sel('</c:verbatim><h:outputText value="#{resultList.postId}"/><c:verbatim>')">选择</a>
				</c:verbatim>


			</h:column>

		</x:dataTable>

		<f:verbatim>
			<br>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
