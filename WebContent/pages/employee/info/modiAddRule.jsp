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

<x:saveState value="#{emp_OrgSumItemSetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_OrgSumItemSetBB.pageInit}"/>
    <f:verbatim><br>
        <table width="96%" height="97%" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center" width="25%" class=tab>&nbsp;<a href="modiRule.jsf?Init=true"><%=LanguageSupport.getResource("RYGL-2316","������������")%> </a></td>
                <td align="center" width="25%" class=activetab><img src="/images/common/handtip.gif">&nbsp;<a href="modiAddRule.jsf?Init=true"><%=LanguageSupport.getResource("RYGL-2317","��������")%> </a></td>
                <td align="center" width="25%" class=tab>&nbsp;<a href="modiMinusRule.jsf?Init=true"><%=LanguageSupport.getResource("RYGL-2318","��������")%> </a></td>
                <td align="center" width="25%" class=tab>&nbsp;<a href="modiDieRule.jsf?InitDie=true"><%=LanguageSupport.getResource("RYGL-3001","��ְ����")%> </a></td>
            </tr>
        <tr>
            <td valign="top" colspan="4">
               <div class="tabbody" height="100%" width="100%">
    </f:verbatim>
    <h:panelGrid width="98%" align="center"  border="0"   columns="1">
        <h:panelGrid align="left" width="95%" cellpadding="0" cellspacing="2" columns="2">
            <h:panelGroup>
                <f:verbatim>
                 <%=LanguageSupport.getResource("RYGL-2319","������Ŀ")%>
                </f:verbatim>
                <h:selectOneMenu style="width:200px;" id="sumitem" value="#{emp_OrgSumItemSetBB.itemid}">
                    <f:selectItems value="#{emp_OrgSumItemSetBB.sumItemList}"/>
                </h:selectOneMenu>
            </h:panelGroup>

            <h:panelGrid align="right" width="100%" cellpadding="0" cellspacing="2" columns="1">
               <h:panelGroup>
                <h:commandButton id="set" styleClass="button01" value=" ���� "
                                 onclick="if(chkNull())return true;else return false;"
                                 action="#{emp_OrgSumItemSetBB.addAddItem}"/>
                <h:commandButton value=" ɾ�� " styleClass="button01"
                                 onclick="if(checkIds(document.form1.Id)){return true;}else return false;"
                                 action="#{emp_OrgSumItemSetBB.deleteItem}" />
              </h:panelGroup>
            </h:panelGrid>

       </h:panelGrid>

        <h:panelGrid align="left" width="95%" cellpadding="0" cellspacing="2" columns="2">
            <h:panelGroup>
             <f:verbatim>
                 <%=LanguageSupport.getResource("RYGL-2320","ѡ��������")%>
                </f:verbatim>
             <h:commandButton id="select" type="button" styleClass="button01" value="ѡ��"  onclick="forSel()"/>
           </h:panelGroup>

            <h:panelGroup>
             <h:inputTextarea readonly="true"  rows="5" cols="90" id="classvaluedes"/>
             <h:inputHidden id="classvalue" value="#{emp_OrgSumItemSetBB.classValue}"/>
           </h:panelGroup>
       </h:panelGrid>

        <h:panelGroup>
            <f:verbatim>
                  ������Ŀ
            </f:verbatim>
            <h:selectOneMenu style="width:110px;" id="classitem"
                value="#{emp_OrgSumItemSetBB.classFieldName2}"
                onclick="document.all('form1:classFilterValue').value='';document.all('form1:classFilterDes').value='';">
                <f:selectItems value="#{emp_OrgSumItemSetBB.classItemList}" />
            </h:selectOneMenu>
            <f:verbatim>
                  ����ֵ
            </f:verbatim>
            <h:inputText readonly="true" style="width:110px" id="classFilterDes" />
            <h:inputHidden id="classFilterValue"
                value="#{emp_OrgSumItemSetBB.classValue2}" />
            <h:commandButton id="selectFilter" type="button" styleClass="button01"
                value="ѡ��" onclick="forSelFilter()" />
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
                 <%=LanguageSupport.getResource("RYGL-2319","������Ŀ")%>
                </f:verbatim>
                </f:facet>
                <h:outputText value="#{list.itemName}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                  <f:verbatim>
                 <%=LanguageSupport.getResource("RYGL-2321","���ܷ�ʽ")%>
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
