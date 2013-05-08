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
function forChange() {
    if (checkMutilSelect(document.form1.chk)) {
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
        window.showModalDialog("/custom/empTypeChangeMgr.jsf?userIDs="+ids, null, "dialogWidth:400px; dialogHeight:270px;center:center;resizable:no;status:no;scroll:yes;");
        document.getElementById('form1:queryPerson').click();
        return false;
    } else {
        alert("请选择人员！");
        return false;
    }
}
</script>
      <x:saveState value="#{emp_personListBB}"/>
      <h:form id="form1">
        <h:inputHidden value="#{emp_personListBB.pageInit}"/>
        <h:inputHidden value="#{emp_personListBB.personList}"/>
        <h:inputHidden id="superId" value="#{emp_personListBB.superId}"/>
        <h:inputHidden id="orgMode" value="#{emp_personListBB.orgMode}"/>  
<f:verbatim>
       <input type="hidden" name="sessionFlag" value="2">
       <input type="hidden" name="backFlag" value="<%=backFlag%>">

        <table id="t1" height="100%" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr >
                <td height="8" class="td_page">
                	</f:verbatim>
                	<h:outputText value="当前机构：#{emp_personListBB.superName}  "/>
                	<f:verbatim>
                    <input name="simple1" type="button" id=15 next=20 class="button01" value="<%=LanguageSupport.getResource("XTGL-1012","选择人员类别") %>"
                           onclick="forSel();">
</f:verbatim>
                    <h:inputHidden id="personType" value="#{emp_personListBB.personType}"/>
                    <h:outputText id="personTypeValue" value="当前人员类别：#{emp_personListBB.personTypeValue}"/>
<f:verbatim>
                </td>
            </tr>
            <tr>
                <td height="8" class="td_page"><%=LanguageSupport.getResource("XTGL-1056","姓名/编号/简拼") %>：
</f:verbatim>
                    <h:inputText id="name" value="#{emp_personListBB.name}"
                                    size="10" styleClass="input"  onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value="查询" id="queryPerson" onclick="javascript:return true;" styleClass="button01"
                                     action="#{emp_personListBB.queryPerson}"/>
                    <h:commandButton value="清除" onclick="javascript:document.getElementById('form1:name').value='';" styleClass="button01"
                                     action="#{emp_personListBB.queryPerson}"/>
                    <h:outputText value="  "/>
                    <h:inputHidden id="ManyPerson" value="#{emp_personListBB.nameStrs}"></h:inputHidden>
                    <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                     action="#{emp_personListBB.queryMultPerson}"/>
                    <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01" />
                    <h:outputText value="  "/>
                    <h:commandButton value="变动人员类别" onclick="return forChange();" type="button" styleClass="button01"/>
<f:verbatim>
                </td>
            </tr>
            <tr><td>
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
         doAdvanceQuery("A","ORG","111","Y","","A001.A001730='<%=Constants.NO%>'","Y","","Y","1");
     }
     function clearQueryName(){
    	 document.all("form1:name").value = "";
     }
     
     var dict_num=null;
     var dateType=null;
     
     function selField(){
    	 var fieldID=document.getElementById("form1:fieldID").value;
    	 dict_num=null;
    	 dateType=null;
    	 document.getElementById("form1:fieldValue").value='';
    	 document.getElementById("fieldValue1").value='';
    	 if(fieldID!=-1){
        	 $.post("/pages/custom/getFieldType.jsp?field="+fieldID, function(e){
        	 	var v=e.split("|");
        	 	dateType=v[0];
	    		if(dateType!=1 && dateType!=3){
		    		dict_num=v[1];
	    			$("#selCode1").show();
			    	document.getElementById("fieldValue1").readOnly =true;
	    		}else{
			    	$("#selCode1").hide();
			    	document.getElementById("fieldValue1").readOnly =false;
	    		}
	    	 });
    	 }else{
	    	 document.getElementById("fieldValue1").readonly=true;
    		 $("#selCode1").hide();	        		 
    	 }
     }
     function selCode11(){
    	 var oper1=document.getElementById("form1:oper").value;
    	 if(dateType==5){
    		 PopUpCalendarDialog(document.getElementById("fieldValue1"));
    	 }else if(dateType==15){
    		 PopUpCalendarDlg_OnlyMonth(document.getElementById("fieldValue1"));
    	 }else if(dateType==6){
    		 if (oper1=='in' || oper1=='notin'){
   	         	PopUpMutilCodeDlgNoSubmit(document.getElementById("form1:fieldValue"), document.getElementById("fieldValue1"), dict_num,'');        			 
    		 }else{
   	            PopUpCodeDlgTwoControl(document.getElementById("form1:fieldValue"), document.getElementById("fieldValue1"), dict_num);        	        	
    	     }
    	 }
     }
     function forQuery2(){
    	 var fieldID=document.getElementById("form1:fieldID").value;
    	 var oper1=document.getElementById("form1:oper").value;
    	 var value=document.getElementById("fieldValue1").value;
    	 value=$.trim(value);
    	 if(fieldID!='-1'){
    		 if(oper1 == "isnull" || oper1 == "notisnull"){
                 return true;
             }
    		 if(value.length>0){
    			 if(dateType!=6){
	    			 document.getElementById("form1:fieldValue").value=value;
    			 }
    			 if ((dateType == 1 || dateType == 2) && isNaN(value)) {
   	             	alert("请输入数字");
   	                return false;
   	             }
    			 return true;
    		 }else{
        		 alert("请输入查询条件");
        		 return false;
    		 }
    	 }else{
    		 alert("请选择指标");
    		 return false;
    	 }
     }
</script>
