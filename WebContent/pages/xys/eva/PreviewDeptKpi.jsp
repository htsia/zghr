<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@page import="com.hr319wg.post.pojo.bo.PostBO"%>
<%@page import="com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO"%>
<%@page import="com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.XysKpiObjLibBO" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.XysKpiObjKeyBO" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>

<%
//此页面为部门、个人KPI审批共用页面

    String objId = request.getParameter("objId");
    IXysKpiDeptUCC ucc = null;
    IXysKpiPersonUCC pucc = null;
    XysKpiPersonObjBO pobj = null;
    XysKpiDeptObjBO dobj = null;
    
    String title = null;
    try {
        ucc = (IXysKpiDeptUCC) SysContext.getBean("xysKpiDeptUCC");
        dobj = ucc.findXysKpiDeptObjBOById(objId);
        pucc = (IXysKpiPersonUCC) SysContext.getBean("xysKpiPersonUCC");
        pobj = pucc.findXysKpiPersonObjBOById(objId);
        
        if(pobj != null){
        	//人员KPI，使用姓名当标题
        	PersonBO pbo = SysCacheTool.findPersonById(pobj.getPersonId());
        	title = pbo.getName();
        }else if(dobj != null){
        	//部门KPI，使用部门名称当标题
        	PostBO pbo = SysCacheTool.findPost(dobj.getPostId());
        	OrgBO org = SysCacheTool.findOrgById(pbo.getOrgId());
        	title = org.getName();
        }
    } catch (Exception e) {

    }
%>
<html>
<head>
    <title>预览指标</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
    	.td_xys_top {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 12px;
			color: #333333;
			background-color: #F3F3F3;
			padding: 2px;
			border-right: 1px #4986d4 solid;
			border-bottom: 1px #4986d4 solid;
			height: 22px;
		}
		.td_xys_mid {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 12px;
			color: #333333;
			background-color: #FFFFFF;
			padding: 2px;
    		border-right: 1px #4986d4 solid;
			border-bottom: 1px #4986d4 solid;
			height: 22px;
    		text-align :left;
		}
    </style>
</head>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<body bgcolor="<%=Constants.BGCOLOR%>">

<br>
<table width=98% align="center">
    <tr>
        <td align="right"></td>
    </tr>
    <tr>
        <td align="center"><span style="font-size:18px;font-weight:bold;align:center"><%=title %>KPI评分表预览</span></td>
    </tr>
    <tr>
        <td height=8>

        </td>
    </tr>

    <tr>
        <td>
            <table class="table02" align="center">
                <%
                    List libList = ucc.getXysKpiObjLibBOByObjId(objId);
	                out.println("<tr>");
	                out.println("<td valign='center' class='td_xys_top' align='center'>");
	                out.println("<b>指标名称</b>");
	                out.println("</td>");
	                out.println("<td valign='center' class='td_xys_top'  align='center'>");
	                out.println("<b>指标内容和工作计划</b>");
	                out.println("</td>");
	                out.println("<td valign='center' class='td_xys_top'align='center'>");
	                out.println("<b>权重</b>");
	                out.println("</td>");
	                out.println("<td valign='center' class='td_xys_top'  align='center'>");
	                out.println("<b>评分标准</b>");
	                out.println("</td>");
	                out.println("<td valign='center' class='td_xys_top' align='center'>");
	                out.println("<b>目标值</b>");
	                out.println("</td>");
	                out.println("<td valign='center' class='td_xys_top' align='center'>");
	                out.println("<b>实际完成情况</b>");
	                out.println("</td>");
	                out.println("<td valign='center' class='td_xys_top' align='center'>");
	                out.println("<b>自评分</b>");
	                out.println("</td>");
	                out.println("</tr>");
                    for (int i = 0; i < libList.size(); i++) {
                        XysKpiObjLibBO lib = (XysKpiObjLibBO) libList.get(i);
                        List items = ucc.getXysKpiObjKeyBOByLibId(lib.getObjLibId());
                        int count = items.size() > 0 ? items.size() : 1;
                        out.println("<tr>");
                        out.println("<td valign='center' class='td_xys_mid' align='center' rowspan='" + String.valueOf(count) + "'>");
                        out.println(lib.getObjLibName());
                        out.println("</td>");
                        if (items != null && items.size() > 0) {
                            XysKpiObjKeyBO itembo = (XysKpiObjKeyBO) items.get(0);
                            out.println("<td class='td_xys_mid'>");
                            out.println(itembo.getKeyName());
                            out.println("</td>");
                            out.println("<td class='td_xys_mid'>");
                            out.println(itembo.getWeight() + "%");
                            out.println("</td>");
                            out.println("<td class='td_xys_mid' >");
                            out.println(CommonFuns.filterNull(itembo.getGradeStd()));
                            out.println("</td>");
                            out.println("<td class='td_xys_mid' >");
                            out.println(CommonFuns.filterNull(itembo.getAimValue()));
                            out.println("</td>");
                            out.println("<td class='td_xys_mid' >");
                            out.println(CommonFuns.filterNull(itembo.getExecution()));
                            out.println("</td>");
                            out.println("<td class='td_xys_mid' >");
                            out.println(CommonFuns.filterNull(itembo.getSelfGrade()));
                            out.println("</td>");
                            out.println("</tr>");
                            for (int j = 1; j < items.size(); j++) {
                                itembo = (XysKpiObjKeyBO) items.get(j);
                                out.println("<tr>");
                                out.println("<td class='td_xys_mid'>");
                                out.println(itembo.getKeyName());
                                out.println("</td>");
                                out.println("<td class='td_xys_mid'>");
                                out.println(itembo.getWeight() + "%");
                                out.println("</td>");
                                out.println("<td class='td_xys_mid' >");
                                out.println(CommonFuns.filterNull(itembo.getGradeStd()));
                                out.println("</td>");
                                out.println("<td class='td_xys_mid' >");
                                out.println(CommonFuns.filterNull(itembo.getAimValue()));
                                out.println("</td>");
                                out.println("<td class='td_xys_mid' >");
                                out.println(CommonFuns.filterNull(itembo.getExecution()));
                                out.println("</td>");
                                out.println("<td class='td_xys_mid' >");
                                out.println(CommonFuns.filterNull(itembo.getSelfGrade()));
                                out.println("</td>");
                                out.println("</tr>");
                            }
                        } else {
                            out.println("</tr>");
                        }
                    }
                %>
            </table>
        </td>
    </tr>
</table>
</body>
</html>