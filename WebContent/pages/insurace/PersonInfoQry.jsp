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
    function changeInfo(){
        if (checkMutilSelect(form1.chk)) {
            count = form1.chk.length;
            var perID = "";
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        perID = form1.chk[i].value;   // 取第一个
                        break;
                    }
            } else
                perID = form1.chk.value;
            var url="/employee/info/ChangeInfo.jsf?FieldList=A001001,A001077,A754001,A754005&ID="+perID;
            window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
        } else {
            alert("请选择人员");
            return false;
        }
        document.all('form1:btnSearch').click();
        return false;
    }

    function forEdit(form, id, right) {
        var arg = "id=" + id;
        window.open("/pages/insurace/base/PersonInfoFrame.jsp?" + arg, null, "left="+screen.width*0.05+",top="+screen.height*0.01+",height="+screen.height*0.9+",width="+screen.width*0.9+",status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
        window.status = "";
    }
    function forMutilEdit() {
        var frm = document.forms(0);
        if (checkMutilSelect(frm.chk)) {
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;
            windowOpen("", "plist", "", "900", "600", "no", "10", "0", "yes");

            var obj = document.forms(0).chk ;
            var ids = "";
            if (obj.length == null) {
                ids = obj.value + ",";
            } else {
                for (i = 0; i < obj.length; i++) {
                    if (obj[i].checked) {
                        ids += obj[i].value + ",";
                    }
                }
            }
            ids = ids.substr(0, ids.length - 1);
            document.forms(1).idStr.value = ids;
            document.forms(1).target = "plist";
            document.forms(1).method = "post";
            document.forms(1).action = "/pages/wage/base/PersonInfoFrame.jsf";
            document.forms(1).submit();
            document.forms(1).target = "_self";
        } else {
            alert("请选择人员");
            return false;
        }
    }

    function forExport() {
        window.open('/pages/common/ExportToExcel.jsp?sessionKey=<%=Constants.OBJECT%>');
        return null;
    }
    function forSel() {
	    PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
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

<x:saveState value="#{wage_personQueryBB}"/>
<h:inputHidden id="pageInit" value="#{wage_personQueryBB.insPageInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{wage_personQueryBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{wage_personQueryBB.personTypeValue}"/>
    <c:verbatim>
    <table width=100% height=97% border=0 >
    <tr><td height=8px>
    </c:verbatim>
            <h:panelGrid align="left" columns="1" cellpadding="5">
                	<h:panelGroup>
                	<h:commandButton styleClass="button01" value="选择人员类别" onclick="forSel();"
                                     action="#{wage_personQueryBB.doQuery}" />
                    <h:outputText value="姓名或员工编号："/>
                    <h:outputText value=" "></h:outputText>
                    <h:inputText id="searchStr" value="#{wage_personQueryBB.searchStr}"  styleClass="input" style="width:100px;" 
                    	onkeypress ="enterKeyDown('form1:btnSearch')" />
                    <h:commandButton id="btnSearch" styleClass="button01" value="查询" onclick="return chkpersontype()"
                                     action="#{wage_personQueryBB.doQuery}" />
                    <h:outputText value=" "></h:outputText>
                    <h:commandButton styleClass="button01" value="自定义查询"
                                     onclick="return doAdvanceQuery('A','ORG','011','Y','TABLEOBJECT','','N','','Y')"
                                     action="#{wage_personQueryBB.queryAdvance}"/>
                    <h:outputText value=" "></h:outputText>
                <h:commandButton styleClass="button01" value="批量维护" type="button" onclick="return forMutilEdit()"/>
                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" value="导出到Excel" type="button" onclick="return forExport();"/>
                </h:panelGroup>
            </h:panelGrid>
            
<c:verbatim>
    </td></tr>

    <tr><td>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="true"/>
            <jsp:param name="isForward" value="true"/>
            <jsp:param name="rowFuncName" value="forEdit"/>
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
