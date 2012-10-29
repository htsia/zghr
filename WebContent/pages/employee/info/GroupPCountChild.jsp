<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function ModiData(){
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++){
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value ;  // 取第一个
                            break;
                        }
                     }
                } else
                    str = form1.chk.value;
                window.showModalDialog("/employee/info/ModiCountDetail.jsf?SUBID="+str, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
                return true;
            } else {
                alert("请选择月份！");
                return false;
            }
        }
        function ModiRule() {
            window.showModalDialog("/employee/info/modiRule.jsf", null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doDetailPopup(){
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++){
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value ;  // 取第一个
                            break;
                        }
                     }
                } else
                    str = form1.chk.value;
                window.showModalDialog("/employee/info/PersonCountDetail.jsf?subid="+str, null, "dialogWidth:"+0.8*screen.width+"px; dialogHeight:"+0.8*screen.height+"px;center:center;resizable:yes;status:no;scroll:yes;");
            } else {
                alert("请选择数据！");
            }
            return false;
        }
        function doCalc(){
            if (document.all('form1:curMonth')=='') {
                alert("请选择月份！");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{emp_PersonCountBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{emp_PersonCountBB.groupInit}"/>
    <h:inputHidden id="subid" value="#{emp_PersonCountBB.superId}"/>
    <f:verbatim>
    <table  height="98%" width="98%" align="center">
        <tr>
        <td align="left">
    </f:verbatim>
         <f:verbatim>
			      <%=LanguageSupport.getResource("RYGL-2148","处理日期")%>
		 </f:verbatim>
         <h:inputText readonly="true" id="curMonth" value="#{emp_PersonCountBB.curMonth}"></h:inputText>
         <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:curMonth')"></h:commandButton>
         <h:commandButton  styleClass="button01" value="查询" action="#{emp_PersonCountBB.queryMonth}"></h:commandButton>
    <f:verbatim>
        </td>
        <td height="1" align="right">
    </f:verbatim>
            <h:commandButton value="变动明细" styleClass="button01" type="button" onclick="return doDetailPopup();"></h:commandButton>
            <h:commandButton value="修改数据" styleClass="button01" onclick="return ModiData();" action="#{emp_PersonCountBB.queryMonth}"></h:commandButton>
            <h:commandButton value="重新核算" styleClass="button01" onclick="return doCalc();" action="#{emp_PersonCountBB.doGroupCalc}"></h:commandButton>
            <h:commandButton value="新增下属当月数据" styleClass="button01" action="#{emp_PersonCountBB.addMonth}"></h:commandButton>
     <f:verbatim>
        </td></tr>

         <tr><td height="8" colspan="2" align="right"></td></tr>

        <tr><td colspan="2">
            <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                <jsp:param name="hasOperSign" value="true"/>
                <jsp:param name="isPage" value="false"/>
                <jsp:param name="operSignType" value="checkbox"/>
                <jsp:param name="hasEdit" value="false"/>
                <jsp:param name="isEditList" value="false"/>
                <jsp:param name="isCheckRight" value="false"/>
                <jsp:param name="keyName" value="SUBID"/>
                <jsp:param name="rowFuncName" value="forViewPerson"/>
            </jsp:include>
        </td></tr>
    </table>
    </f:verbatim>
</h:form>
