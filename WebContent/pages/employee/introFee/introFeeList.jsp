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
           <h:outputText value="���ܷѹ���"/>
     <f:verbatim>
      </td></tr>
     <tr><td height=8 align="right">
    </f:verbatim>
         <h:panelGroup>
             <h:outputText value="��¼��:#{emp_introFeeBB.pagevo.totalRecord}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ҳ��:#{emp_introFeeBB.pagevo.totalPage}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ÿҳ��#{emp_introFeeBB.pagevo.pageSize}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="��ǰΪ��#{emp_introFeeBB.pagevo.currentPage}ҳ"></h:outputText>
             <h:commandButton value="��ҳ" action="#{emp_introFeeBB.first}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{emp_introFeeBB.pre}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{emp_introFeeBB.next}" styleClass="button01"></h:commandButton>
             <h:commandButton value="βҳ" action="#{emp_introFeeBB.last}" styleClass="button01"></h:commandButton>
             <h:commandButton value="����" type="button" onclick="doFee();" styleClass="button01"></h:commandButton>
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
                    <c:facet name="header"><h:outputText value="��������"/></c:facet>
                    <h:outputText value="#{list.startDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����"/></c:facet>
                    <h:outputText value="#{list.personName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="�ܶ�"/></c:facet>
                    <h:outputText value="#{list.feeSum}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="���"/></c:facet>
                    <h:outputText value="#{list.balance}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="��һ�η���ʱ��"/></c:facet>
                    <h:outputText value="#{list.firstDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="��һ�η��Ž��"/></c:facet>
                    <h:outputText value="#{list.firstFee}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="�ڶ��η���ʱ��"/></c:facet>
                    <h:outputText value="#{list.secondDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="�ڶ��η��Ž��"/></c:facet>
                    <h:outputText value="#{list.secondFee}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="�����η���ʱ��"/></c:facet>
                    <h:outputText value="#{list.thirdDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="�����η��Ž��"/></c:facet>
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
