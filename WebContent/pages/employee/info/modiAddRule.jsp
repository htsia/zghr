<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

    
    <script language="javascript">
        function forSelFilter() {
            PopUpMutilCodeDlgNoSubmit('form1:classFilterValue', 'form1:classFilterDes', document.all("form1:classitem").value,'');
            return false;
        }

        function forSel() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', '0200','0200110001');
            return false;
        }

        function chkNull() {
            if (document.getElementById("form1:classvalue").value == "") {
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

<x:saveState value="#{emp_OrgSumItemSetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_OrgSumItemSetBB.pageInit}"/>
    <f:verbatim><br>
        <table width="96%" height="97%" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center" width="25%" class=tab>&nbsp;<a href="modiRule.jsf?Init=true"><%=LanguageSupport.getResource("RYGL-2316","人数汇总设置")%> </a></td>
                <td align="center" width="25%" class=activetab><img src="/images/common/handtip.gif">&nbsp;<a href="modiAddRule.jsf?Init=true"><%=LanguageSupport.getResource("RYGL-2317","增加设置")%> </a></td>
                <td align="center" width="25%" class=tab>&nbsp;<a href="modiMinusRule.jsf?Init=true"><%=LanguageSupport.getResource("RYGL-2318","减少设置")%> </a></td>
                <td align="center" width="25%" class=tab>&nbsp;<a href="modiDieRule.jsf?InitDie=true"><%=LanguageSupport.getResource("RYGL-3001","离职死亡")%> </a></td>
            </tr>
        <tr>
            <td valign="top" colspan="4">
               <div class="tabbody" height="100%" width="100%">
    </f:verbatim>
    <h:panelGrid width="98%" align="center"  border="0"   columns="1">
        <h:panelGrid align="left" width="95%" cellpadding="0" cellspacing="2" columns="2">
            <h:panelGroup>
                <f:verbatim>
                 <%=LanguageSupport.getResource("RYGL-2319","汇总项目")%>
                </f:verbatim>
                <h:selectOneMenu style="width:200px;" id="sumitem" value="#{emp_OrgSumItemSetBB.itemid}">
                    <f:selectItems value="#{emp_OrgSumItemSetBB.sumItemList}"/>
                </h:selectOneMenu>
            </h:panelGroup>

            <h:panelGrid align="right" width="100%" cellpadding="0" cellspacing="2" columns="1">
               <h:panelGroup>
                <h:commandButton id="set" styleClass="button01" value=" 设置 "
                                 onclick="if(chkNull())return true;else return false;"
                                 action="#{emp_OrgSumItemSetBB.addAddItem}"/>
                <h:commandButton value=" 删除 " styleClass="button01"
                                 onclick="if(checkIds(document.form1.Id)){return true;}else return false;"
                                 action="#{emp_OrgSumItemSetBB.deleteItem}" />
              </h:panelGroup>
            </h:panelGrid>

       </h:panelGrid>

        <h:panelGrid align="left" width="95%" cellpadding="0" cellspacing="2" columns="2">
            <h:panelGroup>
             <f:verbatim>
                 <%=LanguageSupport.getResource("RYGL-2320","选择分类代码")%>
                </f:verbatim>
             <h:commandButton id="select" type="button" styleClass="button01" value="选择"  onclick="forSel()"/>
           </h:panelGroup>

            <h:panelGroup>
             <h:inputTextarea readonly="true"  rows="5" cols="90" id="classvaluedes"/>
             <h:inputHidden id="classvalue" value="#{emp_OrgSumItemSetBB.classValue}"/>
           </h:panelGroup>
       </h:panelGrid>

        <h:panelGroup>
            <f:verbatim>
                  过滤项目
            </f:verbatim>
            <h:selectOneMenu style="width:110px;" id="classitem"
                value="#{emp_OrgSumItemSetBB.classFieldName2}"
                onclick="document.all('form1:classFilterValue').value='';document.all('form1:classFilterDes').value='';">
                <f:selectItems value="#{emp_OrgSumItemSetBB.classItemList}" />
            </h:selectOneMenu>
            <f:verbatim>
                  过滤值
            </f:verbatim>
            <h:inputText readonly="true" style="width:110px" id="classFilterDes" />
            <h:inputHidden id="classFilterValue"
                value="#{emp_OrgSumItemSetBB.classValue2}" />
            <h:commandButton id="selectFilter" type="button" styleClass="button01"
                value="选择" onclick="forSelFilter()" />
        </h:panelGroup>


    <f:verbatim><br></f:verbatim>
        <h:dataTable styleClass="table03" align="center" width="95%" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle"
                     value="#{emp_OrgSumItemSetBB.additemBos}"
                     var="list" border="1">
            <h:column>
                <f:facet name="header">
                    <f:verbatim escape="false">
                        <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.Id)"/>
                    </f:verbatim>
                </f:facet>
                <f:verbatim escape="false">
                    <input type="checkbox" name="Id" value="</f:verbatim><h:outputText value="#{list.itemId}"/><f:verbatim>">
                </f:verbatim>
            </h:column>

            <h:column>
                <f:facet name="header">
                <f:verbatim>
                 <%=LanguageSupport.getResource("RYGL-2319","汇总项目")%>
                </f:verbatim>
                </f:facet>
                <h:outputText value="#{list.itemName}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                  <f:verbatim>
                 <%=LanguageSupport.getResource("RYGL-2321","汇总方式")%>
                </f:verbatim>
                </f:facet>
                <h:outputText value="#{list.description}"/>
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
