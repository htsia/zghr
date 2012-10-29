<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String showName = CommonFuns.filterNull((String) request.getAttribute("showName"));
%>

    <script type="text/javascript">
        function forAdQry() {
            document.all("form1:area").value = "";
            document.all("form1:area").code = "";
            document.all("form1:provinceArea").value = "";
            document.all("form1:provinceArea").code = "";
            document.all("form1:centerArea").value = "";
            document.all("form1:centerArea").code = "";
            doAdvanceQuery("B", "ORG", "111", "Y", "", "B001.B001730='00901'");
        }

    </script>

<h:form id="form1">
    <h:inputHidden value="#{org_orgAreaListBB.orgList}"/>
    <h:inputHidden value="#{org_orgAreaListBB.superId}"/>
<c:verbatim>
    <input type="hidden" name="sessionFlag" value="2">
    <table id=t1 width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_page">
               <%=LanguageSupport.getResource("JGGL-1082"," 区域隶属关系")%> : 
               
</c:verbatim>
                <h:inputText id="area" value="#{org_orgAreaListBB.area}" size="15" styleClass="input"  code="" dict="yes" dict_num="0240"/>
                <h:commandButton onclick="javascript:PopUpCodeDlgOneControl('form1:area')" styleClass="button_select" type="button"/>
<c:verbatim>
            </td>
            </tr>
      <tr>
        <td class="td_page" align="right">
</c:verbatim>
                <h:commandButton value=" 查询 " id="queryOrg" onclick="javascript:return forsubmit(document.forms(0));" styleClass="button01"
                                 action="#{org_orgAreaListBB.queryOrg}"/>
                <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01"/>
<c:verbatim>
        </tr>
    </table>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="true"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="isForward" value="true"/>
        <jsp:param name="isRow" value="false"/>
        <jsp:param name="isPage" value="true"/>
    </jsp:include>
</c:verbatim>    
</h:form>
 <form id="form2">
        <input type="hidden" name="orgids"/>
 </form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
