<%@page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function forSel() {
	    PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
	}
    function forExport() {
        window.open('/pages/common/ExportToExcel.jsp?sessionKey=<%=Constants.OBJECT%>');
        return null;
    }
    function chkpersontype(){
    	var personType=document.all("form1:personType").value;
	    if(personType==null || personType==""){
	    	alert("请选择人员类别");
	    	return false;
	    }
	    return true;
    }
</script>


<x:saveState value="#{ins_PayQueryBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{ins_PayQueryBB.pageInit}"/>
    <c:verbatim>
    <table width=100% height=97% border=0 >
    <tr><td height=8px>
    </c:verbatim>
            <h:panelGrid align="left" columns="1" cellpadding="5">
                	<h:panelGroup>
                	<h:inputHidden id="personType" value="#{ins_PayQueryBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{ins_PayQueryBB.personTypeValue}"/>
                	<h:commandButton styleClass="button01" value="选择人员类别" onclick="forSel();"
                                     action="#{ins_PayQueryBB.queryPersonByName}" />             	
                    <h:outputText value="缴费日期："/>
                    <h:inputText id="dateStr" value="#{ins_PayQueryBB.dateStr}" readonly="readonly" styleClass="input" style="width:100px;" />
                	<c:verbatim>
                	<input id="form1:_id14" name="form1:_id14" type="button" onclick="PopUpCalendar_OnlyMonth('form1:dateStr');" class="button_select" />
                	</c:verbatim>
                    <h:outputText value="姓名或员工编号："/>
                    <h:outputText value=" "></h:outputText>
                    <h:inputText id="searchStr" value="#{ins_PayQueryBB.searchStr}"  styleClass="input" style="width:100px;" 
                    	onkeypress ="enterKeyDown('form1:btnSearch')" />
                    <h:commandButton id="btnSearch" styleClass="button01" value="查询" onclick="return chkpersontype();"
                                     action="#{ins_PayQueryBB.queryPersonByName}" />
                    <h:outputText value=" "></h:outputText>
                    <h:commandButton styleClass="button01" value="自定义查询"
                                     onclick="return doAdvanceQuery('A','ORG','011','Y','','','N','101','Y')"
                                     action="#{ins_PayQueryBB.queryAdvance}"/>
                    <h:outputText value=" "></h:outputText>
                <h:commandButton styleClass="button01" value="导出到Excel" type="button" onclick="return forExport();"/>
                </h:panelGroup>
            </h:panelGrid>
            
<c:verbatim>
    </td></tr>

    <tr><td>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="isForward" value="true"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
        </jsp:include>
    </td></tr>
    </table>
</c:verbatim>           
</h:form>
<form id="form2">
    <input type="hidden" name="idStr"/>
</form>
