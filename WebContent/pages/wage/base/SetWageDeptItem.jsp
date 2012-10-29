<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>


<script language="javascript">
        function chkNull() {
            if (document.getElementById("form1:method").value == "1") {
                if (document.getElementById("form1:wageitem").value == ""){
                    alert("请选择薪资项目！")
                    return false;
                }
            }
            if (document.getElementById("form1:conditionitem2").value!="" && document.getElementById("form1:conditionitem").value==""){
                alert("请先使用第一个条件！")
                return false;
            }
            if (document.getElementById("form1:item").value == "") {
                alert("请选择薪资部门汇总项目！")
                return false;
            }
            else if(document.all("form1:method").value=="") {
                alert("请选择汇总方法！")
                return false;
            }
            else {
                pageCodeExchange(form1);
                return true
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

<x:saveState value="#{wage_deptSumBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_deptSumBB.pageInit}"/>
    <h:inputHidden value="#{wage_deptSumBB.setID}"/>
    <f:verbatim>
    <table height=98% width=98% align="center">
        <tr><td height=8px>
    </f:verbatim>
            <h:panelGrid  width="100%" columns="2" styleClass="td_title" align="center">
                <h:panelGroup>
                    <h:outputText value="薪资账套：#{wage_deptSumBB.setName}"></h:outputText>
                    <h:outputText value="   "></h:outputText>
                    <h:selectBooleanCheckbox id="orderByName" value="#{wage_deptSumBB.orderByName}" onclick="submit();"  valueChangeListener="#{wage_deptSumBB.outputByName}" ></h:selectBooleanCheckbox>
                    <h:outputText value="按项目名称排序"></h:outputText>
                </h:panelGroup>

                <h:panelGrid align="right" columns="2">
                    <h:commandButton id="set" styleClass="button01" value="设置"
                                     onclick="if(chkNull())return true;else return false;"
                                     action="#{wage_deptSumBB.addWageDeptItem}"/>
                    <h:commandButton value=" 删除 " styleClass="button01"
                                     onclick="if(checkIds(document.form1.Id)){pageCodeExchange(form1);return true;}else return false;"
                                     action="#{wage_deptSumBB.deleteItem}">
                    </h:commandButton>
               </h:panelGrid>
            </h:panelGrid>
<f:verbatim>
        </td></tr>

        <tr><td height=8px>
</f:verbatim>
           <h:panelGrid width="98%" align="center"  border="0"   columns="1">
           <h:panelGroup>
                <h:outputText value="薪资项目："/>
                <h:selectOneMenu style="width:120px;" id="wageitem" value="#{wage_deptSumBB.wibo.fieldID}">
                    <f:selectItems value="#{wage_deptSumBB.wageItemList}"/>
                </h:selectOneMenu>

                <c:verbatim>&nbsp;&nbsp;</c:verbatim>

                <h:outputText value="薪资部门汇总项目 "/>
                <h:selectOneMenu style="width:120px;" id="item" value="#{wage_deptSumBB.wibo.sumFieldID}">
                    <f:selectItems value="#{wage_deptSumBB.wageDeptItemList}"/>
                </h:selectOneMenu>

                <h:outputText value="汇总方法"/>
                <h:selectOneMenu style="width:120px;" id="method" value="#{wage_deptSumBB.wibo.operateType}">
                    <f:selectItem itemValue="" itemLabel="--请选择--"/>
                    <f:selectItem itemValue="0" itemLabel="计数"/>
                    <f:selectItem itemValue="1" itemLabel="求和"/>
                </h:selectOneMenu>
              </h:panelGroup>

            <h:panelGroup>
                <h:outputText value="汇总条件设置:"/>
                <h:selectOneMenu style="width:120px;" id="conditionitem" value="#{wage_deptSumBB.wibo.classFieldID}">
                    <f:selectItems value="#{wage_deptSumBB.wageItemList}"/>
                </h:selectOneMenu>

                <h:selectOneMenu style="width:80px;" id="conditionoper" value="#{wage_deptSumBB.wibo.classFieldOperate}">
                    <c:selectItem itemValue="-1" itemLabel="比较符"></c:selectItem>
                    <c:selectItem itemValue="=" itemLabel="等于"></c:selectItem>
                    <c:selectItem itemValue=">" itemLabel="大于"></c:selectItem>
                    <c:selectItem itemValue=">=" itemLabel="大于等于"></c:selectItem>
                    <c:selectItem itemValue="<" itemLabel="小于"></c:selectItem>
                    <c:selectItem itemValue="<=" itemLabel="小于等于"></c:selectItem>
                    <c:selectItem itemValue="<>" itemLabel="不等于"></c:selectItem>
                </h:selectOneMenu>
                <h:inputText value="#{wage_deptSumBB.wibo.classFieldValue}"></h:inputText>
           </h:panelGroup>

                <h:panelGroup>
                    <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;并且:"/>
                    <h:selectOneMenu style="width:120px;" id="conditionitem2" value="#{wage_deptSumBB.wibo.classFieldID2}">
                        <f:selectItems value="#{wage_deptSumBB.wageItemList}"/>
                    </h:selectOneMenu>

                    <h:selectOneMenu style="width:80px;" id="conditionoper2" value="#{wage_deptSumBB.wibo.classFieldOperate2}">
                        <c:selectItem itemValue="-1" itemLabel="比较符"></c:selectItem>
                        <c:selectItem itemValue="=" itemLabel="等于"></c:selectItem>
                        <c:selectItem itemValue=">" itemLabel="大于"></c:selectItem>
                        <c:selectItem itemValue=">=" itemLabel="大于等于"></c:selectItem>
                        <c:selectItem itemValue="<" itemLabel="小于"></c:selectItem>
                        <c:selectItem itemValue="<=" itemLabel="小于等于"></c:selectItem>
                        <c:selectItem itemValue="<>" itemLabel="不等于"></c:selectItem>
                    </h:selectOneMenu>
                    <h:inputText value="#{wage_deptSumBB.wibo.classFieldValue2}"></h:inputText>
               </h:panelGroup>

        </h:panelGrid>
<f:verbatim>
         </td></tr>

        <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
                <h:dataTable align="center" width="95%"  value="#{wage_deptSumBB.deptBos}" var="list" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle"
                 styleClass="table03">
                    <h:column>
                    <f:facet name="header"><f:verbatim escape="false">
                        <input type="checkbox" name="chkAll"     onclick="selectAll(document.form1.chkAll,document.form1.Id)"/></f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false"><div align=center><input type="checkbox" name="Id"
                        value="</f:verbatim>
                    <h:outputText value="#{list.itemId}"/><f:verbatim>"></div></f:verbatim>
                    </h:column>
                    <h:column>
                    <f:facet name="header"><h:outputText value="薪资项目(A815)"/></f:facet>
                    <h:outputText value="#{list.fieldIDDes}"/>
                    </h:column>

                    <h:column>
                    <f:facet name="header"><h:outputText value="部门薪资发放信息子集(B732)"/></f:facet>
                    <h:outputText value="#{list.sumFieldIDDes}"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header"><h:outputText value="汇总方式"/></f:facet>
                        <h:outputText value="#{list.operateTypeDes}"/>
                    </h:column>

                    <h:column>
                    <f:facet name="header"><h:outputText value="汇总条件"/></f:facet>
                    <h:outputText value="#{list.whereDes}"/>
                    </h:column>
                </h:dataTable>
<f:verbatim>
            </div>
         </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
    setDataTableOver("form1:dateList");
</script>

