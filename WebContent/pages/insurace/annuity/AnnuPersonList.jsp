<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addAnnu(){
             window.showModalDialog("/insurace/annuity/AddAnnuPerson.jsf?Init=true", null, "dialogWidth:800px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
             return true;
         }
         function OpenRpt(){
             if (document.all("form1:ReportID").value=="-1"){
                 alert("请先选择表格样式！");
                 return false;
             }

             if (checkMutilSelect(form1.chk)) {
                 count = form1.chk.length;
                 var perID = "";
                 if (count != null) {
                     var num = 0;
                     for (i = 0; i < count; i++)
                         if (form1.chk[i].checked) {
                             perID = form1.chk[i].value;   // 取第一个
                             break;
                         }
                 } else
                     perID = form1.chk.value;
                 var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID="+document.all("form1:superId").value+"&Parameter=&Title=";
                 window.open(url);
             } else {
                 var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID=&Parameter=&Title=";
                 window.open(url);
             }
            return false;
        }

    </script>
<x:saveState value="#{annu_personListBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{annu_personListBB.pageInit}"></h:inputHidden>    
     <f:verbatim>
        <table id=t1 height=98% width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td_page" height=8 align="left">
     </f:verbatim>
            <h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{annu_personListBB.regTableList}"/>
            </h:selectOneMenu>
            <h:commandButton styleClass="button01" type="button" value="显示表格" onclick="OpenRpt();"></h:commandButton>

      <f:verbatim>
                </td>

                <td class="td_page" height=8 align="right">
       </f:verbatim>
                    <h:outputText value="满足条件但未参保人员:#{annu_personListBB.personCount}"></h:outputText>
                    <h:commandButton value="参保" styleClass="button01" onclick="return addAnnu();"></h:commandButton>
       <f:verbatim>
                </td>
            </tr>
            <tr><td colspan=2 height=8></td></tr>
            <tr><td colspan=2>
                <jsp:include page="../../common/activepage/ActiveList.jsp">
                    <jsp:param name="hasOperSign" value="true"/>
                    <jsp:param name="operSignType" value="checkbox"/>
                    <jsp:param name="hasEdit" value="true"/>
                    <jsp:param name="isEditList" value="false"/>
                    <jsp:param name="isCheckRight" value="true"/>
                    <jsp:param name="isForward" value="true"/>
                    <jsp:param name="isRow" value="false"/>
                    <jsp:param name="isPage" value="true"/>
                </jsp:include>
            </td></tr>
        </table>
       </f:verbatim>
    </h:form>
  

<script type="text/javascript">

</script>
