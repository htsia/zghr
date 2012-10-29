<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.service.InfoSetService" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.UserAPI"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>
<%
    String personId = (String) session.getAttribute("doc_A_personId");
    String setId = (String) session.getAttribute("doc_A_setId");
    String typeId = (String) session.getAttribute("doc_A_typeId");

    if (typeId == null || "".equals(typeId))
        typeId = "2001010000";//员工信息

    //自动选中第一个下级
    String[] typeIds = typeId.split(",");

    String parentId = typeIds[typeIds.length - 1];
    List subList = null;
    do {
        subList = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, null, parentId);
        if (!subList.isEmpty()) {
            CodeItemBO b = (CodeItemBO) subList.get(0);
            parentId = b.getItemId();
            if(setId == null || "".equals(setId)){
                typeId += "," + parentId;
            }
        }
    } while (subList == null);

    SysAPI sysapi = (SysAPI) SysContext.getBean("sys_SysAPI");
    if (setId == null || "".equals(setId)) {
        InfoSetService setService = (InfoSetService) SysContext.getBean("sys_infoSetService");
        InfoSetBO[] bos = setService.queryInfoSets(parentId);
        if (bos != null) {
            setId = bos[0].getSetId();
            session.setAttribute("doc_A_setId", setId);
        }
    }

    typeIds = typeId.split(",");
    typeId = "";

    InfoSetBO[] sets = sysapi.queryInfoSetByBigType("A");
    UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");

    InfoSetBO posSet = null;
    if (setId != null && !"".equals(setId)) {
        posSet = SysCacheTool.findInfoSet(setId);
    }

    for (int i = 0; i < typeIds.length; i++) {
        List list = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, "2001", typeIds[i]);
        typeId += typeIds[i] + ",";
        int count = list.size();
   %>
        <table border='0' width='100%' class='table'><tr>
   <%
        if (!list.isEmpty()) {
            for (int n = 0; n < count; n++) {
                CodeItemBO bo = (CodeItemBO) list.get(n);
                //2001010100 员工基本信息
                //2001010200 履历信息
                //2001010950 档案管理信息集
                //2001010700 教育培训信息集
                if( !"2001010100".equals(bo.getItemId()) &&
                    !"2001010200".equals(bo.getItemId()) &&
                    !"2001010950".equals(bo.getItemId()) &&
                    !"2001010700".equals(bo.getItemId()))
                    continue;
                String id = typeId + bo.getItemId();

                if (i < typeIds.length - 1) {
                    if (bo.getItemId().equals(typeIds[i + 1])) {
                        if (posSet != null && !posSet.getSet_sType().equals(bo.getItemSuper())){
                        %>
                            <td class='td_sec2'>
                        <%
                        }
                        else{
                        %>
                            <td class='td_sec1'>
                        <%
                        }
                    } else{
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
                   <a href='PersonIndex.jsf?flag=2&fk=<%=personId%>&typeId=<%=id%>'><%out.println(name);%></a></td>
                <%
            }
        }
        %>
           </tr><br><tr>
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
                }
                else{
                %>
                    <td class='td_sec1'>
                <%
                    }
                    String id = "";
                    if (typeId.endsWith(","))
                        id = typeId.substring(0, typeId.length() - 1);
                    String url="PersonIndex.jsf?flag=2&fk="+personId+"&typeId="+id+"&setId="+ CommonFuns.filterNull(sets[j].getSetId());
                    String tempName = CommonFuns.filterNull(sets[j].getSetName());
                %>
                  <a href='<%=url%>'><%=tempName%></a></td>
                <%
            }
        }
        %>
         </tr></table>
        <%
    }
%>