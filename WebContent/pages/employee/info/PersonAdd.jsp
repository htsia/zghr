<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %> 
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.sys.pojo.bo.WFTypeBO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgEnterBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user=(User)session.getAttribute(Constants.USER_INFO);
%>

<script type="text/javascript">

var info = "";
function selPost(){
    var deptId=document.all("form1:A001705").code;
	if(deptId == null || deptId==""){
		alert("请选择部门");
		return false;
	}
    PopUpPostDlgByDept(document.all("form1:A001715"),null,deptId);
}

function selectTypeFun(){
   PopUpCodeDlgOneControl('form1:A016010','0200110001');
}

//XMLHttpRequest状态改变时要执行的函数
function handleStateChange() {
    if (xmlHttp.readyState == 4) {
        if (xmlHttp.status == 200) {
            //解析从xml文件得到的结果,动态画树
            parseResults();
        }
    }
}

//解析从xml文件得到的结果
function parseResults() {
    var results = xmlHttp.responseXML;
    var orgs = null;
    var trees = results.getElementsByTagName("message");
    for (var i = 0; i < trees.length; i++) {
        orgs = trees[i];
        info = orgs.getElementsByTagName("info")[0].firstChild.nodeValue;
    }
}
//创建XMLHttpRequest对象
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}

function forCheck() {
    //debugger;
    var queryString = createQueryString("A001",document.forms(0));
    createXMLHttpRequest();
    xmlHttp.open("POST", "/pages/ajax/Check.jsp", false);
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
    xmlHttp.send(queryString);

    if (info != null && info != "" && info != "no") {
    	alert(info);
        return false;
    }
    return true;
}

function forSave() {
    if (forCheck()) {
        return forsubmit(document.forms(0));
    }
    return false;
}

function selWorkTime() {
    <%
       InfoItemBO workTime=SysCacheTool.findInfoItem("A001","A001041");
       if (InfoItemBO.DATA_TYPE_DATE6.equals(workTime.getItemDataType())){
    %>
        PopUpCalendarDlg_OnlyMonth("form1:A001041");
    <%
       }
       else{
     %>
         PopUpCalendarDialog("form1:A001041");
    <%
     }
    %>
}

function selUnitTime() {
    <%
       InfoItemBO unitTime=SysCacheTool.findInfoItem("A001","A001044");
       if (InfoItemBO.DATA_TYPE_DATE6.equals(unitTime.getItemDataType())){
    %>
        PopUpCalendarDlg_OnlyMonth("form1:A001044");
    <%
       }
       else{
     %>
         PopUpCalendarDialog("form1:A001044");
    <%
     }
    %>
    document.all("form1:A016020").value = document.all("form1:A001044").value;
}

function selPartTime() {
    <%
       InfoItemBO partTime=SysCacheTool.findInfoItem("A001","A001718");
       if (InfoItemBO.DATA_TYPE_DATE6.equals(partTime.getItemDataType())){
    %>
        PopUpCalendarDlg_OnlyMonth('form1:A001718')
    <%
       }
       else{
     %>
         PopUpCalendarDialog("form1:A001718");
    <%
     }
    %>
}
function selSysTime() {
    <%
       InfoItemBO sysTime=SysCacheTool.findInfoItem("A001","A001781");
       if (InfoItemBO.DATA_TYPE_DATE6.equals(sysTime.getItemDataType())){
    %>
        PopUpCalendarDlg_OnlyMonth('form1:A001781')
    <%
       }
       else{
     %>
         PopUpCalendarDialog("form1:A001781");
    <%
     }
    %>
}
function selAddTime() {
    <%
       InfoItemBO addTime=SysCacheTool.findInfoItem("A016","A016020");
       if (InfoItemBO.DATA_TYPE_DATE6.equals(addTime.getItemDataType())){
    %>
        PopUpCalendarDlg_OnlyMonth('form1:A016020')
    <%
       }
       else{
     %>
         PopUpCalendarDialog("form1:A016020");
    <%
     }
    %>
}


</script>

<h:form id="form1">
<h:inputHidden  id="type" value="#{emp_personAddBB.type}"></h:inputHidden>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif"> 
                  <%=LanguageSupport.getResource("YGL-0300", "人员管理")%>   ->
                  <%=LanguageSupport.getResource("RYGL-2327", "新员工入职")%>
        </td>
        <td class="td_title" align="right">
            <%
                if ("1".equals(Constants.AUTO_CACL_BIRTH)) out.println(LanguageSupport.getResource("RYGL-2328", "根据身份证计算性别/出生日期:开启"));
                else out.println(LanguageSupport.getResource("RYGL-2329", "根据身份证计算性别/出生日期:关闭"));
            %>
            &nbsp;&nbsp;
            <%
                if ("1".equals(Constants.EMP_ADD_AFTER_APPROVE) || "2".equals(Constants.EMP_ADD_AFTER_APPROVE))
                    out.println("<font color=red>注意：新增人员需审批后才生效</font>");
                if ("2".equals(Constants.EMP_ADD_AFTER_APPROVE)) {
                    out.println("<input type='button' class='button01' value='流程说明' onclick='showWorkDefine(\"" + WFTypeBO.RYGL_COMMON_IN + "\")'>");
                }
            %>
        </td>
    </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f05 width=75%>
            <%= LanguageSupport.getResource("RYGL-2325", "基本信息")%>     
        </td>
</f:verbatim>
        <!-- <td class="td_form01" width="120">
         <%= LanguageSupport.getResource("XTGL-1042", "员工编号")%>     
        </td> -->
        <td class="td_form02">
		<!-- 修改开始1 -->
            <h:inputText styleClass="input" id="A001735" value="#{emp_personAddBB.personvo.personCode}"   readonly="true"  alt="员工编号|1|s|50||"  />
		<!-- 修改结束1 -->
<f:verbatim>
        </td>
        <%
            try{
                IPersonUCC uu = (IPersonUCC) SysContext.getBean("emp_personUCC");
                out.print("<script type=\"text/javascript\">");
                out.print("document.all('form1:A001735').value=\""+uu.getNextPersonCode(user.getOrgId())+"\";");
				out.print("document.all('form1:A001735').style.display='none';");
                out.print("</script>");
            }
            catch(Exception e){

            }
        %>
    </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01 td_form_required" width="120">  <%= LanguageSupport.getResource("MSG-0010", "姓名")%> </td>
    <td class="td_form02">
</f:verbatim>
        <h:inputText styleClass="input"  id="A001001" value="#{emp_personAddBB.personvo.name}" alt="姓名|0|s|50||"/>
<f:verbatim>
    </td>
    <td class=td_form01  width="120"><%= LanguageSupport.getResource("RYGL-2330", "员工照片")%> </td>
    <td class=td_form02  >
        <iframe name=uploadPhoto frameBorder=0 width=150 height=98% scrolling=no
                src='/common/UploadPhoto.jsf?imageItemId=A001780'></iframe>
        <div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;left:800px;top:55px;display:none;" onMouseDown="catchFilter()" onMouseUp="releaseFilter()">
            <img id=showZP src="" width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> alt="照片">
        </div>
        &nbsp;<%out.print(Constants.EMP_PHOTO_DESCRIPTION);%>
    </td>
</tr>
<tr nowrap>
    <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-1015", "身份证号")%> </td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001077"  size="20"
                     value="#{emp_personAddBB.personvo.idNum}"
                     alt="身份证号|0|s|50||"/>
<f:verbatim>
    </td>
    
	<td class="td_form01 "> <%=LanguageSupport.getResource("MSG-0013", "出生日期")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001011"  size="21"  value="#{emp_personAddBB.personvo.birth}"
                     readonly="true" alt="出生日期|1|d|50||"/>
<f:verbatim>
         <%if ("1".equals(Constants.AUTO_CACL_BIRTH)){%>
            从身份证号得到
         <%}else{%>
            <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
         <%}%>
    </td>
</tr>

<tr nowrap>
    <!-- <td class="td_form01 "> <%=LanguageSupport.getResource("MSG-0013", "出生日期")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001011" value="#{emp_personAddBB.personvo.birth}"
                     readonly="true" alt="出生日期|1|d|50||"/>
<f:verbatim>
         <%if ("1".equals(Constants.AUTO_CACL_BIRTH)){%>
            从身份证号得到
         <%}else{%>
            <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
         <%}%>
    </td> -->
	<td class="td_form01 td_form_required"><%=LanguageSupport.getResource("XTGL-1044", "员工类别")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{emp_personAddBB.personvo.personType}"
                     alt="员工类别|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')">
    </td>
    <td  class="td_form01 "><%=LanguageSupport.getResource("MSG-0012", "性别")%></td>
    <td class=td_form02 >
</f:verbatim>
        <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                     readonly="true"  size="21"   value="#{emp_personAddBB.personvo.sex}"
                     alt="性别|1|s|50||"/>
<f:verbatim>
        <%if ("1".equals(Constants.AUTO_CACL_BIRTH)){%>
          从身份证号得到
        <%}else{%>
           <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')">
         <%}%>
    </td>

</tr>

<tr nowrap>
    <td class="td_form01 td_form_required"> <%=LanguageSupport.getResource("RYGL-2063", "所在机构")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
                     readonly="true" value="#{emp_personAddBB.personvo.deptId}"
                     alt="所在机构|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_org" onclick="PopUpOrgDlgShowGroup('form1:A001705',2)">
    </td>

<!--修改2开始  这段修改的代码，是从下面复制过来的。-->	
<!-- <td class="td_form01 td_form_required"><%=unitTime.getItemName()%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001044" value="#{emp_personAddBB.personvo.unitTime}"
                     readonly="true" alt="来公司时间|1|d6|50||"/>
<f:verbatim>
        <script type="text/javascript">
            document.all('form1:A001044').alt = "<%=unitTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(unitTime.getItemDataType())%>|50||";
        </script>
        <input type="button" class="button_date" onclick="selUnitTime();"></td> -->
<!--修改2结束-->

<td class=td_form01> <%=LanguageSupport.getResource("JGGL-1078", "岗位名称")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001715" code="" dict="yes" dict_num="PO"
                     readonly="true"  size="21"   value="#{emp_personAddBB.personvo.postId}"
                     alt="岗位|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_post" onclick="selPost()">
    </td>

    
</tr>

<tr>
<td class="td_form01 td_form_required"><%=unitTime.getItemName()%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001044" value="#{emp_personAddBB.personvo.unitTime}"
                     readonly="true" alt="来公司时间|1|d6|50||"/>
<f:verbatim>
        <script type="text/javascript">
            document.all('form1:A001044').alt = "<%=unitTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(unitTime.getItemDataType())%>|50||";
        </script>
        <input type="button" class="button_date" onclick="selUnitTime();"></td>
    <!-- <td class=td_form01> <%=LanguageSupport.getResource("JGGL-1078", "岗位名称")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001715" code="" dict="yes" dict_num="PO"
                     readonly="true" value="#{emp_personAddBB.personvo.postId}"
                     alt="岗位|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_post" onclick="selPost()">
    </td> -->
<!--修改3开始   把 td  隐藏掉-->
    <td id="td_postLevel" class="td_form01 td_form_required">当前状态</td>
    <td class=td_form02>
</f:verbatim>
        <h:selectOneMenu value="#{emp_personAddBB.personvo.status}">
        	<c:selectItems value="#{emp_personAddBB.currStatusList}"/>
        </h:selectOneMenu>
<f:verbatim>
       
    </td>
</tr>
<!--修改3结束-->

<!--修改4开始  注释部分代码，复制到修改 2 处，未注释部分， 把tr 隐藏掉了。 -->
<tr nowrap id = "hiddentr">
	<!-- <td class="td_form01 td_form_required"><%=unitTime.getItemName()%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001044" value="#{emp_personAddBB.personvo.unitTime}"
             readonly="true" alt="来公司时间|1|d6|50||"/>
<f:verbatim>
       
        <input type="button" class="button_date" onclick="selUnitTime();"></td> -->
	
		 <script type="text/javascript">
            document.getElementById("hiddentr").style.display = "none";
        </script>
<!--修改4结束-->
    <td class="td_form01 "><%=sysTime.getItemName()%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001781" value="#{emp_personAddBB.personvo.sysTime}"
                     readonly="true" alt="进入本系统时间|1|d6|50||"/>
<f:verbatim>
    <script type="text/javascript">
        document.all('form1:A001781').alt = "<%=sysTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(sysTime.getItemDataType())%>|50||";
    </script>

    <input type="button" class="button_date" onclick="selSysTime();">
    </td>
	<td class="td_form01 td_form_required">
</f:verbatim>
    <h:outputText value="#{sys_commonInfoBB.a001031des}" rendered="#{sys_commonInfoBB.a001031used}"></h:outputText>
<f:verbatim>
    </td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001031" code="" dict="yes" dict_num="0140"  rendered="#{sys_commonInfoBB.a001031used}"
                     readonly="true" value="#{emp_personAddBB.personvo.personIdentity}"
                     alt="员工身份|0|s|50||"/>
        <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:A001031')" rendered="#{sys_commonInfoBB.a001031used}"/>
<f:verbatim>
    </td>
</tr>

<tr nowrap>
    <td class=td_form01><%=LanguageSupport.getResource("JGGL-1010", "备注")%></td>
    <td class=td_form02 colspan="3">
</f:verbatim>
        <h:inputTextarea rows="3" id="A001784" cols="86" value="#{emp_personAddBB.personvo.memo}"/>
<f:verbatim>
    </td>
</tr>
</table>
<br>

<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class="f05"><%=LanguageSupport.getResource("RYGL-2332", "增员情况")%></td>
    </tr>
</table>

<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
    <tr nowrap>
        <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("XTGL-1047", "增员类别")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                         readonly="true" value="#{emp_personAddBB.personchangevo.changeType}"
                         alt="增员类别|0|s|50||"/>
            <h:commandButton type="button" styleClass="button_select"  id="selectType" />
<f:verbatim>

        </td>
        <td class="td_form01 td_form_required" width="120"><%=addTime.getItemName()%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="A016020" value="#{emp_personAddBB.personchangevo.changeDate}"  readonly="true" alt="增员时间|0|d6|50||"/>
            <h:commandButton type="button" styleClass="button_date" onclick="selAddTime();"/>
<f:verbatim>
    <script type="text/javascript">
        document.all('form1:A016020').alt = "<%=addTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(addTime.getItemDataType())%>|50||";
    </script>

        </td>
    </tr>
</table>
    <%
        IPersonUCC personucc = (IPersonUCC) SysContext.getBean("emp_personUCCImpl");
        OrgEnterBO oo=personucc.getOrgEnterBO(user.getOrgId());
        if (oo!=null && oo.getWageItems()!=null){
            String []items=oo.getWageItems().split(",");
            out.println("<br><table width=95% align=center border=0 cellpadding=0 cellspacing=0><tr nowrap><td class=f05>薪酬情况</td></tr></table>");
            out.println("<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class='table03'>");
            for(int i=0;i<items.length;i++){
                InfoItemBO ib=SysCacheTool.findInfoItem("",items[i]);
                out.println("<tr nowrap>");
                out.println("<td class=td_form01>"+ib.getItemName()+"</td>");
                out.println("<td class=td_form02>");
                if (InfoItemBO.DATA_TYPE_CODE.equals(ib.getItemDataType())){
                   out.println("<input id='"+ib.getItemId()+"' name='"+ib.getItemId()+"' type='text' value=''  code='' dict='yes' dict_num='"+ib.getItemCodeSet()+"' class='input' >");
                   out.println("<input id='btn"+ib.getItemId()+"' name='btn"+ib.getItemId()+"' type='button' onclick=\"PopUpCodeDlgOneControl('"+ib.getItemId()+"');\" class='button_select' >");
                }
                else{
                    out.println("<input id='"+ib.getItemId()+"' name='"+ib.getItemId()+"' type='text' value=''  class='input' >");
                }
                out.println("</td>");
                if (i<items.length){
                    i++;
                    ib=SysCacheTool.findInfoItem("",items[i]);
                    out.println("<td class=td_form01>"+ib.getItemName()+"</td>");
                    out.println("<td class=td_form02>");
                    if (InfoItemBO.DATA_TYPE_CODE.equals(ib.getItemDataType())){
                       out.println("<input id='"+ib.getItemId()+"' name='"+ib.getItemId()+"' type='text' value=''  code='' dict='yes' dict_num='"+ib.getItemCodeSet()+"' class='input' >");
                       out.println("<input id='btn"+ib.getItemId()+"' name='btn"+ib.getItemId()+"' type='button' onclick=\"PopUpCodeDlgOneControl('"+ib.getItemId()+"');\" class='button_select' >");
                    }
                    else{
                        out.println("<input id='"+ib.getItemId()+"' name='"+ib.getItemId()+"' type='text' value=''  class='input' >");
                    }
                    out.println("</td>");
                }
                out.println("</tr>");
            }
            out.println("</table>");
        }
    %>
</f:verbatim>

<f:verbatim>
<br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
            <font color=red><strong>注意：所在机构必须选择最底层的部门或班组&nbsp;&nbsp;</strong></font>
</f:verbatim>
            <h:commandButton value="下一步" onclick="javascript:return forSave()" styleClass="button01"
                             action="#{emp_personAddBB.createPerson}"/>&nbsp;&nbsp;
            <h:commandButton value="取消" styleClass="button01"
                             action="#{emp_personAddBB.cancelPerson}"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
    document.all('form1:selectType').onclick=selectTypeFun;
    document.all.seryFilterDiv.style.left = document.body.scrollWidth - 120;
    var bIsCatchSery = false;
    var dragClickX = 0;
    var dragClickY = 0;
    function myload_setFilter() {
        seryFilterDiv.style.top = document.body.scrollTop + 100;
        seryFilterDiv.style.left = document.body.scrollLeft + 100;
    }
    function catchFilter(e) {
        bIsCatchSery = true;
        var x = event.x + document.body.scrollLeft;
        var y = event.y + document.body.scrollTop;
        dragClickX = x - seryFilterDiv.style.pixelLeft;
        dragClickY = y - seryFilterDiv.style.pixelTop;
        seryFilterDiv.setCapture();
        document.onmousemove = moveFilter;
    }
    function releaseFilter(e) {
        bIsCatchSery = false;
        seryFilterDiv.releaseCapture();
        document.onmousemove = null;
    }
    function moveFilter(e) {
        if (bIsCatchSery) {
            seryFilterDiv.style.left = event.x + document.body.scrollLeft - dragClickX;
            seryFilterDiv.style.top = event.y + document.body.scrollTop - dragClickY;
        }
    }
<%--     <% --%>
//        InfoItemBO A001716Item=SysCacheTool.findInfoItem("","A001716");
//        if (A001716Item!=null && "1".equals(A001716Item.getItemNotNull())){
//           out.println("document.all('form1:A001716').alt='岗位级别|0|s|50||';");
//           out.println("document.all('td_postLevel').className='td_form01 td_form_required';");
//        }
<%--     %> --%>
    
</script>
