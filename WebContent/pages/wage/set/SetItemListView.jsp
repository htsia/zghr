<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
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
        function viewFormula(fid){
            window.showModalDialog("/wage/base/FormulaView.jsf?formulaid=" + fid, null, "dialogWidth:800px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function editFormula(fid){
            window.showModalDialog("/wage/base/FormulaEdit.jsf?unitId="+document.all("form1:unitId").value+"&formulaID=" + fid, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function viewStandard(sid){
            window.showModalDialog("/wage/base/StandardEditValueDlg.jsf?StandardID=" + sid, null, "dialogWidth:800px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>

<x:saveState value="#{wage_setItemBB}"/>
<x:saveState value="#{wage_setBB}"/>
<h:inputHidden value="#{wage_setItemBB.initView}"/>
<h:form id="form1">
    <h:inputHidden id="setId" value="#{wage_setItemBB.item.setId}"/>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid align="center" columns="2" width="100%">
            <h:outputText value="账套名称：#{wage_setItemBB.setName}"/>
            <h:panelGrid align="right" columns="1" cellspacing="2">
                <h:commandButton styleClass="button01" value="返回" onclick="window.close();">
                </h:commandButton>
            </h:panelGrid>
        </h:panelGrid>

        <h:dataTable value="#{wage_setItemBB.itemList}" var="list" width="100%" styleClass="table03" id="dateList"
                     headerClass="td_top"
                     columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
            <h:column>
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll"
                               onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>全选
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <input type="checkbox" name="selectItem"
                    value="</c:verbatim><h:outputText value="#{list.itemId}"/><c:verbatim>">
                </c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="薪资项名称"/></c:facet>
                <h:outputText value="#{list.field}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="薪资项类型"/></c:facet>
                <h:outputText value="#{list.typeEx}"/>
                <h:commandButton id="view" styleClass="button01"  rendered="#{list.type=='1'}" value="查看" onclick="return viewFormula('#{list.linkId}')" />
                <h:commandButton id="viewStandard" styleClass="button01"  rendered="#{list.type=='0'}" value="查看" onclick="return viewStandard('#{list.linkId}')" />
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
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>