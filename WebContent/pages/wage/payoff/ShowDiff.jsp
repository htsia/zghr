<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
    function doCheck(){
        if (document.all('form1:dateID').value=="-1" ){
            alert('请选择比较时间!');
            return false;
        }
        if (document.all('form1:field').value=="-1"){
            alert('请选择比较内容!');
            return false;
        }

        return true;
    }
    function forView(form, id, type) {
        windowOpen("/wage/payoff/ShowDiffDetail.jsf?personID=" + id+"&curDateID="+document.all('form1:currentdateID').value+"&dateID="+document.all('form1:dateID').value, "aa", "", "1000", "600", "no","10","1","yes");
    }
    function doImport(){
        var ret=window.showModalDialog("/wage/payoff/WriteDiff.jsf?setId="+document.all('form1:setId').value, null, "dialogWidth:350px; dialogHeight:160px;center:center;resizable:yes;status:no;scroll:yes;");
        if (ret==""){
            return false;
        }
        else{
            document.all('form1:writeParam').value=ret;
            return true;
        }
    }
    
</script>
<x:saveState value="#{wage_diffBB}"></x:saveState>
 <h:form id="form1">
      <h:inputHidden value="#{wage_diffBB.pageInit}"/>
      <h:inputHidden id="currentdateID" value="#{wage_diffBB.currentdateID}"/>
      <h:inputHidden id="setId" value="#{wage_diffBB.setId}"/>
      <c:verbatim>
      <table height=96% width=98%>
      <tr><td height=8>
</c:verbatim>
          <h:panelGrid columns="4">
              <h:outputText value="当前发薪月份:#{wage_diffBB.currentPayoffDate}"></h:outputText>

              <h:selectOneMenu id="dateID" value="#{wage_diffBB.dateID}">
                  <c:selectItems value="#{wage_diffBB.dateList}"></c:selectItems>
              </h:selectOneMenu>

              <h:selectOneMenu id="field" value="#{wage_diffBB.field}">
                  <c:selectItems value="#{wage_diffBB.fieldList}"></c:selectItems>
              </h:selectOneMenu>

              <h:panelGroup>
                  <h:outputText value="最低差值"></h:outputText>
                  <h:inputText value="#{wage_diffBB.minValue}"></h:inputText>
              </h:panelGroup>

              <h:panelGroup>
                  <h:selectOneRadio value="#{wage_diffBB.diffMode}">
                      <c:selectItem itemValue="0" itemLabel="比较该月"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="该月至当月平均"></c:selectItem>
                  </h:selectOneRadio>
              </h:panelGroup>
              <h:panelGroup>
                  <h:commandButton value="开始比较" styleClass="button01" onclick="return doCheck();" action="#{wage_diffBB.showDiff}"></h:commandButton>
                  <h:commandButton value="导出" styleClass="button01" type="button" onclick="doExport2()"></h:commandButton>
                  <h:inputHidden id="writeParam" value="#{wage_diffBB.writeParam}"></h:inputHidden>
                  <h:commandButton value="回填结果" styleClass="button01"  onclick="doImport();" action="#{wage_diffBB.writeData}"></h:commandButton>
                  <h:commandButton value="返回" styleClass="button01" type="button" onclick="if (document.all('form1:writeParam').value!='') window.returnValue='refresh'; window.close()"></h:commandButton>
              </h:panelGroup>
          </h:panelGrid>
<c:verbatim>
       </td></tr>
      <tr><td>
          <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
              <jsp:param name="hasOperSign" value="true"/>
              <jsp:param name="operSignType" value="checkbox"/>
              <jsp:param name="hasEdit" value="true"/>
              <jsp:param name="isEditList" value="false"/>
              <jsp:param name="isCheckRight" value="false"/>
              <jsp:param name="keyName" value="ID"/>
              <jsp:param name="fixcol" value="2"/>
              <jsp:param name="rowFuncName" value="forView"/>
          </jsp:include>
      </td></tr>    
      </table>
</c:verbatim>     
  </h:form>
