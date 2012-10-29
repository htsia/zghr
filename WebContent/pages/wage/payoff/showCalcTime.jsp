<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<base target="_self">
<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{wage_flowBB.initShowTime}"></h:inputHidden>
       <table height=98% width=98% align="center">
           <tr><td height=8>
               <h:outputText value="最后计算时间：#{wage_flowBB.date.calcDate}"></h:outputText>
           </td></tr>

           <tr><td>
               <div style='width:100%;height:100%;overflow:auto' id=datatable>
                   <x:dataTable value="#{wage_flowBB.timeList}" var="list" align="center"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle"
                     styleClass="table03"  rowIndexVar="index">
                       <h:column>
                           <c:facet name="header"><h:outputText value="序号" style="width:40px"  /></c:facet>
                           <h:outputText value="#{index+1}"/>
                       </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="表格" style="width:240px"  /></c:facet>
                                <h:outputText value="#{list.rptDesc}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="生成日期" style="width:140px"/></c:facet>
                                <h:outputText value="#{list.crDate}"/>
                            </h:column>

                           <h:column>
                               <c:facet name="header"><h:outputText value="操作" style="width:40px"/></c:facet>
                               <h:commandButton value="删除" styleClass="button01" action="#{wage_flowBB.deleteFlowRpt}">
                                   <x:updateActionListener property="#{wage_flowBB.flowRptID}" value="#{list.title}"></x:updateActionListener>
                               </h:commandButton>
                           </h:column>

                      </x:dataTable>
               </div>    
           </td></tr>
        </table>
</h:form>
