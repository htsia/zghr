<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <c:verbatim><base target="_self"></c:verbatim>
    <script type="text/javascript">
        function beginGroup(){
            window.showModalDialog("/wage/payoff/ShowUnitGroup.jsf?payDate="+form1.all("form1:yearmonth1").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

     function forSel() {
           if(PopUpMutilCodeDlgForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                  document.forms(0).all('form1:count').click();
           }
      }
     function OpenNowRpt(){
         if (document.all("form1:nowStaticID").value=="-1"){
             alert("请先选择表格样式！");
             return false;
         }
         var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:nowStaticID").value+"&ID="+document.all("form1:yearmonth1").value+"&ORGUID="+document.all("form1:yearmonth2").value
         window.open(url);
         return false;
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
       
    </script>

  <x:saveState value="#{wage_orggroupBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_orggroupBB.pageInit}"/>
      <h:inputHidden id="str" value=""/>

      <f:verbatim>
      <table  width="100%" border="0" height="96%" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title" height=8>
      </f:verbatim>
                      <h:graphicImage value="/images/tips.gif" />
                      <h:outputText value=" 薪资汇总情况"/>
      <f:verbatim>
              </td>
          </tr>

          <tr>
               <td  align="left" height=8>
      </f:verbatim>
                   <h:outputText value="开始时间"></h:outputText>
                   <h:inputText readonly="true" id="yearmonth1" value="#{wage_orggroupBB.beginDate}"></h:inputText>
                   <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:yearmonth1')"/>

                   <h:outputText value="结束时间"></h:outputText>
                   <h:inputText readonly="true" id="yearmonth2" value="#{wage_orggroupBB.endDate}"></h:inputText>
                   <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:yearmonth2')"/>

                   <h:commandButton  styleClass="button01" value="查询" action="#{wage_orggroupBB.doQuery}"/>
                   <h:commandButton type="button" styleClass="button01" value="导出" onclick="doExport();"/>
                   <h:commandButton  styleClass="button01" value="设置显示项目" onclick="doShowItem();" action="#{wage_orggroupBB.saveShowItem}"/>

                   <h:commandButton styleClass="button01" value="机构汇总查询" type="button" onclick="beginGroup();" ></h:commandButton>
                   <h:selectOneMenu id="nowStaticID" style="width:200px">
                      <c:selectItems value="#{wage_orggroupBB.nowReportList}"/>
                  </h:selectOneMenu>
                   <h:commandButton value="显示" styleClass="button01" onclick="return OpenNowRpt();"></h:commandButton>
<f:verbatim>
               </td>
          </tr>
          <tr>
              <td>
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
