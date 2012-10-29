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
         </c:verbatim>
          <h:selectOneRadio value="#{eva_selfscorebb.showMode}" onclick="submit();" valueChangeListener="#{eva_selfscorebb.changeMode}">
        	<c:selectItem itemLabel="普通视图" itemValue="0"/>
        	<c:selectItem itemLabel="指标视图" itemValue="1" />
        </h:selectOneRadio>
          <c:verbatim>
        </td>
        <td height=8 align="right">
         </c:verbatim>
         	<h:outputText value="姓名或简称："></h:outputText>
         	<h:inputText value="#{eva_selfscorebb.queryValue}" styleClass="input" size="20"></h:inputText>
         	<h:commandButton styleClass="button01"  value="查询" action="#{eva_selfscorebb.refreshObject}"></h:commandButton>
         	<h:outputText value=" "></h:outputText>
         	<h:outputText value="#{eva_selfscorebb.gradeDes} " rendered="#{eva_selfscorebb.ifSeeReport=='0'}"></h:outputText>
         	<h:outputText value=" "></h:outputText>
         	<h:selectOneMenu id="ReportID" style="width:190px" rendered="#{eva_selfscorebb.ifSeeReport=='0'}">
                <c:selectItems value="#{eva_selfscorebb.regTableList}"/>
            </h:selectOneMenu>
            <h:outputText value=" "></h:outputText>
            <h:commandButton styleClass="button01" type="button" value="显示" onclick="showTable();" rendered="#{eva_selfscorebb.ifSeeReport=='0'}"></h:commandButton>
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
                    styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center" rendered="#{eva_selfscorebb.showMode=='0'}">
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
                      <h:commandButton value="打分" onclick="return beginInput('#{list.masterId}','#{list.objectID}')" styleClass="button01" rendered="#{eva_selfscorebb.allowMark=='1'}"></h:commandButton>
                      <h:commandButton value="显示表格" styleClass="button01" onclick="return showTable2('#{list.masterId}');" rendered="#{eva_selfscorebb.ifSeeReport=='0'}"/>
                  </h:column>
             </x:dataTable>
         <c:verbatim>
         
         <%
         String showMode=(String)session.getAttribute("showMode");
         String planId=(String)session.getAttribute("planID");
         String templateId=(String)session.getAttribute("templateId");
         String masterPid=(String)session.getAttribute("masterPid");
         List list=(ArrayList)session.getAttribute("objList");
         String[] objIds=(String[])session.getAttribute("objIds");
         Hashtable masterht=(Hashtable)session.getAttribute("ht");
         Hashtable gradeht=(Hashtable)session.getAttribute("ht2");
         EvaKeyItemUCC ucc = null;
         EvaObjectsUCC objectucc = null;
         EvaScoreUCC scoreucc = null;
         EvaPlanUCC planUcc=null;
         teamManagerImpl teamucc=null;
         EvaGradeUCC gradeUcc=null;
         try {
			ucc = (EvaKeyItemUCC) SysContext.getBean("eva_keyitemucc");
			objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
			scoreucc = (EvaScoreUCC) SysContext.getBean("eva_scoreUCC");
			planUcc=(EvaPlanUCC)SysContext.getBean("eva_planUCC");
			teamucc=(teamManagerImpl)SysContext.getBean("teamucc");
			gradeUcc=(EvaGradeUCC)SysContext.getBean("eva_gradeUCC");
		} catch (Exception e) {
			e.printStackTrace();
		}
		String objectType=(String)session.getAttribute("objectType");
		String notShowPers="0";
		EvaPlanBO pb=planUcc.findPlanById(planId);
		if(pb!=null&&pb.getNotShowPercent()!=null&&pb.getNotShowPercent().equals("1")){
			notShowPers=pb.getNotShowPercent();
		}
         if(showMode.equals("1")){
        	if(planId!=null&&!planId.equals("")&&templateId!=null&&!templateId.equals("")){
        		if(list!=null&&list.size()>0){
        			out.println("<table class='table02' align='center' id='dateList1'>");
    				out.println("<tr>");
    				if(objectType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
    					out.println("<td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>部门</td><td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>姓名</td>");
    				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_DEPT)){
    					out.println("<td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>部门</td>");
    				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_TEAM)){
    					out.println("<td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>团队</td>");
    				}
    				List itemList=ucc.getAllChildItemSet(templateId);
    				Hashtable ht=ucc.getAllChildItemForHash(templateId);
    				Hashtable ht2=ucc.getAllKeyItemBOByTemlateId(templateId);
    				Hashtable ht3=scoreucc.getEvaScoreBOByPlanIdAndPersonIdForHash(masterPid,objIds);
    				if(itemList!=null&&itemList.size()>0){ 
    					for(int j=0;j<itemList.size();j++){
    						TemplateItemSetBO bo=(TemplateItemSetBO)itemList.get(j);
    						List chileItemList=(ArrayList)ht.get(bo.getSetID());
    						if(chileItemList!=null&&chileItemList.size()>0){
    							out.println("<td class='locked_top td_fixtop' colspan='"+chileItemList.size()+"' valign='center' align='center'>"+bo.getSetName()+"</td>");
    						}
    					}
    				}
    				out.println("<td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>考核得分</td><td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>考核等级</td><td class='locked_top td_fixtop' rowspan='2' valign='center' align='center'>操作</td>");
					out.println("</tr>");
    				out.println("<tr>");
    				if(itemList!=null&&itemList.size()>0){
    					for(int j=0;j<itemList.size();j++){
    						TemplateItemSetBO bo=(TemplateItemSetBO)itemList.get(j);
    						List chileItemList=(ArrayList)ht.get(bo.getSetID());
    						if(chileItemList!=null&&chileItemList.size()>0){
    							for(int m=0;m<chileItemList.size();m++){
    								TemplateItemBO itembo = (TemplateItemBO) chileItemList.get(m);
    								EvaKeyItemBO keybo =(EvaKeyItemBO)ht2.get(itembo.getItemID());
    								if(notShowPers.equals("1")){
    									out.println("<td class='locked_top td_fixtop' >"+keybo.getItemName()+"("+itembo.getScore()+")</td>");
    								}else{
    									out.println("<td class='locked_top td_fixtop' >"+keybo.getItemName()+"("+itembo.getScore()+"%)</td>");
    								}
    							}
    						}
    					}
    				}
    				out.println("</tr>");
        			for(int i=0;i<list.size();i++){
        				out.println("<tr>");
        				EvaObjectsVO bo = (EvaObjectsVO) list.get(i);
        				EvaMasterBO mbo=(EvaMasterBO)masterht.get(bo.getObjectID());
        				if(objectType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
	        				PersonBO pbo=SysCacheTool.findPersonById(bo.getPersonID());
	        				out.println("<td class='td_middle_center'>"+SysCacheTool.findOrgById(pbo.getDeptId()).getName()+"</td>");
	        				out.println("<td class='td_middle_center'>"+pbo.getName()+"</td>");
        				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_DEPT)){
        					out.println("<td class='td_middle_center'>"+SysCacheTool.findOrgById(bo.getPersonID()).getName()+"</td>");
        				}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_TEAM)){
        					out.println("<td class='td_middle_center'>"+teamucc.findEmpTeamInfoBoById(bo.getPersonID()).getTeamName()+"</td>");
        				}
        				if(itemList!=null&&itemList.size()>0){
        					for(int j=0;j<itemList.size();j++){
        						TemplateItemSetBO tbo=(TemplateItemSetBO)itemList.get(j);
        						List chileItemList=(ArrayList)ht.get(tbo.getSetID());
        						if(chileItemList!=null&&chileItemList.size()>0){
        							for(int m=0;m<chileItemList.size();m++){
        								TemplateItemBO itembo = (TemplateItemBO) chileItemList.get(m);
        								EvaScoreBO score=(EvaScoreBO)ht3.get(bo.getObjectID()+mbo.getMasterID()+itembo.getItemID());
        								if(score!=null){
        									out.println("<td class='td_middle_center'>"+CommonFuns.filterNull(score.getScore())+"</td>");
        								}else{
        									out.println("<td class='td_middle_center'></td>");
        								}
        							}
        						}
        					}
        				}
        				String gradeName="";
        				if(mbo.getGradeId()!=null&&!mbo.getGradeId().equals("")){
        					gradeName=((EvaGradeItemBO)gradeht.get(mbo.getGradeId())).getFlagChar();
        				}
        				out.println("<td class='td_middle_center'>"+CommonFuns.filterNull(mbo.getScore())+"</td>");
        				out.println("<td class='td_middle_center'>"+CommonFuns.filterNull(gradeName)+"</td>");
        				out.println("<td class='td_middle_center'><input type='button' value='打分' class='button01' onclick='beginInput2(\""+mbo.getMasterID()+"\",\""+bo.getObjectID()+"\",\""+bo.getTemplateID()+"\")'/><input type='button' value='修改' class='button01' onclick='beginInput1(\""+mbo.getMasterID()+"\",\""+bo.getObjectID()+"\",\""+bo.getTemplateID()+"\")'/></td>");
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
        }
         %>
       </div>
        </td></tr>
        </table>
    </c:verbatim>
    
</h:form>
<script type="text/javascript">
    setDataTableOver("form1:dateList");
    setDataTableOver("dateList1");
    function beginInput1(masterid,objId,temid){
        window.showModalDialog("/eva/selfTemplateSetScore.jsf?templateID="+temid+"&masterID="+masterid+"&objectID="+objId+"&type=modify",null,"dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:yes;scroll:yes;");
        document.all('form1:refresh').click();
        return true;
    }
    function beginInput2(masterid,objId,temid){
        window.showModalDialog("/eva/selfTemplateSetScore.jsf?templateID="+temid+"&masterID="+masterid+"&objectID="+objId+"&type=add", null, "dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:yes;scroll:yes;");
        document.all('form1:refresh').click();
        return true;
    }
    function beginInput(masterid,objId){
        window.showModalDialog("/eva/selfTemplateSetScore.jsf?templateID="+document.all('form1:templateId').value+"&masterID="+masterid+"&objectID="+objId+"&type=add", null, "dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:yes;scroll:yes;");
        return true;
    }
</script>