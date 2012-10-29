<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.user.pojo.bo.SelfOperateBO" %>

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

                //如果字节点选中，父节点也选中
                if(flag && tmpId != str){
                    if(str.indexOf(tmpId)==0){
                        chk[i].checked=true;
                    }
                }
            }
        }
        function getSelectedNode(nodeName) {
            var chk = document.all(nodeName);
            var size = chk.length;
            var selNodes="";
            for (i = 0; i < size; i++) {
               // debugger;
                if (chk[i].checked) {
                    if (chk[i].value != null && chk[i].value != "0000")
                    {
                        if (selNodes!='')
                            selNodes += ",";
                        selNodes += '~' + chk[i].value + '~';
                    }
                }
            }
            document.all("formSelfOperate:selectedNodes").value = selNodes;
            return true;
        }

        function setSelectedNode(nodeName) {

            var selNodes = document.all("formSelfOperate:selectedNodes").value;
            if (selNodes != null && selNodes != "") {
                var chk = document.all(nodeName);
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

        function checkall(srcNode) {
            tree.oncheck = null;
            selectSub(srcNode, 'checkitem');
            tree.oncheck = checkall;
        }
        function nocheck(srcNode) {
            tree.oncheck = null;
            nid = srcNode.getKey();
            var chk = document.all('checkitem');
            var size = chk.length;
            var selNodes;
            for (i = 0; i < size; i++) {
                if (chk[i].value == nid)
                    chk[i].checked = !chk[i].checked;
            }
            tree.oncheck = nocheck;
        }
    </script>
</c:verbatim>
<h:form id="formSelfOperate">
    <h:inputHidden id="pageInit" value="#{SYS_OPERATEBB.initSelfPower}"/>
    <h:inputHidden id="selectedNodes" value="#{SYS_OPERATEBB.selectedNodes}"/>
    <h:inputHidden id="pageFlag" value="#{SYS_OPERATEBB.pageFlag}"/>
    <h:inputHidden  value="#{SYS_OPERATEBB.manageFlag}"/>
    <h:inputHidden value="#{SYS_OPERATEBB.paramId}"/>

    <c:verbatim>
    <table width="100%" border="0" cellspacing="2" cellpadding="0">
    <tr>
        <td align="right">
        <script language="javascript" src="../../js/floater.js"></script>
           <div id="floater" style="position:absolute; width:120px; z-index:1; height: 23px; left: 580px;">
</c:verbatim>
                  <h:commandButton id="save" styleClass="button01" value="保存" onclick="return getSelectedNode('checkitem')"  action="#{SYS_OPERATEBB.updateRoleSelfPower}"></h:commandButton>
<c:verbatim>
            </div>
        </td>
    </tr>

    <tr>
        <td>
            <table width="100%" border="0" align="center" cellpadding="10" cellspacing="1" bordercolor="#999999">
                <tr>
                    <td bgcolor="#FFFFFF">
                        <div id="dt"></div>
                        <script language="JavaScript">
                            //定义树的图片对象
                            var flag = false;
                            var images = getTreeImage();

                              //初始化树
                            var tree = new newtree(images, 16, dt);
                            var root = tree.root;
                            var operRoot = tree.addChkNode(root, "last", "自助权限列表", "0000", "0001", "", "folder", "", "", false, true, 'checkitem', '0000', '0001');

                            <%
                                 List list = (List) request.getAttribute("SYS_SELF_OPERATE");
                                 if(list!=null && list.size()!=0){
                                      for(int i=0;i<list.size();i++){
                                          SelfOperateBO item =(SelfOperateBO) list.get(i);
                                          StringBuffer sf = new StringBuffer();
                                          sf.append("var t")
                                          .append(item.getOperateId()).append("=tree.addChkNode(");
                                          String superId =item.getSuperId();
                                          if("-1".equals(superId)){
                                              sf.append("operRoot,'last','")
                                              .append(item.getOperateName())
                                              .append("','")
                                              .append(item.getOperateId())
                                              .append("','0001")
                                              .append(item.getTreeId())
                                              .append("','','folder','','',false,true,'checkitem','")
                                              .append(item.getOperateId())
                                              .append("','0001")
                                              .append(item.getTreeId())
                                              .append("');");
                                          }
                                          else{
                                              sf.append("t").append(superId);
                                              sf.append(",'last','")
                                              .append(item.getOperateName())
                                                .append("','")
                                              .append(item.getOperateId())
                                              .append("','0001")
                                              .append(item.getTreeId())
                                              .append("','','folder','','',false,true,'checkitem','")
                                              .append(item.getOperateId())
                                              .append("','0001")
                                              .append(item.getTreeId())
                                              .append("');");
                                          }
                                          out.println(sf.toString());
                                      }
                                  }
                            %>

                            tree.expandAll(false);
                            setSelectedNode('checkitem');

                            var pflag = document.all("formSelfOperate:pageFlag").value;
                            if (pflag == "1")  //角色权限设置
                                tree.oncheck = checkall;
                            else{          //用户权限浏览
                                tree.oncheck = nocheck;
                                document.all("formSelfOperate:save").style.display = "none";
                            }
                        </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </table>
 </c:verbatim>
</h:form>
