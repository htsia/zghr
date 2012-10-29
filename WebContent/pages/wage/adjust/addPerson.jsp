<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
</script>
    <x:saveState value="#{wageReformCaclMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{wageReformCaclMgrBB.initEdit}"/>
        <h:inputHidden id="postId" value=""></h:inputHidden>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td class=td_form01>人员姓名</td>
                <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{wageReformCaclMgrBB.personNames}" rows="3" cols="50"></h:inputTextarea>
			   <h:inputHidden value="#{wageReformCaclMgrBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="选择" onclick="return fPopUpBackPerTreeDlg('');" action="#{wageReformCaclMgrBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>选择套改标准</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                  <h:selectOneMenu value="#{wageReformCaclMgrBB.setId}">
                  	<c:selectItems value="#{wageReformCaclMgrBB.setIdList}"/>
                  </h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>

        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存"  action="#{wageReformCaclMgrBB.savePerson}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>