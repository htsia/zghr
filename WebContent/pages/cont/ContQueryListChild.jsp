<%@ page contentType="text/html;charset=GBK" language="java" pageEncoding="GBK"%>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function OpenRosterRpt(){
        if (document.all("form1:ListReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }

        if (document.all('form1:superId').value!=null && document.all('form1:superId').value!=""){
            doShowPersonRoster(document.all("form1:ListReportID").value,document.all('form1:superId').value);
        } else {
            alert("请选择机构");
        }
       return false;
    }

    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }

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
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID=&Parameter=&Title=";
            window.open(url);
        } else {
            alert("请选择人员");
        }
       return false;
   }
    
    function doQueryManyPerson(){
        var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
        if (reval != null && reval !="") {
            document.all('form1:ManyPerson').value = reval;
            return true;
        } else {
            return false;
        }
    }

    function forUploadFile() {
        var arg = "act=selectInfoItem"
        reval = window.showModalDialog("/wage/base/PersonInfoUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        if (reval != null) {
            return true;
        } else {
            return false;
        }
    }
    function forEdit(form, id, right) {
        var arg = "id=" + id;
        window.open("/pages/cont/base/PersonInfoFrame.jsp?" + arg, null, "left=100,top=50,height=600,width=900,status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
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
</script>

<x:saveState value="#{cont_personQueryBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{cont_personQueryBB.personList}"/>
    <h:inputHidden id="superId" value="#{cont_personQueryBB.superId}"/>
    <f:verbatim>
    <table height="98%" width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
           <td class="td_page" height=8>
    </f:verbatim>
                <h:outputText escape="false" value="<strong>当前单位:#{cont_personQueryBB.unitName}</strong>"/>
                <h:outputText value="     "></h:outputText>
<f:verbatim>
          </td>
           <td class="td_page" align="left">
</f:verbatim>
               <h:commandButton styleClass="button01" type="button" value="导出Excel" onclick="doExport();"></h:commandButton>
<f:verbatim>
           </td>
           <td class="td_page">
</f:verbatim>
               <h:selectOneMenu id="displaySet" value="#{cont_personQueryBB.defaultQry}" >
                   <c:selectItems value="#{cont_personQueryBB.displaySetList}"></c:selectItems>
               </h:selectOneMenu>
               <h:commandButton value="启用" styleClass="button01" action="#{cont_personQueryBB.changeQuery}"></h:commandButton>
<f:verbatim>
           </td>
        </tr>
        <tr>
            <td class="td_page" height=8>
</f:verbatim>
                <h:outputText value="姓名或员工编号："></h:outputText>
                <h:inputText id="name" value="#{cont_personQueryBB.name}"
                                    size="10" styleClass="input"  onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value="查询" id="queryPerson" onclick="javascript:return true;" styleClass="button01"
                                     action="#{cont_personQueryBB.queryPerson}"/>
                    <h:inputHidden id="ManyPerson" value="#{cont_personQueryBB.nameStrs}"></h:inputHidden>
                    <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                     action="#{cont_personQueryBB.queryMultPerson}"/>
                    <h:commandButton styleClass="button01" value="自定义查询"
                                 onclick="return doAdvanceQuery('A','ORG','011','Y','','','Y','160','Y','1')"  />
<f:verbatim>
           </td>
            <td class="td_page" align="left" height=8 colspan=2>
</f:verbatim>
                <h:selectOneMenu id="ReportID" style="width:190px">
                    <c:selectItems value="#{cont_personQueryBB.contReportList}"/>
                </h:selectOneMenu>
                <h:commandButton value="显示个人表" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
                <h:selectOneMenu id="ListReportID" style="width:190px">
                    <c:selectItems value="#{cont_personQueryBB.contListReportList}"/>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" type="button" value="显示名册" onclick="OpenRosterRpt();"></h:commandButton>
<f:verbatim>
            </td>
       </tr>
       <tr><td colspan=3 height=8></td></tr>

        <tr>
           <td colspan=3>
                <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                    <jsp:param name="hasOperSign" value="true"/>
                    <jsp:param name="operSignType" value="checkbox"/>
                    <jsp:param name="hasEdit" value="true"/>
                    <jsp:param name="isForward" value="true"/>
                    <jsp:param name="editName" value="维护"/>
                    <jsp:param name="editFuncName" value="forEdit"/>
                    <jsp:param name="isEditList" value="false"/>
                    <jsp:param name="isCheckRight" value="false"/>
                </jsp:include>
           </td>
       </tr>
    </table>
</f:verbatim>
</h:form>
<form id="form2">
    <input type="hidden" name="idStr"/>
</form>
