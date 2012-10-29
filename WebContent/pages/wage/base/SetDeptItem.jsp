
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

    <script language="javascript">
        function modiDefine(ID){
            window.showModalDialog("/wage/base/ModifyDeptItem.jsf?ID="+ID, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
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

        function chkNull() {
            if (document.getElementById("form1:wageitem").value == "" || document.getElementById("form1:item").value == "") {
                alert("请选择相关项目！")
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

<x:saveState value="#{wage_wageItemSetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_wageItemSetBB.pageInit}"/>
<f:verbatim>
    <br>
    <table height=96% width=98% align="center" cellpadding="0" cellspacing="0">
    <tr height=8>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetWageItem.jsf?act=1">薪资项目－成本代码</a></td>
                <td align="center" width="16%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="SetDeptItem.jsf?act=2">薪资项目－机构人力成本</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetPersonItem.jsf?act=3">薪资项目－员工人力成本</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetOrgSumItem.jsf?act=4">机构汇总设置</a></td>
               <!-- <td align="center" width="16%" class=tab>&nbsp;<a href="SetPieceItem.jsf?act=6">个人计量汇总</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetOrgPieceItem.jsf?act=7">部门计量汇总</a></td> -->
     </tr>

    <tr><td colspan="6" valign="top">
    <div class="tabbody" height="100%" width="100%"  id=datatable>
</f:verbatim>
        <h:panelGrid width="100%">
            <h:panelGroup>
                <h:selectBooleanCheckbox id="orderByName" value="#{wage_wageItemSetBB.orderByName}" onclick="submit();"  valueChangeListener="#{wage_wageItemSetBB.outputByName}" ></h:selectBooleanCheckbox>
                <h:outputText value="按项目名称排序"></h:outputText>
            </h:panelGroup>
            <h:panelGroup>
            <h:outputText value="   "></h:outputText>
            <h:outputText value="把薪资项目："/>
            <h:selectOneMenu style="width:150;" id="wageitem" value="#{wage_wageItemSetBB.costFieldBo.costType}">
                <f:selectItems value="#{wage_wageItemSetBB.wageItemList}"/>
            </h:selectOneMenu>

            <h:outputText value="汇总到机构人力成本项目 "/>
            <h:selectOneMenu style="width:150;" id="item" value="#{wage_wageItemSetBB.costFieldBo.costField}">
                <f:selectItems value="#{wage_wageItemSetBB.deptItemList}"/>
            </h:selectOneMenu>

            <h:outputText value="汇总条件"/>
            <h:selectOneMenu style="width:110px;" id="classitem" value="#{wage_wageItemSetBB.classFieldName}" onclick="document.all('form1:classvalue').value='';document.all('form1:classvaluedes').value='';">
                <f:selectItems value="#{wage_wageItemSetBB.classItemList}"/>
            </h:selectOneMenu>
            <h:selectOneMenu id="oper1" value="#{wage_wageItemSetBB.oper1}">
                 <c:selectItem itemValue="1" itemLabel="等于"></c:selectItem>
                 <c:selectItem itemValue="2" itemLabel="属于"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="   分类值"/>
            <h:inputText readonly="true"  style="width:110px" id="classvaluedes"/>
            <h:inputHidden id="classvalue" value="#{wage_wageItemSetBB.classValue}"/>
            <h:commandButton id="select" type="button" styleClass="button01" value="选择"  onclick="forSel()"/>
        </h:panelGroup>
            <h:panelGroup>
            <h:outputText value="同时将人数统计到: "/>
            <h:selectOneMenu style="width:150;" id="countitem" value="#{wage_wageItemSetBB.costFieldBo.countfield}">
                <f:selectItems value="#{wage_wageItemSetBB.deptItemList}"/>
            </h:selectOneMenu>

            <h:outputText value="同时平均数统计到: "/>
            <h:selectOneMenu style="width:150;" id="avgitem" value="#{wage_wageItemSetBB.costFieldBo.avgfield}">
                <f:selectItems value="#{wage_wageItemSetBB.deptItemList}"/>
            </h:selectOneMenu>

            <h:commandButton id="set" styleClass="button01" value="设置"
                             onclick="if(chkNull())return true;else return false;"
                             action="#{wage_wageItemSetBB.addDeptItem}"/>
            <h:commandButton value=" 删除 " styleClass="button01"
                             onclick="if(checkIds(document.form1.Id)){pageCodeExchange(form1);return true;}else return false;"
                             action="#{wage_wageItemSetBB.deleteItem}">
                <x:updateActionListener property="#{wage_wageItemSetBB.flag}" value="2"/>
            </h:commandButton>
    </h:panelGroup>
        </h:panelGrid>
        <h:dataTable align="center" width="95%"  value="#{wage_wageItemSetBB.deptBos}" var="list"  id="dateList"
                 headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle"
                 styleClass="table03">
        <h:column>
            <f:facet name="header"><f:verbatim escape="false"><input type="checkbox" name="chkAll"
                                                                     onclick="selectAll(document.form1.chkAll,document.form1.Id)"/></f:verbatim>
            </f:facet>
            <f:verbatim escape="false"><div align=center><input type="checkbox" name="Id"
                value="</f:verbatim>
            <h:outputText value="#{list.costFieldId}"/><f:verbatim>"></div></f:verbatim>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="薪资项目(A815)"/></f:facet>
            <h:outputText value="#{list.costNameEx}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="汇总条件"/></f:facet>
            <h:outputText value="#{list.conditionDes}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="机构人力成本项目(B028)"/></f:facet>
            <h:outputText value="#{list.fieldNameEx}"/>
        </h:column>


        <h:column>
            <f:facet name="header"><h:outputText value="人数项目(B028)"/></f:facet>
            <h:outputText value="#{list.countfieldName}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="平均项目(B028)"/></f:facet>
            <h:outputText value="#{list.avgfieldName}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="操作" styleClass="td03"/></f:facet>
            <h:commandButton value="修改" styleClass="button01" onclick="return modiDefine('#{list.costFieldId}')" action="#{wage_wageItemSetBB.queryDeptItem}"></h:commandButton>
        </h:column>

    </h:dataTable>
<f:verbatim>
    </div>
    </td></tr>
</f:verbatim> 
</h:form>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
    setDataTableOver("form1:dateList");
</script>
