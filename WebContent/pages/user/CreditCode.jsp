<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ include file="../include/taglib.jsp" %>
<c:verbatim>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree_check.js"></script>

<script type="text/javascript">
       function selectSub(obj, obj2) {
        var chk = document.all(obj2);
        var str = obj.key2;
        var size = chk.length;
        var flag = true;
        for (i = 0; i < size; i++) {
            var tmpId = chk[i].treeId;
            if (tmpId == str) {
                flag = chk[i].checked;
            } else {
                if (tmpId.indexOf(str) == 0)
                    chk[i].checked = flag;
            }
        }
    }

    function setSelectedNode() {
        var selNodes = document.all("formCreditCode:selectedQueryNodes").value;
        if (selNodes != null && selNodes != "") {
            var chk = document.all("checkitem1");
            var size = chk.length;
            var nodeId;
            for (i = 0; i < size; i++) {
                nodeId = '~' + chk[i].value + '~';
                if (selNodes.indexOf(nodeId) != -1) {
                    chk[i].checked = true;
                }
            }
        }
        selNodes = document.all("formCreditCode:selectedOperateNodes").value;
        if (selNodes != null && selNodes != "") {
            var chk = document.all("checkitem2");
            var size = chk.length;
            var nodeId;
            for (i = 0; i < size; i++) {
                nodeId = '~' + chk[i].value + '~';
                if (selNodes.indexOf(nodeId) != -1) {
                    chk[i].checked = true;
                }
            }
        }
    }

    function qTreeCheckAll(srcNode) {
        qTree.oncheck = null;
        selectSub(srcNode, 'checkitem1');
        qTree.oncheck = qTreeCheckAll;
    }
    function qTreeNoCheck(srcNode) {
        qTree.oncheck = null;
        nid = srcNode.getKey();
        var chk = document.all('checkitem1');
        var size = chk.length;
        var selNodes;
        for (i = 0; i < size; i++) {
            if (chk[i].value == nid)
                chk[i].checked = !chk[i].checked;
        }
        qTree.oncheck = qTreeNoCheck;
    }

    function oTreeCheckAll(srcNode) {
        oTree.oncheck = null;
        selectSub(srcNode, 'checkitem2');
        oTree.oncheck = oTreeCheckAll;
    }
    function oTreeNoCheck(srcNode) {
        oTree.oncheck = null;
        nid = srcNode.getKey();
        var chk = document.all('checkitem2');
        var size = chk.length;
        var selNodes;
        for (i = 0; i < size; i++) {
            if (chk[i].value == nid)
                chk[i].checked = !chk[i].checked;
        }
        oTree.oncheck = oTreeNoCheck;
    }
</script>
</c:verbatim>

<h:form id="formCreditCode">
<h:inputHidden id="pageInit" value="#{user_codeScaleBB.pageInit}"/>
<h:inputHidden id="selectedQueryNodes" value="#{user_codeScaleBB.selectedQueryNodes}"/>
<h:inputHidden id="selectedOperateNodes" value="#{user_codeScaleBB.selectedOperateNodes}"/>
<h:inputHidden id="pageFlag" value="#{user_codeScaleBB.pageFlag}"/>
<h:inputHidden value="#{user_codeScaleBB.paramId}"/>
<h:inputHidden id="manageFlag" value="#{user_codeScaleBB.manageFlag}"/>
<c:verbatim>
<table width="100%" height="100%"  class="table03" cellpadding="0" >
<tr>
    <td  align="right" width="50%"  >
        <script language="javascript" src="../../js/floater.js"></script>
    <div id="floater" style="position:absolute; width:120px; z-index:1; height: 60px; left: 580px;">
</c:verbatim>
        <h:commandButton value="保 存" id="save" styleClass="button01" onclick="return getSelectedNode()"
                                     action="#{user_codeScaleBB.updateRoleCode}"></h:commandButton></div></td>
<c:verbatim>
</tr>
<tr>
<td width="100%" height="100%" align="left" valign="top">
        <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="1" bordercolor="#999999">
            <tr>
                <td bgcolor="#FFFFFF" align="left" valign="left" width="40%">
                    <div id="dt1"></div>
                    <script language="JavaScript">
                        //定义树的图片对象
                        var qImages = getTreeImage();

                        //初始化树
                        var qTree = new newtree(qImages, 16, dt1)
                        var qRoot = qTree.root
                        var qT0000 = qTree.addChkNode(qRoot, "last", "查询范围", "0000", "0001", "", "folder", "", "", false, true, 'checkitem1', '0000', '0001');
                        <%
                              List list1 =(List)request.getAttribute("user_querycode") ;
                              if(list1!=null && list1.size()!=0){
                                  for(int i=0;i<list1.size();i++){
                                      CodeItemBO item =(CodeItemBO) list1.get(i);
                                      if(item.getSetId().equals("0188")){
                                    	  continue;
                                      }
                                      StringBuffer sf = new StringBuffer();
                                      sf.append("var qT")
                                      .append(item.getItemId()).append("=qTree.addChkNode(");
                                      String superId =item.getItemSuper();
                                      if("-1".equals(superId)){
                                          sf.append("qT0000,'last','")
                                          .append(item.getItemName())
                                          .append("','")
                                          .append(item.getItemId())
                                          .append("','0001")
                                          .append(item.getTreeId())
                                          .append("','','folder','','',false,true,'checkitem1','")
                                          .append(item.getItemId())
                                          .append("','0001")
                                          .append(item.getTreeId())
                                          .append("');");
                                      }
                                      else{
                                          sf.append("qT").append(superId);
                                          sf.append(",'last','")
                                          .append(item.getItemName())
                                            .append("','")
                                          .append(item.getItemId())
                                          .append("','0001")
                                          .append(item.getTreeId())
                                          .append("','','folder','','',false,true,'checkitem1','")
                                          .append(item.getItemId())
                                          .append("','0001")
                                          .append(item.getTreeId())
                                          .append("');");
                                      }
                                      out.println(sf.toString());
                                  }
                              }
                        %>
                        qTree.expandAll(false);
                    </script>
                </td>
                <td width="60%"  align="left" valign="top">
                <div id="dt2"></div>
                    <script language="JavaScript">
                        //定义树的图片对象
                        var oImages = getTreeImage();
                        //初始化树
                        var oTree = new newtree(oImages, 16, dt2)
                        var oRoot = oTree.root
                        var oT0000 = oTree.addChkNode(oRoot, "last", "维护范围", "0000", "0001", "", "folder", "", "", false, true, 'checkitem2', '0000', '0001');

                        <%
                              List list2 =(List)request.getAttribute("SYS_OPERATEcode") ;
                              if(list2!=null && list2.size()!=0){
                                  for(int i=0;i<list2.size();i++){
                                      CodeItemBO item =(CodeItemBO) list2.get(i);
                                      if(item.getSetId().equals("0188")){
                                    	  continue;
                                      }
                                      StringBuffer sf = new StringBuffer();
                                      sf.append("var oT")
                                      .append(item.getItemId()).append("=oTree.addChkNode(");
                                      String superId =item.getItemSuper();
                                      if("-1".equals(superId)){
                                          sf.append("oT0000,'last','")
                                          .append(item.getItemName())
                                          .append("','")
                                          .append(item.getItemId())
                                          .append("','0001")
                                          .append(item.getTreeId())
                                          .append("','','folder','','',false,true,'checkitem2','")
                                          .append(item.getItemId())
                                          .append("','0001")
                                          .append(item.getTreeId())
                                          .append("');");
                                      }
                                      else{
                                          sf.append("oT").append(superId);
                                          sf.append(",'last','")
                                          .append(item.getItemName())
                                            .append("','")
                                          .append(item.getItemId())
                                          .append("','0001")
                                          .append(item.getTreeId())
                                          .append("','','folder','','',false,true,'checkitem2','")
                                          .append(item.getItemId())
                                          .append("','0001")
                                          .append(item.getTreeId())
                                          .append("');");

                                      }
                                      out.println(sf.toString());
                                  }
                              }

                        %>
                        oTree.expandAll(false);
                        //设置以选择的代码
                        setSelectedNode();
                        var oFlag = document.all("formCreditCode:pageFlag").value;
                        /// debugger;
                        if (oFlag == "1"){  //角色权限设置
                            oTree.oncheck = oTreeCheckAll;
                            qTree.oncheck = qTreeCheckAll;
                        }
                        else{          //用户权限浏览
                            oTree.oncheck = oTreeNoCheck;
                            qTree.oncheck = qTreeNoCheck;
                            document.all("formCreditCode:save").style.display = "none";
                        }
                    </script>
                </td>
                </tr>
         </table>
</td>
</tr>
</table>
</c:verbatim>
<script type="text/javascript">
    function getSelectedNode() {
        var chk = document.all("checkitem1");
        var size = chk.length;
        var selQueryNodes = "";
        for (i = 0; i < size; i++) {
            // debugger;
            if (chk[i].checked) {
                if (chk[i].value != null && chk[i].value != "0000")
                {
                    if (selQueryNodes != '')
                        selQueryNodes += ",";
                    selQueryNodes += '~' + chk[i].value + '~';
                }
            }
        }
        document.all("formCreditCode:selectedQueryNodes").value = selQueryNodes;

        var selOperateNodes = "";
        chk = document.all("checkitem2");
        size = chk.length;
        selOperateNodes = "";
        for (i = 0; i < size; i++) {
            // debugger;
            if (chk[i].checked) {
                if (chk[i].value != null && chk[i].value != "0000")
                {
                    if (selOperateNodes != '')
                        selOperateNodes += ",";
                    selOperateNodes += '~' + chk[i].value + '~';
                }
            }
        }
        document.all("formCreditCode:selectedOperateNodes").value = selOperateNodes;
        //检测维护范围是否小于等于查询范围
        var arryNodes =selOperateNodes.split(",");
        for(var i=0;i<arryNodes.length;i++){
            if(selQueryNodes.indexOf(arryNodes[i])==-1){
                alert("维护范围不得大于查询范围,请重新选择！");
                return false;
            }
        }
        return true;
    }
</script>
</h:form>
