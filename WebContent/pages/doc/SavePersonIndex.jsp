<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.service.InfoSetService" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.UserAPI"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="java.util.Map"%>
<%@ include file="../include/taglib.jsp" %>
<HTML>
<HEAD>
    <TITLE></TITLE>
    <link href="css/style.css" rel="stylesheet" type="text/css">
    <style>
        .td_sec1 {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #333333;
            background-color: #EFEFEF;
            border-left: 0px;
            border-top: 0px;
            border-right: 1px solid #BCBCBC;
            border-bottom: 1px solid #BCBCBC;
            text-align: center;
            height: 30;
        }

        .td_sec2 {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #333333;
            background-color: #DDDDDD;
            border-left: 0px;
            border-top: 0px;
            border-right: 1px solid #BCBCBC;
            border-bottom: 1px solid #BCBCBC;
            text-align: center;
            height: 30;
        }

        .table {
            border-collapse: collapse;
            border-top: 1px #BCBCBC solid;
            border-left: 1px #BCBCBC solid;
        }

        a:link {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #444444;
            text-decoration: none;
        }

        a:active {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #C54320;
            text-decoration: none;
        }

        a:visited {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #444444;
            text-decoration: none;
        }

        a:hover {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #C54320;
            text-decoration: none;
        }
    </style>
    <%
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

    %>
</HEAD>

<BODY>
<c:view>
<%

    String personId = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("fk"));
    String setId = request.getParameter("setId");
    String typeId = request.getParameter("typeId");

    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (typeId == null || "".equals(typeId)) {
        typeId = (String) session.getAttribute("doc_A_typeId");
        setId = (String) session.getAttribute("doc_A_setId");
    }
//	if(null == setId)
//		setId = "A001";
    session.setAttribute("doc_A_setId", setId);
    session.setAttribute("doc_A_typeId", typeId);

    if (typeId == null || "".equals(typeId))
        typeId = "2001010000";//2001020,2001030
    //自动选中第一个下级

    String[] typeIds = typeId.split(",");

    String parentId = typeIds[typeIds.length - 1];
    List subList = null;
    do {
        subList = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, null, parentId);
        if (!subList.isEmpty()) {
            CodeItemBO b = (CodeItemBO) subList.get(0);
            parentId = b.getItemId();
            typeId += "," + parentId;
        }
    } while (subList == null);
    SysAPI sysapi = (SysAPI) SysContext.getBean("sys_SysAPI");
    if (setId == null || "".equals(setId)) {
        InfoSetService setService = (InfoSetService) SysContext.getBean("sys_infoSetService");
        InfoSetBO[] bos = setService.queryInfoSets(parentId);
        if (bos != null) {
            setId = bos[0].getSetId();
        }
    }

    typeIds = typeId.split(",");
    typeId = "";

    InfoSetBO[] sets = sysapi.queryInfoSetByBigType("A");//B  /D
    UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");

    String firstTable = null;
    InfoSetBO posSet = null;
    if (setId != null && !"".equals(setId)) {
        posSet = SysCacheTool.findInfoSet(setId);
    }

    PersonBO person = null;
    String fk = request.getParameter("fk");
    if(fk != null && !"".equals(fk))
        person = SysCacheTool.findPersonById(fk);

    for (int i = 0; i < typeIds.length; i++) {
        List list = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, "2001", typeIds[i]);
        typeId += typeIds[i] + ",";
        int count = list.size();
        out.println("<table border='0' width='100%' class='table'><tr>");
        if (!list.isEmpty()) {

            for (int n = 0; n < count; n++) {
                CodeItemBO bo = (CodeItemBO) list.get(n);
                String id = typeId + bo.getItemId();

                if (i < typeIds.length - 1) {
                    if (bo.getItemId().equals(typeIds[i + 1])) {
                        if (posSet != null && !posSet.getSet_sType().equals(bo.getItemSuper()))
                            out.println("<td class='td_sec2'>");
                        else
                            out.println("<td class='td_sec1'>");
                    } else
                        out.println("<td class='td_sec1'>");
                } else {
                    out.println("<td class='td_sec1'>");
                }
                out.println("<a href='SavePersonIndex.jsf?flag=2&fk=" + personId + "&typeId=" + id + "'>");
                String name = bo.getItemName();
                if (name.length() > 8)
                    name = name.substring(0, 4) + "<BR>" + name.substring(4, name.length());
                out.println(name);
                out.println("</a></td>");
            }

        }

        for (int j = 0; j < sets.length; j++) {
            if (sets[j].getSet_sType().equals(typeIds[i])) {
                //如果没有权限 不显示
                if(1 == pmsapi.checkInfoSet(user, sets[j].getSetId()))
                    continue;

                if(Constants.SYS_SAVE_ABILITY_SET.indexOf(sets[j].getSetId()) != -1){
                    //如果是后备人才5个控制信息集 进一步判断权限
                    //取后备人才维护权限 .
                    Map rightMap = user.getPmsOperateCode();
                    if(rightMap == null)
                        continue;
                    List rightList = (List) rightMap.get(Constants.SYS_SAVE_ABILITY_PERSON);
                    if(list == null)
                        continue;
                    String saveRight = "";
                    for(int t=0;t<rightList.size();t++){
                        CodeItemBO tbo = (CodeItemBO) rightList.get(t);
                        saveRight += tbo.getItemId() + ",";
                    }
                    if(person == null)
                        continue;

                    boolean flag = true;
                    if(saveRight.indexOf(person.getSysSaveAbilityCode()) == -1){
                        flag = false;
                        continue;
                    }
                    //判断setid在不在权限范围内
                    if(Constants.SYS_SAVE_ABILITY_SET.indexOf(setId) != -1 && !flag)
                        setId = "A848";

                }

                if (sets[j].getSetId().equals(setId))
                    out.println("<td class='td_sec2'>");
                else
                    out.println("<td class='td_sec1'>");
                String id = "";
                if (typeId.endsWith(","))
                    id = typeId.substring(0, typeId.length() - 1);
                out.println("<a href='SavePersonIndex.jsf?flag=2&fk=" + personId + "&typeId=" + id + "&setId=" + sets[j].getSetId() + "'>");
                out.println(sets[j].getSetName());
                out.println("</a></td>");
            }
        }

        out.println("</tr>");
        out.println("</table>");
    }

    if (setId != null) {
        InfoSetBO bo = SysCacheTool.findInfoSet(setId);
        if ("A001".equals(setId)) {
%>
<jsp:include page="PersonBasicInfo.jsp"/>
<%
    }else if (InfoSetBO.RS_TYPE_MANY.equals(bo.getSet_rsType())) {
%>
<jsp:include page="PersonInfoDetailList.jsp">

    <jsp:param name="setId" value="<%=setId%>"/>
    <jsp:param name="flag" value="2"/>
</jsp:include>
<%
} else {
%>
<jsp:include page="PersonInfoDetail.jsp">

    <jsp:param name="setId" value="<%=setId%>"/>
    <jsp:param name="flag" value="2"/>

</jsp:include>
<%
        }
    }

%>
</c:view>
</BODY>
</HTML>
