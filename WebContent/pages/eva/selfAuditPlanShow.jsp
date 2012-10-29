<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.eva.ucc.impl.EvaKeyItemUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaScoreUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaObjectsUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaPlanUCC"%>
<%@page import="com.hr319wg.emp.ucc.impl.teamManagerImpl"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaGradeUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.eva.pojo.vo.*" %>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>



    <script type="text/javascript">
   
    function showTable(){
    	url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+document.all("form1:personId").value+"&ORGUID="+document.all("form1:planID").value+"&Parameter="+document.all("form1:templateId").value+"&Title=";
    	window.open(url);
    }
    function showTable2(changId){
		url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+changId+"&ORGUID=&Parameter=&Title=";
		window.open(url);
 	}
    </script>

<x:saveState value="#{eva_selfscorebb}"/>
<h:form id="form1">
    <h:inputHidden id="init" value="#{eva_selfscorebb.init}"/>
    <h:inputHidden id="personId" value="#{eva_selfscorebb.personId}"></h:inputHidden>
    <h:inputHidden id="planID" value="#{eva_selfscorebb.planID}"></h:inputHidden>
    <h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{eva_selfscorebb.refreshObject}"></h:commandButton>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 自助考核打分"/>
        </h:panelGroup>
    </h:panelGrid>
    
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td colspan=2 height=8>
        </td></tr>
        <tr><td height=8 align="left">
    </c:verbatim>
    	<h:outputText value="选择模板:"></h:outputText>
        <h:selectOneMenu id="templateId" value="#{eva_selfscorebb.templateId}" onchange="submit();" valueChangeListener="#{eva_selfscorebb.changeTem}">
            <c:selectItems value="#{eva_selfscorebb.templateList}"></c:selectItems>
        </h:selectOneMenu>
           <c:verbatim>
        </td>
        <td>
        </td>
        <td height=8 align="right">
         </c:verbatim>
         	<h:outputText value="姓名或简称："></h:outputText>
         	<h:inputText value="#{eva_selfscorebb.queryValue}" styleClass="input" size="20"></h:inputText>
         	<h:commandButton styleClass="button01"  value="查询" action="#{eva_selfscorebb.refreshObject}"></h:commandButton>
         	<h:outputText value=" "></h:outputText>
         	<h:outputText value="#{eva_selfscorebb.gradeDes} "></h:outputText>
         	<h:outputText value=" "></h:outputText>
         	<h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{eva_selfscorebb.regTableList}"/>
            </h:selectOneMenu>
            <h:outputText value=" "></h:outputText>
            <h:commandButton styleClass="button01" type="button" value="显示" onclick="showTable();"></h:commandButton>
         <c:verbatim>
        </td></tr>
        <tr>
        	<td colspan=3 align="right" height=8>
        	</c:verbatim>
        		<h:outputText value="页数:#{eva_selfscorebb.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{eva_selfscorebb.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{eva_selfscorebb.pagevo.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{eva_selfscorebb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{eva_selfscorebb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{eva_selfscorebb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{eva_selfscorebb.last}" styleClass="button01"></h:commandButton>
        	<c:verbatim>
        	</td>
        </tr>
        <tr><td colspan=3 valign="top">
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
         </c:verbatim>
         	 <x:dataTable value="#{eva_selfscorebb.objectList}" var="list" width="100%" id="dateList" rowIndexVar="index"
                    styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="序号"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{index+1}"/>
                </h:column>
                <h:column rendered="#{eva_selfscorebb.objectType=='0'}">
                    <f:facet name="header">
                        <h:outputText value="姓名"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.personName}"/>
                </h:column>
                <h:column rendered="#{eva_selfscorebb.objectType!='2'}">
                    <f:facet name="header">
                        <h:outputText value="部门"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.deptName}"/>
                </h:column>
                <h:column rendered="#{eva_selfscorebb.objectType=='2'}">
                    <f:facet name="header">
                        <h:outputText value="团队名称"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.teamName}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="机构"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.orgName}"/>
                </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="考核得分"/>
                      </f:facet>
                      <h:outputText escape="false" value="#{list.score}"/>
                  </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="考核等级"/>
                      </f:facet>
                      <h:outputText escape="false" value="#{list.gradeName}"/>
                  </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="操作"/>
                      </f:facet>
                      <h:commandButton value="显示表格" styleClass="button01" onclick="return showTable2('#{list.masterId}');"/>
                  </h:column>
             </x:dataTable>
         <c:verbatim>
       </div>
        </td></tr>
        </table>
    </c:verbatim>
    
</h:form>
<script type="text/javascript">
    setDataTableOver("form1:dateList");
</script>