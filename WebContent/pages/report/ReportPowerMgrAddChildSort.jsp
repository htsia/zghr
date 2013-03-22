<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.rpt.ucc.IRptInfoUCC" %>
<%@ page import="com.hr319wg.user.pojo.bo.UserRptBO" %>
<%@ page import="com.hr319wg.rpt.pojo.bo.RptClassBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>

<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String roleID = request.getParameter("roleID");
    String operID = request.getParameter("operID");
    IRptInfoUCC rc=null;
    List list=null;
    try {
        rc = (IRptInfoUCC) SysContext.getBean("rpt_infoucc");
        list = rc.getUserRptBO(roleID,operID);
    }
    catch (Exception e) {

    }
%>

    <script type="text/javascript">
        function moveUP(){
            if (!isNature(document.all('form1:step').value)){
                alert("移动位数非法！");
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
              move(document.all.showItem,0);
            }
        }
        function moveDown(){
            if (!isNature(document.all('form1:step').value)){
                alert("移动位数非法！");
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
              move(document.all.showItem,1);
            }
        }

        //0-up; 1-down;
        function move(obj, flag) {
            if (obj == null)
                return;
            if (flag == 0) {
                for (i = 0; i < obj.options.length; i++) {
                    if (obj.options[i].selected) {
                        if (i == 0) return;
                        tmpvalue = obj.options[i].value;
                        tmptext = obj.options[i].text;
                        tmp = document.createElement("option");
                        tmp.value = tmpvalue;
                        tmp.text = tmptext;
                        obj.add(tmp, i - 1);
                        obj.remove(i + 1);
                        tmp.selected = true;
                        document.all.showItem.scrollTop = document.all.showItem.scrollTop+5;
                    }
                }
                if(document.body.scrollTop > 10){
                    document.body.scrollTop += -10;
                }
            } else {
                for (i = obj.options.length - 1; i >= 0; i--) {
                    if (obj.options[i].selected) {
                        if (i == (obj.length - 1)) return;
                        tmp = document.createElement("option");
                        tmp.value = obj.options[i].value;
                        tmp.text = obj.options[i].text;
                        obj.add(tmp, i + 2);
                        obj.remove(i);
                        tmp.selected = true;

                    }
                }
                document.body.scrollTop += 10;
            }
        }

        function movetop(obj) {
            for (i = 0; i < obj.options.length; i++) {
                if (obj.options[i].selected) {
                    if (i == 0) return;
                    tmpvalue = obj.options[i].value;
                    tmptext = obj.options[i].text;
                    tmp = document.createElement("option");
                    tmp.value = tmpvalue;
                    tmp.text = tmptext;
                    obj.add(tmp, 0);
                    obj.remove(i + 1);
                    tmp.selected = true;
                }
            }
        }

        function movebottom(obj) {
            for (i = 0; i < obj.options.length; i++) {
                if (obj.options[i].selected) {
                    if (i == (obj.length - 1)) return;
                    tmp = document.createElement("option");
                    tmp.value = obj.options[i].value;
                    tmp.text = obj.options[i].text;
                    obj.add(tmp, obj.length);
                    obj.remove(i);
                    tmp.selected = true;

                }
            }
        }

        function forSave() {
            if (confirm("确认排序?")) {
                for (i = 0; i < form1.showItem.options.length; i++) {
                    form1.showItem.options[i].selected = true;
                }
                return true;
            } else {
                return false;
            }
        }
    </script>

<x:saveState value="#{Rpt_PowerMgrBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{Rpt_PowerMgrBB.pageInits}"/>
<c:verbatim>
    <table align=center width="80%" border="0" cellpadding="2" cellspacing="0">
</c:verbatim>
        <%
            if (list != null && list.size() > 0) {
        %>
<c:verbatim>
        <tr>
            <td class="td_middle" width="90%">
                <select name="showItem" size="28" multiple id="showItem" style="width:100%;">
                    <%
                        for (int i = 0; i < list.size(); i++) {
                        	UserRptBO userrptbo = (UserRptBO) list.get(i);
                        	RptClassBO bos= rc.getRptClass(userrptbo.getRptCode());
            					if(bos.getRptDesc()!=null && !"".equals(bos.getRptDesc())){
            						userrptbo.setRptCodeName(bos.getRptDesc());
            					}else{
            						userrptbo.setRptCodeName("");
            					}
                    %>
                    <option value="<%=userrptbo.getContEntid()%>"><%=userrptbo.getRptCodeName()%></option>
                    <%
                        }
                    %>
                </select>

            </td>
            <td class="td_middle" align=right width="10%">
                <p>
                    <input type=button class=button01 style="width:70px" value='移至顶部' onclick="movetop(showItem)">
                </p>

                <p>
                    <input type=button class=button01 style="width:70px" value='上移' onclick="moveUP();">
                </p>

                <p>
                    <input name=save2 type=button class=button01 style="width:70px" value='下移'
                           onclick="moveDown();">
                </p>

                <p>
                    <input type=button class=button01 style="width:70px" value='移至底部' onclick="movebottom(showItem)">
                </p>
            </td>
        </tr>
        <br>
        <tr>
            <td class="td_top"  align="left">
              <h:outputText value="每次移动位数:"/>
              <h:inputText id="step" value="1" />
            </td>
            <td class="td_top"   align="right">
</c:verbatim>
              <h:commandButton value="保  存"   styleClass="button01"    onclick="return forSave();"   action="#{Rpt_PowerMgrBB.saveSort}"/>
<c:verbatim>
            </td>
        </tr>
</c:verbatim>
        <%
        } else {
        %>
<c:verbatim>
        <tr>
            <br>
            <td  colspan="2" align="center"> 无查询记录！</td>
        </tr>
</c:verbatim>
        <%
            }
        %>
<c:verbatim>
    </table>
</c:verbatim>
</h:form>
