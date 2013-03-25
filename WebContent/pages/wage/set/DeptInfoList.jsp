<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function exportDept(){
           window.showModalDialog("/wage/set/exportDeptInfo.jsf?setId="+document.all("form1:setId").value+"&unitId="+document.all("form1:unitId").value+"&dateId="+document.all("form1:dateId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
           return false;
       }
        function doDeptInput(){
            var url="/wage/set/SetDeptInput.jsf?setId="+form1.all("form1:setId").value+"&unitId=" + form1.all("form1:unitId").value+"&setName="+form1.all("form1:setName").value+"&dateId="+form1.all("form1:dateId").value;
            //alert(url);
            window.showModalDialog(url, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }

    </script>

  <x:saveState value="#{wage_deptExportBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_deptExportBB.showDeptList}"/>
      <h:inputHidden id="setId" value="#{wage_deptExportBB.setId}"/>
      <h:inputHidden id="unitId" value="#{wage_deptExportBB.unitId}"/>
      <h:inputHidden id="dateId" value="#{wage_deptExportBB.dateId}"/>
      <h:inputHidden id="setName" value="#{wage_deptExportBB.setName}"/>

<c:verbatim>
      <table  width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >
         <tr><td colspan=2 height="10"></td></tr>

         <tr>
              <td colspan=2 align="right" height="8">
</c:verbatim>
                  <h:commandButton styleClass="button01" value="修改"  onclick="return doDeptInput();"/>
                  <h:commandButton styleClass="button01" value="导出" type="button" onclick="return exportDept();"/>
                  <h:commandButton styleClass="button01" value="退出" type="button" onclick="window.close();"/>
<c:verbatim>
              </td>
          </tr>
          <tr><td colspan=2 height="10"></td></tr>
          <tr>
              <td colspan=2 height="400">
                  <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                      <jsp:param name="para" value="true"/>
                  </jsp:include>
              </td>
          </tr>
      </table>
</c:verbatim>
  </h:form>