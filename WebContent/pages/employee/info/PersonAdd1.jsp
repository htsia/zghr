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
function doScan(){
    var ret=window.showModalDialog("/pages/common/ScanIDCard.jsp", null, "dialogWidth:100px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
    if (ret!=""){
       var s=ret.split(",");
       document.all("form1:A001001").value=s[0].trim();
       document.all("form1:A001007").value=s[1].trim();
       if (s[1].trim()=="男"){
            document.all("form1:A001007").code="01001";
       }
       else{
            document.all("form1:A001007").code="01002";
       }

       document.all("form1:A001021").value=s[2].trim();
       switch(s[2].trim()){
           case "汉族":document.all("form1:A001021").code="011501"; break;
           case "蒙古族":document.all("form1:A001021").code="011502"; break;
           case "回族":document.all("form1:A001021").code="011503"; break;
           case "藏族":document.all("form1:A001021").code="011504"; break;
           case "维吾尔族":document.all("form1:A001021").code="011505"; break;
           case "苗族":document.all("form1:A001021").code="011506"; break;
           case "彝族":document.all("form1:A001021").code="011507"; break;
           case "壮族":document.all("form1:A001021").code="011508"; break;
           case "布依族":document.all("form1:A001021").code="011509"; break;
           case "朝鲜族":document.all("form1:A001021").code="011510"; break;
           case "满族":document.all("form1:A001021").code="011511"; break;
           case "侗族":document.all("form1:A001021").code="011512"; break;
           case "瑶族":document.all("form1:A001021").code="011513"; break;
           case "白族":document.all("form1:A001021").code="011514"; break;
           case "土家族":document.all("form1:A001021").code="011515"; break;
           case "哈尼族":document.all("form1:A001021").code="011516"; break;
           case "哈萨克族":document.all("form1:A001021").code="011517"; break;
           case "傣族":document.all("form1:A001021").code="011518"; break;
           case "黎族":document.all("form1:A001021").code="011519"; break;
           case "傈僳族":document.all("form1:A001021").code="011520"; break;
           case "佤族":document.all("form1:A001021").code="011521"; break;
           case "畲族":document.all("form1:A001021").code="011522"; break;
           case "高山族":document.all("form1:A001021").code="011523"; break;
           case "拉祜族":document.all("form1:A001021").code="011524"; break;
           case "水族":document.all("form1:A001021").code="011525"; break;
           case "东乡族":document.all("form1:A001021").code="011526"; break;
           case "纳西族":document.all("form1:A001021").code="011527"; break;
           case "景颇族":document.all("form1:A001021").code="011528"; break;
           case "柯尔克孜族":document.all("form1:A001021").code="011529"; break;
           case "土族":document.all("form1:A001021").code="011530"; break;
           case "达斡尔族":document.all("form1:A001021").code="011531"; break;
           case "仫佬族":document.all("form1:A001021").code="011532"; break;
           case "羌族":document.all("form1:A001021").code="011533"; break;
           case "布朗族":document.all("form1:A001021").code="011534"; break;
           case "撒拉族":document.all("form1:A001021").code="011535"; break;
           case "毛难族":document.all("form1:A001021").code="011536"; break;
           case "仡佬族":document.all("form1:A001021").code="011537"; break;
           case "锡伯族":document.all("form1:A001021").code="011538"; break;
           case "阿昌族":document.all("form1:A001021").code="011539"; break;
           case "普米族":document.all("form1:A001021").code="011540"; break;
           case "塔吉克族":document.all("form1:A001021").code="011541"; break;
           case "怒族":document.all("form1:A001021").code="011542"; break;
           case "乌孜别克族":document.all("form1:A001021").code="011543"; break;
           case "俄罗斯族":document.all("form1:A001021").code="011544"; break;
           case "鄂温克族":document.all("form1:A001021").code="011545"; break;
           case "德昂族":document.all("form1:A001021").code="011546"; break;
           case "保安族":document.all("form1:A001021").code="011547"; break;
           case "裕固族":document.all("form1:A001021").code="011548"; break;
           case "京族":document.all("form1:A001021").code="011549"; break;
           case "塔塔尔族":document.all("form1:A001021").code="011550"; break;
           case "独龙族":document.all("form1:A001021").code="011551"; break;
           case "鄂伦春族":document.all("form1:A001021").code="011552"; break;
           case "赫哲族":document.all("form1:A001021").code="011553"; break;
           case "门巴族":document.all("form1:A001021").code="011554"; break;
           case "珞巴族":document.all("form1:A001021").code="011555"; break;
           case "基诺族":document.all("form1:A001021").code="011556"; break;
       }
       var temp=s[3].trim();
       document.all("form1:A001011").value=temp.substring(0,4)+"-"+temp.substring(4,6)+"-"+temp.substring(6,8);
       document.all("form1:A001077").value=s[4].trim();
    }
}
function selectTypeFun(){
   PopUpCodeDlgOneControl('form1:A016010','0200210000,0200220000,0200220000,0200230001,0200300002,0200300003');
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
            <%=CodeUtil.interpertCode(CodeUtil.TYPE_OPERATER,"0340")%> 
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
</f:verbatim>
            <h:commandButton value="扫描二代证" type="button" styleClass="button01" onclick="doScan();"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%> <%= LanguageSupport.getResource("RYGL-2325", " 基本信息")%>     </td>
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
    <td class=td_form01 rowspan=2 width="120"><%= LanguageSupport.getResource("RYGL-2330", " 员工照片")%> </td>
    <td class=td_form02 rowspan=2 >
        <iframe name=uploadPhoto frameBorder=0 width=280 height=98% scrolling=no
                src='/common/UploadPhoto.jsf?imageItemId=A001780'></iframe>
        <div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;left:800px;top:55px;display:none;" onMouseDown="catchFilter()" onMouseUp="releaseFilter()">
            <img id=showZP src="" width=110 height=140 alt="照片">
        </div>
    </td>

</tr>
<tr nowrap>
    <td width="15%" class="td_form01 "><%=LanguageSupport.getResource("MSG-0012", "性别")%></td>
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
    <td class=td_form01>来源</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001800"  code="" dict="yes" dict_num="2241"
                     value="#{emp_personAddBB.personvo.source}"
                     alt="来源|1|s|50||"/>
<f:verbatim>
       <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001800')">
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
    <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2239", "学历")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A004005" code="" dict="yes" dict_num="0365"
                     readonly="true"  value="#{emp_personAddBB.education}"
                     alt="学历|0|s|50||"/>
        <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:A004005')"/>
<f:verbatim>
    </td>
        <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2234", "毕业时间")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="A004030" value="#{emp_personAddBB.graduate}"
                         readonly="true" alt="毕业时间|0|d6|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:A004030')"/>
<f:verbatim>
        </td>
    </tr>
    <tr>
    <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2233", "毕业学校")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A004035"  value="#{emp_personAddBB.college}"           alt="毕业学校|0|s|50||"/>
<f:verbatim>
    </td>
        <td class="td_form01" width="120"><%=LanguageSupport.getResource("RYGL-2337", "学制")%></td>
        <td class=td_form02>
</f:verbatim>
           <h:inputText styleClass="input" id="A004025" value="#{emp_personAddBB.year}"          alt="学制|1|s|50||"/>
<f:verbatim>
        </td>
    </tr>

    <tr>
    <td class="td_form01" width="120"><%=LanguageSupport.getResource("RYGL-2338", "学位")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A840701" code="" dict="yes" dict_num="0380"
                     readonly="true"  value="#{emp_personAddBB.degree}"
                     alt="学位|1|s|50||"/>
        <h:commandButton type="button" styleClass="button_select"     onclick="PopUpCodeDlgOneControl('form1:A840701')"/>
<f:verbatim>
    </td>
        <td class="td_form01" width="120"><%=LanguageSupport.getResource("RYGL-2339", "学位授予时间")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="A840705" value="#{emp_personAddBB.degreeTime}"
                         readonly="true" alt="学位授予时间|1|d6|50||"/>
            <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCalendarDlg_OnlyMonth('form1:A840705')"/>
<f:verbatim>
        </td>
    </tr>
    </table>

<br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
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
</script>

