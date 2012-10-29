<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String showName = CommonFuns.filterNull((String) request.getAttribute("showName"));
%>

    <script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/org/info/OrgEditInfo.jsf?pk=" + id + "&type=" + type + "&cancel=1", "aa", "", "900", "600", "no", "10", "100", "yes");
        }

        function forAdQry() {
            document.all("form1:orgName").value = "";
            document.all("form1:superId").value = "";
            document.all("form1:superId").code = "";
            document.all("form1:orgType").value = "";
            document.all("form1:orgType").code = "";
            doAdvanceQuery("B", "ORG", "111", "Y", "", "B001.B001730='00901'","Y","<%=Constants.DEFAULT_QUERY_ORG%>","Y","1");
        }

        function back(){
            if(confirm('确认恢复？')){
               pageCodeExchange(document.forms(0));
                return true;
            }else{
                return false;
            }
        }
        function del(){
            if(confirm('确认删除？')){
               pageCodeExchange(document.forms(0));
                return true;
            }else{
                return false;
            }
        }
    </script>

<h:form id="form1">
    <h:inputHidden value="#{org_orgDismissListBB.orgList}"/>
    <h:inputHidden id="backRefresh" value="#{org_orgDismissListBB.backRefresh}"/>
    <h:inputHidden id="delRefresh" value="#{org_orgDismissListBB.delRefresh}"/>
    <c:verbatim>
    <input type="hidden" name="sessionFlag" value="2">
        <table id=t1 width="100%" height=98% border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_page" height=8>
      </c:verbatim>
                 <f:verbatim>
					  <%=LanguageSupport.getResource("JGGL-1002","机构名称：")%>
			     </f:verbatim>
                <h:inputText id="orgName" value="#{org_orgDismissListBB.orgName}"
                                  size="15" styleClass="input"/>
                                  
                 <f:verbatim>
					  <%=LanguageSupport.getResource("JGGL-1004","主管机构：")%>
			     </f:verbatim>
                <h:inputText id="superId" value="#{org_orgDismissListBB.superId}" readonly = "true"
                                  size="15" styleClass="input" code="" dict="yes" dict_num="OU"></h:inputText>
                <h:commandButton onclick="javascript:PopUpOrgDlg('form1:superId',1,'')" styleClass="button_select"
                                 type="button"/>
                                 
                   <f:verbatim>
					  <%=LanguageSupport.getResource("JGGL-1003","机构类别：")%>
			     </f:verbatim>
                <h:inputText id="orgType" readonly = "true" code="" dict="yes" dict_num="0891" value="#{org_orgDismissListBB.orgType}"
                                  size="15" styleClass="input"></h:inputText>
                <h:commandButton onclick="javascript:PopUpCodeDlgOneControl('form1:orgType')" styleClass="button_select"
                                 type="button"/>
                <h:commandButton value=" 查询 " id="queryOrg" onclick="javascript:return forsubmit(document.forms(0));" styleClass="button01"
                                 action="#{org_orgDismissListBB.queryOrg}"/>
                <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01"/>
<c:verbatim>
            </td>
        </tr>
        <tr>
            <td class="td_page" align="right" height=8>
</c:verbatim>
                <h:commandButton value="机构撤销恢复" onclick="javascript:return back();" styleClass="button01"
                                 action="#{org_orgDismissListBB.backOrg}"/>
                <h:commandButton value="机构删除" onclick="javascript:return del();" styleClass="button01"
                                 action="#{org_orgDismissListBB.delOrg}"/>
<c:verbatim>
            </td>
             <tr><td height=8></td></tr>
             <tr><td>
                 <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                     <jsp:param name="hasOperSign" value="true"/>
                     <jsp:param name="operSignType" value="checkbox"/>
                     <jsp:param name="hasEdit" value="true"/>
                     <jsp:param name="isEditList" value="false"/>
                     <jsp:param name="isCheckRight" value="true"/>
                     <jsp:param name="isForward" value="true"/>
                     <jsp:param name="isRow" value="true"/>
                     <jsp:param name="rowFuncName" value="forView"/>
                     <jsp:param name="isPage" value="true"/>
                 </jsp:include>
             </td></tr>
        </tr>
    </table>
    <script type="text/javascript">
        interpret(document.forms(0));
        var showname = "<%=showName%>";
        if (showname != "") {
            alert(showname);
        }
        if (document.all("form1:delRefresh").value == "1") {
            parent.tree.location.href = "/pages/common/ShowOrgTree.jsp?cancelFlag=1";
        }
        if (document.all("form1:backRefresh").value == "1") {
            parent.tree.location.href = "/pages/common/ShowOrgTree.jsp?cancelFlag=1";
        }
    </script>

</c:verbatim>

</h:form>
