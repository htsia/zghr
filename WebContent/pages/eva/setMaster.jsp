<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function addMaster(){
        var deptId=document.all('form1:superId').value;
        window.showModalDialog("/eva/addMaster.jsf?objectID="+document.all('form1:objectID').value+"&deptId="+deptId, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function selectPerson(){
    	var str=" |";
        chk=document.forms(0).selectItem;
        if (checkMutilSelect(chk)){
            var size = chk.length;
            if (size == null) {
                if (chk.checked) {
                    str+=chk.value;
                }
            } else {
                for (var i = 0; i < size; i++) {
                    if (chk[i].checked) {
                        if (i==0){
                            str+=chk[i].value;
                        }
                        else{
                            str+=","+chk[i].value;
                        }
                    }
                }
            }
           if(str != null && str!=""){
          	 var vars=str.split("|");
          	 document.all("form1:masterStr").value = vars[1];
          	 
            }
        }
    }
</script>
<x:saveState value="#{eva_objectBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{eva_objectBB.initmaster}"></h:inputHidden>
	<h:inputHidden id="objectID" value="#{eva_objectBB.objectID}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{eva_objectBB.orgId}"></h:inputHidden>
	<h:inputHidden id="masterStr" value="" />
	<c:verbatim>
		<table height=97% width=98% align="center">
			<tr>
				<td height=8></td>
			</tr>

			<tr>
				<td height=8 align="left"></c:verbatim> <h:outputText
					value="考核客体:#{eva_objectBB.objectvo.personName}"></h:outputText> <c:verbatim></td>
			</tr>

			<tr>
				<td height=8 align="right"></c:verbatim> <h:commandButton value="增加"
					styleClass="button01" onclick="return addMaster();"></h:commandButton>
				<h:outputText value=" "></h:outputText> <h:commandButton
					value="批量删除" styleClass="button01" onclick="selectPerson();"
					action="#{eva_objectBB.bathDelMaster}"></h:commandButton> <h:outputText
					value=" "></h:outputText> <h:outputText value="姓名或简称："></h:outputText>
				<h:inputText value="#{eva_objectBB.queryValue}"></h:inputText> <h:commandButton
					value="查询" styleClass="button01"
					action="#{eva_objectBB.queryMaster}"></h:commandButton> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> 
				<x:dataTable value="#{eva_objectBB.masterPersonList}" var="list" rowIndexVar="index"
					width="100%" id="dateList" styleClass="table03"
					headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
					<h:column>
						<f:facet name="header">
							<f:verbatim escape="false">
								<input type="checkbox" name="all"
									onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)" />
							</f:verbatim>
						</f:facet>
						<f:verbatim escape="false">
							<div align="center"><input type="checkbox"
								name="selectItem"
								value="</f:verbatim>
                        <h:outputText value="#{list.masterID}"/>
                        <f:verbatim escape="false">" />
							</div>
						</f:verbatim>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="序号" />
						</f:facet>
						<h:outputText value="#{index+1}"></h:outputText>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="姓名" />
						</f:facet>
						<h:outputText escape="false" value="#{list.personName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="部门" />
						</f:facet>
						<h:outputText escape="false" value="#{list.deptName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="权重(%)" />
						</f:facet>
						<h:outputText escape="false" value="#{list.purview}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="考核人员类别" />
						</f:facet>
						<h:outputText escape="false" value="#{list.masterType}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" />
						</f:facet>

						<h:commandButton value="删除" styleClass="button01"
							action="#{eva_objectBB.deleteMaster}">
							<x:updateActionListener property="#{eva_objectBB.masterID}"
								value="#{list.masterID}" />
						</h:commandButton>
					</h:column>

				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
