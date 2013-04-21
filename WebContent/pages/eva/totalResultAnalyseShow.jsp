<%@ page import="com.hr319wg.eva.ucc.impl.EvaTaskEstimateUcc"%>
<%@ page import="com.hr319wg.eva.ucc.impl.jobEstimateUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.eva.pojo.bo.*"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@page import="java.util.*"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaScoreUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaObjectsUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaPlanUCC"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.NumberFormat"%><br>


<table width=98% align="center">
	<tr>
		<td align="center"><span
			style="font-size: 18px; font-weight: bold;"></span></td>
		<td></td>
	</tr>
	<tr>
		<td height=8 colspan=2></td>
	</tr>
	<tr>
		<td colspan=2 valign="top">
		<div style='width:100%;height:450px;overflow:auto' id=datatable>
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
						if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)){
							List codeList=scoreucc.getPersonType();
							int count=0;
							for(int m=0;m<codeList.size();m++){
								CodeItemBO codeItem=(CodeItemBO)codeList.get(m);
								boolean isHave=scoreucc.isHaveTheTypeMasterByPlanId(plbo.getPlanId(),codeItem.getItemId());
								if(isHave==true){
									count++;
								}
							}
							out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' colspan='"+String.valueOf(count)+"'>");
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
							List codeList=scoreucc.getPersonType();
							int count=0;
							for(int m=0;m<codeList.size();m++){
								CodeItemBO codeItem=(CodeItemBO)codeList.get(m);
								boolean isHave=scoreucc.isHaveTheTypeMasterByPlanId(plbo.getPlanId(),codeItem.getItemId());
								if(isHave==true){
									count++;
								}
							}
							out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' colspan='"+String.valueOf(count)+"'>");
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
						if(plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)||plbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)){
							List codeList=scoreucc.getPersonType();
							for(int m=0;m<codeList.size();m++){
								CodeItemBO codeItem=(CodeItemBO)codeList.get(m);
								boolean isHave=scoreucc.isHaveTheTypeMasterByPlanId(plbo.getPlanId(),codeItem.getItemId());
								if(isHave==true){
									out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left'>");
									out.println(codeItem.getItemName());
									out.println("</td>");
								}
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
			    						List codeList=scoreucc.getPersonType();
										for(int m=0;m<codeList.size();m++){
											CodeItemBO codeItem=(CodeItemBO)codeList.get(m);
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
			    						List codeList=scoreucc.getPersonType();
					    				EvaSelectionResultSetBO setbo=objectucc.getEvaSelectionResultSetBOForResult(plbo.getPlanId());
					    				for(int m=0;m<codeList.size();m++){
											CodeItemBO codeItem=(CodeItemBO)codeList.get(m);
											boolean isHave=scoreucc.isHaveTheTypeMasterByPlanId(plbo.getPlanId(),codeItem.getItemId());
											if(isHave==true){
												EvaSelectionResultItemBO itembo=objectucc.findEvaSelectionResultItemBO(setbo.getSetId(),bo.getObjectID(),codeItem.getItemId());
												out.println("<td id='locked' class='td_middle' valign='center' align='left'>");
												out.println(nf.format(Double.parseDouble(itembo.getCaclScore())*Double.parseDouble(mixbo.getPurview())/100));
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
			    						List codeList=scoreucc.getPersonType();
										for(int m=0;m<codeList.size();m++){
											CodeItemBO codeItem=(CodeItemBO)codeList.get(m);
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
			    						List codeList=scoreucc.getPersonType();
					    				EvaSelectionResultSetBO setbo=objectucc.getEvaSelectionResultSetBOForResult(plbo.getPlanId());
					    				for(int m=0;m<codeList.size();m++){
											CodeItemBO codeItem=(CodeItemBO)codeList.get(m);
											boolean isHave=scoreucc.isHaveTheTypeMasterByPlanId(plbo.getPlanId(),codeItem.getItemId());
											if(isHave==true){
												EvaSelectionResultItemBO itembo=objectucc.findEvaSelectionResultItemBO(setbo.getSetId(),bo.getObjectID(),codeItem.getItemId());
												out.println("<td id='locked' class='td_middle' valign='center' align='left'>");
												out.println(nf.format(Double.parseDouble(itembo.getCaclScore())*Double.parseDouble(mixbo.getPurview())/100));
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
			    						List codeList=scoreucc.getPersonType();
										for(int m=0;m<codeList.size();m++){
											CodeItemBO codeItem=(CodeItemBO)codeList.get(m);
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
			    						List codeList=scoreucc.getPersonType();
					    				EvaSelectionResultSetBO setbo=objectucc.getEvaSelectionResultSetBOForResult(plbo.getPlanId());
					    				for(int m=0;m<codeList.size();m++){
											CodeItemBO codeItem=(CodeItemBO)codeList.get(m);
											boolean isHave=scoreucc.isHaveTheTypeMasterByPlanId(plbo.getPlanId(),codeItem.getItemId());
											if(isHave==true){
												EvaSelectionResultItemBO itembo=objectucc.findEvaSelectionResultItemBO(setbo.getSetId(),bo.getObjectID(),codeItem.getItemId());
												out.println("<td id='locked' class='td_middle' valign='center' align='left'>");
												out.println(nf.format(Double.parseDouble(itembo.getCaclScore())*Double.parseDouble(mixbo.getPurview())/100));
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
			    	}
			    }
				
			%>
		</table>
        </div>
		</td>
	</tr>
</table>
<script type="text/javascript">
    setDataTableOver("dateList");
</script>
