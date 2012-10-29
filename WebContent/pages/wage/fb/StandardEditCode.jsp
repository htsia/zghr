<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeSetBO" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageFBStdItemBO" %>
<%@ page import="com.hr319wg.wage.pojo.vo.WageFBStandardVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.wage.pojo.vo.WageFBStandardVO"%>
<%@ page import="com.hr319wg.wage.pojo.bo.WageFBStdItemBO"%>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    WageFBStandardVO stdVO = (WageFBStandardVO) session.getAttribute("stdVO");
    ArrayList hItem = stdVO.getH_item();
    ArrayList vItem = stdVO.getV_item();

    String[] HAllCode = stdVO.getHAllCodeItem();
    String[] VAllCode = stdVO.getVAllCodeItem();
    Hashtable HCodehash = new Hashtable();
    if (HAllCode != null) {
        for (int i = 0; i < HAllCode.length; i++) {
            HCodehash.put(HAllCode[i], HAllCode[i]);
        }
    }
    Hashtable VCodehash = new Hashtable();
    if (VAllCode != null) {
        for (int i = 0; i < VAllCode.length; i++) {
            VCodehash.put(VAllCode[i], VAllCode[i]);
        }
    }
%>
<html>
<head>
<title></title>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree_check.js"></script>
<script type="text/javascript">
    //定义树的图片对象
    var flag = false;
    var images = new getTreeImage();
</script>
<script type="text/javascript" language="javascript">
    var Hsets = new Array();
    <%for(int i=0;i<hItem.size();i++){%>
    Hsets[<%=i%>] = "h_<%=((WageFBStdItemBO)hItem.get(i)).getField()%>"
    <%}%>
    var Vsets = new Array();
    <%for(int i=0;i<vItem.size();i++){%>
    Vsets[<%=i%>] = "v_<%=((WageFBStdItemBO)vItem.get(i)).getField()%>"
    <%}%>
    function checkCodes(sets) {
        slen = sets.length;
        setflag = false;
        try {
            for (i = 0; i < slen; i++) {
                ele = document.all(sets[i])
                len = ele.length;
                itemflag = false;
                if (len != null && len > 0) {
                    for (j = 0; j < len; j++) {
                        if (ele[j].type == 'checkbox') {
                            if (ele[j].checked) {
                                itemflag = true;
                                break;
                            }
                        }
                    }
                } else {
                    if (ele.checked) {
                        itemflag = true;
                    }
                }
                if (!itemflag) {
                    alert("请选择代码项！");
                    setflag = true;
                    break;
                }
            }
        } catch(ex) {
            alert("所选指标项指定的代码集中含有没有代码项的代码集，请重新选择");
            return true;
        }
        return setflag;
    }
    function forNext(form1) {
        if (!checkCodes(Hsets) && !checkCodes(Vsets))
            return true;
        else
            return false;
    }
    function selectSub(obj, obj2) {
        var chk = document.all(obj2);
        var str = obj.key2;
        var size = chk.length;
        var flag = true;
        for (i = 0; i < size; i++) {
            var tmpId = chk[i].treeId;
            if (tmpId == str) {
                if (chk[i].checked) {
                    chk[i].checked = false;
                } else {
                    chk[i].checked = true;
                }
                flag = chk[i].checked;
            } else {
                if (tmpId.indexOf(str) == 0)
                    chk[i].checked = flag;
            }
        }
    }
    function selectItem(obj, chk) {
        size = chk.length;
        for (i = 0; i < size; i++) {
            chk[i].checked = obj.checked;
        }
    }
</script>
</head>

<body>
<x:saveState value="#{wage_fbstandardBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="wage_fbstandardBB.standard.unitId"/>
<h:inputHidden value="wage_fbstandardBB.standard.stdId"/>
<h:panelGrid width="95%" align="center">
    <h:panelGrid align="right" columns="3" cellspacing="2">
        <h:commandButton styleClass="button01" value="上一步" action="#{wage_fbstandardBB.step1_setItem}"/>
        <h:commandButton styleClass="button01" value="下一步" action="#{wage_fbstandardBB.step3_setValue}"
                         onclick="if(forNext(document.forms(0))){}else{return false;}"/>
        <h:commandButton styleClass="button01" value="取消返回" action="#{wage_fbstandardBB.list}"/>
    </h:panelGrid>
</h:panelGrid>
<c:verbatim escape="false">
<br>
<table width="95%" border="0" cellpadding="2" cellspacing="0" class="table03" align=center>
<tr>
    <td class="td_top" align=center>选择纵向指标代码项</td>
    <td class="td_top" align=center>选择横向指标代码项</td>
</tr>
<tr align="center" valign="top">
<td class="td_middle" width="50%">
    <%
        SysAPI sysapi = null;
        try{
            sysapi=(SysAPI) SysContext.getBean("sys_SysAPI");
        }
        catch(Exception e){

        }
        if (sysapi!=null && vItem != null && vItem.size() > 0) {
            Iterator vIterator = vItem.iterator();

            while (vIterator.hasNext()) {
                WageFBStdItemBO stdItem = (WageFBStdItemBO) vIterator.next();
                String codeSetId = stdItem.getCodeSetId();
                CodeSetBO setBO = SysCacheTool.findCodeSet(codeSetId);

                List codeItem = null;
                try{
                    codeItem=sysapi.queryAllCodeItemForTree(codeSetId);
                }
                catch(Exception e){

                }
                String treeName = "node" + codeSetId;
    %>
    <table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr>
            <td id="Vdt<%=codeSetId%>">
                <script type="text/javascript">
                    tree<%=codeSetId%> = new newtree(images, 16, Vdt<%=codeSetId%>);
                    root = tree<%=codeSetId%>.root;
                    var <%=treeName%> =tree<%=codeSetId%>.addChkNode(root, "last", "<%=setBO.getSetName()%>", "<%=codeSetId%>", "", "", "item", "JS", "", false, false, "", "");
                    <%
                        if(codeItem==null||codeItem.size()==0) continue;                                        
                        int size=codeItem.size();
                        for(int i=0;i<size;i++){
                            CodeItemBO itemBO=(CodeItemBO)codeItem.get(i);
                            String itemId=itemBO.getItemId();
                            String superId=itemBO.getItemSuper();
                            String treeId=itemBO.getTreeId();
                            String name=itemBO.getItemName();
                            boolean checkFlag=VCodehash.containsKey(itemId)?true:false;
                            boolean leafNode=true;//!SysCache.codeItemSubStrMap.containsKey(itemId);
                            if("-1".equals(superId))
                                superId=codeSetId;
                    %>
                    node<%=itemId%> = tree<%=codeSetId%>.addChkNode(<%="node"+superId%>, "last", "<%=name%>", "<%=itemId%>", "<%=treeId%>", "", "item", "JS", "", <%=checkFlag%>, <%=leafNode%>, "v_<%=stdItem.getField()%>", "<%=itemId%>", "<%=treeId%>");
                    <%
                        }
                    %>
                    tree<%=codeSetId%>.onclick = function(srcNode) {
                        selectSub(srcNode, 'v_<%=stdItem.getField()%>');
                    }

                </script>

            </td>
        </tr>
    </table>
    <br>
    <%
            }
        }
    %>
</td>
<td class="td_middle" width="50%">
    <%
        if (hItem != null && hItem.size() > 0) {
            Iterator hIterator = hItem.iterator();
            while (hIterator.hasNext()) {
                WageFBStdItemBO stdItem = (WageFBStdItemBO) hIterator.next();
                String codeSetId = stdItem.getCodeSetId();
                CodeSetBO setBO = SysCacheTool.findCodeSet(codeSetId);

                List codeItem = null;
                try{
                    codeItem=sysapi.queryAllCodeItemForTree(codeSetId);
                }
                catch(Exception e){

                }

                String treeName = "node" + codeSetId;
    %>
    <table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr>
            <td id="Hdt<%=codeSetId%>">
                <script type="text/javascript">
                    tree<%=codeSetId%> = new newtree(images, 16, Hdt<%=codeSetId%>);
                    root = tree<%=codeSetId%>.root;
                    var <%=treeName%> =tree<%=codeSetId%>.addChkNode(root, "last", "<%=setBO.getSetName()%>", "<%=codeSetId%>", "", "", "item", "", "", false, false, "", "");
                    <%
                        int size=codeItem.size();
                        for(int i=0;i<size;i++){
                            CodeItemBO itemBO=(CodeItemBO)codeItem.get(i);
                            String itemId=itemBO.getItemId();
                            String superId=itemBO.getItemSuper();
                            String treeId=itemBO.getTreeId();
                            String name=itemBO.getItemName();
                            boolean checkFlag=HCodehash.containsKey(itemId)?true:false;
                            boolean leafNode=true;//!SysCache.codeItemSubStrMap.containsKey(itemId);
                            if("-1".equals(superId))
                                superId=codeSetId;
                    %>
                    node<%=itemId%> = tree<%=codeSetId%>.addChkNode(<%="node"+superId%>, "last", "<%=name%>", "<%=itemId%>", "<%=treeId%>", "", "item", "", "", <%=checkFlag%>, <%=leafNode%>, "h_<%=stdItem.getField()%>", "<%=itemId%>", "<%=treeId%>");
                    <%
                        }
                    %>
                    tree<%=codeSetId%>.onclick = function(srcNode) {
                        selectSub(srcNode, 'h_<%=stdItem.getField()%>');
                    }
                </script>

            </td>
        </tr>
    </table>
    <br>
    <%
            }
        }
    %>
</td>
</tr>
</table>
</c:verbatim>
</h:form>
</body>
</html>