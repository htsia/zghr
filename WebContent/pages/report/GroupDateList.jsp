<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function forAddDate() {
        reval = window.showModalDialog("/report/DateEdit.jsf", null, "dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
        if (reval != null && reval != "") {
            var arg = reval.split("|");
            form1.all('form1:date').value = arg[0];
            form1.all('form1:desc').value = arg[1];
            return true;
        } else {
            return false;
        }
    }
</script>

<x:saveState value="#{Rpt_GroupIndexBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{Rpt_GroupIndexBB.pageInit}"/>
    <h:inputHidden id="date" value="#{Rpt_GroupIndexBB.date.staticdate}"/>
    <h:inputHidden id="desc" value="#{Rpt_GroupIndexBB.date.description}"/>

    <f:verbatim>
    <table height=98% width=98% align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF" >
        <tr>
            <td class=td_title colspan=2 height=8>
    </f:verbatim>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" 报表管理 ->  集团报表"/>
<f:verbatim>
            </td>
        </tr>

        <tr><td colspan=2 height=8>
        </td></tr>

        <tr>
            <td>
</f:verbatim>
                <h:outputText value="统计单位:#{Rpt_GroupIndexBB.unitName}"></h:outputText>
<f:verbatim>
            </td>
            <td align=right height=8>
</f:verbatim>
            <h:outputText value="报套："></h:outputText>
            <h:selectOneMenu value="#{Rpt_GroupIndexBB.setID}" onchange="submit()"  valueChangeListener="#{Rpt_GroupIndexBB.changeDateList}">
                <c:selectItems value="#{Rpt_GroupIndexBB.setList}"></c:selectItems>
            </h:selectOneMenu>

              <h:commandButton value="新建统计日期" action="#{Rpt_GroupIndexBB.saveDate}" styleClass="button01"  onclick="return forAddDate();"/>
<f:verbatim>
           </td>
        </tr>

        <tr><td height=8>
        </td></tr>

        <tr>
            <td colspan=2>
                <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
                    <h:dataTable value="#{Rpt_GroupIndexBB.dateList}" var="list" align="center"  id="dateList"
                                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                                         styleClass="table03" width="90%" >
                                <h:column>
                                    <c:facet name="header"><h:outputText value="统计日期"/></c:facet>
                                    <h:outputText value="#{list.staticdate}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="表套"/></c:facet>
                                    <h:outputText value="#{list.setName}"/>
                                </h:column>
                        
                                <h:column>
                                    <c:facet name="header"><h:outputText value="统计人员"/></c:facet>
                                    <h:outputText value="#{list.createID}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="状态"/></c:facet>
                                    <h:outputText value="#{list.stautsDes}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="操作"/></c:facet>
                                    <h:commandButton value="打开" action="#{Rpt_GroupIndexBB.beginStatic}"  rendered="#{list.stauts=='0'}"  styleClass="button01" >
                                        <x:updateActionListener property="#{Rpt_GroupIndexBB.processDate}" value="#{list.staticdate}"/>
                                        <x:updateActionListener property="#{Rpt_GroupIndexBB.dateId}" value="#{list.itemID}"/>
                                        <x:updateActionListener property="#{Rpt_GroupIndexBB.setID}" value="#{list.rptSet}"/>
                                    </h:commandButton>

                                    <h:commandButton value="查看" action="#{Rpt_GroupIndexBB.beginHisView}"   rendered="#{list.stauts!='0'}" styleClass="button01" >
                                        <x:updateActionListener property="#{Rpt_GroupIndexBB.processDate}" value="#{list.staticdate}"/>
                                    </h:commandButton>

                                </h:column>
                            </h:dataTable>
<f:verbatim>
                </div>
            </td>
        </tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>