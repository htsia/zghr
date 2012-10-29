<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.service.InfoSetService"%>
<%@ page import="com.hr319wg.util.CommonFuns" %>


<%
    String typeId = (String)session.getAttribute("doc_B_typeId");
    String personId = (String)session.getAttribute("doc_B_personId");
    String setId = (String)session.getAttribute("doc_B_setId");

    if (typeId == null || "".equals(typeId))
        typeId = "2001020000";//2001020,2001030
    String[] typeIds = typeId.split(",");
    typeId = "";
    SysAPI sysapi = (SysAPI) SysContext.getBean("sys_SysAPI");
    InfoSetBO[] sets = sysapi.queryInfoSetByBigType("B");//B  /D
    UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");

    String parentId = typeIds[typeIds.length -1];
    if (setId == null || "".equals(setId)) {
        InfoSetService setService = (InfoSetService) SysContext.getBean("sys_infoSetService");
        InfoSetBO[] bos = setService.queryInfoSets(parentId);
        if (bos != null && bos.length>0) {
            setId = bos[0].getSetId();
            session.setAttribute("doc_B_setId", setId);
        }
    }

    for (int i = 0; i < typeIds.length; i++) {
        List list = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, "2001", typeIds[i]);
        typeId += typeIds[i] + ",";

        %>
           <table border='0' width='100%' class='table'><tr>
        <%
        for (int j = 0; j < sets.length; j++) {
            if("B710".equals(sets[j].getSetId()) || "A703".equals(sets[j].getSetId()) || Constants.SYS_SAVE_ABILITY_SET.indexOf(sets[j].getSetId()) != -1 || 1 == pmsapi.checkInfoSet((User) session.getAttribute(Constants.USER_INFO),sets[j].getSetId())){
                continue;
            }else if (!InfoSetBO.STATUS_OPEN.equals(sets[j].getSetStatus())){
                continue;
            }
            if (sets[j].getSet_sType().equals(typeIds[i])) {
                if (sets[j].getSetId().equals(setId)){
                %>
                   <td class='td_sec2'>
                <%
                 }else{
                %>
                   <td class='td_sec1'>
                <%
                    }
                    String id = "";
                    if (typeId.endsWith(","))
                        id = typeId.substring(0, typeId.length() - 1);
                    String tempsetid = CommonFuns.filterNull(sets[j].getSetId());
                    String tempsetname = CommonFuns.filterNull(sets[j].getSetName());
                %>
                   <a href='OrgIndex.jsf?flag=2&fk=<%=personId%>&typeId=<%=id%>&setId=<%=tempsetid%>'><%=tempsetname%></a></td>
                <%
            }
        }
        int count = list.size();
        if (!list.isEmpty()) {
            for (int n = 0; n < count; n++) {
                CodeItemBO bo = (CodeItemBO) list.get(n);
                String id = typeId + bo.getItemId();
                if (i < typeIds.length - 1) {
                    if (bo.getItemId().equals(typeIds[i + 1])) {
                    %>
                      <td class='td_sec2'>
                    <%
                    } else {
                     %>
                        <td class='td_sec1'>
                     <%
                    }
                } else {
                %>
                     <td class='td_sec1'>
                <%
                }

                String name = bo.getItemName();
                if (name.length() > 8)
                    name = name.substring(0, 4) + "<BR>" + name.substring(4, name.length());
                %>
                <a href='OrgIndex.jsf?flag=2&fk=<%=personId%>&typeId=<%=id%>'><%out.println(name);%></a></td>
                <%
            }
        }
        %>
        </tr></table>
<%
    }
%>
