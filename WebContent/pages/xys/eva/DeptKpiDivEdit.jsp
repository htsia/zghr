<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>

<script type="text/javascript">
    <%
        User user = (User)session.getAttribute(Constants.USER_INFO);
    %>
   
    function selectPerson(){
         return  fPopUpBackPerTreeDlg('<%=user.getOrgId()%>');
    }
    

</script>
    <x:saveState value="#{xys_deptKpiDivMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{xys_deptKpiDivMgrBB.initEdit}"/>
        <h:inputHidden id="postId" value=""></h:inputHidden>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr>
            <td class=td_form01>姓名</td>
            <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{xys_deptKpiDivMgrBB.personNames}" rows="3" cols="50"></h:inputTextarea>
			   <h:inputHidden value="#{xys_deptKpiDivMgrBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="选择" onclick="return selectPerson()" action="#{xys_deptKpiDivMgrBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>
			<tr>
            <td class=td_form01>权重</td>
            <td class=td_form02 colspan="3">
</c:verbatim> 
			 <h:inputText value="#{xys_deptKpiDivMgrBB.weight}"></h:inputText>
<c:verbatim>
            </td>
            </tr>
            </table>
            <table width=95% align=center>
            <tr>
            <td align="center">
</c:verbatim> 
			<h:commandButton value="保存" styleClass="button01" action="#{xys_deptKpiDivMgrBB.saveDiv}"></h:commandButton>
<c:verbatim>
            </td>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>