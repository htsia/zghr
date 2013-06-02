<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<script type="text/javascript">
	function addRpt() {
		window.showModalDialog("/custom/report/upFileEdit.jsf?act=init",null,"dialogWidth:470px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function editRpt(ID) {
		window.showModalDialog("/custom/report/upFileEdit.jsf?rptID="+ID,null,"dialogWidth:470px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}
</script>

<x:saveState value="#{uploadReportBB}" />
<h:form id="form1" enctype="multipart/form-data" >
<h:inputHidden value="#{uploadReportBB.pageInit}"></h:inputHidden>
 
  <h:panelGrid columns="1"  width="98%" align="center">
    <h:panelGrid columns="1"  styleClass="td_title" width="100%" cellpadding="4" align="center" border="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="报表上传"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="4" border="0" cellspacing="5" align="right">
    <h:panelGroup>
    	<h:outputText value="记录数:#{uploadReportBB.mypage.totalRecord}"></h:outputText>
		<h:outputText value="  "></h:outputText>
		<h:outputText value="页数:#{uploadReportBB.mypage.totalPage}"></h:outputText>
		<h:outputText value="  "></h:outputText>
		<h:outputText value="每页有#{uploadReportBB.mypage.pageSize}"></h:outputText>
		<h:outputText value="  "></h:outputText>
		<h:outputText
			value="当前为第#{uploadReportBB.mypage.currentPage}页"></h:outputText>

		<h:commandButton value="首页" action="#{uploadReportBB.first}"
			styleClass="button01"/>
		<h:commandButton value="上页" action="#{uploadReportBB.pre}"
			styleClass="button01"/>
		<h:commandButton value="下页" action="#{uploadReportBB.next}"
			styleClass="button01"/>
		<h:commandButton value="尾页" action="#{uploadReportBB.last}"
			styleClass="button01"/>
		<h:outputText value="  "/>
　　　　<h:commandButton value="上传报表" onclick="addRpt();" styleClass="button01"/>
	</h:panelGroup>
    </h:panelGrid>

    <h:dataTable value="#{uploadReportBB.list}" var="item"  id="dateList"
                 headerClass="td_top" width="100%" columnClasses="td_middle_center" align="center" border="1" styleClass="table03" >
		<h:column>
			<f:facet name="header">
			<h:outputText value="报表名称"/>
			</f:facet>
		<h:outputText value="#{item.name}" escape="false"/>
		</h:column>
		<h:column>
			<f:facet name="header">
			<h:outputText value="排序(倒叙)"/>
			</f:facet>
		<h:outputText value="#{item.sort}" escape="false"/>
		</h:column>
		<h:column>
			<f:facet name="header">
			<h:outputText value="操作"/>
			</f:facet>
		<h:commandButton styleClass="button01" value="修改" onclick="editRpt('#{item.ID}')"/>
		<h:commandButton styleClass="button01" value="删除" onclick="return confirm('确定删除吗');" action="#{item.delete}">
			<x:updateActionListener value="#{item.ID}" property="#{uploadReportBB.operID}"/>
		</h:commandButton>
		</h:column>
    </h:dataTable>
    </h:panelGrid>
</h:form>