<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
     function forSel() {
           if(PopUpMutilCodeDlgForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                  document.forms(0).all('form1:count').click();
           }
      }
     function doShowItem() {
         var reval = window.showModalDialog("/wage/payoff/GroupShowItemEdit.jsf", null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
         if (reval != null) {
             form1.all('form1:str').value = reval;
             return true;
         } else {
             return false;
         }
     }
     function OpenRpt(){
         if (document.all("form1:ReportID").value=="-1"){
             alert("����ѡ������ʽ��");
             return false;
         }
         var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+document.all('form1:yearmonth1').value;
         window.open(url);
         return false;
     }

    </script>

  <x:saveState value="#{ins_groupBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{ins_groupBB.pageInit}"/>
      <h:inputHidden id="str" value=""/>
     <f:verbatim>
      <table  width="100%" border="0" height="98%" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title" height=8>
                      <img src="/images/tips.gif" >���սɷѻ������
              </td>
          </tr>

          <tr>
               <td  align="left" height=8>
     </f:verbatim>
                   <h:outputText value="��ʼʱ��"></h:outputText>
                   <h:inputText readonly="true" id="yearmonth1" value="#{ins_groupBB.beginDate}"></h:inputText>
                   <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:yearmonth1')"/>

                   <h:outputText value="����ʱ��"></h:outputText>
                   <h:inputText readonly="true" id="yearmonth2" value="#{ins_groupBB.endDate}"></h:inputText>
                   <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:yearmonth2')"/>

                   <h:commandButton  styleClass="button01" value="��ѯ" action="#{ins_groupBB.doQuery}"/>
                   <h:commandButton type="button" styleClass="button01" value="����" onclick="doExport();"/>

                   <h:selectOneMenu id="ReportID" style="width:190px">
                       <c:selectItems value="#{ins_groupBB.reportList}"/>
                   </h:selectOneMenu>
                   <h:commandButton value="Excel��ʾ" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
       <f:verbatim>
               </td>
          </tr>

          <tr>
              <td >
                  <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                      <jsp:param name="hasOperSign" value="false"/>
                      <jsp:param name="operSignType" value="checkbox"/>
                      <jsp:param name="hasEdit" value="false"/>
                      <jsp:param name="isEditList" value="false"/>
                      <jsp:param name="isCheckRight" value="false"/>
                  </jsp:include>
              </td>
          </tr>
      </table>
      </f:verbatim>
  </h:form>
