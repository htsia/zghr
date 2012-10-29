<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<script type="text/javascript">
        function clearws() {
		    document.getElementById("checkSubmitFlg").value="0"; 
        }
        function clearStatew() {
            setInterval("clearws()",2000);
        }
        function openPersonDoc(){
        	var perId = document.all("form1:personId").value;
        	window.open('/doc/OrgBasicInfo.jsf?fk='+perId+"&print=1",'newwindow','top=0,left=0,toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,location=no,status=yes');
        }
         function OpenRpt(){
             if (document.all("form1:ReportID").value=="-1"){
                 alert("请先选择表格样式！");
                 return false;
             }
             doShowOrgTable(document.all("form1:ReportID").value,document.all('form1:personId').value);
             return false;
         }
    
</script>
<c:verbatim>
<style type="text/css">
<!--
.style1
{
    font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border:2px solid #555555;
}
.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style1 TR {
	FONT-SIZE: 9pt; COLOR: #555555; 
	border:1px solid #555555;
}
.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	vertical-align:middle;
	font-family: "宋体";
	border:1px solid #555555;
}
-->
</style>
</c:verbatim>

<x:saveState value="#{doc_DeptNoteBackingBean}" />
<h:form id="form1">
	<h:inputHidden value="#{doc_DeptNoteBackingBean.pageInit}" />
	<h:inputHidden id = "personId" value="#{doc_DeptNoteBackingBean.orgId}"/>

    <f:verbatim>
        <br>
        <table width=800 align="left" cellpadding="0" cellspacing="0">
        <tr  valign="middle">
            <td align="center" width="90" class=tab><a href="/self/PostBookQuery.jsf">岗位职责</a></td>
            <td align="center" width="90" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/self/DeptBookQuery.jsf">部门职责</a></td>
            <td class=notab>&nbsp;&nbsp;</td>
         </tr>

        <tr>
            <td colspan="3" valign="top" align="left">
            <div class="tabbody" height="100%" width="620"  id=datatable align="center">
            <br>
            <jsp:include page="/pages/doc/DeptBookShow.jsp" >
                <jsp:param name="Init" value="true"/>
            </jsp:include>
            </div>    
        </td>
        </tr>
        </table>
    </f:verbatim>
	
</h:form>


