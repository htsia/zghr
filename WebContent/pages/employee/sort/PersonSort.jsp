<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
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

<x:saveState value="#{emp_PersonSortBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_PersonSortBB.pageInit}"/>
    <%
        PersonBO[] list = (PersonBO[])request.getAttribute("sort_personlist");
    %>
<c:verbatim>
    <input type="hidden" name="superId" value="<%=superId%>"/>
</c:verbatim>
        <%
            if (list != null && list.length > 0) {
        %>
<c:verbatim>
       <table align=center width="95%" border="0" cellpadding="0" cellspacing="0" >
        <tr>
            <td class="td_top"  align="left">
</c:verbatim>
              <h:selectBooleanCheckbox value="#{emp_PersonSortBB.onlyShowInService}" onclick="submit();"></h:selectBooleanCheckbox>
              <h:outputText value="仅显示在职人员"></h:outputText>
              <h:outputText value="      "></h:outputText>
              <h:outputText value="每次移动位数:"></h:outputText>
              <h:inputText id="step" value="1" />
<c:verbatim>
            </td>

            <td class="td_top" width="90%"  align="right">
</c:verbatim>
            <h:commandButton value="保存" styleClass="button01"   onclick="return forSave()"   action="#{emp_PersonSortBB.saveSort}"/></td>
<c:verbatim>
        </tr>

        <tr>
            <td class="td_middle" width="90%">
                <select name="showItem" size="24" multiple id="showItem" style="width:100%;">
                    <%
                        for (int i = 0; i < list.length; i++) {
                            PersonBO bo =  list[i];
                    %>
                    <option value="<%=bo.getPersonId()%>"><%=bo.getName()%></option>
                    <%
                        }
                    %>
                </select>

            </td>
            <td class="td_middle" align=right width="10%">
                <p>
                    <input type=button class=button01 value='<%=LanguageSupport.getResource("JGGL-1026", "移至顶部")%>' onclick="movetop(showItem)">
                </p>
                <p>
                    <input type=button class=button01 value='<%=LanguageSupport.getResource("JGGL-1027", "上移")%>' onclick="moveUP()">
                </p>
                <p>
                    <input name=save2 type=button class=button01 value='<%=LanguageSupport.getResource("JGGL-1028", "下移")%>' onclick="moveDown()">
                </p>
                <p>
                    <input type=button class=button01 value='<%=LanguageSupport.getResource("JGGL-1029", "移至底部")%>' onclick="movebottom(showItem)">
                </p>
            </td>
        </tr>
       </table>
</c:verbatim>
        <%
        } else {
        %>
<c:verbatim>
        <br>
        <table align=center width="95%" border="0" cellpadding="0" cellspacing="0" >
        <tr>
               <td  colspan="2" align="center"><strong>
                   <%=LanguageSupport.getResource("JGGL-1075", "没有选择机构或此机构下没有人！")%>
                                               </strong></td>
        </tr>
       </table>
</c:verbatim>
        <%
            }
        %>
</h:form>
<script type="text/javascript">
    if( document.all.showItem!=null && document.all.showItem.options.length> 30){
        document.all.showItem.size=document.all.showItem.options.length;
    }
</script>
