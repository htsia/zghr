<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String showPost = CommonFuns.filterNull((String)request.getAttribute("showPost"));
    String showName = CommonFuns.filterNull((String)request.getAttribute("showName"));
%>

    <script type="text/javascript">
         function forDel() {
            if (checkMutilSelect(document.forms(0).chk)) {
                if (confirm('确认删除？删除后岗位将不能恢复！')) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择要删除处理的岗位");
                return false;
            }
        }
    </script>

<h:form id="form1">
    <h:inputHidden value="#{post_PostListBB.postList}"/>
<f:verbatim>
    <input type="hidden" name="sessionFlag" value="2">
    <table id=t1 height=98% width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_page" height=8>
</f:verbatim>
                <f:verbatim>
                   <%=LanguageSupport.getResource("JGGL-1077"," 岗位名称")%> :
                </f:verbatim>
                
                <h:inputText id="postName" value="#{post_PostListBB.postName}"
                                  size="10" styleClass="input"/>

                 <f:verbatim>
                   <%=LanguageSupport.getResource("JGGL-1004"," 主管机构")%> :
                </f:verbatim>
                <h:inputText id="superId" value="#{post_PostListBB.superId}"
                                  size="10" styleClass="input" code="" dict="yes" dict_num="OU"/>
                 <h:commandButton  onclick="javascript:PopUpOrgDlg('form1:superId',1)" styleClass="button_select" type="button"/>
                <h:commandButton value=" 查询 " onclick="javascript:return forsubmit(document.forms(0));" styleClass="button01"
                                 action="#{post_PostListBB.queryPost}"/>
                <h:commandButton value=" 删除 " onclick="javascript:return forDel()" styleClass="button01"
                                  action="#{post_PostListBB.delPost}"/>
<f:verbatim>
            </td>
        </tr>
    
        <tr><td>
                <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                    <jsp:param name="hasOperSign" value="true"/>
                    <jsp:param name="operSignType" value="checkbox"/>
                    <jsp:param name="hasEdit" value="true"/>
                    <jsp:param name="isEditList" value="false"/>
                    <jsp:param name="isCheckRight" value="true"/>
                    <jsp:param name="isForward" value="true"/>
                    <jsp:param name="isRow" value="false"/>
                    <jsp:param name="rowFuncName" value="forView"/>
                    <jsp:param name="isPage" value="true"/>
                </jsp:include>
        </td></tr>
    </table>

</f:verbatim>    
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
    var showpost = "<%=showPost%>";
    if(showpost != ""){
        alert(showpost);
    }
     var showname = "<%=showName%>";
    if(showname != ""){
        alert(showname);
    }
</script>
