<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

      <c:verbatim><base target="_self"></c:verbatim>
      <script type="text/javascript">
           function  selectItems(){
               var reval = window.showModalDialog("/wage/payoff/SelectItems.jsf?setId="+document.all('form1:setId').value, null, "dialogWidth:400px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
               if (reval != null) {
                   var val=reval.split("|");
                   document.all("form1:fieldstrDes").value=val[0];
                   document.all("form1:fieldstr").value=val[1];
               }
               return false;
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

  <h:form id="form1">
      <x:saveState value="#{wage_queryBB}"></x:saveState>
      <h:inputHidden value="#{wage_queryBB.pageInit2}"/>
<f:verbatim>
      <table width=100% height=96% border=0 >
      <tr><td height=20px valign="bottom">
</f:verbatim>
          <h:panelGrid columns="4">
              <h:panelGroup>
                      <h:outputText value="薪资账套:"></h:outputText>
                      <h:selectOneMenu id = "setId" value="#{wage_queryBB.setId}" onchange="submit();" valueChangeListener="#{wage_queryBB.changeSet}">
                           <c:selectItems value="#{wage_queryBB.setList}"/>
                      </h:selectOneMenu>
              </h:panelGroup>

              <h:panelGroup>
                  <h:outputText value="汇总项目:"  ></h:outputText>
                  <h:inputText id="fieldstrDes" readonly="true" style="width:250px" value="#{wage_queryBB.fieldstrDes}"  />
                  <h:inputHidden id="fieldstr" value="#{wage_queryBB.fieldstr}"  />
                  <h:commandButton value="选取" onclick="return selectItems();" type="button" styleClass="button01"></h:commandButton>
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
                  <h:commandButton value="查询" onclick="return checkDate();" styleClass="button01" action="#{wage_queryBB.dosumQuery2}"></h:commandButton>
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
