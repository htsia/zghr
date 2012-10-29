<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>


<script language="javascript">
        function forSel() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:classitem").value,'');
            return false;
        }
        function forSel2() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue2', 'form1:classvaluedes2', document.all("form1:classitem2").value,'');
            return false;
        }

        function forSel3() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue3', 'form1:classvaluedes3', document.all("form1:classitem3").value,'');
            return false;
        }


        function chkNull() {
            if (document.getElementById("form1:sumitem").value == "" ){
                alert("请选择相关汇总项目！")
                return false;
            }
            else {
                document.all("form1:sumType").value="0";
                return true;
            }
        }
        function checkIds(persId) {
            if (checkMutilSelect(persId)) {
                if (confirm('确定要删除所选项目吗？'))
                {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择项目！")
                return false;
            }
        }
    </script>

<x:saveState value="#{cont_staticBB}" />
<h:form id="form1">
	<h:inputHidden value="#{cont_staticBB.initRule}" />
    <h:inputHidden id="sumType" value="#{cont_staticBB.sumType}"></h:inputHidden>
    <f:verbatim>
		<br>
		<table width="96%" align="center">
			<tr>
                <td align="center" width="25%" class=activetab><a href="modiRule.jsf?Init=true">签订合同人数</a></td>
                <td align="center" width="25%" class=tab><a href="modiAddRule.jsf?Init=true">续订合同人数</a></td>
                <td align="center" width="25%" class=tab><a href="modiEndRule.jsf?Init=true">终止合同人数</a></td>
                <td align="center" width="25%" class=tab><a href="modiTerminateRule.jsf?Init=true">解除合同人数</a></td>
            </tr>
		</table>
	</f:verbatim>

	<h:panelGrid width="98%" align="center" border="0" columns="1">
		<h:panelGrid align="left" width="95%" cellpadding="0" cellspacing="2"
			columns="2">
			<h:panelGroup>
				<f:verbatim>
					汇总项目
				</f:verbatim>
				<h:selectOneMenu style="width:200px;" id="sumitem"
					value="#{cont_staticBB.itemid}">
					<f:selectItems value="#{cont_staticBB.sumItemList}" />
				</h:selectOneMenu>

			</h:panelGroup>

			<h:panelGrid align="right" width="100%" cellpadding="0"
				cellspacing="2" columns="1">
				<h:panelGroup>
					<h:commandButton id="set" styleClass="button01" value=" 设置 "
						onclick="if(chkNull())return true;else return false;"
						action="#{cont_staticBB.addItem}" />
					<h:commandButton value=" 删除 " styleClass="button01"
						onclick="if(checkIds(document.form1.Id)){return true;}else return false;"
						action="#{cont_staticBB.deleteItem}" />
				</h:panelGroup>
			</h:panelGrid>
		</h:panelGrid>

		<h:panelGroup>
			<f:verbatim>
				<strong>请定义分类条件=></strong>
                  分类项目1
                </f:verbatim>
			<h:selectOneMenu style="width:110px;" id="classitem"
				value="#{cont_staticBB.classFieldName}"
				onclick="document.all('form1:classvalue').value='';document.all('form1:classvaluedes').value='';">
				<f:selectItems value="#{cont_staticBB.classItemList}" />
			</h:selectOneMenu>
			<f:verbatim>
				分类值1
            </f:verbatim>
			<h:inputText readonly="true" style="width:110px" id="classvaluedes" />
			<h:inputHidden id="classvalue"
				value="#{cont_staticBB.classValue}" />
			<h:commandButton id="select" type="button" styleClass="button01"
				value="选择" onclick="forSel()" />
		</h:panelGroup>

		<h:panelGroup>
			<h:outputText escape="false" value="<strong>并且</strong> 分类项目2" />
			<h:selectOneMenu style="width:110px;" id="classitem2"
				value="#{cont_staticBB.classFieldName2}"
				onclick="document.all('form1:classvalue2').value='';document.all('form1:classvaluedes2').value='';">
				<f:selectItems value="#{cont_staticBB.classItemList}" />
			</h:selectOneMenu>
			<f:verbatim>
			      分类值2
             </f:verbatim>
			<h:inputText readonly="true" style="width:110px" id="classvaluedes2" />
			<h:inputHidden id="classvalue2"
				value="#{cont_staticBB.classValue2}" />
			<h:commandButton id="select2" type="button" styleClass="button01"
				value="选择" onclick="forSel2()" />
		</h:panelGroup>

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>并且</strong> 分类项目3" />
            <h:selectOneMenu style="width:110px;" id="classitem3"
                value="#{cont_staticBB.classFieldName3}"
                onclick="document.all('form1:classvalue3').value='';document.all('form1:classvaluedes3').value='';">
                <f:selectItems value="#{cont_staticBB.classItemList}" />
            </h:selectOneMenu>
            <f:verbatim>
                分类值3
             </f:verbatim>
            <h:inputText readonly="true" style="width:110px" id="classvaluedes3" />
            <h:inputHidden id="classvalue3"
                value="#{cont_staticBB.classValue3}" />
            <h:commandButton id="select3" type="button" styleClass="button01"
                value="选择" onclick="forSel3()" />
        </h:panelGroup>

		<f:verbatim>
			<br>
		</f:verbatim>
		<h:dataTable styleClass="table03" align="center" width="95%"
			id="dateList" headerClass="td_top"
			columnClasses="td_middle_center,td_middle,td_middle"
			value="#{cont_staticBB.itemBos}" var="list" border="1">
			<h:column>
				<f:facet name="header">
					<f:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll,document.form1.Id)" />
					</f:verbatim>
				</f:facet>
				<f:verbatim escape="false">
					<input type="checkbox" name="Id"
						value="</f:verbatim><h:outputText value="#{list.itemId}"/><f:verbatim>">
				</f:verbatim>
			</h:column>
			<h:column>
				<f:facet name="header">
				     <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2319","汇总项目")%> 
             </f:verbatim>
				</f:facet>
				<h:outputText value="#{list.itemName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
				     <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2321","汇总方式")%>
             </f:verbatim>
				</f:facet>
				<h:outputText value="#{list.description}" />
			</h:column>
		</h:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
     setDataTableOver("form1:dateList");
</script>
