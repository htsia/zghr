<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
 <c:verbatim><base target="_self"></c:verbatim>
  <script language="javascript">
      function dook(){
          var str = "";
          if (checkMutilSelect(form1.chk)) {
              count = form1.chk.length;
              if (count != null) {
                  var num = 0;
                  for (i = 0; i < count; i++)
                      if (form1.chk[i].checked) {
                          str += form1.chk[i].value + ",";
                          num++;
                      }
              } else
                  str = form1.chk.value;
          }
          window.returnValue=str;
          window.close();
      }
  </script>

  <x:saveState value="#{wage_reinforceBB}"></x:saveState>
  <h:form id="form1">
  <h:inputHidden id="pageInit" value="#{wage_reinforceBB.pageInit}"/>
      <c:verbatim>
           <table width="95%" height=98%>
               <tr >
                   <td align="right" height=8>
                       <input class="button01" value="±£´æ" type="button" id="ok" onclick="dook()"/> <input class="button01" value="È¡Ïû" type="button" id="cancel" onclick="window.close()" /> 
                   </td>
               </tr>
               <tr><td height=8></td></tr>
               <tr><td>
                   <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
                       <jsp:param name="hasOperSign" value="true"/>
                       <jsp:param name="operSignType" value="checkbox"/>
                       <jsp:param name="hasEdit" value="false"/>
                       <jsp:param name="isEditList" value="false"/>
                       <jsp:param name="isCheckRight" value="false"/>
                   </jsp:include>
               </td></tr>
           </table>
      </c:verbatim>
  </h:form>

