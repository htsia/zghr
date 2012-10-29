<%@ page import="com.hr319wg.title.ucc.impl.TitleContentSetUCC" %>
<%@ page import="com.hr319wg.title.ucc.impl.EmpTitleApplyUcc" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.title.pojo.bo.*" %>
<%@ page import="com.hr319wg.title.uitl.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>

<html>
  <head>
     <link href="/css/style.css" rel="stylesheet" type="text/css"/>
     <script type="text/javascript">
     	function checkValue(itemId,hi,low){
     		var resultHi=parseFloat(hi);
     		var resultLow=parseFloat(low);
     		var reg=/^\d+(\.\d+)?$/;
     		var score=document.getElementById(itemId).value;
     		if(reg.test(score)){
     			var scoreValue=parseFloat(score);
	         	if(scoreValue<resultLow||scoreValue>resultHi){
	             	alert("请在打分区间（"+low+"-"+hi+"）内打分");
	             	document.getElementById(itemId).value="";
	             	document.getElementById(itemId).focus();
	         	}
     		}else{
         		alert("请输入数字");
         		document.getElementById(itemId).value="";
             	document.getElementById(itemId).focus();
     		}
     	}
     </script>
  </head>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<body BGCOLOR=<%=Constants.BGCOLOR%>>
<form action="deptAuditShow.jsp" method="post">
	<%
	   TitleContentSetUCC setUcc=(TitleContentSetUCC)SysContext.getBean("titleContentSetUcc");
	   EmpTitleApplyUcc applyUcc=(EmpTitleApplyUcc)SysContext.getBean("empTitleApplayUcc");
       String scoreId = request.getParameter("scoreId");
       String scoreId1=request.getParameter("scoreId1");
       if(scoreId1!=null&&!scoreId1.equals("")){
    	   List list=applyUcc.getAllEmpTitleScoreItemBOByScoreId(scoreId1);
    	   if(list!=null&&list.size()>0){
    		   for(int i=0;i<list.size();i++){
    			   EmpTitleScoreItemBO bo=(EmpTitleScoreItemBO)list.get(i);
    			   String value=request.getParameter(bo.getScoreItemId());
    			   if(value!=null&&!value.equals("")){
    				   bo.setScore(value);
    				   applyUcc.saveEmpTitleScoreItemBO(bo); 
    			   }
    		   }
    	   }
       }
       System.out.println(scoreId+"====="+scoreId);
       List rowList=applyUcc.getAllEmpTitleScoreItemBOByScoreId(scoreId);
   %>
   
              <input type="hidden" name="scoreId1" value="<%=scoreId%>" />
              <input type="hidden" name="scoreId" value="<%=scoreId%>"/>
              <table width="100%">
              <tr><td height="30px" align="right">
              <input type="submit" value="保存" class="button01"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              </td></tr>
              </table>
              <%
              	StringBuffer buff=new StringBuffer();
				if(rowList!=null&&rowList.size()>0){
					out.println("<table class='table02'  align='center' width='100%'>");
					EmpTitleScoreItemBO vo1=(EmpTitleScoreItemBO)rowList.get(0);
					String[] fileds=vo1.getFiledIds().split(",");
					buff.append("<tr>");
					buff.append("<td class='td_top'>");
					buff.append("序号");
					buff.append("</td>");
					for(int i=0;i<fileds.length;i++){
						buff.append("<td class='td_top'>");
						buff.append(SysCacheTool.findInfoItem("",fileds[i]).getItemName());
						buff.append("</td>");
					}
					buff.append("<td class='td_top'>");
					buff.append("评分");
					buff.append("</td>");
					buff.append("</tr>");
					for(int i=0;i<rowList.size();i++){
						buff.append("<tr>");
						EmpTitleScoreItemBO vo=(EmpTitleScoreItemBO)rowList.get(i);
						EmpTitleApplyScoreBO score=applyUcc.findEmpTitleApplyScoreBOById(vo.getScoreId());
						EmpTitleTempItemBO item=setUcc.findEmpTitleTempItemBO(score.getTempItemId());
						String hi=item.getHiScore();
						String low=item.getLowScore();
						buff.append("<td class='td_middle_left'>");
						buff.append(i+1);
						buff.append("</td>");
						String[] values=vo.getFiledValues().split("<,>");
						for(int j=0;j<values.length;j++){
							buff.append("<td class='td_middle_left'>");
							if(values[j]!=null&&!values[j].equals("")&&!values[j].equals("NULL_VALUE")){
								buff.append(CodeUtil.interpertCode(FilterXMLDATA.filterXml(values[j])));
							}
							buff.append("</td>");
						}
						buff.append("<td class='td_middle_left'>");
						buff.append("<input type='text' class='input' id='"+vo.getScoreItemId()+"' name='"+vo.getScoreItemId()+"' value='"+CommonFuns.filterNull(vo.getScore())+"' onchange=\"checkValue('"+vo.getScoreItemId()+"','"+hi+"','"+low+"')\">");
						buff.append("</td>");
						buff.append("</tr>");
					}
					out.println(buff.toString());
					//System.out.println(buff.toString());
					out.println(" </table>");
				}else{
					out.println("<table align='center' width='100%' >");
					out.println("<tr><td>没有相关信息记录</td></tr>");
					out.println(" </table>");
				}
              %>
</form>
</body>
</html>