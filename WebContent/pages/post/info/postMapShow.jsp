<%@page import="com.hr319wg.common.Constants"%>
<%@page import="com.hr319wg.common.pojo.vo.User"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.custom.common.service.ICommonService"%>
<link rel="stylesheet" href="/css/jquery.jOrgChart.css"/>
<link rel="stylesheet" href="/css/custom2.css"/>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<script type="text/javascript" src="/js/jquery-1.4.4.min.js"></script>
<script src="/js/jquery.jOrgChart.js"></script>
<%
	String showLevel=request.getParameter("showLevel");
	if(showLevel==null){
		showLevel="3";
	}
	int n=Integer.valueOf(showLevel);
	String superID=request.getParameter("superId");
	User user=(User)session.getAttribute(Constants.USER_INFO);
	if(superID==null || "".equals(superID)){
		superID=user.getOrgId();
	}
%>
<script>
	$(function() {
	    $("#org").jOrgChart({
	        chartElement : '#chart'
	    });
	    $(".node a").click(function(){
	    	var id=$(this).attr("id");
	    	open("/doc/SinglePostBookQuery.jsf?postid="+id+"&fk="+id);
	    });
	    $(".node").first().css({height:20,width:240});
	});
</script>
	<form action="/pages/post/info/postMapShow.jsp">
		<table width="98%" border="0" cellspacing="0" cellpadding="0" id="control" align="center">
			<tr valign="top">
				<td>
				<strong>显示级数</strong> <input type="text" name="showLevel" id="showLevel" value=<%=showLevel%>> 
				<input type="hidden" name="superId" value=<%=superID%>>&nbsp;&nbsp;
				<input type="submit" class="button01" value="确定">
			</tr>
		</table>
	</form>
	<div style="display: none;">
	<%
		OrgBO org = SysCacheTool.findOrgById(superID);
		JdbcTemplate jdbc=(JdbcTemplate)SysContext.getBean("jdbcTemplate");
		String sql="select postid,c001005 from c001 where c001701 like '"+org.getTreeId()+"%' and (c001015 is null or c001015 in (select postid from c001 where c001701 not like '"+org.getTreeId()+"%'))";
		List<Map<String, Object>> list1 = jdbc.queryForList(sql);
		out.print("<ul id='org'>");
		out.print("<li>"+org.getName());
		if(list1!=null && list1.size()>0 && n>=1){
			//第一层
			out.print("<ul>");
			for(Map m1 : list1){
				out.print("<li><a href='javascript:void(-1);' id='"+m1.get("postid")+"'>"+m1.get("c001005")+"</a>");
				//第二层
				sql="select postid,c001005 from c001 where c001015='"+m1.get("postid")+"' and c001701 like '"+org.getTreeId()+"%' order by c001701";
				List<Map<String, Object>> list2 = jdbc.queryForList(sql);
				if(list2!=null && list2.size()>0 && n>=2){
					out.print("<ul>");
					for(Map m2 : list2){
						out.print("<li><a href='javascript:void(-1);' id='"+m2.get("postid")+"'>"+m2.get("c001005")+"</a>");
						//第三层
						sql="select postid,c001005 from c001 where c001015='"+m2.get("postid")+"' and c001701 like '"+org.getTreeId()+"%' order by c001701";
						List<Map<String, Object>> list3 = jdbc.queryForList(sql);
						if(list3!=null && list3.size()>0 && n>=3){
							out.print("<ul>");
							for(Map m3 : list3){
								out.print("<li><a href='javascript:void(-1);' id='"+m3.get("postid")+"'>"+m3.get("c001005")+"</a>");
								//第四层
								sql="select postid,c001005 from c001 where c001015='"+m3.get("postid")+"' and c001701 like '"+org.getTreeId()+"%' order by c001701";
								List<Map<String, Object>> list4 = jdbc.queryForList(sql);
								if(list4!=null && list4.size()>0 && n>=4){
									out.print("<ul>");
									for(Map m4 : list4){
										out.print("<li><a href='javascript:void(-1);' id='"+m4.get("postid")+"'>"+m4.get("c001005")+"</a>");
										//第五层
										sql="select postid,c001005 from c001 where c001015='"+m4.get("postid")+"' and c001701 like '"+org.getTreeId()+"%' order by c001701";
										List<Map<String, Object>> list5 = jdbc.queryForList(sql);
										if(list5!=null && list5.size()>0 && n>=5){
											out.print("<ul>");
											for(Map m5 : list5){
												out.print("<li><a href='javascript:void(-1);' id='"+m5.get("postid")+"'>"+m5.get("c001005")+"</a>");
												//第六层
												sql="select postid,c001005 from c001 where c001015='"+m5.get("postid")+"' and c001701 like '"+org.getTreeId()+"%' order by c001701";
												List<Map<String, Object>> list6 = jdbc.queryForList(sql);
												if(list6!=null && list6.size()>0 && n>=6){
													out.print("<ul>");
													for(Map m6 : list6){
														out.print("<li><a href='javascript:void(-1);' id='"+m6.get("postid")+"'>"+m6.get("c001005")+"</a>");
														out.print("</li>");
													}
													out.print("</ul>");
												}//第六层
												out.print("</li>");
											}
											out.print("</ul>");
										}//第五层
										out.print("</li>");
									}
									out.print("</ul>");
								}//第四层
								out.print("</li>");
							}
							out.print("</ul>");
						}//第三层
						out.print("</li>");
					}
					out.print("</ul>");
				}//第二层
				out.print("</li>");
			}//第一层
			out.print("</ul>");
		}
		out.print("</li>");
		out.print("</ul>");
	%>
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="10"
		align=center>
		<tr>
			<td id="chart" valign="top" align="center" ></td>
		</tr>
	</table>