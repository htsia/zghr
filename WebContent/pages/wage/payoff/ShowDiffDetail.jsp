<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forSel() {
            if (document.all('form1:oper').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:classitem").value,'');
            }
            else{
                PopUpCodeDlgTwoControlSelectAll(document.all('form1:classvalue'),document.all( 'form1:classvaluedes'), document.all("form1:classitem").value,'');
            }
            return false;
        }
        function  chechPara(){
            if (document.all('form1:classitem').value!=''){
                if (document.all('form1:classvalue').value==''){
                    alert("请选择分类值！");
                    return false;
                }
            }
            return true;
        }
        
    </script>

  <x:saveState value="#{wage_diffItemBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_diffItemBB.pageInit}"/>

      <f:verbatim>
      <table  width="100%" height=98% border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr>
              <td  height=8>
                  详细信息如下：
              </td>
          </tr>

          <tr><td>
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="para" value="true"/>
              </jsp:include>
           </td></tr>
      </table>
</f:verbatim>      
  </h:form>
