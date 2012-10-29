<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.title.pojo.bo.*"%>
<%@ page import="com.hr319wg.title.ucc.impl.TitleContentSetUCC" %>
<%@ page import="com.hr319wg.title.ucc.impl.EmpTitleApplyUcc" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
        function selGroup(itemId){
        	 var returnvalue=window.showModalDialog("/employee/title/selAuditGroup.jsf?applyId="+document.all('form1:applayId').value, null, "dialogWidth:300px; dialogHeight:400px;center:center;resizable:no;status:yes;scroll:no;");
        	 if (typeof(returnvalue) == "undefined") { 
        		  return false; 
        	} else{ 
        		  document.all("form1:groups").value=returnvalue;
        		  document.all("form1:itemId").value=itemId;
        		  document.all("form1:submitButton").click();
        	}
        }
        function showPerson(itemId){
       	 window.showModalDialog("/employee/title/votePersonList.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:yes;scroll:no;");
       	 return true;
       }
</script>

<x:saveState value="#{empapplyItemResultBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{empapplyItemResultBB.initItemList}"></h:inputHidden>
	<h:inputHidden id="itemId" value="#{empapplyItemResultBB.itemId}"></h:inputHidden>
	<h:inputHidden id="groups" value="#{empapplyItemResultBB.groups}"></h:inputHidden>
	<h:inputHidden id="applayId" value="#{empapplyItemResultBB.applayId}"></h:inputHidden>
	<h:commandButton style="display:none" id="submitButton" action="#{empapplyItemResultBB.selGroups}"></h:commandButton>
	<c:verbatim>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 申报管理 ->打分结果 </td>
        </tr>
    </table>
		<table height=98% width=98% align="center" >
            <tr>
            <td valign="top">
            	</c:verbatim>
            		<h:outputText value="等级："></h:outputText>
            		<h:selectOneMenu value="#{empapplyItemResultBB.templateId}" onchange="submit();" valueChangeListener="#{empapplyItemResultBB.change}">
            			<c:selectItems value="#{empapplyItemResultBB.templates}"/>
            		</h:selectOneMenu>
            		<h:outputText value="类别："></h:outputText>
            		<h:selectOneMenu value="#{empapplyItemResultBB.classType}" onchange="submit();" valueChangeListener="#{empapplyItemResultBB.change}">
            			<c:selectItems value="#{empapplyItemResultBB.classTypes}"/>
            		</h:selectOneMenu>
            		<h:outputText value="学科组："></h:outputText>
            		<h:selectOneMenu value="#{empapplyItemResultBB.majorClass}" onchange="submit();" valueChangeListener="#{empapplyItemResultBB.change}">
            			<c:selectItems value="#{empapplyItemResultBB.majorClasses}"/>
            		</h:selectOneMenu>
            	<c:verbatim>
            </td>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="1">
			             <h:panelGroup>
			                <h:outputText value="记录数:#{empapplyItemResultBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="页数:#{empapplyItemResultBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="每页有#{empapplyItemResultBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="当前为第#{empapplyItemResultBB.mypage.currentPage}页"></h:outputText>
			           		<h:commandButton value="首页" action="#{empapplyItemResultBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="上页" action="#{empapplyItemResultBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="下页" action="#{empapplyItemResultBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="尾页" action="#{empapplyItemResultBB.last}" styleClass="button01"></h:commandButton>
				            <h:outputText value="  "></h:outputText>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td colspan="2">
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				<table class='table02' align='center' id='dateList' width="100%">
				
				<%
				   TitleContentSetUCC setUcc=(TitleContentSetUCC)SysContext.getBean("titleContentSetUcc");
				   EmpTitleApplyUcc applyUcc=(EmpTitleApplyUcc)SysContext.getBean("empTitleApplayUcc");
					List resultList=(List)session.getAttribute("resultList"); 
					List dirList=(List)session.getAttribute("dirList"); 
					if(dirList!=null&&dirList.size()>0){
						out.println("<tr>");
						out.println("<td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>");
						out.println("姓名");
						out.println("</td>");
						out.println("<td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>");
						out.println("类别");
						out.println("</td>");
						out.println("<td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>");
						out.println("学科");
						out.println("</td>");
						for(int i=0;i<dirList.size();i++){
							EmpTitleTempDirBO dirbo=(EmpTitleTempDirBO)dirList.get(i);
							out.println("<td class='locked_top td_fixtop' colspan='2' valign='center' align='center'>");
							out.println(dirbo.getDirName());
							out.println("</td>");
						}
						out.println("<td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>");
						out.println("总分");
						out.println("</td>");
						out.println("<td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>");
						out.println("操作");
						out.println("</td>");
						out.println("</tr>");
						out.println("<tr>");
						for(int i=0;i<dirList.size();i++){
							EmpTitleTempDirBO dirbo=(EmpTitleTempDirBO)dirList.get(i);
							out.println("<td class='locked_top td_fixtop' valign='center' align='center'>");
							out.println("得分");
							out.println("</td>");
							out.println("<td class='locked_top td_fixtop' valign='center' align='center'>");
							out.println("参考分");
							out.println("</td>");
						}
						out.println("</tr>");
						if(resultList!=null&&resultList.size()>0){
							for(int i=0;i<resultList.size();i++){
								out.println("<tr>");
								EmpTitleApplyScoreSortBO sort=(EmpTitleApplyScoreSortBO)resultList.get(i);
								EmpTitleApplayItemBO itembo=applyUcc.findEmpTitleApplayItemBOById(sort.getItemId());
								out.println("<td class='td_middle_center'>");
								out.println(SysCacheTool.findPersonById(itembo.getPersonId()).getName());
								out.println("</td>");
								out.println("<td class='td_middle_center'>");
								out.println(itembo.getClassTypeDes());
								out.println("</td>");
								out.println("<td class='td_middle_center'>");
								out.println(CodeUtil.interpertCode(itembo.getMajorClass()));
								out.println("</td>");
								for(int j=0;j<dirList.size();j++){
									out.println("<td class='td_middle_center'>");
									out.println(sort.getV(j));
									out.println("</td>");
									out.println("<td class='td_middle_center'>");
									out.println(sort.getC(j));
									out.println("</td>");
								}
								out.println("<td class='td_middle_center'>");
								out.println(sort.getTotal());
								out.println("</td>");
								out.println("<td class='td_middle_center'>");
								out.println("<input type='button' class='button01' value='选择评审团' onclick=\"selGroup('"+sort.getItemId()+"')\"/>");
								out.println("<input type='button' class='button01' value='投票人员' onclick=\"showPerson('"+sort.getItemId()+"')\"/>");
								out.println("</td>");
								out.println("</tr>");
							}
						}
					}
					
				%>
				</table>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
