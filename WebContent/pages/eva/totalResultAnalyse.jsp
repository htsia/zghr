<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.eva.ucc.impl.EvaTaskEstimateUcc"%>
<%@ page import="com.hr319wg.eva.ucc.impl.jobEstimateUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.eva.pojo.bo.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaScoreUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaObjectsUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaPlanUCC"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.*"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script>
   function exportCvs(){
		window.open("/pages/eva/totalResultAnalyseExcel.jsp", "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:yes;scroll:yes;");
	    return true;
	}
</script>

<x:saveState value="#{evatotalresultAnalyseBB}"></x:saveState>
<h:form id="form1">

	<h:inputHidden value="#{evatotalresultAnalyseBB.initPlanList}"></h:inputHidden>
	<h:inputHidden id="superID" value="#{evatotalresultAnalyseBB.superId}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				
				</c:verbatim> <h:panelGrid align="left">
					<h:panelGroup>
						<h:outputText value="当前机构:"></h:outputText>
						<h:outputText value="#{evatotalresultAnalyseBB.superName}"></h:outputText>
					</h:panelGroup>
				</h:panelGrid> 
				 <h:panelGrid align="right" columns="2">
					<h:panelGroup>
						<h:outputText value="记录数:#{evatotalresultAnalyseBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="页数:#{evatotalresultAnalyseBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="每页有#{evatotalresultAnalyseBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="当前为第#{evatotalresultAnalyseBB.mypage.currentPage}页"></h:outputText>
						<h:commandButton value="首页"
							action="#{evatotalresultAnalyseBB.first}" styleClass="button01"></h:commandButton>
						<h:commandButton value="上页"
							action="#{evatotalresultAnalyseBB.pre}" styleClass="button01"></h:commandButton>
						<h:commandButton value="下页"
							action="#{evatotalresultAnalyseBB.next}" styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页"
							action="#{evatotalresultAnalyseBB.last}" styleClass="button01"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> 
				<c:verbatim></td>
			</tr>
			<tr>
				<td align="center">
				
				<table width=98% align="center">
	<tr>
		<td align="center"><span
			style="font-size: 18px; font-weight: bold;"></span></td>
		<td></td>
	</tr>
	<tr>
		<td height=8 colspan=2 align="right"><input name="b1" type="button" class="button01" value="导出到Excel" onclick="exportCvs()"> </td>
	</tr>
	<tr>
		<td colspan=2 valign="top">
		<div style='width:100%;height:500px;overflow:auto' id=datatable>
		<table class="table02"  align="center" id="dateList" width="100%">
			<%
				String firstMode = (String) session.getAttribute("firstMode");
				String firstPlanId=(String)session.getAttribute("firstPlanId");
				EvaObjectsUCC objectucc = null;
				EvaScoreUCC scoreucc = null;
				EvaPlanUCC planucc = null;
				EvaTaskEstimateUcc taskucc=null;
				jobEstimateUCC jobucc=null;
				List objList = (ArrayList) session.getAttribute("objectList");
				List planList = (ArrayList) session.getAttribute("planList");
				Hashtable ht=(Hashtable)session.getAttribute("planHash");
				Hashtable typeHash=(Hashtable)session.getAttribute("typeHash");
				EvaPlanBO planbo=(EvaPlanBO)session.getAttribute("firstPlan");
				try {
					objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
					scoreucc = (EvaScoreUCC) SysContext.getBean("eva_scoreUCC");
					planucc = (EvaPlanUCC) SysContext.getBean("eva_planUCC");
					taskucc=(EvaTaskEstimateUcc) SysContext.getBean("eva_taskucc");
					jobucc=(jobEstimateUCC) SysContext.getBean("eva_jobestimateucc");
				} catch (Exception e) {
				}
			%>
			<%
			    if(planList!=null&&planList.size()>0&&firstMode!=null&&!firstMode.equals("")){
			    	out.println("<tr>");
		    		out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' rowspan='2'>");
					out.println("部门");
					out.println("</td>");
		    		out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' rowspan='2'>");
					out.println("姓名");
					out.println("</td>");
					for(int i=0;i<planList.size();i++){
						EvaPlanBO plbo=(EvaPlanBO)planList.get(i);
						List codeList=(ArrayList)typeHash.get(plbo.getPlanId());
						if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)){
							out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' colspan='"+String.valueOf(codeList.size())+"'>");
							out.println(plbo.getPlanName());
							out.println("</td>");
						}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_POST)){
							out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' rowspan='2'>");
							out.println("岗位职责考核得分");
							out.println("</td>");
						}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TASK)){
							out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' rowspan='2'>");
							out.println("任务考核得分");
							out.println("</td>");
						}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)){
							out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' colspan='"+String.valueOf(codeList.size())+"'>");
							out.println(plbo.getPlanName());
							out.println("</td>");
						}
					}
					out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' rowspan='2'>");
					out.println("总分");
					out.println("</td>");
					out.println("</tr>");
					out.println("<tr>");
					for(int i=0;i<planList.size();i++){
						EvaPlanBO plbo=(EvaPlanBO)planList.get(i);
						List codeList=(ArrayList)typeHash.get(plbo.getPlanId());
						if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)||plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)){
							for(int m=0;m<codeList.size();m++){
								CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(m));
								out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center'>");
								out.println(codeItem.getItemName());
								out.println("</td>");
							}
						}
					}
		    		out.println("</tr>");
			    	if(firstMode.equals(EvaPlanBO.EVA_MODEL_ELECTION)||firstMode.equals(EvaPlanBO.EVA_MODEL_TABLE)){
			    		if(objList!=null&&objList.size()>0){
			    			for(int i=0;i<objList.size();i++){
			    				out.println("<tr>");
			    				EvaObjectsBO obj=(EvaObjectsBO)objList.get(i);
			    				PersonBO pbo=SysCacheTool.findPersonById(obj.getPersonID());
			    				out.println("<td class='td_middle'>");
			    				out.println(SysCacheTool.findOrgById(pbo.getDeptId()).getName());
			    				out.println("</td>");
			    				out.println("<td class='td_middle'>");
			    				out.println(pbo.getName());
			    				out.println("</td>");
			    				for(int j=0;j<planList.size();j++){
			    					EvaPlanBO plbo=(EvaPlanBO)planList.get(j);
			    					EvaPlanMixBO mixbo=(EvaPlanMixBO)ht.get(plbo.getPlanId());
			    					List codeList=(ArrayList)typeHash.get(plbo.getPlanId());
			    					
			    					int per = 0;
			    				    String pers = plbo.getScorePers();
			    					if (pers != null && !pers.equals("")) {
			    						per = Integer.parseInt(pers);
			    					} else {
			    						per = 2;
			    					}
			    					NumberFormat nf = NumberFormat.getInstance();
			    					nf.setMaximumFractionDigits(per);
			    					
			    					if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)){
			    						EvaObjectsBO obj2=objectucc.getEvaObjectsBOByPlanIdAndPersonId(plbo.getPlanId(),obj.getPersonID());
										for(int m=0;m<codeList.size();m++){
											CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(m));
											double score=0;
											List masterList=objectucc.getMastersByMasterType(obj2.getObjectID(),codeItem.getItemId());
											if(masterList!=null&&masterList.size()>0){
												for(int n=0;n<masterList.size();n++){
													EvaMasterBO bo=(EvaMasterBO)masterList.get(n);
													if(bo.getScore()!=null&&!bo.getScore().equals("")&&bo.getPurview()!=null&&!bo.getPurview().equals("")){
														score+=Double.parseDouble(bo.getScore())*Double.parseDouble(bo.getPurview())/100;
													}
												}
												out.println("<td class='td_middle'>");
												out.println(nf.format(score*Double.parseDouble(mixbo.getPurview())/100));
												out.println("</td>");
											}
										}
			    					}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_POST)){
			    						out.println("<td class='td_middle'>");
			    						EvaJobEstimateBO bo=jobucc.findSelfJobEstimateBO(plbo.getPlanId(),obj.getPersonID());
			    						if(bo!=null&&bo.getScore()!=null){
					    					out.println(bo.getScore());
			    						}else{
			    							out.println("");
			    						}
					    				out.println("</td>");
			    					}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TASK)){
			    						out.println("<td class='td_middle'>");
			    						EvaTaskMasterBO bo=taskucc.findEvaTaskMasterBOByPid(plbo.getPlanId(),obj.getPersonID());
			    						if(bo!=null&&bo.getScore()!=null){
					    					out.println(bo.getScore());
			    						}else{
			    							out.println("");
			    						}
					    				out.println("</td>");
			    					}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)){
					    				EvaObjectsBO bo=objectucc.getEvaObjectsBOByPlanIdAndPersonId(plbo.getPlanId(),obj.getPersonID());
					    				EvaSelectionResultSetBO setbo=objectucc.getEvaSelectionResultSetBOForResult(plbo.getPlanId());
					    				for(int m=0;m<codeList.size();m++){
					    					CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(m));
					    					if(setbo!=null){
												EvaSelectionResultItemBO itembo=objectucc.findEvaSelectionResultItemBO(setbo.getSetId(),bo.getObjectID(),codeItem.getItemId());
												if(itembo!=null){
													out.println("<td id='locked' class='td_middle' valign='center' align='left'>");
													out.println(nf.format(Double.parseDouble(itembo.getCaclScore())*Double.parseDouble(mixbo.getPurview())/100));
													out.println("</td>");
												}else{
													out.println("<td id='locked' class='td_middle' valign='center' align='left'>");
													out.println("");
													out.println("</td>");
												}
					    					}else{
					    						out.println("<td id='locked' class='td_middle' valign='center' align='left'>");
												out.println("");
												out.println("</td>");
					    					}
										}
			    					}
			    				}
			    				out.println("<td class='td_middle'>");
				    			out.println(CommonFuns.filterNull(obj.getSumScore()));
				    			out.println("</td>");
				    			out.println("</tr>");
			    			}
			    			
			    		}
			    	}else if(firstMode.equals(EvaPlanBO.EVA_MODEL_POST)){
			    		if(objList!=null&&objList.size()>0){
			    			for(int i=0;i<objList.size();i++){
			    				out.println("<tr>");
			    				EvaJobEstimateBO obj=(EvaJobEstimateBO)objList.get(i);
			    				PersonBO pbo=SysCacheTool.findPersonById(obj.getPersonID());
			    				out.println("<td class='td_middle'>");
			    				out.println(SysCacheTool.findOrgById(pbo.getDeptId()).getName());
			    				out.println("</td>");
			    				out.println("<td class='td_middle'>");
			    				out.println(pbo.getName());
			    				out.println("</td>");
			    				for(int j=0;j<planList.size();j++){
			    					EvaPlanBO plbo=(EvaPlanBO)planList.get(j);
			    					EvaPlanMixBO mixbo=(EvaPlanMixBO)ht.get(plbo.getPlanId());
			    					List codeList=(ArrayList)typeHash.get(plbo.getPlanId());
			    					
			    					int per = 0;
			    				    String pers = plbo.getScorePers();
			    					if (pers != null && !pers.equals("")) {
			    						per = Integer.parseInt(pers);
			    					} else {
			    						per = 2;
			    					}
			    					NumberFormat nf = NumberFormat.getInstance();
			    					nf.setMaximumFractionDigits(per);
			    					
			    					if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)){
			    						EvaObjectsBO obj2=objectucc.getEvaObjectsBOByPlanIdAndPersonId(plbo.getPlanId(),obj.getPersonID());
										for(int m=0;m<codeList.size();m++){
											CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(m));
											double score=0;
											List masterList=objectucc.getMastersByMasterType(obj2.getObjectID(),codeItem.getItemId());
											if(masterList!=null&&masterList.size()>0){
												for(int n=0;n<masterList.size();n++){
													EvaMasterBO bo=(EvaMasterBO)masterList.get(n);
													double score1=
													score+=Double.parseDouble(bo.getScore())*Double.parseDouble(bo.getPurview())/100;
												}
												out.println("<td id='locked' class='td_middle' valign='center' align='center'>");
												out.println(nf.format(score*Double.parseDouble(mixbo.getPurview())/100));
												out.println("</td>");
											}
										}
			    					}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_POST)){
			    						out.println("<td class='td_middle'>");
			    						EvaJobEstimateBO bo=jobucc.findSelfJobEstimateBO(plbo.getPlanId(),obj.getPersonID());
			    						if(bo!=null&&bo.getScore()!=null){
					    					out.println(bo.getScore());
			    						}else{
			    							out.println("");
			    						}
					    				out.println("</td>");
			    					}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TASK)){
			    						out.println("<td class='td_middle'>");
			    						EvaTaskMasterBO bo=taskucc.findEvaTaskMasterBOByPid(plbo.getPlanId(),obj.getPersonID());
			    						if(bo!=null&&bo.getScore()!=null){
					    					out.println(bo.getScore());
			    						}else{
			    							out.println("");
			    						}
					    				out.println("</td>");
			    					}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)){
			    						EvaObjectsBO bo=objectucc.getEvaObjectsBOByPlanIdAndPersonId(plbo.getPlanId(),obj.getPersonID());
					    				EvaSelectionResultSetBO setbo=objectucc.getEvaSelectionResultSetBOForResult(plbo.getPlanId());
					    				for(int m=0;m<codeList.size();m++){
					    					CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(m));
											EvaSelectionResultItemBO itembo=objectucc.findEvaSelectionResultItemBO(setbo.getSetId(),bo.getObjectID(),codeItem.getItemId());
											out.println("<td id='locked' class='td_middle' valign='center' align='left'>");
											out.println(nf.format(Double.parseDouble(itembo.getCaclScore())*Double.parseDouble(mixbo.getPurview())/100));
											out.println("</td>");
										}
			    					}
			    				}
			    				out.println("<td class='td_middle'>");
				    			out.println(CommonFuns.filterNull(obj.getSumScore()));
				    			out.println("</td>");
				    			out.println("</tr>");
			    			}
			    		}
			    	}else if(firstMode.equals(EvaPlanBO.EVA_MODEL_TASK)){
			    		if(objList!=null&&objList.size()>0){
			    			for(int i=0;i<objList.size();i++){
			    				out.println("<tr>");
			    				EvaTaskMasterBO obj=(EvaTaskMasterBO)objList.get(i);
			    				PersonBO pbo=SysCacheTool.findPersonById(obj.getPersonId());
			    				out.println("<td class='td_middle'>");
			    				out.println(SysCacheTool.findOrgById(pbo.getDeptId()).getName());
			    				out.println("</td>");
			    				out.println("<td class='td_middle'>");
			    				out.println(pbo.getName());
			    				out.println("</td>");
			    				for(int j=0;j<planList.size();j++){
			    					EvaPlanBO plbo=(EvaPlanBO)planList.get(j);
			    					EvaPlanMixBO mixbo=(EvaPlanMixBO)ht.get(plbo.getPlanId());
			    					List codeList=(ArrayList)typeHash.get(plbo.getPlanId());
			    					
			    					int per = 0;
			    				    String pers = plbo.getScorePers();
			    					if (pers != null && !pers.equals("")) {
			    						per = Integer.parseInt(pers);
			    					} else {
			    						per = 0;
			    					}
			    					NumberFormat nf = NumberFormat.getInstance();
			    					nf.setMaximumFractionDigits(per);
			    					
			    					if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)){
			    						EvaObjectsBO obj2=objectucc.getEvaObjectsBOByPlanIdAndPersonId(plbo.getPlanId(),obj.getPersonId());
										for(int m=0;m<codeList.size();m++){
											CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(m));
											double score=0;
											List masterList=objectucc.getMastersByMasterType(obj2.getObjectID(),codeItem.getItemId());
											if(masterList!=null&&masterList.size()>0){
												for(int n=0;n<masterList.size();n++){
													EvaMasterBO bo=(EvaMasterBO)masterList.get(n);
													score+=Double.parseDouble(bo.getScore())*Double.parseDouble(bo.getPurview())/100;
												}
												out.println("<td id='locked' class='td_middle' valign='center' align='center'>");
												out.println(nf.format(score*Double.parseDouble(mixbo.getPurview())/100));
												out.println("</td>");
											}
										}
			    					}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_POST)){
			    						out.println("<td class='td_middle'>");
			    						EvaJobEstimateBO bo=jobucc.findSelfJobEstimateBO(plbo.getPlanId(),obj.getPersonId());
			    						if(bo!=null&&bo.getScore()!=null){
					    					out.println(bo.getScore());
			    						}else{
			    							out.println("");
			    						}
					    				out.println("</td>");
			    					}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TASK)){
			    						out.println("<td class='td_middle'>");
			    						EvaTaskMasterBO bo=taskucc.findEvaTaskMasterBOByPid(plbo.getPlanId(),obj.getPersonId());
			    						if(bo!=null&&bo.getScore()!=null){
					    					out.println(bo.getScore());
			    						}else{
			    							out.println("");
			    						}
					    				out.println("</td>");
			    					}else if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)){
			    						EvaObjectsBO bo=objectucc.getEvaObjectsBOByPlanIdAndPersonId(plbo.getPlanId(),obj.getPersonId());
					    				EvaSelectionResultSetBO setbo=objectucc.getEvaSelectionResultSetBOForResult(plbo.getPlanId());
					    				for(int m=0;m<codeList.size();m++){
					    					CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(m));
											EvaSelectionResultItemBO itembo=objectucc.findEvaSelectionResultItemBO(setbo.getSetId(),bo.getObjectID(),codeItem.getItemId());
											out.println("<td id='locked' class='td_middle' valign='center' align='left'>");
											out.println(nf.format(Double.parseDouble(itembo.getCaclScore())*Double.parseDouble(mixbo.getPurview())/100));
											out.println("</td>");
										}
			    					}
			    				}
			    				out.println("<td class='td_middle'>");
				    			out.println(CommonFuns.filterNull(obj.getSumScore()));
				    			out.println("</td>");
				    			out.println("</tr>");
			    			}
			    			
			    		}
			    	}
			    }
				
			%>
		</table>
        </div>
		</td>
	</tr>
</table>
			   
				</td>
			</tr>
		</table>
		<h:inputHidden id="c" value="#{evatotalresultAnalyseBB.clear}"></h:inputHidden>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("dateList");
</script>
