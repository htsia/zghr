<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"  %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String backFlag = CommonFuns.filterNull(request.getParameter("backFlag"));
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
                var url="/employee/info/ChangeInfo.jsf?FieldList=A001001,A001077&ID="+perID;
                window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
            } else {
                alert("请选择人员");
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
                var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID="+document.all("form1:superId").value+"&Parameter=&Title=";
                window.open(url);
            } else {
                var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:superId").value+"&Parameter=&Title=";
                window.open(url);
            }
           return false;
       }
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
        function doQueryManyPerson(){
            var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
            if (reval != null && reval !="") {
                document.all('form1:ManyPerson').value = reval;
                return true;
            } else {
                return false;
            }
        }

        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&type="+type, "aa", "", "1000", "600", "no","10","1","yes");
        }
        function forSel() {
           if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                  document.forms(0).all('form1:queryPerson').click();
           }
        }
        function setAllSort(){
            if (checkMutilSelect(document.forms(0).chk)) {
                showx = event.screenX - event.offsetX - 150;
                showy = event.screenY - event.offsetY + 18;
                windowOpen("","plist","","1000","600","yes","10","0","yes");
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
                document.forms(1).perids.value = ids;
                document.forms(1).target = "plist";
                document.forms(1).method = "post";
                document.forms(1).action = "/employee/sort/OrderInput.jsf";
                document.forms(1).submit();
                document.forms(1).target = "_self";
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
        }
        function forSelPerson() {
            if (checkMutilSelect(document.forms(0).chk)) {
                showx = event.screenX - event.offsetX - 150;
                showy = event.screenY - event.offsetY + 18;
                windowOpen("","plist","","1000","600","no","10","0","yes");
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
                document.forms(1).perids.value = ids;
                document.forms(1).target = "plist";
                document.forms(1).method = "post";
                document.forms(1).action = "/employee/info/PersonManyEditInfo.jsf";
                document.forms(1).submit();
                document.forms(1).target = "_self";
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
        }
         function forAdQry(){
             document.all("form1:name").value = "";
             doAdvanceQuery("A","ORG","111","Y","","A001.A001730='<%=Constants.NO%>'","Y","<%=Constants.DEFAULT_QUERY_PERSON%>","Y","1");
         }
    
    </script>

      <x:saveState value="#{personPassQueryBB}"></x:saveState>
      <h:form id="form1">
        <h:inputHidden value="#{personPassQueryBB.personList}"/>
        <h:inputHidden id="superId" value="#{personPassQueryBB.superId}"/>       
<f:verbatim>
    <input type="hidden" name="sessionFlag" value="2">
    <input type="hidden" name="backFlag" value="<%=backFlag%>">

        <table id=t1 height=98% width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr >
                <td height=8 class="td_page" colspan=3>
                    <input name="simple1" type="button" id=15 next=20 class="button01" value="<%=LanguageSupport.getResource("XTGL-1012","选择人员类别")%>"
                           onclick="forSel();">
</f:verbatim>
                    <h:inputHidden id="personType" value="#{personPassQueryBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{personPassQueryBB.personTypeValue}"/>
                    <h:outputText value="#{personPassQueryBB.personTypeDesc}"></h:outputText>
<f:verbatim>
                </td>
            </tr>
            <tr>
                <td height=8 class="td_page"> <%=LanguageSupport.getResource("XTGL-1013","姓名或员工编号 ")%> ：
</f:verbatim>
                    <h:inputText id="name" value="#{personPassQueryBB.name}"
                                    size="10" styleClass="input"  onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value="查询" id="queryPerson" onclick="javascript:return true;" styleClass="button01"
                                     action="#{personPassQueryBB.queryPerson}"/>
                    <h:inputHidden id="ManyPerson" value="#{personPassQueryBB.nameStrs}"></h:inputHidden>
                    <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                     action="#{personPassQueryBB.queryMultPerson}"/>
<f:verbatim>
                </td>

                <td height=8 class="td_page">
</f:verbatim>
                   <h:commandButton value="维护多人" onclick="forSelPerson();" type="button"
                                     styleClass="button01"/>
                   <h:outputText value=" "></h:outputText>
                   <h:commandButton styleClass="button01" type="button" value="导出Excel" onclick="doExport();"></h:commandButton>
<f:verbatim>
                </td>
            </tr>
            
            <tr ><td colspan=3>
            <jsp:include page="../../common/activepage/ActiveList.jsp">
                <jsp:param name="hasOperSign" value="true"/>
                <jsp:param name="operSignType" value="checkbox"/>
                <jsp:param name="hasEdit" value="true"/>
                <jsp:param name="isEditList" value="false"/>
                <jsp:param name="isCheckRight" value="true"/>
                <jsp:param name="isForward" value="true"/>
                <jsp:param name="isRow" value="true"/>
                <jsp:param name="rowFuncName" value="forView"/>
                <jsp:param name="isPage" value="true"/>
            </jsp:include>
            </td>    
            </tr>
        </table>
</f:verbatim>          
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
