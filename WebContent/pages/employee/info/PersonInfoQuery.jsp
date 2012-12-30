<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>

<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String backFlag = CommonFuns.filterNull(request.getParameter("backFlag"));
    String flag = CommonFuns.filterNull(request.getParameter("flag"));
    User user = (User) session.getAttribute(Constants.USER_INFO);
%>
    <script type="text/javascript">
        function applyChangeInfo(){
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
                forModifyPersonApply(perID); 
            } else {
                alert("请选择人员");
            }
           return false;
        }
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
                document.forms(0).all('form1:queryPerson').click();
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
        // pk 人员ID
        // type=1 只读
        function forView(form, id, type) {
            <%
                 if (!UserAPI.checkButtonOperate(user, "031101")){
                      out.println("type='1';");
                  }
            %>
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
         function clearQueryName(){
        	 document.all("form1:name").value = "";
         }
    </script>

      <x:saveState value="#{emp_personListBB}"></x:saveState>
      <h:form id="form1">
        <h:inputHidden value="#{emp_personListBB.personList}"/>
        <h:inputHidden id="superId" value="#{emp_personListBB.superId}"/>
        <h:inputHidden id="orgMode" value="#{emp_personListBB.orgMode}"/>  
<f:verbatim>
       <input type="hidden" name="sessionFlag" value="2">
       <input type="hidden" name="backFlag" value="<%=backFlag%>">

        <table id=t1 height="100%" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr >
                <td height=8 class="td_page" colspan=2>
                    <input name="simple1" type="button" id=15 next=20 class="button01" value="<%=LanguageSupport.getResource("XTGL-1012","选择人员类别") %>"
                           onclick="forSel();">
</f:verbatim>
                    <h:inputHidden id="personType" value="#{emp_personListBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{emp_personListBB.personTypeValue}"/>
                    <h:outputText value=" "></h:outputText>
<f:verbatim>
                </td>
				 <td height=8 class="td_page">
</f:verbatim>
                    <h:commandButton value="按列修改" onclick="return colEdit();" type="button" rendered="#{emp_personListBB.modiPerson}"  styleClass="button01"/>
                    <h:commandButton value="基本信息变更" onclick="changeInfo();" type="button" rendered="#{emp_personListBB.modiBase}"  styleClass="button01"/>
                    <h:commandButton value="申请变更" onclick="applyChangeInfo();" type="button" rendered="#{emp_personListBB.modiApply}"  styleClass="button01"/>

                    <h:commandButton value="维护多人" onclick="forSelPerson();" type="button"  rendered="#{emp_personListBB.modiPerson}" styleClass="button01"/>
                    <h:commandButton value="设定总排序" onclick="setAllSort();" type="button"   rendered="#{emp_personListBB.haveA001003}" styleClass="button01"/>
<f:verbatim>
                </td>
            </tr>
            <tr>
                <td height=8 class="td_page" colspan=2><%=LanguageSupport.getResource("XTGL-1056","姓名/编号/简拼") %>：
</f:verbatim>
                    <h:inputText id="name" value="#{emp_personListBB.name}"
                                    size="10" styleClass="input"  onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value="查询" id="queryPerson" onclick="javascript:return true;" styleClass="button01"
                                     action="#{emp_personListBB.queryPerson}"/>
                    <h:inputHidden id="ManyPerson" value="#{emp_personListBB.nameStrs}"></h:inputHidden>
                    <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                     action="#{emp_personListBB.queryMultPerson}"/>
                    <h:commandButton value="清除" id="clean_queryName" onclick="clearQueryName()" styleClass="button01" action="#{emp_personListBB.queryPerson}"/>
<f:verbatim>
                </td>

                <td height=8 class="td_page">
</f:verbatim>
                    <h:commandButton value="自定义查询" onclick="javascript:return forAdQry();" styleClass="button01" />
                    <h:selectOneMenu id="displaySet" value="#{emp_personListBB.defaultQry}" onchange="disPlayProcessBar();submit();" valueChangeListener="#{emp_personListBB.changeQuery}">
                        <c:selectItems value="#{emp_personListBB.displaySetList}"></c:selectItems>
                    </h:selectOneMenu>
					 <h:commandButton styleClass="button01" type="button" value="导出Excel" onclick="doExport();"></h:commandButton>
<f:verbatim>
                </td>

             
            </tr>
            <tr>
                <td height=8 class="td_page" colspan=2>
</f:verbatim>
                    <h:selectOneMenu id="ReportID" style="width:190px">
                        <c:selectItems value="#{emp_personListBB.regTableList}"/>
                    </h:selectOneMenu>
                    <h:commandButton styleClass="button01" type="button" value="显示表格" onclick="OpenRpt();"></h:commandButton>
<f:verbatim>
                </td>

                <td height=8 class="td_page">
</f:verbatim>
                    <h:selectOneMenu id="ListReportID" style="width:190px">
                        <c:selectItems value="#{emp_personListBB.listTableList}"/>
                    </h:selectOneMenu>
                    <h:commandButton styleClass="button01" type="button" value="显示机构人员名册" onclick="OpenRosterRpt();"></h:commandButton>
                   
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
<script type="text/javascript">
    interpret(document.forms(0));
</script>
