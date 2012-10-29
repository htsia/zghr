<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ include file="../include/taglib.jsp" %>

<c:verbatim>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree_check.js"></script>
<script type="text/javascript">
    function selectSub(obj, obj2) {
     //tree.oncheck = null;
     // debugger;
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
 function getSelectedNode() {
     var selOperateNodes = "";
     chk = document.all("checkitem2");
     size = chk.length;
     selOperateNodes = "";
     for (i = 0; i < size; i++) {
         if (chk[i].checked) {
             if (chk[i].value != null && chk[i].value != "0000")
             {
                 if (selOperateNodes != '')
                     selOperateNodes += ",";
                 selOperateNodes += '~' + chk[i].value + '~';
             }
         }
     }
     document.all("formCreditPostCode:selectedOperateNodes").value = selOperateNodes;
      return true;
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

    function setSelectedNode() {
        selNodes = document.all("formCreditPostCode:selectedOperateNodes").value;
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
</script>    
</c:verbatim>

<h:form id="formCreditPostCode">
<h:inputHidden id="pageInit" value="#{user_postCodeScaleBB.pageInit}"/>
<h:inputHidden id="selectedOperateNodes" value="#{user_postCodeScaleBB.selectedOperateNodes}"/>
<h:inputHidden id="pageFlag" value="#{user_postCodeScaleBB.pageFlag}"/>
<h:inputHidden value="#{user_postCodeScaleBB.paramId}"/>
<h:inputHidden id="manageFlag" value="#{user_postCodeScaleBB.manageFlag}"/>

<c:verbatim>
<table width="100%" height="100%"  class="table03" cellpadding="0" >
<tr>
    <td  align="right" width="50%"  >
        <script language="javascript" src="../../js/floater.js"></script>
    <div id="floater" style="position:absolute; width:120px; z-index:1; height: 60px; left: 580px;">
</c:verbatim>
        <h:commandButton value="保 存" id="save" styleClass="button01" onclick="return getSelectedNode()"
                                     action="#{user_postCodeScaleBB.updateRoleCode}"></h:commandButton></div></td>
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
                            var oImages = getTreeImage();

                            //初始化树
                            var oTree = new newtree(oImages, 16, dt1)
                            var oRoot = oTree.root
                            var oT0000 = oTree.addChkNode(oRoot, "last", "维护范围", "0000", "0001", "", "folder", "", "", false, true, 'checkitem2', '0000', '0001');

                            <%
                                  List list2 =(List)request.getAttribute("SYS_OPERATEcode") ;

                                  if(list2!=null && list2.size()!=0){
                                      for(int i=0;i<list2.size();i++){
                                          CodeItemBO item =(CodeItemBO) list2.get(i);
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
                            var oFlag = document.all("formCreditPostCode:pageFlag").value;
                            /// debugger;
                            if (oFlag == "1"){  //角色权限设置
                                oTree.oncheck = oTreeCheckAll;

                            }
                            else {         //用户权限浏览
                                oTree.oncheck = oTreeNoCheck;
                                document.all("formCreditPostCode:save").style.display = "none";
                            }
                        </script>
                </td>
                <td width="60%"  align="left" valign="top">
                    <div id="dt2"></div>
                </td>
                </tr>
             </table>
</td>
</tr>
</table>
</c:verbatim>
</h:form>
