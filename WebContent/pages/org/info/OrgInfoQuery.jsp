<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../../include/taglib.jsp"  %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script>
    function forView(form, id, type) {
       // window.showModalDialog("/org/info/OrgEditInfo.jsf?pk="+id+"&type="+type, "", "dialogWidth:900px; dialogHeight:600px; center:center; status:0;");
        //parent.refreshTree();
        //parent.refreshList(id);
		windowOpen("/org/info/OrgEditInfo.jsf?pk="+id+"&type="+type, "aa", "", "900", "600", "no","10","100","yes");
    }
     function forAdQry(){
         doAdvanceQuery("B","ORG","111","Y","","B001.B001730='00900'","Y","","Y","1");
     }
    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }

        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("refreshId").value+"&Parameter=&Title=";
        window.open(url);
        return false;
   }
    function OpenRosterRpt(){
        if (document.all("form1:ListReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }

        if (document.all('form1:superId').value!=null && document.all('refreshId').value!=""){
            doShowOrgRoster(document.all("form1:ListReportID").value,document.all('refreshId').value);
        } else {
            alert("请选择机构");
        }
       return false;
    }
    

</script>

<h:form id="form1">
    <h:inputHidden value="#{OrgListBB.orgList}"/>
    <f:verbatim>
    <input type="hidden" name="sessionFlag" value="2">
    <input type="hidden" name="refreshFlag" value="<%=CommonFuns.filterNull(request.getParameter("flag"))%>">
    <input type="hidden" name="refreshId" value="<%=CommonFuns.filterNull(request.getParameter("superId"))%>">
    <table id=t1 width="100%" height="96%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height=8 class="td_page">
            <%=LanguageSupport.getResource("JGGL-1002","机构名称：")%>  
            
    </f:verbatim>
                <h:inputText id="orgName" value="#{OrgListBB.orgName}" styleClass="input" size="10"/>
                <f:verbatim>
                   <%=LanguageSupport.getResource("JGGL-1004","主管机构：")%>  
                </f:verbatim>
                <h:inputText id="superId" value="#{OrgListBB.superId}"  styleClass="input" size="10" code=""  dict="yes"  readonly="true" dict_num="OU"/>
                <h:commandButton  onclick="javascript:PopUpOrgDlg('form1:superId',1)" styleClass="button_select" type="button"/>
                 <f:verbatim>
                   <%=LanguageSupport.getResource("JGGL-1003","机构类别：")%>  
                </f:verbatim>
                
                <h:inputText id="orgType" code=""  readonly="true" dict="yes" dict_num="0891" value="#{OrgListBB.orgType}" styleClass="input"  size="10"/>
                <h:commandButton  onclick="javascript:PopUpCodeDlgOneControl('form1:orgType')" styleClass="button_select" type="button"/>
                <h:outputText escape="fasle" value="&nbsp;&nbsp;" ></h:outputText>

                <h:commandButton value=" 查询 " id="queryOrg" onclick="javascript:return forsubmit(document.forms(0));" styleClass="button01"
                                 action="#{OrgListBB.queryOrg}"/>
                <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01" />
                <h:commandButton value="按列修改" onclick="return colEdit();" styleClass="button01" />
      <f:verbatim>
            </td>
        </tr>
        <tr>
            <td height=8 class="td_page">
    </f:verbatim>
                <h:selectOneMenu id="ReportID" style="width:190px">
                    <c:selectItems value="#{OrgListBB.regTableList}"/>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" type="button" value="显示表格" onclick="OpenRpt();"></h:commandButton>

                <h:selectOneMenu id="ListReportID" style="width:190px">
                    <c:selectItems value="#{OrgListBB.listTableList}"/>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" type="button" value="显示名册" onclick="OpenRosterRpt();"></h:commandButton>
<f:verbatim>
            </td>
        </tr>
        <tr>
            <td>
                <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                    <jsp:param name="hasOperSign" value="false"/>
                    <jsp:param name="operSignType" value="checkbox"/>
                    <jsp:param name="hasEdit" value="true"/>
                    <jsp:param name="isEditList" value="false"/>
                    <jsp:param name="isCheckRight" value="false"/>
                    <jsp:param name="isForward" value="true"/>
                    <jsp:param name="isRow" value="true"/>
                    <jsp:param name="rowFuncName" value="forView"/>
                    <jsp:param name="isPage" value="true"/>
                </jsp:include>
            </td>
        </tr>
    </table>
 </f:verbatim>
</h:form>
<script>
    interpret(document.forms(0));
</script>
