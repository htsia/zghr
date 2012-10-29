<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript" language="javascript">
    function doShowBase(setId){
        var arg = "setId=" + setId;
        reval = window.showModalDialog("/insurace/ShowBase.jsf?" + arg, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{ins_computelistBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{ins_computelistBB.auditRate}"/>
<f:verbatim>
    <table height=98% width=96% align="center">
    <tr><td height=8>
</f:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="保险管理 -> 基数审批"/>
           </h:panelGroup>
        </h:panelGrid>
<f:verbatim>
     </td></tr>

    <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
            <h:dataTable value="#{ins_computelistBB.ratelist}" var="list"      id="setlist"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle_left,td_middle_center,td_middle,td_middle_center"
                         styleClass="table03" width="100%">

                <h:column>
                    <c:facet name="header"><h:outputText value="操作"/></c:facet>
                    <h:commandButton styleClass="button01"  onclick="doShowBase('#{list.setID}');" value="审批" rendered="#{list.status=='2'}">
                    </h:commandButton>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="账套名称"/></c:facet>
                    <h:outputText value="#{list.setName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="基数开始时间"/></c:facet>
                    <h:outputText value="#{list.startDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="基数结束时间"/></c:facet>
                    <h:outputText value="#{list.endDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="最后计算日期"/></c:facet>
                    <h:outputText value="#{list.calcDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="状态"/></c:facet>
                    <h:outputText value="#{list.statusDes}"/>
                </h:column>

            </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
     </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:setlist");
</script>
