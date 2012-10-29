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
        //选择机构  useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号，可以用“，”分隔
        function PopUpOrgDlg() {
            var arg = "dict_num=OU";
            arg += "&curCode=";
            arg += "&value=";
            arg += "&rightFlag=1";
            arg += "&rootId=";
            arg += "&cancelFlag=1"
            //debugger;
            showx = event.screenX - event.offsetX - 250;
            // + deltaX;
            showy = event.screenY - event.offsetY + 18;
            var flag = document.all("formCreditOrgScale:scaleFlag").value;
            // flag "0" 查询范围 "1" 维护
            if (flag == "0")
                retval = window.showModalDialog("/pages/common/SelOrg.jsp?" + arg, "", "dialogWidth:315px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            else
                retval = window.showModalDialog("/pages/common/SelOptOrg.jsp?" + arg, "", "dialogWidth:315px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            //  debugger;
            if (retval != null) {
                var rs = retval.split(",");
                if (rs[0] != null && rs[0] != "") {
                    document.forms[0]["formCreditOrgScale:selOrgId"].value = rs[0];
                    return true;
                }
            }
            return false;
        }
    </script>

<x:saveState value="#{user_orgScaleBB}"/>
<h:form id="formCreditOrgScale">
<h:inputHidden id="selOrgId" value="#{user_orgScaleBB.selOrgId}"/>
<h:inputHidden id="pageInit" value="#{user_orgScaleBB.pageInit}"/>
<h:inputHidden id="paramId" value="#{user_orgScaleBB.paramId}"/>
<h:inputHidden id="scaleFlag" value="#{user_orgScaleBB.scaleFlag}"/>
<h:inputHidden id="pageFlag" value="#{user_orgScaleBB.pageFlag}"/>
<h:inputHidden id="manageFlag" value="#{user_orgScaleBB.manageFlag}"/>
<c:verbatim>
<table border="1" class="table03" cellpadding="0" width=97%>
    <tr height="5%">
        <td class="td_title" width=30%>有权机构列表</td>
        <td class="td_title" width=20% style="border-right: 2px solid;">
</c:verbatim>
            <h:commandButton id="add1" value="添  加" onclick="return PopUpOrgDlg()" styleClass="button01"
                             action="#{user_orgScaleBB.saveHaveOrgScale}"></h:commandButton>
            <h:commandButton id="delete1" value="删 除" styleClass="button01"
                             onclick="return checkBatchDelete('selectItem1')"
                             action="#{user_orgScaleBB.deleteHaveOrgScale}"></h:commandButton>
<c:verbatim>
        </td>
        <td class="td_title" width=30%>排除机构列表</td>
        <td class="td_title" width=20%>
</c:verbatim>
            <h:commandButton id="add" value="添  加" styleClass="button01" onclick="return PopUpOrgDlg()"
                             action="#{user_orgScaleBB.saveNoOrgScale}"></h:commandButton>
            <h:commandButton id="delete" value="删 除" styleClass="button01" onclick="return confirm('确认删除吗？')"
                             action="#{user_orgScaleBB.deleteNoOrgScale}"></h:commandButton>
<c:verbatim>
        </td>
    </tr>
    <tr height=95%>
         <td colspan=2 width=50% align="left" valign="top">
</c:verbatim>
            <h:dataTable value="#{user_orgScaleBB.haveOrgScale}" var="list" width="90%" headerClass="td_top"
                         rowClasses="td_middle"
                         styleClass="table03"
                         border="1">
                <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox" name="all1"
                                   onclick="selectAll(document.forms(0).all1,document.forms(0).selectItem1)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem1" value="</f:verbatim>
                    <h:outputText value="#{list.condId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="机构名称"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.orgName}"/>
                </h:column>

            </h:dataTable>
<c:verbatim>
        </td>
        <td colspan=2 width=50% align="left" valign="top">
</c:verbatim>
            <h:dataTable value="#{user_orgScaleBB.noOrgScale}" var="list" width="90%" headerClass="td_top"
                         rowClasses="td_middle"
                         styleClass="table03"
                         border="1">
                <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox" name="all2"
                                   onclick="selectAll(document.forms(0).all2,document.forms(0).selectItem2)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem2" value="</f:verbatim>
                    <h:outputText value="#{list.condId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="机构名称"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.orgName}"/>
                </h:column>

            </h:dataTable>
<c:verbatim>
        </td>
    </tr>
</table>
</c:verbatim>
<script type="text/javascript">
    var pflag = document.all("formCreditOrgScale:pageFlag").value;
    if (pflag != "1")  //角色权限设置
    {
        //  tree.oncheck = nocheck;
        document.all("formCreditOrgScale:add").style.display = "none";
        document.all("formCreditOrgScale:delete").style.display = "none";
        document.all("formCreditOrgScale:add1").style.display = "none";
        document.all("formCreditOrgScale:delete1").style.display = "none";

        var elms = document.forms(0).elements;
        for (i = 0; i < elms.length; i++) {
            if (elms[i].type == 'checkbox') {
                elms[i].disabled = true;
            }
        }
    }
</script>
</h:form>