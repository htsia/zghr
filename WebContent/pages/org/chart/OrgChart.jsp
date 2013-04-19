<%@page import="com.hr319wg.common.Constants"%>
<%@page import="com.hr319wg.sys.cache.SysCache"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.sys.pojo.vo.CellVO"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	String superId = request.getParameter("superId");
	String showLevel = request.getParameter("showLevel");
	boolean notShowVir = "v2".equals(request.getParameter("vGroup"));
	int expand = 1;
	if (showLevel != null && !"".equals(showLevel)) {
		expand = Integer.parseInt(showLevel);
	}
	if (expand >= 5)
		expand = 5;
	showLevel = String.valueOf(expand);
	
	String orgsHtml="";
	String orgs="";
	int max=0;
	
	OrgBO org = SysCacheTool.findOrgById(superId);
	List list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", superId);

	String name = "";
	String id = "";
	if (org != null) {
		orgsHtml+="<ul id='org'>";
		name = org.getName();
		id = org.getOrgId();
		orgsHtml+="<li><div id='"+org.getPkId()+"'><a href='javascript:void(-1);'>"+name+"</a></div>";
		//第一级_begin
		if (list != null && list.size() > 0) {
			orgsHtml+="<ul>";
			for (int i = 0; i < list.size(); i++) {
				OrgBO bo = (OrgBO) list.get(i);
				if (Constants.YES.equals(bo.getOrgCancel())) {
					continue;
				}
				if (OrgBO.VIRTUALTYPE.equals(bo.getorgType()) && notShowVir){
					continue;
				}
				String sid = bo.getOrgId();
				int len=bo.getName().length();
				max=Math.max(max, len);
				int cols=len/8+(len%8>0?1:0);
				if(cols>1){
					orgs+=bo.getPkId()+"-"+cols+",";
				}
				orgsHtml+="<li><div class='suborg' id='"+bo.getPkId()+"'><a href='javascript:void(-1);'>" + bo.getName()+"</a></div>";
				//第二级
				if (expand>1){
                    List child = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", sid);
                    if (child!=null && child.size()>0){
                    	orgsHtml+="<ul>";
                        for(int j=0;j<child.size();j++){
                             OrgBO childbo = (OrgBO)child.get(j);
                             if(Constants.YES.equals(childbo.getOrgCancel())){
                                 continue;
                             }
                             if (OrgBO.VIRTUALTYPE.equals(childbo.getorgType()) && notShowVir ) continue;
                             String csid=childbo.getOrgId();
                             len=childbo.getName().length();
                             max=Math.max(max, len);
         					 cols=len/8+(len%8>0?1:0);
         					 if(cols>1){
         						 orgs+=childbo.getPkId()+"-"+cols+",";
         					 }
                             orgsHtml+="<li><div class='suborg' id='"+childbo.getPkId()+"'><a href='javascript:void(-1);'>"+childbo.getName()+"</a></div>";
                             //第三级
                             if (expand>2){
                                 List childchild = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", csid);
                                 if (childchild!=null && childchild.size()>0){
                                     orgsHtml+="<ul>";
                                	 for(int k=0;k<childchild.size();k++){
                                         OrgBO childchildbo = (OrgBO)childchild.get(k);
                                         if(Constants.YES.equals(childchildbo.getOrgCancel())){
                                  	     	continue;
                                         }
                                         if (OrgBO.VIRTUALTYPE.equals(childchildbo.getorgType()) && notShowVir ) continue;
   	                                     String ccsid=childchildbo.getOrgId();
   	                                     len=childchildbo.getName().length();
   	                                  	 max=Math.max(max, len);
   		         					 	 cols=len/8+(len%8>0?1:0);
	   		         					 if(cols>1){
	   		         						 orgs+=childchildbo.getPkId()+"-"+cols+",";
	   		         					 }
   	                                     orgsHtml+="<li><div class='suborg' id='"+childchildbo.getPkId()+"'><a href='javascript:void(-1);'>"+childchildbo.getName()+"</a></div>";
   	                                     //第四级
   	                                     if (expand>3){
                                             List child4 = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", ccsid);
                                             if (child4!=null && child4.size()>0){
                                             	orgsHtml+="<ul>";
	                                            for(int l=0;l<child4.size();l++){
		                                            OrgBO child4bo = (OrgBO)child4.get(l);
		                                            if(Constants.YES.equals(child4bo.getOrgCancel())){
		                                            	continue;
		                                            }
		                                            if (OrgBO.VIRTUALTYPE.equals(child4bo.getorgType()) && notShowVir ) continue;
			   	                                     len=child4bo.getName().length();
			   	                                  	 max=Math.max(max, len);
			   		         					 	 cols=len/8+(len%8>0?1:0);
				   		         					 if(cols>1){
				   		         						 orgs+=child4bo.getPkId()+"-"+cols+",";
				   		         					 }			                                            
		                                            	orgsHtml+="<li><div class='suborg' id='"+child4bo.getPkId()+"'><a href='javascript:void(-1);'>"+child4bo.getName()+"</a></div></li>";
		                                            }
                                                }
                                                orgsHtml+="</ul>";
                                           }// 显示第4级_end
   	                                     orgsHtml+="</li>";
                                      }
                                	  orgsHtml+="</ul>";
                                  }
                             }//显示三级_end
		                    orgsHtml+="</li>";
                        }
                        orgsHtml+="</ul>";
                    }
            	}
                orgsHtml+="</li>";
			}
			orgsHtml+="</ul>";
		}//第一级_end
		orgsHtml+="</li></ul>";
	}
%>

<link rel="stylesheet" href="/css/jquery.jOrgChart.css"/>
	<style>
		body, html, div, p, span, a, h1, h2, h3, h4, h5{
		margin 				: 0;
		padding 			: 0;
		background-color: aliceblue;
	}
	
	body, html{	
		width 				: 100%;
	}
	
	body{
		font-family 		: tahoma;
		font-weight 		: lighter;
		padding-top 		: 40px;
	}
	
		body p{
			font-size 		: 14px;
		}
		
			body p a{
				font-size	: 16px;
			}
	
	h1 {
		color 				: #E05E00;	
		font-style 			: italic;
	}
	
	a{
		color 				: #E05E00;	
		text-decoration		: none;
	}
	
	a:hover{
		text-decoration		: underline;
	}
	
	/* general */
	.clear {
		clear: both;
	}
	
	/* Header */
	.brand{
		color 				: #E05E00 !important;	
		font-family 		: georgia;
		font-style 			: italic;
	}
	
	/* list stuff */
	#org{
		margin 				: 10px;
		padding 			: 10px;
	}
	
	#show-list{
		cursor 				: pointer;
	}
	
	/* bootstrap overrides */
	.alert-message{
		margin: 2px 0;
	}
	
	.topbar{
		position 			: absolute;
	}
	
	/* Custom chart styling */
	.jOrgChart {
	
	}
	
	/* Custom node styling */
	.jOrgChart .node {
		font-size 			: 13px;
		border-radius 		: 8px;
		border 				: 1px solid blue;
		color 				: black;
		-moz-border-radius 	: 8px;
		width: 20px;
		height: 120px;
		padding-top: 3px;
		align:left;
		word-wrap:break-word;
	}
	.node p{
		font-family 	: tahoma;
		font-size 		: 10px;
		line-height 	: 11px;
		padding 		: 2px;
	}
	
	.subnode{
		border:1px solid red;
	}
</style>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
    
    <script type="text/javascript" src="/js/jquery-1.4.4.min.js"></script>
    <script src="/js/jquery.jOrgChart.js"></script>

	<form action="/pages/org/chart/OrgChart.jsp">
		<table width="98%" border="0" cellspacing="0" cellpadding="0"
			id="control" align="center">
			<tr valign="top">
				<td align="left"><strong>显示虚拟组织</strong> <INPUT id="v1" value="v1" type="radio" name="vGroup"
					<%if ("v2".equals(request.getParameter("vGroup")))
				out.print("");
			else
				out.print("checked");%>>是<INPUT
					id="v2" value="v2" type="radio" name="vGroup"
					<%if (!"v2".equals(request.getParameter("vGroup")))
				out.print("");
			else
				out.print("checked");%>>否&nbsp;&nbsp;&nbsp; <strong>显示级数</strong> <input type="text" name="showLevel" id="showLevel"
					value=<%=showLevel%>> <input type="hidden" name="superId"
					id="superId" value=<%=superId%>>&nbsp;&nbsp;
				<input type="submit" class="button01"
					value="确定">
					<input type="hidden" id="content" name="content" value="">
					<input type="hidden" id="exportType" name="exportType" value="">
					<a id="export" target="_blank"
					href="/pages/org/chart/exportOrg1.jsp"></a> <input
					style="display: none;" type="button" class="button01"
					value="导出"
					onclick="exportToWord();">
				</td>
			</tr>
		</table>
	</form>
	
	<div style="display: none;">
		<%=orgsHtml%>
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		align=center>
		<tr>
			<td id="chart" valign="top" align="center"></td>
		</tr>
	</table>
	<script>
	    $(function() {
	    	var orgs="<%=orgs%>";
	    	if(orgs!=''){
	    		var org=orgs.split(",");
	    		for(var i=0;i<org.length;i++){
	    			if(org[i]!=''){
		    			var params=org[i].split("-");
		    			$("#"+params[0]).css({height:110,width:15*params[1]});
	    			}
	    		}
	    	}
	        $("#org").jOrgChart({
	            chartElement : '#chart'
	        });
	        $(".node a").click(function(){
	        	var id=$(this).parent().attr("id");
	        	open("/doc/OrgIndex.jsf?fk="+id);
	        });
	    	var max="<%=max%>";
	    	if(max<8){
    			$(".jOrgChart .node").css({height:max*15+10,width:20});
	    	}
	        $(".node").first().css({height:20,width:240});
	    });
    </script>