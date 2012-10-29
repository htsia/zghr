<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

    <c:verbatim><base target="_self"></c:verbatim>
    <script language="javascript">
        function forSel() {
            if (document.all('form1:oper1').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:classitem").value,'');
            }
            else{
                PopUpCodeDlgTwoControl(document.all('form1:classvalue'),document.all( 'form1:classvaluedes'), document.all("form1:classitem").value,'');
            }
            return false;
        }

        function chkNull() {
            if (document.getElementById("form1:classitem").value != ""){
              if ( document.getElementById("form1:oper1").value == "" || document.getElementById("form1:classvalue").value == "") {
                alert("请选择相关项目！")
                return false;
              }
            }
            return true;
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

<x:saveState value="#{wage_wageItemSetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_wageItemSetBB.initEdit}"/>
    <h:panelGrid width="98%" align="center"  border="0"   columns="1">
            <h:panelGrid align="right" width="100%" cellpadding="0" cellspacing="2" columns="1">
                  <h:commandButton id="set" styleClass="button01" value=" 设置 "
                                 onclick="if(chkNull())return true;else return false;"
                                 action="#{wage_wageItemSetBB.modifyDeptItem}"/>
            </h:panelGrid>

        <h:panelGroup>
            <h:outputText value="把薪资项目"/>
            <h:selectOneMenu style="width:110px;" id="calcitem" value="#{wage_wageItemSetBB.costFieldBo.costType}">
                <f:selectItems value="#{wage_wageItemSetBB.wageItemList}"/>
            </h:selectOneMenu>

            <h:outputText value="汇总到"/>
            <h:selectOneMenu style="width:150;" id="item" value="#{wage_wageItemSetBB.costFieldBo.costField}">
                <f:selectItems value="#{wage_wageItemSetBB.deptItemList}"/>
            </h:selectOneMenu>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="汇总条件"/>
            <h:selectOneMenu style="width:110px;" id="classitem" value="#{wage_wageItemSetBB.costFieldBo.classFieldName}" onclick="document.all('form1:classvalue').value='';document.all('form1:classvaluedes').value='';">
                <f:selectItems value="#{wage_wageItemSetBB.classItemList}"/>
            </h:selectOneMenu>

            <h:outputText value=" "/>
            <h:selectOneMenu style="width:110px;" id="oper1" value="#{wage_wageItemSetBB.costFieldBo.oper1}">
                <c:selectItem itemValue="1" itemLabel="等于"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="属于"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="   分类值"/>
            <h:inputText readonly="true"  style="width:110px" id="classvaluedes"/>
            <h:inputHidden id="classvalue" value="#{wage_wageItemSetBB.costFieldBo.classFieldValue}"/>
            <h:commandButton id="select" type="button" styleClass="button01" value="选择"  onclick="forSel()"/>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="同时将人数统计到: "/>
            <h:selectOneMenu style="width:150;" id="countitem" value="#{wage_wageItemSetBB.costFieldBo.countfield}">
                <f:selectItems value="#{wage_wageItemSetBB.deptItemList}"/>
            </h:selectOneMenu>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="同时平均数统计到: "/>
            <h:selectOneMenu style="width:150;" id="avgitem" value="#{wage_wageItemSetBB.costFieldBo.avgfield}">
                <f:selectItems value="#{wage_wageItemSetBB.deptItemList}"/>
            </h:selectOneMenu>
         </h:panelGroup>
    </h:panelGrid>
</h:form>
