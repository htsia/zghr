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
                alert("��ѡ�������Ŀ��")
                return false;
              }
            }
            return true;
        }
        function checkIds(persId) {
            if (checkMutilSelect(persId)) {
                if (confirm('ȷ��Ҫɾ����ѡ��Ŀ��'))
                {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("��ѡ����Ŀ��")
                return false;
            }
        }
    </script>

<x:saveState value="#{wage_wageItemSetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_wageItemSetBB.initEdit}"/>
    <h:panelGrid width="98%" align="center"  border="0"   columns="1">
            <h:panelGrid align="right" width="100%" cellpadding="0" cellspacing="2" columns="1">
                  <h:commandButton id="set" styleClass="button01" value=" ���� "
                                 onclick="if(chkNull())return true;else return false;"
                                 action="#{wage_wageItemSetBB.modifyDeptItem}"/>
            </h:panelGrid>

        <h:panelGroup>
            <h:outputText value="��н����Ŀ"/>
            <h:selectOneMenu style="width:110px;" id="calcitem" value="#{wage_wageItemSetBB.costFieldBo.costType}">
                <f:selectItems value="#{wage_wageItemSetBB.wageItemList}"/>
            </h:selectOneMenu>

            <h:outputText value="���ܵ�"/>
            <h:selectOneMenu style="width:150;" id="item" value="#{wage_wageItemSetBB.costFieldBo.costField}">
                <f:selectItems value="#{wage_wageItemSetBB.deptItemList}"/>
            </h:selectOneMenu>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="��������"/>
            <h:selectOneMenu style="width:110px;" id="classitem" value="#{wage_wageItemSetBB.costFieldBo.classFieldName}" onclick="document.all('form1:classvalue').value='';document.all('form1:classvaluedes').value='';">
                <f:selectItems value="#{wage_wageItemSetBB.classItemList}"/>
            </h:selectOneMenu>

            <h:outputText value=" "/>
            <h:selectOneMenu style="width:110px;" id="oper1" value="#{wage_wageItemSetBB.costFieldBo.oper1}">
                <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="����"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="   ����ֵ"/>
            <h:inputText readonly="true"  style="width:110px" id="classvaluedes"/>
            <h:inputHidden id="classvalue" value="#{wage_wageItemSetBB.costFieldBo.classFieldValue}"/>
            <h:commandButton id="select" type="button" styleClass="button01" value="ѡ��"  onclick="forSel()"/>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="ͬʱ������ͳ�Ƶ�: "/>
            <h:selectOneMenu style="width:150;" id="countitem" value="#{wage_wageItemSetBB.costFieldBo.countfield}">
                <f:selectItems value="#{wage_wageItemSetBB.deptItemList}"/>
            </h:selectOneMenu>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="ͬʱƽ����ͳ�Ƶ�: "/>
            <h:selectOneMenu style="width:150;" id="avgitem" value="#{wage_wageItemSetBB.costFieldBo.avgfield}">
                <f:selectItems value="#{wage_wageItemSetBB.deptItemList}"/>
            </h:selectOneMenu>
         </h:panelGroup>
    </h:panelGrid>
</h:form>
