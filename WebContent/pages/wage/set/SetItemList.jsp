<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function viewFormulaChange(id){
            window.showModalDialog("/wage/base/showFormulaChange.jsf?FormularID=" + id, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

        function windowOpen() {
            if (document.getElementById("checkSubmitFlg").value == "0") {
                window.open("", "add", "left=300px,top=200px,height=250px,width=400px,status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=yes");
                form1.target = "add";
                return true;
            } else {
                return false;
            }
        }
        function confirmDel() {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm('确定要删除吗？'))
                    return true;
            }
            return false;
        }
        function editFormula(fid){
            window.showModalDialog("/wage/base/FormulaEdit.jsf?unitId="+document.all("form1:unitId").value+"&formulaID=" + fid, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doshowLog(){
            window.showModalDialog("/wage/base/showSetItemChange.jsf?setId=" + document.all("form1:setId").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>

<x:saveState value="#{wage_setItemBB}"/>
<x:saveState value="#{wage_setBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_setItemBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_setItemBB.item.setId}"/>
    <h:inputHidden id="unitId" value="#{wage_setItemBB.unitId}"/>

    <f:verbatim>
    <table height=98% width=98%>
       <tr><td height=8>
     </f:verbatim>
        <h:panelGrid align="center" columns="2" width="100%">
            <h:outputText escape="false" value="<strong>#{wage_setItemBB.setName}</strong>"/>
            <h:panelGrid align="right" columns="8" cellspacing="2">
                <h:selectBooleanCheckbox id="nameselect" onclick="submit()" valueChangeListener="#{wage_setItemBB.viewsetitem}" />  <h:outputText value="按名称排序"/>
                <h:commandButton styleClass="button01" value="变化日志"  onclick="doshowLog();" type="button"/>
                <h:commandButton styleClass="button01" value="新建"  rendered="#{wage_setItemBB.operRight}"
                                 action="#{wage_setItemBB.create}"/>
                <h:commandButton styleClass="button01" value="删除"  rendered="#{wage_setItemBB.operRight}"
                                 action="#{wage_setItemBB.delete}"
                                 onclick="return confirmDel();"/>
                <h:commandButton styleClass="button01" value="设置顺序" rendered="#{wage_setItemBB.operRight}"
                                 action="#{wage_setItemBB.listShowItem}"/>
                <h:commandButton styleClass="button01" value="返回" action="#{wage_setBB.list}">
                    <x:updateActionListener property="#{wage_setBB.wageset.unitId}" value="#{wage_setItemBB.unitId}"/>
                </h:commandButton>
            </h:panelGrid>
        </h:panelGrid>
      <f:verbatim>
       </td></tr>

        <tr><td >
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
       </f:verbatim>
            <h:dataTable value="#{wage_setItemBB.itemList}" var="list" width="100%" styleClass="table03"  id="itemList"
                         headerClass="td_top tr_fixrow"
                         columnClasses="td_middle_center,td_middle,td_middle_left,td_middle_center,td_middle_center,td_middle_center">
                <h:column>
                    <c:facet name="header">
                        <c:verbatim escape="false">
                            <input type="checkbox" name="chkAll"  onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>全选
                        </c:verbatim>
                    </c:facet>
                    <c:verbatim escape="false">
                        <input type="checkbox" name="selectItem"
                        value="</c:verbatim><h:outputText value="#{list.itemId}" rendered="#{list.type!='3'}"/><c:verbatim>">
                    </c:verbatim>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="薪资项名称"/></c:facet>
                    <h:outputText value="#{list.fieldName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="薪资项类型"/></c:facet>
                    <h:outputText escape="false" value="#{list.typeEx}"/>
                    <h:commandButton id="view" styleClass="button01" type="button" rendered="#{list.type=='1'}" value="查看" onclick="return viewFormula('#{list.linkId}')" />
                    <h:commandButton id="viewfchange" styleClass="button01" type="button" rendered="#{list.type=='1'}" value="查看变动日志" onclick="return viewFormulaChange('#{list.linkId}')" />
                    <h:commandButton id="edit" styleClass="button01"  rendered="#{list.type=='1' && list.canModify}" value="修改" onclick="return editFormula('#{list.linkId}')" />
                    <h:commandButton id="viewStandard" styleClass="button01" type="button" rendered="#{list.type=='0'}" value="查看" onclick="return viewStandard('#{list.linkId}')" />
                    <h:commandButton id="viewTax" styleClass="button01"  type="button" rendered="#{list.field=='A815714'}" value="查看计税方法" onclick="return viewTax();" />
                    <h:commandButton id="viewYearTax" styleClass="button01"  type="button" rendered="#{list.field=='A815756'}" value="查看计税方法" onclick="return viewYearTax();" />
                    <h:commandButton id="clear" styleClass="button01"  rendered="#{list.type=='2' && list.canClear!='1'}" value="允许清空" action="#{wage_setItemBB.beginClear}">
                        <x:updateActionListener property="#{wage_setItemBB.itemID}" value="#{list.itemId}"/>
                    </h:commandButton>
                    <h:commandButton id="setclear" styleClass="button01"  rendered="#{list.type=='2' && list.canClear=='1'}" value="禁止清空" action="#{wage_setItemBB.endClear}">
                         <x:updateActionListener property="#{wage_setItemBB.itemID}" value="#{list.itemId}"/>
                    </h:commandButton>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="缺省值"/></c:facet>
                    <h:outputText value="#{list.defaultValue}"/>
                </h:column>

                <h:column rendered="#{wage_setItemBB.flowFlag}">
                    <c:facet name="header"><h:outputText value="计算顺序"/></c:facet>
                    <h:outputText value="#{list.countSeq}"/>
                </h:column>
            </h:dataTable>
<f:verbatim>
        </div>
       </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
    var size = form1.selectItem.length;
    if (size == null) {
        if (form1.selectItem.value=="") {
            form1.selectItem.style.display="none";   // 屏蔽A815714
        }
    } else {
        for (var i = 0; i < size; i++) {
            if (form1.selectItem[i].value=="") {
                form1.selectItem[i].style.display="none";
            }
        }
    }
   setDataTableOver("form1:itemList");
</script>
