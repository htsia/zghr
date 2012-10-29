<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function doOK(){
        window.returnValue=document.all('form1:setID').value;
        window.close();
    }
    function doCancel(){
        window.returnValue=""; 
        window.close();
    }
</script>
<h:form id="form1">
    <c:verbatim>
        <table width="95%" align="center">
        <tr><td align="right">
    </c:verbatim>
        <h:commandButton value="确定" styleClass="button01" onclick="doOK();"></h:commandButton>
        <h:commandButton value="取消" styleClass="button01" onclick="doCancel();"></h:commandButton>
    <c:verbatim>
        </td></tr>
         <tr><td>
    </c:verbatim>
             <h:selectOneMenu style="width:200px" id="setID">
                 <c:selectItems value="#{wage_setPersonBB.wagesetList}"></c:selectItems>
             </h:selectOneMenu>
    <c:verbatim>
        </td></tr>
        </table>
    </c:verbatim>
</h:form>