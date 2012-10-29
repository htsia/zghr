<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
     function doCheck() {
          if(!checkMutilSelect(form1.all('form1:inputField'))){alert('请选择输入项');return false;}else{return true;}
      }
     function DoSelectAll(isSelect){
          var size = document.all('form1:inputField').length;
          for (var i = 0; i < size; i++) {
              document.all('form1:inputField')[i].checked=isSelect;
          }
      }
    </script>

  <x:saveState value="#{wage_deptExportBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_deptExportBB.showDept}"/>
      <h:inputHidden value="#{wage_deptExportBB.setId}"/>
<c:verbatim>
      <table  width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title" >选择输出项目</td>
              <td class="td_title" >
</c:verbatim>
                  <h:selectManyCheckbox value="#{wage_deptExportBB.inputField}" layout="pageDirection" id="inputField">
                      <c:selectItems value="#{wage_deptExportBB.inputList}"/>
                  </h:selectManyCheckbox>
<c:verbatim>
              </td>
          </tr>
          <tr><td colspan=2 height="10"></td></tr>

          <tr>
              <td colspan=2 align="right">
</c:verbatim>
                  <h:commandButton  styleClass="button01" type="button" value="全部选择" onclick="DoSelectAll(true);" />
                  <h:commandButton  styleClass="button01" type="button" value="全部取消" onclick="DoSelectAll(false);" />
                  <h:commandButton value="查询" styleClass="button01" onclick="return doCheck();" action="#{wage_deptExportBB.doQueryDeptInfo}"></h:commandButton>
                  <h:commandButton value="导出" type="button" styleClass="button01" onclick="ExportShowTable();"></h:commandButton>
<c:verbatim>
              </td>
          </tr>
           <tr><td colspan=2 height="10"></td></tr>
          <tr>
              <td colspan=2>
                  <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                      <jsp:param name="para" value="true"/>
                  </jsp:include>
              </td>
          </tr>
      </table>
</c:verbatim>
  </h:form>