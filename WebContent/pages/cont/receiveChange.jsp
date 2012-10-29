<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function OpenRpt(ID){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }

            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+ID+"&ORGUID=&Parameter=&Title=";
            window.open(url);
           return false;
       }
        
    </script>

<x:saveState value="#{emp_PersonDismissBB}"/>
<h:form id="form1">
    <h:inputHidden id="fromOrgEdit" value="#{emp_PersonDismissBB.initReceive}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
         <f:verbatim>
             变更合同主体
         </f:verbatim>
       </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="3" width="100%">
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

        <h:panelGroup>
            <h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{emp_PersonDismissBB.regTableList}"/>
            </h:selectOneMenu>

        </h:panelGroup>
    </h:panelGrid>
    <br>
    <h:dataTable value="#{emp_PersonDismissBB.personList}" var="list" align="center"      id="dateList"
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
            <%=LanguageSupport.getResource("RYGL-2150","办理状态") %>
         </f:verbatim>  
            </c:facet>
            <h:outputText value="#{list.applyStatusDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
               <f:verbatim>
                   主体变更
               </f:verbatim>
            </c:facet>
            <h:selectOneRadio disabled="true" value="#{list.cont_new_begin}">
                <c:selectItem itemValue="1" itemLabel="已变更"></c:selectItem>
                <c:selectItem itemValue="0" itemLabel="未处理"></c:selectItem>
            </h:selectOneRadio>
        </h:column>

        <h:column>
            <c:facet name="header">
              <f:verbatim>
            <%=LanguageSupport.getResource("YXGL-1026","操作") %>
         </f:verbatim>  
            </c:facet>
            <h:panelGrid columns="2">
                <h:commandButton styleClass="button01"  value="变更"  rendered="#{list.cont_new_begin!='1'}" action="#{emp_PersonDismissBB.changeCont}">
                    <x:updateActionListener property="#{emp_PersonDismissBB.chgs}" value="#{list.chgId}"></x:updateActionListener>
                </h:commandButton>
                <h:commandButton styleClass="button01"  value="显示表格"  rendered="#{list.cont_new_begin=='1'}" onclick="OpenRpt('#{list.chgId}');"></h:commandButton>
            </h:panelGrid>
        </h:column>

     </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>