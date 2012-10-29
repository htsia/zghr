<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<c:verbatim>
    <script type="text/javascript">
        function showHis(){
            window.showModalDialog("/wage/payoff/showComputerHis.jsf?dateID="+document.all('form1:dateID').value, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
                
        function showHisData(){
            window.showModalDialog("/wage/payoff/showDataInfo.jsf?dateID="+document.all('form1:dateID').value, null, "dialogWidth:650px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>
</c:verbatim>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{wage_flowBB.initApply}"></h:inputHidden>
      <h:inputHidden id="dateID" value="#{wage_flowBB.date.dateId}"></h:inputHidden>
<c:verbatim>
       <table height=98% width=100% align="center">
            <tr>
                 <td height=8 align="right" class="td_title">
</c:verbatim>
                    <h:commandButton value="申请复核" styleClass="button01"
                                     action="#{wage_flowBB.submitCheckApply}" onclick=" return confirm('您确认提交?');">
                    </h:commandButton>
                    <h:commandButton value="关闭" type="button" onclick="window.close();" styleClass="button01"></h:commandButton>
<c:verbatim>
                </td>
            </tr>

           <tr><td height=8>
</c:verbatim>
               <h:outputText escape="false"  value="<strong>#{wage_flowBB.multiDes}</strong><br>" rendered="#{wage_flowBB.multiPerson}"/>
               <h:outputText escape="false"  value="<strong>#{wage_flowBB.multiInputDes}</strong><br><br>" rendered="#{wage_flowBB.multiInputPerson}"/>
    
               <h:outputText escape="false" value="<strong>帐套：</strong>#{wage_flowBB.setName}"></h:outputText>
               <c:verbatim><br></c:verbatim>
               <h:outputText escape="false" value="<strong>单位：</strong>#{wage_flowBB.unitName}"></h:outputText>
               <c:verbatim><br><br></c:verbatim>
    
               <h:outputText escape="false"  value="<strong>最后计算时间:</strong>#{wage_flowBB.date.calcDate}"/>
               <h:commandButton styleClass="button01" type="button" value="查看计算历史" onclick="showHis();"></h:commandButton>
               <c:verbatim><br></c:verbatim>
               <h:outputText escape="false" value="<strong>最后更新数据时间:</strong>#{wage_flowBB.date.updateDate}"/>
               <h:commandButton styleClass="button01" type="button" value="查看更新历史" onclick="showHisData();"></h:commandButton>
               <c:verbatim><br><br></c:verbatim>

               <h:outputText escape="false" value="<strong>总计人数:</strong>#{wage_flowBB.allCount}"/>
               <h:outputText escape="false" value="<strong>错误数据：</strong>#{wage_flowBB.errData}"/>
               <c:verbatim><br></c:verbatim>
               <h:outputText escape="false" value="<strong>实发为负人员：</strong>#{wage_flowBB.negative}"/>
<c:verbatim>
           </td></tr>

           <tr><td>
               <div style='width:100%;height:100%;overflow:auto' id=datatable>
               <br>
</c:verbatim>
              <h:outputText escape="false" value="<strong>总额控制情况:</strong>" rendered="#{sys_commonInfoBB.wagesumControl}"></h:outputText>
              <h:dataTable rendered="#{sys_commonInfoBB.wagesumControl}" width="420" var="sumList" value="#{wage_flowBB.controlList}" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle" id="grossList">
                  <h:column>
                      <c:facet name="header"><h:outputText value="控制项目" style="width:220px"/></c:facet>
                      <h:outputText value="#{sumList.title}"/>
                  </h:column>
                  <h:column>
                      <c:facet name="header"><h:outputText value="总额" style="width:100px"/></c:facet>
                      <h:outputText value="#{sumList.sumLimit}"/>
                  </h:column>

                  <h:column>
                      <c:facet name="header"><h:outputText value="累计" style="width:100px"/></c:facet>
                      <h:outputText value="#{sumList.curSum}"/>
                  </h:column>
              </h:dataTable>
              <c:verbatim><br></c:verbatim>
              <h:outputText escape="false" value="<strong>审批表情况:</strong>"></h:outputText>
              <h:dataTable value="#{wage_flowBB.timeList}" var="list" align="left"  id="dateList"
                 headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle"
                 styleClass="table03"  >
                    <h:column>
                        <c:facet name="header"><h:outputText value="上报表格" style="width:220px"/></c:facet>
                        <h:outputText value="#{list.rptDesc}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="生成日期" style="width:100px"/></c:facet>
                        <h:outputText value="#{list.crDate}"/>
                    </h:column>
                  </h:dataTable>
<c:verbatim>
               </div>
           </td></tr>
        </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
   setDataTableOver("form1:grossList");
</script>