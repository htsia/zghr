<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.user.pojo.vo.InfoItemPermissionVO" %>
<%@ page import="com.hr319wg.user.pojo.vo.InfoSetPermissionVO" %>
<%@ page import="com.hr319wg.user.web.DatalistBackingBean" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<script language="javascript" src="<%=request.getContextPath()%>/js/tree2.js"></script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language=javascript>
    function checkAll(radiovalue) {
        var eCount = document.forms(0).elements.length;
        for (i = 4; i < eCount; i++){
            rvalue=document.forms(0).elements[i].value;
            if(rvalue==radiovalue){
                document.forms(0).elements[i].checked = true;
            }
            ename = document.forms(0).elements[i].name;
            if(ename!=null && ename.length>3){
                tabname = ename.substring(0,3);
                if(tabname=="fld" && rvalue > radiovalue){
                   document.forms(0).elements[i].disabled=true;
                } else{
                   document.forms(0).elements[i].disabled=false;
                }
            }
        }
    }

    function checkSub(obj, num) {
        var eCount = document.forms(0).elements.length;
        count = (num+1) * 3  + 3+parseInt(obj.se);
        //每个字段有3个radio
        for (i = obj.se; i < eCount && i < count; i++){
            tabname = obj.name.substring(3, obj.name.length);
            fldname = document.forms(0).elements[i].name;
            fldname = fldname.substring(3, fldname.length);
            if (fldname.indexOf(tabname) == 0) {
                rvalue = document.forms(0).elements[i].value;
                //如果是当前的checkBox是指标项，如果比表权限小，则控制其为无效
             //  alert(fldname.length);
                if(fldname.length ==7){
                    if(rvalue > obj.value)
                        document.forms(0).elements[i].disabled = true;
                    else
                        document.forms(0).elements[i].disabled = false;
                }
                if (rvalue == obj.value)
                     document.forms(0).elements[i].checked = true;
            }
        }
    }

</script>
<x:saveState value="#{user_dataListBB}"/>
<h:form id="formCreditDataInfo">
<h:inputHidden id="pageInit" value="#{user_dataListBB.pageInit}"/>
<h:inputHidden id="pageFlag" value="#{user_dataListBB.pageFlag}"/>
<h:inputHidden id="manageFlag" value="#{user_dataListBB.manageFlag}"/>
<h:inputHidden id="sType" value="#{user_dataListBB.sType}"/>
<h:inputHidden value="#{user_dataListBB.paramId}"/>
<c:verbatim>
    <table width="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td>
            <table width="100%"  border="0" cellspacing="2" cellpadding="0">
                <tr>
                  <td width="45%"> </td>
                  <td width="40%" align="right">
                      <input type="radio" name="all" value="1" onclick="checkAll('1')">拒绝
                      <input type="radio" name="all" value="2" onclick="checkAll('2')">读
                      <input type="radio" name="all" value="3" onclick="checkAll('3')">写
                  </td>
        
                  <td align="right">
                      <script language="javascript" src="../../js/floater.js"></script>
                      <div id="floater" style="position:absolute; width:120px; z-index:1; height: 3px; left: 370px;">
</c:verbatim>
                        <h:commandButton id="save" styleClass="button01" value="保存"   action="#{user_dataListBB.updateRoleData}"></h:commandButton>
<c:verbatim>
                     </div>
                  </td>
               </tr>
           </table>
        <br>
</c:verbatim>
<%
    Hashtable dataList = (Hashtable) request.getAttribute(DatalistBackingBean.DATALIST_NAME);
    List setList = (List) request.getAttribute(DatalistBackingBean.INFOSET_NAME);
    Hashtable itemhash = (Hashtable) request.getAttribute(DatalistBackingBean.INFOITEM_NAME);
    if (dataList == null) dataList = new Hashtable();
    if (setList == null) setList = new ArrayList();
    if (itemhash == null) itemhash = new Hashtable();
    int len = setList.size();
    int loc = 7;
    for (int i = 0; i < len; i++) {        //控制表的个数
        String setId = ((InfoSetPermissionVO) setList.get(i)).getSetId();
        String setName = ((InfoSetPermissionVO) setList.get(i)).getSetName();
        String setpms = ((InfoSetPermissionVO) setList.get(i)).getPermission();
        //管理员权限
        if (setpms == null || setpms.equals(""))
            setpms = "2";
        int sysOperSetPms = Integer.parseInt(setpms);
        //角色权限
        String roleSetPms;
        if (dataList.get(setId) == null)
            roleSetPms = "2";  //默认只读
        else
            roleSetPms = (String) dataList.get(setId);

        List items = (List) itemhash.get(setId);
        int size = 0;
        if (items != null)
            size = items.size();
%>
<c:verbatim>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td width="19"><img id="img<%=setId%>" onclick="head('field<%=setId%>','img<%=setId%>');"
                            src="../../images/tree_03.gif" width="19" height="20"></td>
        <td width="19"><img src="../../images/tree_30.gif" width="19" height="20"></td>
        <td nowrap width="260" align="left" class="<%=(i%2==0)?"td08":"td07"%>">　<%=setName%></td>
        <td class="<%=(i%2==0)?"td08":"td07"%>">表权限</td>
        <td class="<%=(i%2==0)?"td08":"td07"%>">
</c:verbatim>
            <% if (sysOperSetPms >= 1) {%>
            <c:verbatim><input type="radio" name="tab<%=setId%>"
                   value="1" <%=("1".equals(roleSetPms) || 1==sysOperSetPms)?"checked":""%>
                   onclick="checkSub(this,<%=size%>)" se="<%=loc++%>">拒绝</c:verbatim>
            <%
                }
                if (sysOperSetPms >= 2) {
            %>

            <c:verbatim><input type="radio" name="tab<%=setId%>"
                   value="2" <%=("2".equals(roleSetPms))?"checked":""%>
                   onclick="checkSub(this,<%=size%>)" se="<%=loc++%>">读</c:verbatim>
            <%
                }
                if (sysOperSetPms >= 3) {
            %>
            <c:verbatim><input type="radio" name="tab<%=setId%>"
                   value="3" <%=("3".equals(roleSetPms))?"checked":""%>
                   onclick="checkSub(this,<%=size%>)" se="<%=loc++%>">写</c:verbatim>
            <%}%>
<c:verbatim>
        </td>
    </tr>
</table>

<div id="field<%=setId%>" style="DISPLAY: none">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="19" background="../../images/tree_06.gif">&nbsp;</td>
            <td width="19">&nbsp;</td>
            <td><br>
</c:verbatim>
                <%
                    if (items != null) {
                        int tmp = 0;
                        if (size % 3 != 0)
                            tmp = 3 - size % 3;      //为了控制最后一行的显示
                %>
                <c:verbatim><table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="td07"></c:verbatim>
                    <%
                        for (int j = 0; j < size + tmp; j++) {       //控制行数
                            if (j % 3 == 0) {
                    %>
                    <c:verbatim><tr nowrap></c:verbatim>
                        <%
                            for (int k = j; k < j + 3; k++) {
                                if (k < size) {
                                    String itemId = ((InfoItemPermissionVO) items.get(k)).getItemId();
                                    String itemName = ((InfoItemPermissionVO) items.get(k)).getItemName();
                                    String itempms = ((InfoItemPermissionVO) items.get(k)).getPermission();
                                    if (itempms == null || itempms.equals(""))
                                        itempms = "2";
                                    //管理员权限
                                    int sysOperItemPms = Integer.parseInt(itempms);
                                    //  System.out.println("指标集权限:" + itemId + dataList.get(itemId));
                                    //角色权限
                                    String roleItemPms;
                                    if (dataList.get(itemId) == null)
                                        roleItemPms = "2";  //默认只读
                                    else
                                        roleItemPms = (String) dataList.get(itemId);
                        %>
                        <c:verbatim><td align="left" nowrap class="td09"><%=itemName%></td>
                        <td bgcolor="#FFFFFF" nowrap></c:verbatim>
                            <% if (sysOperItemPms >= 1) {%>
                            <c:verbatim><input type="radio" name="fld<%=itemId%>"
                                   value="1" <%=("1".equals(roleItemPms) || 1==sysOperItemPms)?"checked":""%>
                                   se="<%=loc++%>">拒绝</c:verbatim>
                            <%
                                }
                                if (sysOperItemPms >= 2) {
                            %>
                            <c:verbatim><input type="radio" name="fld<%=itemId%>"  <%=(2<=Integer.parseInt(roleSetPms))?"":"disabled"%>
                                   value="2" <%=("2".equals(roleItemPms))?"checked":""%>
                                   se="<%=loc++%>" >读</c:verbatim>
                            <%
                                }
                                if (sysOperItemPms >= 3) {
                            %>
                            <c:verbatim><input type="radio" name="fld<%=itemId%>" <%=("3".equals(roleSetPms))?"":"disabled"%>
                                   value="3" <%=("3".equals(roleItemPms))?"checked":""%>
                                   se="<%=loc++%>" >写</c:verbatim>
                            <%}%>
                        <c:verbatim></td></c:verbatim>
                        <%
                        } else {     //最后一行缺少的补充空格
                        %>
                        <c:verbatim>
                        <td align="left" nowrap class="td09">&nbsp;</td>
                        <td bgcolor="#FFFFFF" nowrap>&nbsp;</td>
                        </c:verbatim>
                        <%
                                }
                            }
                        %>
                    <c:verbatim></tr></c:verbatim>
                    <%
                            }
                        }
                    %>
                <c:verbatim></table></c:verbatim>
                <%
                    }   //end if
                %>
                <c:verbatim>
                <br></td>
        </tr>
    </table>
</div>
</c:verbatim>
<%
    }  //end for
%>
<c:verbatim>
</td>
</tr>
    </table>

    <script type="text/javascript">
          var pflag = document.all("formCreditDataInfo:pageFlag").value;
          if (pflag != "1"){
              document.all("formCreditDataInfo:save").style.display = "none";
              var elms = document.forms(0).elements;
              for(i=0;i<elms.length;i++){
                  if(elms[i].type == 'radio'){
                      elms[i].disabled = true;
                  }
              }
          }
    </script>
</c:verbatim>
</h:form>
