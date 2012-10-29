<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

      <script type="text/javascript">
        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }

            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+document.all('form1:beginTime').value;
            window.open(url);
            return false;
        }
        function beginGroup(){
            if (document.all("form1:beginTime").value=="" || document.all("form1:endTime").value==""){
                alert("请先汇总时间");
                return false;
            }

            if (document.all("form1:sortList").value=="-1") {
                alert("没有选择汇总信息项");
                return false;
            }
            else{
               window.showModalDialog("/insurace/ShowGroup.jsf?timeField="+document.all("form1:timeField").value+"&beginTime="+document.all("form1:beginTime").value+"&endTime="+document.all("form1:endTime").value+"&setId=" + form1.all("form1:setId").value+"&groupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            }
            return false;
        }

    </script>

  <x:saveState value="#{emp_busiqueryBB}"/>
  <h:form id="form1">
      <f:verbatim>
      <table  border="0"  height=98% width=98% align="center" cellSpacing=0 id=main>
          <tr >
             <td class="td_title" height=2>
       </f:verbatim>
                 <h:inputHidden value="#{emp_busiqueryBB.pageInit}"></h:inputHidden>
                 <h:inputHidden id="setId" value="#{emp_busiqueryBB.setId}"></h:inputHidden>
                 <h:inputHidden value="#{emp_busiqueryBB.setName}"></h:inputHidden>
                 <h:inputHidden id="timeField" value="#{emp_busiqueryBB.timeField}"></h:inputHidden>
                 <h:inputHidden value="#{emp_busiqueryBB.operateID}"></h:inputHidden>
                 <h:graphicImage value="/images/tips.gif" />
                 <h:outputText value="#{emp_busiqueryBB.setName}"/>
<f:verbatim>
             </td>
              <td align="right" class="td_title" height=2>
</f:verbatim>
                  <h:commandButton value="导出excel" type="button" styleClass="button01" onclick="doExport();" />
<f:verbatim>
              </td>
         </tr>

          <tr>
              <td height=2>
</f:verbatim>
                   <f:verbatim>
		        	<%=LanguageSupport.getResource("RYGL-2193","姓名或编号")%>:
		        </f:verbatim>   
                  
                  <h:inputText  id="nameStr" value="#{emp_busiqueryBB.nameStr}" style="width:140px"/>
                  <h:commandButton value="查询" styleClass="button01" id="addMany" action="#{emp_busiqueryBB.doQuery}" />
<f:verbatim>
              </td>
              <td height=2>
</f:verbatim>
                  <h:panelGrid >
                  <h:panelGroup>
                     <f:verbatim>
		        	<%=LanguageSupport.getResource("RYGL-2278"," 开始时间")%>
		        </f:verbatim>  
                      
                      <h:inputText styleClass="input" id="beginTime" size="12" alt="开始时间|0|d" value="#{emp_busiqueryBB.beginTime}" readonly="true"/>
                      <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTime')"></f:verbatim>

                      <f:verbatim>
		        	<%=LanguageSupport.getResource("RYGL-2279"," 结束时间")%>
		        </f:verbatim>
                      <h:inputText styleClass="input" id="endTime" alt="结束时间|0|d" size="12" value="#{emp_busiqueryBB.endTime}" readonly="true"/>
                      <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:endTime')"></f:verbatim>
                      <h:commandButton value="开始查询" id="query"  styleClass="button01" action="#{emp_busiqueryBB.doQuery}" />

                      <h:outputText value="  "></h:outputText>
                      <h:selectOneMenu id="sortList" value="#{emp_busiqueryBB.sortField}">
                         <c:selectItems value="#{emp_busiqueryBB.sortList}"></c:selectItems>
                      </h:selectOneMenu>
                      <h:commandButton value="汇总" type="button" id="group"  styleClass="button01" onclick="beginGroup();" />

                      <h:outputText value="  "></h:outputText>
                      <h:selectOneMenu id="ReportID" style="width:190px">
                          <c:selectItems value="#{emp_busiqueryBB.reportList}"/>
                      </h:selectOneMenu>
                      <h:commandButton value="Excel显示" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
                  </h:panelGroup>
                  </h:panelGrid>
<f:verbatim>
              </td>
          </tr>

          <tr><td colspan=2 valign="top">
              <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                  <jsp:param name="hasOperSign" value="true"/>
                  <jsp:param name="operSignType" value="checkbox"/>
                  <jsp:param name="hasEdit" value="false"/>
                  <jsp:param name="isEditList" value="false"/>
                  <jsp:param name="isCheckRight" value="false"/>
              </jsp:include></td>
          </tr>
      </table>
</f:verbatim>      
  </h:form>
