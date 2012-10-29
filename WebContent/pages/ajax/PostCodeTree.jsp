<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.post.ucc.IPostUCC" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.post.pojo.bo.PostBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
%>
<%
    String superId = request.getParameter("superId");
    String setId = request.getParameter("setId");
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
    ArrayList list = null;
    if("".equals(rootId)){
      list = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, setId, superId);
    }else{
         String[] ids = rootId.split(",");
        if(ids != null && ids.length >0){
            list = new ArrayList();
            for(int i=0;i<ids.length;i++){
                CodeItemBO o =SysCacheTool.findCodeItem(setId,ids[i]);
                if(o != null)
                    list.add(o);
            }
        }
    }
    CodeItemBO code = SysCacheTool.findCodeItem(setId, superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            childnum="1";
            out.println("<code>");
            CodeItemBO o = (CodeItemBO) list.get(i);
            if (o != null) {
               // ArrayList list1 = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, setId, oa.getItemId());
                ///if (list1 != null && list1.size() > 0) {
               //     childnum = "1";
               // } else {
               //     childnum = "0";
               //     icon = "file";
               // }
                out.println("<PostCatalog>");
                out.println("<key>" + o.getTreeId() + "</key>");
                out.println("<name>" + o.getItemName() + "</name>");
                out.println("<id>" + o.getItemId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
                out.println("</PostCatalog>");
            }
            out.println("</code>");
        }
    }

    if (code != null) {
        out.println("<supertree>");
        out.println("<treeid>" + code.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }
    
    String addSql=" p.postTemp='"+Constants.YES+"'";
    StringBuffer condi = new StringBuffer();
    if (CommonFuns.filterNull(addSql).length() > 0)
        condi.append(" and (").append(addSql).append(")");
    condi.append(" and p.postClass='").append(superId).append("'");

   
    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (user != null) {
	//System.out.println(">>condi>>"+condi.toString());
             
        IPostUCC ucc = (IPostUCC) SysContext.getBean("post_postUCC");
        PostBO[] posts = ucc.queryPost(condi.toString());

        if (posts != null) {
            for (int i = 0; i < posts.length; i++) {
                PostBO p = posts[i];
                //System.out.println(">>>>>"+p.getName());
                out.println("<post>");
                out.println("<id>" + p.getPostId() + "</id>");
                out.println("<name>" + p.getName() + "</name>");
                out.println("</post>");
            }
        }

    }

    out.println("</tree>");

%>