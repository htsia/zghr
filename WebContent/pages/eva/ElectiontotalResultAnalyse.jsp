<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.eva.pojo.bo.*"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@page import="com.hr319wg.emp.pojo.bo.EmpTeamInfoBo"%>
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
<%@page import="com.hr319wg.emp.ucc.impl.teamManagerImpl"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.NumberFormat"%><br>
<script>
function exportToExcel() {
    try {
        var range = document.body.createTextRange();
        range.moveToElementText(dateList);
        range.execCommand('Copy');
        excel = new ActiveXObject('Excel.Application');
        excel.Application.Visible = true;
        book = excel.Workbooks.Add;
        sheet = book.Worksheets.Add;
        sheet.Paste;
    } catch(e) {
        alert("您的电脑可能没有安装Microsoft Excel软件，或者没有将本站点设为信任站点。");
        return false;
    }
}
</script>

<table width=98% align="center">
	<tr>
		<td align="center"><span
			style="font-size: 18px; font-weight: bold;"></span></td>
		<td></td>
	</tr>
	<tr>
		<td height=8 colspan=2 align="right"><input name="b1" type="button" class="button01" value="导出到Excel" onclick="exportToExcel()"> </td>
	</tr>
	<tr>
		<td colspan=2 valign="top">
		<div style='width:100%;height:450px;overflow:auto' id=datatable>
		<table class="table02"  align="center" id="dateList" width="100%">
			<%
				String planId = (String) session.getAttribute("planId");
				String setId=(String)session.getAttribute("setId");
				String objectType=(String)session.getAttribute("objectType");
				EvaObjectsUCC objectucc = null;
				EvaScoreUCC scoreucc = null;
				EvaPlanUCC planucc = null;
				teamManagerImpl teamucc=null;
				List objList = (ArrayList) session.getAttribute("objectList");
				List gradeList = (ArrayList) session.getAttribute("gradeList");
				try {
					objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
					scoreucc = (EvaScoreUCC) SysContext.getBean("eva_scoreUCC");
					planucc = (EvaPlanUCC) SysContext.getBean("eva_planUCC");
					teamucc=(teamManagerImpl)SysContext.getBean("teamucc");
				} catch (Exception e) {
				}
			%>
			<%	
				if(planId!=null&&!planId.equals("")&&gradeList!=null&&gradeList.size()>0){
					EvaPlanBO plo=planucc.findPlanById(planId);
					NumberFormat nf = NumberFormat.getInstance();
					if (plo.getScorePers() != null && !plo.getScorePers().equals("")) {
						int intPers = Integer.parseInt(plo.getScorePers());
						nf.setMaximumFractionDigits(intPers);
					} else {
						nf.setMaximumFractionDigits(2);
					}
					if(objList!=null&&objList.size()>0){
						List codeList=scoreucc.getThePersonTypeByPlanId(planId);
					    EvaSelectionResultSetBO bo=objectucc.findEvaSelectionResultSetBO(setId);
						out.println("<tr>");
						if(objectType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)||objectType.equals(EvaPlanBO.OBJCT_TYPE_DEPT)){
				    		out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left' rowspan='2'>");
							out.println("部门");
							out.println("</td>");
						}else{
							out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left' rowspan='2'>");
							out.println("团队");
							out.println("</td>");
						}
						if(objectType.equals(EvaPlanBO.EVA_PRUVIEW_PERSON)){
				    		out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left' rowspan='2'>");
							out.println("姓名");
							out.println("</td>");
						}
						if(codeList!=null&&codeList.size()>0){
							for(int i=0;i<codeList.size();i++){
								CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(i));
								int count = gradeList.size() > 0 ? gradeList.size() + 2 : 2;
								if(codeItem.getItemStatus().equals("1")){
									out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' colspan='"+ String.valueOf(count) + "'>");
									out.println(codeItem.getItemName());
									out.println("</td>");
								}
							}
						}
						out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left' rowspan='2'>");
						out.println("总分");
						out.println("</td>");
					    out.println("</tr>");
					    out.println("<tr>");
					    if(codeList!=null&&codeList.size()>0){
							for(int i=0;i<codeList.size();i++){
								CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(i));
								if(codeItem.getItemStatus().equals("1")){
									if (gradeList != null && gradeList.size() > 0) {
										for (int j = 0; j < gradeList.size(); j++) {
											EvaGradeItemBO itembo = new EvaGradeItemBO();
											itembo = (EvaGradeItemBO) gradeList.get(j);
											out.println("<td id='locked' class='locked_top td_fixtop'>");
											out.println(itembo.getItemName());
											out.println("</td>");
										}
										out.println("<td id='locked' class='locked_top td_fixtop'>");
										out.println("总数");
										out.println("</td>");
										out.println("<td id='locked' class='locked_top td_fixtop'>");
										out.println(bo.getSetName());
										out.println("</td>");
									}
								}
							}
					    }
					    out.println("</tr>");
					    if(objList!=null&&objList.size()>0){
					    	String objIds="'1'";
					    	for(int i=0;i<objList.size();i++){
					    		EvaObjectsBO obj=(EvaObjectsBO)objList.get(i);
					    		objIds+=",'"+obj.getObjectID()+"'";
					    	}
					    	Hashtable ht=objectucc.findEvaSelectionResultItemBOByObjectIds(objIds);
					    	for(int i=0;i<objList.size();i++){
					    		out.println("<tr>");
					    		EvaObjectsBO obj=(EvaObjectsBO)objList.get(i);
					    		if(objectType.equals(EvaPlanBO.EVA_PRUVIEW_PERSON)){
				    				PersonBO pbo=SysCacheTool.findPersonById(obj.getPersonID());
				    				out.println("<td class='td_middle_left'>");
				    				out.println(SysCacheTool.findOrgById(pbo.getDeptId()).getName());
				    				out.println("</td>");
				    				out.println("<td class='td_middle_left'>");
				    				out.println(pbo.getName());
				    				out.println("</td>");
					    		}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_DEPT)){
					    			OrgBO org=SysCacheTool.findOrgById(obj.getPersonID());
					    			out.println("<td class='td_middle_left'>");
				    				out.println(org.getName());
				    				out.println("</td>");
					    		}else if(objectType.equals(EvaPlanBO.OBJCT_TYPE_TEAM)){
					    			out.println("<td class='td_middle_left'>");
				    				out.println(teamucc.findEmpTeamInfoBoById(obj.getPersonID()).getTeamName());
				    				out.println("</td>");
					    		}
			    				double caclScore=0;
			    				for(int j=0;j<codeList.size();j++){
			    					CodeItemBO codeItem=SysCacheTool.findCodeItem("",(String)codeList.get(j));
			    					if(codeItem.getItemStatus().equals("1")){
			    						List masterList=objectucc.getMastersByMasterType(obj.getObjectID(),codeItem.getItemId());
			    						EvaSelectionResultItemBO itembo1=(EvaSelectionResultItemBO)ht.get(setId+obj.getObjectID()+codeItem.getItemId());
			    						if(itembo1!=null&&itembo1.getCaclScore()!=null&&!itembo1.getCaclScore().equals("")){
			    							caclScore+=Double.parseDouble(itembo1.getCaclScore());
			    						}
										if (gradeList != null && gradeList.size() > 0) {
											for (int m = 0; m < gradeList.size(); m++) {
												EvaGradeItemBO itembo = new EvaGradeItemBO();
												itembo = (EvaGradeItemBO) gradeList.get(m);
												int count=0;
												for(int n=0;n<masterList.size();n++){
													EvaMasterBO mbo=(EvaMasterBO)masterList.get(n);
													if(mbo.getGradeId()!=null&&mbo.getGradeId().equals(itembo.getItemID())){
														count++;
													}
												}
												out.println("<td id='locked' class='td_middle_left'>");
												out.println(String.valueOf(count));
												out.println("</td>");
											}
											out.println("<td id='locked' class='td_middle_left'>");
											out.println(masterList.size());
											out.println("</td>");
											out.println("<td id='locked' class='td_middle_left'>");
											if(itembo1!=null&&itembo1.getCaclPers()!=null&&!itembo1.getCaclPers().equals("")){
												out.println(itembo1.getCaclPers()+"%");
											}else{
												out.println("");
											}
											out.println("</td>");
										}
									}
			    				}
			    				out.println("<td class='td_middle_left'>");
				    			out.println(nf.format(caclScore));
				    			out.println("</td>");
				    			out.println("</tr>");
					    	}
					    }
					}
				}
			session.removeAttribute("planId");
			session.removeAttribute("setId");
			session.removeAttribute("objectType");
			session.removeAttribute("objectList");
			session.removeAttribute("gradeList");
			%>
		</table>
        </div>
		</td>
	</tr>
</table>
<script type="text/javascript">
    setDataTableOver("dateList");
</script>
