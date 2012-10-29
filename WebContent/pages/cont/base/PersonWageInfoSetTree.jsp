<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>

<%@ include file="/pages/include/taglib.jsp" %>
<%
    String setType = "A";
    CodeItemBO cItem = SysCacheTool.findCodeItem(Constants.INFO_SET_TYPE_CODEID, "2001010301");

    String typeTreeId = cItem.getTreeId();

    ArrayList infosetTypes = SysCacheTool.queryCodeItemBySetId("2001");
    List infoSet = SysCacheTool.queryAllInfoSet();
    UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");
%>
<html>
<head><title>
</title></head>

<body>

<div id="dt"></div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
<script language="javascript">
    var xmlHttp;
    var setId = "";
    var flag = true;
    //定义树的图片对象
    var images = new getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, dt);
    root = tree.root;
    <%
        //画类别
        if(infosetTypes != null && infosetTypes.size()>0){
            int count=infosetTypes.size();
            out.println(count);
            for(int i=0;i<count;i++){
                CodeItemBO citem = (CodeItemBO) infosetTypes.get(i);
                if(!citem.getTreeId().startsWith(typeTreeId))
                    continue;
                if("2001010000".equals(citem.getItemSuper())){
                    String str = "T" + citem.getItemId() + " = tree.add(root,'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','database','','');";
                    out.println(str);
                }else{
                    String str = "T" + citem.getItemId() + " = tree.add(T" + citem.getItemSuper() +",'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','database','','');";
                    out.println(str);
                }
            }
        }
        //画指标集
        if(infoSet != null && infoSet.size() >0){
            //Iterator  iterator=infoSet.values().iterator();
            int count =infoSet.size();
            //while(iterator.hasNext()){
            for(int i=0;i<count;i++){
                String rootNode = "root";
                //InfoSetBO setBO=(InfoSetBO)iterator.next();
                InfoSetBO setBO=(InfoSetBO)infoSet.get(i);
                if(!setType.equals(setBO.getSet_bType())) continue;
                if(setBO.getSet_sType() != null && !"".equals(setBO.getSet_sType())){
                    String stype=setBO.getSet_sType();
                    String treeId=SysCacheTool.findCodeItem("",stype).getTreeId();
                    if(treeId.startsWith(typeTreeId)){
                        // 还需要判断权限
                        if(0==pmsapi.checkInfoSet((User) session.getAttribute(Constants.USER_INFO),setBO.getSetId())){
                            rootNode = "T" + setBO.getSet_sType();
                            String str =setBO.getSetId() + " = tree.add(" + rootNode + ",'last','" + setBO.getSetName() + "','" + setBO.getSetId() + "','"+setBO.getSet_rsType()+"','','book_open','','');";
                            out.println(str);
                        }
                    }
                }
             }
        }

    %>

    tree.expandAll(true);
    tree.onclick = function(srcNode) {
        setId=srcNode.getKey();
        rsType=srcNode.key2;
        if(setId.substr(0,1)=="A"){
            parent.refreshList(setId,rsType);
        }else{
            return;
        }
    }
</script>
</body>
</html>