<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    %>    

<script type="text/javascript">
   
</script>
    <x:saveState value="#{empTypeChangeBB}"/>
    <h:form id="form1" >
    	<h:inputHidden value="#{empTypeChangeBB.pageInit}"/>
        <c:verbatim>
        <table width="100%" border="0" cellspacing="6" cellpadding="0" align="center">
            <tr>
                <td class="td_title">人员类别变动</td>
            </tr>
        </table>
        </c:verbatim>

        <c:verbatim>
        <table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
        	<tr>
                <td colspan="4" align="left">
</c:verbatim>
                    <h:outputText value="#{empTypeChangeBB.selectedUserNames}"/>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td width="40%" height="24" class="td_form02">新人员类别</td>
                <td width="60%" colspan="2" class="td_form02">
</c:verbatim>
                   <h:inputText id="pType" value="#{empTypeChangeBB.newType}" styleClass="input" alt="人员类别|0|s|30" dict="yes" dict_num="0135" code="" readonly="true"/>
                   <h:commandButton styleClass="button_select" type="button" onclick="PopUpCodeDlgOneControl('form1:pType');"/>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                <br/>
</c:verbatim>
                    <h:commandButton styleClass="button01" onclick="return forsubmit(document.forms(0))" action="#{empTypeChangeBB.saveType}" value="    保  存    "/>
<c:verbatim>
                </td>
            </tr>
        </table>
</c:verbatim>        
    </h:form>

