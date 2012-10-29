<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleApplyItemScoreBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         
 </script>

<x:saveState value="#{persontitleapplyBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{persontitleapplyBB.initScore}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
			<tr>
				<td>
				<%
				EmpTitleApplyItemScoreBO scorebo=(EmpTitleApplyItemScoreBO)session.getAttribute("scorebo");
				String personId=(String)session.getAttribute("personId");
				String showType=(String)session.getAttribute("showType");
				session.setAttribute("scorebo",null);
				session.setAttribute("showType",null);
				session.setAttribute("personId",null);
				if(scorebo!=null){
			        InfoSetBO info=SysCacheTool.findInfoSet(scorebo.getInfoSetId());
			        String type=scorebo.getAllowEdit();
			        String url="<iframe name='main' frameborder='0' height='100%'  width='100%' src='";
			        if(info.getSet_rsType().equals("1")){
			        	if(type.equals("1")&&showType.equals("edit")){
			        		url+="/employee/info/PersonInfoDetail.jsf?setId="+info.getSetId()+"&flag=2&fk="+personId+"&type=0&isCheckRight=false";
			        	}else{
			        		url+="/employee/info/PersonInfoDetail.jsf?setId="+info.getSetId()+"&flag=2&fk="+personId+"&type=1&isCheckRight=false";
			        	}
			        }else if(info.getSet_rsType().equals("2")){
			        	if(type.equals("1")&&showType.equals("edit")){
			        		url+="/employee/info/PersonInfoDetailList.jsf?setId="+info.getSetId()+"&flag=2&fk="+personId+"&type=0&isCheckRight=false";
			        	}else{
			        		url+="/employee/info/PersonInfoDetailList.jsf?setId="+info.getSetId()+"&flag=2&fk="+personId+"&type=1&isCheckRight=false";
			        	}
			        }
			        url+="'></iframe>";
			        out.println(url);
				}
				%>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
