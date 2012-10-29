<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

    <script language="javascript">
        function modiDefine(){
            window.showModalDialog("/wage/base/ModifyOrgSumItem.jsf?ID="+document.all('form1:SpecialQuery').value+"&setID="+document.all('form1:setId').value, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function forSel() {
            if (document.all('form1:oper1').value=='1'){
                PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:classitem").value,'');
            }
            else{
                PopUpCodeDlgTwoControlSelectAll(document.all('form1:classvalue'),document.all( 'form1:classvaluedes'), document.all("form1:classitem").value,'');
            }
            return false;
        }
        function forSel2() {
            if (document.all('form1:oper2').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue2', 'form1:classvaluedes2', document.all("form1:classitem2").value,'');
            }
            else{
                PopUpCodeDlgTwoControlSelectAll(document.all('form1:classvalue2'), document.all('form1:classvaluedes2'), document.all("form1:classitem2").value,'');
            }
            return false;
        }
        function forSel3() {
            if (document.all('form1:oper3').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue3', 'form1:classvaluedes3', document.all("form1:classitem3").value,'');
            }
            else{
                PopUpCodeDlgTwoControlSelectAll(document.all('form1:classvalue3'), document.all('form1:classvaluedes3'), document.all("form1:classitem3").value,'');
            }
            return false;
        }
        function forSel4() {
            if (document.all('form1:oper4').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue4', 'form1:classvaluedes4', document.all("form1:classitem4").value,'');
            }
            else{
                PopUpCodeDlgTwoControlSelectAll(document.all('form1:classvalue4'), document.all('form1:classvaluedes4'), document.all("form1:classitem4").value,'');
            }
            return false;
        }

        function chkNull() {
            if (document.getElementById("form1:sumitem").value == ""
                || document.getElementById("form1:sumType").value == ""
                || document.getElementById("form1:classitem").value == ""
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

<x:saveState value="#{wage_OrgSumItemSetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_OrgSumItemSetBB.initEdit}"/>
    <h:panelGrid width="98%" align="center"  border="0"   columns="1">
            <h:panelGrid align="right" width="100%" cellpadding="0" cellspacing="2" columns="1">
                  <h:commandButton id="set" styleClass="button01" value=" 设置 "
                                 onclick="if(chkNull())return true;else return false;"
                                 action="#{wage_OrgSumItemSetBB.saveItem}"/>
            </h:panelGrid>

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>汇总项目:</strong>"/>
            <h:inputHidden  id="sumitem" value="#{wage_OrgSumItemSetBB.itemid}" />
            <h:outputText   value="#{wage_OrgSumItemSetBB.itemName}"></h:outputText>
        </h:panelGroup>
        <h:panelGroup>

            <h:outputText value="   汇总方式"/>
            <h:selectOneMenu style="width:110px;" id="sumType" value="#{wage_OrgSumItemSetBB.sumType}">
                <f:selectItem itemLabel="计数" itemValue="0"/>
                <f:selectItem itemLabel="求和" itemValue="1"/>
            </h:selectOneMenu>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="   计算项目"/>
            <h:selectOneMenu style="width:110px;" id="calcitem" value="#{wage_OrgSumItemSetBB.sumFieldName}">
                <f:selectItems value="#{wage_OrgSumItemSetBB.calcItemList}"/>
            </h:selectOneMenu>
        </h:panelGroup>

         <h:outputText value="请定义分类条件=> "/>

        <h:panelGroup>
            <h:outputText value="分类项目1"/>
            <h:selectOneMenu style="width:110px;" id="classitem" value="#{wage_OrgSumItemSetBB.classFieldName}" onclick="document.all('form1:classvalue').value='';document.all('form1:classvaluedes').value='';">
                <f:selectItems value="#{wage_OrgSumItemSetBB.classItemList}"/>
            </h:selectOneMenu>
            <h:selectOneMenu id="oper1" value="#{wage_OrgSumItemSetBB.oper1}">
                 <c:selectItem itemValue="1" itemLabel="等于"></c:selectItem>
                 <c:selectItem itemValue="2" itemLabel="属于"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="   分类值1"/>
            <h:inputText readonly="true"  style="width:110px" id="classvaluedes" value="#{wage_OrgSumItemSetBB.classValueDes}"/>
            <h:inputHidden id="classvalue" value="#{wage_OrgSumItemSetBB.classValue}"/>
            <h:commandButton id="select" type="button" styleClass="button01" value="选择"  onclick="forSel()"/>
      </h:panelGroup>

      <h:panelGroup>
            <h:outputText value=" 并且 分类项目2"/>
            <h:selectOneMenu style="width:110px;" id="classitem2" value="#{wage_OrgSumItemSetBB.classFieldName2}" onclick="document.all('form1:classvalue2').value='';document.all('form1:classvaluedes2').value='';">
                <f:selectItems value="#{wage_OrgSumItemSetBB.classItemList}"/>
            </h:selectOneMenu>
          <h:selectOneMenu id="oper2" value="#{wage_OrgSumItemSetBB.oper2}">
               <c:selectItem itemValue="1" itemLabel="等于"></c:selectItem>
               <c:selectItem itemValue="2" itemLabel="属于"></c:selectItem>
          </h:selectOneMenu>
            <h:outputText value="   分类值2"/>
            <h:inputText readonly="true"  style="width:110px" id="classvaluedes2" value="#{wage_OrgSumItemSetBB.classValueDes2}"/>
            <h:inputHidden id="classvalue2" value="#{wage_OrgSumItemSetBB.classValue2}"/>
            <h:commandButton id="select2" type="button" styleClass="button01" value="选择"  onclick="forSel2()"/>
        </h:panelGroup>

        <h:panelGroup>
              <h:outputText value=" 并且 分类项目3"/>
              <h:selectOneMenu style="width:110px;" id="classitem3" value="#{wage_OrgSumItemSetBB.classFieldName3}" onclick="document.all('form1:classvalue3').value='';document.all('form1:classvaluedes3').value='';">
                  <f:selectItems value="#{wage_OrgSumItemSetBB.classItemList}"/>
              </h:selectOneMenu>
            <h:selectOneMenu id="oper3" value="#{wage_OrgSumItemSetBB.oper3}">
                 <c:selectItem itemValue="1" itemLabel="等于"></c:selectItem>
                 <c:selectItem itemValue="2" itemLabel="属于"></c:selectItem>
            </h:selectOneMenu>
              <h:outputText value="   分类值3"/>
              <h:inputText readonly="true"  style="width:110px" id="classvaluedes3" value="#{wage_OrgSumItemSetBB.classValueDes3}"/>
              <h:inputHidden id="classvalue3" value="#{wage_OrgSumItemSetBB.classValue3}"/>
              <h:commandButton id="select3" type="button" styleClass="button01" value="选择"  onclick="forSel3()"/>
          </h:panelGroup>

        <h:panelGroup>
              <h:outputText value=" 并且 分类项目4"/>
              <h:selectOneMenu style="width:110px;" id="classitem4" value="#{wage_OrgSumItemSetBB.classFieldName4}" onclick="document.all('form1:classvalue4').value='';document.all('form1:classvaluedes4').value='';">
                  <f:selectItems value="#{wage_OrgSumItemSetBB.classItemList}"/>
              </h:selectOneMenu>
            <h:selectOneMenu id="oper4" value="#{wage_OrgSumItemSetBB.oper4}">
                 <c:selectItem itemValue="1" itemLabel="等于"></c:selectItem>
                 <c:selectItem itemValue="2" itemLabel="属于"></c:selectItem>
            </h:selectOneMenu>
              <h:outputText value="   分类值4"/>
              <h:inputText readonly="true"  style="width:110px" id="classvaluedes4" value="#{wage_OrgSumItemSetBB.classValueDes4}"/>
              <h:inputHidden id="classvalue3" value="#{wage_OrgSumItemSetBB.classValue4}"/>
              <h:commandButton id="select3" type="button" styleClass="button01" value="选择"  onclick="forSel4()"/>
          </h:panelGroup>

    </h:panelGrid>
</h:form>
