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
      <h:inputHidden value="#{wage_queryBB.pageInit}"></h:inputHidden>
      <f:verbatim>
      <table width="98%" height="96%" border="0" cellpadding="0" cellspacing="0" align="center">
          <tr>
             <td class="td_title"  height=8 colspan=3>
      </f:verbatim>
                 <h:graphicImage value="/images/tips.gif" />
                 <h:outputText value=" 薪资信息查询"/>
      <f:verbatim>
             </td>
         </tr>
          <tr><td height=8 colspan=3></td></tr>
          <tr>
              <td height=8 colspan=3>
      </f:verbatim>
                  <h:outputText escape="false" value="<strong>薪资账套：</strong>"></h:outputText>
                  <h:selectOneMenu id = "setId" value="#{wage_queryBB.setId}" >
                       <c:selectItems value="#{wage_queryBB.setList}"/>
                  </h:selectOneMenu>
                  <h:outputText escape="false" value="<strong>  请输入姓名编号或简拼:</strong>" />
                  <h:inputText  id="nameStr" value="#{wage_queryBB.nameStr}" style="width:140px"/>
                  <h:commandButton value="查询人员" onclick="return checkquery();" styleClass="button01" id="addMany" action="#{wage_queryBB.addMany}" />
      <f:verbatim>
              </td>
           </tr>
          <tr><td height=8 colspan=3></td></tr>
           <tr>
              <td height=8 >
      </f:verbatim>
                  <h:outputText escape="false" value="<strong>请选择：</strong>"></h:outputText>
                  <h:selectOneMenu value="#{wage_queryBB.code}">
                      <c:selectItems value="#{wage_queryBB.pids}"></c:selectItems>
                  </h:selectOneMenu>
                  <h:outputText escape="false" value="&nbsp;&nbsp;<strong>开始时间</strong>" />
                  <h:inputText styleClass="input" id="beginTime" size="12" alt="开始时间|0|d" value="#{wage_queryBB.beginTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTime')"></f:verbatim>

                  <h:outputText escape="false" value="&nbsp;&nbsp;<strong>结束时间</strong>" />
                  <h:inputText styleClass="input" id="endTime" alt="结束时间|0|d" size="12" value="#{wage_queryBB.endTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:endTime')"></f:verbatim>
      <f:verbatim>
              </td>
               <td align="left">
      </f:verbatim>
                  <h:selectOneRadio value="#{wage_queryBB.showCur}">
                      <c:selectItem itemValue="true" itemLabel="包含正计算数据"></c:selectItem>
                      <c:selectItem itemValue="false" itemLabel="不包含正计算数据"></c:selectItem>
                  </h:selectOneRadio>
      <f:verbatim>
              </td>
               <td>
      </f:verbatim>
                  <h:commandButton value="查询薪酬" id="query" onclick="return checkDate();" styleClass="button01" action="#{wage_queryBB.beginQuery}" />
                  <h:commandButton value="导出" styleClass="button01" onclick="ExportShowTable();"></h:commandButton>
      <f:verbatim>
              </td>
          </tr>

          <tr>
              <td  height=5 colspan=3>
          </tr>
          <tr>
              <td colspan=3>
                  <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                      <jsp:param name="para" value="true"/>
                  </jsp:include>
              </td>
          </tr>
      </table>
      </f:verbatim>      
  </h:form>
