<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
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

     function OpenRpt(){
         if (document.all("form1:ReportID").value=="-1"){
             alert("����ѡ������ʽ��");
             return false;
         }

         if (document.all("form1:curMonth").value==""){
             alert("����ѡ��ʱ��!");
             return false;
         }

         var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&Where="+document.all("form1:curMonth").value;
         window.open(url);
         return false;
     }

    </script>

  <x:saveState value="#{emp_PersonCountBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{emp_PersonCountBB.initAllShow}"/>
      <h:inputHidden id="str" value=""/>
<f:verbatim>
      <table  width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title" >
                      <img src="/images/tips.gif" />
                   <%=LanguageSupport.getResource("RYGL-2259","��Ա�䶯�������")%>
              </td>
          </tr>

          <tr>
               <td  align="left">
</f:verbatim>
                   <h:outputText value="ʱ��"></h:outputText>
                   <h:selectOneMenu id="curMonth" value="#{emp_PersonCountBB.curMonth}">
                       <c:selectItems value="#{emp_PersonCountBB.months}"></c:selectItems>
                   </h:selectOneMenu>

                   <h:commandButton  styleClass="button01" value="��ѯ" action="#{emp_PersonCountBB.doQuery}"/>
                   <h:commandButton type="button" styleClass="button01" value="����" onclick="doExport();"/>

                   <h:selectOneMenu id="ReportID" style="width:190px">
                       <c:selectItems value="#{emp_PersonCountBB.reportList}"/>
                   </h:selectOneMenu>
                   <h:commandButton value="Excel��ʾ" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
  <f:verbatim>
               </td>
          </tr>
          <tr><td>
              <jsp:include page="/pages/common/activepage/ShowTable.jsp" >
                  <jsp:param name="" value=""></jsp:param>
              </jsp:include>
          </td></tr>
      </table>
</f:verbatim>      
  </h:form>
