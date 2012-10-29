<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
	<%
		Date d = new Date();
	%>
	function doAddItem() {
		window.showModalDialog("/custom/wage/wageDataOthersEdit.jsf",null,"dialogWidth:470px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function modifyset(itemID) {
		window.showModalDialog("/custom/wage/wageDataOthersEdit.jsf?itemID="+itemID,null,"dialogWidth:470px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function userset(itemID) {
		window.showModalDialog("/custom/wage/wageDataOthersUser.jsf?view=0&itemID="+itemID,null,"dialogWidth:1150px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function viewuser(itemID) {
		window.showModalDialog("/custom/wage/wageDataOthersUser.jsf?view=1&itemID="+itemID,null,"dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
	}

	function forsel(){
	    var item = document.getElementsByName("selectItem");
        var selId="";
        if(item.length>0){
            for(var i=0;i<item.length;i++){
                if(item[i].checked)
                {
                	selId+=item[i].value+",";    
                }
            }
        }
        if(selId==""){
        	alert("请选择项目");
        	return false;
        }
        document.all("form1:selectedItemIDs").value=selId;
        return true;
	}
	function selMonth(){
		if(forsel()){
			var month = window.showModalDialog("/pages/common/CalendarMonthOnly.jsp?month=<%=d.getMonth()%>",null,"dialogWidth:250px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
			if(month!=null){
				document.all("form1:yearmonth").value=month;
				return true;
			}
		}
		return false;
	}
</script>

<x:saveState value="#{wage_dataOthersBB}" />
<h:form id="form1">
	<h:inputHidden value="#{wage_dataOthersBB.pageInit}"/>
	<h:inputHidden id="yearmonth" value="#{wage_dataOthersBB.yearmonth}"/>
	<h:inputHidden id="selectedItemIDs" value="#{wage_dataOthersBB.selectedItemIDs}"/>
	<c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=20 class="td_title"><img src="/images/tips.gif">工资杂项</td>
        </tr>
    </table>
    </c:verbatim>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGroup>
			<h:panelGrid columns="1" align="left">
				<h:panelGroup>
					<h:commandButton value="增加" styleClass="button01" onclick="doAddItem();"/>
					<h:outputText value="  "/>
					<h:commandButton styleClass="button01" value="数据归档" onclick="return selMonth();"  action="#{wage_dataOthersBB.confirm}">					
						<x:updateActionListener property="#{wage_dataOthersBB.operSetID}" value="#{item.ID}" />
					</h:commandButton>
                 <h:outputText value="  "/>
				<h:outputText value="编辑中"/>
                 <h:selectBooleanCheckbox value="#{wage_dataOthersBB.notReview}" onclick="submit();" valueChangeListener="#{wage_dataOthersBB.haveReview}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "/>
                 <h:outputText value="归档结束"/>
                 <h:selectBooleanCheckbox value="#{wage_dataOthersBB.reviewed}" onclick="submit();" valueChangeListener="#{wage_dataOthersBB.haveReviewed}"></h:selectBooleanCheckbox>
				<h:panelGroup>
			</h:panelGroup>
				</h:panelGroup>
			</h:panelGrid>
			<h:panelGrid columns="1" align="right">
				<h:panelGroup>
					
					<h:outputText
						value="记录数:#{wage_dataOthersBB.mypage.totalRecord}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="页数:#{wage_dataOthersBB.mypage.totalPage}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="每页有#{wage_dataOthersBB.mypage.pageSize}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText
						value="当前为第#{wage_dataOthersBB.mypage.currentPage}页"></h:outputText>
		
					<h:commandButton value="首页" action="#{wage_dataOthersBB.first}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="上页" action="#{wage_dataOthersBB.pre}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="下页" action="#{wage_dataOthersBB.next}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="尾页" action="#{wage_dataOthersBB.last}"
						styleClass="button01"></h:commandButton>
				</h:panelGroup>
			</h:panelGrid>
		</h:panelGroup>

		<x:dataTable value="#{wage_dataOthersBB.setList}"
			headerClass="td_top" rowIndexVar="index" var="item" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
		        <f:facet name="header">
		            <f:verbatim escape="false">
		                <input type="checkbox" name="all"
		                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
		            </f:verbatim>
		        </f:facet>
		        <f:verbatim escape="false">
		            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim><h:outputText value="#{item.ID}"/><f:verbatim escape="false">"/></div></f:verbatim>
		    </h:column>				
			<h:column>
				<f:facet name="header">
					<h:outputText value="序号" />
				</f:facet>
				<h:outputText value="#{index+1}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="项目名称" />
				</f:facet>
				<h:outputText value="#{item.name}"></h:outputText>
			</h:column>
			<h:column >
				<f:facet name="header">
					<h:outputText value="项目适用月份" />
				</f:facet>
				<h:outputText value="#{item.beginDate}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="创建人" />
				</f:facet>
				<h:outputText value="#{item.createUserName}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="创建日期" />
				</f:facet>
				<h:outputText value="#{item.createDate}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="状态" />
				</f:facet>
				<h:outputText value="#{item.desc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" onclick="modifyset('#{item.ID}');" value="修改"
					rendered="#{item.status=='0'}"/>
				<h:commandButton styleClass="button01" onclick="userset('#{item.ID}');" value="人员设置"
					rendered="#{item.status=='0'}"/>
				<h:commandButton styleClass="button01" onclick="viewuser('#{item.ID}');" value="人员数据"
					rendered="#{item.status=='2'}"/>
				<h:commandButton styleClass="button01" onclick="return confirm('确定删除吗?');" value="删除"  action="#{wage_dataOthersBB.deleteSet}"
					rendered="#{item.status=='0'}">
					<x:updateActionListener property="#{wage_dataOthersBB.operSetID}" value="#{item.ID}" />				
				</h:commandButton>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
	setDataTableOver("form1:dateList");
</script>