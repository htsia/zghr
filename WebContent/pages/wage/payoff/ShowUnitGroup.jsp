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

            if (document.all('form1:groupField').value=='-1'){
                    alert("请选择汇总项目！");
                    return false;
            }
            return true;
        }

    </script>

  <x:saveState value="#{wage_unitgroupBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_unitgroupBB.pageInit}"/>
      <c:verbatim>
      <table  width="100%" height=98% border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title"  height=8>
               <table width="100%">
               <tr>
                  <td>
</c:verbatim>
                  <h:graphicImage value="/images/tips.gif" />
                  <h:outputText value="#{wage_unitgroupBB.dateId}机构汇总"/>
<c:verbatim>
                  </td>

                  <td  align="right">
 </c:verbatim>
                      <h:selectOneMenu id="groupField" value="#{wage_unitgroupBB.groupField}">
                          <c:selectItems value="#{wage_unitgroupBB.fieldList}"></c:selectItems>
                      </h:selectOneMenu>
                      <h:selectBooleanCheckbox value="#{wage_unitgroupBB.onlyHave}"></h:selectBooleanCheckbox>
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
                  <h:outputText value="设定统计范围=>"></h:outputText>
                  <h:selectOneMenu style="width:110px;" id="classitem" value="#{wage_unitgroupBB.personType}" onchange="document.all('form1:classvalue').value='';document.all('form1:classvaluedes').value='';">
                      <f:selectItems value="#{wage_unitgroupBB.classItemList}"/>
                  </h:selectOneMenu >

                  <h:selectOneMenu id="oper" value="#{wage_unitgroupBB.oper}">
                       <c:selectItem itemValue="1" itemLabel="等于"></c:selectItem>
                       <c:selectItem itemValue="2" itemLabel="属于"></c:selectItem>
                  </h:selectOneMenu>

                  <h:inputText readonly="true"  style="width:210px" id="classvaluedes"/>
                  <h:inputHidden id="classvalue" value="#{wage_unitgroupBB.personTypeValue}"/>
                  <h:commandButton id="select" type="button" styleClass="button01" value="选择"  onclick="forSel()"/>
                  <h:commandButton id="count" value="统计" styleClass="button01" onclick="return chechPara();" action="#{wage_unitgroupBB.beginCalc}" ></h:commandButton>
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
