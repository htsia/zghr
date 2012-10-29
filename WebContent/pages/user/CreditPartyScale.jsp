<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/check.js"></script>

    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    %>
    <script type="text/javascript">
        function fPopUpPartyDlg(pflag) {
            var arg = "dict_num=PA";
            arg += "&curCode=";
            arg += "&value=";
            arg += "&rightFlag=1";
            arg += "&rootId=";
            arg += "&paType=";

            showx = event.screenX - event.offsetX - 250;
            // + deltaX;
            showy = event.screenY - event.offsetY + 18;
            //var flag = document.all("user_partyScaleBB:scaleFlag").value;
            // flag "0" 查询范围 "1" 维护
            if (pflag == '0')
                retval = window.showModalDialog("/pages/common/SelParty.jsp?" + arg, "", "dialogWidth:315px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            else{
                retval = window.showModalDialog("/pages/common/SelOptParty.jsp?" + arg, "", "dialogWidth:315px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            }
            //     debugger;
            if (retval != null) {
                var rs = retval.split(",");
                if (rs[0] != null && rs[0] != "") {
                    document.forms[0]["formCreditPartyScale:selPartyId"].value = rs[0];
                    return true;
                }
            }
            return false;
        }
    </script>

<x:saveState value="#{user_partyScaleBB}"/>
<h:form id="formCreditPartyScale">
    <h:inputHidden id="selPartyId" value="#{user_partyScaleBB.selPartyId}"/>
    <h:inputHidden id="pageInit" value="#{user_partyScaleBB.pageInit}"/>
    <h:inputHidden id="paramId" value="#{user_partyScaleBB.paramId}"/>
    <h:inputHidden id="pageFlag" value="#{user_partyScaleBB.pageFlag}"/>
    <h:inputHidden id="manageFlag" value="#{user_partyScaleBB.manageFlag}"/>
    <c:verbatim>
    <table border="1" class="table03" cellpadding="0" width=97%>
        <tr height="5%">
            <td class="td_title" width=30%>查询范围列表</td>
            <td class="td_title" width=20% style="border-right: 2px solid;">
     </c:verbatim>
                <h:commandButton id="queryadd" value="添  加" onclick="return fPopUpPartyDlg('0')" styleClass="button01"
                                 action="#{user_partyScaleBB.saveQueryPartyScale}"></h:commandButton>
                <h:commandButton id="querydelete" value="删 除" styleClass="button01"
                                 onclick="return checkBatchDelete('selectItem1')"
                                 action="#{user_partyScaleBB.deleteQueryPartyScale}"></h:commandButton>
      <c:verbatim>
            </td>
            <td class="td_title" width=30%>维护范围列表</td>
            <td class="td_title" width=20%>
      </c:verbatim>
                <h:commandButton id="operateadd" value="添  加" styleClass="button01" onclick="return fPopUpPartyDlg('1')"
                                 action="#{user_partyScaleBB.saveOperatePartyScale}"></h:commandButton>
                <h:commandButton id="operatedelete" value="删 除" styleClass="button01"
                                 onclick="return checkBatchDelete('selectItem2')"
                                 action="#{user_partyScaleBB.deleteOperatePartyScale}"></h:commandButton>
 <c:verbatim>
            </td>
        </tr>
        <tr height=95%>
            <td colspan=2 width=50% align="left" valign="top">
 </c:verbatim>
                <h:dataTable value="#{user_partyScaleBB.queryPartyScale}" var="list" width="90%" headerClass="td_top"
                             rowClasses="td_middle"
                             styleClass="table03"
                             border="1">
                    <h:column>
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox" name="all2"
                                       onclick="selectAll(document.forms(0).all2,document.forms(0).selectItem1)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem1" value="</f:verbatim>
                        <h:outputText value="#{list.partyId}"/>
                        <f:verbatim escape="false">"/></div></f:verbatim>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="党组织名称"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.partyName}"/>
                    </h:column>

                </h:dataTable>
 <c:verbatim>
            </td>
            <td colspan=2 width=50% align="left" valign="top">
 </c:verbatim>
                <h:dataTable value="#{user_partyScaleBB.operatePartyScale}" var="list" width="90%" headerClass="td_top"
                             rowClasses="td_middle"
                             styleClass="table03"
                             border="1">
                    <h:column>
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox" name="all1"
                                       onclick="selectAll(document.forms(0).all1,document.forms(0).selectItem2)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem2" value="</f:verbatim>
                        <h:outputText value="#{list.partyId}"/>
                        <f:verbatim escape="false">"/></div></f:verbatim>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="党组织名称"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.partyName}"/>
                    </h:column>
                </h:dataTable>
 <c:verbatim>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var pflag = document.all("formCreditPartyScale:pageFlag").value;
        if (pflag != "1"){
            document.all("formCreditPartyScale:queryadd").style.display = "none";
            document.all("formCreditPartyScale:querydelete").style.display = "none";
            document.all("formCreditPartyScale:operateadd").style.display = "none";
            document.all("formCreditPartyScale:operatedelete").style.display = "none";
            var elms = document.forms(0).elements;
            for (i = 0; i < elms.length; i++) {
                if (elms[i].type == 'checkbox') {
                    elms[i].disabled = true;
                }
            }
        }
    </script>
 </c:verbatim>
</h:form>
