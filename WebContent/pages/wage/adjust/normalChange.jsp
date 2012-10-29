<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function forAddDate() {
    window.showModalDialog("/wage/adjust/wageAdjustEdit.jsf", null, "dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
    return true;
}
function definRule() {
    window.showModalDialog("/wage/adjust/wageAdjustRule.jsf", null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function enterAdj(id) {
    window.showModalDialog("/wage/adjust/wageNomalAdjDetail.jsf?adjId="+id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function showAdj(id) {
    window.showModalDialog("/wage/adjust/showNomalAdjDetail.jsf?adjId="+id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
</script>

<x:saveState value="#{wage_nomalAdjListBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_nomalAdjListBB.pageInit}"/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF" >
            <tr>
                <td class=td_title>
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 薪酬管理 -> 晋级晋档"/>
      <f:verbatim>
                </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8>
        <table width="95%"  >
            <tr><td align="right">
            </td>
            <td align="right">
</f:verbatim>
                <h:commandButton value="开始新业务"  styleClass="button01" onclick="return forAddDate()"/>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="业务规则定义" styleClass="button01" onclick="return definRule()"/>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable value="#{wage_nomalAdjListBB.nomalAdjustList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="调整单位"/></c:facet>
                <h:outputText value="#{list.orgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="调整时间"/></c:facet>
                <h:outputText value="#{list.adjCreateDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="调整人员"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="初审意见"/></c:facet>
                <h:outputText value="#{list.aduitdes1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="复审意见"/></c:facet>
                <h:outputText value="#{list.aduitdes2}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="终审意见"/></c:facet>
                <h:outputText value="#{list.aduitdes3}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:panelGrid columns="5" align="center" cellspacing="2">
                	<h:commandButton value="进入" type="button"   onclick="enterAdj('#{list.adjId}');" styleClass="button01" rendered="#{list.status!='3'}"/>
                    <h:commandButton value="查看" type="button"   onclick="showAdj('#{list.adjId}');" styleClass="button01" rendered="#{list.status=='3'}"/>
                </h:panelGrid>
            </h:column>
        </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>