<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
    <script type="text/javascript">
        function checkquery(){
            if (document.all("form1:nameStr").value==""){
                alert("请输入查询条件!");
                return false;
            }
            return true;
        }
        function forSel() {
           if(PopUpMutilCodeDlgForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                  document.forms(0).all('form1:count').click();
           }
      }
     function checkDate(){
        var endDate = document.all("form1:endTime").value;
        var startDate = document.all("form1:beginTime").value;
        if(startDate==null||startDate==""||endDate==null||endDate==""){
          alert("请输入开始时间和结束时间");
          return false;
        }else if(startDate>endDate){
          alert("开始时间晚于结束时间");
          return false;
        }
        else
          return true;
     }

    </script>

  <x:saveState value="#{wage_queryBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_queryBB.personQuery}"></h:inputHidden>
      <h:inputHidden value="#{wage_queryBB.showCur}"></h:inputHidden>
<f:verbatim>
      <table width="100%" height=98%>
          <tr>
             <td class="td_title" colspan=2 height=8>
</f:verbatim>
                 <h:graphicImage value="/images/tips.gif" />
                 <h:outputText value=" 薪资信息查询"/>
<f:verbatim>
             </td>
         </tr>

          <tr>
              <td height=8>
</f:verbatim>
                  <h:outputText value="姓名" />
                  <h:inputText  readonly="true" id="nameStr" value="#{wage_queryBB.nameStr}" style="width:140px"/>
                  <h:inputHidden value="#{wage_queryBB.code}"></h:inputHidden>
<f:verbatim>
              </td>
              <td height=8>
</f:verbatim>
                  <h:outputText value="       开始时间" />
                  <h:inputText styleClass="input" id="beginTime" size="12" alt="开始时间|0|d" value="#{wage_queryBB.beginTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTime')"></f:verbatim>

                  <h:outputText value="       结束时间" />
                  <h:inputText styleClass="input" id="endTime" alt="结束时间|0|d" size="12" value="#{wage_queryBB.endTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:endTime')"></f:verbatim>

                  <h:commandButton value="开始查询" id="query" onclick="return checkDate();" styleClass="button01" action="#{wage_queryBB.beginQuery}" />
                  <h:commandButton value="导出" styleClass="button01" onclick="ExportShowTable();"></h:commandButton>
<f:verbatim>
              </td>
          </tr>
          <tr><td colspan=2>
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="para" value="true"/>
              </jsp:include>
          </td></tr>
      </table>
</f:verbatim>
  </h:form>
