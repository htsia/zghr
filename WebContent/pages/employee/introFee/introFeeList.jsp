<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function doFee(){
        window.showModalDialog("/employee/introFee/FeePayOffList.jsf", null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
    }
</script>

<x:saveState value="#{emp_introFeeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emp_introFeeBB.pageInit}"></h:inputHidden>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8 class=td_title>
    </f:verbatim>
           <h:graphicImage value="/images/tips.gif" />
           <h:outputText value="介绍费管理"/>
     <f:verbatim>
      </td></tr>
     <tr><td height=8 align="right">
    </f:verbatim>
         <h:panelGroup>
             <h:outputText value="记录数:#{emp_introFeeBB.pagevo.totalRecord}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="页数:#{emp_introFeeBB.pagevo.totalPage}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="每页有#{emp_introFeeBB.pagevo.pageSize}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="当前为第#{emp_introFeeBB.pagevo.currentPage}页"></h:outputText>
             <h:commandButton value="首页" action="#{emp_introFeeBB.first}" styleClass="button01"></h:commandButton>
             <h:commandButton value="上页" action="#{emp_introFeeBB.pre}" styleClass="button01"></h:commandButton>
             <h:commandButton value="下页" action="#{emp_introFeeBB.next}" styleClass="button01"></h:commandButton>
             <h:commandButton value="尾页" action="#{emp_introFeeBB.last}" styleClass="button01"></h:commandButton>
             <h:commandButton value="发放" type="button" onclick="doFee();" styleClass="button01"></h:commandButton>
         </h:panelGroup>
    <f:verbatim>
     </td></tr>
     <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </f:verbatim>
            <h:dataTable value="#{emp_introFeeBB.dataList}" var="list" align="center"  id="dateList"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                         styleClass="table03" width="100%" >
                <h:column>
                    <c:facet name="header"><h:outputText value="分配日期"/></c:facet>
                    <h:outputText value="#{list.startDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                    <h:outputText value="#{list.personName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="总额"/></c:facet>
                    <h:outputText value="#{list.feeSum}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="余额"/></c:facet>
                    <h:outputText value="#{list.balance}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="第一次发放时间"/></c:facet>
                    <h:outputText value="#{list.firstDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="第一次发放金额"/></c:facet>
                    <h:outputText value="#{list.firstFee}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="第二次发放时间"/></c:facet>
                    <h:outputText value="#{list.secondDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="第二次发放金额"/></c:facet>
                    <h:outputText value="#{list.secondFee}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="第三次发放时间"/></c:facet>
                    <h:outputText value="#{list.thirdDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="第三次发放金额"/></c:facet>
                    <h:outputText value="#{list.thirdFee}"/>
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
