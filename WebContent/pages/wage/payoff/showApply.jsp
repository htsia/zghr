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
                    <h:commandButton value="���븴��" styleClass="button01"
                                     action="#{wage_flowBB.submitCheckApply}" onclick=" return confirm('��ȷ���ύ?');">
                    </h:commandButton>
                    <h:commandButton value="�ر�" type="button" onclick="window.close();" styleClass="button01"></h:commandButton>
<c:verbatim>
                </td>
            </tr>

           <tr><td height=8>
</c:verbatim>
               <h:outputText escape="false"  value="<strong>#{wage_flowBB.multiDes}</strong><br>" rendered="#{wage_flowBB.multiPerson}"/>
               <h:outputText escape="false"  value="<strong>#{wage_flowBB.multiInputDes}</strong><br><br>" rendered="#{wage_flowBB.multiInputPerson}"/>
    
               <h:outputText escape="false" value="<strong>���ף�</strong>#{wage_flowBB.setName}"></h:outputText>
               <c:verbatim><br></c:verbatim>
               <h:outputText escape="false" value="<strong>��λ��</strong>#{wage_flowBB.unitName}"></h:outputText>
               <c:verbatim><br><br></c:verbatim>
    
               <h:outputText escape="false"  value="<strong>������ʱ��:</strong>#{wage_flowBB.date.calcDate}"/>
               <h:commandButton styleClass="button01" type="button" value="�鿴������ʷ" onclick="showHis();"></h:commandButton>
               <c:verbatim><br></c:verbatim>
               <h:outputText escape="false" value="<strong>����������ʱ��:</strong>#{wage_flowBB.date.updateDate}"/>
               <h:commandButton styleClass="button01" type="button" value="�鿴������ʷ" onclick="showHisData();"></h:commandButton>
               <c:verbatim><br><br></c:verbatim>

               <h:outputText escape="false" value="<strong>�ܼ�����:</strong>#{wage_flowBB.allCount}"/>
               <h:outputText escape="false" value="<strong>�������ݣ�</strong>#{wage_flowBB.errData}"/>
               <c:verbatim><br></c:verbatim>
               <h:outputText escape="false" value="<strong>ʵ��Ϊ����Ա��</strong>#{wage_flowBB.negative}"/>
<c:verbatim>
           </td></tr>

           <tr><td>
               <div style='width:100%;height:100%;overflow:auto' id=datatable>
               <br>
</c:verbatim>
              <h:outputText escape="false" value="<strong>�ܶ�������:</strong>" rendered="#{sys_commonInfoBB.wagesumControl}"></h:outputText>
              <h:dataTable rendered="#{sys_commonInfoBB.wagesumControl}" width="420" var="sumList" value="#{wage_flowBB.controlList}" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle" id="grossList">
                  <h:column>
                      <c:facet name="header"><h:outputText value="������Ŀ" style="width:220px"/></c:facet>
                      <h:outputText value="#{sumList.title}"/>
                  </h:column>
                  <h:column>
                      <c:facet name="header"><h:outputText value="�ܶ�" style="width:100px"/></c:facet>
                      <h:outputText value="#{sumList.sumLimit}"/>
                  </h:column>

                  <h:column>
                      <c:facet name="header"><h:outputText value="�ۼ�" style="width:100px"/></c:facet>
                      <h:outputText value="#{sumList.curSum}"/>
                  </h:column>
              </h:dataTable>
              <c:verbatim><br></c:verbatim>
              <h:outputText escape="false" value="<strong>���������:</strong>"></h:outputText>
              <h:dataTable value="#{wage_flowBB.timeList}" var="list" align="left"  id="dateList"
                 headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle"
                 styleClass="table03"  >
                    <h:column>
                        <c:facet name="header"><h:outputText value="�ϱ����" style="width:220px"/></c:facet>
                        <h:outputText value="#{list.rptDesc}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="��������" style="width:100px"/></c:facet>
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