<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
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

        function forSel4() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue4', 'form1:classvaluedes4', document.all("form1:classitem4").value,'');
            return false;
        }

        function forSel5() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue5', 'form1:classvaluedes5', document.all("form1:classitem5").value,'');
            return false;
        }

        function chkNull() {
            if (document.getElementById("form1:classitem").value == ""
                || document.getElementById("form1:classvalue").value == "") {
                alert("请选择相关项目！")
                return false;
            }
            else {
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

<x:saveState value="#{emp_OrgSumItemSetBB}" />
<h:form id="form1">
	<h:inputHidden value="#{emp_OrgSumItemSetBB.pageInit}" />
	<f:verbatim>
		<br>
		<table width="98%" height="97%" align="center" cellpadding="0" cellspacing="0">
			<tr height=8>
                <td align="center" width="25%" class=activetab><img src="/images/common/handtip.gif">&nbsp;<a href="modiRule.jsf?Init=true"><%=LanguageSupport.getResource("RYGL-2316","人数汇总设置")%> </a></td>
                <td align="center" width="25%" class=tab>&nbsp;<a href="modiAddRule.jsf?Init=true"><%=LanguageSupport.getResource("RYGL-2317","增加设置")%> </a></td>
                <td align="center" width="25%" class=tab>&nbsp;<a href="modiMinusRule.jsf?Init=true"><%=LanguageSupport.getResource("RYGL-2318","减少设置")%> </a></td>
                <td align="center" width="25%" class=tab>&nbsp;<a href="modiDieRule.jsf?InitDie=true"><%=LanguageSupport.getResource("RYGL-3001","离职死亡")%> </a></td>
			</tr>

            <tr>
                <td valign="top" colspan="4">
                   <div class="tabbody" height="100%" width="100%">
    </f:verbatim>
        <h:panelGrid width="98%" align="center" border="0" columns="1">
            <h:panelGrid align="left" width="95%" cellpadding="0" cellspacing="2"
                columns="2">
                <h:panelGroup>
                    <f:verbatim>
                        <%=LanguageSupport.getResource(	"RYGL-2319", "汇总项目")%>
                    </f:verbatim>
                    <h:selectOneMenu style="width:200px;" id="sumitem"
                        value="#{emp_OrgSumItemSetBB.itemid}">
                        <f:selectItems value="#{emp_OrgSumItemSetBB.sumItemList}" />
                    </h:selectOneMenu>
                    <h:selectBooleanCheckbox value="#{emp_OrgSumItemSetBB.excPart}"></h:selectBooleanCheckbox><h:outputText value="不计算兼职人员"></h:outputText>
                    <h:selectBooleanCheckbox value="#{emp_OrgSumItemSetBB.excReturn}"></h:selectBooleanCheckbox><h:outputText value="不计算返聘人员"></h:outputText>
                </h:panelGroup>

                <h:panelGrid align="right" width="100%" cellpadding="0"
                    cellspacing="2" columns="1">
                    <h:panelGroup>
                        <h:commandButton id="set" styleClass="button01" value=" 设置 "
                            onclick="if(chkNull())return true;else return false;"
                            action="#{emp_OrgSumItemSetBB.addItem}" />
                        <h:commandButton value=" 删除 " styleClass="button01"
                            onclick="if(checkIds(document.form1.Id)){return true;}else return false;"
                            action="#{emp_OrgSumItemSetBB.deleteItem}" />
                    </h:panelGroup>
                </h:panelGrid>
            </h:panelGrid>

            <h:panelGroup>
                <f:verbatim>
                    <strong><%=LanguageSupport.getResource("RYGL-2322","请定义分类条件")%>=></strong>
                      <%=LanguageSupport.getResource("RYGL-2323","分类项目")%>1
                    </f:verbatim>
                <h:selectOneMenu style="width:110px;" id="classitem"
                    value="#{emp_OrgSumItemSetBB.classFieldName}"
                    onclick="document.all('form1:classvalue').value='';document.all('form1:classvaluedes').value='';">
                    <f:selectItems value="#{emp_OrgSumItemSetBB.classItemList}" />
                </h:selectOneMenu>
                <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2324",
                                        "分类值")%>1
                    </f:verbatim>
                <h:inputText readonly="true" style="width:110px" id="classvaluedes" />
                <h:inputHidden id="classvalue"
                    value="#{emp_OrgSumItemSetBB.classValue}" />
                <h:commandButton id="select" type="button" styleClass="button01"
                    value="选择" onclick="forSel()" />
            </h:panelGroup>

            <h:panelGroup>
                <h:outputText escape="false" value="<strong>并且</strong> 分类项目2" />
                <h:selectOneMenu style="width:110px;" id="classitem2"
                    value="#{emp_OrgSumItemSetBB.classFieldName2}"
                    onclick="document.all('form1:classvalue2').value='';document.all('form1:classvaluedes2').value='';">
                    <f:selectItems value="#{emp_OrgSumItemSetBB.classItemList}" />
                </h:selectOneMenu>
                <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2324",
                                        "分类值")%>2
                 </f:verbatim>
                <h:inputText readonly="true" style="width:110px" id="classvaluedes2" />
                <h:inputHidden id="classvalue2"
                    value="#{emp_OrgSumItemSetBB.classValue2}" />
                <h:commandButton id="select2" type="button" styleClass="button01"
                    value="选择" onclick="forSel2()" />
            </h:panelGroup>

            <h:panelGroup>
                <h:outputText escape="false" value="<strong>并且</strong> 分类项目3" />
                <h:selectOneMenu style="width:110px;" id="classitem3"
                    value="#{emp_OrgSumItemSetBB.classFieldName3}"
                    onclick="document.all('form1:classvalue3').value='';document.all('form1:classvaluedes3').value='';">
                    <f:selectItems value="#{emp_OrgSumItemSetBB.classItemList}" />
                </h:selectOneMenu>
                <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2324","分类值")%>3
                 </f:verbatim>
                <h:inputText readonly="true" style="width:110px" id="classvaluedes3" />
                <h:inputHidden id="classvalue3"
                    value="#{emp_OrgSumItemSetBB.classValue3}" />
                <h:commandButton id="select3" type="button" styleClass="button01"
                    value="选择" onclick="forSel3()" />
            </h:panelGroup>

            <h:panelGroup>
                <h:outputText escape="false" value="<strong>并且</strong> 分类项目4" />
                <h:selectOneMenu style="width:110px;" id="classitem4"
                    value="#{emp_OrgSumItemSetBB.classFieldName4}"
                    onclick="document.all('form1:classvalue4').value='';document.all('form1:classvaluedes4').value='';">
                    <f:selectItems value="#{emp_OrgSumItemSetBB.classItemList}" />
                </h:selectOneMenu>
                <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2324","分类值")%>4
                 </f:verbatim>
                <h:inputText readonly="true" style="width:110px" id="classvaluedes4" />
                <h:inputHidden id="classvalue4"
                    value="#{emp_OrgSumItemSetBB.classValue4}" />
                <h:commandButton id="select4" type="button" styleClass="button01"
                    value="选择" onclick="forSel4()" />
            </h:panelGroup>

            <h:panelGroup>
                <h:outputText escape="false" value="<strong>并且</strong> 分类项目5" />
                <h:selectOneMenu style="width:110px;" id="classitem5"
                    value="#{emp_OrgSumItemSetBB.classFieldName5}"
                    onclick="document.all('form1:classvalue5').value='';document.all('form1:classvaluedes5').value='';">
                    <f:selectItems value="#{emp_OrgSumItemSetBB.classItemList}" />
                </h:selectOneMenu>
                <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2324","分类值")%>5
                 </f:verbatim>
                <h:inputText readonly="true" style="width:110px" id="classvaluedes5" />
                <h:inputHidden id="classvalue5"
                    value="#{emp_OrgSumItemSetBB.classValue5}" />
                <h:commandButton id="select5" type="button" styleClass="button01"
                    value="选择" onclick="forSel5()" />
            </h:panelGroup>

            <f:verbatim>
                <br>
            </f:verbatim>
            <h:dataTable styleClass="table03" align="center" width="95%"
                id="dateList" headerClass="td_top"
                columnClasses="td_middle_center,td_middle,td_middle"
                value="#{emp_OrgSumItemSetBB.itemBos}" var="list" border="1">
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
    <f:verbatim>
                   </div>
                </td>
            </tr>
        </table>

    </f:verbatim>



</h:form>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
     setDataTableOver("form1:dateList");
</script>
