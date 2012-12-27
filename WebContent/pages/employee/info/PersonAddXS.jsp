<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

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

</script>

<h:form id="form1">
<h:inputHidden  id="type" value="#{emp_personAddBB.type}"></h:inputHidden>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">
          <%=LanguageSupport.getResource("RYGL-2362", " 其他管理 ")%>-> 
          <%=LanguageSupport.getResource("RYGL-2363", "增加其他  ")%>      
       </td>
        <td class="td_title" align="right">
            <%
                if ("1".equals(Constants.AUTO_CACL_BIRTH)) out.println(LanguageSupport.getResource("RYGL-2328", "根据身份证计算性别/出生日期:开启"));
                else  out.println(LanguageSupport.getResource("RYGL-2329", "根据身份证计算性别/出生日期:关闭"));
            %>
        </td>
    </tr>
</table>
<br>

<table width=840 align=center border=0 cellpadding=0 cellspacing=0>
        <tr nowrap>
            <td class="f05"><%= LanguageSupport.getResource("RYGL-2325", " 基本信息")%>  </td>
        </tr>
</table>
<br>

<table  width=840 align=center border=0 cellpadding=0 cellspacing=0 class="table03">
    <tr nowrap>
    <td class="td_form01 td_form_required"><%= LanguageSupport.getResource("RYGL-2364", " 班级")%>  </td>
    <td class=td_form02 >
</f:verbatim>
        <h:inputText styleClass="input" id="A001706" code="" dict="yes" dict_num="OU"
                     readonly="true" value="#{emp_personAddBB.classId}"
                     alt="班级|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpOrgDlgShowGroup('form1:A001706',2)">
       </td>

        <td class="td_form01 " width="80">
            <%= LanguageSupport.getResource("RYGL-2122", " 人员编号")%>  
        </td>
        <td class="td_form02" >
</f:verbatim>
            <h:inputText styleClass="input" id="A001735" value="#{emp_personAddBB.personvo.personCode}" alt="人员编号|1|s|50||"/>
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
    <td class="td_form01 td_form_required" width="80"><%= LanguageSupport.getResource("RYGL-1016", "姓名")%></td>
    <td class="td_form02" width="180">
</f:verbatim>
        <h:inputText styleClass="input" id="A001001" value="#{emp_personAddBB.personvo.name}" alt="姓名|0|s|50||"/>
<f:verbatim>
    </td>

    </tr>

 <tr nowrap>
    <td class=td_form01 width="80"><%= LanguageSupport.getResource("RYGL-2054", "政治面貌")%></td>
    <td class=td_form02 width="180">
</f:verbatim>
        <h:inputText styleClass="input" id="A001009" code="" dict="yes" dict_num="0120"
                     readonly="true" value="#{emp_personAddBB.personvo.partyFigure}"
                     alt="政治面貌|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001009')">
     </td>


    <td class=td_form01 width="80"><%= LanguageSupport.getResource("RYGL-1015", "身份证号")%></td>
    <td class=td_form02 width="180">
</f:verbatim>
        <h:inputText styleClass="input" id="A001077"  size="22"
                     value="#{emp_personAddBB.personvo.idNum}"
                     alt="身份证号|1|s|50||"/>
<f:verbatim>
    </td>

    <td class=td_form01 rowspan=2 width="80"><%= LanguageSupport.getResource("RYGL-2348", "人员照片")%></td>
    <td class=td_form02 rowspan=2 width="180">
        <iframe name=uploadPhoto frameBorder=0 width=180 height=98% scrolling=no
                src='/common/UploadPhoto.jsf?imageItemId=A001780'></iframe>
        <div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;left:800px;top:55px;display:none;" onMouseDown="catchFilter()" onMouseUp="releaseFilter()">
            <img id=showZP src="" width=110 height=140 alt="照片">
        </div>
    </td>
</tr>

 <tr nowrap>
    <td class="td_form01 "><%=LanguageSupport.getResource("MSG-0013", "出生日期")%> </td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001011" value="#{emp_personAddBB.personvo.birth}"
                     readonly="true" alt="出生日期|1|d|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
    </td>

    <td width="80" class="td_form01 "><%=LanguageSupport.getResource("MSG-0012", "性别")%></td>
    <td class=td_form02 width="180">
</f:verbatim>
        <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                     readonly="true" value="#{emp_personAddBB.personvo.sex}"
                     alt="性别|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')">
    </td>
</tr>

<tr nowrap>
    <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("XTGL-1061", "人员类别")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{emp_personAddBB.personvo.personType}"
                     alt="人员类别|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')">
    </td>

    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2057", "民族")%></td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001021" code="" dict="yes" dict_num="0115"
                     readonly="true" value="#{emp_personAddBB.personvo.folk}"
                     alt="民族|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001021')">
    </td>

    <td class=td_form01><%=LanguageSupport.getResource("RYGL-2349", "户籍地")%></td>
    <td class=td_form02>
</f:verbatim>
     <h:inputText styleClass="input" id="A090701" code="" dict="yes" dict_num="0105"
             readonly="true" value="#{emp_personAddBB.personvo.residence}"
             alt="户口所在地|1|s|50||"/>

<f:verbatim>
     <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A090701')">
    </td>
</tr>
</table>

    <br>
    <table width=840 align=center border=0 cellpadding=0 cellspacing=0>
            <tr nowrap>
                <td class="f05"><%=LanguageSupport.getResource("RYGL-2361", "联系方式")%></td>
            </tr>
    </table>
    <br>

<table  width=840 align=center border=0 cellpadding=0 cellspacing=0 class="table03">
    <tr>
        <td class="td_form01" width="80">eMail</td>
        <td class=td_form02 width="180">
    </f:verbatim>
            <h:inputText value="#{emp_personAddBB.personvo.workCompany}"/>
    <f:verbatim>
        </td>
        <td class="td_form01" width="80"><%=LanguageSupport.getResource("RYGL-2356", "家庭联系电话")%></td>
        <td class=td_form02 width="180">
    </f:verbatim>
            <h:inputText value="#{emp_personAddBB.personvo.homeTel}"/>
    <f:verbatim>
        </td>
        <td class="td_form01" width="80"><%=LanguageSupport.getResource("RYGL-2355", "移动电话")%></td>
        <td class=td_form02 width="180">
    </f:verbatim>
            <h:inputText value="#{emp_personAddBB.personvo.mobile}"/>
    <f:verbatim>
        </td>
    </tr>

</table>


<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
</f:verbatim>
            <h:commandButton value=" 下一步 " onclick="javascript:return forSave()" styleClass="button01"
                             action="#{emp_personAddBB.createPersonXS}"/>&nbsp;&nbsp;
            <h:commandButton value=" 取消 " styleClass="button01"
                             action="#{emp_personAddBB.cancelPerson}"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
    if (document.all('form1:A001054').value==""){
        document.all('form1:A001054').value="013510";
    }
    interpret(document.forms(0));
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
