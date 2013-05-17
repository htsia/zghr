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

      <x:saveState value="#{emp_personListBB2}"/>
      <h:form id="form1">
        <h:inputHidden value="#{emp_personListBB2.pageInit}"/>
        <h:inputHidden id="fieldValue" value="#{emp_personListBB2.fieldValue}"/>  
<f:verbatim>
       <input type="hidden" name="sessionFlag" value="2">
       <input type="hidden" name="backFlag" value="<%=backFlag%>">

        <table id="t1" height="100%" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr >
                <td height="8" class="td_page" colspan="2">
                	</f:verbatim>
                	<h:outputText value="当前机构：#{emp_personListBB2.superName}  "/>
                	<f:verbatim>
                    <input name="simple1" type="button" id=15 next=20 class="button01" value="<%=LanguageSupport.getResource("XTGL-1012","选择人员类别") %>"
                           onclick="forSel();">
</f:verbatim>
                    <h:inputHidden id="personType" value="#{emp_personListBB2.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{emp_personListBB2.personTypeValue}"/>
                    <h:outputText value="  "/>
                    <h:commandButton value="按列修改" onclick="return colEdit();" type="button" rendered="#{emp_personListBB2.modiPerson}"  styleClass="button01"/>
					<h:outputText value="  "/>
                    <h:commandButton value="维护多人" onclick="forSelPerson();" type="button"  rendered="#{emp_personListBB2.modiPerson}" styleClass="button01"/>
<f:verbatim>
                </td>
				 <td height=8 class="td_page">
</f:verbatim>
					<h:outputText value="查询方案："/>
					<h:selectOneMenu id="displaySet" value="#{emp_personListBB2.defaultQry}" onchange="disPlayProcessBar();submit();" valueChangeListener="#{emp_personListBB2.changeQuery}">
                        <c:selectItems value="#{emp_personListBB2.displaySetList}"></c:selectItems>
                    </h:selectOneMenu>
                    <h:outputText value="  "/>
                    <h:selectOneMenu id="ReportID" style="width:100px">
                        <c:selectItems value="#{emp_personListBB2.regTableList}"/>
                    </h:selectOneMenu>
                    <h:commandButton styleClass="button01" type="button" value="显示表格" onclick="OpenRpt();"/>
                    <h:outputText value="  "/>                    
                    <h:commandButton styleClass="button01" type="button" value="导出Excel" onclick="doExport();"></h:commandButton>
<f:verbatim>
                </td>
            </tr>
            <tr>
                <td height="8" class="td_page" colspan="2"><%=LanguageSupport.getResource("XTGL-1056","姓名/编号/简拼") %>：
</f:verbatim>
                    <h:inputText id="name" value="#{emp_personListBB2.name}"
                                    size="10" styleClass="input"  onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value="查询" id="queryPerson" onclick="disPlayProcessBar();" styleClass="button01"
                                     action="#{emp_personListBB2.queryPerson}"/>
                    <h:commandButton value="清除" onclick="return clearQuery();" styleClass="button01"
                                     action="#{emp_personListBB2.queryPerson}"/>
                    <h:outputText value="  "/>
                    <h:inputHidden id="ManyPerson" value="#{emp_personListBB2.nameStrs}"></h:inputHidden>
                    <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                     action="#{emp_personListBB2.queryMultPerson}"/>
                    <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01" /> 
<f:verbatim>
                </td>

                <td height=8 class="td_page">
</f:verbatim>
					<h:commandButton value="设置显示项目" onclick="setItem();" styleClass="button01" rendered="#{emp_personListBB2.showSetItem}"/>
                    <h:outputText value="  "/>
                    <h:selectOneMenu id="fieldID" value="#{emp_personListBB2.fieldID}" onchange="selField();">
                        <c:selectItems value="#{emp_personListBB2.fieldList}"/>
                    </h:selectOneMenu>
                    <h:selectOneMenu id="oper" value="#{emp_personListBB2.oper}">
                       <c:selectItem itemValue='equal' itemLabel="等于"/>
	                   <c:selectItem itemValue='notequal' itemLabel="不等于"/>
	                   <c:selectItem itemValue='morethan' itemLabel="大于"/>
	                   <c:selectItem itemValue='lessthan' itemLabel="小于"/>
	                   <c:selectItem itemValue='moreequal' itemLabel="大于等于"/>
	                   <c:selectItem itemValue='lessequal' itemLabel="小于等于"/>
	                   <c:selectItem itemValue='in' itemLabel="在列表中"/>
	                   <c:selectItem itemValue='notin' itemLabel="不在列表中"/>
	                   <c:selectItem itemValue='like' itemLabel="匹配"/>
	                   <c:selectItem itemValue='notlike' itemLabel="不匹配"/>
	                   <c:selectItem itemValue='exist' itemLabel="存在"/>
	                   <c:selectItem itemValue='notexist' itemLabel="不存在"/>
	                   <c:selectItem itemValue='isnull' itemLabel="为空"/>
	                   <c:selectItem itemValue='notisnull' itemLabel="不为空"/>
                    </h:selectOneMenu>
                    <f:verbatim>
                    	<input id="fieldValue1" size="15" class="input" readonly="true"/>
                    </f:verbatim>
                    <c:verbatim>
	                   <input id="selCode1" type="button" class="button_select" onclick="selCode11();" style="display: none;"/>
	                </c:verbatim>
	                <h:commandButton value="简单查询" onclick="return forQuery2();" styleClass="button01"
                                     action="#{emp_personListBB2.queryPerson2}" />
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
            document.getElementById('form1:name').value='';
			disPlayProcessBar();
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
     
     function clearQuery(){
 		disPlayProcessBar();
 		document.getElementById('form1:name').value='';
 		return true;
 	 }
     
     function setItem(){
    	 window.showModalDialog("/custom/emp/empQueryItemSetting.jsf", "", "dialogWidth:800px; dialogHeight:500px; status:0;");
    	 disPlayProcessBar();
     }
</script>
