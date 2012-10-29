<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

  <script type="text/javascript">
       function checkDate(){
          if (document.all("form1:field").value=="-1"){
              alert("请选择汇总项目!");
              return false;
          }
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

  <x:saveState value="#{wage_queryBB}"></x:saveState>
  <h:form id="form1">
      <h:inputHidden value="#{wage_queryBB.pageInit}"/>
<f:verbatim>
      <br>
      <table width=100% height=96% border=0 >
      <tr><td height=8px>
</f:verbatim>
          <h:panelGrid columns="4">
              <h:panelGroup>
                      <h:outputText value="薪资账套:"></h:outputText>
                      <h:selectOneMenu id = "setId" value="#{wage_queryBB.setId}" onchange="submit();" valueChangeListener="#{wage_queryBB.changeSet}">
                           <c:selectItems value="#{wage_queryBB.setList}"/>
                      </h:selectOneMenu>
              </h:panelGroup>

              <h:panelGroup>
                  <h:outputText value="汇总项目:"></h:outputText>
                  <h:selectOneMenu id="field" value="#{wage_queryBB.field}">
                      <c:selectItems value="#{wage_queryBB.fieldList}"></c:selectItems>
                  </h:selectOneMenu>
              </h:panelGroup>


              <h:panelGroup>
                  <h:outputText value="       开始时间" />
                  <h:inputText styleClass="input" id="beginTime" size="12" alt="开始时间|0|d" value="#{wage_queryBB.beginTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTime')"></f:verbatim>

                  <h:outputText value="       结束时间" />
                  <h:inputText styleClass="input" id="endTime" alt="结束时间|0|d" size="12" value="#{wage_queryBB.endTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:endTime')"></f:verbatim>
              </h:panelGroup>

              <h:panelGroup>
                  <h:commandButton value="查询" onclick="return checkDate();" styleClass="button01" action="#{wage_queryBB.dosumQuery}"></h:commandButton>
                  <h:commandButton value="导出" styleClass="button01" onclick="doExport2()"></h:commandButton>
                  <h:commandButton value="返回" styleClass="button01" onclick="window.close()"></h:commandButton>
              </h:panelGroup>
          </h:panelGrid>
<f:verbatim>
      </td>
      </tr>
      <tr><td>
      <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
          <jsp:param name="hasOperSign" value="true"/>
          <jsp:param name="operSignType" value="checkbox"/>
          <jsp:param name="hasEdit" value="false"/>
          <jsp:param name="isEditList" value="false"/>
          <jsp:param name="isCheckRight" value="false"/>
          <jsp:param name="keyName" value="ID"/>
          <jsp:param name="fixcol" value="2"/>
      </jsp:include>
      </td></tr>
      </table>
</f:verbatim>
  </h:form>
