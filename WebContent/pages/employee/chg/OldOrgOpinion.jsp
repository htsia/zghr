<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function OpenRpt(perID){
           if (document.all("form1:ReportID").value=="-1"){
               alert("请先选择表格样式！");
               return false;
           }
           var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID=&Parameter=&Title=";
           window.open(url);
           return false;
        }
        function doApprove() {
            var str="";
            if (document.form1.selectItem == null) {
                window.alert("没有选择审批对象!");
                return false;
            }
            var size = document.form1.selectItem.length;
            if (size == null) {
                if (document.form1.selectItem.checked) {
                    str=document.form1.selectItem.value;
                } else {
                    window.alert("没有选择审批对象!");
                    return false;
                }
            } else {
                for (var i = 0; i < size; i++) {
                    if (document.form1.selectItem[i].checked) {
                        if (str=="") str=document.form1.selectItem[i].value;
                        else str=str+","+document.form1.selectItem[i].value;
                    }
                }
            }
            if (str==""){
                window.alert("没有选择审批对象!");
                return false;
            }
            else{
                var ret=window.showModalDialog("/employee/chg/OldOrgOpinionEdit.jsf?Ids="+str, null, "dialogWidth:730px; dialogHeight:450px;center:center;resizable:no;status:no;");
                return true;
            }
        }
        function doShowPerson(id) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&type=1", "aa", "", "1000", "600", "no","10","1","yes");
        }
    </script>

<x:saveState value="#{emp_PersonChgListBB}"/>
<h:form id="form1">
    <h:inputHidden id="fromOrg" value="#{emp_PersonChgListBB.fromOrg}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2179", "调配管理")%>->
				 <%=LanguageSupport.getResource("RYGL-2202", "调出业务审批")%>
	   </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>

   <h:panelGrid columns="3" width="95%" align="center">
       <h:panelGroup>
            <c:verbatim>&nbsp;&nbsp;</c:verbatim>
            <h:selectBooleanCheckbox value="#{emp_PersonChgListBB.onlyNotApprove}" id="selectNotApprove" onclick="submit()" valueChangeListener="#{emp_PersonChgListBB.changeFrom}" />  <h:outputText value="仅显示未审批"/>
       </h:panelGroup>

       <h:panelGroup>
           <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2190", "申请时间")%>
	       </f:verbatim>
           <h:inputText readonly="true" id="processDate" value="#{emp_PersonChgListBB.processDate}"></h:inputText>
           <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
            <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2193", "姓名或编号")%>：
	       </f:verbatim>
           <h:inputText value="#{emp_PersonChgListBB.name}"></h:inputText>
           <h:commandButton value="查询" styleClass="button01" action="#{emp_PersonChgListBB.getFromOrg}"></h:commandButton>
           <h:commandButton value="全部" styleClass="button01" onclick="document.all('form1:processDate').value='';" action="#{emp_PersonChgListBB.getFromOrg}"></h:commandButton>
       </h:panelGroup>

       <h:panelGrid columns="4" align="right">
          <h:selectOneMenu id="ReportID" style="width:140px">
             <c:selectItems value="#{emp_PersonChgListBB.reportList}"/>
          </h:selectOneMenu>
          <h:commandButton value="审批" styleClass="button01" onclick="return doApprove();"></h:commandButton>
       </h:panelGrid>
   </h:panelGrid>

    <h:panelGrid columns="1" cellspacing="2" width="95%"  align="center" >
        <h:dataTable value="#{emp_PersonChgListBB.fromOrgPerson}" var="list" align="center"  id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="100%" >
            <h:column>
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll"
                               onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>
                              <%=LanguageSupport.getResource("RYGL-2194", "全选")%>
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <input type="checkbox" name="selectItem"    value="</c:verbatim><h:outputText value="#{list.chgId}"/><c:verbatim>">
                </c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header">
                     <f:verbatim>
				  <%=LanguageSupport.getResource( "RYGL-2163", "申请日期")%>
			     </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.applyDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header">
                 <f:verbatim>
				  <%=LanguageSupport.getResource( "XTGL-1042", "员工编号")%>
			     </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
				  <%=LanguageSupport.getResource( "RYGL-1016", "姓名")%>
			     </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
				  <%=LanguageSupport.getResource( "RYGL-2176", "身份")%>
			     </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.degree}"/>
            </h:column>


            <h:column>
                <c:facet name="header">
                 <f:verbatim>
				  <%=LanguageSupport.getResource( "RYGL-2175", "调往单位")%>
			     </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.toOrgName}"/>
            </h:column>

             <h:column>
                <c:facet name="header">
                  <f:verbatim>
				  <%=LanguageSupport.getResource( "RYGL-2199", "工资帐套情况")%>
			     </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.oldOrgWageSet}"/>
            </h:column>

             <h:column>
                <c:facet name="header">
                  <f:verbatim>
				  <%=LanguageSupport.getResource( "RYGL-2170", "原单位合同情况")%>
			     </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.cont_old_end}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
				  <%=LanguageSupport.getResource( "RYGL-2151", "办理状态")%>
			     </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.applyStatusDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
				  <%=LanguageSupport.getResource( "RYGL-2203", "审批结果")%>
			     </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.fromOpinionDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
               <f:verbatim>
				  <%=LanguageSupport.getResource( "YXGL-1026", "操作")%>
			   </f:verbatim>
                </c:facet>
                <h:panelGrid columns="3">
                    <h:commandButton styleClass="button01"  value="查看信息"  onclick="doShowPerson('#{list.personId}')"></h:commandButton>
                    <h:commandButton value="打印表格" styleClass="button01" onclick="return OpenRpt('#{list.personId}');"></h:commandButton>
                </h:panelGrid>
            </h:column>

        </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>