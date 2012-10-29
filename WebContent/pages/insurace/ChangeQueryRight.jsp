<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id, "aa", "", "800", "700", "no");
        }

        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var perId = selectOnlyOne(document.forms(0).chk);

            if (perId!=null) {
                doShowPersonTable(document.all("form1:ReportID").value,perId);
            }
            return false;
        }
         function OpenListRpt(){
             if (document.all("form1:listRptID").value=="-1"){
                 alert("请先选择表格样式！");
                 return false;
             }
             if (document.all("form1:superId").value!="") {
                 doShowPersonRoster(document.all("form1:listRptID").value,document.all("form1:superId").value);
             }
         }
         function forAdQry(){
             doAdvanceQuery("A","ORG","111","Y","","A001.A001730='00900'","Y","<%=Constants.DEFAULT_QUERY_PERSON%>","Y","1");
         }
    </script>

    <h:form id="form1">
        <h:inputHidden value="#{ins_ChangeQueryBB.namelist}"/>
        <h:inputHidden id="superId" value="#{ins_ChangeQueryBB.superId}"/>
         <input type="hidden" name="sessionFlag" value="2">
        <f:verbatim>
        <table id=t1 width="100%" height="98%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td_page" height=8 widht=100%>
        </f:verbatim>
                    <h:outputText value="姓名或员工编号："></h:outputText>
                    <h:inputText id="name" value="#{ins_ChangeQueryBB.name}"
                                    size="10" styleClass="input" onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value=" 查询 " id="queryPerson"  styleClass="button01"
                                     action="#{ins_ChangeQueryBB.queryPerson}"/>
                    <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01" />
					<h:commandButton styleClass="button01" type="button" value="导出Excel" onclick="doExport();"></h:commandButton>
        <f:verbatim>
        </td>
                <td class="td_page" height=8>
        </f:verbatim>
                    <h:selectOneMenu id="ReportID" style="width:150px">
                        <c:selectItems value="#{ins_ChangeQueryBB.reportList}"/>
                    </h:selectOneMenu>
                    <h:commandButton value="显示登记表" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>

                    <h:selectOneMenu id="listRptID" style="width:150px">
                        <c:selectItems value="#{ins_ChangeQueryBB.listrptList}"/>
                    </h:selectOneMenu>
                    <h:commandButton value="显示花名册" styleClass="button01" onclick="return OpenListRpt();"></h:commandButton>
           <f:verbatim>
                </td>
            </tr>
            <tr>
                <td colspan=2 width="100%">
                    <jsp:include page="../common/activepage/ActiveList.jsp">
                        <jsp:param name="hasOperSign" value="true"/>
                        <jsp:param name="operSignType" value="checkbox"/>
                        <jsp:param name="hasEdit" value="true"/>
                        <jsp:param name="isEditList" value="false"/>
                        <jsp:param name="isCheckRight" value="false"/>
                        <jsp:param name="isForward" value="true"/>
                        <jsp:param name="isRow" value="false"/>
                        <jsp:param name="isPage" value="true"/>
                    </jsp:include>
                </td>
            </tr>
        </table>
        </f:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
