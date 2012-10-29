<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = request.getParameter("superId");
    String flag = CommonFuns.filterNull(request.getParameter("flag"));
    if (superId == null || "".equals(superId)) {
        superId = (String) request.getAttribute("superId");
    }

    List list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
%>

    <script type="text/javascript">
        function moveUP(){
            if (!isNature(document.all('form1:step').value)){
                alert("移动位数非法！");
                return false;
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
              move(document.all.showItem,0);
            }
        }
        function moveDown(){
            if (!isNature(document.all('form1:step').value)){
                alert("移动位数非法！");
                return false;
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

<x:saveState value="#{org_orgSortBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{org_orgSortBB.superId}"/>
    <h:inputHidden id="sortRefresh" value="#{org_orgSortBB.sortRefresh}"/>
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
                            OrgBO org = (OrgBO) list.get(i);
                            if (Constants.YES.equals(org.getOrgCancel())) {
                                continue;
                            }
                    %>
                    <option value="<%=org.getOrgId()%>"><%=org.getName()%></option>
                    <%
                        }
                    %>
                </select>

            </td>
            <td class="td_middle" align=right width="10%">
                <p>
                    <input type=button class=button01 style="width:70px" value='<%=LanguageSupport.getResource("JGGL-1026","移至顶部")%>' onclick="movetop(showItem)">
                </p>

                <p>
                    <input type=button class=button01 style="width:70px" value='<%=LanguageSupport.getResource("JGGL-1027","上移")%>' onclick="moveUP();">
                </p>

                <p>
                    <input name=save2 type=button class=button01 style="width:70px" value='<%=LanguageSupport.getResource("JGGL-1028","下移")%>'
                           onclick="moveDown();">
                </p>

                <p>
                    <input type=button class=button01 style="width:70px" value='<%=LanguageSupport.getResource("JGGL-1029","移至底部")%>' onclick="movebottom(showItem)">
                </p>
            </td>
        </tr>
        <br>
        <tr>
            <td class="td_top"  align="left">
              <f:verbatim>
              <%=LanguageSupport.getResource("JGGL-1030","每次移动位数:")%>
              </f:verbatim>
              <h:inputText id="step" value="" />
            </td>
            <td class="td_top"   align="right">
</c:verbatim>
              <h:commandButton value="保存"   styleClass="button01"    onclick="return forSave();"   action="#{org_orgSortBB.saveSort}"/>
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
            <td  colspan="2" align="center">
             <%=LanguageSupport.getResource("JGGL-1025","无下级机构！")%>  
            </td>
        </tr>
</c:verbatim>
        <%
            }
        %>
<c:verbatim>
    </table>
</c:verbatim>
</h:form>

<script type="text/javascript">
    if (document.all('form1:step')!=undefined && document.all('form1:step')!=null && document.all('form1:step').value==""){
        document.all('form1:step').value="1";
    }
    if(document.all.showItem!=null && document.all.showItem!=undefined && document.all.showItem.options!=null && document.all.showItem.options.length> 30){
         document.all.showItem.size=document.all.showItem.options.length;
    }

    var flag = "<%=flag%>";
    if (flag != "1") {
        if (document.all("form1:sortRefresh").value == "1") {
            parent.tree.location.href = "/pages/org/sort/OrgTree.jsp";
        }
    }
</script>
