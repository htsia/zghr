<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
      <script type="text/javascript">
          function forSel() {
                if(PopUpMutilCodeDlgForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                    document.all('form1').submit();
                }
          }
          function doShowPerson(){
              if (form1.all("form1:dateID").value=="" || form1.all("form1:dateID").value=="-1"){
                  alert("请选择比较时间!");
                  return false;
              }
              if (form1.all("form1:WageDept").value==""){
                  alert("请选择部门!");
                  return false;
              }

              if (form1.all("form1:field").value=="" || form1.all("form1:field").value=="-1"){
                  alert("请选择项目!");
                  return false;
              }

              var url="/wage/payoff/ShowPersonDetail.jsf?currentdateID="+form1.all("form1:currentdateID").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateID").value+"&deptID="+form1.all("form1:WageDept").value+"&fieldID="+form1.all("form1:field").value;
              window.showModalDialog(url, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
              return false;
          }
      </script>

  <x:saveState value="#{wage_diffBB}"></x:saveState>
  <h:form id="form1">
      <h:inputHidden value="#{wage_diffBB.initDeptDiff}"/>
      <h:inputHidden id="currentdateID" value="#{wage_diffBB.currentdateID}"/>
      <h:inputHidden id="setId" value="#{wage_diffBB.setId}"/>
      <c:verbatim>
      <table height=98% width=98%>
             <tr><td height=8 colspan=2>
      </c:verbatim>
                   <h:outputText value="当前发薪月份:#{wage_diffBB.currentPayoffDate}"></h:outputText>
<c:verbatim>
             </td></tr>
              <tr>
                  <td height=8>
                        <input name="simple1" type="button" id=15 next=20 class="button01" value="选择人员类别"
                         onclick="forSel()">
      </c:verbatim>
                      <h:inputHidden id="personType" value="#{wage_diffBB.personType}"/>
                      <h:inputHidden id="personTypeValue" value="#{wage_diffBB.personTypeValue}"/>
<c:verbatim>
                  </td>
                  <td height=8>
</c:verbatim>
                     <h:outputText value="#{wage_diffBB.personTypeDesc}"></h:outputText>
<c:verbatim>
                  </td>
              </tr>

              <tr>
                  <td colspan=2 height=8>
 </c:verbatim>

                      <h:selectOneMenu id="dateID" value="#{wage_diffBB.dateID}">
                          <c:selectItems value="#{wage_diffBB.dateList}"></c:selectItems>
                      </h:selectOneMenu>

                      <h:selectOneMenu id="field" value="#{wage_diffBB.field}">
                          <c:selectItems value="#{wage_diffBB.fieldList}"></c:selectItems>
                      </h:selectOneMenu>

                          <h:commandButton id="count" value="开始比较" styleClass="button01" action="#{wage_diffBB.showDeptDiff}"></h:commandButton>
                          <h:commandButton value="导出" styleClass="button01" onclick="ExportShowTable();"></h:commandButton>
                          <h:selectOneMenu id="WageDept"  value="#{wage_diffBB.dept}">
                             <c:selectItems value="#{wage_diffBB.deptList}"></c:selectItems>
                          </h:selectOneMenu>
                          <h:commandButton value="查看人员对比明细" type="button" styleClass="button01" onclick="doShowPerson();"></h:commandButton>
                          <h:commandButton value="返回" styleClass="button01" onclick="window.close()"></h:commandButton>
<c:verbatim>
                  </td>
              </tr>

          <tr><td colspan=2 height=10></td></tr>
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
