<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.emp.pojo.bo.EmpSurveyConditionBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String SurveyID="";
%>
<c:verbatim>
    <script type="text/javascript">
        with (window) onload = onresize = function(){
            var mainHeight = document.body.clientHeight - 50;
            document.getElementById("main").style.height = "" + mainHeight + "px";
       }
       function copyValue(){
           document.all('form1:filtervalue').value=document.all('conditionID').value;
           disPlayProcessBar();
           return true;
       }
    </script>
</c:verbatim>

  <h:form id="form1">
      <h:inputHidden value="#{emp_surveyByCodeBB.pageInit}"/>
      <h:inputHidden id="surveyID" value="#{emp_surveyByCodeBB.surveyID}"/>
      <h:inputHidden id="filtervalue" value="#{emp_surveyByCodeBB.filtervalue}"/>
      <h:inputHidden id="onlyMyOrg" value="#{emp_surveyByCodeBB.onlyMyOrg}"/>

  <f:verbatim>
      <table width="98%" cellspacing="0">
      <tr >
          <td class="td_title"  height=2>
  </f:verbatim>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="#{emp_surveyByCodeBB.survey.itemName}"/>
  <f:verbatim>
          </td>
      <tr>
      </table>

      <br>
      <table   width="98%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" id=main>
          <tr>
      <td align="left" height=8>
  </f:verbatim>
               <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2391"," 统计时间") %> :
              </f:verbatim>
             <h:outputText value="#{emp_surveyByCodeBB.staticDate}"></h:outputText>
  <f:verbatim>
          </td>
          <td align="right">
            <%=LanguageSupport.getResource("RYGL-2392","选择过滤条件") %> :
              <select style="WIDTH: 200px" name="conditionID">
                  <option value="-1"> <%=LanguageSupport.getResource("RYGL-2393"," 全部") %> </option>
                  <%
                      SurveyID = CommonFuns.filterNull((String) session.getAttribute("MySurveyID"));
                      List list = (List) session.getAttribute("SurveyCondition" + SurveyID);
                      if (list != null && list.size() > 0) {
                          EmpSurveyConditionBO bo = (EmpSurveyConditionBO) list.get(0);
                          String field = bo.getFilterField();
                          InfoItemBO ib = SysCacheTool.findInfoItem("", field);
                          out.println("<optgroup label=" + ib.getItemName() + ">");
                          for (int i = 0; i < list.size(); i++) {
                              EmpSurveyConditionBO nextbo = (EmpSurveyConditionBO) list.get(i);
                              if (!field.equals(nextbo.getFilterField())) {
                                  field = nextbo.getFilterField();
                                  ib = SysCacheTool.findInfoItem("", field);
                                  out.println("</optgroup>");
                                  if (ib == null) {
                                      out.println("<optgroup label=" + field + ">");
                                  } else {
                                      out.println("<optgroup label=" + ib.getItemName() + ">");
                                  }
                              }
                              out.println("<option value='" + nextbo.getItemID() + "'>" + nextbo.getFilterName() + "</option>");
                          }
                          out.println("</optgroup>");
                      }
                  %>
              </select>
  </f:verbatim>
               <h:commandButton value="查询" styleClass="button01"  onclick="return copyValue();" action="#{emp_surveyByCodeBB.beginCalc}"></h:commandButton>
               <h:commandButton type="button" styleClass="button01" value="导出" onclick="ExportShowTable()"></h:commandButton>
      <f:verbatim>
          </td>
          </tr>
           <tr><td height=8></td></tr>
          <tr>

          <td valign="top" colspan=2>
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="sessionObject" value="<%=SurveyID%>"/>
                  <jsp:param name="para" value="true"/>
                  <jsp:param name="reverseQuery" value="true"/>
                  <jsp:param name="reverseQueryURL" value="/employee/info/ShowEmpSurveyByCodeDetail.jsf"/>
              </jsp:include>
          </td>
          </tr>
      </table>
  </f:verbatim>
  </h:form>

<script type="text/javascript">
    var obj=document.all('conditionID');
    var count = obj.options.length;
    for (i = 0; i < count; i++) {
        if (obj.options[i].value==document.all('form1:filtervalue').value) {
           obj.options[i].selected=true;
        }
    }
</script>

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

