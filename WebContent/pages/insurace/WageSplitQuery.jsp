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
    function forUpdatebase(){
        var rate = document.all("form1:rate").value.trim();
        var reg = /^\d+$/
        if(reg.test(rate) ){
        	rate=rate.trim();
        	if(rate<1 || rate >100){
        		alert("比例为1-100的数字");
        		return false;
        	}
        	return true;
        }else{
        	alert("比例为1-100的数字");
        	return false;
        }
    }
</script>


<x:saveState value="#{wage_SplitQueryBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_SplitQueryBB.pageInit}"/>
    <c:verbatim>
    <table width=100% height=97% border=0 >
    <tr><td height=8px>
    </c:verbatim>
            <h:panelGrid align="left" columns="1" cellpadding="5">
                	<h:panelGroup>
                	<h:inputHidden id="personType" value="#{wage_SplitQueryBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{wage_SplitQueryBB.personTypeValue}"/>
                    <h:commandButton styleClass="button01" value="选择人员类别" onclick="forSel();"
                                     action="#{wage_SplitQueryBB.queryPersonByName}" />
                    <h:outputText value="姓名或员工编号："/>
                    <h:outputText value=" "></h:outputText>
                    <h:inputText id="searchStr" value="#{wage_SplitQueryBB.searchStr}"  styleClass="input" size="10"
                    	onkeypress ="enterKeyDown('form1:btnSearch')" />
                    <h:commandButton id="btnSearch" styleClass="button01" value="查询" onclick="return chkpersontype();"
                                     action="#{wage_SplitQueryBB.queryPersonByName}" />
                    <h:outputText value=" "></h:outputText>
                    <h:commandButton styleClass="button01" value="自定义查询"
                                     onclick="return doAdvanceQuery('A','ORG','011','Y','','','N','101','Y')"
                                     action="#{wage_SplitQueryBB.queryAdvance}"/>
                    <h:outputText value=" "></h:outputText>
                <h:commandButton styleClass="button01" value="导出到Excel" type="button" onclick="return forExport();"/>
                </h:panelGroup>
            </h:panelGrid>
            <h:panelGrid align="left" columns="1" cellpadding="5">
                <h:panelGroup>
                    <h:inputText id="rate" value="#{wage_SplitQueryBB.rate}"  styleClass="input" size="10" />
                    <h:commandButton styleClass="button01" value="基数测算" onclick="return forUpdatebase();" action="#{wage_SplitQueryBB.updteBase}"/>
					<h:outputText value="  "/>
                    <h:commandButton id="split" styleClass="button01" value="拆分基数" action="#{wage_SplitQueryBB.splitBase}"/>
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
