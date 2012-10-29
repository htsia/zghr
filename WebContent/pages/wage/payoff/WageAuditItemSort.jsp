<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.wage.pojo.bo.WageAduitItemBO" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = request.getParameter("superId");
    if (superId == null || "".equals(superId)) {
        superId = (String) request.getAttribute("superId");
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
            for (i = 0; i < form1.showItem.options.length; i++) {
                form1.showItem.options[i].selected = true;
            }
            return true;
        }
    </script>

<x:saveState value="#{wage_aduitItemBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_aduitItemBB.pageInit}"/>
    <c:verbatim>
    <input type="hidden" name="superId" value="<%=superId%>"/>

    <table align=center width="95%" border="0" cellpadding="0" cellspacing="0" >
     </c:verbatim>
        <%
            WageAduitItemBO[] list = (WageAduitItemBO[]) request.getAttribute("sort_list");
            if (list != null && list.length > 0) {
        %>
    <c:verbatim>
        <tr>
            <td class="td_top"  align="left">
              <h:outputText value="每次移动位数:"></h:outputText>
              <h:inputText id="step" value="" />
            </td>

            <td class="td_top" width="90%"  align="right">
    </c:verbatim>
            <h:commandButton value="保存" styleClass="button01"  onclick="return forSave()"   action="#{wage_aduitItemBB.saveSort}"/></td>
    <c:verbatim>
        </tr>
        <tr>
            <td class="td_middle" width="90%">
                <select name="showItem" size="24" multiple id="showItem" style="width:100%;">
                    <%
                        for (int i = 0; i < list.length; i++) {
                            WageAduitItemBO bo =  list[i];
                    %>
                    <option value="<%=bo.getItemID()%>"><%=bo.getFieldName()%></option>
                    <%
                        }
                    %>
                </select>
            </td>
            <td class="td_middle" align=right width="10%">
                <p>
                    <input type=button class=button01 value='移至顶部' onclick="movetop(showItem)">
                </p>
                <p>
                    <input type=button class=button01 value='上移' onclick="moveUP()">
                </p>
                <p>
                    <input name=save2 type=button class=button01 value='下移' onclick="moveDown()">
                </p>
                <p>
                    <input type=button class=button01 value='移至底部' onclick="movebottom(showItem)">
                </p>
            </td>
        </tr>
        <br>
      </c:verbatim>
        <%
        } else {
        %>
        <c:verbatim>
        <tr>
            <br>
            <td class="td_middle" colspan="2" align="center">没有选择项目！</td>
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
    if( document.all.showItem!=null && document.all.showItem.options.length> 30){
        document.all.showItem.size=document.all.showItem.options.length;
    }
</script>
