<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   <base target="_self">
    <script type="text/javascript">
        function checkquery(){
            if (document.all("form1:nameStr").value==""){
                alert("�������ѯ����!");
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
          alert("�����뿪ʼʱ��ͽ���ʱ��");
          return false;
        }else if(startDate>endDate){
          alert("��ʼʱ�����ڽ���ʱ��");
          return false;
        }
        else
          return true;
     }
    </script>

  <x:saveState value="#{wage_queryBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_queryBB.pageInit}"></h:inputHidden>
     <f:verbatim>
      <table width="100%" border="0">
      <tr >
         <td class="td_title">
      </f:verbatim>
             <h:graphicImage value="/images/tips.gif" />
             <h:outputText value=" ������Ϣ��ѯ"/>
      <f:verbatim>
         </td>
          <td align="right" class="td_title">
      </f:verbatim>
              <h:commandButton value="����excel" type="button" styleClass="button01" onclick="exportToExcel('ShowTable');" />
<f:verbatim>
          </td>
     </tr>
     </table>

      <table  width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr>
              <td>
</f:verbatim>
                  <h:outputText value="н�����ף�"></h:outputText>
                  <h:selectOneMenu id = "setId" value="#{wage_queryBB.setId}"  >
                       <c:selectItems value="#{wage_queryBB.setList}"/>
                  </h:selectOneMenu>
<f:verbatim>
              </td>
              <td>
</f:verbatim>
                  <h:outputText value="��������:" />
                  <h:inputText  id="nameStr" value="#{wage_queryBB.nameStr}" style="width:140px"/>
                  <h:commandButton value="��ѯ" onclick="return checkquery();" styleClass="button01" id="addMany" action="#{wage_queryBB.addManyInInsurace}" />
      <f:verbatim>
                    </td>
                    <td>
      </f:verbatim>
                  <h:outputText value="��ѡ��"></h:outputText>
                  <h:selectOneMenu value="#{wage_queryBB.code}">
                      <c:selectItems value="#{wage_queryBB.pids}"></c:selectItems>
                  </h:selectOneMenu>
                  <h:outputText value="       ��ʼʱ��" />
                  <h:inputText styleClass="input" id="beginTime" size="12" alt="��ʼʱ��|0|d" value="#{wage_queryBB.beginTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTime')"></f:verbatim>

                  <h:outputText value="       ����ʱ��" />
                  <h:inputText styleClass="input" id="endTime" alt="����ʱ��|0|d" size="12" value="#{wage_queryBB.endTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:endTime')"></f:verbatim>

                  <h:commandButton value="��ʼ��ѯ" id="query" onclick="return checkDate();" styleClass="button01" action="#{wage_queryBB.beginQueryInsurace}" />
                  <h:commandButton value="����" styleClass="button01" onclick="ExportShowTable();"></h:commandButton>
<f:verbatim>
              </td>
          </tr>
      </table>
      
      <br>
      <jsp:include page="/pages/common/activepage/ShowTable.jsp">
          <jsp:param name="para" value="true"/>
      </jsp:include>
</f:verbatim>      
  </h:form>
