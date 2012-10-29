<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doAdd(){
            if (document.all('form1:postID').value==""){
                alert("请选择岗位");
                return false;
            }
            document.all('form1:postName').value="";
            return true;
        }
    </script>

<x:saveState value="#{user_rolePostBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{user_rolePostBB.pageInit}"/>
    <h:inputHidden  id="roleid" value="#{user_rolePostBB.roleid}"/>
    <c:verbatim>
        <table width="98%" align="center" cellspacing="0" cellpadding="0">
        <tr><td height=10>
        </td></tr>

        <tr><td>
    </c:verbatim>
                <h:inputText readonly="true" id="postName"></h:inputText>
                <h:inputHidden id="postID" value="#{user_rolePostBB.postid}"></h:inputHidden>
                <h:commandButton styleClass="button_post" type="button" onclick="fPopUpPostDlg('form1:postID','form1:postName')"></h:commandButton>
                <h:commandButton value="增加" styleClass="button01" onclick="doAdd();" action="#{user_rolePostBB.addPost}"></h:commandButton>
    <c:verbatim>
       </td></tr>

        <tr><td height=10>
        </td></tr>
        
       <tr><td>
    </c:verbatim>
        <h:dataTable width="98%"  align="center" value="#{user_rolePostBB.postList}" var="list"   id="dateList"
                 headerClass="td_top" columnClasses="td_middle_left,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03"  >
            <h:column>
                <c:facet name="header"><h:outputText value="单位"/></c:facet>
                <h:outputText value="#{list.orgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="部门"/></c:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="删除" action="#{user_rolePostBB.delete}"   styleClass="button01" onclick="return confirm('确认删除？')">
                <x:updateActionListener property="#{user_rolePostBB.itemID}" value="#{list.itemId}"></x:updateActionListener>
            </h:commandButton>
        </h:column>
    </h:dataTable>
    <c:verbatim>
       </td></tr>
        </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>