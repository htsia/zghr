<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
    function doCheck(){
        if (checkMutilSelect('selected_ids')){
            disPlayProcessBar();
            return true;
        }
        else{
            alert("请选择项目!")
            return false;
        }
    }
</script>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<x:saveState value="#{ins_OpenYearBaseInfoListBB}" />
<h:form id="form1">
	<h:inputHidden id="superID"
		value="#{ins_OpenYearBaseInfoListBB.pageInit}"></h:inputHidden>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="9" align="left">
			<h:outputText value="业务时间:"></h:outputText>
			<h:outputText value="#{ins_OpenYearBaseInfoListBB.timeValues}"></h:outputText>
			<h:outputText value="   "></h:outputText>
			<h:outputText value="   "></h:outputText>
			<h:commandButton styleClass="button01" value="增加 "
				onclick="return doCheck();"
				action="#{ins_OpenYearBaseInfoListBB.addBatch}" />
			<h:commandButton styleClass="button01" value="取消"
				onclick="window.close();" />
		</h:panelGrid>
		<x:dataTable value="#{ins_OpenYearBaseInfoListBB.itemList}"
			id="dateList" headerClass="td_top" rowIndexVar="index" var="list"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
			<h:column>
				<c:facet name="header">
					<c:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);"/>
					</c:verbatim>
				</c:facet>
				<c:verbatim escape="false">
					<input type="checkbox" name="selected_ids"
						value="</c:verbatim>
                  <h:outputText value="#{list.setId}"/>
                  <c:verbatim>">
				</c:verbatim>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="参数子集" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.setName}" />
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>





