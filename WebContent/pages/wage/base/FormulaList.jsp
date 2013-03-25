<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function confirmDel() {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm('确定要删除吗？'))
                    return true;
            }
            return false;
        }
        function checkSelect(){
             if (!checkMutilSelect(form1.selectItem)) {
                alert("请选择要另存的公式!");
                return false;
            }
            return true;
        }
        function viewFormula(fid){
            window.showModalDialog("/wage/base/FormulaView.jsf?formulaid=" + fid, null, "dialogWidth:800px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function showDeleteLog(){
            window.showModalDialog("/wage/base/FormulaDelete.jsf?unitId=" + document.all('form1:unitId').value, null, "dialogWidth:800px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>

<x:saveState value="#{wage_formulaBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_formulaBB.pageInit}"/>
    <h:inputHidden id="unitId" value="#{wage_formulaBB.unitId}"/>
    <c:verbatim>
    <table width=98% height=98%>
      <tr><td height=8>
    </c:verbatim>
        <h:panelGrid columns="2" width="100%">
            <h:outputText escape="false" value="<strong>发薪单位:</strong>#{wage_formulaBB.unitName}"/>
            <h:panelGrid columns="6" cellspacing="2" align="right">
                <h:panelGroup>
                    <h:selectBooleanCheckbox value="#{wage_formulaBB.orderByName}"  valueChangeListener="#{wage_formulaBB.outputByName}" onclick="submit()"></h:selectBooleanCheckbox>
                    <h:outputText value="按公式名称排序"></h:outputText>

                    <c:verbatim>&nbsp;&nbsp;</c:verbatim>

                    <h:selectBooleanCheckbox value="#{wage_formulaBB.showPublic}"  valueChangeListener="#{wage_formulaBB.changePublic}" onclick="submit()"></h:selectBooleanCheckbox>
                    <h:outputText value="显示公用公式"></h:outputText>
                </h:panelGroup>

                <h:commandButton styleClass="button01" value="新建公式" action="#{wage_formulaBB.create}"/>

                <h:commandButton styleClass="button01" value="另存公式副本" action="#{wage_formulaBB.copy}"/>

                <h:commandButton styleClass="button01" value="删除公式" action="#{wage_formulaBB.delete}"
                                 onclick="return confirmDel();"/>
                <h:commandButton styleClass="button01" value="删除日志" onclick="showDeleteLog();" type="button"></h:commandButton>
                <h:commandButton styleClass="button01" value="发送" action="#{wage_formulaBB.send}"></h:commandButton>
            </h:panelGrid>
        </h:panelGrid>
    <c:verbatim>
    </td></tr>

      <tr><td>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
     </c:verbatim>
        <h:dataTable value="#{wage_formulaBB.formulaList}" var="list"    id="dateList"
                     headerClass="td_top"
                     columnClasses="td_middle_center,td_middle_left,td_middle_left,td_middle_left,td_middle_center"
                     styleClass="table03"
                     width="100%">
            <h:column>
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll"
                               onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>全选
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <input type="checkbox" name="selectItem"
                    value="</c:verbatim><h:outputText value="#{list.formulaId}"/><c:verbatim>">
            </c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="结果指标"/></c:facet>
                <h:outputText value="#{list.rsField}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="名称"/></c:facet>
                <h:outputText escape="false" value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText escape="false" value="#{list.desc}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="通用"/></c:facet>
                <h:outputText value="#{list.usualFlag}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="所属单位"/></c:facet>
                <h:outputText value="#{list.unitName}"/>
            </h:column>


            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton id="view" styleClass="button01"  value="查看" onclick="viewFormula('#{list.formulaId}')">
                </h:commandButton>
                <h:outputText value=" "/>
                <h:commandButton id="modify" styleClass="button01" action="#{wage_formulaBB.find}" value="修改"
                                 rendered="#{list.canModify}">
                    <x:updateActionListener property="#{wage_formulaBB.formula.formulaId}" value="#{list.formulaId}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
    <c:verbatim>
       </div>
        </td></tr>
    </table>
    </c:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
    setDataTableOver("form1:dateList");
</script>
