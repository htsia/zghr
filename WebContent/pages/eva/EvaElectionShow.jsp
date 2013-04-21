<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.eva.ucc.impl.EvaKeyItemUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaScoreUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaObjectsUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaPlanUCC"%>
<%@page import="com.hr319wg.emp.ucc.impl.teamManagerImpl"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaGradeUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.eva.pojo.bo.*" %>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
     
        function subimtValue(id) {
            document.all("form1:refresh").click();
        }
    </script>
<x:saveState value="#{eva_selfscorebb}"/>
<h:form id="form1">
    <h:inputHidden id="init" value="#{eva_selfscorebb.initElection}"/>
    <h:commandButton id="refresh" value="保存" style="display:none;"  action="#{eva_selfscorebb.saveElection}"></h:commandButton>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 自助考核打分"/>
        </h:panelGroup>
    </h:panelGrid>
    
    <c:verbatim>
        <table height=97% width=98% align="center">
        <%
        	String des="";
        	if(session.getAttribute("des")!=null){
        		des=(String)session.getAttribute("des");
        	}
        %>
        <tr><td align="right"><%=des%>&nbsp;&nbsp;&nbsp;<input type="button" value="保存" class="button01" onclick="subimtValue();"/>&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
        <tr><td colspan=3 valign="top">
         
         <%
         String planId=(String)session.getAttribute("planID");
         String personId=(String)session.getAttribute("personId");
         EvaObjectsUCC objectucc = null;
         EvaScoreUCC scoreucc = null;
         EvaPlanUCC planUcc=null;
         teamManagerImpl teamucc=null;
         EvaGradeUCC gradeucc=null;
         try {
			objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
			scoreucc = (EvaScoreUCC) SysContext.getBean("eva_scoreUCC");
			planUcc=(EvaPlanUCC)SysContext.getBean("eva_planUCC");
			teamucc=(teamManagerImpl)SysContext.getBean("teamucc");
			gradeucc=(EvaGradeUCC)SysContext.getBean("eva_gradeUCC");
		} catch (Exception e) {
			e.printStackTrace();
		}
		String objectType="0";
		if(planId!=null&&!planId.equals("")){
			objectType=planUcc.findPlanById(planId).getPlanObjectType();
		}
		List list=objectucc.getMasterByMasterPlanId(planId,personId);
         if(planId!=null&&!planId.equals("")){
        		if(list!=null&&list.size()>0){
        			out.println("<table class='table03' align='center' id='dateList' width='500'>");
    				out.println("<tr>");
    				if(objectType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
    					out.println("<td class='td_top'  valign='center' align='center'>部门</td><td class='td_top'  valign='center' align='center'>姓名</td>");
    				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_DEPT)){
    					out.println("<td class='td_top'  valign='center' align='center'>部门</td>");
    				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_TEAM)){
    					out.println("<td class='td_top'  valign='center' align='center'>团队</td>");
    				}
    				out.println("<td class='td_top' valign='center' align='center'>投票</td>");
					out.println("</tr>");
    				out.println("<tr>");
    				
        			for(int i=0;i<list.size();i++){
        				out.println("<tr>");
        				EvaMasterBO mbo = (EvaMasterBO) list.get(i);
        				EvaObjectsBO obo=objectucc.findEvaObjectBOById(mbo.getObjectID());
        				if(objectType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
	        				PersonBO pbo=SysCacheTool.findPersonById(obo.getPersonID());
	        				out.println("<td class='td_middle_center'>"+SysCacheTool.findOrgById(pbo.getDeptId()).getName()+"</td>");
	        				out.println("<td class='td_middle_center'>"+pbo.getName()+"</td>");
        				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_DEPT)){
        					out.println("<td class='td_middle_center'>"+SysCacheTool.findOrgById(obo.getPersonID()).getName()+"</td>");
        				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_TEAM)){
        					out.println("<td class='td_middle_center'>"+teamucc.findEmpTeamInfoBoById(obo.getPersonID()).getTeamName()+"</td>");
        				}
        				EvaScoreBO scorebo=(EvaScoreBO)scoreucc.getAllEvaScoreBOByObjIdAndMasterId(obo.getObjectID(),mbo.getMasterID()).get(0);
        				String gradeid=planUcc.findPlanById(planId).getPlanGrade();
        				List gardeList=gradeucc.getAllGradeItem(gradeid);
        				if(gardeList!=null&&gardeList.size()>0){
        					out.println("<td class='td_middle_center'>");
        					for(int j=0;j<gardeList.size();j++){
        						EvaGradeItemBO gradebo=(EvaGradeItemBO)gardeList.get(j);
        						if(scorebo.getScore()!=null&&!scorebo.getScore().equals("")&&gradebo.getItemID().equals(scorebo.getScore())){
        							out.println(gradebo.getItemName()+"<input type='radio' name='"+scorebo.getScoreID()+"' checked='checked' value='"+gradebo.getItemID()+"'>&nbsp;&nbsp;&nbsp;&nbsp;");
        						}else{
        							out.println(gradebo.getItemName()+"<input type='radio' name='"+scorebo.getScoreID()+"' value='"+gradebo.getItemID()+"'>&nbsp;&nbsp;&nbsp;&nbsp;");
        						}
        					}
        					out.println("</td>");
        				}else{
        					out.println("<td class='td_middle_center'>计划没有选择等级</td>");
        				}
        				out.println("</tr>");
        			}
        			out.println("</table>");
        		}else{
        			if(objectType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
        				out.println("<table class='table02' align='center' id='dateList'><tr><td class='locked_top'>部门</td><td class='locked_top'>姓名</td><td class='locked_top'>选择计划和模板</td><td class='locked_top'>考核得分</td><td class='locked_top'>考核等级</td></tr></table>");
        			}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_DEPT)){
        				out.println("<table class='table02' align='center' id='dateList'><tr><td class='locked_top'>部门</td><td class='locked_top'>选择计划和模板</td><td class='locked_top'>考核得分</td><td class='locked_top'>考核等级</td></tr></table>");
        			}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_TEAM)){
        				out.println("<table class='table02' align='center' id='dateList'><tr><td class='locked_top'>团队</td><td class='locked_top'>选择计划和模板</td><td class='locked_top'>考核得分</td><td class='locked_top'>考核等级</td></tr></table>");
        			}
        		}
        	}
         %>
       
        </td></tr>
        </table>
    </c:verbatim>
    
</h:form>
