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
      <h:inputHidden value="#{emp_d2AnaBB.pageInit}"></h:inputHidden>
      <c:verbatim>
          <table width="98%" height="98%" align="center" cellspacing="0">
          <tr>
            <td align="left" height="8" class="td_title">
      </c:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value="#{emp_d2AnaBB.title}"></h:outputText>
      <c:verbatim>
     
            </td>
          <td align="right"  height="8" class="td_title">
  </c:verbatim>
              <h:commandButton value="项目配置" styleClass="button01" onclick="return configItem()" type="button"></h:commandButton>
  <c:verbatim>
          </td>

          </tr>

      <tr>
        <td align="left" height="12" colspan="2">
        </td>
      </tr>
                <tr>
                  <td align="left" height="8" colspan="2">
                     <%=LanguageSupport.getResource("RYGL-2290","所属机构")%>
      </c:verbatim>
                      <h:inputText id="orgId" value="#{emp_d2AnaBB.orgId}" readonly = "true"
                                        size="20" styleClass="input" code="" dict="yes" dict_num="OU" />
                      <h:commandButton onclick="PopUpOrgDlg('form1:orgId',2,'')" styleClass="button_select"  type="button"/>

                      <h:selectOneMenu id="hitem" style="width:200px" value="#{emp_d2AnaBB.hitem}">
                            <c:selectItems value="#{emp_d2AnaBB.hitems}"></c:selectItems>
                      </h:selectOneMenu>
                      <h:selectOneMenu id="vitem" style="width:200px" value="#{emp_d2AnaBB.vitem}">
                            <c:selectItems value="#{emp_d2AnaBB.vitems}"></c:selectItems>
                      </h:selectOneMenu>
                      <h:selectBooleanCheckbox value="#{emp_d2AnaBB.showV}"></h:selectBooleanCheckbox>
                      <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2291","显示列合计")%>  
                      </f:verbatim>

                      <h:selectBooleanCheckbox value="#{emp_d2AnaBB.showH}"></h:selectBooleanCheckbox>
                         <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2292","显示行合计")%>  
                      </f:verbatim>
                      <h:selectOneMenu value="#{emp_d2AnaBB.qryID}" id="qryID">
                          <c:selectItems value="#{emp_d2AnaBB.conList}"></c:selectItems>
                      </h:selectOneMenu>

                      <h:commandButton value="统计" styleClass="button01" onclick="return doCheck();" action="#{emp_d2AnaBB.doStatic}"></h:commandButton>
                      <h:commandButton value="导出" styleClass="button01" onclick="ExportShowTable();" type="button"></h:commandButton>
<c:verbatim>
                  </td>
              </tr>

          <tr><td colspan="2" height="10">
          </td></tr>

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
<script type="text/javascript">
    interpret(document.forms(0));
</script>