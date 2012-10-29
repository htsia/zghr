<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String setID=request.getParameter("SetID");
    String PayoffMonth=request.getParameter("PayoffMonth");
    
%>
<x:saveState value="#{wage_setPersonChangeBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{wage_setPersonChangeBB.showMonth}"></h:inputHidden>
<c:verbatim>
<table height=98% width=98% align="center">
    <tr>
        <td align="center" width="16%" class=activeTab>&nbsp;<a href="/wage/payoff/showPersonChangeByMonth.jsf?Mode=1&SetID=<%=setID%>&PayoffMonth=<%=PayoffMonth%>">增加情况</a></td>
        <td align="center" width="16%" class=tab>&nbsp;<a href="/wage/payoff/showPersonChangeByMonth2.jsf?Mode=0&SetID=<%=setID%>&PayoffMonth=<%=PayoffMonth%>">减少情况</a></td>
        <td align="center" width="16%" class=tab>&nbsp;<a href="showChangeRecord.jsf?SetID=<%=setID%>&PayoffMonth=<%=PayoffMonth%>">变动情况</a></td>
    </tr>
   
    <tr><td colspan=3>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
        <x:dataTable value="#{wage_setPersonChangeBB.personList}" var="list"  rowIndexVar="index" id="data"
                             headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                             rowClasses="td_middle" styleClass="table03" width="95%" border="0">
                    <h:column>
                        <c:facet name="header"><h:outputText value="序号"/></c:facet>
                        <h:outputText value="#{index+1}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
                        <h:outputText value="#{list.personCode}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                        <h:outputText value="#{list.personName}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="薪资部门"/></c:facet>
                        <h:outputText value="#{list.wageDetp}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="变化日期"/></c:facet>
                        <h:outputText value="#{list.changeDate}"/>
                    </h:column>


            <h:column>
                <c:facet name="header"><h:outputText value="增减情况"/></c:facet>
                <h:outputText value="#{list.addorminus}"/>
            </h:column>

        </x:dataTable>
<c:verbatim>
        </div>
    </td></tr>
</c:verbatim>    
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:data");
</script>