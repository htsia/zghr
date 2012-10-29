<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ include file="../../include/taglib.jsp" %>
<script language="javascript" src="/js/floater.js"></script>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = request.getParameter("superId");
%>


    <script type="text/javascript">
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

<x:saveState value="#{sys_AddressBookItemBB}"/>
<h:form id="form1">
   <h:inputHidden value="#{sys_AddressBookItemBB.initSort}"/>
    <%
        PersonBO[] list = (PersonBO[])request.getAttribute("sort_personlist");
    %>

    <c:verbatim>
        <table align=center width="95%" border="0" cellpadding="0" cellspacing="0" ></c:verbatim>
        <%
            if (list != null && list.length > 0) {
        %>
        <c:verbatim>
        <tr>
            <td class="td_middle" width="60%">
                <select name="showItem" size="25" multiple id="showItem" style="width:100%;">
       </c:verbatim>
                    <%
                        for (int i = 0; i < list.length; i++) {
                            PersonBO bo =  list[i];
                    %>
                     <c:verbatim><option value="<%=bo.getPersonId()%>"><%=bo.getName()%></option> </c:verbatim>
                    <%
                        }
                    %>
 <c:verbatim>
                </select>

            </td>
            <td class="td_middle" align=right width="40%">
                <div id="floater" style="position:absolute; width:60px; z-index:1; height: 30px; left: 200px;">
                <p>
                    <input type=button class=button01 value='<%=LanguageSupport.getResource("JGGL-1026"," 移至顶部 ") %>' onclick="movetop(showItem)">
                </p>
                <p>
                    <input type=button class=button01 value='<%=LanguageSupport.getResource("JGGL-1027"," 上移 ") %>' onclick="move(showItem,0)">
                </p>
                <p>
                    <input name=save2 type=button class=button01 value='<%=LanguageSupport.getResource("JGGL-1028","下移 ") %>' onclick="move(showItem,1)">
                </p>
                <p>
                    <input type=button class=button01 value='<%=LanguageSupport.getResource("JGGL-1029","移至底部 ") %>' onclick="movebottom(showItem)">
                </p>
 </c:verbatim>
                    <h:commandButton value="保存" styleClass="button01"
                                                                                onclick="return forSave()"
                                                                                action="#{sys_AddressBookItemBB.saveSort}"/>
 <c:verbatim>
                </div>
            </td>
        </tr>
        <br>
 </c:verbatim>
        <%
        } else {
        %>
 <c:verbatim>
        <tr>
            <td class="td_middle" colspan="2" align="center">
               <%=LanguageSupport.getResource("XTGL-1290"," 此名单下没有人 ！ ") %>  
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
    if( document.all.showItem!=null && document.all.showItem.options.length> 30){
        document.all.showItem.size=document.all.showItem.options.length;
    }
</script>
