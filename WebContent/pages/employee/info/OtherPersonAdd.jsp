<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    // 员工类别
    String A001054=request.getParameter("A001054");
    // 员工身份
    String A001031=request.getParameter("A001031");
    // 增员类别
    String A016010=request.getParameter("A016010");
%>

<script type="text/javascript">
function forCheck() {
    return true;
    var party = document.all("form1:A001009").code;
    //政治面貌
    var ccp = document.all("form1:A001708").code;
    //所属党组织
    var birth = document.all("form1:A001011").value;
    //出生日期
    var status = document.all("form1:A001725").code;
    //当前状态
    var homeTown = document.all("form1:A001014").value;
    //籍贯
    var postType = document.all("form1:A001712").code;
    //岗位类别
    var birthTowm = document.all("form1:A001017").value;
    //出生地
    var folk = document.all("form1:A001021").value;
    //民族
    var idCard = document.all("form1:A001077").value;
    //身份证号
    var residence = document.all("form1:A001071").value;
    //户口所在地
    var personType = document.all("form1:A001054").code;
    //员工类别
    var partyTime = document.all("form1:A001718").value;
    //参加党派时间
    var workTime = document.all("form1:A001041").value;
    //参加工作时间
    var sysTime = document.all("form1:A001044").value;
    //进入系统时间
    var unitTime = document.all("form1:A001781").value;
    var addTime = document.all("form1:A016020").value;
    //增员时间

    var dt = new Date();

    if (idCard.trim() != "") {
        if (!(idCard.trim().length == 15 || idCard.trim().length == 18)) {
            alert("身份证号应为15位或者18位!");
            return false;
        }
    }

    if (idCard.trim() != "") {
        var tmpCard ;
        if (idCard.length == 15) {
            tmpCard = "19" + idCard.substring(6, 12);
        }
        if (idCard.length == 18) {
            tmpCard = idCard.substring(6, 14);
        }
        var tmpBirth = birth.replace(/\-/g, "");
        if (tmpCard != tmpBirth) {
            alert("身份证号和出生日期不匹配!");
        }
    }
    return true;
}

function forSave() {
    if (forCheck()) {
        return forsubmit(document.forms(0));
    }
    return false;
}

function selSysTime() {
    PopUpCalendarDlg_OnlyMonth("form1:A001044");
    document.all("form1:A016020").value = document.all("form1:A001044").value;
}

</script>

<x:saveState value="#{emp_personAddBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden   value="#{emp_personAddBB.pageInit}"></h:inputHidden>
<c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif"> 人员管理 -> 增加表外人员 </td>
        <td class="td_title" align="right">
            <%
                if ("1".equals(Constants.AUTO_CACL_BIRTH)) out.println("根据身份证计算性别/出生日期:开启");
                else out.println("根据身份证计算性别/出生日期:关闭");
            %>
            &nbsp;&nbsp;
            <%
                if ("1".equals(Constants.EMP_ADD_AFTER_APPROVE)) out.println("<font color=red>注意：新增人员需审批后才生效</font>");
            %>
        </td>
    </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%><%=LanguageSupport.getResource("RYGL-2325", "基本信息")%> </td>
        <td class="td_form01 " width="120">
            <%=LanguageSupport.getResource("XTGL-1042", "员工编号")%>
        </td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText styleClass="input" id="A001735" value="#{emp_personAddBB.personvo.personCode}" alt="员工编号|1|s|50||"/>
<c:verbatim>
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
    <td class="td_form01 td_form_required" width="120">  <%=LanguageSupport.getResource("MSG-0010", "姓名")%></td>
    <td class="td_form02">
</c:verbatim>
        <h:inputText styleClass="input" id="A001001" value="#{emp_personAddBB.personvo.name}" alt="姓名|0|s|50||"/>
<c:verbatim>
    </td>
    <td width="15%" class="td_form01 ">  <%=LanguageSupport.getResource("MSG-0012", "性别")%></td>
    <td class=td_form02 width="30%">
</c:verbatim>
        <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                     readonly="true" value="#{emp_personAddBB.personvo.sex}"
                     alt="性别|1|s|50||"/>
<c:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')">
    </td>
</tr>

   <tr nowrap>
        <td class=td_form01>  <%=LanguageSupport.getResource("RYGL-1015", "身份证号")%></td>
        <td class=td_form02>
</c:verbatim>
            <h:inputText styleClass="input" id="A001077"  size="22"
                         value="#{emp_personAddBB.personvo.idNum}"
                         alt="身份证号|1|s|50||"/>
<c:verbatim>
        </td>
       <td class="td_form01 td_form_required">  <%=LanguageSupport.getResource("RYGL-2063", "所在部门")%></td>
       <td class=td_form02>
</c:verbatim>
         <h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
                      readonly="true" value="#{emp_personAddBB.personvo.deptId}"
                      alt="所在部门|0|s|50||"/>
<c:verbatim>
         <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A001705',2)">
        </td>
    </tr>

<tr nowrap>
    <td class="td_form01 ">  <%=LanguageSupport.getResource("MSG-0013", "出生日期")%></td>
    <td class=td_form02>
</c:verbatim>
        <h:inputText styleClass="input" id="A001011" value="#{emp_personAddBB.personvo.birth}"
                     readonly="true" alt="出生日期|1|d|50||"/>
<c:verbatim>
        <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
    </td>
    <td class=td_form01>  <%=LanguageSupport.getResource("RYGL-2057", "民族")%></td>
    <td class=td_form02>
</c:verbatim>
        <h:inputText styleClass="input" id="A001021" code="" dict="yes" dict_num="0115"
                     readonly="true" value="#{emp_personAddBB.personvo.folk}"
                     alt="民族|1|s|50||"/>
<c:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001021')">
    </td>
</tr>

<tr nowrap>
    <td class="td_form01 td_form_required">  <%=LanguageSupport.getResource("XTGL-1044", "员工类别")%></td>
    <td class=td_form02>
</c:verbatim>
        <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{emp_personAddBB.personvo.personType}"
                     alt="员工类别|0|s|50||"/>
<c:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054','<%=A001054%>')">
    </td>
    <td class=td_form01>  <%=LanguageSupport.getResource("RYGL-2326", "户口所在地")%></td>
    <td class=td_form02>
</c:verbatim>
        <h:inputText styleClass="input" id="A001071"
                     value="#{emp_personAddBB.personvo.residence}"
                     alt="户口所在地|1|s|50||"/>
<c:verbatim>
    </td>
</tr>

<tr nowrap>
        <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("XTGL-1047", "增员类别")%></td>
        <td class=td_form02>
</c:verbatim>
            <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                         readonly="true" value="#{emp_personAddBB.personchangevo.changeType}"
                         alt="增员类别|0|s|50||"/>
<c:verbatim>
        </td>
        <td class="td_form01 td_form_required" width="120">  <%=LanguageSupport.getResource("RYGL-2282", "增员时间")%></td>
        <td class=td_form02>
</c:verbatim>
            <h:inputText styleClass="input" id="A016020" value="#{emp_personAddBB.personchangevo.changeDate}"
                         readonly="true" alt="增员时间|0|d6|50||"/>
<c:verbatim>
            <input type="button" class="button_select" onclick="
            <%
                InfoItemBO ib=SysCacheTool.findInfoItem("","A016020");
                if (InfoItemBO.DATA_TYPE_DATE6.equals(ib.getItemDataType())){
                    out.println("PopUpCalendarDlg_OnlyMonth('form1:A016020');");
                }
                else{
                    out.println("PopUpCalendarDialog('form1:A016020');");
                }
            %> ">
            <script type="text/javascript">
            <%
                if (InfoItemBO.DATA_TYPE_DATE.equals(ib.getItemDataType())){
                    out.println("document.all('form1:A016020').alt='增员时间|0|d|50||';");
                }
            %>

            </script>
        </td>
</tr>
</table>

<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
</c:verbatim>
            <h:commandButton value=" 增加 " onclick="javascript:return forSave()" styleClass="button01"
                             action="#{emp_personAddBB.createPerson}"/>&nbsp;&nbsp;
            <h:commandButton value=" 取消 " styleClass="button01"
                             action="#{emp_personAddBB.cancelPerson}"></h:commandButton>
<c:verbatim>
        </td>
    </tr>
</table>
</c:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
