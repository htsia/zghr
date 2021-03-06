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
		String inself=request.getParameter("inself");
	%>
	function doAddItem() {
		window.showModalDialog("/custom/wage/wageDataOtherEdit.jsf?itemType="+document.all("form1:itemType").value+"&inself="+document.all("form1:inself").value,null,"dialogWidth:470px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function modifyset(itemID,itemType) {
		window.showModalDialog("/custom/wage/wageDataOtherEdit.jsf?itemID="+itemID+"&itemType="+itemType,null,"dialogWidth:470px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function userset(itemID) {
		window.showModalDialog("/custom/wage/wageDataOtherUser.jsf?view=0&itemType="+document.all("form1:itemType").value+"&itemID="+itemID+"&inself="+document.all("form1:inself").value,null,"dialogWidth:1150px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function viewuser(itemID) {
		window.showModalDialog("/custom/wage/wageDataOtherUser.jsf?view=1&itemID="+itemID,null,"dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
	}

	function selMonth(){
		var yearmonth = document.all("form1:operYearMonth").value;
        if(yearmonth==""){
        	alert("请选择归档日期");
        	return false;
        }
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
</script>
<x:saveState value="#{wage_dataOtherBB}" />
<h:form id="form1">
	<h:inputHidden value="#{wage_dataOtherBB.pageInit}"/>
	<h:inputHidden id="inself" value="#{wage_dataOtherBB.inself}"/>
	<h:inputHidden id="itemType" value="#{wage_dataOtherBB.itemType}"/>
	<h:inputHidden id="selectedItemIDs" value="#{wage_dataOtherBB.selectedItemIDs}"/>
	<f:verbatim>
    <table height=100% width=100% align="center">
        <tr>
            <td height="1" class="td_title"><img src="/images/tips.gif">
			</f:verbatim>
				<h:outputText value="#{wage_dataOtherBB.itemName}"/>
				<f:verbatim>
					<span style="color:red;font-weight:bold;padding-left:20px;">总金额:
					</f:verbatim>
					<h:outputText value="#{wage_dataOtherBB.totalMoney}"/>
					<f:verbatim>
					元
					</span>
				</f:verbatim>
			<f:verbatim>  
            </td>
        </tr>
        <tr><td height="1">
    </f:verbatim>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton value="增加" styleClass="button01" onclick="doAddItem();"/>
				<h:outputText value=" 归档日期"/>
				<h:inputText id="operYearMonth" readonly="true" size="10" styleClass="input Wdate" value="#{wage_dataOtherBB.operYearMonth}" onclick="WdatePicker({startDate:'%y-%M',dateFmt:'yyyy-MM',el:'form1:operYearMonth'})"/>
				<h:commandButton value="数据归档" styleClass="button01" onclick="return selMonth();" action="#{wage_dataOtherBB.updateWageOther1}"/>
				<h:outputText value="  " />				
				<h:outputText value="编辑中" />
                <h:selectBooleanCheckbox value="#{wage_dataOtherBB.editting}" onclick="submit();" valueChangeListener="#{wage_dataOtherBB.setEditting}"/>					
				
				<h:outputText value="分发中" rendered="#{(wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4') && wage_dataOtherBB.inself!='1'}"/>
				<h:outputText value="审核中" rendered="#{wage_dataOtherBB.inself=='1'}"/>
				<h:outputText value="归档中" rendered="#{(wage_dataOtherBB.itemType=='3' || wage_dataOtherBB.itemType=='5') && wage_dataOtherBB.inself!='1'}"></h:outputText>
                <h:selectBooleanCheckbox value="#{wage_dataOtherBB.issueing}" onclick="submit();" valueChangeListener="#{wage_dataOtherBB.setIssueing}"/>	
				
				<h:outputText value="分发结束" rendered="#{(wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4') && wage_dataOtherBB.inself!='1'}"/>
				<h:outputText value="审核结束" rendered="#{wage_dataOtherBB.inself=='1'}"/>
				<h:outputText value="归档结束" rendered="#{(wage_dataOtherBB.itemType=='3' || wage_dataOtherBB.itemType=='5') && wage_dataOtherBB.inself!='1'}"></h:outputText>
                <h:selectBooleanCheckbox value="#{wage_dataOtherBB.includeEnd}" onclick="submit();" valueChangeListener="#{wage_dataOtherBB.setIncludeEnd}"/>					
				
				<h:outputText value="  "/>
				<h:outputText value="创建日期从"/>
				<h:inputText id="beginDate" value="#{wage_dataOtherBB.beginDate}" styleClass="input Wdate" size="10" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:beginDate'})"/>
				<h:outputText value="至"/>
				<h:inputText id="endDate" value="#{wage_dataOtherBB.endDate}" styleClass="input Wdate" size="10" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:endDate'})"/>
				<h:commandButton action="#{wage_dataOtherBB.queryWageSet}" styleClass="button01" value="查询 "/>
				<h:outputText value="  "/>
				<h:outputText
					value="记录数:#{wage_dataOtherBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="页数:#{wage_dataOtherBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="每页有#{wage_dataOtherBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="当前为第#{wage_dataOtherBB.mypage.currentPage}页"></h:outputText>
	
				<h:commandButton value="首页" action="#{wage_dataOtherBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{wage_dataOtherBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{wage_dataOtherBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{wage_dataOtherBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
	<f:verbatim>
		</td></tr><tr><td><div style='width:100%;height:98%;overflow:auto' id=datatable>
	</f:verbatim>
		<x:dataTable value="#{wage_dataOtherBB.setList}" align="center"
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
			<h:column>
				<f:facet name="header">
					<h:outputText value="总金额" />
				</f:facet>
				<h:outputText value="#{item.totalmoney}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="适用日期" />
				</f:facet>
				<h:outputText value="#{item.applyDate}"></h:outputText>
			</h:column>
			<h:column rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}">
				<f:facet name="header">
					<h:outputText value="最后归档月份" />
				</f:facet>
				<h:outputText value="#{item.usedMonth}"></h:outputText>
			</h:column>
			<h:column rendered="#{wage_dataOtherBB.itemType=='1' || wage_dataOtherBB.itemType=='2' || wage_dataOtherBB.itemType=='4'}">
				<f:facet name="header">
					<h:outputText value="已分摊总额" />
				</f:facet>
				<h:outputText value="#{item.usedMoney}"></h:outputText>
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
				<h:outputText value="#{item.statusDesc}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" onclick="modifyset('#{item.ID}','#{item.itemType}');" value="修改"/>
				<h:commandButton styleClass="button01" onclick="userset('#{item.ID}');" value="人员设置"/>
				<h:commandButton styleClass="button01" onclick="return confirm('确定删除吗?');" value="删除"  action="#{wage_dataOtherBB.deleteSet}">
					<x:updateActionListener property="#{wage_dataOtherBB.operSetID}" value="#{item.ID}" />				
				</h:commandButton>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			</div></td></tr></table>
		</f:verbatim>
	
</h:form>
<script type="text/javascript" language="javascript">
	setDataTableOver("form1:dateList");
</script>