<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
    <script language="javascript" src="<%=request.getContextPath()%>/js/tree2.js"></script>
    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    %>
    <script language=javascript>
        function secBoard(n){
            for (i = 0; i < secTable.cells.length; i++)  secTable.cells[i].className = "tab";
            secTable.cells[n].className = "activeTab";
            // debugger;
            var magFlag =document.all("formCreditManage:manageFlag").value;
            //alert(magFlag);
            if(magFlag=='是'){
                magFlag="1";
            }else
                magFlag="0";
           // alert(magFlag);
            var pram = "paramid=" + document.all("formCreditManage:paramId").value + "&pageflag=" + document.all("formCreditManage:pageFlag").value;
            pram +="&manageFlag="+ magFlag;
            switch (n) {
                case 0:
                    document.infoiframe.location = "/user/CreditOperate.jsf?" + pram;
                    break;
                case 1:
                    document.infoiframe.location = "/user/CreditSelfBusiPower.jsf?"+pram;
                    break;
                case 2:
                    document.infoiframe.location = "/user/CreditSelfPower.jsf?"+pram;
                    break;
                case 3:
                    document.infoiframe.location = "/user/CreditDataIndex.jsf?" + pram;
                    break;
                case 4:
                    document.infoiframe.location = "/user/CreditOrgScale.jsf?"+pram+"&scaleflag=0";
                    break;
                case 5:
                    document.infoiframe.location = "/user/CreditOrgScale.jsf?"+pram+"&scaleflag=1";
                    break;
                case 6:
                    document.infoiframe.location = "/user/CreditPartyScale.jsf?"+pram;
                    break;
                case 7:
                    document.infoiframe.location = "/user/CreditCode.jsf?"+pram;
                    break;
                case 8:
                    document.infoiframe.location = "/user/CreditPostCode.jsf?"+pram;
                    break;
                default:
                    break;
            }
        }
        secBoard(0);
    </script>

<h:form id="formCreditManage">
    <h:inputHidden id="pageFlag" value="#{user_creditManageBB.pageFlag}"></h:inputHidden>
    <h:inputHidden id="paramId" value="#{user_creditManageBB.paramId}"></h:inputHidden>
    <h:inputHidden id="pageInit" value="#{user_creditManageBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="paramName" value="#{user_creditManageBB.name}"></h:inputHidden>
    <h:inputHidden id="manageFlag" value="#{user_creditManageBB.manageFlag}"></h:inputHidden>
    <h:inputHidden id="personName" value="#{user_creditManageBB.condiValue}"></h:inputHidden>
    <h:inputHidden id="condiValue" value="#{user_creditManageBB.condiType}"></h:inputHidden>
    <h:inputHidden id="orgId" value="#{user_creditManageBB.orgId}"></h:inputHidden>
    <h:inputHidden id="personType" value="#{user_creditManageBB.personType}"></h:inputHidden>
    <h:inputHidden id="queryType" value="#{user_creditManageBB.queryType}"></h:inputHidden>

<c:verbatim>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="td_title">
</c:verbatim>
            <h:outputText value="#{user_creditManageBB.title}"/>
<c:verbatim>
        </td>
        <td align="right" class="td_title">
</c:verbatim>
            <h:commandButton id="btnBack1" value="返  回" styleClass="button01" action="rolelist"/>
            <h:commandButton id="btnBack2" value="返  回" styleClass="button01" action="userlist">
                <x:updateActionListener property="#{user_userPmsManagerBB.condiValue}" value="#{user_creditManageBB.condiValue}"/>
                <x:updateActionListener property="#{user_userPmsManagerBB.condiType}" value="#{user_creditManageBB.condiType}"/>
                <x:updateActionListener property="#{user_userPmsManagerBB.orgId}" value="#{user_creditManageBB.orgId}"/>
                <x:updateActionListener property="#{user_userPmsManagerBB.personType}" value="#{user_creditManageBB.personType}"/>
                <x:updateActionListener property="#{user_userPmsManagerBB.queryType}" value="#{user_creditManageBB.queryType}"/>
            </h:commandButton>
<c:verbatim>
        </td>
    </tr>
</table>
           <br>
           <table  width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td >
                    <table  border="0" cellpadding="0" cellspacing="0" id=secTable>
                        <tr align="center">
                            <td width="100" height="25" class="activeTab" onclick="secBoard(0)"><img src="/images/common/handtip.gif">&nbsp;业务操作</td>
                            <td width="110" height="25" class="tab" onclick="secBoard(1)"><img src="/images/common/handtip.gif">&nbsp;自助业务操作</td>
                            <td width="100" height="25" class="tab" onclick="secBoard(2)"><img src="/images/common/handtip.gif">&nbsp;自助操作</td>
                            <td width="100" class="tab" onclick="secBoard(3)"><img src="/images/common/handtip.gif">&nbsp;信息项</td>
                            <td width="100" class="tab" onclick="secBoard(4)"><img src="/images/common/handtip.gif">&nbsp;机构查询</td>
                            <td width="100" class="tab" onclick="secBoard(5)"><img src="/images/common/handtip.gif">&nbsp;机构维护</td>
                            <td width="100" class="tab" onclick="secBoard(6)"><img src="/images/common/handtip.gif">&nbsp;党组织范围</td>
                            <td width="100" class="tab" onclick="secBoard(7)"><img src="/images/common/handtip.gif">&nbsp;人员范围</td>
                            <td width="100" class="tab" onclick="secBoard(8)"><img src="/images/common/handtip.gif">&nbsp;岗位分类</td>
                        </tr>
                    </table>
                </td>
                <td align="right" class="sec3">
                </td>
            </tr>
        </table>

        <table width="98%" height="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="main_tab">
            <tr>
                <td align="center">
                    <iframe name="infoiframe" height="100%" id="infoiframe" frameborder=0 width="100%"  scrolling="auto"></iframe>
                </td>
            </tr>
        </table>
    <script type="text/javascript">
        if(document.all("formCreditManage:pageFlag").value=="1") {
            document.all("formCreditManage:btnBack2").style.display = "none";
        }
        else{
            document.all("formCreditManage:btnBack1").style.display = "none";
        }
        <%
            User user = (User) session.getAttribute(Constants.USER_INFO);
            Hashtable hashMenus = user.getPmsMenus();
            if(hashMenus != null && hashMenus.get(OperateBO.PARTYMODULEID) != null){

            }
        %>
    </script>
</c:verbatim>
</h:form>

