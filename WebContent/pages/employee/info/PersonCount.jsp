<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function confirmData(){
            var subid=getFirstSelectValue(form1.chk);
            if (subid==""){
                alert("请选择要确认的月份!");
                return false;
            }
            document.all('form1:subid').value=subid;
            return true;
        }
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
            window.showModalDialog("/employee/info/modiRule.jsf?Init=true", null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function addMonth() {
            window.showModalDialog("/employee/info/addMonth.jsf", null, "dialogWidth:320px; dialogHeight:160px;center:center;resizable:yes;status:no;scroll:yes;");
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
                alert("请选择月份！");
            }
            return false;
        }
        function doCalc(){
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
                document.all('form1:subid').value=str;
                disPlayProcessBar();
                return true;
            } else {
                alert("请选择月份！");
                return false;
            }
        }
    </script>

<x:saveState value="#{emp_PersonCountBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{emp_PersonCountBB.pageInit}"/>
    <h:inputHidden id="subid" value="#{emp_PersonCountBB.subid}"/>
    <f:verbatim>
    <table  height="98%" width="98%" align="center">
        <tr><td class="td_title" height=30>
            <img src="/images/tips.gif" />  
              <%=LanguageSupport.getResource("RYGL-0300","  人员管理   ")%> ->
              <%=LanguageSupport.getResource("RYGL-0370","人员基数核算")%>  
        </td></tr>

        <tr><td height="1" align="right">
    </f:verbatim>
            <h:commandButton value="计算规则" styleClass="button01" onclick="ModiRule();" rendered="#{emp_PersonCountBB.canModiRule}"></h:commandButton>
            <h:commandButton value="变动明细" styleClass="button01" type="button" onclick="return doDetailPopup();"></h:commandButton>
            <h:commandButton value="修改数据" styleClass="button01" onclick="return ModiData();"></h:commandButton>
            <h:commandButton value="重新核算" styleClass="button01" onclick="return doCalc();" action="#{emp_PersonCountBB.doCalc}"></h:commandButton>
            <h:commandButton value="数据确认" styleClass="button01" onclick="return confirmData();" action="#{emp_PersonCountBB.confirmData}"></h:commandButton>
            <h:commandButton value="新增月份" styleClass="button01" onclick="addMonth();"></h:commandButton>
     <f:verbatim>
        </td></tr>

         <tr><td height="8" align="right"></td></tr>

        <tr><td>
            <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                <jsp:param name="hasOperSign" value="true"/>
                <jsp:param name="isPage" value="false"/>
                <jsp:param name="operSignType" value="checkbox"/>
                <jsp:param name="hasEdit" value="false"/>
                <jsp:param name="isEditList" value="false"/>
                <jsp:param name="isCheckRight" value="false"/>
                <jsp:param name="keyName" value="SUBID"/>
                <jsp:param name="rowFuncName" value="forViewPerson"/>
                <jsp:param name="BaseCountList" value="true"/>
            </jsp:include>
        </td></tr>
    </table>
    </f:verbatim>
</h:form>
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
