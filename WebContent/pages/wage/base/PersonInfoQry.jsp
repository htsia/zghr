<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forSel() {
       if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
           disPlayProcessBar();
           document.forms(0).all('form1:btnSearch').click();
       }
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

    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        if (checkMutilSelect(form1.chk)) {
            count = form1.chk.length;
            var str = "";
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        str = form1.chk[i].value;
                        break;
                    }
            } else
                str = form1.chk.value;
            str=str.replace("#","~");  // #不能出现
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+str;
            window.open(url);
        } else {
            alert("请选择人员");
        }
        return false;
    }

    function forUploadFile() {
        reval = window.showModalDialog("/employee/import/PerDataUpload.jsf", null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        if (reval != null) {
            return true;
        } else {
            return false;
        }
    }
    function forEdit(form, id, right) {
        var arg = "id=" + id;
        window.open("/pages/wage/base/PersonInfoFrame.jsf?" + arg, null, "left=100,top=50,height=600,width=900,status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
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
    function doOrderInput() {
        if (checkMutilSelect(form1.chk)) {
            count = form1.chk.length;
            var str = "";
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        str += form1.chk[i].value.replace("#","~") + ",";
                        num++;
                        if (num > 120) {
                            alert("最多只能选择120个人员");
                            return false;
                        }
                    }
            } else
                str = form1.chk.value;
            var reval = window.showModalDialog("/wage/set/OrderInput.jsf?PerStr=" + str, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        } else {
            alert("请选择人员");
            return false;
        }
    }
</script>

<x:saveState value="#{wage_personQueryBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_personQueryBB.pageInit}"/>
     <f:verbatim>
    <table height=95% width=100% border="0" cellspacing="0" cellpadding="0">
     <tr><td height=8>
     </f:verbatim>
                <h:inputHidden id="personType" value="#{wage_personQueryBB.personType}"/>
                <h:inputHidden id="personTypeValue" value="#{wage_personQueryBB.personTypeValue}"/>
    <f:verbatim>
     </td></tr>
     <tr><td height=8 align="left">
     </f:verbatim>
     <f:verbatim>
     				<input name="simple1" type="button" id=15 next=20 class="button01" value="<%=LanguageSupport.getResource("XTGL-1012","选择人员类别") %>"
                       onclick="forSel();">
                    </f:verbatim>
                    <h:outputText value="姓名或员工编号："/>
                    <c:verbatim><input type="text" alt="姓名|0" name="form1:nameStr"
                                       onkeypress="enterKeyDown('form1:btnSearch')"></c:verbatim>
                    <h:commandButton id="btnSearch" styleClass="button01" value="查询"  onclick="return disPlayProcessBar();"
                                     action="#{wage_personQueryBB.queryPersonByName}" />
                    <h:inputHidden id="ManyPerson" value="#{wage_personQueryBB.nameStrs}"></h:inputHidden>
                    <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                     action="#{wage_personQueryBB.queryMultPerson}"/>

                    <h:commandButton styleClass="button01" value="自定义查询"
                                     onclick="return doAdvanceQuery('A','ORG','011','Y','TABLEOBJECT','','N','','Y')"
                                     action="#{wage_personQueryBB.queryAdvance}"/>
    <f:verbatim>
     </td></tr>

     <tr><td height=8 align="left">
     </f:verbatim>
                <h:selectOneMenu id="ReportID" style="width:190px" rendered="#{wage_personQueryBB.oper061501}">
                    <c:selectItems value="#{wage_personQueryBB.reportList}"/>
                </h:selectOneMenu>
                <h:commandButton value="Excel显示" type="button" styleClass="button01" onclick="return OpenRpt();" rendered="#{wage_personQueryBB.oper061501}"></h:commandButton>

                <h:commandButton styleClass="button01" value="数据导入" type="button" rendered="#{wage_personQueryBB.oper061502}"
                                 onclick="return forUploadFile()"/>
                <h:commandButton styleClass="button01" value="批量维护" type="button" onclick="return forMutilEdit()"
                                 disabled="#{wage_personQueryBB.btnRight}"/>
                <h:commandButton value="修改薪资排序" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                              onclick="return doOrderInput()"/>

                <h:commandButton styleClass="button01" value="导出到Excel" type="button" onclick="return forExport();"/>
    <f:verbatim>
    </td></tr>

    <tr><td>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="true"/>
            <jsp:param name="isForward" value="true"/>
            <jsp:param name="editName" value="&#32500;&#25252;"/>
            <jsp:param name="editFuncName" value="forEdit"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
        </jsp:include>
    </td></tr>
    </table>
    </f:verbatim>
</h:form>
<form id="form2">
    <input type="hidden" name="idStr"/>
</form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
