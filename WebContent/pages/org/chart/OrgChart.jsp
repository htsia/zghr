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
%>

<link rel="stylesheet" href="/css/jquery.jOrgChart.css"/>
<link rel="stylesheet" href="/css/custom.css"/>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
    
    <script type="text/javascript" src="/js/jquery-1.4.4.min.js"></script>
    
    <script src="/js/jquery.jOrgChart.js"></script>

    <script>
    $(function() {
        $("#org").jOrgChart({
            chartElement : '#chart'
        });
        $(".node a").click(function(){
        	var id=$(this).attr("id");
        	open("/doc/OrgIndex.jsf?fk="+id);
        });
        $(".node").first().css({height:20,width:240});
    });
    </script>

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
		<%
		OrgBO org = SysCacheTool.findOrgById(superId);
		List list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", superId);

		String name = "";
		String id = "";
		if (org != null) {
			out.print("<ul id='org'>");
			name = org.getName();
			id = org.getOrgId();
			out.println("<li><a href='javascript:void(-1);'id='"+org.getPkId()+"'>"+name+"</a>");
			//第一级_begin
			if (list != null && list.size() > 0) {
				out.println("<ul>");
				for (int i = 0; i < list.size(); i++) {
					OrgBO bo = (OrgBO) list.get(i);
					if (Constants.YES.equals(bo.getOrgCancel())) {
						continue;
					}
					if (OrgBO.VIRTUALTYPE.equals(bo.getorgType()) && notShowVir){
						continue;
					}
					String sid = bo.getOrgId();
					out.println("<li><a href='javascript:void(-1);'id='"+bo.getPkId()+"'>" + bo.getName()+"</a>");
					//第二级
					if (expand>1){
                        List child = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", sid);
                        if (child!=null && child.size()>0){
                        	out.println("<ul>");
	                        for(int j=0;j<child.size();j++){
	                             OrgBO childbo = (OrgBO)child.get(j);
	                             if(Constants.YES.equals(childbo.getOrgCancel())){
	                                 continue;
	                             }
	                             if (OrgBO.VIRTUALTYPE.equals(childbo.getorgType()) && notShowVir ) continue;
	                             String csid=childbo.getOrgId();
	                             out.println("<li><a href='javascript:void(-1);'id='"+childbo.getPkId()+"'>"+childbo.getName()+"</a>");
                                 //第三级
                                 if (expand>2){
                                     List childchild = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", csid);
                                     if (childchild!=null && childchild.size()>0){
                                         out.println("<ul>");
                                    	 for(int k=0;k<childchild.size();k++){
                                             OrgBO childchildbo = (OrgBO)childchild.get(k);
                                             if(Constants.YES.equals(childchildbo.getOrgCancel())){
                                      	     	continue;
                                             }
                                             if (OrgBO.VIRTUALTYPE.equals(childchildbo.getorgType()) && notShowVir ) continue;
	   	                                     String ccsid=childchildbo.getOrgId();
	   	                                     out.println("<li><a href='javascript:void(-1);'id='"+childchildbo.getPkId()+"'>"+childchildbo.getName()+"</a>");
	   	                                     //第四级
	   	                                     if (expand>3){
	                                             List child4 = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", ccsid);
	                                             if (child4!=null && child4.size()>0){
	                                             	out.println("<ul>");
		                                            for(int l=0;l<child4.size();l++){
			                                            OrgBO child4bo = (OrgBO)child4.get(l);
			                                            if(Constants.YES.equals(child4bo.getOrgCancel())){
			                                            	continue;
			                                            }
			                                            if (OrgBO.VIRTUALTYPE.equals(child4bo.getorgType()) && notShowVir ) continue;
			                                            	out.println("<li><a href='javascript:void(-1);'id='"+child4bo.getPkId()+"'>"+child4bo.getName()+"</a></li>");
			                                            }
	                                                }
	                                                out.println("</ul>");
	                                           }// 显示第4级_end
	   	                                     out.println("</li>");
                                          }
                                    	  out.println("</ul>");
                                      }
                                 }//显示三级_end
			                    out.println("</li>");
	                        }
	                        out.println("</ul>");
                        }
                	}
                    out.println("</li>");
				}
				out.print("</ul>");
			}//第一级_end
			out.print("</li></ul>");
		}
	%>
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		align=center>
		<tr>
			<td id="chart" valign="top" align="center"></td>
		</tr>
	</table>