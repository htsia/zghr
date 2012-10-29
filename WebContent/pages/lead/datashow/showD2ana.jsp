<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="/pages/include/taglib.jsp" %>

  <script type="text/javascript">
          function configItem(){
              window.showModalDialog("/employee/info/D2ItemList.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:no;status:no;scroll:no;");
          }

          function doCheck(){
                if (document.all('form1:hitem').value=="" || document.all('form1:hitem').value=="-1"){
                    alert("请选择横向指标")
                    return false;
                }
                if (document.all('form1:vitem').value=="" || document.all('form1:vitem').value=="-1"){
                    alert("请选择纵向指标")
                    return false;
                }
                if (document.all('form1:hitem').value==document.all('form1:vitem').value){
                    alert("请选择不同的纵向指标和横向指标！")
                    return false;
                }

                return forsubmit(document.forms(0));
            }
      </script>

  <x:saveState value="#{emp_d2AnaBB}" />
  <h:form id="form1">
      <h:inputHidden value="#{emp_d2AnaBB.initShow}"></h:inputHidden>
      <c:verbatim>
          <table width="98%" height="98%" align="center" cellspacing="0">
          <tr>
            <td align="left" height="8" class="td_title">
      </c:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value="#{emp_d2AnaBB.orgName}"></h:outputText>
      <c:verbatim>
     
            </td>
          </tr>

      <tr>
        <td align="left" height="12" colspan="2">
        </td>
      </tr>

          <tr><td colspan="2">
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="para" value="true"/>
                  <jsp:param name="reverseQuery" value="true"/>
                  <jsp:param name="reverseQueryURL" value="/employee/info/d2anaDetail.jsf"/>
              </jsp:include>
           </td></tr>

          </table>
      </c:verbatim>
 </h:form>
