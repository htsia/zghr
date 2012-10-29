<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>

<script type="text/javascript">
    <%
        User user = (User)session.getAttribute(Constants.USER_INFO);
    %>
    function selectPerson(){
         return  fPopUpBackPerTreeDlg('<%=user.getOrgId()%>');
    }

</script>
    <x:saveState value="#{attMImicReportRecQryBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{attMImicReportRecQryBB.initEdit}"/>
        <h:inputHidden id="postId" value=""></h:inputHidden>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr>
            <td class=td_form01>人员姓名</td>
            <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{attMImicReportRecQryBB.personNames}" rows="3" cols="50" rendered="#{attMImicReportRecQryBB.operType=='add'}"></h:inputTextarea>
			   <h:inputHidden value="#{attMImicReportRecQryBB.personIds}" rendered="#{attMImicReportRecQryBB.operType=='add'}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="选择" onclick="return selectPerson()" action="#{attMImicReportRecQryBB.selPerson}" rendered="#{attMImicReportRecQryBB.operType=='add'}"/>
               <h:inputText readonly="true" value="#{attMImicReportRecQryBB.personName}" rendered="#{attMImicReportRecQryBB.operType=='edit'}"></h:inputText>
               <h:inputHidden  value="#{attMImicReportRecQryBB.personId}" rendered="#{attMImicReportRecQryBB.operType=='edit'}"></h:inputHidden>
<c:verbatim>
               </td>
            </tr>

            <tr nowrap>
                <td class=td_form01>年度</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                 <h:inputText value="#{attMImicReportRecQryBB.mrYear}" readonly="true"></h:inputText>
<c:verbatim>
                </td>
            </tr>

    <tr nowrap>
        <td class=td_form01>休假时间</td>
        <td class=td_form02 colspan="3">
</c:verbatim>
           <h:inputText styleClass="input" id="mrMonth" value="#{attMImicReportRecQryBB.mrMonth}"
                     readonly="true" alt="日期|1|d|50||"/>
<c:verbatim>
            <input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:mrMonth')">
        </td>
    </tr>

    <tr nowrap>
        <td class=td_form01>目的地</td>
        <td class=td_form02 colspan="3">
</c:verbatim>
            <h:inputText value="#{attMImicReportRecQryBB.dest}"></h:inputText>
<c:verbatim>
        </td>
    </tr>

    <tr nowrap>
        <td class=td_form01>休假天数(天)</td>
        <td class=td_form02 colspan="3">
</c:verbatim>
            <h:inputText value="#{attMImicReportRecQryBB.lastDate}"></h:inputText>
<c:verbatim>
        </td>
    </tr>
        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存"  action="#{attMImicReportRecQryBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>