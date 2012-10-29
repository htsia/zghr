<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
    <script type="text/javascript">
         function doCheck(){
            if (document.all('form1:percent').value==""||document.all('form1:percent').value=="NO"){
                alert("请录入等级比例!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{evaSetPlanGradeBB}"/>
<h:form id="form1">
        <h:inputHidden id="pageInit" value="#{evaSetPlanGradeBB.initItemEdit}"/>
        <h:inputHidden id="planId" value="#{evaSetPlanGradeBB.planId}"></h:inputHidden>
        <h:inputHidden id="templateId" value="#{evaSetPlanGradeBB.templateId}"></h:inputHidden>
        <c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td class="td_form01">全部控制项</td>
                <td class="td_form02">
</c:verbatim>
                  <h:selectOneMenu value="#{evaSetPlanGradeBB.controlbo.gradeItem}">
                  		<c:selectItems value="#{evaSetPlanGradeBB.gradeItemList}"/>
                  </h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">等级比例（%）</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText  id="percent" value="#{evaSetPlanGradeBB.controlbo.gradeCount}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
			
            <tr>
                <td class="td_form01">部门控制人数</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText  id="deptCount" value="#{evaSetPlanGradeBB.controlbo.deptCount}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
        </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="保存" onclick="return doCheck();" action="#{evaSetPlanGradeBB.saveControlbo}" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>