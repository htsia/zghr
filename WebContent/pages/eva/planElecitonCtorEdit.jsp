<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
    <script type="text/javascript">
         function doCheck(){
            if (document.all('form1:percent').value==""||document.all('form1:percent').value==null){
                alert("请录入等级比例!");
                return false;
            }else if (document.all('form1:masterType').value==""||document.all('form1:masterType').value==null){
                alert("请录入考核人员类型!");
                return false;
            }else{
            	forsubmit(document.forms(0)); 
            }
        }
    </script>

<x:saveState value="#{evaSetElectionContrlBB}"/>
<h:form id="form1">
        <h:inputHidden id="pageInit" value="#{evaSetElectionContrlBB.initEdit}"/>
        <h:inputHidden id="planId" value="#{evaSetElectionContrlBB.planId}"></h:inputHidden>
        <c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
        	<tr>
                <td class="td_form01">考核人员类型</td>
                <td class="td_form02">
</c:verbatim>
                   <h:inputText styleClass="input" id="masterType" code="" dict="yes" dict_num="0652"
                             readonly="true" value="#{evaSetElectionContrlBB.control.masterType}"
                             alt="考核人员类别|0|s|52||"/>
<c:verbatim>
				<input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:masterType')">
                </td>
            </tr>
            <tr>
                <td class="td_form01">全部控制项</td>
                <td class="td_form02">
</c:verbatim>
                  <h:selectOneMenu value="#{evaSetElectionContrlBB.control.gradeItem}">
                  		<c:selectItems value="#{evaSetElectionContrlBB.gradeItemList}"/>
                  </h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">等级比例（%）</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText  id="percent" value="#{evaSetElectionContrlBB.control.gradeCount}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
			
            <tr>
                <td class="td_form01">部门控制人数</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText  id="deptCount" value="#{evaSetElectionContrlBB.control.deptCount}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
        </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="保存" onclick="return doCheck();" action="#{evaSetElectionContrlBB.saveControl}" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>