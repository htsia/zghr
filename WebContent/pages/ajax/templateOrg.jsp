<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgTemplateItemBO" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.org.ucc.impl.OrgTemplateUCC" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));     // 权限方式  //   0-不使用 1-使用查询权限过滤,2-使用维护权限过滤
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));           // 根节点
    String cancelFlag = CommonFuns.filterNull(request.getParameter("cancelFlag"));   // 是否显示撤销机构
    String showGroup = CommonFuns.filterNull(request.getParameter("showGroup"));    //   是否显示班组
    String onlyOrg= CommonFuns.filterNull(request.getParameter("onlyOrg"));          //  只显示机构
    List  list = new ArrayList();
    String templateId=(String)session.getAttribute("templateId");
    
    OrgTemplateUCC rc = null;
    try {
        rc = (OrgTemplateUCC) SysContext.getBean("orgtemplateucc");
	    if ("-1".equals(superId)&&null!=templateId&&!"".equals(templateId)){
	       
	    	OrgTemplateItemBO o= rc.getRootOrgTemplateItemByTemplatId(templateId);
	        list.add(o);
	    }
	    else{
	        list = rc.getAllOrgTemplateItemBOBySuperId(superId);
	    }
    }
    catch (Exception e) {
		e.printStackTrace();
    }
    OrgTemplateItemBO org=rc.findOrgTemplateItemBOById(superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");

    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
        	OrgTemplateItemBO o = (OrgTemplateItemBO) list.get(i);
            if (!"1".equals(showGroup) && OrgBO.GROUPTYPE.equals(o.getOrgType())){  // 过滤掉班组
                continue;
            }
            if ("1".equals(onlyOrg) && !OrgBO.UNITTYPE.equals(o.getOrgType())){      // 过滤部门
                continue;
            }
            childnum = "0";
            out.println("<org>");

            //判断下级是否有节点,并且如果不显示撤消机构 则判下级是否都是撤消机构
            if (o != null) {
                List list1 =rc.getAllOrgTemplateItemBOBySuperId(o.getOrgId());
                
                if (OrgBO.UNITTYPE.equals(o.getOrgType())){
                    icon="org";
                }
                else if (OrgBO.DEPTTYPE.equals(o.getOrgType())){
                    icon="dept";
                }
                else if (OrgBO.GROUPTYPE.equals(o.getOrgType())){
                    icon="group";
                }
                else if (OrgBO.VIRTUALTYPE.equals(o.getOrgType())){
                    icon="virtual";
                }
                else{
                    icon="folder";
                }
                out.println("<key>" + o.getOrgId() + "</key>");
                out.println("<name>" + o.getOrgName() + "</name>");
                out.println("<id>" + o.getOrgId() + "</id>");
                out.println("<cancel>" + "0" + "</cancel>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + list1.size() + "</childnum>");

            }
            out.println("</org>");
        }
    }

    if (org != null) {
        out.println("<supertree>");
        out.println("<treeid>" + org.getOrgId() + "</treeid>");
        out.println("</supertree>");
    }

    out.println("</tree>");
%>