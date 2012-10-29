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
            if (document.all('form1:classitem').value==''){
                alert("请选择分类值！");
                return false;
            }
            return true;
        }
        
    </script>

  <x:saveState value="#{wage_classBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_classBB.showGroup}"/>
      <h:inputHidden value="#{wage_classBB.setId}"/>
      <h:inputHidden value="#{wage_classBB.groupField}"/>
<c:verbatim>
      <table  width="100%" height=98% border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title"  height=8>
               <table width="100%">
               <tr>
                  <td><img src="/images/tips.gif" />分类汇总 </td>
                  <td  align="right">
</c:verbatim>
                      <h:selectBooleanCheckbox value="#{wage_classBB.onlyHave}"></h:selectBooleanCheckbox>
                      <h:outputText value="仅计算有数人员"></h:outputText>
<c:verbatim>
                  </td>
              </tr>
              </table>
              </td>
          </tr>

          <tr>
              <td  height=8>
</c:verbatim>
                  <h:outputText value="设定分类指标=>"></h:outputText>
                  <h:selectOneMenu style="width:150px;" id="classitem" value="#{wage_classBB.personType}">
                      <f:selectItems value="#{wage_classBB.classItemList}"/>
                  </h:selectOneMenu >

                  <h:commandButton id="count" value="统计" styleClass="button01" onclick="return chechPara();" action="#{wage_classBB.beginCalc}" ></h:commandButton>
                  <h:commandButton id="export" value="导出" styleClass="button01" onclick="ExportShowTable();" type="button"></h:commandButton>
                  <h:commandButton value="关闭" styleClass="button01" onclick="window.close()"></h:commandButton>
<c:verbatim>
              </td>
          </tr>

          <tr><td>
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="para" value="true"/>
              </jsp:include>
           </td></tr>
      </table>
</c:verbatim>
  </h:form>
