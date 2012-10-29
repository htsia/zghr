<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<x:saveState value="#{post_editPostBB}"/>
<!-- 修改开始1  -->
<script type="text/javascript">
	var subw=null;
    function forView(form, id, type) {
		url = "/employee/info/PersonEditInfo.jsf?pk=" + id+"&type=0";
		if(subw != null){
			subw.close();
		}
		subw= window.open(url,"","height=600,width=1000,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,left=50,top=50");
        subw.focus();
        //window.showModalDialog("<%=Constants.LEAD_SHOW_PERSONURL%>?flag333=2&fk="+id+"&typeId=2001010000,2001010100&setId=A001", "", "dialogWidth:1000px; dialogHeight:600px; center:center; status:0;resizable:yes");
    }
</script>
<!-- 修改结束1  -->

<h:form id="form1">
    <h:inputHidden value="#{post_editPostBB.table}"></h:inputHidden>
    <c:verbatim>
    <table height=600 width=100% style="margin-top:-30px;">
    <tr valign="top">
        <td valign="top" height=1>
        <jsp:include page="/pages/common/activepage/ActiveDetail.jsp">
            <jsp:param name="isEdit" value="false"/>
        </jsp:include>
     </td></tr>

     <tr valign="top">
           <td valign="top">
               <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                   <jsp:param name="hasOperSign" value="true"/>
                   <jsp:param name="operSignType" value="checkbox"/>
                   <jsp:param name="hasEdit" value="true"/>
                   <jsp:param name="isEditList" value="false"/>
                   <jsp:param name="isCheckRight" value="false"/>
                   <jsp:param name="isForward" value="true"/>
                   <jsp:param name="isRow" value="true"/>
                   <jsp:param name="rowFuncName" value="forView"/>
                   <jsp:param name="isPage" value="true"/>
               </jsp:include>
           </td>
        </tr>
     </table>
    </c:verbatim>
</h:form>
