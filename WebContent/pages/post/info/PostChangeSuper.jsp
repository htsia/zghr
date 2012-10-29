<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<script type="text/javascript">
    function doCheck() {
        if (document.all('form1:C001010').value==""){
            alert("请选择新机构!")
            return false;
        }
        return forsubmit(document.forms(0));
    }
</script>
<h:form id="form1">
    <h:inputHidden value="#{post_PostListBB.pageInit}"></h:inputHidden>
    <h:inputHidden value="#{post_PostListBB.postID}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
          <f:verbatim>
                   <%=LanguageSupport.getResource("GWGL-0200"," 岗位管理")%> ->
                   <%=LanguageSupport.getResource("GWGL-1000"," 变更岗位所属机构")%>  
          </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>

 <f:verbatim>
    <table width=95% align=center border=0 cellpadding=0 cellspacing=0 class=table03>
    <tr nowrap>
        <td class="td_form01" width=140> <%=LanguageSupport.getResource("JGGL-1078"," 岗位名称")%> </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" readonly="true" id="C001005" value="#{post_PostListBB.postName}" alt="岗位名称|0|s|50||"/>
<f:verbatim>
        </td>
   </tr>
    <tr nowrap>
        <td class="td_form01 td_form_required" width=140><%=LanguageSupport.getResource("GWGL-1001"," 新隶属机构")%>  </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="C001010" code="" dict="yes" dict_num="OU"   readonly="true"
                         value="#{post_PostListBB.changeId}"
                         alt="隶属机构|0|s|50||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="PopUpOrgDlgShowGroup('form1:C001010',1)">
        </td>
    </tr>

    <tr>
        <td colspan="2" align=right>
</f:verbatim>
            <h:commandButton value=" 保存 " onclick="return doCheck();" styleClass="button01"
                             action="#{post_PostListBB.changeSuper}"/>
            <h:commandButton id="selPost" type="button" value="取消" styleClass="button01" onclick="window.close();"/>
<f:verbatim>
        </td>
    </tr>

</table>
</f:verbatim>
</h:form>


