<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

    <script language="javascript">
        function editWageItem(id){
            window.showModalDialog("/wage/base/editWageItem.jsf?itemID="+id, null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        
        function chkNull() {
            if (document.getElementById("form1:code").value == "" || document.getElementById("form1:item").value == "") {
                alert("��ѡ�������Ŀ��")
                return false;
            }
            else {
                pageCodeExchange(form1);
                return true
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

<x:saveState value="#{wage_wageItemSetBB}"/>
<h:form id="form1">
<h:inputHidden value="#{wage_wageItemSetBB.pageInit}"/>
    <f:verbatim>
    <br>
    <table height=96% width=98% align="center" cellpadding="0" cellspacing="0">
    <tr height=8>
                <td align="center" width="16%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="SetWageItem.jsf?act=1">н����Ŀ���ɱ�����</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetDeptItem.jsf?act=2">н����Ŀ�����������ɱ�</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetPersonItem.jsf?act=3">н����Ŀ��Ա�������ɱ�</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetOrgSumItem.jsf?act=4">������������</a></td>
               <!-- <td align="center" width="16%" class=tab>&nbsp;<a href="SetPieceItem.jsf?act=6">���˼�������</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetOrgPieceItem.jsf?act=7">���ż�������</a></td> -->
     </tr>

     <tr><td colspan="6" valign="top">
        <div class="tabbody" height="100%" width="100%" id=datatable>
</f:verbatim>
            <h:panelGrid width="95%" align="center" border="0"   columns="2">
                <h:panelGroup>
                    <h:selectBooleanCheckbox id="orderByName" value="#{wage_wageItemSetBB.orderByName}" onclick="submit();"  valueChangeListener="#{wage_wageItemSetBB.outputByName}" ></h:selectBooleanCheckbox>
                    <h:outputText value="����Ŀ��������"></h:outputText>
                </h:panelGroup>
                <h:panelGroup>
                    <h:outputText value="н����Ŀ��"/>
                    <h:selectOneMenu style="width:150px;" id="item" value="#{wage_wageItemSetBB.costFieldBo.costField}">
                        <f:selectItems value="#{wage_wageItemSetBB.wageItemList}"/>
                    </h:selectOneMenu>
                    <c:verbatim>&nbsp;&nbsp;</c:verbatim>
                    <h:outputText value="�ɱ����룺"/>
                    <h:inputText id="code" value="#{wage_wageItemSetBB.costFieldBo.costType}"
                                 code="" dict="yes" dict_num="0280" readonly="true" alt="�����ɱ���|1" styleClass="input"/>
                    <h:outputText value=" "/>
                    <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:code','','0')"/>
                <h:commandButton id="set" styleClass="button01" value=" ���� "
                                 onclick="if(chkNull())return true;else return false;"
                                 action="#{wage_wageItemSetBB.addWageItem}"/>
                <h:commandButton value=" ɾ�� " styleClass="button01"
                                 onclick="if(checkIds(document.form1.Id)){pageCodeExchange(form1);return true;}else return false;"
                                 action="#{wage_wageItemSetBB.deleteItem}">
                    <x:updateActionListener property="#{wage_wageItemSetBB.flag}" value="1"/>
                </h:commandButton>
              </h:panelGroup>
        </h:panelGrid>
            <h:dataTable styleClass="table03" align="center" width="95%"   id="dateList"
                         headerClass="tr_fixrow td_top" columnClasses="td_middle_center,td_middle,td_middle"
                         value="#{wage_wageItemSetBB.wageBos}"
                         var="list" border="0">
                <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.Id)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <input type="checkbox" name="Id" value="</f:verbatim><h:outputText value="#{list.costFieldId}"/><f:verbatim>">
                    </f:verbatim>
                </h:column>
                <h:column>
                    <f:facet name="header"><h:outputText value="н����Ŀ" styleClass="td03"/></f:facet>
                    <h:outputText value="#{list.fieldNameEx}"/>
                </h:column>
                <h:column>
                    <f:facet name="header"><h:outputText value="�ɱ�����" styleClass="td03"/></f:facet>
                    <h:outputText value="#{list.costName}"/>
                </h:column>
                <h:column>
                    <f:facet name="header"><h:outputText value="����" styleClass="td03"/></f:facet>
                    <h:commandButton styleClass="button01" action="#{wage_wageItemSetBB.queryWageItem}" value="�޸�" onclick="editWageItem('#{list.costFieldId}');"></h:commandButton>
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
