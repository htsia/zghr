<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

    <script language="javascript">
        function modiDefine(ID){
            window.showModalDialog("/wage/base/ModifyOrgSumItem.jsf?ID="+ID, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function forSel() {
            if (document.all('form1:oper1').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:classitem").value,'');
            }
            else{
                PopUpCodeDlgTwoControl(document.all('form1:classvalue'),document.all( 'form1:classvaluedes'), document.all("form1:classitem").value,'');
            }
            return false;
        }
        function forSel2() {
            if (document.all('form1:oper2').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue2', 'form1:classvaluedes2', document.all("form1:classitem2").value,'');
            }
            else{
               PopUpCodeDlgTwoControl(document.all('form1:classvalue2'),document.all( 'form1:classvaluedes2'), document.all("form1:classitem2").value,'');
            }
            return false;
        }
        function forSel3() {
            if (document.all('form1:oper3').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue3', 'form1:classvaluedes3', document.all("form1:classitem3").value,'');
            }
            else{
               PopUpCodeDlgTwoControl(document.all('form1:classvalue3'),document.all( 'form1:classvaluedes3'), document.all("form1:classitem3").value,'');
            }
            return false;
        }

        function forSel4() {
            if (document.all('form1:oper4').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue4', 'form1:classvaluedes4', document.all("form1:classitem4").value,'');
            }
            else{
               PopUpCodeDlgTwoControl(document.all('form1:classvalue4'),document.all( 'form1:classvaluedes4'), document.all("form1:classitem4").value,'');
            }
            return false;
        }

        function chkNull() {
            if (document.getElementById("form1:sumitem").value == ""
                || document.getElementById("form1:sumType").value == ""
                || document.getElementById("form1:classitem").value == ""
                || document.getElementById("form1:classvalue").value == "") {
                alert("��ѡ�������Ŀ��")
                return false;
            }
            else {
                return true;
            }
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

<x:saveState value="#{wage_OrgSumItemSetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_OrgSumItemSetBB.pageInit}"/>
    <f:verbatim>
        <br>
        <table height=96% width=98% align="center" cellpadding="0" cellspacing="0">
        <tr height=8>
                    <td align="center" width="16%" class=tab>&nbsp;<a href="SetWageItem.jsf?act=1">н����Ŀ���ɱ�����</a></td>
                    <td align="center" width="16%" class=tab>&nbsp;<a href="SetDeptItem.jsf?act=2">н����Ŀ�����������ɱ�</a></td>
                    <td align="center" width="16%" class=tab>&nbsp;<a href="SetPersonItem.jsf?act=3">н����Ŀ��Ա�������ɱ�</a></td>
                    <td align="center" width="16%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="SetOrgSumItem.jsf?act=4">������������</a></td>
                 <!--   <td align="center" width="16%" class=tab>&nbsp;<a href="SetPieceItem.jsf?act=6">���˼�������</a></td>
                    <td align="center" width="16%" class=tab>&nbsp;<a href="SetOrgPieceItem.jsf?act=7">���ż�������</a></td> -->
         </tr>

       <tr><td colspan="6" valign="top">
        <div class="tabbody" id=datatable>
</f:verbatim>
             <h:panelGrid width="100%">
                 <h:panelGrid align="left" width="95%" cellpadding="0" cellspacing="2" columns="2">
                    <h:panelGroup>
                        <h:outputText value="������Ŀ"/>
                        <h:selectOneMenu style="width:110px;" id="sumitem" value="#{wage_OrgSumItemSetBB.itemid}">
                            <f:selectItems value="#{wage_OrgSumItemSetBB.sumItemList}"/>
                        </h:selectOneMenu>
                        <h:outputText value="   ���ܷ�ʽ"/>
                        <h:selectOneMenu style="width:110px;" id="sumType" value="#{wage_OrgSumItemSetBB.sumType}">
                            <f:selectItem itemLabel="����" itemValue="0"/>
                            <f:selectItem itemLabel="���" itemValue="1"/>
                        </h:selectOneMenu>
                        <h:outputText value="   ������Ŀ"/>
                        <h:selectOneMenu style="width:110px;" id="calcitem" value="#{wage_OrgSumItemSetBB.sumFieldName}">
                            <f:selectItems value="#{wage_OrgSumItemSetBB.calcItemList}"/>
                        </h:selectOneMenu>
                    </h:panelGroup>

                    <h:panelGrid align="right" width="100%" cellpadding="0" cellspacing="2" columns="2">
                        <h:commandButton id="set" styleClass="button01" value=" ���� "
                                         onclick="if(chkNull())return true;else return false;"
                                         action="#{wage_OrgSumItemSetBB.addItem}"/>

                        <h:commandButton value=" ɾ�� " styleClass="button01"
                                         onclick="if(checkIds(document.form1.Id)){return true;}else return false;"
                                         action="#{wage_OrgSumItemSetBB.deleteItem}" />
                    </h:panelGrid>
               </h:panelGrid>
                 <h:panelGroup>
                    <h:outputText escape="false" value="<strong>�붨���������=></strong> ������Ŀ1"/>
                    <h:selectOneMenu style="width:110px;" id="classitem" value="#{wage_OrgSumItemSetBB.classFieldName}" onclick="document.all('form1:classvalue').value='';document.all('form1:classvaluedes').value='';">
                        <f:selectItems value="#{wage_OrgSumItemSetBB.classItemList}"/>
                    </h:selectOneMenu>
                    <h:selectOneMenu id="oper1" value="#{wage_OrgSumItemSetBB.oper1}">
                         <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
                         <c:selectItem itemValue="2" itemLabel="����"></c:selectItem>
                    </h:selectOneMenu>
                    <h:outputText value="   ����ֵ1"/>
                    <h:inputText readonly="true"  style="width:110px" id="classvaluedes"/>
                    <h:inputHidden id="classvalue" value="#{wage_OrgSumItemSetBB.classValue}"/>
                    <h:commandButton id="select" type="button" styleClass="button01" value="ѡ��"  onclick="forSel()"/>
                </h:panelGroup>
                 <h:panelGroup>
                       <h:outputText value="    "></h:outputText>
                       <h:outputText value="���� ������Ŀ2"/>
                        <h:selectOneMenu style="width:110px;" id="classitem2" value="#{wage_OrgSumItemSetBB.classFieldName2}" onclick="document.all('form1:classvalue2').value='';document.all('form1:classvaluedes2').value='';">
                            <f:selectItems value="#{wage_OrgSumItemSetBB.classItemList}"/>
                        </h:selectOneMenu >
                        <h:selectOneMenu id="oper2" value="#{wage_OrgSumItemSetBB.oper2}">
                             <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
                             <c:selectItem itemValue="2" itemLabel="����"></c:selectItem>
                        </h:selectOneMenu>
                        <h:outputText value="   ����ֵ2"/>
                        <h:inputText readonly="true"  style="width:110px" id="classvaluedes2"/>
                        <h:inputHidden id="classvalue2" value="#{wage_OrgSumItemSetBB.classValue2}"/>
                        <h:commandButton id="select2" type="button" styleClass="button01" value="ѡ��"  onclick="forSel2()"/>
                 </h:panelGroup>
                 <h:panelGroup>
                    <h:outputText value="    "></h:outputText>
                    <h:outputText value="���� ������Ŀ3"/>
                     <h:selectOneMenu style="width:110px;" id="classitem3" value="#{wage_OrgSumItemSetBB.classFieldName3}" onclick="document.all('form1:classvalue3').value='';document.all('form1:classvaluedes3').value='';">
                         <f:selectItems value="#{wage_OrgSumItemSetBB.classItemList}"/>
                     </h:selectOneMenu >
                     <h:selectOneMenu id="oper3" value="#{wage_OrgSumItemSetBB.oper3}">
                          <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
                          <c:selectItem itemValue="2" itemLabel="����"></c:selectItem>
                     </h:selectOneMenu>
                     <h:outputText value="   ����ֵ3"/>
                     <h:inputText readonly="true"  style="width:110px" id="classvaluedes3"/>
                     <h:inputHidden id="classvalue3" value="#{wage_OrgSumItemSetBB.classValue3}"/>
                     <h:commandButton id="select3" type="button" styleClass="button01" value="ѡ��"  onclick="forSel3()"/>
                </h:panelGroup>
                 <h:panelGroup>
               <h:outputText value="    "></h:outputText>
               <h:outputText value="���� ������Ŀ4"/>
                <h:selectOneMenu style="width:110px;" id="classitem4" value="#{wage_OrgSumItemSetBB.classFieldName4}" onclick="document.all('form1:classvalue3').value='';document.all('form1:classvaluedes3').value='';">
                    <f:selectItems value="#{wage_OrgSumItemSetBB.classItemList}"/>
                </h:selectOneMenu >
                <h:selectOneMenu id="oper4" value="#{wage_OrgSumItemSetBB.oper4}">
                     <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
                     <c:selectItem itemValue="2" itemLabel="����"></c:selectItem>
                </h:selectOneMenu>
                <h:outputText value="   ����ֵ4"/>
                <h:inputText readonly="true"  style="width:110px" id="classvaluedes4"/>
                <h:inputHidden id="classvalue4" value="#{wage_OrgSumItemSetBB.classValue4}"/>
                <h:commandButton id="select4" type="button" styleClass="button01" value="ѡ��"  onclick="forSel4()"/>
           </h:panelGroup>
             </h:panelGrid>
            <h:dataTable styleClass="table03" align="center" width="95%" id="dateList"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle"
                         value="#{wage_OrgSumItemSetBB.wageBos}"
                         var="list" border="0">
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
                    <f:facet name="header"><h:outputText value="������Ŀ" styleClass="td03"/></f:facet>
                    <h:outputText value="#{list.itemName}"/>
                </h:column>

                <h:column>
                    <f:facet name="header"><h:outputText value="���ܷ�ʽ" styleClass="td03"/></f:facet>
                    <h:outputText value="#{list.description}"/>
                </h:column>

                <h:column>
                    <f:facet name="header"><h:outputText value="����" styleClass="td03"/></f:facet>
                    <h:commandButton value="�޸�" styleClass="button01" onclick="return modiDefine('#{list.itemId}')"></h:commandButton>
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
