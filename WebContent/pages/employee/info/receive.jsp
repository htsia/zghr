<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doProcess(ID){
            window.showModalDialog("/employee/info/receiveProcess.jsf?chgID="+ID, null, "dialogWidth:350px; dialogHeight:250px;center:center;resizable:no;status:no;");
            return true;
        }
    </script>

<x:saveState value="#{emp_PersonDismissBB}"/>
<h:form id="form1">
    <h:inputHidden id="fromOrgEdit" value="#{emp_PersonDismissBB.initReceive}"/>
    <c:verbatim>
    <table height=98% width=100% align="center">
        <tr><td height=8>
    </c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
             <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
                 <%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID, OperateBO.CHANGEMODULEID) %> ->
                 <%=CodeUtil.interpertCode(CodeUtil.TYPE_OPERATER, "0366") %>
             </f:verbatim>
           </h:panelGroup>
        </h:panelGrid>
    <c:verbatim>
          </td></tr>

        <tr><td height=8>
    </c:verbatim>
    <h:panelGrid columns="2" width="100%">
        <h:panelGroup>
             <c:verbatim>&nbsp;&nbsp;</c:verbatim>
             <h:selectBooleanCheckbox value="#{emp_PersonDismissBB.onlyNotApprove}" id="selectNotApprove" onclick="submit()" valueChangeListener="#{emp_PersonChgListBB.changeTo}" />  <h:outputText value="仅显示待接收"/>
        </h:panelGroup>

        <h:panelGroup>
              <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2190","申请时间") %>
         </f:verbatim>
            <h:inputText readonly="true" id="processDate" value="#{emp_PersonDismissBB.processDate}"></h:inputText>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
            <h:commandButton value="查询" styleClass="button01" action="#{emp_PersonDismissBB.refreshQuery}"></h:commandButton>
            <h:commandButton value="全部" styleClass="button01" onclick="document.all('form1:processDate').value='';" action="#{emp_PersonDismissBB.refreshQuery}"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim>
          </td></tr>

        <tr><td valign="top">
    </c:verbatim>
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
    <h:dataTable value="#{emp_PersonDismissBB.personList}" var="list" align="center"   id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="98%" >

        <h:column>
            <c:facet name="header">
            <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2163","申请日期") %>
         </f:verbatim>  
                         </c:facet>
            <h:outputText value="#{list.applyDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
           <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1042","员工编号") %>
         </f:verbatim>  
              </c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
                <f:verbatim>
            <%=LanguageSupport.getResource("MSG-0010","姓名") %>
         </f:verbatim>  
              </c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
                 <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2146","原单位") %>
         </f:verbatim>  
            </c:facet>
            <h:outputText value="#{list.fromOrgName}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
                 <f:verbatim>
                     原部门
                </f:verbatim>
            </c:facet>
            <h:outputText value="#{list.fromDepName}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
                 <f:verbatim>
                     原岗位
                </f:verbatim>
            </c:facet>
            <h:outputText value="#{list.fromPostName}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
               <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2150","办理状态") %>
         </f:verbatim>  
            </c:facet>
            <h:outputText value="#{list.applyStatusDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
              <f:verbatim>
            <%=LanguageSupport.getResource("YXGL-1026","操作") %>
         </f:verbatim>  
            </c:facet>
            <h:panelGrid columns="2">
                <h:commandButton styleClass="button01"  value="接收"  rendered="#{list.applyStatus=='0'}" onclick="doProcess('#{list.chgId}')"></h:commandButton>
            </h:panelGrid>
        </h:column>

     </h:dataTable>
    </div>
    <c:verbatim>
          </td></tr>

        </table>
    </c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>