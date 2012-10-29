<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
         function addAnnu(){
             var str=getAllSelectValue(document.forms(0).chk,",");
             if (str==""){
                 alert("请选择人员!");
                 return false;
             }
             document.all("form1:personIds").value=str;
             return true;
         }
    </script>
<x:saveState value="#{annu_personListBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{annu_personListBB.initAdd}"></h:inputHidden>
    <h:inputHidden id="personIds" value="#{annu_personListBB.personIds}"></h:inputHidden>
     <f:verbatim>
        <table id=t1 height=98% width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td_page" height=8 align="left" colspan="2">
     </f:verbatim>
                    <h:outputText value="单位入公共缴费比例(%):"></h:outputText>
                    <h:inputText style="width:80px" readonly="true" value="#{annu_personListBB.unitRate}"></h:inputText>

                    <h:outputText value="单位入个人缴费比例(%):"></h:outputText>
                    <h:inputText style="width:80px" readonly="true" value="#{annu_personListBB.unitPersonRate}"></h:inputText>

                    <h:outputText value="个人缴费比例(%):"></h:outputText>
                    <h:inputText style="width:80px" readonly="true" value="#{annu_personListBB.personRate}"></h:inputText>

      <f:verbatim>
                </td>

            </tr>

        <tr>
            <td class="td_page" height=8 align="left">
     </f:verbatim>
                <h:outputText value="年金系数:"></h:outputText>
                <h:inputText value="#{annu_personListBB.parameter}"></h:inputText>

                <h:outputText value="缴费基数:"></h:outputText>
                <h:inputText value="#{annu_personListBB.baseset}"></h:inputText>
     <f:verbatim>
             </td>
          <td class="td_page" height=8 align="right">
 </f:verbatim>
              <h:commandButton value="参保" styleClass="button01" onclick="return addAnnu();" action="#{annu_personListBB.addPerson}"></h:commandButton>
 <f:verbatim>
          </td>

        </tr>
            <tr><td colspan=2 height=8></td></tr>
            <tr><td colspan=2>
                <jsp:include page="../../common/activepage/SecondActiveList.jsp">
                    <jsp:param name="hasOperSign" value="true"/>
                    <jsp:param name="operSignType" value="checkbox"/>
                    <jsp:param name="hasEdit" value="true"/>
                    <jsp:param name="isEditList" value="false"/>
                    <jsp:param name="isCheckRight" value="true"/>
                    <jsp:param name="isForward" value="true"/>
                    <jsp:param name="isRow" value="false"/>
                    <jsp:param name="isPage" value="true"/>
                </jsp:include>
            </td></tr>
        </table>
       </f:verbatim>
    </h:form>
  

<script type="text/javascript">

</script>
