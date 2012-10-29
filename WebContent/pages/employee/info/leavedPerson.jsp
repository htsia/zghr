<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
      <script type="text/javascript">
          function doViewCard(){
              var id=getFirstSelectValue(form1.chk);
              if (id==""){
                 alert("请选择人员！");  
              }
              else{
                windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&type=0", "aa", "", "1000", "600", "no","10","1","yes");
              }
              return false;
          }
      </script>

  <x:saveState value="#{emp_LeavePersonBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{emp_LeavePersonBB.pageInit}"/>
 <f:verbatim>
  <table width="98%" height=98% border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="td_title" height=8>
            <img src="/images/tips.gif" />
 </f:verbatim>
            <h:outputText value="#{emp_LeavePersonBB.unitName}"/>
 <f:verbatim>
           <%=LanguageSupport.getResource("RYGL-0368","离职人员信息")%> 
        </td>
    </tr>

      <tr>
      <td align="right" height=8>
 </f:verbatim>
          <h:outputText escape="false" value="<strong>姓名或编号</strong>"></h:outputText>
          <h:inputText value="#{emp_LeavePersonBB.name}"></h:inputText>
          <h:selectOneMenu value="#{emp_LeavePersonBB.type}">
              <c:selectItems value="#{emp_LeavePersonBB.typeList}"></c:selectItems>
          </h:selectOneMenu>

          <h:outputText escape="false" value="<strong>查询时间</strong>"></h:outputText>
          <h:inputText  id="inputDate" readonly="true" value="#{emp_LeavePersonBB.inputDate}"></h:inputText>
          <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:inputDate')"/>
          <h:commandButton value="查询" styleClass="button01" action="#{emp_LeavePersonBB.query}" onclick="disPlayProcessBar();"></h:commandButton>
          <h:commandButton value="详细信息" styleClass="button01" type="button" onclick="return doViewCard();"></h:commandButton>
 <f:verbatim>
      </td>
      </tr>
       <tr> <td align="right" height=8></td></tr>
     <tr><td align="top">
         <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
             <jsp:param name="hasOperSign" value="true"/>
             <jsp:param name="operSignType" value="checkbox"/>
             <jsp:param name="hasEdit" value="false"/>
             <jsp:param name="isEditList" value="false"/>
             <jsp:param name="isCheckRight" value="false"/>
         </jsp:include>
     </td></tr>
  </table>
 </f:verbatim>      
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
