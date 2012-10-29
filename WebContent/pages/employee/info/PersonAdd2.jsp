<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
var info = "";
function selectTypeFun(){
   PopUpCodeDlgOneControl('form1:A016010','0200300005,0200300006');
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
            <%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID, OperateBO.CHANGEMODULEID)%> ->
            <%=CodeUtil.interpertCode(CodeUtil.TYPE_OPERATER,"0341")%>
        </td>
        <td class="td_title" align="right">
            <%
                if ("1".equals(Constants.AUTO_CACL_BIRTH)) out.println(LanguageSupport.getResource("RYGL-2328", "根据身份证计算性别/出生日期:开启"));
                else  out.println(LanguageSupport.getResource("RYGL-2329", "根据身份证计算性别/出生日期:关闭"));
            %>
            &nbsp;&nbsp;
            <font color=red>
            <%
                if ("1".equals(Constants.EMP_ADD_AFTER_APPROVE)) out.println(LanguageSupport.getResource("RYGL-2329", "注意：新增人员需审批后才生效"));
            %>
              </font>
        </td>
    </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%><%= LanguageSupport.getResource("RYGL-2325", " 基本信息")%> </td>
        <td class="td_form01 " width="120">
           <%= LanguageSupport.getResource("XTGL-1042", "员工编号")%>     
        </td>
        <td class="td_form02">
</f:verbatim>
            <h:inputText styleClass="input" id="A001735" value="#{emp_personAddBB.personvo.personCode}" alt="员工编号|1|s|50||"/>
<f:verbatim>
        </td>
        <%
            try{
                IPersonUCC uu = (IPersonUCC) SysContext.getBean("emp_personUCC");
                User user = (User) session.getAttribute(Constants.USER_INFO);
                out.print("<script type=\"text/javascript\">");
                out.print("     document.all('form1:A001735').value=\""+uu.getNextPersonCode(user.getOrgId())+"\"");
                out.print("</script>");
            }
            catch(Exception e){

            }
        %>
    </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01 td_form_required" width="120"> <%= LanguageSupport.getResource("MSG-0010", " 姓名")%> </td>
    <td class="td_form02">
</f:verbatim>
        <h:inputText styleClass="input" id="A001001" value="#{emp_personAddBB.personvo.name}" alt="姓名|0|s|50||"/>
<f:verbatim>
    </td>
    <td class=td_form01 rowspan=2 width="120"> <%= LanguageSupport.getResource("RYGL-2330", " 员工照片")%> </td>
    <td class=td_form02 rowspan=2 >
        <iframe name=uploadPhoto frameBorder=0 width=280 height=98% scrolling=no
                src='/common/UploadPhoto.jsf?imageItemId=A001780'></iframe>
        <div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;left:800px;top:55px;display:none;" onMouseDown="catchFilter()" onMouseUp="releaseFilter()">
            <img id=showZP src="" width=110 height=140 alt="照片">
        </div>
    </td>

</tr>
<tr nowrap>
    <td width="15%" class="td_form01 "><%= LanguageSupport.getResource("MSG-0012", "性别")%></td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                     readonly="true" value="#{emp_personAddBB.personvo.sex}"
                     alt="性别|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')">
    </td>

</tr>
<tr nowrap>
    <td class="td_form01 "><%=LanguageSupport.getResource("MSG-0013", "出生日期")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001011" value="#{emp_personAddBB.personvo.birth}"
                     readonly="true" alt="出生日期|1|d|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
    </td>

    <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2063", "所在部门")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
                     readonly="true" value="#{emp_personAddBB.personvo.deptId}"
                     alt="所在部门|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A001705',2)">
       </td>
</tr>
<tr nowrap>
    <td class=td_form01><%=LanguageSupport.getResource("XTGL-1060", "岗位类别")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001712" code="" dict="yes" dict_num="0110"
                     readonly="true" value="#{emp_personAddBB.personvo.postType}"
                     alt="岗位类别|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001712')"></td>
</tr>
<tr nowrap>
    <td class=td_form01><%=LanguageSupport.getResource("JGGL-1078", "岗位名称")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001715" code="" dict="yes" dict_num="PO"
                     readonly="true" value="#{emp_personAddBB.personvo.postId}"
                     alt="岗位|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="fPopUpPostDlg('form1:A001715')"></td>
    <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("XTGL-1044", "员工类别")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{emp_personAddBB.personvo.personType}"
                     alt="员工类别|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')">
    </td>

</tr>
<tr nowrap>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2053", "籍贯")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001014" code="" dict="yes" dict_num="0105"
                     readonly="true" value="#{emp_personAddBB.personvo.homeTown}"
                     alt="籍贯|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001014')">
    </td>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2056", "出生地")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001017" code="" dict="yes" dict_num="0105"
                     readonly="true" value="#{emp_personAddBB.personvo.homePlace}"
                     alt="出生地|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001017')"></td>

</tr>
<tr nowrap>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2057", "民族")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001021" code="" dict="yes" dict_num="0115"
                     readonly="true" value="#{emp_personAddBB.personvo.folk}"
                     alt="民族|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001021')">
    </td>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2054", "政治面貌")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001009" code="" dict="yes" dict_num="0120"
                     readonly="true" value="#{emp_personAddBB.personvo.partyFigure}"
                     alt="政治面貌|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001009')"></td>

</tr>
<tr nowrap>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2055", "参加党派时间")%></td>
    <td class=td_form02>
</f:verbatim>
       <h:inputText styleClass="input" id="A001718" value="#{emp_personAddBB.personvo.partyTime}"
             readonly="true" alt="参加党派时间|1|d6|50||"/>
<f:verbatim>
    <script type="text/javascript">
    document.all('form1:A001718').alt = "<%=partTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(partTime.getItemDataType())%>|50||";
    </script>
    <input type="button" class="button_select" onclick="selPartTime();"></td>
    <td class="td_form01 "><%=LanguageSupport.getResource("RYGL-2340", "婚姻状况")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001027" code="" dict="yes" dict_num="0130"
                     value="#{emp_personAddBB.personvo.marryStatus}" readonly="true"
                     alt="婚姻状况|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001027')"></td>

</tr>
<tr nowrap>
    <td class="td_form01" td_form_required><%=workTime.getItemName()%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001041" value="#{emp_personAddBB.personvo.workTime}"
                     readonly="true" alt="参加工作时间|1|d6|50||"/>
<f:verbatim>
    <script type="text/javascript">
        document.all('form1:A001041').alt = "<%=workTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(workTime.getItemDataType())%>|50||";
    </script>

     <input type="button" class="button_select" onclick="selWorkTime();"></td>

    <td class="td_form01 td_form_required"><%=unitTime.getItemName()%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001044" value="#{emp_personAddBB.personvo.unitTime}"
                     readonly="true" alt="来公司时间|1|d6|50||"/>
<f:verbatim>
        <script type="text/javascript">
            document.all('form1:A001044').alt = "<%=unitTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(unitTime.getItemDataType())%>|50||";
        </script>
        <input type="button" class="button_select" onclick="selUnitTime();"></td>
</tr>
<tr nowrap>
    <td class="td_form01 "><%=sysTime.getItemName()%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001781" value="#{emp_personAddBB.personvo.sysTime}"
                     readonly="true" alt="进入本系统时间|1|d6|50||"/>
<f:verbatim>
    <script type="text/javascript">
        document.all('form1:A001781').alt = "<%=sysTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(sysTime.getItemDataType())%>|50||";
    </script>

    <input type="button" class="button_select" onclick="selSysTime();"></td>

    <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2331", "员工身份")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001031" code="" dict="yes" dict_num="0140"
                     readonly="true" value="#{emp_personAddBB.personvo.personIdentity}"
                     alt="员工身份|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001031')">
    </td>
</tr>
<tr>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-1015", "身份证号")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001077"  size="22"
                     value="#{emp_personAddBB.personvo.idNum}"
                     alt="身份证号|1|s|50||"/>
<f:verbatim>
    </td>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2334", "工作证号")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001782"
                     value="#{emp_personAddBB.personvo.workCard}"
                     alt="工作证号|1|s|50||"/>
<f:verbatim>
    </td>
</tr>
<tr>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2335", "国籍")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001783"
                     value="#{emp_personAddBB.personvo.nation}"
                     alt="国籍|1|s|50||"/>
<f:verbatim>
    </td>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2058", "健康状况")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001024" value="#{emp_personAddBB.personvo.health}"
                     alt="健康状况|1|s|50||"/></td>
<f:verbatim>
</tr>
<tr>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2326", "户口所在地")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001071"
                     value="#{emp_personAddBB.personvo.residence}"
                     alt="户口所在地|1|s|50||"/>
<f:verbatim>
    </td>
    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2336", "专长")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001783" value="#{emp_personAddBB.personvo.speciality}"
                     alt="专长|1|s|50||"/></td>
<f:verbatim>
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
        <td class="f04"><%=LanguageSupport.getResource("RYGL-2332", "增员情况")%></td>
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
        <h:commandButton type="button" styleClass="button_select" onclick="selAddTime();"/>
<f:verbatim>
<script type="text/javascript">
    document.all('form1:A016020').alt = "<%=addTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(addTime.getItemDataType())%>|50||";
</script>
        </td>
    </tr>

    <tr>
    <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2345", "复转类别")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A076701" code="" dict="yes" dict_num="0249"
                     readonly="true"  value="#{emp_personAddBB.returnType}"
                     alt="复转类别|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select"
               onclick="PopUpCodeDlgOneControl('form1:A076701')" >
    </td>
    <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2344", "批准复转时间")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="A076710" value="#{emp_personAddBB.returnTime}"
                         readonly="true" alt="批准复转时间|0|d6|50||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:A076710')">
        </td>
    </tr>
    <tr>
       <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2343", "批准复转单位")%></td>
       <td class=td_form02>
</f:verbatim>
           <h:inputText styleClass="input" id="A076715"  value="#{emp_personAddBB.returnDep}"
                        alt="批准复转单位|0|s|50||"/>
<f:verbatim>
       </td>
           <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2342", "复转前在军队职务")%></td>
           <td class=td_form02>
</f:verbatim>
              <h:inputText styleClass="input" id="A076720"  value="#{emp_personAddBB.returnDuty}"
                        alt="复转前在军队职务|0|s|50||"/>
<f:verbatim>
           </td>
       </tr>
    </table>
<br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
</f:verbatim>
            <h:commandButton value=" 增加 " onclick="javascript:return forSave()" styleClass="button01"
                             action="#{emp_personAddBB.createPerson}"/>&nbsp;&nbsp;
            <h:commandButton value=" 取消 " styleClass="button01"
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
</script>
