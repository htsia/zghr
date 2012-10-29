<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.web.SelfInfoListBackingBean" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.user.pojo.vo.InfoSetPermissionVO" %>
<%@ page import="com.hr319wg.user.pojo.vo.InfoItemPermissionVO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>

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
        for (i = obj.se; i < eCount && i < count; i++)
        {
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

<x:saveState value="#{sys_selfinfoPowerBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{sys_selfinfoPowerBB.pageInit}"/>
    <f:verbatim>
    <table width="100%" height="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td height="1">
        <table width="100%"  border="0" cellspacing="2" cellpadding="0">
        <tr>
          <td width="55%" align="left">
             <strong>
                <%
                 User user = (User)session.getAttribute(Constants.USER_INFO);
                 out.println(LanguageSupport.getResource("XTGL-1055","当前单位:")+user.getOrgName());
             %>
             </strong>
          </td>

          <td width="30%" align="right">
           <%=LanguageSupport.getResource("XTGL-1075","操作所有选项 ")%>  
          <input type="radio" name="all" value="1" onclick="checkAll('1')"><%=LanguageSupport.getResource("XTGL-1074","拒绝 ")%>  
          <input type="radio" name="all" value="2" onclick="checkAll('2')"><%=LanguageSupport.getResource("XTGL-1076","读")%>  
          <input type="radio" name="all" value="3" onclick="checkAll('3')"><%=LanguageSupport.getResource("XTGL-1077"," 写")%>
          </td>

          <td align="right">
	    </f:verbatim>
	                <h:commandButton id="save" styleClass="button01" value="保存"   action="#{sys_selfinfoPowerBB.Save}"></h:commandButton>
	<f:verbatim>
	       </td>
       </tr>
       </table>
       </td><tr><td><div style='width:100%;height:98%;overflow:auto' id=datatable>
<%
    List setList = (List) request.getAttribute(SelfInfoListBackingBean.INFOSET_NAME);
    Hashtable itemhash = (Hashtable) request.getAttribute(SelfInfoListBackingBean.INFOITEM_NAME);

    setList = (List) CommonFuns.filterNull(List.class, setList);
    itemhash = (Hashtable) CommonFuns.filterNull(Hashtable.class, itemhash);

    int len = setList.size();
    int loc = 7;
    for (int i = 0; i < len; i++) {        //控制表的个数
        String setId = ((InfoSetPermissionVO) setList.get(i)).getSetId();
        String setName = ((InfoSetPermissionVO) setList.get(i)).getSetName();
        String setpms = ((InfoSetPermissionVO) setList.get(i)).getPermission();

        List items = (List) itemhash.get(setId);
        int size = 0;
        if (items != null)
            size = items.size();
%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td width="19"><img id="img<%=setId%>" onclick="head('field<%=setId%>','img<%=setId%>');"
                            src="../../images/tree_03.gif" width="19" height="20"></td>
        <td width="19"><img src="../../images/tree_30.gif" width="19" height="20"></td>
        <td nowrap width="300" align="left" class="<%=(i%2==0)?"td08":"td07"%>">　<%=setName+"("+setId+")"%></td>
        <td class="<%=(i%2==0)?"td08":"td07"%>"><%=LanguageSupport.getResource("XTGL-1078","表权限")%> </td>
        <td class="<%=(i%2==0)?"td08":"td07"%>">
            <input type="radio" name="tab<%=setId%>"
                   value="1" <%=("1".equals(setpms))?"checked":""%>
                   onclick="checkSub(this,<%=size%>)" se="<%=loc++%>"><%=LanguageSupport.getResource("XTGL-1074","拒绝 ")%>  
            <input type="radio" name="tab<%=setId%>"
                   value="2" <%=("2".equals(setpms))?"checked":""%>
                   onclick="checkSub(this,<%=size%>)" se="<%=loc++%>"><%=LanguageSupport.getResource("XTGL-1076","读")%>  
            <input type="radio" name="tab<%=setId%>"
                   value="3" <%=("3".equals(setpms))?"checked":""%>
                   onclick="checkSub(this,<%=size%>)" se="<%=loc++%>"><%=LanguageSupport.getResource("XTGL-1077"," 写")%>
        </td>
    </tr>
</table>

<div id="field<%=setId%>" style="DISPLAY: none">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="19" background="../../images/tree_06.gif">&nbsp;</td>
            <td width="19">&nbsp;</td>
            <td><br>
                <%
                    if (items != null) {
                        int tmp = 0;
                        if (size % 3 != 0)
                            tmp = 3 - size % 3;      //为了控制最后一行的显示
                %>
                <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="td07">
                    <%
                        for (int j = 0; j < size + tmp; j++) {       //控制行数
                            if (j % 3 == 0) {
                    %>
                    <tr nowrap>
                        <%
                            for (int k = j; k < j + 3; k++) {
                                if (k < size) {
                                    String itemId = ((InfoItemPermissionVO) items.get(k)).getItemId();
                                    String itemName = ((InfoItemPermissionVO) items.get(k)).getItemName();
                                    String itempms = ((InfoItemPermissionVO) items.get(k)).getPermission();
                        %>
                        <td align="left" nowrap class="td09"><%=itemName%></td>
                        <td bgcolor="#FFFFFF" nowrap>
                            <input type="radio" name="fld<%=itemId%>"
                                   value="1" <%=("1".equals(itempms))?"checked":""%>
                                   se="<%=loc++%>"><%=LanguageSupport.getResource("XTGL-1074","拒绝 ")%>  
                            <input type="radio" name="fld<%=itemId%>"
                                   value="2" <%=("2".equals(itempms))?"checked":""%>
                                   se="<%=loc++%>" ><%=LanguageSupport.getResource("XTGL-1076","读")%> 
                            <input type="radio" name="fld<%=itemId%>"
                                   value="3" <%=("3".equals(itempms))?"checked":""%>
                                   se="<%=loc++%>" ><%=LanguageSupport.getResource("XTGL-1077"," 写")%>
                            </td>

                        <%
                        } else {     //最后一行缺少的补充空格
                        %>
                        <td align="left" nowrap class="td09">&nbsp;</td>
                        <td bgcolor="#FFFFFF" nowrap>&nbsp;</td>
                        <%
                                }
                            }
                        %>
                    </tr>
                    <%
                            }
                        }
                    %>
                </table>
                <%
                    }   //end if
                %>
                <br></td>
        </tr>
    </table>
</div>
<%
    }  //end for
%>
</div>
</td>
</tr>
    </table>
</f:verbatim>
</h:form>